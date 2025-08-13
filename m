Return-Path: <linux-kselftest+bounces-38883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0FAB24E4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13211C24C30
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5AE29ACED;
	Wed, 13 Aug 2025 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mghUu9Uk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C32299A81;
	Wed, 13 Aug 2025 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099743; cv=none; b=orjei0ottqel+rXDch+ZZzrInblPQcSgnNmD7eoFUoxQRAe4pJRTgTiJXbZy1MDGiCs++BA0QwtlS9YtzZVDFEqI7vnhiK6gwD/Ffe0GzAWj3maTPEkuUvPOkyBaFURGnPoVIXvB19UdAnNqUx9S0dt4xf92DaSBmzfP4TUYM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099743; c=relaxed/simple;
	bh=jSSTP0CMYqLQgK+GyMVsel3zf/VtDwNHVf3qOND1uDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MunZXZaApEuOrHWfk2UBlgOzIJeKWIfcc/HblyRfqH4NgFErTeCHnQaseWObioipTX6RJmy+aCgOE/G1HmScz9fEiABWqNUYYG6ai0m8pNQXXVx7gb0PHY2lThmPgB2BNreVQWkU7KczuRNzWN6+pfDbT3vIZmZhdJdUqu7NrAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mghUu9Uk; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e864c4615aso115043485a.1;
        Wed, 13 Aug 2025 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099740; x=1755704540; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcmbdRLiVO4cc/yBM3bWVRyme/nNaKfenk9T8xs0Ffk=;
        b=mghUu9UkbrgdO+MoviOBTeXtWT9IX6LSWL2z9FRxigCJAqd02X7TblEh4BGupV2ztx
         SGVO7EJv0AIp2GmOb1pF05vzhoZW3KAnojzPGsKSYpgze8VVrG6aOv5jDRbYvOvb9hJq
         7h2XQxgf+yYEkJ2rFllmq5g3midFpIEfluiSJeJ+kuulB1cCtrcT+tZXJQbDasXs6WgZ
         HGz4GJ0RSIn/iSmR28qmBoLuVaja6/60VKbF2Jy6d9oWAIQKWAy5Z9SfVaf68tBFAt0p
         FXlSVIq4Mio+96k+fy7izBUxZSmHwve/WGDS1M0Ofoue5nOC3uVyZtsoD5ZE3AAvZHNM
         g5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099740; x=1755704540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcmbdRLiVO4cc/yBM3bWVRyme/nNaKfenk9T8xs0Ffk=;
        b=a+EYBWye487OqZqYuFvY0rDaAUHfHiNwajQyGailR//Y0k99AGZ7eTtc57A6FjCDl6
         5Moeud1ILw1RwfgvaXbqMAyWkFvm0BO3gs/oMXvYt8OdEvqWKBF5NF26sEk37uWvhwRs
         m929ByedjJlBOZOHy2dM+gMx/An66gktzPxnxX9g1I2f1hvWXwVgtNh/DXdnj9b5i7OJ
         +xrDy6JjYL0JKZ5+Wp12+rS5RfVoNtGIfrXJtXZL5sd2l793U8M8tZhOe+vT7Bo4DIFQ
         azsJa8Uw7PTeHrXpUhVOhNuDg1dTjD636/g6mvgTUOtMK8Fd0oWz07c1hUhpPJuBGlbS
         w3pg==
