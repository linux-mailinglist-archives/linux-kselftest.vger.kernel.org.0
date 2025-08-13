Return-Path: <linux-kselftest+bounces-38880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1014B24E37
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFFD721828
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14B528F937;
	Wed, 13 Aug 2025 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSZ+gKzG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D2928C87F;
	Wed, 13 Aug 2025 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099736; cv=none; b=f5KY+9P54/opwwPJwVAr16pj9fS/jz4fDJz2xaErcPYAMbGwcojWDa6EZPNd3/ecZaRt/q+W27Ws58gla25aOCmB5n+6pz3eMxjbHJQvyt485bgwpVjtukT1LT3xPN4aJs5/mBOrTetI6NGty/6F3iH+n4LNFa7oAS+Ysh1idxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099736; c=relaxed/simple;
	bh=yC7ocmh0FxZ1j6QxD66YMq6ma2bl8MjdYDc752aDD2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjUxT2ZeEfMJJ7dkmIjPcd9w16ewGPTFqZIu2/nMvrJWYtGoTB2pYwriu8OrdQHcqt9o2cxwLRBy58qW+S7ULo5hm6BTFLwn1tMigzrg9MPwM0R3NzxKXIuydqSW04HSsthWUEZNxTXuePI5eKNAycoR10uOsM63w4zxphxRQcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSZ+gKzG; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e83d6633f2so418550985a.1;
        Wed, 13 Aug 2025 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099733; x=1755704533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3bSBo4SS/FgSpl21RHA4IaNFoFjWvFemtvDkPW++F8=;
        b=HSZ+gKzGbWxkW8y76dmZZgdrA81rJY6dd92AEeRL9nmXBcauRaACQzXTX1koMpe03i
         e0pCiaROJlo8d0Uxf5kj3uCBPCb6t6tyGDCyOaYYu2xJdWLfng594tZw8LbrIXjBwAVP
         ZlYQ/cxfUK7n3xM63SBvcnwwR4SE2qTFcCeMvHut21rJusQP7BUQ3IVSwmdBUSWgeF7p
         gtKhnuuzXyJjgpYx78PSAKorbwazAfRW30ZxA1fpzvHfJSDxv1A5R3Kx09dLfv+npUmV
         p10AdC0vbvmuunYgLHxmGPn8VdQ6jHeVCFgvc2TQGzNcpfSQV0wiwPHJ43wDxhk30dwF
         ZdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099733; x=1755704533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3bSBo4SS/FgSpl21RHA4IaNFoFjWvFemtvDkPW++F8=;
        b=q0Nb1FrKHMpX5dl5prG4YtvLDbfaZ6qnaLrY+nwLDBcEO0GdJEgaW+qbGdaz7xAVUK
         3J+YgQP4zufg94kcy9DtS2XCvSozotSD39ye4TFEP2/zAfDYFLaiGOljD0CW6Lp70ikV
         pqpAgbSlOjUiZflkIArCKSobgbW4Bxj6C+XAsEf4rH/czl/NrLfE6LVwl0JrfH/LH2m9
         XI45ALi/rQKciVYha3/FEPjk1xCsMVK6lwqkM+dndZ3yCTyrK9yBlLwsHsEsdXnxVFcM
         Xa6XCWIAuGK2VFD+W8SDaWmvpmLuZPpiBh6Z0pVKR5V/B87/1TE1vn638iq1lSC8QrXB
         jX4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUq7IDuzF7InZb7KyCT7UzLLtvRo/pQ5AWZcOnxWz9wyXnmNEXvOdtrUSpLsHlYPA2qTfZiNB09@vger.kernel.org, AJvYcCUwYVFnMurBw99gY65HVOK9TpTVpBZOE22NOUpUBi89sTP1fIaZGqpzkaeFdKXceg9ZW+mqUW7twHx+Nw==@vger.kernel.org, AJvYcCV/WVaib4bSn8qniAwNwSWBMUfdzN/iEeoDxfEAfd3CKVNI+LCd5aGq0M77+V3S4oV3Aw42NgLmIKhAliCHIG0=@vger.kernel.org, AJvYcCVay8zUsoO9RwJn6x+gDyeqFU/qdTJtqfKsoL++fDeJ/Q/lbN9R+rR45k8eaf5b7xqO+87MRqVqazU=@vger.kernel.org, AJvYcCWqmK5m8iBF1AKgN6AHtvbH2xQrRYXxHQTR1r6/R9D+olgny+uTzxz4Y98QcJNOGjYMTrgFoF3SYDMa@vger.kernel.org, AJvYcCXOr53VoEwf8huaBmEkl0cZO5TvsM5poYvUvXhZpSQa+hk0j6iCqesS3PJgAjN0+kXe65R6QLHTjaHIstqo@vger.kernel.org, AJvYcCXfth8p/t7zDZBVcB27Y7rJDYTp30B0bhbwxFOB9Xgb4gAf8gaWGQQG4VkEsO6/2TZ2mmpzHWCiMGhlFAa+NHkY@vger.kernel.org
