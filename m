Return-Path: <linux-kselftest+bounces-29039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F07EA6112E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFFF162BBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 12:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B3F200105;
	Fri, 14 Mar 2025 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK5r6K2U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA821FF610;
	Fri, 14 Mar 2025 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955306; cv=none; b=igznSrS27JOhswyXld8ry7eTOGowXv6nRtjZu0mZ+Pmgfqv/WnXJW7S327cq1WMYG59d0VBHWf7vgy3iTTO7qdKmeBf71YAm4UEhxV3PxUrUuXzaOwTCKFHuoJNnAKDyT68bwFeVycwdp+OOeaJp7xZwCT/tq2IK45Dn7gXPCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955306; c=relaxed/simple;
	bh=eOC8GNYrVfiMmJjIlMnjsi5R6euOkfd+217Ym/0TGMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAqSdrf34aL3xA7ROVIHpAm6XBAArJ7HUC2cx9RIoVNB28mohnQc9mD4igXUW8v0JHdp98ypZ8ahwfbM/jS7EwU6DPsswpIqvYm3aHK4p3oeLn4Gxg19aag2JVQnJxnAh0ttU4ILT/1gCWq1mvSDlntJzXfykkp9VFhQqqr69qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EK5r6K2U; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476a1acf61eso15929391cf.1;
        Fri, 14 Mar 2025 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741955304; x=1742560104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DKJLM7Z9Stu40Q/kKnTtPbAzpv2yQ1EFXVOPNeWeiM=;
        b=EK5r6K2UjGJwZY/ynmwe8B51/BoB+OaBE+db7yIclMm5VXJU2e8dR3BLEyVM0wx6tw
         bqwemZJU84KYD2wanLlqdEn/zd7E52mxQnCX1rghifGZhaxEp8kTowa5bpCBcPpjMD58
         VgEjBkFYFJvKqhWHHVgPGmwzbtu9IxEdlMGtaEjR5vyUZ3f1TnujiXp6d9tyuIYuMisZ
         9tKzo272deoiE2SacqfZeiClXEl/+UfDf4Xhu8VJr0qW3I4eGXV23+0MJ+XXpV1+GPG2
         d8d90XrhFlO+VQwQ1WVqKqjcY4kH4bclP5fxbwhz0wgTXMlH0xkaZIOj0BHakwgMQD9a
         v7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955304; x=1742560104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DKJLM7Z9Stu40Q/kKnTtPbAzpv2yQ1EFXVOPNeWeiM=;
        b=Wc/xpkIgxHjKeWPOhK7UCtI1zhZvn7gEIBQpDAAo/4qMHqE1SYWH8LQs0N3Z3mSlb2
         zkSsaITTSTHfKzPJFYol4HhubhAQfJMXRm5MYktQNXFrWfmwLXVsajcYLcPBDsWsn5zN
         Cp4Pz5cs9ECrFCOxeYbc9Kg7MCvjegQ7vWxWcMrVjZLaFJz5yLG2GRiSl5ZtCW9jsY5v
         dm5SjUtukGTAKVPY81W1KYYaQwSyzVFuGn5umzgEJqpXW084wbQDxndzuBRxDX6GhJ6i
         2YbRhdnkx/QW/DNeRVnTNI2zaxAql+mGZQPsitkG97TaQv/9dktKaUhWHH5rm7a+fNYg
         GhbA==
