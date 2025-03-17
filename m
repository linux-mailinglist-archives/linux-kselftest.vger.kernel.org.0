Return-Path: <linux-kselftest+bounces-29227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB84A65344
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 15:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52970189BE9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3762475C3;
	Mon, 17 Mar 2025 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keyNMPyV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5BB245026;
	Mon, 17 Mar 2025 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221442; cv=none; b=Vy+CqoFYYW4IevVR6tK7sbWlJB11oI0TGzQccXwZuy5DjZVWNbZrFzh5joCROGwJAOeOJGNR9grJ4IcscaRJV57ajO1PPo+GJdNNwDy2mTUYumbVYRL9q4UkIMzpyQxgP2LCvbksopuSD7sP5UMYhm7d4DAVBOCvq6wGWKCO+yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221442; c=relaxed/simple;
	bh=/r0m5YzIWWRQazZFOJwTQSRLej9n6gB2sGQQ7S4a1Yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ci92zCBLQ4/dbxZAFy8aveTqzYUXL/Xz17EPREKYcK6N/7qZ8hM/LCoQmElrii3lOHfOpoZd6LJHl6mm3HSJ9hfMrlJTjNwJ9p/MIE72JFxCkXejFmL2rXgmpLnNmvwmrZfytr/08AXbkJBSMU+FT5sdPpTrR4xc6qnWzdOcyRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keyNMPyV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4766cb762b6so41789061cf.0;
        Mon, 17 Mar 2025 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742221439; x=1742826239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pDD8iTOqsV2dG/t13s+olVTpQHy7nswKrZLCkN6NIk=;
        b=keyNMPyVmv90F+WY2dK58NX1eF3UmlAOBoOzRZSANeWZUycu2nsiPo71SRqiGfgLz9
         +z+7r/ciFj0FfuMcEhFYdrC8ESOSc7eagR6u9W+Wn+DJmUf24yiiJ7HNm3KsIRlwdFn5
         yJ6io4/WUfHHVuL0vn1shCQkNoF4kSQtp2rkE2aiCJVCJ5VnUHKXbJRi/OrM+6wivW4B
         CafkrymxuFsLYqqXExex49ZhK0PzB1dSnKMcXAIlopl8tklhHmGnJec6iRRswiG+WRZj
         swhHLtGPoe/dgT9Bw3LVJEsVLQdinfhdphYL8vqzW5GKmW5SGt20sDE8uLPTFr5RE3H+
         MB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742221439; x=1742826239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pDD8iTOqsV2dG/t13s+olVTpQHy7nswKrZLCkN6NIk=;
        b=TrcZdZof+HoO884Ns1rwdMYyVcapAA1sU3dNW5knR7eLOwYxhdwxespYhch1GVbyuu
         9sicqa5ZRgNmS6LffRSkVbCRsw1TTQ2n+615sr27+4ReaJNkzgtsj+EOlXLQx6/0HXls
         3AbZvlmvD5NSFbjcPpcWHWkjBJEh9fED/ksudv33Z4HS/Fmqq5f8NA6eVWP+CsFSdZPY
         WWxb7go1x3AGNHkzKq/yrEVGl0tN2LvGFhlu0v+RvcdPj45nZfsRFuKngZOnsEEfInRh
         zxQjhC2gg3ZgzoxOQ+ljBmobCkLXsH+H7tlJTIBoFfRXg2RsMn09o8Htkq+TnV++h+rI
         4m7w==
X-Forwarded-Encrypted: i=1; AJvYcCUCNKk1jHTu1GruWuyF3lPN2kiJn6UD7KTAF5eoQJIlP8B7kR4KO0Y/HII760l54jaqmx9aG9/nGrLm@vger.kernel.org, AJvYcCUQioMXBa8+Nfqtx4a1tQ7INY3z2aO2B8dlwIH7mdDOWfsLMzv6K12q4dPtwZkbxNoqPl61aznAKvzuI01M@vger.kernel.org, AJvYcCUU75vpHvsHcwvUc9j9HDIM1vaDJrhfsBv7DGnWTlH72CWm3Cb2+VNIGq92R7VRf/Km3YISe0cDTEohE8e9tT6/@vger.kernel.org, AJvYcCUirkVT44GznVLAkDAocpZTKA2YhSR7NS5GfulLhYR8pYAgPIzqPJincwqQ8rIt/ZBUkHxMSt22CDliz4Q=@vger.kernel.org, AJvYcCVGdtV5Rj/iMjf6XY7Oztz2FSTkud0D/geB5e/yNpeuCL7FcKkMnzkMkLRUTwBcbGD3SrsGuGHX+LsK+/9YdOM=@vger.kernel.org, AJvYcCWBWSqPphH47uKp/0swo3b316OGQXzZ60D3OpmGtFZDUXms55rjFqz2OUEf43dRoRnLLjx7JRZcurua@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBq9xHzqOSZS8t6BkgDK0bKRhKyKM/pNOtLFGAqUDbERbU+dF
	kxeF8kNSqxPIQr5LayDobHQM4a/ofbV/32syhZ6Vc79LL0o6i63t
X-Gm-Gg: ASbGncsldHdHobFnJ92D2frseNM+hl4wRgnBWovtLrX6iY2feHipkO7+zWU33kpHtgS
	DTdqSHZ/ZjDMrzeVi7ExDZvVUMUvCBZDdWyDDGoBPHhAYTdvPmbzkgtQtAxoxntJns2FrQkUD/D
	xoIvD954+4VWeSVn8zO2+fz7SMiaTcJw/lclGbxs3WKZdpYirP0pjuUuA/7IgJcOX+mfC3W2hgp
	/Iw+u0dOPNao5lK26udnczwzegV4JbN8awcG2oDhAGbrMzXJIsRN5v9P4RCkfSBsZVq+eOcbAfl
	R9dqMNRTHe7Vjv2J2Jm02PYQ9MsvCuu/DHzIFpnNk7379UrJje9SKaMWGCgzaHIto+CIUJqQbw=
	=
X-Google-Smtp-Source: AGHT+IFRlDG35n4MDH7v/SCuYgNy5RJhqN2IH/eGOc1MDtnnqVTwWyf0e4O3awIHjyo7Fk1WiLgD/Q==
X-Received: by 2002:ac8:598c:0:b0:471:825d:aa52 with SMTP id d75a77b69052e-476c93243b8mr162288801cf.20.1742221439007;
        Mon, 17 Mar 2025 07:23:59 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:6895:24c6:e898:e320])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb60b13esm54601011cf.6.2025.03.17.07.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:23:58 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 10:23:53 -0400
Subject: [PATCH v5 3/6] rust: enable `clippy::ptr_cast_constness` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-ptr-as-ptr-v5-3-5b5f21fa230a@gmail.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
In-Reply-To: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
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
 2 files changed, 4 insertions(+), 2 deletions(-)

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
index 7943f43b9575..10c6d69be7f3 100644
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
 

-- 
2.48.1


