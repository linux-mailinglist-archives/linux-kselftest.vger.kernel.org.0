Return-Path: <linux-kselftest+bounces-17961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9942978AA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 23:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A03E1C22E6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 21:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC7017838B;
	Fri, 13 Sep 2024 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="RyV3k2wF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022113.outbound.protection.outlook.com [52.101.96.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337BC17623A;
	Fri, 13 Sep 2024 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263215; cv=fail; b=iahyMK7Zo22i1difjeWTdJBnic9U9p3NwtmDqHJIpeCpB2TXvj5Jtu7YXkqGCMVjUzGPRzgj5NqgoRcxb3rvCVBf/z3HoNxp0r97U8Bx5I4r/YAIGhQb4rmA0x9ezUYajE4lfyLoGRisV3t4/VCVFe0Om3sXgRTC08+3Pn9UoHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263215; c=relaxed/simple;
	bh=jRja1tg0WQbBh8Ke468nb6Tcj/huW0D0Wp37eQd4+R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=amqsyzLsM3sexkQJwrK1xkieoJmdKthdQR6+htH/yJDI0cHDRrG2O+IZaeHjsbjSAFxrvmG2ST7btLFy8LKyMpEzmenndqDbUtQZ/mz75KsU+S7A+8DtHFtSyPMSCGqbDC6bzE4v/dMGPbStW6VOQb7sMbnwy99M+Qb7iexcFeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=RyV3k2wF; arc=fail smtp.client-ip=52.101.96.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOJJUVD56sZ5QKF+3DmNWg0zoi/DK569+HWeGDOd52PrbTx3bNR0gOrZHPl3PXrK5jfSHUp0A81E+NcTIA6lA5eX6MSmv3VdZQqEWm8UslF4CgXFAYSU65TJlB0wZEm4mmNZA7vO6Av2fxn1yK//icBbge8m1bLvLURR3y/WmTK6Ps1EwU3fXDQnALZTySDNZGJD75b3KV6pRnffrSp5tBG2PKRBy5AaLnNcKse9vWgIOugSrhf0bNKkkg6sHDuUK4FJItYmkNBut7Em4eRxdDFL87krxUecb5VY2b3R12v6ovdQ8lzJp7b+2yUlwntkfPz+MHd8qNVI7zLOkNYbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+OH1U9UEu0Hwq936OTNYAZRT7ekSwZvaqmh4X/uJd0=;
 b=lsKBU8SZm3gZjOBo4oY0ETyucEgeEw/WBfAUQTs8dQZCUIIpXO6q4lDOjmEoDIkPqVzn7rDmoMh3IaLH9L0kVVM26d9UYTFer8zRSbeoujnVuaqqU+9OvN/dWaPlZ67CN/CDMPh1QEOvXrhE7HwJuAMYULf/cpM5mUH6AFSKAJEM5w7TuDHqQVMXFM+Ulf/S1HCtfrGi2m8exobIgIExuhm33YW1V/6I2PueWycx1SyJh0AnGvZa+PfUowmiKZassND1JWyaPY6w3YUpqK1vVymfrD8e1pLfvKWvFCvkqUXzli1c4akOtoVj7ZezxYrjl35uGQuWud7tzlOdWUHhzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+OH1U9UEu0Hwq936OTNYAZRT7ekSwZvaqmh4X/uJd0=;
 b=RyV3k2wFNrmmfgqfihnDvhrqlwt3mEkJpdi97zufgh6n7MBZqmoGkt4q0cTNKEJn6edp3iWhLWOUr9AawUdNRnB68aLwIZkCkhLugqgXFWvW+xRreYmusQ8VT3FhVmMwK8GSPrbXdQxacE3EJcexl793bvK20qbg9zTqjlai9zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB3594.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 21:33:30 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 21:33:30 +0000
From: Gary Guo <gary@garyguo.net>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Michael Vetter <jubalh@iodoru.org>,
	Finn Behrens <me@kloenk.dev>,
	Valentin Obst <kernel@valentinobst.de>,
	Danilo Krummrich <dakr@redhat.com>,
	Yutaro Ohno <yutaro.ono.418@gmail.com>
