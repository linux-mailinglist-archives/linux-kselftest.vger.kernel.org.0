Return-Path: <linux-kselftest+bounces-29130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2F0A62C73
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 13:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9287D189BDF9
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 12:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2007F1FC7D4;
	Sat, 15 Mar 2025 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVyrdJUL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489BC1FC0EB;
	Sat, 15 Mar 2025 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742041060; cv=none; b=GmGLWLxp4Q6sFpDEMDSct8iIzPt6jFVvKpC006s9xi8D8fydFwvZS8BAXC+FRHdFkUdezDuVos0LYj4Ijk93lEf1auMcZH+fhuBYniRjoJPZSoU0w/OEiyPbuE3b1ZL+idkApTUq+s/tnfk7E/jWrf4Rik2/5ktkMZ/Q6Z/Ga0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742041060; c=relaxed/simple;
	bh=/r0m5YzIWWRQazZFOJwTQSRLej9n6gB2sGQQ7S4a1Yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YYAxWIJfLTnAK/qtVpIlPGo8SA4GjZwKhpve+OZlzd7TuKUwJ3L+TE9MJUApM+IMMj5S8LUnx7T3zMBWyVmCS83Iqk6bgVk91LpLiFCBIze1E6/7BMFLrsASVVqUqxYcP23WIf0/F2sLyLzQqgZkyFy+0xVHclQSSJsAUjcDNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVyrdJUL; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c559b3eb0bso178412085a.1;
        Sat, 15 Mar 2025 05:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742041057; x=1742645857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pDD8iTOqsV2dG/t13s+olVTpQHy7nswKrZLCkN6NIk=;
        b=QVyrdJULlr/xSLFugkS9sHH6tqR+KeRmNKyFM+hBLR/ncVEkrlqb82+hKBMur96PF0
         gu3P9Ezn32dFML+b1CYc64GCMTk0vFQY+qywz8H7+nedrbNNAtkDw3RjUbAbo5XyABzS
         7K1+8CNzLzf1+Fs/Ly50X3UvgMBn/fEbfrw9urqYujS6gdJc8Lyf4rNVk0j/N3bker+L
         rBYyyuv1lNh7rnPrcusb8JXvvYfxERt871WzH1gDS6rGxuU/TCX7QF/78iJ+dICnHHov
         rRgR4mlDFJbbJ26fTUB5Wic36ohdRkCN/K1TNo0lLXinkvwpq/Mk6UEto/rhwj0Y4/73
         1EIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742041057; x=1742645857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pDD8iTOqsV2dG/t13s+olVTpQHy7nswKrZLCkN6NIk=;
        b=kjv9HWbSXvdJBkDi9bbFqyaKk129HTFguYgogZHFLkfktutss9kAclkBHVYPVlmv5z
         HaPvyhfMiGur5i2fMBjomie4zwf9AIUi8D5QAStlVEt7J3k0h2oYC24tKQWnjhoqwE5m
         nnEvmg4NDznSHmJteK1hrSsa722B3Vg52aX9i7oQVhXZ0P+0UNgx2lRYEnX1dxCeAiJj
         7pUSOxNw8s9xxuQ86pUZ9g0LLLKOIGl7Rlq1UxYFS3S6K/WACZGcyPZBa96V7R22hXrb
         m0WZwKDkIuKCpWi6JfQWvx56kcWwVnh7gyDO9rOKdL1lMjGionvJuGfoK5byilN7BduA
         /Apw==
X-Forwarded-Encrypted: i=1; AJvYcCVbH3j3CUQAsumdwcrE6M1laubacITkMRqo2drPgQ6IyeF5KMzk3b1Sro7vZo7fZrrjofgphqLhiwX+l1A=@vger.kernel.org, AJvYcCVcP7ofIF/Oox6Ce1HAoM2gBQFcSJpZ45yqC1cPIsfqWDcGZB7nXnHYcD7JblFvPeg8jmrq4SaBfYQ/@vger.kernel.org, AJvYcCVfV+9mycxOoaPp40b8I1EZcGLZXKUDrdBc/2bKFDFcHpf+mG5t2hyZ0OV2ur2I0FedVXk2z9m3YaL0pzwAeec=@vger.kernel.org, AJvYcCVzBx+6RNNFFcT4srVgBlVc671QGnNq25yAcxAGsFP2BKz7njvCtWgq9YHKA3di0AVS09hcWPfZk5yu+jDZ@vger.kernel.org, AJvYcCWmH2hnRafR+H8ZaIxt9HyOP6AouxSLTdV1tbR+wfxbXJP9LCfk/3CRAhiZXuZklR6MZEuELJ/myD3n@vger.kernel.org, AJvYcCWuvwAqfA1ZRcdNaI4YfxyKRlXPyCoxjhND6Ns1qMkeDcnSIuVNUAGrPSCQRdTrg00d17r7uNQq1xKtxRUySfVw@vger.kernel.org
X-Gm-Message-State: AOJu0YyRl0COl45eG7lHtwTdZHVWaabn9MSCx3xUKcKqgUj9q6NPRA7j
	9E1GQ0mhQ5kazDBLH123F0uOQtcoUciI3tAmlOCWFu2U94M6Ftlk
X-Gm-Gg: ASbGncuDYlVmV9lGLs6HEsyVWgtHwWEFiHYgw2MeWxAXeA6wUX7SapIfcHIQemBtHqG
	rI4mY3bKm00jF2NqkEepuWPhRpgtMD5pxyNItxj1I+Qrm/JX0yaFC5D5Vwm1FhwUt1xVDk8YVBO
	eUuWlJ4Kin6slE7goydHvbGEWINGqO7H8U2VXTcKctae3+hA+PWWch1ss+0lV35r/1TwSVOH9MQ
	M9OLecVPwneUWlYwWb1HYn4p2tQhHybhLM1Fhqlg6P473WUrzazgP4F5296s7yxpbT50kCXUoHX
	qjRmEeUHRP7DhKPCp2eN6Jcv5Doqqa3AO+k0A43hAwZL+k1FPfXU3Fg5phX4JAPHDmqj
X-Google-Smtp-Source: AGHT+IHUekxau7xPaW0+KxmpDa26nJyHAMk6CCMOp1FyRE4XYEfSDw97ppwK31w6YhjIZwLpPqNs2Q==
X-Received: by 2002:a05:620a:46aa:b0:7c5:4349:2f19 with SMTP id af79cd13be357-7c57c8f0c02mr1066084785a.49.1742041057002;
        Sat, 15 Mar 2025 05:17:37 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:cd19:6a0f:e1a6:e800])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9be48sm371885185a.60.2025.03.15.05.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 05:17:36 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 15 Mar 2025 08:17:27 -0400
Subject: [PATCH v4 3/6] rust: enable `clippy::ptr_cast_constness` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250315-ptr-as-ptr-v4-3-b2d72c14dc26@gmail.com>
References: <20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com>
In-Reply-To: <20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com>
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


