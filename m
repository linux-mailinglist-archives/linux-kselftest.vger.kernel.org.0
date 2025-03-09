Return-Path: <linux-kselftest+bounces-28568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE17BA585A2
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 17:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F503ACFAA
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1414C1EF37C;
	Sun,  9 Mar 2025 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mF4cgE2u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559671EF371;
	Sun,  9 Mar 2025 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741536074; cv=none; b=Id43l72i40HtBgWKdJFjfhQNkm9ka8QH8KHtAObSBhqnGW89BJy8lIaMpegYeNxhnJKsvvwfBpgm9cUcxU45U+yxDy3bz+S0MKnL1LJcoJl4T325wFMgkG2qw8k4DNfU96aWFIxDrjOTRgelSB7SnAGOVSLU6Lw1czhH0fk7BWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741536074; c=relaxed/simple;
	bh=HxbhEPgqCuwrpYNtTePvfa/ubYGF3lGsbO7lrTt8oKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WtiVeVNRWUbtYfVCSKq0xbEVLtIHwYm5CA8m+GipUpuKa1IsKWCatoDyg9ffE57c30UmdGlFsu30Uk41YRYwDaVMfaeIyJCy64E+Jmr8V7XgQa1WMrqC+UODfydU9HVO33yoL4D2pb1UT2Wcm5P3FD3FVYy2VPpcPiFflp3a9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mF4cgE2u; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e904f53151so14692416d6.3;
        Sun, 09 Mar 2025 09:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741536071; x=1742140871; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7KaSTZS5R2yUcePjN3hlGQ4K9sAZcgJ+NDJtZEjrbo=;
        b=mF4cgE2ubfBIBDr7DurtNPZxtjBf8UJSHjwOvSaUJf8trIr/FX+O5jrYbJqo/4Ag/N
         rE2WUIAN8DSPzuf8SN55L7bCmqFuE/BOMvmUZcUfK4JbHpOg9wt2oPxS96peNJPx0Zrf
         kY0bZbqz5EV2ZJ3Yow8cANWfoA9wS5BEBOYNTBY3dnsA0Ez4WXYr6dbv/h6+Za6dtWfI
         5/X1JPAbxSsl5lVHqO0aWEJwDu0D1wrEwGN4xi7xcNrOqR6QkNekVjH2pDE1sRk0U3VW
         +Lkxo+xY11Clv4Tdj9sZlbE70M8bL7AchzxXfHdojRADM+GtTH443G18sNh2mmWJawM+
         K9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741536071; x=1742140871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7KaSTZS5R2yUcePjN3hlGQ4K9sAZcgJ+NDJtZEjrbo=;
        b=c25hO3E9EBpU5g6dapC20DLB8dMTUI+qExmKLx1MhvnNg116jYm6EU+o+imSjRT/Dk
         9L/+lMBsIk2a5e9J0L+NsljaBRcleAUWk7VOy/zUD9wY9bks4BiR0uaUK8CoD6+wcwZG
         i4MjftyLAJlwl/pBW5MuXMmlGQ5CYYeBNMFXWrN0bcUDC03w2+eGiaYkOSoNf0ZdWts4
         daetoYaqoXLVbeDF9iegI+1WIvE+xWdES/s1cnlmBzox0qsWfnxNMP6ueb7wKDtNDaZI
         hnRPo+iFrzRRb4ZvSRUfteeiI4YACw2tbCB0DtOjJerj5Csog3GOgmmQ0ZvJgY5Iz9ZL
         zHGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPUI8KdfXRsOu++5BH+DLSdxIcCzze+R52vGShTl47434gTgjcXHtswcmDxDfY6USKHaxf6N7pXLKhHzw=@vger.kernel.org, AJvYcCVXgZ1VIzzCJgtBLsyj+vb3NMO1t6SrVBsTgheJCZakSrXeIofONyxGOrPI2d9xO0W2f9KQcdMT4uAwBBFDij7X@vger.kernel.org, AJvYcCVpWAPGg6Ilhm96vnPiocGqYSDV+qMoG6FY8EwOd66wY4z0r58AhzCPqURPRy63eT4i0dgtktgGVvGU@vger.kernel.org, AJvYcCWO8fXf9sPvfHjSyaYHQEPETOXusS/o9ZAabB7vNDqxOJDT0MctIWNkIbkGwNio3I5QrDBkW4Bgdfnksx/W@vger.kernel.org, AJvYcCXhkfml/2aNkrpGk7yCDknNFrPXP4tauezmzjsoTBwyjwv/2UfLfRbUwEVEan95/AEraIioa/i7HFRAeaUvTMg=@vger.kernel.org, AJvYcCXxL5RQpR7VyZzL6JPaxTSrkjCgaTXh6k26+eVD6NBRcEdekupg9OKpLjhrCrkzSN5K83jSEpg3E+L2@vger.kernel.org
X-Gm-Message-State: AOJu0YzruKmkkyUnINe3vGf3jG1LgiTflX1LwCvI+9j/YURi+8mM2LWq
	0/ySn3jUpNkPsKPv2c0Zh4zh/zSSCxs0EPEkah5sZHb4GEovbQVJ
X-Gm-Gg: ASbGncsynP3+qqkSBLuW+i8otoecJ3GtuUgR8HDA7mYkJ4XTqZUYIMd8RvGLrjDuMqF
	7KIV+qReuQw5tdy+y1gENUdbe8G3GXA6AQFun8LsKc7YGYVN8WTTtnzYz2bQ0QhZWUWHWlaAsab
	X5CUtOWjY0TSPjFB4yPIyGNvjC1VyJz5ZBn3qfXEvM6BUY4+lY6OQJQOEhLjErguP098hF9ywBf
	BYoB9qIDpQ04Tt/tyOWr1df+GtvB4yOoPH+1htpVepyL8CpaQsezXqDP+iHwnxrxDDktYQjszBI
	9OCVyzYm1LEVJQBwanQ07ttcgQ1ZXPh6FdqLqOKjUY6bMZELJvGIbShrvJ2XlgtRd+8=
X-Google-Smtp-Source: AGHT+IFJtY7lXlh5gqBGTBs5oIzomrTfGTpZbDYZs0cgMoc/Gx8TBR/rXmP7+drYJX9np1C/LXlUUA==
X-Received: by 2002:a05:6214:da9:b0:6e6:68e3:8d84 with SMTP id 6a1803df08f44-6e9006041damr162266376d6.18.1741536071123;
        Sun, 09 Mar 2025 09:01:11 -0700 (PDT)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534d38dsm512531485a.44.2025.03.09.09.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 09:01:09 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 09 Mar 2025 12:00:42 -0400
Subject: [PATCH v2 3/5] rust: enable `clippy::ptr_cast_constness` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-ptr-as-ptr-v2-3-25d60ad922b7@gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
In-Reply-To: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
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


