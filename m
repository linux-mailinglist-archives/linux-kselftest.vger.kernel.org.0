Return-Path: <linux-kselftest+bounces-37670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066E0B0B298
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D1117F858
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B18128E594;
	Sat, 19 Jul 2025 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDE7kosJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7891128DEF8;
	Sat, 19 Jul 2025 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964977; cv=none; b=QOA7iqAbYsemmyFkofgEm3q7sJYZBW4ZyBCbS8J6K+L15EQ/3wEs4a6dwTh3029QV19gNrAl2kzbOtCoybX2/Hrc+4Y7xBDR+7Y6ifGnNQ5bdh1U8bGx99g6S7hsKH9eibb8phpWHRqFf+n6bQxXZwMWXFpvupHCX4seEpNYlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964977; c=relaxed/simple;
	bh=lZfqelYwV8zIrJ8mC1Q2efKvp9yb5zIZ8TIX1qUdauE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h+I6MRM4P/6CrQI1ZcJH1yRfEqqT4VosPXHSWUnCw9yAqXoMTTePmK7VHKIOSj9Bg5GRRSg4omkmFNi7f9fS48IRX5nLE1XWoBX6FCfXUbozGpuwSFdMX3j15wQ5VvVn66HC6PXfOjuG6XxBkzjX4OD+dPchDkBvTGYc6au2Fbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDE7kosJ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4abac5b1f28so26401911cf.0;
        Sat, 19 Jul 2025 15:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964973; x=1753569773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNvCZ3pjMtqtkb7kluvKanA1YBUxX9SYGV79cPChZl4=;
        b=iDE7kosJoNXl6hpkITXJMPUItow4UN3XAud8QqithLH68QaQhIjCO9GdE2jmqzMQRR
         LCPKFrZYnxxqet6rwCoxUP29mnexJxagtlER+1tcVdWQ9tORyp+A4O+opQfoK1aIVx8+
         j5O3VgSgx4Y/vblPJ7xMnkpv62c37ghVZM8262R/hUAOUTP7knwjRcVQaF1KeAGJ+lUU
         4kAoZS7U/u98rSHz43W3+GtuWZErqr06j6UNbFxZuXBl4h5lBndcEkF73QirYqSANLpd
         thaXGQU3I+4orgWQPbbs1l19WyclFMMdAHgmjTT5OnZwLDuqq38d+BfrraMx6A7iGMI6
         k5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964973; x=1753569773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNvCZ3pjMtqtkb7kluvKanA1YBUxX9SYGV79cPChZl4=;
        b=JkBbMlTd4qfvi1acrlcf1u15RvQ5G7m+DYnY4QPoggO2CYMFtamX9EJh25gVWJIi03
         COokCbEU4iWlWjk7bHhB0l/lIgJlmEQaLdl4cdnN90km4XvyVoS6Pp3bKVNrEvUMfNhF
         osIk6cbgfKPiVLwdwdIbFcgogr/tH/4GYp6R5SRuCGytEULjZ6npYtnQWzJ/VtIWSz2Z
         3whLJg2LsWrKfJ6nNoR+6Z6gr9EVg8VNmLe9QZ0K4QFeiUlClKFLHumBzQlSqYU7FbzE
         aOo12UrFlM4G6yvqcq279aNvLHwNUskV2js4RELMP8sSI1Uhb/rKPiX6rusouje3vir5
         H9EA==
