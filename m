Return-Path: <linux-kselftest+bounces-38877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DBEB24E24
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7111AA014D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A74288C32;
	Wed, 13 Aug 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4xJMAlP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2A28853C;
	Wed, 13 Aug 2025 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099728; cv=none; b=tgH43VCBqtGQTwU61aGaoURl9W239i8JGbRn11o5TPFpRmXnXOayYFcw+5KhN7VZqIl67tDuS53lkNuzxqH1O56/TJxt2JHRLkn0eFLpQ3KxGyDn4L3CJmgY+dlqkhoLLP1GW0SszPF4nPf6jIePbkc+nlkvHMDGKnsM33d2hto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099728; c=relaxed/simple;
	bh=kg6DNzoNrYf0nrR1AgMnV/J34mmfXDSDe/reyUaD9+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPmXw/b0HItNB3nrFuXgEkqxmiqn1jPIak+QV6XkNahQTdW5ZaDO8lELxwp7fwXmV1exiMjcFDTAQCBZwg5c9b8iIwf1/LfGmSmVRBosnR9cZ2uSn5e/lFKjwMFwPWXz/MBzJ2bBFitCRQyPlCoX6o7fsPXd99+eTs2g0SY9Qm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4xJMAlP; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e811828b2fso837516685a.0;
        Wed, 13 Aug 2025 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099726; x=1755704526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeUhMEGs9wuRsft8g3SDqk5wc2QhmGlWOcjaI9cl8qw=;
        b=R4xJMAlPPXdvyB53pfkphaadMDVeOismRihvGzUsSyB2E8Qa0cxGPWDxNtJdA63oFN
         Y8sFhvHDnlNNf0K4CoFjYGJ4SUAn8ZamgYuat/HOPwQ4Vwu/1nGqKnBdqXWcXVEwdft/
         ZB9n6NCHmHyi3U0k2xOFhzuW4lyUfvc/RGdPSpGRV5crPaCR19ruQ251sRR173nBrCtG
         f8APttZ+HMfCxUDw8MU27iBRNVDSHYTx5bz0EdclvSJjQTgSXGYmnHrHcBExaPJxVshk
         iB2Yxp7NcT1sMiaAaKe2H6YN01AVzGDIGTLlcQzkTuzHHPL0LkxgWIqXi6ZAm9BM619z
         xI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099726; x=1755704526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeUhMEGs9wuRsft8g3SDqk5wc2QhmGlWOcjaI9cl8qw=;
        b=MlB9St/JA5LN16fOWtgFnyeILWHlOV0evZR2+bND5HSVRzVQQz8JzIrPT8Ke4m/7mf
         618Z4/IW/UUhWRdrKw3gGuYbMpxSVCbMH1rZ2CTQsAY/4GGFQ9SDNEOJueRe5IEr/LDY
         A98YIV/GaE/d9g7bycN2XFRnN4otd6VVd5Wp5giyk1xBKlqNqgUfKae320GADIoz0qDT
         phVq9rZeTCbdFGdVDOG0BnOOMnY3CrAhcsKIiyklnzsRgc8hFguFFaDPp7fyJhdlOQ3A
         w2qUBDMaixookomPl2YJXIRjthq+UgG8PLy45bZZfOI7mg1C4a6SyroNSEIm2GF+YOc3
         nv+w==
X-Forwarded-Encrypted: i=1; AJvYcCU1hAz3WjluSxkDvixsS73K92rjRirffVOTQUWAPN0Rmk4jJN+ytCXiv3njVHzKqUDOTRoHdGTwIshl@vger.kernel.org, AJvYcCU4LXjv2qKaRj2uYsFjRoDl8utJO0uDafPTYjXdXeXT8a0B+bMGGGcvDOvN2wLLzTzCgtjJpZfogVxqutDK@vger.kernel.org, AJvYcCUvUOVa7SBqYsjaBWyhMZdps4LPn3sq6lhp5WLrEBM2KT7YvhB5E8Z2wgiD+geKykXKTS/8ZGZQFH/E5K416qU=@vger.kernel.org, AJvYcCVl7mTnFlF1h/eYLpi96rSM/C7bdDChfpUQKbeIjqw0kC0DvpUwrN2SO2QiYluqU9mmpw4QIVbkv9Y=@vger.kernel.org, AJvYcCW8qjMHUclmd7VDEIozcmKrJYPRv2bLAKNWAYOmq+YoKZpXlJOVX2FkowaeltXfM/5rZBHE02aMbRr9dD9fnC55@vger.kernel.org, AJvYcCWUqMe+61F9D3ALpALmNJEU1+v3PjRnM60LaAf1SruWJ5gvWK/FjRheQR5YSdujvOLM9kb00RgMDD3N3g==@vger.kernel.org, AJvYcCWWeRCQjPhcJ6FiA+M0IG1V2oBeBjPShQTaNYV+pS+HjyvNbwwL1eRpwccfMgMfDJlF9xuFfV4f@vger.kernel.org
X-Gm-Message-State: AOJu0YxLcXEPHX1s13XYsvGhzdFQtf0hjvPsPwOSvVd0noBGRdk7be4x
	cPZ5+Q+cuIFkwgZPTIQMuN8R/xts0TSdP9Hwgnwv98brlxVNTSjZqfNa
