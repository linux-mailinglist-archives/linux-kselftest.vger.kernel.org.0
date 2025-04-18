Return-Path: <linux-kselftest+bounces-31132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8747AA939CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 17:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C353F1B66AF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6501215064;
	Fri, 18 Apr 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo/Zqu3s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045C2144B0;
	Fri, 18 Apr 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990651; cv=none; b=OWrQnONuKNCsekpyPCdrjuE76tSFjoWk+FPprPtx6yVqZZCIe49ic0Ze2V2KhYxF+ctBiDA0cBelXXgUOlN1qm/odRXncG2/PenxUUwFSxzBvNPmOd1BxFvMmrXybTwLy8RFifvfWp8VoDX0eHVnfU40DnvZ+RImWFgxnJslogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990651; c=relaxed/simple;
	bh=Fm7MgeesW7TKpAVweWa2ZIUM9CTzCHG83W/gghqXVSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q3T/4qbNCNSTVfA/UQI+FnoOJDEtO0T/vfPmm8O6aTgislPq5162SqZTNUDbyc4eBHQi57hCfrO5CnDew6B5yUSYWQ24i+vCktCv4Qhnc4DYQUgQvBfKxOHaR9raOnAdzqod85co1UtAETU3nNfHgTC0DlnY+tryXLswIPYuD3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo/Zqu3s; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8fce04655so17775466d6.3;
        Fri, 18 Apr 2025 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744990648; x=1745595448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaSAJ7bEVoobZvX7s9TBRwmAW2KmRlOmxaaNZas7vsY=;
        b=Eo/Zqu3su9z+UBQjq5g0V2zTSb2KAMgM1hOswm0VJU9JVHn6VrXoqO6R14U+qP6ZL5
         E/xdFaimf397vjhB+8wFTNin08OxmPmfFYUkt2JE31XqawIICaIMFJMBgLpUGx+5UCun
         cmDpmetJjxAl8wlJ6YmJWH4OEL2lZREEEAZBN/jMEoZ6hPq3wGoLYmUTEKkjpOAW/59Z
         yevSXCc+/o9FA8LW3a5NMR2QkjAYrTBEdjbdVi31YO3NO1KokNYZU7U1lGIqsL008ZP5
         22OAlRy7jp83Q86+0MkcHwF06XCjW3XDBrpR+NXyjjcQurJYxbrFhowUfuCtoRJ5bN2n
         +7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744990648; x=1745595448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaSAJ7bEVoobZvX7s9TBRwmAW2KmRlOmxaaNZas7vsY=;
        b=jEixrnHlIppbMKHIfzvL6ljjtyzDzM6sB7oZXkHtQm3Sb6jKl0t+93mn/lbBY9OVw1
         m9tdm+70wKSKK2mvl+1E2xzlxAYdZZit2fbsCyAJSka4WD60P2xfDP727LP6STufHhg7
         eX5jOijWw/PQ/akyGQhsFiW9oAK/2J+jFHD5fCX/d9jv/w1SsVm2urvtcwXC7jyQxzKb
         gkj/kFKVQzRwk0FXz39zX/8l94IGcJfqu2yvWqm0JV0TPpsyxIn7M7j4ax/29poqhwX8
         Lj//rjfXmQDzzIrMAXqbOVxzDAqakEkFaA3XpI5+MPOUXycePk9ko5MexvnY3MrcpqtX
         QE1w==
X-Forwarded-Encrypted: i=1; AJvYcCV3K6Hv9aWjyXSf9lHfSS56ZLu6UjgAiownEZCbHZaDqua2DttZ4cZKJ1HasFyJmJxKQMqCvG0L0oMwkpE=@vger.kernel.org, AJvYcCVKHaJISiDpUaGTDi1f5eGUN7UKPubse6wjP4IuYAwpqae35QVS0VY8kkcVWYm9cvJahy4JMQR0SxQcb/lM/1Je@vger.kernel.org, AJvYcCWL0KxWGq9tCUKCRyhJw5FEAWYK76HzK0ofnhDyQHTgK1i/xH249bcgEQUefsfqixILwQUe/6byv5fnTOct@vger.kernel.org, AJvYcCWXHyxGC56R5lQyzifgexk5nzZ12ANanTnNBLhAt/RoerFCg/bX8e5OgRimXQ29XPknxkODWwpDdJy5@vger.kernel.org, AJvYcCXCIMtopg0OnjMMcJL1arNTAwqlzoiq1fuUBE9jVyjdelOqF1oq2CtYhSFJlYDqytL4b1iattzo+a3x@vger.kernel.org, AJvYcCXhIzw8Xij0IJ0PgwhTgdrYAyFt/rmMoW3qpTFdMUKgIEkgOUJBia6oDxoGWuv48jpeFUYQojgRvVJj2cLM4ok=@vger.kernel.org, AJvYcCXmOdVDjXwytxb7A9F31vv/2OGY+TDQtfwFmDml8CLroR1ga/knV/dIIBcRGGSNawngpgYN0X4c@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mg4kOJL44NWrR6eRrRpg9ofh+aW3nBF0bWH1sz2FiNvbtBYm
	Xaze7Ot253AeQ9sbOR2kWhmii/FsLJM5A22OuMdp44I7cLmhuv4n3tPS8l1e
X-Gm-Gg: ASbGncuJe3BmbWxjdamUs2VyaI6Kqcr5ZPGZxtbSw28+E2YsVtFphZuSs4mbHVWzbes
	1hVxMxzKgDp3hMs/jtcHjVqQsLdLNrm51eUaAvcM9ewbZXb7HcYuIFdaMVH+DcQZ+ddJNFl781u
	jtW/mu5QQxNCIZ7jdtmoP4m38X4LAo6duRgkOfdhuHNNmyAi+xN/O3hLAMtsa0vmNarBKTZ3qoM
	uErJ9OceJNntSfUu+sqkulJFPqtmkp6tHFIb8v0IzyolAxF9o2Z5VbN/3OdMOrACxwvjRgamAbF
	8bMu/C67xKCl2Lk2lWAwrEtrpn185xTWZE8ybg0vp5WXWTOjfVl5ig8hAeefQsNs/N+k/Q==
X-Google-Smtp-Source: AGHT+IFkQhTRZqjW4xV1jKnWgn/NCzOB5gSq4F6ybTimLrSF39Hn/Jekuc0wYec+k9hEc3zjpAc5JA==
X-Received: by 2002:a05:6214:1251:b0:6e8:fa33:2969 with SMTP id 6a1803df08f44-6f2c4539b53mr55537496d6.10.1744990647730;
        Fri, 18 Apr 2025 08:37:27 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:7988:e5e5:1f4c:be78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c21d9bsm11623096d6.96.2025.04.18.08.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 08:37:27 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 18 Apr 2025 11:37:18 -0400
Subject: [PATCH v10 2/6] rust: enable `clippy::ptr_cast_constness` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-ptr-as-ptr-v10-2-3d63d27907aa@gmail.com>
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
 2 files changed, 3 insertions(+), 2 deletions(-)

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
 

-- 
2.49.0


