Return-Path: <linux-kselftest+bounces-35032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B84D5ADA3DB
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 22:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E18188F77B
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 20:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A66B28468C;
	Sun, 15 Jun 2025 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKCF1xDt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40253283FD5;
	Sun, 15 Jun 2025 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750020919; cv=none; b=Aaf3PmhGn8cDpL/D5rYQtt5pFT+V1BlX6gFm803w11922jxAmUjnH5GotDVnKF2dgrmMTJIJkfCLC3OlEZhsuPydtmnns6NB3Mm8Bk3zyhk3xK0MVpDTcW98Hc2930DYTSKklhhdvY6rZekUze/l0P9eaxocOwiQEFdePyOCu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750020919; c=relaxed/simple;
	bh=yF5Gv8tK9X1wroVzoAbelwVn5+WfGFCL8D9RidNzyJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pFY7P5R+pKr47ZpotNJd+wl9Mj+esP2fZQhkcWURnFRcv+6RSU3x/K1SPYeVQydyulv1aKBJt0fRfnHkLfKy6qtvoTIMUG/lsp63WlqoJ1U3mXMCrJlzI/0zn7Y1QaAp/S1eeqGWqNMeeFf/mU6Xv66HUj7o+dBEO95T7fEO+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKCF1xDt; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fac1c60e19so51740796d6.1;
        Sun, 15 Jun 2025 13:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750020917; x=1750625717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwuzOkwr2WXLbNIqZ4PjxHxYIhjL5EaV2fkU8tqfaYg=;
        b=PKCF1xDtFWQ0SDEV0gdWl9qc/I3iAdlG0nU9+IBQjW08EWvn2FrsyURMvOdg9apz2w
         x7dLBOjsP0zPO86xk+dakk4DoFAmVl3raAtq2i3Qvn1S5uYAw55vBcXMX8YnD/zVO1fT
         Nm4Eb7UCkw6H176Fc551phGh1JqlOmXT1KgMQvKdsm18QCYTm7cdIcuEhJq+kDQSlcED
         N6OAyiIMacLqOktj9ueypT/LRqXTpLGEzLr9i6UwMO8x8mJAz/8Njk7A0CDSNoSf6y3W
         x0KE28JhWQgHBv4yRxL6i3A+5I3VcJe/CLDMBGuUuFHgWNZmAK5dlJVVu7HR1fbd4FLy
         9lNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750020917; x=1750625717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwuzOkwr2WXLbNIqZ4PjxHxYIhjL5EaV2fkU8tqfaYg=;
        b=QDmI7EVnFx1Ly41N1UryqAg5JEttTM/SaphAIJlNf3J/hTQLl8lbvAfHtXN1ZBV0ZD
         YfFX1/9aiPPxjW0A3q5vPuBR111lRqL8aBzFHcgfCPDVPJHwgxI0MAlj2QiP1rLB5NQH
         UrXEAuYD0XfjYCAYItjNZweKFqgqVUbE3DGSYsxAFreUCngNBOTN6PrhkCv6J4ZIV0R3
         jbTdUlBS+CDiP1tuJKcVzR0mw1K0RDtC4Bi/yzRooYQpYFeynl9YY9NYngBLmfSx0LH/
         yxrWg35/Zjl79mP3+W+8itEArxdPESZvwYCoVOwyCLcqGUVW8kKP78cttyIAQKeMb0gq
         T+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUk++kanK8CKtZsBJ2dmdVBiFsm9FBdPrEeqRaSg8Op3eeNxc5GT0F6W6Gn1shSSM/QoQtKVcs2Z0pJ2BJRZsxP@vger.kernel.org, AJvYcCVYLHSwmFpJhRrVC9YITqciswF419myrYz8Ez/lvzluBFht4d568VZ4N+ubJa2F2EGqejO+5dZ5hTiuc+iHJeA=@vger.kernel.org, AJvYcCVbq0GC+3T69ZwU8tgPFDW+Bu2qiuyajmpcnRSA9Brr1sbDVQYPGhphWOG+tGBtk0CfioLQlBuigdntOi0u@vger.kernel.org, AJvYcCWPsd0yMGDaNmKIKfJao7gqZSpolpFlTPPivWSUoaJuApRRjkotu17e7xUc6dlXvlcjiOZTznO/EAXT@vger.kernel.org, AJvYcCWm8F08MpYKjp2LV+iJIo1Gqw9qeGrzWMd+GACImVSzU9u1DEBhF1LVXriPvQA86xe3Cv1gLhwIG94s@vger.kernel.org, AJvYcCXA09cIpQVdDjw7PIMyFLG6Y4hWZwRD7G8L08QWBu4ciHSkk2dyyqQ8t/jFJLNggpXBrshDLI2GKHQ7l0s=@vger.kernel.org, AJvYcCXOf2zfs4YP4WzBWNE2M8ZzHv1YtNoYiBpek6eB5CzikZWhMKOrTwI4T6CmJK592uXTTrfRJ06tMRA=@vger.kernel.org, AJvYcCXXh+gsnqS6SJBopffVEGpS8xOkL7lRBeKYIwr5ccfBd1DYvA4s1AddL+Kp+Ak2irayq5iX28Xo@vger.kernel.org
