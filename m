Return-Path: <linux-kselftest+bounces-30433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AA8A828EC
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34F5465172
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0DE269B15;
	Wed,  9 Apr 2025 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaO85uWI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5492690D1;
	Wed,  9 Apr 2025 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210053; cv=none; b=AaaV1455ZjcXQDkNK8Y7x56yoVIlO0vl55/YXJPAQNNn3KtjPupdl7ZrM4wggOf77yd61iroJ5n//Ws/SkEnV8j+tvuaF5n3gtHAK1KfOPANBwfhkUEEIyf4kIbwONS0IO87ewSF1t5uBdV0EDfxDvQnI7m0uhHrLldnUp+TgE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210053; c=relaxed/simple;
	bh=aDDrOps01d2tlLzt3LaJGP74NrXJiZ8HlX3eJ61yYi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DRm+GKuCqXVErcwGAo4ueQZShu+7bzVucCQa4vtDK9pw9dC/CVKdGCaz+AiiUR/A9xS/avG10EK/l0UnSi2AHO1GzgNdDHUd4v0RXA4XJL0W30E775oYE2JIYoqvfaHxDBiG08Y462nCCHjBbp70Zl9KsbNgFNQwS83W3YxY7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaO85uWI; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4774193fdffso98324041cf.1;
        Wed, 09 Apr 2025 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744210050; x=1744814850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sORjvcO0tUIMjXvZbPyesA3RS3F2BYfcBEs3dz3VH8Y=;
        b=FaO85uWIfWP4u97GnxOZF2Ju9mQHwORGZ+xdCfz7av4Sn475m4LqIub4ruT57vpPOO
         7IcQOLIJfPz/RjsXFDefr6rCh8PhifA9ozlF0i7W7GGjXVYySw1wz9J0d/F1ZGE6QCgd
         KMO9d5wdn18Q31c8fLTQno5/K7PgXLkcIx8q8i3tKboXhVmsNwRTV45jgbRO43xNk972
         Zq5bVXfH/vLm8SpGL9D4iomQ9XXM7QywA8af2aENUz+/VKqCme8lxt2IP+E058QhxpRw
         xMbCuOrWoGfUerpXtQcyn8kJzXTCOce1lqWn/e0IzBR7uQ0CLEEirHy/bNwTNVpVRvKh
         ZWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210050; x=1744814850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sORjvcO0tUIMjXvZbPyesA3RS3F2BYfcBEs3dz3VH8Y=;
        b=QDKcG9n/NzXPATqJK3lLFKpY3NKbY3dKb6SuAfrnjpRNk9MQW/DVtBeX/7EKJxg22N
         nLcd95yjDvxRfJtkZqroLFYzdJMAniF6SND+ImfCPLfrNYHbuLL9CMcnNNOedB/C6et6
         ayXBsiVGKrHe9In/6Gs9PXC8SiSNjrd0/ZOMPzbVlMhWnKPqZSPC7/f8Z4YTBWSk6gJe
         7onYOOX6JDCXremPu7o1XV4heEaH9NmZjgckjYIZxclzuF6LtvrCpjJoFxueWBZ/8eq9
         mVg3Gy/rsaT9UXCpkd4QDQ9U3scZarBGZRbIMj3W05pCf5IqVrn0i4Ob/FL6CdMkasLk
         IdGw==
X-Forwarded-Encrypted: i=1; AJvYcCV1naJSn+PDXv7hQLs6zxsO96ImauGQrCprEHs0Wgh2EH3Pa722cyTP5Kfbn3ekCTxvURsJY81B13ayN3gLl0bd@vger.kernel.org, AJvYcCV4r47+i4wQ8Dupd9dXgD1fsApwCdUYHag6hfsaMvSIqnbV7KxzNGFFPOZqOkFh2MxrL0ZeNO5X9Jhq@vger.kernel.org, AJvYcCVJYXqUSbvsTAfdCjl/6Ky7Y7ckft58sqrauWupJqCmhpxkn7KjL0xiGh4656eQ7/a/ARklWlwr@vger.kernel.org, AJvYcCWWETjtgDfS3PNCKZVUzMpkUumZYYuuWvcBK+ifDsB5a+Gi1I8ebqCyBy944OItT2yITmUiK2bHklCzggJUCGo=@vger.kernel.org, AJvYcCWWVv6xb55T4t2rKVyiFK7QsUYFWdEZkcDcADeB6Kx6gnSFPKN2SZ1aEOhFaP54JAxfRRTBYZmG1lfGYUz7@vger.kernel.org, AJvYcCX1rRNDtW+Pxafm4BUle3C48FnlV3DDQIOzkY+XsQ9JUWPKZ6/Df4Uf+7tI+sLy8O3mWo7TSDvRVebD@vger.kernel.org, AJvYcCXNnMx6nr5JFp+I4Smy9QoFTFjvYXdq5cLxlyn7ffYwbPbwDeLiOqM7ItXa7XLeboDdFSxrWi16ZEbn2Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnizJ7So2VXMy1OdH6KEpQuZwtlhxlpBqwMUJgOvWzEq0H+KmU
	b4eivOTsDr6K45Dt4HeuqDezTiHcDxxoCE1UUyQw0RiWSn9kA8F9
X-Gm-Gg: ASbGncsaAYCBp97GGBV5yBxCRw7WvWSwLYYtV1agD6EzyxWXRtz0bWj3ErzF9PFrx4d
	7KK50PIs4cCkw/LS/dNXzMploNUnT1NvF6FrcPwVCveDfZvzna6e+qM38xOfNPOOYoIto17aoYw
	u+gjNkUIBvMZRCik0N8j/p/BQTN2KEHripQngY/dIbCL7vvRGYQAXnKhyGEoDabNqpZX34LPWna
	5vOQ8XTNZC+AnrZJLOo17/eonQoHo4HmIBuVNtdMCrNqL4X+Omg2QfRxf5XJdTouZ2gRwIHrGO9
	bGCoMpl4ElSuY15HgkCgUCEVjDL+sc9zsPRxylLSXzyl34Z8DDYKiZ0X5tWL/w1gCmPZFKCFom3
	Qyp4cYTT1Y07Bdhi6RZw1gAXuR3m39siDGp1G2eTPSiuI
X-Google-Smtp-Source: AGHT+IH9LWDhCYt3RFzLjRakH45YjPiReCb3dS1+Uu22JX78lQZJIGgZ5/arLIqBQVHKNepy2RpTnw==
X-Received: by 2002:a05:622a:1116:b0:477:1ee1:23d9 with SMTP id d75a77b69052e-479600a3fe5mr42498781cf.20.1744210050275;
        Wed, 09 Apr 2025 07:47:30 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:3298])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47964eb9a8fsm8024461cf.49.2025.04.09.07.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:47:29 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Apr 2025 10:47:20 -0400
Subject: [PATCH v8 3/6] rust: enable `clippy::as_ptr_cast_mut` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250409-ptr-as-ptr-v8-3-3738061534ef@gmail.com>
References: <20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com>
In-Reply-To: <20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com>
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


