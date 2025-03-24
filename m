Return-Path: <linux-kselftest+bounces-29714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B908EA6E63D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 23:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B0B188CEE7
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEC41F239B;
	Mon, 24 Mar 2025 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnbMKDEN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA71F1307;
	Mon, 24 Mar 2025 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853712; cv=none; b=JuggLmUFWJeIKuQcCbSFcx97yTDTnMHVg5jw595L08CVdbxEtVWEUeQ/IDnG0bDyL+jNiHQrRJv/oy6TbU56z/Sa4vJPuucS/xg1EGEQSX7REquWq1e3/MiMo8Ca4jN8NOFXtDWBGP5Nb+jA/I4bCyFv1vkofaZV8lzd2fo5344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853712; c=relaxed/simple;
	bh=xbVg7Xhp/6dsdm/KyWD3Le3ZeFNfssrbQ2pquJNc7H4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OuTkz98ybLprDPYzvd0IDxLr+zhOdzV0Na+Emu83r3usGf/ZX9yJX2Sv3J4Em/MiZEntXm2IgZSnNztYj5D+fBcTCTxMYOc9dirjkumY8oJzE/Fl06KSePVSNX5aRAK/4XuN0Pn3F3Cp/TpKlf2LPjqoDZ7ACH1oFZSA1X16TDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnbMKDEN; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4767e969b94so30224591cf.2;
        Mon, 24 Mar 2025 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742853709; x=1743458509; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrSMUDZZYlyoJ9Y4j+pFyX1Efp/qPB5Vo8olgw4flH0=;
        b=BnbMKDEN2KtY+5hcjtIpZkS7G5MyUQRQQyrySnCLFM0FTEuixN9XGNHSmQgqWOSL6J
         zILwIrzKsWQHg9pKet3G3r4aWv8EXNI/I538coHJFzhTAMol0jNe8OrJv6gnp08QsBEj
         LJd0APxhaKet08L3alrrpP7Wv67MU6xT/QV/kVLxeYAiHfq9qBAWLOxX6n99p2QrXKYM
         gewoEry4isIXBfz7t9KdKPr+Erkreua95GGMwlXh0TQY/a2rxyesapKHYCZkOqpjGygl
         ayIC0hu+u7OV/H3wm7YYPB1QlVpDvMws352/AQMG/4QEPAyOxXn0yo4ktNzd4RsLqXec
         hieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742853709; x=1743458509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrSMUDZZYlyoJ9Y4j+pFyX1Efp/qPB5Vo8olgw4flH0=;
        b=fRDi+z4cJ/jHqOjbg0XprGWizQzhBEDWQdPAusHBLrBhWSzFnIfT6H1Ikk70fMHTpI
         XBv02OgpLsPe0EpPHboyVom8CdRCz9Mg5VP/ouwXwHIUaM8/BpfajjrBQZJh4nee91WY
         RxOPSQ6QvhqpBh8ZtjEz80YErmk0g26XRVgikhxbLuAzjwMXSKEDFHSaalO9Gn+0dlvo
         MGUDzI5QaQpTEH+wRI0SzWFpOd9fDFrfGtfUuKBGsPRMLCX8zYbvVCUez5d3CFQk0qqc
         dAidLRL8ji6MW7XSapo6bsFjl20FLhAoK09xO1+68ZMV+DzyV5Uda9AOrEp9A4b6/8Wv
         PCFw==
X-Forwarded-Encrypted: i=1; AJvYcCUk2xJV4cE2TODzGlUKKG8e/DSDJimARAgTArLCOzemwXRxj9AlX5ZQBJu1gg2Kv36M77DWEQGX1mQUDLpn@vger.kernel.org, AJvYcCVuOf67s9jsGlr87XxtY92bVCznYfh/xesN2jPBGLOaQzFs+phqXnqHmsLkvJJhDhoLqKUlb0BUQjmLOLU=@vger.kernel.org, AJvYcCWORogAWEVISootgX6imclFlyLZLTtIAbIf+oYnUrqId90fAjTPwOhZ7XVBR0LPP0b+Gf0ylolvXp2r5nEAwg8=@vger.kernel.org, AJvYcCWoQwvrpylitY6OkAgtK2gTT2sCtWjtt9O4pq65Vf6ay1DQSLnT+CnDkDiUiggrAyyh3rKU2nWtoc2v@vger.kernel.org, AJvYcCWuwthuN6VdW22MR4w+PaEXkNCSk1twVatdqtGdQtCgxA02IAAVWCzpjTpyiUkYZsL5+S1Xo4XTpr4Uv8f/4fL5@vger.kernel.org, AJvYcCXOg2qrGlErKJVCVysDM9Dor2Qwa5y3boxH2drnKdHMGDCg+KxgxYVROgFivJ++vnC9QD/PnUJiO/bx@vger.kernel.org, AJvYcCXkIfq3+S192a2KNVNi85IBV4idr9PRcz6ElbNuN1hnCAupD98xPIMrcoxZk58xPyy1Dalw7MCL@vger.kernel.org
X-Gm-Message-State: AOJu0YxIyrIFowa3vZ8E1mPoAACpG2C17pAPrYETaVUEfo3akwq9JfBA
	SjZO1jkOauyMYLPVp6unUIPtFfgN46cmEOG0H7xNkGvaLftDUO/K
X-Gm-Gg: ASbGncu80opFwyTPLPJ1/JU+8B+U8GpSHFuVXrHZAiTLQ3+h7sq/g/hx6VdAFRoNeXe
	+b0WsZ4oul8rKzIETFiIXlZSEbj6Y/e6k1JH5ntJ8xhyQgXaXcM/0u+4QBOqh0xVQvVzjaCnmhM
	pslEaWNNBGmdO1YoZv8F59XzejgXFX0VCyb6pjfylhuzcJMqivLT/Vp4X3ZlhPw/uYAdq/DBZup
	LBi3hwTz1Pw5H1SMbuX56KSO/cvKseOKcfQ+MsJe4++wNcZisGMpNq9av1ocn7Si/JHkrQagQfP
	V3k/T4b8YkCQfCNSGLjwOCkulDQ0zb0Cj+G3NAawV/Yq+YoELSODCC0/U3zc+8VWREUSaWTDQCb
	JgMEmtOV5K+nVNB2EOsIYCLwr+4+OnOuWkCZtTs9f+KtqP+hcqy8k6g==
X-Google-Smtp-Source: AGHT+IGClCAaATZslBV1U1w4j++Vn9oRujV1utPTcSNqeAgqWjnn31iDitDZyWoTomflHvtQ1nvRqA==
X-Received: by 2002:a05:622a:244a:b0:477:db8:e15b with SMTP id d75a77b69052e-4771dd608acmr207554641cf.9.1742853708852;
        Mon, 24 Mar 2025 15:01:48 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:43c7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d0ad87esm52129541cf.0.2025.03.24.15.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:01:48 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 18:01:32 -0400
Subject: [PATCH v6 3/6] rust: enable `clippy::ptr_cast_constness` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-ptr-as-ptr-v6-3-49d1b7fd4290@gmail.com>
References: <20250324-ptr-as-ptr-v6-0-49d1b7fd4290@gmail.com>
In-Reply-To: <20250324-ptr-as-ptr-v6-0-49d1b7fd4290@gmail.com>
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
2.48.1