X-Forwarded-Encrypted: i=1; AJvYcCUYJxXcBg5xY9RKmMofbxgfEMFmbapWK3FfB8+LahoOFijMT1NnbGv5kGzLysJqiWIi/EhwLHUg95/HvNTQ/toS@vger.kernel.org, AJvYcCUzWbIJG+YN6pes4cm+Mv9n5VYQ0posLb+mmHGzg+EGe+7a//49cdufTq5wZ7M/VTC0u+GyxKW7@vger.kernel.org, AJvYcCVSBacGT/MOk+hVMhqMlTBD/muMtOYqSmwbQa3+yJOc3MYYJy8Xcy6HbFR4BnF6H7JKRtwTXOl8q1YkEYMY@vger.kernel.org, AJvYcCVpMkj1szZ1mz2Un7+e+CLjH2CRS51Jloekekn/S8k/YLjMTJl/Ot4c3ay7wsIC6Mpx0c6iMkAnjoD3@vger.kernel.org, AJvYcCVtH3QSb3zt6nS5k9ZZzqAwxD4Od+IM3LEd2GH/wz379o0uFf+eIWFWUXQDfgkMpaEd5aX+rernJsc=@vger.kernel.org, AJvYcCWvUuSAzip5EcesdQ7gT+qtrJL45pfXE3uf5joWJYkkCK+/54WMNtLbPngtho/miD/7s+hIhc5CsHZgiEV1nJY=@vger.kernel.org, AJvYcCXzbgeNM9tflFenjTKPJQyP13/FsAnYmHqVNh0IosEj3mVNApxpyroWYoCuUO7zN37ucVwUMl0U1RVyjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmxA12OP3BfW/Z3toxVh/yyF/j6jUNdFaFKt2Rz11n8ReT7jMz
	UzhKN5v0cqQUZgajtBuY/egZhFS+bCrddhSgsQu+58yaJ1nQZ5kCyoYo
X-Gm-Gg: ASbGncvHq9YeM62LIxq3pIwtjyed0KD4+oQBXWyDFA83bP1eikWq75QRs4hdUjHxdmI
	xBeRzv4qZCkAZsKg/iuhTUtR4U+AwvkVXmjUA/2gqEAkzw8Yq1OD6IGxWEs9SEQ0SonW2bdOS5I
	kflj3ncPfUF4kwJLhFiHUnxasa8FpoSE7C9MA/CsEQBT690E1+XRmTjKtb3a/XGP13eQDVagq/d
	FX2PG+7NpD6+jpYshNpjbwDVPzmIqEkqsghYEYb4ld1XXeph5tK8b/VQ3ICV9AQZRd1mUJRNtxd
	x6gQbfx6mTWWO5l0bgmfxxAoiHkt25xgkHv7KjPitjxsI2iSaSa6oHf3ei8ZcJi3CgPjxl37fBN
	InXRSOz2bJxaz9cRp7tB+qGrUmr1R0nRg6G8/p7KW/Mqfre3qORjpRA88759pjSLgX0EDK2IxfL
	MS+WGfqATEoT94629y+E3zRfBh2wk+qPIYjutOMvZfqlyX
X-Google-Smtp-Source: AGHT+IGfyPN9tuqYm8U4vQO9QvX0XCFm/DgPPcPcTW3fssXclM27AttUHXU9384uEAdC1FKNPCVA9w==
X-Received: by 2002:a05:620a:4309:b0:7e0:e2d7:e03 with SMTP id af79cd13be357-7e86fbc0bd8mr8171785a.7.1755099740351;
        Wed, 13 Aug 2025 08:42:20 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81bc7a1e3sm1180019685a.74.2025.08.13.08.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:42:19 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:42:00 -0400
Subject: [PATCH v3 09/11] rust: net: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-9-545c14bc44ff@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099716; l=1163;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=jSSTP0CMYqLQgK+GyMVsel3zf/VtDwNHVf3qOND1uDk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLE8mI7AVGtx+HAorNNktKwEeNw87jP2Dm/x8WxEn8G0HU4C1+7sSGz2uvHfqc6z1xiQtkNCaCN
 XP4LWQ43yBQI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/net/phy.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 7de5cc7a0eee..be1027b7961b 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -497,7 +497,7 @@ unsafe impl Sync for DriverVTable {}
 pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
     // INVARIANT: All the fields of `struct phy_driver` are initialized properly.
     DriverVTable(Opaque::new(bindings::phy_driver {
-        name: T::NAME.as_char_ptr().cast_mut(),
+        name: crate::str::as_char_ptr_in_const_context(T::NAME).cast_mut(),
         flags: T::FLAGS,
         phy_id: T::PHY_DEVICE_ID.id(),
         phy_id_mask: T::PHY_DEVICE_ID.mask_as_int(),

-- 
2.50.1


