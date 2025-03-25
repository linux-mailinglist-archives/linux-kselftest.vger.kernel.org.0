Return-Path: <linux-kselftest+bounces-29780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3FAA70B26
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 21:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54612167481
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 20:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D6F268C7F;
	Tue, 25 Mar 2025 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUzcGgiy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B72686BB;
	Tue, 25 Mar 2025 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933277; cv=none; b=Rbx0dkJk7LTps+rIYU3epJ9CIa3zErAAPGKMMntFQ2EZg3d4BWunv427gIF3/77O7tsbenYj0ihTCfeTGjmjxwfX3mbKVXyrQsaW8TDEEFe0AJiUF3Lx9cD+VNUUNvJ4vVaeQhawiINc4+QA0FiboLb7e/ncSXAmykmSNi54fCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933277; c=relaxed/simple;
	bh=d+tmvh0gyOl0JVuKZBG1UMfxq3zqeMKGdPEzn/WP544=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fOIA9t0J6dHFUDlbnjf2sM9n4prAfumqGYPjbcmVVsRbnrhawsn3tvpHB712CrZ5sWf8rHfvbkCCKp5UFz5dCJ+n0IUFVAS6NNUuouyl9GLn2lfGVLLTh6urbCBcRu0qGbLvheCu92/VMlYgjXX+aSFvvjpWB2+4DzR7SYYg+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUzcGgiy; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e1b11859a7so21363206d6.1;
        Tue, 25 Mar 2025 13:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933274; x=1743538074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXDBuKpzZkDEwqWUPr5JbpVdesx1OReuFvw422VpuEU=;
        b=TUzcGgiyjFSCd+zLrSVuE+NRiddhrk9Tu73iVFw9k9N6J/n4L+oIydawvcqNdkSfRL
         UpDl7JyREjx6iYm2QZnEOJKa9RHhiTxg6CsUvLBW8nm3pVoyNBJ/C/2lFzF5fSO4NnDo
         rPvyKcUucEyGHEfomLX282FSb5/zDuyX7U2yOKC+JD4X3LBHdz/3TGyT0m8ihBPetBZS
         DXs4lhjpcR1XaV8KsGl7kaKUMdK1JAh2kcCJGQIQkQg4lu0zLmMzi2ZdMfGWEQB3MhN+
         V0Oq/0hiQgc4DmRXlfc1/dFXxiCiACJ1usXk62cbrSxvjJO1o3mEBeH/Q6WHJqNXA6Yr
         KFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933274; x=1743538074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXDBuKpzZkDEwqWUPr5JbpVdesx1OReuFvw422VpuEU=;
        b=PLORHczrYwkG1TiNKy2ZOZtByftFTZx4oXQqjN47YkAoCxbExzKmkKfqUir8bmRmq2
         suvIfToU2D6cJAesbfddCF2Xi9q5Ja0jhurYqHjNFEwCyowkYk+qyDEGdyY7gP6EP4om
         hWfLOuWyXw8Y7/QnBUVPCZsLJvJqCJqAVM5cTpl2TpW1vOjQqXk7PL765RaJYx2Pgx56
         5L1s7jsanbN8lF4vAltUDHlUUqB0gWVj7ttf9yRsDqu7lRZMnGsF7kb1hNGAdx8qyZ9O
         fkfg7srBr0V+Nt09v1W/exdFg0j6jC7N4JQXApz2619POMCDO0uoayCrzc4NYLOYXNid
         WEOA==
X-Forwarded-Encrypted: i=1; AJvYcCV/Y2XdCxrg38pEUISzvlTTy+tzL8ZkEbNN8BKH8ZaBevQVkM+V9ixi/iR6hax7iTESPbDROVpMILzv@vger.kernel.org, AJvYcCV5TEXT/3akw3r1ovSZSvWvQ1vGJi8oOZ5KX6gNk/OK0r72menm5d5fuoL8sa/LR/lpTGTEovcx@vger.kernel.org, AJvYcCVjoA51o37XA2LbSbZBRe59HBQRc8ohq4+RBoz1LuZ91kfx18eXuKbaxzTa9Yan+tH5LoZei9RotwFM874=@vger.kernel.org, AJvYcCWFXTxk7rYaMFycxC/JfhhhWUjr4LX5/Kx2Vwqd2Jpij0R0DEVGghccJZ+smTqVSPUbbQmZ2o5TStLwlv7rPSZu@vger.kernel.org, AJvYcCWZqCOdK41U2ixnMFXX24auOCzjS2POokyPr/0C+OU12NUD+XuWSR4GTTNPinEBIAu8qZS9k0+SLvg9@vger.kernel.org, AJvYcCWhNRbb03fjW21LMVG91H26MwL1NnHGvP+p/IYkoul+6RaRB9WWpKHBNZ6kZQRJYX3o6tezwxeqwLFtsjxt@vger.kernel.org, AJvYcCXgtedjp7sEsY7k54KHJnYZp77jLyxef/9zg4k7RE3nPU9GnTqfGkRCp1zVJ6pfE+4sMCmW+9yy51AHmR6WGaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxqJkT6P4/mnA/0cEPE2KArliIDO0O7sFuMNecKWe279nVqXoh
	PbOnvc5VhucFn1Tu45E5lQlNsvoJ6Dw0YIFAPVNw71BcmSuATfGR
X-Gm-Gg: ASbGncv348Aki8Yciz3Un5YmQ5w03Se6kSQvRHGQqw12kV3UafSC0tMnKfgGsAPMBue
	a3d4bCD+ktC14mbJEnrr0XcV1kJ1WhnuCe0kcUz98QqYaWOfVVr3O/0nhJCdNFsRpyKoJJqiOCm
	X3KuR9kw0bqBXxvb2gmDz4KYtytBN8idXJnidBu6gf8QXlaNlJd0DXm/oFsBWaGb9Ujj0Ee5xgl
	4oJvCFd8oZgkoh76ugHU36el6eNycz4B0ydfIdBjczkWtGAIY7b2FLsMrS3TOOAp8xKOwt5+uIH
	w5Nq3zR8wCz4LvDEv3VMcBQLG1xqJGTzUPjLseDnJ1efRTmimioXzuLNCBSafq7SiRlhTSziAsa
	KhPfihXe1Q5c/ar1c91xhI+3xPC6qyh0qkZjAQHVx1/w3XnziyOdRU2G7f/jhjea1
X-Google-Smtp-Source: AGHT+IEODFsgFHGeBQ9zW8PY+ll3LVkcvJOvrWbn6xtmL0Kku/jCxdUnT9mLuAqmvSy6k4YXj/4CGg==
X-Received: by 2002:a05:6214:252f:b0:6e8:f9e6:c4e2 with SMTP id 6a1803df08f44-6eb3f33d619mr287029296d6.32.1742933273933;
        Tue, 25 Mar 2025 13:07:53 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef31810sm59790316d6.64.2025.03.25.13.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:07:52 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:07:43 -0400
Subject: [PATCH v7 3/7] rust: enable `clippy::ptr_cast_constness` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-ptr-as-ptr-v7-3-87ab452147b9@gmail.com>
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
In-Reply-To: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
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
 Saravana Kannan <saravanak@google.com>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>
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
index ec8efc8e23ba..c62bae2b107b 100644
--- a/Makefile
+++ b/Makefile
@@ -484,6 +484,7 @@ export rust_common_flags := --edition=2021 \
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


