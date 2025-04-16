Return-Path: <linux-kselftest+bounces-30966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C380A90A21
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 19:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DFB19053E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 17:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779FC21ADDE;
	Wed, 16 Apr 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOr2qDez"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07B6219A71;
	Wed, 16 Apr 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824988; cv=none; b=OD8qgFAVDfaFpC5eDZNe6O+m5bHcesv2cs3lEYYje2UzZJE3qdIByWaDzZ86q7vp93Na3rAyGffRwB255B0g9OAY4ye/fnfxxrC92sFn1dftPn/7IPo8JpK52E2GJqRor1SE/NcdrP89JAXxwyHyQUCceR8ND7aTAiMsYygX784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824988; c=relaxed/simple;
	bh=BrBKHbaTMC9r3OZ4ZcvFVn9kP3njL2115M5/9TpT85M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UC6ZPeBRZ3Qy4RUo8eVof+75RbPBiETBNo46KTpC/NsS6QBfu1AnqiykNjKebzXCN8Vmv6HB5Rh9Mx3tk4t5WU9yoperD6BnPxLxvuIEs+H17QgFXGYm7EzrTf3r87pqKqI57k4LflLBLhmnyBPB5Jg3T8ECU6RNIgcE9zowAt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOr2qDez; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ed16ce246bso39297476d6.3;
        Wed, 16 Apr 2025 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824985; x=1745429785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJDBBJuQk0zO1YYyCYhFBx0Rtrb+rmDlBpZnK9sGyyk=;
        b=EOr2qDezbMfDi0q0FDT9L5NG1lcxHTRWoNNO0UEmDwj+JOj3IUXyEa5vtfNjquPh9G
         RL2/LdCRS0heLpyEyiHPHFLr0aFbjZw0+QifSTpKz+1KPc4d30UgsaH7/y8hnt32Ddaf
         9NB4t31jxaHJOIrubOId1lBgRrtQIDdFoHXBdQk2qWqIRhVEdu+G/rMSyW4qthLJmfoG
         +ywEGzqAffk+U6tEI3DDxWkRbQeZQ28tytJCp6Tg0YTpGSSc893K/Sz9CCBPMfTcQQur
         WhOQzvGeSbUsP/VpsDsMNcp/dTEzQrTKThcK2kdJguzBYnxlym039q8PakU8sjqFkR1x
         UKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824985; x=1745429785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJDBBJuQk0zO1YYyCYhFBx0Rtrb+rmDlBpZnK9sGyyk=;
        b=JKjknXTT3A/5g4mrN+z00/0JK7O/5lfnxyzmlGYR7246isvD3KJXKwS04HvC+ghTID
         AADA1U2bvs6BxIvmcx+89uybmAEuQcJYne+DFIAY3W2psltA1BoDdmQkqG3Zknde44Uj
         WynSa1WoiFvtdcdp7THNR8OJ0nq5RcDdANp6n/+Epp3hYYgS0X8tmF3B0URz44uMGKrp
         oDcXxuNMObmqNeRcXqKRiA4sNZBuBiyCLXA354a669HlUSCXpjpAaShIynyHEUAa+L3G
         HOgkB+01VwjeMhjIFKUao8RlcU2MwAo22cr4kIMNRHeYkcX6SlBAg1GSOnx+kXtcrDyr
         upJw==
