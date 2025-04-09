Return-Path: <linux-kselftest+bounces-30432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBDBA828E0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3FB1B82BF2
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544E926980C;
	Wed,  9 Apr 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyrYV/h0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241E268C42;
	Wed,  9 Apr 2025 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210052; cv=none; b=LXmRtZhkbH4Ycj5WEkITAA2Hh89+CTBrkpt+txpp+C3hy7OBVQpm0OiJ5JbYfGacqhNthta1TZm8QVPU8MeF1kxgZ+7PaPQEc+rUWcvPMb64bE1ARw/hgxAy9k4lfrUcC0a/xkCSXfxG0BV3sTSdUi5GKdPn4vwwNRD4S7qvZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210052; c=relaxed/simple;
	bh=1lm55BiOT/FFvcYCcYH0ZcTmx31jiv2NnT0cdCpTpcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rt+AO2hvlP1GWJsUk0xRuNrNG0NbDEeCBjS7cbP8OnX7wZjQHDjrSXWUPLg6ACIWVetgzLf3V93T38ckrma8fRtWYkB5xsTXiLBhjHyUlhSvGWvipUaSa20iEAcWSd5G9gDkQ7aK0cHeWsE6/Q1Yqa5qrkZyjooTam/QL8Fjia8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyrYV/h0; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c54b651310so914530885a.0;
        Wed, 09 Apr 2025 07:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744210048; x=1744814848; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUwLdZwmh+cy9A2SbSrrWRD9Fgt6AUa5s7mHmX38m6c=;
        b=lyrYV/h0cdMkEQIy/rhxFy/b7OvNTFt5gXb1a1lcPKN/QjyTgCh/gkzW+nFu9QUqlW
         VpJEdGOn4AxSFdI36RlYR5ID7w4Hz8ONGJuCUVk371d/x6ow4yJ/QQm5LmhPe7P9OFGL
         1ArymWA3SsacRfkaSMcAcLGLAUAuvh5xMI8MPgr2XsLWyMwahzxxKymWYl3HnIn6Fpn3
         AXl+DfkhWh33UhS5XzvHZl6lT1TS7eMZXMqOxexpUxora7+147bh/8aZQI5qAmTooRsp
         ne7gPwsOplL5LjKos3NoyPF3y2il6ZipIr1htPRuvCUKKn7ZOt8qIXdeM+kxaC9VrYDd
         F/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210048; x=1744814848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUwLdZwmh+cy9A2SbSrrWRD9Fgt6AUa5s7mHmX38m6c=;
        b=AhnOf06T05scboCMiImYbUNvOtTAakGLsPFs/ZHvBwzncqIDLQuuIlGHkVhgT6PK/k
         7addzrynkfJWK8BrstCJeYaK2P5n3KvSTvceVEPcy5XZbygNM8dMPhAJLwLTj1mEX79Q
         eWuUmSDh1gxXg4ThHOAiYqfNYIadZ1CyRZUGlu8xJnnMRqrebyDh2Po9gcdv5IaTCCUq
         s1WCZRvpZEHEFOLyThXAgdgurWJZjKJjmIGVef/LBWNjuOviKB8P3P5gB7dsDtz0t7dx
         I/3pZClGbs6NlPMV4I/jLyjFJmwm4w2l/ZslRBT1/cMwc8W0J3yo/gqLMg9k/xM5mIsj
         39VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVdwfucnZ6FWx3n8Yjfkt6yJpl7mYrhrBSvTONshrrJlr1tr2E3OOoKn5Kw09TjmWhB61NEf6MIlRf@vger.kernel.org, AJvYcCUenLIRgIbEOv4PYwti+GWVP1Lr/arFigulryxfM2zDGSrGqLa5sgdz6tdlZytZ6ZH+Yio+kmfZJm5GDzha@vger.kernel.org, AJvYcCUs6Wd52PjLRQv05yj7ji6rgFt/TExqhdyVvHFu3INf1YfWsojn3TRQA1GM+AReTRIPs7gchzB/2LK7@vger.kernel.org, AJvYcCV74j409QOye9/+aYKpsA/KrkQkgjqfS8ZXSnmSCpURLX9FX0ePMu8tblCO2Od+i6x1/9wrpi+9TEGl12NsfVR+@vger.kernel.org, AJvYcCWq7KwKyj6BTLNbtmZn4YbLy5Jw+UtH1Op3PqW496c2eLtQjXi24dDqqgRpSOH9h+UhFa7ocI/n/PTl68E=@vger.kernel.org, AJvYcCXfsLCP7Qglw8R5IxKx6OY2EbeN+i3plNDN4tNOq81/JKyEFT28OejwEBAxX5jhiDYWJ/Arv0dbi0M4y7yUsjs=@vger.kernel.org, AJvYcCXrZKq7LHK3HWmXy5hMpfVcNAN+p1HwghBm2u39vHvgUmgvbfDgiFJJQxQk36TffqdpE8tmKnd9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+tQo2bxJJOSyyL5s7xYjQpuMhxkjj1HKGL1r6zm34C4sjGw6e
	vagLcAXBgO9elbBmexoTo5t7AHWNL9KJm72Yu/2lO9w8pm9jHYzGmP/sstEs
