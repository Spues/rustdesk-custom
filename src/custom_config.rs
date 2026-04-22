// 自定义服务器配置
// 此文件硬编码服务器地址和公钥

pub const CUSTOM_RENDEZVOUS_SERVER: &str = "makerural.cn:21116";
pub const CUSTOM_RS_PUB_KEY: &str = "W9MJUb9NuDXzPOJDKLOfgT7fJgQhvW6nYUAeVsABlJk=";
pub const CUSTOM_RELAY_SERVER: &str = "makerural.cn:21117";

// 用于覆盖默认配置
#[macro_export]
macro_rules! get_custom_server {
    () => {
        crate::custom_config::CUSTOM_RENDEZVOUS_SERVER
    };
}

#[macro_export]
macro_rules! get_custom_pubkey {
    () => {
        crate::custom_config::CUSTOM_RS_PUB_KEY
    };
}