X-Forwarded-Encrypted: i=1; AJvYcCUP+XrwQAMQLO3wAL92hITmohn5f4iGh6jP8XwKLt0odhTUWzrXlumHj2QUTWWSyyl7VmTH3hnQVGhe@vger.kernel.org, AJvYcCV2xlVwTMXQmNtjx6Ofu2LUcjRAAsCZY/JKwJ3hkWXfec7Lpdw8X5J2sZc7yNJgps3JRY38Olw6Gbg1chzyW0o=@vger.kernel.org, AJvYcCVNBsNiBkKmRBiZixDQEJbf3fxlQPa6ZeHXw0Kq8bLe/zLb3yvSSBsx4NVfeRCHdt5vU601/t+Z@vger.kernel.org, AJvYcCW8p8n3U/C5kMpPSk/1MpaJpoIvg1I59vxOJ+6yhDkuoxCTHNlIztm93TVccu3fe9iZkoWwFr0qrcFLVghy@vger.kernel.org, AJvYcCW9wnEbLuO7JNQA0Nm9lxAWV842gNFT451Y45YLQ69YhKA7iUvmJ/SpePBj2RGGdnllGUKzwJ0X07+L@vger.kernel.org, AJvYcCXPzQglR8xyb6q+RkztFE0f0rH0zGPspKf9h48BlvHTkrtJEM0WXZtKDU0ujkZT4sjBBTyOAgtozbPFbBEMW1CW@vger.kernel.org, AJvYcCXYQmlEaNcnStCXmru3lxqy3jjM8aIFxDODg4fe6tcx0r+fLg2YQE0xP9LKDB7lITJEMAtSAhdz3IEu+ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ZiuDXJAyhfrJI8jbUhzSWI5uevipf+WAMihnyyUOZLLpybqC
	ksYQw8RLxgK+zfVHpfDC6TX4T7jdnvEp7JZP2ITGMYThqLbDIVX6
X-Gm-Gg: ASbGncuv+FiMxROjYK2jr966ij5SCX9RzeLHhOmwozMaM7IsO+QFvyCpMJXZ5dRnEf4
	tGp2QV54hHdmYlfeZH5tSWu/kF4S1hcwtlVMMO41BOwPOfMf9Uf8T4ppf5Ei7NyaG2txntOnOvj
	daGW5Anja2OSLBHGLPEBgD3CpCqne/+4EJ7KCv1GBLUooAqSC2kV7MogIhprw+XsCtD0bv8QcwL
	diustmT0BVWat4JuI0H5ae17CaD9v9FefyycwSpdGpPWiuC4MXT57BTiS02vnbwsBbV3a8bdu/z
	aQFfT4DgJ8YbuFm/ximsqng5Aj9UF/W/XC5f2HrOpByXdVtYFXMSFY6CviwJWypPzKYaA1LUUG1
	v85wnUeLjHwQzDbMJoOZ/q61s6tjjj5k9KH6Oajtats/E
X-Google-Smtp-Source: AGHT+IGvStqMejrtJadrdvE+zWRyHrQ23Hn7yDYS1rshWoBmONfgRKt3F6tOokW8CHrD7/YmbgoA2w==
X-Received: by 2002:a05:6214:1cce:b0:6e4:4288:61a3 with SMTP id 6a1803df08f44-6f2b2f30abfmr36229256d6.18.1744824985307;
        Wed, 16 Apr 2025 10:36:25 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:a61d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea07c50sm118289886d6.77.2025.04.16.10.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:36:24 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 16 Apr 2025 13:36:06 -0400
Subject: [PATCH v9 2/6] rust: enable `clippy::ptr_cast_constness` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-ptr-as-ptr-v9-2-18ec29b1b1f3@gmail.com>
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

In Rust 1.72.0, Clippy introduced the `ptr_cast_constness` lint [1]:

> Though `as` casts between raw pointers are not terrible,
> `pointer::cast_mut` and `pointer::cast_const` are safer because they
> cannot accidentally cast the pointer to another type.

There are only 2 affected sites:
- `*mut T as *const U as *mut U` becomes `(*mut T).cast()`
- `&self as *const Self as *mut Self` becomes
  `core::ptr::from_ref(self).cast_mut()`.

Apply these changes and enable the lint -- no functional change
intended.

Link: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_cast_constness [1]
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile                        | 1 +
 rust/kernel/block/mq/request.rs | 4 ++--
 rust/kernel/dma.rs              | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

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
index 4a5b7ec914ef..af5c9ac94f36 100644
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
@@ -155,7 +155,7 @@ pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
         // the private data associated with this request is initialized and
         // valid. The existence of `&self` guarantees that the private data is
         // valid as a shared reference.
-        unsafe { Self::wrapper_ptr(self as *const Self as *mut Self).as_ref() }
+        unsafe { Self::wrapper_ptr(core::ptr::from_ref(self).cast_mut()).as_ref() }
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