X-Gm-Gg: ASbGncsVa86mazO4KAmuJpYMJv9/EPhDT9LN8y+8K0AC5Mcl2XrDAZbbNsEsBJXgzK6
	dooT685R6gt4EOlIaX+hVgLH80Ir2pA9G9FVP/51CjW1UtP7Sr8FaF0tgkZaCwXw9s5rvcv5x7C
	Bep7eVGpjtO0qoTofu9ollYswiMAgdWAdiMNK6jb0DNnIXtfgIO4lp1UQGdN03xJYk6k7QK/rYG
	2YYNYnCI65ALUcyNZDgVmYpmIuS5f+PIvLNnyJbtRJRBptKvNRxy2wOCPA0lHUaZNz71lE2LGpz
	GPLI/1UIPgE2YSlI9XpbY3OGRbgAOCwFos25x0tpQBA6EC7lpeHF/LwQzwreTeJNyeIFZydDD8z
	voOXDx4ubomfJkq8OLwrCw6A6QF3O/CCfPlt4v9Ual8cA
X-Google-Smtp-Source: AGHT+IEtpm2maEl8wOrCcK7U+9nPKjcEayy9yuyC9vnFfyrE2QXcE2b1Bx+rFHLvmbOyvjQvRgGi/A==
X-Received: by 2002:a05:620a:280d:b0:7c5:5d4b:e63b with SMTP id af79cd13be357-7c79de91e5fmr351879785a.38.1744210048520;
        Wed, 09 Apr 2025 07:47:28 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:3298])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47964eb9a8fsm8024461cf.49.2025.04.09.07.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:47:27 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Apr 2025 10:47:19 -0400
Subject: [PATCH v8 2/6] rust: enable `clippy::ptr_cast_constness` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-ptr-as-ptr-v8-2-3738061534ef@gmail.com>
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

In Rust 1.72.0, Clippy introduced the `ptr_cast_constness` lint [1]:

> Though `as` casts between raw pointers are not terrible,
> `pointer::cast_mut` and `pointer::cast_const` are safer because they
> cannot accidentally cast the pointer to another type.

There are only 2 affected sites:
- `*mut T as *const U as *mut U` becomes `(*mut T).cast()`
- `&self as *const Self as *mut Self` becomes a reference-to-pointer
  coercion + `(*const Self).cast()`.

Apply these changes and enable the lint -- no functional change
intended.

Link: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_cast_constness [1]
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                        | 1 +
 rust/kernel/block/mq/request.rs | 5 +++--
 rust/kernel/dma.rs              | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 5d2931344490..7b85b2a8d371 100644
--- a/Makefile
+++ b/Makefile
@@ -481,6 +481,7 @@ export rust_common_flags := --edition=2021 \
 			    -Aclippy::needless_lifetimes \
 			    -Wclippy::no_mangle_with_rust_abi \
 			    -Wclippy::ptr_as_ptr \
+			    -Wclippy::ptr_cast_constness \
 			    -Wclippy::undocumented_unsafe_blocks \
 			    -Wclippy::unnecessary_safety_comment \
 			    -Wclippy::unnecessary_safety_doc \
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 4a5b7ec914ef..c9f8046af65c 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -69,7 +69,7 @@ pub(crate) unsafe fn aref_from_raw(ptr: *mut bindings::request) -> ARef<Self> {
         // INVARIANT: By the safety requirements of this function, invariants are upheld.
         // SAFETY: By the safety requirement of this function, we own a
         // reference count that we can pass to `ARef`.
-        unsafe { ARef::from_raw(NonNull::new_unchecked(ptr as *const Self as *mut Self)) }
+        unsafe { ARef::from_raw(NonNull::new_unchecked(ptr.cast())) }
     }
 
     /// Notify the block layer that a request is going to be processed now.
@@ -151,11 +151,12 @@ pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper>
     /// Return a reference to the [`RequestDataWrapper`] stored in the private
     /// area of the request structure.
     pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
+        let this: *const _ = self;
         // SAFETY: By type invariant, `self.0` is a valid allocation. Further,
         // the private data associated with this request is initialized and
         // valid. The existence of `&self` guarantees that the private data is
         // valid as a shared reference.
-        unsafe { Self::wrapper_ptr(self as *const Self as *mut Self).as_ref() }
+        unsafe { Self::wrapper_ptr(this.cast_mut()).as_ref() }
     }
 }
 
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index f395d1a6fe48..43ecf3c2e860 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -186,7 +186,7 @@ pub fn alloc_attrs(
             dev: dev.into(),
             dma_handle,
             count,
-            cpu_addr: ret.cast(),
+            cpu_addr: ret.cast::<T>(),
             dma_attrs,
         })
     }

-- 
2.49.0