X-Gm-Message-State: AOJu0YwkYNo1r9d/G5prmNEwm7I1gemQTjZ6FPDCup20RQiflulVZ5Fw
	eUhow6+nR7mB4K9hbCTJMG6u0c0OW63rJc6C6mQbNZ5CldCx7XL+Km/R
X-Gm-Gg: ASbGncuaeC/kDvlPIj1j+f9tOd74xvzDO6lHRL73+JCUGy3qSnh38jFMvprOdc3VvrH
	LuK8NMvQwKwKYBudgb3zulyyhcGPpmcsZCZtC3C70RkFGAUOAlydgkNp74yCd/ygq8jJ2C/7q8M
	5oacKX/j/v+1auAbai2OE5Z/kI+xW1DzNlrSYjHDXDir3f+EpDfwWpLgnhhmMBWIteEokZTCbdT
	99c9+wKPOftRjXe6YCxruWKOHF9XkA/Th/3QAVgRx4QacS3DTbBQEevEf4ot5mhPf7+f64yISM6
	3yTfd81gwaoaUJYKmdxMk2ncaEmTdjYVZ01Nvuer6JPGqUVzAod1WZw+JHggxLUsw6K4CA==
X-Google-Smtp-Source: AGHT+IEgmK9+Bj58C8dqWwTYX0gZlBqZMRj5psT70nx4i2bPfqmKaepd9+hxp6sh8BMt38kvfV7yAg==
X-Received: by 2002:a05:6214:76d:b0:6f8:c53f:48e with SMTP id 6a1803df08f44-6fb459eecb2mr143148166d6.0.1750020917091;
        Sun, 15 Jun 2025 13:55:17 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:b0c6:92db:d807:21a6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c84148sm43468176d6.109.2025.06.15.13.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 13:55:16 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 15 Jun 2025 16:55:07 -0400
Subject: [PATCH v12 3/6] rust: enable `clippy::as_ptr_cast_mut` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250615-ptr-as-ptr-v12-3-f43b024581e8@gmail.com>
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
In-Reply-To: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Breno Leitao <leitao@debian.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
 linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org, 
 Tamir Duberstein <tamird@gmail.com>, Benno Lossin <lossin@kernel.org>
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
index 5eeddfbf5900..bb33023f87c3 100644
--- a/Makefile
+++ b/Makefile
@@ -479,6 +479,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wrust_2018_idioms \
 			    -Wunreachable_pub \
 			    -Wclippy::all \
+			    -Wclippy::as_ptr_cast_mut \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
 			    -Wclippy::needless_bitwise_bool \
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index e5475ff62da3..237182446db3 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -140,7 +140,7 @@ fn remove_action(this: &Arc<Self>) {
             bindings::devm_remove_action_nowarn(
                 this.dev.as_raw(),
                 Some(this.callback),
-                this.as_ptr() as _,
+                this.as_ptr().cast_mut().cast(),
             )
         };
 

-- 
2.49.0