X-Gm-Message-State: AOJu0YxGdmTIy8jJu4q4N/biFKLWVzlffJmC4OzWpv8J/zoiYPBr4MvO
	IRu25OZ3ccNdh+Q4Sl83uemDwqmWLNVLk/IeCn7FZcVfgMwMfd0dDKJg
X-Gm-Gg: ASbGnctFL8WpKNZOwHM8TFeDctVWz8MKktih2B/7sPZF4glnE89+NqbBTEbgVIVdaIg
	xKL/z2zsr4cvwzhiHYhRBbcc9h9Cl9tEjTybOFPkKQ54HXnhdGPnax3srM6TKsqNMhsnBX1npCF
	GxbhamAjuSW9qGbXTDf66bJaUznZoAM03r3iMDNrzQkNjc8UB/TjopmP6XooRD2PxI+Cg37T3fc
	c621Bq0TDyXeGWpX3JfE4bM5d5YBReJ7VkzHYxk9TEJMftVuIKlX2KttWbLumgBmDN/SNyLH5hd
	wGZVcmjLow2s4VxQ4OL+OsjNVnCamHiT3w7noVUXt5D/IcCa9hf5cWngx3+2sMGTnncABiIyB/m
	uy+pl5Fj0KHwsrt3dQtXh4eE+jQ7lEn9epS/qe7b93O2fP44qkYkfwxh4WgzvMn0YVOVKTcr/7Q
	Lg1BHpBxqOt3bghu2d4/xotfpBdquSMt5ky3+IylpoG9b6
X-Google-Smtp-Source: AGHT+IE8kOnAeo+GXXSMqsc4caiIGvbQQSTgwoOCP36Gq0RBHmk5vnkOhXDcBjjhHMfsGrLWbnpK6g==
X-Received: by 2002:a05:620a:a506:b0:7e8:4337:9975 with SMTP id af79cd13be357-7e865320571mr448557585a.33.1755099733022;
        Wed, 13 Aug 2025 08:42:13 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81bc7a1e3sm1180019685a.74.2025.08.13.08.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:42:12 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:41:57 -0400
Subject: [PATCH v3 06/11] rust: firmware: use `core::ffi::CStr` method
 names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-6-545c14bc44ff@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099715; l=1139;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=yC7ocmh0FxZ1j6QxD66YMq6ma2bl8MjdYDc752aDD2c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPkwf/qzhiyFdFxI2/LV7vaTM5qqBUs0a8B4sP0rLb4odWWjZvsYE/y2xskn3LUJBjsfaaCSwqW
 Uk0Xaykxhjg0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/firmware.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 1abab5b2f052..94e6bb88b903 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -291,7 +291,7 @@ const fn push_module_name(self) -> Self {
         let module_name = this.module_name;
 
         if !this.module_name.is_empty() {
-            this = this.push_internal(module_name.as_bytes_with_nul());
+            this = this.push_internal(module_name.to_bytes_with_nul());
 
             if N != 0 {
                 // Re-use the space taken by the NULL terminator and swap it with the '.' separator.

-- 
2.50.1


