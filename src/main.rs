use arboard::Clipboard;
use clap::{Parser, Subcommand, command};

#[derive(Parser)]
#[command(name = "bincli")]
#[command(version = "1.0.1")]
#[command(override_usage = "bincli <COMMAND> [OPTIONS]")]
#[command(about = "Translate text ↔ binary from the command line", long_about = None)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    #[command(about = "Encode text into binary.")]
    Encode {
        text: String,

        #[arg(short, long, help = "Copy the result to the clipboard")]
        copy: bool,
    },
    #[command(about = "Decode text from binary.")]
    Decode {
        binary: String,

        #[arg(short, long, help = "Copy the result to the clipboard")]
        copy: bool,
    },
}

fn copy_to_clipboard(content: &str) {
    let mut clipboard = Clipboard::new().expect("Failed to access clipboard");
    clipboard
        .set_text(content.to_string())
        .expect("Failed to copy text");
}

fn text_to_binary(text: &str) -> String {
    text.chars()
        .map(|c| format!("{:08b}", c as u8))
        .collect::<Vec<String>>()
        .join(" ")
}

fn binary_to_text(binary: &str) -> Result<String, String> {
    binary
        .split_whitespace()
        .map(|b| {
            u8::from_str_radix(b, 2)
                .map_err(|_| format!("Invalid binary: {}", b))
                .map(|byte| byte as char)
        })
        .collect()
}

fn main() {
    let cli = Cli::parse();

    match &cli.command {
        Commands::Encode { text, copy } => {
            let binary = &text_to_binary(text);
            println!("{}", binary);
            if *copy {
                copy_to_clipboard(&binary);
                println!("Copied to clipboard!");
            }
        }
        Commands::Decode { binary, copy } => match binary_to_text(binary) {
            Ok(text) => {
                println!("{}", text);
                if *copy {
                    copy_to_clipboard(&text);
                    println!("Copied to clipboard!");
                }
            }
            Err(e) => println!("Error: {}", e),
        },
    }
}
