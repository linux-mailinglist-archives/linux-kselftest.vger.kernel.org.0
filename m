Return-Path: <linux-kselftest+bounces-26714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F78A36CC4
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 10:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCCE3ADB17
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 09:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40A11A4B69;
	Sat, 15 Feb 2025 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lOX6PmKl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559251A2C06
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Feb 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739610407; cv=none; b=GJx27kxYlqiub5n4LmsVnB7CgIX+9TpYuCVJ0JRALoPl0dQjFss0WPCAPg3Es7am/fIOMsb+A8ZKzXTEYXE3T2jSjRtXoLsAVxdPJSdSgYp5tOS6yKxRC5K2F1WeFd5299w4F34uQUCh+gx9xdVHgFrclMrBz2kFtkBQdgME3sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739610407; c=relaxed/simple;
	bh=Brif0Uu+CgbP+MFCn/3eNgcrnGLZavM1s9AzupsE6jE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EgFYN0KiIHCJwD7voB0Y18kPHsILr9+bkNzpOhFjBCQuYw4McFVdMMVxMTar8oQPrKMtwKk4cPGrFC40Dl2v0R3uiBjbG9C4VuC1Xbiu107G32SgDwaLWIBCxAKL3DdeVeQnVesrx3+9UlrGzcpwAqzBNazstAoAZRPSA/Iqhwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lOX6PmKl; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220d1c24b25so60844605ad.0
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Feb 2025 01:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739610405; x=1740215205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNO63Q8fUF1rvzf4dCO7HftqO6PY/IYB86cB56hZgtY=;
        b=lOX6PmKl2IzOB8A/H3k0Rfrwx4xWA4iGwVyeJ3NURufEtJ/CPJQSnzXa0BnneysS/z
         l638Rqcg4Guj89aCYILmjWmP3aZ5AcgdLh33dX9WhRCxvZCWb9//rH6su2gx1Gf0tobW
         bd3nL0h2pXLLUVD6Qj73badNaLDSN13qvQc/2N8Mv0gMdnzW1iZPrFrC6ijPDzPBUBJk
         EWwPVyIX6tlWZ+t/XsIDdNv0uSJo4mXzrGkiFLAVq4xRZi5CrntgBvCfsvaD4cKxdQYO
         gwljaFQnYZ4gmjlzRWW5d6qFb/vYx0LNBomJSqRySc8Rg08VUuGGaqW/1CsQWIG3lyAt
         ELcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739610405; x=1740215205;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yNO63Q8fUF1rvzf4dCO7HftqO6PY/IYB86cB56hZgtY=;
        b=Xya8s1dcrzWnJycCqJBzjbV8AXkE77utaMTfTsMVawGljfXnxd5isgL38AbGob9SF5
         KI0SvKHgQla3yF7wyQWOJvFoc+39bFZ8EMHU8OJSFhW3ZmqeN6PO/ZwvklMR/B2CwnWl
         FAX9fxF+pcFcIy3sN+7RJOsUeqa7j70rG+Vy5XLecZVuY4Uyxah4FIeM4VXw2HB8K27q
         IVdHuxCfci0S/YL30jYe4r6F/4GssvJU0KSX7/Yepop0w8f2TWvOFhRWUYB9+b03iHK9
         dIDIML1L6C4DQK2jxOqj8riYHaMhLkVtgrF/aFM9D937ICqtlyH5e3P8O3TBRVwZ1CWu
         9faA==
X-Forwarded-Encrypted: i=1; AJvYcCWxB3STToC+1uf8KaeFqRBFG4ZStieWixQRRVhz4qPxt3/jYjwJsq+qjJT/YDgfKmlA4shpLs2NfuUu4rhA6wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2UBOrzP2Xkom1oqREsC3sraGL20Ef4NiT0VqGjM/tMUAfu2jF
	YYER6id757bY4mCfW+nlc3fC8UImY1mx4bxyOeFRVp22ljZIf+9YwwRsLbh+wuEdMSnMfinHAVA
	/BGrlZo1+mQ==
X-Google-Smtp-Source: AGHT+IHtFENxipav4o9tqRA/ja1GzbDCGx7710bdD1BFLEpzmG+fgognz6SYkYpQwhD6qiYIX2BeQfkGlf/crg==
X-Received: from pfbbq17.prod.google.com ([2002:a05:6a00:e11:b0:732:222e:ac25])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:999e:b0:1dc:7907:6d67 with SMTP id adf61e73a8af0-1ee8cbf7a69mr4953468637.40.1739610404506;
 Sat, 15 Feb 2025 01:06:44 -0800 (PST)
Date: Sat, 15 Feb 2025 17:06:20 +0800
In-Reply-To: <20250215090622.2381038-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250215090622.2381038-1-davidgow@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215090622.2381038-4-davidgow@google.com>
Subject: [PATCH v7 3/3] rust: kunit: allow to know if we are in a test
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Rae Moar <rmoar@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Tamir Duberstein <tamird@gmail.com>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>

In some cases, we need to call test-only code from outside the test
case, for example, to mock a function or a module.