X-Forwarded-Encrypted: i=1; AJvYcCUTT84z4LqQWOhDfEPT6EI0gm/k0aHJSs/e31OIVhR2gz/ePqLsnqvWPxRvIWDV8/WJLa7j00xDxGWN@vger.kernel.org, AJvYcCUyYPkskaiG+QY9NGqVaJm20krSqJWjg5s8y0VOwzP03aAIFDT09SsSMJ2UexQVawmap/+FistKIM/g2Ng=@vger.kernel.org, AJvYcCVBB17ulRh2YoLkdi9Q9D8xU7leN0ZnZ7D2YIqgjQmBjh2V7ELKW7k2JI6hq3WFGcPvZJam14teNX/yaRgM@vger.kernel.org, AJvYcCWEsCwQvH0vxmcO4wsUnwR8HYegRcwELboI1IHQtkk9qxBf54d60WJ8yxhFWkaI9Zqdn++4xSEz7iNsMmSYZoo=@vger.kernel.org, AJvYcCXHHb6LrilEerucf5OhaU0XrXG8H9KCqbBCwtC3Rzn4IGzHEujTl3z8BK1QSv1L+/tMkk0zmhbZbECMaqWCrRZu@vger.kernel.org, AJvYcCXnAgGHmUvgzQCxhdyJ+s7PzTsVhTLyNuWHoP5wcllsdBl7ygQK/6atJz8khlOc0Com7gqv6Ns1BGuQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiy7KjvSe1KAuRB2JCtfRDYTM39/c0/JZWNb9azvAxc9ksHXTS
	V8EcifXYXyeWqJr/XQuaFtuBwOfc3HL8xydA1R7ozcELw+16JbsF
X-Gm-Gg: ASbGnctFeakuwke7EYatPA83YDjaxg2IRfSkxGLNaN4NH33DtG+pnqp/m0NlMhomsQ6
	HTmop/nDNAfGEHBpLSlS4R0V+5MDfcea6urW+8pXheFoggs72+UEXdX+tQkme/vi+hUUofsUnHH
	dOVfBOWnnD4rGSgCLuCsuW6zswkmFgBlXa8hzCeQw3+bGwQ5U4U9vBG87sB9Fbh0ONNzb6j5rKh
	Gx+RBSIvOb4J+rDG/oJuycLBPcMIV8Uy+i6W9Fh79cmYf8lweEIu6xJnzEejonhDo19pnC/IVqd
	Ge50Cg552iJmZj5rVHbsva0c/hC68p4FmTaWXStC18auPwVa04eKt71javntAsoQ5isA
X-Google-Smtp-Source: AGHT+IFLZwVqog4UYIXJ3/matlo/LAPeAX0PTBzGdmOshrjju6wsM8OswEs+8XFq1HVEXuw+WxItNw==
X-Received: by 2002:a05:622a:1350:b0:476:78a8:4347 with SMTP id d75a77b69052e-476c81c7c21mr35738181cf.33.1741955303701;
        Fri, 14 Mar 2025 05:28:23 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:cd19:6a0f:e1a6:e800])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb63f3a4sm21905821cf.30.2025.03.14.05.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:28:23 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Mar 2025 08:28:08 -0400
Subject: [PATCH v3 4/6] rust: enable `clippy::as_ptr_cast_mut` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250314-ptr-as-ptr-v3-4-e7ba61048f4a@gmail.com>
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
In-Reply-To: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

In Rust 1.66.0, Clippy introduced the `as_ptr_cast_mut` lint [1]:

> Since `as_ptr` takes a `&self`, the pointer won’t have write
> permissions unless interior mutability is used, making it unlikely
> that having it as a mutable pointer is correct.

There is only one affected callsite, and the change amounts to replacing
`as _` with `.cast_mut().cast()`. This doesn't change the semantics, but
is more descriptive of what's going on.

Apply this change and enable the lint -- no functional change intended.

Link: https://rust-lang.github.io/rust-clippy/master/index.html#as_ptr_cast_mut [1]
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile              | 1 +
 rust/kernel/devres.rs | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c62bae2b107b..bb15b86182a3 100644
--- a/Makefile
+++ b/Makefile
@@ -477,6 +477,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wrust_2018_idioms \
 			    -Wunreachable_pub \
 			    -Wclippy::all \
+			    -Wclippy::as_ptr_cast_mut \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
 			    -Wclippy::needless_bitwise_bool \
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 3a9d998ec371..598001157293 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -143,7 +143,7 @@ fn remove_action(this: &Arc<Self>) {
             bindings::devm_remove_action_nowarn(
                 this.dev.as_raw(),
                 Some(this.callback),
-                this.as_ptr() as _,
+                this.as_ptr().cast_mut().cast(),
             )
         };
 

-- 
2.48.1


