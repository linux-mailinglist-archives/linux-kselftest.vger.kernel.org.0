Return-Path: <linux-kselftest+bounces-31133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73989A939D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 17:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483931B67201
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 15:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D782E217651;
	Fri, 18 Apr 2025 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCtOs54O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C422153D8;
	Fri, 18 Apr 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990653; cv=none; b=oq8qwPY5x3fvjlHEcaFPg84YMP6VCa8QvpKdlmPJNRSYItJpXiKLujdLK6BAkDFhZbZiQ0eC/iTsF3YI4+cXhUfAzlANjSqovBJWF4xXPQZrwavubZzA1MesOT2cMYVs4fYKOcDsUpAewbdbazqKo4+KMHRY18fE0sSZ0h96v5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990653; c=relaxed/simple;
	bh=L66clSs10cmdggfkE7GrJ7F7Bs0RHiLfZJMrV+sNjZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WCN38S8Zcd0BKSui41z/uSUvdNjQiGUqulVy7zhifxjchlQ3ebZmZ45JZR5J9DDgd7bKyGGPB9Nh8HhB7xUjor0WsEPpWSZ693PAZGdrYm3xnwNDQNCKprmi6HxhL9RRLa+v7xBKx4T9JP7e1bEeJiXWI72XZBu0jSzGKQmjrFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCtOs54O; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so27865676d6.2;
        Fri, 18 Apr 2025 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744990650; x=1745595450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sq/SHuUzGkWXlE0xMieSzf1X7J6mgZyFeTghfCxeR6I=;
        b=hCtOs54OGPOSjGEugfH9Pxpl7JwdpnJWEUyBLjcj7KEsBUTUjWt0+bw1Swdnt9BuVy
         TTxmIugrdufLhrY/EkWR1wewjoZ6rwmmNwILhf+XbG3pr9XyT1bfmMegh03MM2Nl6KB0
         0YKkduLTIGPDG+/txBh5y33Do4bvIydE5HUty8JWhFri25PmECqjFaDpE9hZttC5p4dh
         Td4UWs3+fD8K7VC0EdSlejCG1dUcQSFqHYBc+ET0ONmi3qpb77yPiEqV8Bv6ujx+HvCC
         g4Q3DlWHBFt5Uea0YnW9r1HgL6ecs8kGxT+mvlxL3VYTZQ+tHiCa7b7DvZ/dWrPXb3Hu
         NqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744990650; x=1745595450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sq/SHuUzGkWXlE0xMieSzf1X7J6mgZyFeTghfCxeR6I=;
        b=tErCFUxC31m7lo7p6TSWG8+Lnfe0GEtx+0wrcuut8toDy0579E1CCMRmlcAfme/VYC
         xA1NHJ0QODwDh1C6JsPn6m0PgZakAoZxjd/9myzXjkyTgNw4oDrfbGvc68E6CKBU4+uU
         0ZTQPosd1gLN/IEncs0eJu6RUZosoiLXAiYgO5IjUBVtpjBBaG+Ul3ajBcjwR+EwSFLV
         KAAnVnGmFPBiMhS91lp5d7vyDDpIJdrlvKm6eCst5wa4EtQoVSN/PHEBfuNDojuPVpqv
         trtxvKapjUpIgigHg540u1nv1rDR0TblCp7ByZuMShP9NbUU1B14+LFj8N1T4p05T9HF
         lElA==
X-Forwarded-Encrypted: i=1; AJvYcCV6BTF6FjqrpLRzaK0jrbKsbI9MPHRA6vQYb/J1hK/FXXhGfzIIN93Du3MLLXzjzih/ty98XWCNC3/ki5JL@vger.kernel.org, AJvYcCVwWE84Tgj5GcaRuBYqET3Qa5jnuFBDPimILNlc7+S/A71gC47RqFnjSNUvXxODmLxS8LIpbqSX6HCt@vger.kernel.org, AJvYcCWVUtpsPL/VAxdFOO9kiKOaPGuqq+EvPjGzvrF2Tsqv/GW8KAzsc6JGnJJX/0h+q9Sbxa+GQyVD@vger.kernel.org, AJvYcCWpwd+zchteElcamcGuqhPMibwR0jNE0pm6Iqu6MeIg3ESxGpKZEfSWNNESx5JB5uHVTQUe+cbe9J3I1m9COg4=@vger.kernel.org, AJvYcCXAYZy5FEtC3ypoq16r3VvwYE8qbHR3Ro+HjVNap1ztno87OVto798ZCFdC+DKQKfcK3Mh6ulcIsSCV/0w=@vger.kernel.org, AJvYcCXZfvA8pqxrjaGU3F35tlWaUM1DNuxXzUpsrUpK+M3hQKkwH9UHN4E0JVpWvApUR/J1TuLyxBa74m+nx7tM8tjI@vger.kernel.org, AJvYcCXpOoWKWLXMqt89/iSZafNmDwiQUizuARMCw+seKjB2fakpz9OUmqGhXQIfnz/i62IB67TbUmxbuqdu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2guWaoqU+uvzUTi+URf4TVWtkuYWUuebLD1QJHvyFMmhhdkCH
	BQtm01mqmea1FOF99pjzi174xgY2NnVUa3Kt4cz412iQIi69S1Ll01nO1XGd
X-Gm-Gg: ASbGncuY5HblXswRTLFmHMmFmiYAf6xiqq3j+cyLEHRpI2BNGz+PKk8kJrsAh2JbEsa
	rg07c7Bnsxf8adwhKpDL1sBtq6IRkLusp0Zvete10uJMjqSnLNRQEboMD/Aqc/Bemcr5ZOht09P
	RKET+/311OaDxvgS63N95dmSpBLdRrTBnpAgaGTSh9ONU5DXtNMyw+5E908IeZQwsOmynl5qf1Z
	mLw3o2m76umb9MQfbyfjWoIJ5H5H27wfmu8MQDCfYzyG4mNwG2pMQ9CvqwUZYxECVn+ukBPz/F0
	0fBg447ZcTmMhdrXia8OP9XGEKnITEYUxpECixZzJynRZzozFJ8PKsvYf/V1REazguU3mw==
X-Google-Smtp-Source: AGHT+IG9yKVgVclK4FNEvGa06LMTfBMSMcF6TN/Goe4L3z7/y4kXQiJs1GLAHbqOW92iCyBP0J1YfQ==
X-Received: by 2002:ad4:4eec:0:b0:6e2:497f:1ec7 with SMTP id 6a1803df08f44-6f2c467180amr51017446d6.41.1744990649935;
        Fri, 18 Apr 2025 08:37:29 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:7988:e5e5:1f4c:be78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c21d9bsm11623096d6.96.2025.04.18.08.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 08:37:29 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 18 Apr 2025 11:37:19 -0400
Subject: [PATCH v10 3/6] rust: enable `clippy::as_ptr_cast_mut` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250418-ptr-as-ptr-v10-3-3d63d27907aa@gmail.com>
References: <20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com>
In-Reply-To: <20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
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
 Saravana Kannan <saravanak@google.com>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
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
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile              | 1 +
 rust/kernel/devres.rs | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7b85b2a8d371..04a5246171f9 100644
--- a/Makefile
+++ b/Makefile
@@ -474,6 +474,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wrust_2018_idioms \
 			    -Wunreachable_pub \
 			    -Wclippy::all \
+			    -Wclippy::as_ptr_cast_mut \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
 			    -Wclippy::needless_bitwise_bool \
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 9e649d70716a..f7e8f5f53622 100644
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
2.49.0