In order to check whether we are in a test or not, we need to test if
`CONFIG_KUNIT` is set.
Unfortunately, we cannot rely only on this condition because:
- a test could be running in another thread,
- some distros compile KUnit in production kernels, so checking at runtime
  that `current->kunit_test !=3D NULL` is required.

Forturately, KUnit provides an optimised check in
`kunit_get_current_test()`, which checks CONFIG_KUNIT, a global static
key, and then the current thread's running KUnit test.

Add a safe wrapper function around this to know whether or not we are in
a KUnit test and examples showing how to mock a function and a module.

Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v6:
https://lore.kernel.org/rust-for-linux/20250214074051.1619256-4-davidgow@go=
ogle.com/
- Doc comments now have a useful link. (Thanks, Tamir!)
- A small tidy-up to limit unsafe usage. (Thanks, Tamir!)

Changes since v5:
https://lore.kernel.org/all/20241213081035.2069066-4-davidgow@google.com/
- Greatly improved documentation, which is both clearer and better
  matches the rustdoc norm. (Thanks, Miguel)
- The examples and safety comments are also both more idiomatic an
  cleaner. (Thanks, Miguel)
- More things sit appropriately behind CONFIG_KUNIT (Thanks, Miguel)

Changes since v4:
https://lore.kernel.org/linux-kselftest/20241101064505.3820737-4-davidgow@g=
oogle.com/
- Rebased against 6.13-rc1
- Fix some missing safety comments, and remove some unneeded 'unsafe'
  blocks. (Thanks Boqun)

Changes since v3:
https://lore.kernel.org/linux-kselftest/20241030045719.3085147-8-davidgow@g=
oogle.com/
- The example test has been updated to no longer use assert_eq!() with
  a constant bool argument (fixes a clippy warning).

No changes since v2:
https://lore.kernel.org/linux-kselftest/20241029092422.2884505-4-davidgow@g=
oogle.com/

Changes since v1:
https://lore.kernel.org/lkml/20230720-rustbind-v1-3-c80db349e3b5@google.com=
/
- Rebased on top of rust-next.
- Use the `kunit_get_current_test()` C function, which wasn't previously
  available, instead of rolling our own.
- (Thanks also to Boqun for suggesting a nicer way of implementing this,
  which I tried, but the `kunit_get_current_test()` version obsoleted.)
---
 rust/kernel/kunit.rs | 66 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 2131443a5f1e..91aa49da0265 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -286,11 +286,77 @@ macro_rules! kunit_unsafe_test_suite {
     };
 }
=20
+/// Returns whether we are currently running a KUnit test.
+///
+/// In some cases, you need to call test-only code from outside the test c=
ase, for example, to
+/// create a function mock. This function allows to change behavior depend=
ing on whether we are
+/// currently running a KUnit test or not.
+///
+/// # Examples
+///
+/// This example shows how a function can be mocked to return a well-known=
 value while testing:
+///
+/// ```
+/// # use kernel::kunit::in_kunit_test;
+/// fn fn_mock_example(n: i32) -> i32 {
+///     if in_kunit_test() {
+///         return 100;
+///     }
+///
+///     n + 1
+/// }
+///
+/// let mock_res =3D fn_mock_example(5);
+/// assert_eq!(mock_res, 100);
+/// ```
+///
+/// Sometimes, you don't control the code that needs to be mocked. This ex=
ample shows how the
+/// [`bindings`] module can be mocked:
+///
+/// ```
+/// // Import our mock naming it as the real module.
+/// #[cfg(CONFIG_KUNIT)]
+/// use bindings_mock_example as bindings;
+/// #[cfg(not(CONFIG_KUNIT))]
+/// use kernel::bindings;
+///
+/// // This module mocks `bindings`.
+/// #[cfg(CONFIG_KUNIT)]
+/// mod bindings_mock_example {
+///     /// Mock `ktime_get_boot_fast_ns` to return a well-known value whe=
n running a KUnit test.
+///     pub(crate) fn ktime_get_boot_fast_ns() -> u64 {
+///         1234
+///     }
+/// }
+///
+/// // This is the function we want to test. Since `bindings` has been moc=
ked, we can use its
+/// // functions seamlessly.
+/// fn get_boot_ns() -> u64 {
+///     // SAFETY: `ktime_get_boot_fast_ns()` is always safe to call.
+///     unsafe { bindings::ktime_get_boot_fast_ns() }
+/// }
+///
+/// let time =3D get_boot_ns();
+/// assert_eq!(time, 1234);
+/// ```
+pub fn in_kunit_test() -> bool {
+    // SAFETY: `kunit_get_current_test()` is always safe to call (it has f=
allbacks for
+    // when KUnit is not enabled).
+    !unsafe { bindings::kunit_get_current_test() }.is_null()
+}
+
 #[kunit_tests(rust_kernel_kunit)]
 mod tests {
+    use super::*;
+
     #[test]
     fn rust_test_kunit_example_test() {
         #![expect(clippy::eq_op)]
         assert_eq!(1 + 1, 2);
     }
+
+    #[test]
+    fn rust_test_kunit_in_kunit_test() {
+        assert!(in_kunit_test());
+    }
 }
--=20
2.48.1.601.g30ceb7b040-goog


