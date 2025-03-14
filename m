Return-Path: <linux-kselftest+bounces-29038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF87A61142
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B594C7AFBCB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 12:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B55A1FFC51;
	Fri, 14 Mar 2025 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNnmS+ph"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343E1FF7AD;
	Fri, 14 Mar 2025 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955305; cv=none; b=eIOK4Whk4ljGpDXFkgUjP31y2JeLHddDE+6/fWvgRGJ+JZSX+zetGZRnSMRkLkOS6XdDZOwx4ikGIJFM0op1NVkrfEH5TvpZMUy5hAkytIYRMLwU3qYp9m7ZfYjm6bJ0M5+HtdClARGLRf0TtWxTJqMJic7dL/EMtX53otsCdTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955305; c=relaxed/simple;
	bh=/r0m5YzIWWRQazZFOJwTQSRLej9n6gB2sGQQ7S4a1Yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HFsGC/kftsjflFbUoz0MDH7E+4Ki+1xzAFOfwr1Ay68SWLwZusxHZBhUwUFuaOyrbq+8SJFCfp0Q/63LbcI4r8Gn8PASNlajH478oX1Gvxb0tS5LXEI7uBHY7J3aAh95C3/nR0tNIX/HCh4HSnBbDrMUe4+d6sdEQhTSad+DJHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNnmS+ph; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso30381096d6.0;
        Fri, 14 Mar 2025 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741955302; x=1742560102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pDD8iTOqsV2dG/t13s+olVTpQHy7nswKrZLCkN6NIk=;
        b=DNnmS+phGl+ydHJRo+BqXFbFjEScPmFO3wylViykr32WdkZ1mNHArCS+YqP7UBaQoZ
         iyNKgY+dWvWmfIj7hTtV8A3QaxYH5WppauAKsEEAA0NJkPWzDfbuT+0UN7hZiXDkTTg+
         AiUGt2VYV3Taac9iKvFjyk5whp/AwSJbISDbhLe5DYvDXxL2WYebODYRfAlE/sZN+4yU
         NBsFQLcmvui+M0RDUENhZb+rTfxhg38dmENHQQPLzPghPURrvS32utBwoNOOo7Gfv2Xo
         eDuN17rlkqZrZQNvHprGpd0yOSeJ+otOt0o/vB01HfScP/2Vvah/aGz5L1+KyBSnXYSm
         HyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955302; x=1742560102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pDD8iTOqsV2dG/t13s+olVTpQHy7nswKrZLCkN6NIk=;
        b=bxxcWrfNN+wBYDPfItbwoN30mg1FqT8JAzhvWZnY2LcKiPPCPv2fMj8mQqeXh7eI6w
         VHl7gmwKNKwQgje3HOTicpb4f1BwWEHzQbum5mb+gI8COsaMOhGC67mpLO4VPc/X1VFG
         HXGq1laihh0jthdFjTroCbuKJqdjBR+F8xNNjlECboq6TM+9/98EouMfxKr46XtRK/+Q
         MgUt5GmJVUvGtS64YZJ/pSTYd31ynHRx/nPREue3JwWKY29OrexyA9LhZ4J5AsXvizdA
         q5AmHZuWIXC1kNAibJD0xuOB+e2XQn4XT6AiNfm7XPd4LMfVAmA7QaYMagsKsmbhWaDg
         dUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN0rgIT+H+qJj9Q+Ce0eUMHXzLGUpyLCoFM8DMsd4wu+p5MTu/5F94Yx1tRvQAMFjhA/RusI7GK/hmW6mCpbs=@vger.kernel.org, AJvYcCVLU1h3G6IHQFHUTC8OPlgte3Y3FvLAu9ERnAWOraYPPKOG/Ihys/6HCeRiTFcjK24UE1zf88kjOc2fjuUoac7k@vger.kernel.org, AJvYcCVO9cUXUJoCc+WL3V5dtbn5yEaTMj6Lb9aOZgJoXFTgJZSnj8xtEI1hJVn+Ip4mpL6R2M59MJEt0qTZ@vger.kernel.org, AJvYcCW9V45ZHeKDmi+rkbDO8psjDZenz/hkNz7E70fORemAEoJpYOJ1HNVjL3z08IF11BvcghkWxtF8WNvXb9k=@vger.kernel.org, AJvYcCWFUrt573ILlwjrqcAgLUnKtLfdrP0y4xNmA2dvcmgye59Vi123gxvrtJx0VChGWpvrDmJe1aI8WYPbHLdU@vger.kernel.org, AJvYcCXJXUodoZ/OdrjxvWCVZOi5YqbZzvtAkyeRfVjA+8JCfNIJArKGulesldyEUZNa09rrBht9yMXkP1TQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm9tZQxJoWil9wEEoaCeE6JUJjFPfKQLKLI05mWFkQkqjae1wg
	i4VWRxDGrCSp0GY81LM4ihsJInfetetm2AYvWw/Re7YlNC6KjAOWKK+f9aqq7FY=
X-Gm-Gg: ASbGncvRPs5m9i7AYvbC0uxfh3BLcuIh6wIy0SK7bbQivZ6fe6jwUP/dviFJ7S3AZhV
	7xDZi//1g2cZo6linaVJBdrCh1tnWAQnPWjg9sMjdHUo3edRhgmeul4HQUyR3n+iLLyWXELN6+3
	xO5SrKKpvpuU+D8pDmUCml/ZddmAGylzbzko5usXPMoDyEP/K4CnKq4MfXdHaV4gS1czPei8LLC
	TU56a/R2FkgS7enGH7fwnm1+wN5A620ZJVFkcr/Z8vLuLiQ1lD5eOlA12M276pcsF+uE1JVHQT9
	7O9sXJRdHdTRpoJtZv5pwEck0A/CPD5iJ6gWOP0pbpDlE/KkN4Y8Ls8EGJRK/RdInadb
X-Google-Smtp-Source: AGHT+IG/4iTqsvPQvMpRQNMCVnkOIgAdCvYYH/7ZDiDgMPHIwZ6VA7y3z2XFKZs6w8/T98J8t0jqhg==
X-Received: by 2002:ad4:5aaf:0:b0:6d4:25c4:e775 with SMTP id 6a1803df08f44-6eaeaa0646emr31762426d6.15.1741955302051;
        Fri, 14 Mar 2025 05:28:22 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:cd19:6a0f:e1a6:e800])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb63f3a4sm21905821cf.30.2025.03.14.05.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:28:21 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Mar 2025 08:28:07 -0400
Subject: [PATCH v3 3/6] rust: enable `clippy::ptr_cast_constness` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-ptr-as-ptr-v3-3-e7ba61048f4a@gmail.com>
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