X-Gm-Gg: ASbGnctpPps2GS0O/rLmzHp97swkUJJHqG3C0Nx4SfCmq/5o37XwIaqhnF2ua+HETja
	iyFW7Q0DTX1fLC+EDb2gnbvogslSCVlT9W9ycGGT8RjhJXTorZKvIE0jDsYKuMnQww5fXm9sunS
	4u+8avsG8PYng+G6305emHx+Lyu9gWYOA+vhfwga6APZQOPbADM6oWcNujGbtUQgnIvpJNEhwaH
	IQs8F2G8SvfDGpDFF1Iw/qiyMF1fnyrDIB11rZD0RcJVTK6GMpI0P9ruh8X6xMRixdiJtaaA5l2
	qFIjWewlfG9B0CirRhhwqDW2Ef2o+xIl1UDdln/jJc2CK7cg4CMtLcnez+GSCiG+6Cx4BCNGYaN
	VmCZAtAze3jeEEK965c698Z3mNp9WL+gdgiEZQegdl4YLahEIntZckRHVn5veJxvImRkRnV2JvQ
	1CeOLjxOoF4drQBlC7OcPmla+ZLKawAYATHZmLRQskDJt0
X-Google-Smtp-Source: AGHT+IG1mIF6487HtOxJkAPPuPzh2mMUjp+Xc46MEr7/bKJq4m3Tp1y7THXr+TXxripZV2FXg2KGdA==
X-Received: by 2002:a05:620a:a008:b0:7e8:6fa1:338e with SMTP id af79cd13be357-7e86fa1347fmr16087185a.30.1755099725938;
        Wed, 13 Aug 2025 08:42:05 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81bc7a1e3sm1180019685a.74.2025.08.13.08.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:42:05 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:41:54 -0400
Subject: [PATCH v3 03/11] rust: configfs: use `core::ffi::CStr` method
 names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-3-545c14bc44ff@gmail.com>
References: <20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com>
In-Reply-To: <20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099715; l=2429;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=kg6DNzoNrYf0nrR1AgMnV/J34mmfXDSDe/reyUaD9+0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLQbWrxVox3vhWtRI0GbehTSVJ4dOxqZCxMx5W5R2TVPGaDV2mg94i8oRtKtBHDHKVzZj0gCPJ1
 hi57xW1V/LQI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Also avoid `Deref<Target=BStr> for CStr` as that impl doesn't exist on
`core::ffi::CStr`.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/configfs.rs       | 4 ++--
 samples/rust/rust_configfs.rs | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 2736b798cdc6..9fb5ef825e41 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -263,7 +263,7 @@ pub fn new(
         try_pin_init!(Self {
             group <- pin_init::init_zeroed().chain(|v: &mut Opaque<bindings::config_group>| {
                 let place = v.get();
-                let name = name.as_bytes_with_nul().as_ptr();
+                let name = name.to_bytes_with_nul().as_ptr();
                 // SAFETY: It is safe to initialize a group once it has been zeroed.
                 unsafe {
                     bindings::config_group_init_type_name(place, name.cast(), item_type.as_ptr())
@@ -613,7 +613,7 @@ impl<const ID: u64, O, Data> Attribute<ID, O, Data>
     pub const fn new(name: &'static CStr) -> Self {
         Self {
             attribute: Opaque::new(bindings::configfs_attribute {
-                ca_name: name.as_char_ptr(),
+                ca_name: crate::str::as_char_ptr_in_const_context(name),
                 ca_owner: core::ptr::null_mut(),
                 ca_mode: 0o660,
                 show: Some(Self::show),
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
index af04bfa35cb2..5005453f874d 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -94,7 +94,7 @@ impl configfs::AttributeOperations<0> for Configuration {
 
     fn show(container: &Configuration, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
         pr_info!("Show message\n");
-        let data = container.message;
+        let data = container.message.to_bytes();
         page[0..data.len()].copy_from_slice(data);
         Ok(data.len())
     }

-- 
2.50.1


