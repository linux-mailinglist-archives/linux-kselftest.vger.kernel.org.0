Return-Path: <linux-kselftest+bounces-36859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9D1AFF240
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05B45A7ABF
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CFA257AF0;
	Wed,  9 Jul 2025 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmxLYy1p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5422824888C;
	Wed,  9 Jul 2025 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091144; cv=none; b=tn/NeEIGDfEuMy76kQhdi7GoITv5MwNEnb5FErl+rsGTpKWHCskANh4r/bwUu1jNA7Oq0FIwU80S/r/GcdXJgiX3psrDIyGj5aGLAfnh+UbwCUW8duV+6cR2s7aIhUdAPHCG9dA3X+jXy4h8WpKCVzpfSw7JGBJGojoHIjYrr+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091144; c=relaxed/simple;
	bh=h6tC3zN7Md0UOz4MMT6cfetqyNoedejjhSvA80iqjoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XE1+VSY8L5lj6sqLnsSzhsYoj0ptnd9deAh4gNEkehzDPdPLuV1iWvu29CgIhCcfE4XMyZeyvWcCE5bgDdwNwP8S8+qpdszBb1kcahtSOLLja5FN/CdDdztI2J/Z1MgpiT7mI6Qvxi6DrTSySPKLyYVSR8kAmsl6WkC4jCLpFJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmxLYy1p; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a58f79d6e9so3774931cf.2;
        Wed, 09 Jul 2025 12:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091141; x=1752695941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxv+cX53M0fWuTxa/rfWTueJP/9Z3ooTwaDANDLIWY4=;
        b=UmxLYy1pL5QWeQKfV4vniWdTSR+55hc1JgVAuja4atuDfisWQ576qcoogBvilrivTY
         SLsKiBhULwKnE9e4BR4zXb7GlEa3KEn2MyPHa6bSxPTiG/jtySU5BW9IZ0+xtndSaxUJ
         8KNLet0anmbC9k9pRTIStkTpOcDZxT2iESw5Lz5kbotsNUakl88tHMlXMs9ZkxWJfyHu
         /Zg140sLn7lNvKtYu0nLJEOWZVHsiI/R+ia1MMvrF4nKDKnCzU/OtVCmle3dbYAQf5+w
         4hAtrmNNBeGfK1VkudeOEHZTF/8HVqoGSErx/CyK9sppK9Z2BTZI3CS4ExZ00DLZcu4x
         PaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091141; x=1752695941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxv+cX53M0fWuTxa/rfWTueJP/9Z3ooTwaDANDLIWY4=;
        b=ppjja8XJH8cLlq1s84igXTgWFAl18YcagxTMb5gnIIOVKdqMZYCdRo7CgOlGt/2KMq
         Kv3clqRsep+OBMgRXAuA9IYRygqOe1P9EGSfVAFv3disGyFfB9fxj5AiaPtMtawFFAnS
         huK3B+BTuLRs9648dtjPlHPhCEsXsY9l2hRv3eZoxGB6EOcZcs8LsclqcZnWyoNe5u/f
         Hr/VQ/7OP4Nhvit6ZSZLgISwjJCJUnbJ9EjAnbPJMrhUHeY67w7oKM+qnMZX3t732tdB
         iYdF29Asi0q1KTGJXN83yD8oWHL26lkPxF+Ls6JnvBivC9bDdqiEw5ufkdsrABJygWYF
         KHmA==
X-Forwarded-Encrypted: i=1; AJvYcCUbJh0a20hKPeiE/bPAlhUCDiUtYAnA+DMc5ao2C5UEki+vjjPWTjqYFpx0lo4ywKfYyAm0PRmwlQ3WuQ4i@vger.kernel.org, AJvYcCVULfbmuCHo3aPWbupw0xpyIXnBt3YkQK3QyPGh67liUM5lFl3aHfCNF5g1yAcRahOboKTxjXjWr4v8@vger.kernel.org, AJvYcCVqKLEqPcWjhcNeDaKioGAcPG/+Nc8oYoQ/BddZlh56E4miHLoiZgfqdNC5DLkykaG/x9fBhRbeubDCUj2vt5o=@vger.kernel.org, AJvYcCWoryiebKBwCu9HKOqEbeEzjrwUsbKucfkPycLHYvb9kJhty6XZjTUKKe9reUhsDN8+8gRpv4ZN9bgqaTysnbhl@vger.kernel.org, AJvYcCXgLIi+ejm2LfLQ+DpgIahnmGTW8czxkyOEtIY93u1qeQItnYtkkONuuS5qkJAtoBvsyOsDsqqV@vger.kernel.org, AJvYcCXlon+oICdzTSEefDK9fWTaHVPTLAYZAolQSa2K7skYAeIZNjTzrfrRrIVw2ABbOBienTlh+cqJjUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3T9FIDdzlAn3FdXKZr+p4pDGjwyBHT3IEBqWRjQbsbut+hW6H
	MNJ7BGmLkzhzc7zd4tWydJWiZmnAbWl7hOB2PlGCqcfLvKSIYBKIYaUs
X-Gm-Gg: ASbGncuiC2/P00A7NtA6yVJmt34VAGNKvS5+WLDaH50JCEUx268fQdLOZwpv8HGAjS3
	tGc6gHk2owCYDH4eXFQ/hqXQN7u+ty2l4O21HRKoXLjmJ3u2DBOWuhP5mgHQ1tU4cxfqQByzp49
	OJ7vLx23WwYndj8Ne1K3Y0qbefjSiJKk47TqdFYSn+dwGRJbafmgiR7handJkTansAwgYCIXmnj
	EqDeSVRt46CNxC64dZw4f5pAVwZyXQp7+tQ3u269xf5O+UM5eqyFujSYAzsxs3eaH4kEavAj4au
	jsD5eVQID4fUZLqP3zx2ArFwIIY0PFQ+kvYK8Dn9ytFsdu2R5CCaFeW918YKKVJV0DxuOqA30dZ
	2APQD+wogfUo+E9KKO2CGw1vFkMdDNmy7xaTEk7cTQqLuVhnlsRTRXJ1VEA==
X-Google-Smtp-Source: AGHT+IEvOmLNAfKMwFeccve+TnvGa29pxtqNeoCaz5gGAr5K0zm9M7P7N+Kqf/C+pZuFyW3BMiWUnA==
X-Received: by 2002:a05:622a:7284:b0:494:abde:2aa3 with SMTP id d75a77b69052e-4a9e95c9735mr10316081cf.18.1752091141111;
        Wed, 09 Jul 2025 12:59:01 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949faf39sm103584281cf.28.2025.07.09.12.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:59:00 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:58:53 -0400
Subject: [PATCH 03/10] rust: configfs: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-3-fd793b3e58a2@gmail.com>
References: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>
In-Reply-To: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>
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
 Saravana Kannan <saravanak@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091133; l=2325;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=h6tC3zN7Md0UOz4MMT6cfetqyNoedejjhSvA80iqjoE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEsOr/WBA7+xGvjY2sHkb67mB9WU5bZUW+aM5k/YuUpfoMwVaCu8hZMIuajFrdeqXMfc3qHNLaw
 XIaLNkI+MTgY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Also avoid `Deref<Target=BStr> for CStr` as that impl doesn't exist on
`core::ffi::CStr`.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/configfs.rs       | 4 ++--
 samples/rust/rust_configfs.rs | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index aafef70b7177..d4797c41ba77 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -263,7 +263,7 @@ pub fn new(
         try_pin_init!(Self {
             group <- pin_init::zeroed().chain(|v: &mut Opaque<bindings::config_group>| {
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
2.50.0


