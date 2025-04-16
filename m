Return-Path: <linux-kselftest+bounces-30967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D469EA90A29
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 19:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B964B5A15E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BCE2206AE;
	Wed, 16 Apr 2025 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E48E4M32"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D621ADD6;
	Wed, 16 Apr 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824989; cv=none; b=SVqM06xXewYR/V1cKeqA/gu0L2qTtyy1XsGWUK4SBwBHNIz8EfRixpMQrgbfQ6JCXHTgT9rQ0tFX6jTupxg5RfxaMqyV/MmxrQy7uPkMs6onCjIhtWCm07IV8MvVNQure1Hh1oYdbTSZKmUUAM+JMu9e2Qgp94nfa2LK1wYzFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824989; c=relaxed/simple;
	bh=aDDrOps01d2tlLzt3LaJGP74NrXJiZ8HlX3eJ61yYi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Arj9baLtT2ohxYgT650uTlpltDZAaMJ1b//ZmD8/0LrEAaV/bBFCONtWTaPaQ20X4uyyjliyn5GnnSV1qUEdaXzs2g/HM4nZcBKRKMC7sqrioNoBeYlyRypy1ilitZ2oWkynfZgRshC17esDRn9rwhWotsijxdTJoqh5kiU7/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E48E4M32; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ecfc7ed0c1so57335436d6.3;
        Wed, 16 Apr 2025 10:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824987; x=1745429787; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sORjvcO0tUIMjXvZbPyesA3RS3F2BYfcBEs3dz3VH8Y=;
        b=E48E4M32ZZ/xO6iQKzMBgbfOu/4WMUJU9vNG5V1t2luUp/I2/HpnfzOI+mpiGt7wcn
         CvoLexNYXpJXL/ZP/jJ+J+AgU/UK/XCMxgfjxqbXZlOWBCIbcnetKx7dC18hR+Bbq6hp
         YzWpUzijOsYSr1Up1Itv8PrMSm1W69SzA3HV67a40uFdcEWbyg/dAjIaYY8jp5Xcrtau
         +3s9eHju1pI8gMMRbaACbKefrP9SYixZeLzPb9ajYbXfR4y6ENIB+Oq/RY1taHGLxd1z
         az+4E5E7kC7LA/7MJzKTEroKG4tfyO5/Kqg2N+gRuN87qBNal+nj4nGvBAOz5OUn7aDE
         /e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824987; x=1745429787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sORjvcO0tUIMjXvZbPyesA3RS3F2BYfcBEs3dz3VH8Y=;
        b=B0dwqvfpafVnvdGpQpO9O38fA0BUMTkldaGvlxhvNqz4z4aFk6mINFp9pttlgl9OTW
         jzNBYpOsfd4D/Kw/k0MXeqZwGYbn/PIvL2rem8X/bxV6/huqFg8+mafGaKZdm6e/gJgL
         SrfTztWj+RvQ9iirzzTCaebTgzpohd4F6G77SfMVg9sfhmWGf6ieSL2XzAyGu8TQzNlU
         AOoSi0S1RjWleU2UIO/EUw5FN9VhE0ul+RfFOfh4WtLdmOFQ8b+BxiucItf9Ej8tvK7b
         b1qgEnvVdNqHowRaMU2BBUVHTPnWKcR1rBRAStXLgxqiUyaY/ezQq9afg2s2G8S5yE1I
         NXlA==
X-Forwarded-Encrypted: i=1; AJvYcCWabETnV+kYKHiXE5pRo6O3nAoVZTo8QUZyXc9v3OhNpUKDDVuMzB+5Xrd0Ort4/hfhKrxgWwQq5BB/+Yo=@vger.kernel.org, AJvYcCWnXT+J2buVz3R8bZnJneXLAZlKb7Nsg/S82iNyRsKQacT1ZMdSLg7/Q/KeswjkBWh2OopBmqEx@vger.kernel.org, AJvYcCWrNXOVlgVDJle0gy7ubsVfreoJuBDusw6UK8uOrKm5T91jufOO2RfPFaYUxpgJ51F4zUrHRSyMx4qs@vger.kernel.org, AJvYcCXZ4SLOHONrNijoYIjk3DHEXHnyeiQecN3x6DBPr9eexumGxO24a/HvYiS5CMqKR1DUJOVaMfQ+A0T1j9vPdp4=@vger.kernel.org, AJvYcCXe3jWbzWPJrg8HHdDom7p5NnpHnks5OT3yWPsVg+kl6ijDZqgMWjP+MqCapQlVESDkDnKEXBrTJU+C@vger.kernel.org, AJvYcCXhmy39bYrzGKk4CIIkTLccTH99T4VilrrlMTCAXJ79YRtHKZGvOUZzYVH5muySqlTJSr6agNeyQzGsY7AJtoMn@vger.kernel.org, AJvYcCXkZIZaXtxmqkqTB6o5tdzI7P+TxDXd/jrIBisM/Yg/Z46CGbWRkCNFHqCXATgP1gKnOf4fkywgAnUdsTms@vger.kernel.org
X-Gm-Message-State: AOJu0YzRlMiY2mnPG7UKu/yLhZe6e7mL6Xi4jv1yjV0HFVQopco8YWZH
	jWhqbmb0yO5KVOHiiILrQaqGg93HHxsGGWZp/7hMNXJD+8+42Ict
X-Gm-Gg: ASbGncumdBan4OpaeVdntPPXQM9mQaaVENTjrRfYSyBgue1LXHipY78FU+5j0QEgxkq
	6NChNadSShwWrY4t+a1zErO2yiaNPVbv6giSmZYKLbz2+yEBtp3p8FAT+wPUXxwlDkp2A0LVcW+
	JkgCytDfoXhqFbSOLA5LmMRN4k+Eb/UIbsAYFDijCF5BzUbi5OzH2wqP+1f40kEnewMXA8ijDGe
	OCnaWpvkTlMuNbnE58nDKMFrFvIEQrlmkqY04XUU3Grr8GelAKw2nvehMUgxLKD/ECNIx+i4vvD
	R8J1e1WyemIle4O/urzk4F9WacVP1/9BFTWwsdPdhAhIgcDxkfB5aSNrW1sG4byeP0uanWsYfnp
	G3rYB2NxmCnFaZTGIXc0qJn6hg1w3wnxG1mGP1lVfclHw
X-Google-Smtp-Source: AGHT+IEdGY2wFQqajLYK8mKt0U3F/fNAP2mW/+4VwbP2os6RpAAcUYU2SqjB20jtKZ0BY8vcuLVuMA==
X-Received: by 2002:a05:6214:3008:b0:6e6:61f1:458a with SMTP id 6a1803df08f44-6f2b2f429a0mr34380666d6.14.1744824986976;
        Wed, 16 Apr 2025 10:36:26 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:a61d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea07c50sm118289886d6.77.2025.04.16.10.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:36:26 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 16 Apr 2025 13:36:07 -0400
Subject: [PATCH v9 3/6] rust: enable `clippy::as_ptr_cast_mut` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250416-ptr-as-ptr-v9-3-18ec29b1b1f3@gmail.com>
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
In-Reply-To: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
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