X-Forwarded-Encrypted: i=1; AJvYcCUZh0QfYS2iMgjM9tGxoUWGXnImwq/4gFHXVP7t3hROWzoZXQzkULtG83Q57cORzi/fLqKS1FoR@vger.kernel.org, AJvYcCV/YKbl2n4Q9NCMKqLRUuqEzCSBIGxJiSsr4QB70lXNtjSz+efQNM8G4ah/OSnpsmXJ4lIorOPXHxU=@vger.kernel.org, AJvYcCVBEKPE3lEGveRddqzDZZ08Tk6aK67MO+S4BfLrwpjfETXtd3vBaNpDTh9Tp6ByKvhCf9a1NQcawvVI1hX7J3so@vger.kernel.org, AJvYcCVCHWr5CTE/SwaW5r+9GFoE2C30adKTY4Te6/6qUWKT+MKejcdfy4iN+n/R8B2jh6/ZYjbTY5THQDND35Sj@vger.kernel.org, AJvYcCW0IxQAli7oYZ3FcGVNCybMLXf+eW+jVzFdeXMDFp6a/XaCUfBdiNoCgfWUVUr6djUBoDQYQ4EEda1v@vger.kernel.org, AJvYcCXAw4yARgr7MYgftq1ZWTP8R+AD19QI+Afp3pyQtFuAfIKmP3PtHAzjJ+ylKrtK+p1wRnZZxmTOw4IbIyD1qQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKZFTf47eKbjebWO/yxp7tOGzTqZQpgH6PPp+nUe0vn5ER4GGl
	J1Jwer9p46AHKRB+ivLItNlxlwtMftRChQ+Wv7TWzx82CL170XaD1kw4
X-Gm-Gg: ASbGncvvLaoLYpt43LAUp48qlpAONvqjIN6mQOHboEni3Y1DVRfTvyNIrBkPcatDv9a
	lDNvTxAVyOiSCDHGujWOcZVSZqoZRzHOF8OUxDhCAKuHWc+CeTrVAkB1ZVmokOvNIsNVoNp61Vx
	WE/8xl22U+kVppAVEQ47numNDyOiaf0l/pEmYAke5TztsGyYYWuoV460derIU+thikakNxpNh4X
	sxv8Rep3HFRtHkguFZXXdaGi4448AKZD6Rm4ATpYAf/H8Ozl7AT+rbOTIfIFAaD09U4s6GbW2Ag
	8KKkLVgqGneZDKIg7hEgzWIwJ20F0+EVNICqXccxx0HjSJiE6Hh2d7eQ4BGvP9HOqrdWQO8LBkp
	8V2NHrwaPoI0XMR/qh5ff6GcctV4Lh6ptG2Be8GrbihI902nK76FOd0Zhufu9JEt73KkcknHIDz
	3r+2HuIdAaBey2YHI0MoLHIwAtX2WI
X-Google-Smtp-Source: AGHT+IGuVgalovnA+HCQB1axFBvdtzKf0ypyaad2YVYZ3IyuazjlnfCCWqKMExbkm60aghoSvVdt5w==
X-Received: by 2002:ac8:7d51:0:b0:4ab:377c:b6be with SMTP id d75a77b69052e-4aba3cca75emr161850101cf.22.1752964973336;
        Sat, 19 Jul 2025 15:42:53 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b1f1d5sm23671841cf.50.2025.07.19.15.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:52 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:42:37 -0400
Subject: [PATCH v2 08/10] rust: miscdevice: use `core::ffi::CStr` method
 names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-8-e1cb53f6d233@gmail.com>
References: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
In-Reply-To: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964955; l=1231;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=lZfqelYwV8zIrJ8mC1Q2efKvp9yb5zIZ8TIX1qUdauE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNgVoP5fUEeNshHPuiSNpSaABih144IwAS+Gk+Fr79lMmJelh+Zmxg2GxFCxv0BmRtW8iB/JzKp
 oMNvetu19nwo=
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
 rust/kernel/miscdevice.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index ad51ffc549b8..585cfbcb8a2f 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -35,7 +35,7 @@ pub const fn into_raw<T: MiscDevice>(self) -> bindings::miscdevice {
         // SAFETY: All zeros is valid for this C type.
         let mut result: bindings::miscdevice = unsafe { MaybeUninit::zeroed().assume_init() };
         result.minor = bindings::MISC_DYNAMIC_MINOR as ffi::c_int;
-        result.name = self.name.as_char_ptr();
+        result.name = crate::str::as_char_ptr_in_const_context(self.name);
         result.fops = MiscdeviceVTable::<T>::build();
         result
     }

-- 
2.50.1