Cc: Wedson Almeida Filho <walmeida@microsoft.com>,
	Asahi Lina <lina@asahilina.net>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] rust: cleanup unnecessary casts
Date: Fri, 13 Sep 2024 22:29:25 +0100
Message-ID: <20240913213041.395655-6-gary@garyguo.net>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240913213041.395655-1-gary@garyguo.net>
References: <20240913213041.395655-1-gary@garyguo.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0136.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::28) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB3594:EE_
X-MS-Office365-Filtering-Correlation-Id: 87375238-b07c-4ab0-f61c-08dcd43bb648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/dMeFbXzBtgTm2ey7t9Oi9Vmjoi9Abm7bHyxcEX4639KEoNaA5PwuUi+1hI/?=
 =?us-ascii?Q?iq9Ywv/zwD3ZKf5fSTiUEnvGj07TMemRRdsd4bDQ/Uf8WY+yRZjglLNygzPl?=
 =?us-ascii?Q?ww8PQGiP3ciMBVSViaHDHk+VpJTKBeVnxEoE8Dxjnqavt8GVtes7xSiiFcIz?=
 =?us-ascii?Q?Vv++nX3lfBVPhk6BLq+mZytlI7LxDiib2IIck9QZUyPKSW+e5RpFuQKtPGJh?=
 =?us-ascii?Q?SDdJGEHsvAFHPjOYbUSb0kzIa3rA00iXclQ5fJAj5/QTgQVJwRTbnNajB0ah?=
 =?us-ascii?Q?KYCrmTrih5yVtCf+XIS/n2C6NUHlMDCIhvEWWAmdy/qOHV5V7eZe15PwixCO?=
 =?us-ascii?Q?qVINpLy70CVBNiYLv4dqJYBMnplWOmrUsTzb9r3C8RoaRnMUBpsCK9021r1l?=
 =?us-ascii?Q?VaX5PjaE/ESck3JjHeyXbe0TpxKTrifNys6W95412ZXuK/ulsuRP/yYy5sBR?=
 =?us-ascii?Q?kQUlvKDleCjYk36sS4/yn+5QTY7lq0cRmv7IpPpvTj+UDRGTk5CFyyxbC5Os?=
 =?us-ascii?Q?2T61ClxCTHRbXf2ufVepRBWo3l9vx8NmR93PIZ65RMTyejN48do60XLsFFre?=
 =?us-ascii?Q?YHCldPsMkIeXkvmMHAmPlZz+t2LkOsAyj9LdMbCaGjXykquYtUNM6XeInZ3g?=
 =?us-ascii?Q?pWdiP0QqBvAVWTllbIoaYfMX45dBFSidfTsoPxzSp3oiPek6/Vh7HvPxatLh?=
 =?us-ascii?Q?4JFX9p7meqXtiVPHjrNf2ZivjAfW8g3E3FN+iMkBsyuLG1eN+PPID5BzH5hM?=
 =?us-ascii?Q?DmtXMJSzm4KWTuURZ+VJ4aUrDGzEZ0hTNF3NczVsO/MUqVJI1aEtHNeerZzu?=
 =?us-ascii?Q?5pCyYI/FItsZdZew/kFjsP/GoexZ3W4jA7wcZ2kaN/p2nNjJlJqKZS1svddC?=
 =?us-ascii?Q?5lIN4Rld4+oa52GKVkCiiNlocI4aiHHeSbcF88WdHhu/TxIbPoE7otYMwW4D?=
 =?us-ascii?Q?AFfHQTECyvIi80JyiCU0lIcKxc3+Iqs1f0ElDx3q5OLWnhoMtUnUUk8htKS9?=
 =?us-ascii?Q?mZLztDkGZaM0OgqPwmP+KE20sFLKLrciYVOOaF6wFMSFY5iws3sJbnbn6gk9?=
 =?us-ascii?Q?ik98OlhALoeMMJZJEEsqANTFrtQBINtYs5RYoCk8uIgk5zJXrQiuBHvWXJUh?=
 =?us-ascii?Q?7cRmX+yiVKzSA8UE/9S2O0SMuxj/QU19brSQq3QMRLYbEok1o2O7hvxACE7u?=
 =?us-ascii?Q?JXUjBeXyV3v632Ibje2qYbHdf7TFJ4QKGPHuZ/5pZ9Vk3Rj3PW0n7oIkh3yD?=
 =?us-ascii?Q?C/o27lfSni+POfAO8DtYTdVFS4Q+ngvEWKWHsBMjXNPXO3/JCjesVIKODotM?=
 =?us-ascii?Q?8KLD1BTH/BmuUi13aSF9+piz2WpzUL6Jklqz8NGsks6dDpj1fyL7iAafOkaB?=
 =?us-ascii?Q?BBhiOhf9SIr2e9bJtoqWZy+MXpPK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dGGiYl5zcZYNW97sOspUKoxmVMQWV3wQlEN7F86Or6x8ihvpyHW9Sxs79Qr2?=
 =?us-ascii?Q?iyoh9hVzzfu+/d9NkyaDnJ6wNGYou+ssDax9SaTrMcOLnEMqlczeVX1JZjaT?=
 =?us-ascii?Q?9vBpdYcQNteVJ+zOTr9BdO8QVoQ5LD/TbpUpTMJNeGwCw4RNia2BQ60JTqO7?=
 =?us-ascii?Q?3bo1p1HIUdismD8Tw7h4MQyguLiWiYW3OkC7zxZeQeMJMK/IXKFMyR4CGzMy?=
 =?us-ascii?Q?ERoYB8obtKkIZtlpqe9dKmGqIAolHSkZr3wRTqfKxLuK4Gweu+0yxspsD83h?=
 =?us-ascii?Q?rmH/BX3j8cOTGE6fld/O24b/FX/9ChE9lA/Vs2AST1UPrc40HInl4suTN97q?=
 =?us-ascii?Q?1gChlx7I99Vp8GOB3g06ChOnTm6fPZN2VVyFJY+zi3lvZU91OtXSvH/nowNp?=
 =?us-ascii?Q?aG8C4azRKqx4FE06pNYJIhDuraJmNW7E6h1/w4JgmOsP0s8lMxROMjNxC+lF?=
 =?us-ascii?Q?IW+dIj6FYN0JIdQRDMVIvvu6AWcNE2wWsWTQK8xAe0EHIPcFfGGijdBMKy/Z?=
 =?us-ascii?Q?n5w4Eswa/q2kgZSrCkQHFvaunv669gvCpTUXwapyB+S7oQwJ+xQCM+J8mxLU?=
 =?us-ascii?Q?MC9q6Uh4jn3aepJygaT3f2KL2UpculEUx2RRZLgzzVBUca1J9rsLr6zPrtHg?=
 =?us-ascii?Q?jWGUSOAIq6v5nm6ylZGCw8s9J2GSHHLFaVCv2e7P4dF+OqtEBoy1hHbFiq62?=
 =?us-ascii?Q?GbNISEOWzfIPtvWv8C0XqzVtScOCJW1iwbbB3kv011BRO1CjwZUYwjSabX8t?=
 =?us-ascii?Q?ONRnUgq4zvYS3dXL7WgJJljan8DMTCLHQb2c6Etz5bOLPBZFmqJrb0Qj1K13?=
 =?us-ascii?Q?5Hh16U3X9aYpBKOZszegaPKfcTVWX0FqtaJYeiPQSjHwZBvZpsN4Cg7R3nbV?=
 =?us-ascii?Q?ljP3Cvgv6naBW50utAY2BAlvpaDFP9xzkaCd0O40O4zn3nZblm6oo0FxxH1L?=
 =?us-ascii?Q?L89PwQZNzysV9vv3d85HWOMLZ4uX+9/R65vfBX++8td9VWav5ibegUx3PzUT?=
 =?us-ascii?Q?BaiQAg38Luit6aOwCCk+JTR35MKOv4S8nyvRC740k6N6A6aPMzDn+xjgN8Ta?=
 =?us-ascii?Q?9glxl1fXhtxk+gEAnP7mgXupxWq1Wux2MxiSo2XvcEdI8lxM+8UWSZepJXX6?=
 =?us-ascii?Q?hu5L+D7y/07ibyDlIzFlMZyHGQQcb+rrkFaPJgLa+P3EtuvZtNHlOW5qi5OH?=
 =?us-ascii?Q?J23HZXZoABnhVA4ekf4iNZHuaSjd+x9GkYEbRoII7Vl0pI7dxGqElJsAb76q?=
 =?us-ascii?Q?gZ/7OvTHSOg5P/2MqIQLdsoOCMVi9SC2rr90LY6O8O2cZx1u42E/bx8bx7a2?=
 =?us-ascii?Q?/uOQYkRG9jbguDe02H3mB1j5RLH4LQGw861W6TGY6KIoI/OEyWcF+F49Sfwy?=
 =?us-ascii?Q?qT01bgA7xLnul+e3TUX4yp3K5C0FcAe12hLmxsG/S+gVAMonJ6n7p/PoqF0/?=
 =?us-ascii?Q?FGfz/QAlb3VF9KmtafBM5Z0MnLeUvWM084gOqS/uazIS+sUVsqqAcY2lek4W?=
 =?us-ascii?Q?QAg8uBFqNAxLxSk1kvO4JoNKU1OmKcBYVq6eQKQAcOpaXwLKRxbbPok2KNUm?=
 =?us-ascii?Q?zG/irynmF/7s9yV1j1L85TYIUXsGje/DHqfidU2Vohlxc0FkQubTkoJ2xAGj?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 87375238-b07c-4ab0-f61c-08dcd43bb648
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 21:33:30.7449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaY37UXZv6RIOoymrZC121d39xcDBTtO2IgFE+T3un8GdOeyCQIT7HUcqd34A/mSuXVS205bFofws/h+uGVWPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3594

With `long` mapped to `isize`, `size_t`/`__kernel_size_t` mapped to
usize and `char` mapped to `u8`, many of the existing casts are no
longer necessary.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/kunit.rs   | 10 ++--------
 rust/kernel/print.rs   |  4 ++--
 rust/kernel/str.rs     |  6 +++---
 rust/kernel/uaccess.rs | 27 +++++++--------------------
 4 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 0ba77276ae7ef..766aeb1c6aea8 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -17,10 +17,7 @@ pub fn err(args: fmt::Arguments<'_>) {
     // are passing.
     #[cfg(CONFIG_PRINTK)]
     unsafe {
-        bindings::_printk(
-            b"\x013%pA\0".as_ptr() as _,
-            &args as *const _ as *const c_void,
-        );
+        bindings::_printk(b"\x013%pA\0".as_ptr(), &args as *const _ as *const c_void);
     }
 }
 
@@ -33,10 +30,7 @@ pub fn info(args: fmt::Arguments<'_>) {
     // are passing.
     #[cfg(CONFIG_PRINTK)]
     unsafe {
-        bindings::_printk(
-            b"\x016%pA\0".as_ptr() as _,
-            &args as *const _ as *const c_void,
-        );
+        bindings::_printk(b"\x016%pA\0".as_ptr(), &args as *const _ as *const c_void);
     }
 }
 
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index 508b0221256c9..90ae4f2568910 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -104,7 +104,7 @@ pub unsafe fn call_printk(
     #[cfg(CONFIG_PRINTK)]
     unsafe {
         bindings::_printk(
-            format_string.as_ptr() as _,
+            format_string.as_ptr(),
             module_name.as_ptr(),
             &args as *const _ as *const c_void,
         );
@@ -125,7 +125,7 @@ pub fn call_printk_cont(args: fmt::Arguments<'_>) {
     #[cfg(CONFIG_PRINTK)]
     unsafe {
         bindings::_printk(
-            format_strings::CONT.as_ptr() as _,
+            format_strings::CONT.as_ptr(),
             &args as *const _ as *const c_void,
         );
     }
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 3980d37bd4b29..2d30bca079e37 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -190,7 +190,7 @@ pub unsafe fn from_char_ptr<'a>(ptr: *const crate::ffi::c_char) -> &'a Self {
         // to a `NUL`-terminated C string.
         let len = unsafe { bindings::strlen(ptr) } + 1;
         // SAFETY: Lifetime guaranteed by the safety precondition.
-        let bytes = unsafe { core::slice::from_raw_parts(ptr as _, len as _) };
+        let bytes = unsafe { core::slice::from_raw_parts(ptr as _, len) };
         // SAFETY: As `len` is returned by `strlen`, `bytes` does not contain interior `NUL`.
         // As we have added 1 to `len`, the last byte is known to be `NUL`.
         unsafe { Self::from_bytes_with_nul_unchecked(bytes) }
@@ -249,7 +249,7 @@ pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
     /// Returns a C pointer to the string.
     #[inline]
     pub const fn as_char_ptr(&self) -> *const crate::ffi::c_char {
-        self.0.as_ptr() as _
+        self.0.as_ptr()
     }
 
     /// Convert the string to a byte slice without the trailing `NUL` byte.
@@ -817,7 +817,7 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         // SAFETY: The buffer is valid for read because `f.bytes_written()` is bounded by `size`
         // (which the minimum buffer size) and is non-zero (we wrote at least the `NUL` terminator)
         // so `f.bytes_written() - 1` doesn't underflow.
-        let ptr = unsafe { bindings::memchr(buf.as_ptr().cast(), 0, (f.bytes_written() - 1) as _) };
+        let ptr = unsafe { bindings::memchr(buf.as_ptr().cast(), 0, f.bytes_written() - 1) };
         if !ptr.is_null() {
             return Err(EINVAL);
         }
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index c746a1f1bb5ad..eb72fbcf152a1 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -8,7 +8,7 @@
     alloc::Flags,
     bindings,
     error::Result,
-    ffi::{c_ulong, c_void},
+    ffi::c_void,
     prelude::*,
     types::{AsBytes, FromBytes},
 };
@@ -227,13 +227,9 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
         if len > self.length {
             return Err(EFAULT);
         }
-        let Ok(len_ulong) = c_ulong::try_from(len) else {
-            return Err(EFAULT);
-        };
-        // SAFETY: `out_ptr` points into a mutable slice of length `len_ulong`, so we may write
+        // SAFETY: `out_ptr` points into a mutable slice of length `len`, so we may write
         // that many bytes to it.
-        let res =
-            unsafe { bindings::copy_from_user(out_ptr, self.ptr as *const c_void, len_ulong) };
+        let res = unsafe { bindings::copy_from_user(out_ptr, self.ptr as *const c_void, len) };
         if res != 0 {
             return Err(EFAULT);
         }
@@ -262,9 +258,6 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T> {
         if len > self.length {
             return Err(EFAULT);
         }
-        let Ok(len_ulong) = c_ulong::try_from(len) else {
-            return Err(EFAULT);
-        };
         let mut out: MaybeUninit<T> = MaybeUninit::uninit();
         // SAFETY: The local variable `out` is valid for writing `size_of::<T>()` bytes.
         //
@@ -275,7 +268,7 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T> {
             bindings::_copy_from_user(
                 out.as_mut_ptr().cast::<c_void>(),
                 self.ptr as *const c_void,
-                len_ulong,
+                len,
             )
         };
         if res != 0 {
@@ -338,12 +331,9 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
         if len > self.length {
             return Err(EFAULT);
         }
-        let Ok(len_ulong) = c_ulong::try_from(len) else {
-            return Err(EFAULT);
-        };
-        // SAFETY: `data_ptr` points into an immutable slice of length `len_ulong`, so we may read
+        // SAFETY: `data_ptr` points into an immutable slice of length `len`, so we may read
         // that many bytes from it.
-        let res = unsafe { bindings::copy_to_user(self.ptr as *mut c_void, data_ptr, len_ulong) };
+        let res = unsafe { bindings::copy_to_user(self.ptr as *mut c_void, data_ptr, len) };
         if res != 0 {
             return Err(EFAULT);
         }
@@ -362,9 +352,6 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
         if len > self.length {
             return Err(EFAULT);
         }
-        let Ok(len_ulong) = c_ulong::try_from(len) else {
-            return Err(EFAULT);
-        };
         // SAFETY: The reference points to a value of type `T`, so it is valid for reading
         // `size_of::<T>()` bytes.
         //
@@ -375,7 +362,7 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
             bindings::_copy_to_user(
                 self.ptr as *mut c_void,
                 (value as *const T).cast::<c_void>(),
-                len_ulong,
+                len,
             )
         };
         if res != 0 {
-- 
2.44.1


