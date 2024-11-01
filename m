Return-Path: <linux-kselftest+bounces-21282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A59C9B8B4E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 07:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8051C21E5C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 06:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D569155A25;
	Fri,  1 Nov 2024 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0FBm8o7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CB415535B
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730443527; cv=none; b=Kz0a4fzMRCQxx74rYbzyZcG+ErIMxpe1z+JXbGh1prKvijOkfnZoBW3iSKgl6jg2x+Be9n2rTYHm9sfSEXPL1QUxjrs+doBlVxijyQtqn4unV4b5i4Rb7+SojcR3G729f5knEZRvngdEFeEWUgRk9vkSr9z0K9c3wIegimuG+lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730443527; c=relaxed/simple;
	bh=f3EQWER6RRuCLdLa6B3j/75NplNWzvD63Oagrzez9Kg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oviGDYZdaCf4TOLFtTm6UqX34KadZcqVHF7IVAgGXPvRM8qcfoSZeUY19O9/cPz9jNYQWnUpXsnOGBmwi5uviDzTgstF1+7j1EmlJx2/+NmI05Tb8foP67i6/9+peSfAaR4ZHQz9PQdIkBeTMeSqAdddAdX6qah6g/KugU1zIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0FBm8o7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2e3321aae0so2862898276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 23:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730443524; x=1731048324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHPJiykftORb/g35WFmCs+9SKBvzp/KNUqXI3sEF0e8=;
        b=H0FBm8o75WDSOJooUUCigqPjMN3jae5MqpmZunAzEgBkm6gJ5vbwxfhq+yKMVTvleH
         6Wgc5bsj7iVTFbtCt+xBIQLohnIL68AQJlj1qtD2tuOWBWCEoM+xXulN5cF4PDavEGjT
         BY3iD0BkUqTXzoI9v4K8gHp+Qp4x4AjYPCahqf/m5gHnOqyBhEp/CkzW1oEVfjNisAqz
         wfUiU2PkB8X1C7hvzk/t8mLIIkNJF7zclY3M81JI/p5sFJGBYJkXON/ktQbhrN9B7y7M
         2WnqMp/HzSgCZd6JAaye4Pstz2ghkF63RktuA11RM+OwsWsIO85tgTCTNX70ivF+CbYD
         o8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730443524; x=1731048324;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lHPJiykftORb/g35WFmCs+9SKBvzp/KNUqXI3sEF0e8=;
        b=e7WeBX4A/kNZjxVb02GhHV+Bv0Ut2qMnId5b7oOQUfLrVezRyqhhu3NVf8bQf91CG7
         aaOMitYc7EWWBQr4u8+yILT4xCAxogoheAWFAisjyuxC7GZcQygxOSl7i4YoMqe3M1jc
         9urY5+kw4NFsQn1e+yj57KcaL2Vf6tavA86XcmDU4CntuszWyQUuxUBRrHvnozqRk+OE
         O4pWYzX5Z5iDX+z76rTV8IfSCjiUgWED1jDbK0Q3z78eZGrOmBgH8dHfJp1GWXsaov3q
         uj0j+W/neOHqcTE2xQCOwsBCzm86y/GI2yY+81edgi9X5+Kr4qaJftgTW9+dV9N1iw0n
         EJLg==
X-Forwarded-Encrypted: i=1; AJvYcCWi7pnEI8gYWk9N5UVkHDF3uFo4iqJc9UI/EVpKc1wAk1wNFmbPllX5OAP9P3yk8I7AU2TW4eBRr34O6MSHMCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLdPZOSp8IJNHGOzj/BcdeoTpJr68LL/hoLA5s4TgXEKxBJ8r2
	q59D2wOssl5Ajwr4inZKZWnxqDGkMHjui4B9hkdmwdca/6EDwA21zmOlIZ7tCoJlUo80fAyrMs7
	TKzWvOh2Hmw==
X-Google-Smtp-Source: AGHT+IEIXo3M6l3NU9Qv2uOCk9CnzdlHFgd4U1XPtBHdD4Ek09zM+pvRo5MbMvTvDW7Nu3Tut9Zu4gtndT2qHg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a25:aa83:0:b0:e30:c235:d79f with SMTP id
 3f1490d57ef6-e30e5b282d1mr2857276.8.1730443523956; Thu, 31 Oct 2024 23:45:23
 -0700 (PDT)
Date: Fri,  1 Nov 2024 14:45:02 +0800
In-Reply-To: <20241101064505.3820737-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101064505.3820737-1-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241101064505.3820737-4-davidgow@google.com>
Subject: [PATCH v4 3/3] rust: kunit: allow to know if we are in a test
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>
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
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

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
 rust/kernel/kunit.rs | 72 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 71ce1d145be8..ad38d6d62446 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -276,10 +276,82 @@ macro_rules! kunit_unsafe_test_suite {
     };
 }
=20
+/// In some cases, you need to call test-only code from outside the test c=
ase, for example, to
+/// create a function mock. This function can be invoked to know whether w=
e are currently running a
+/// KUnit test or not.
+///
+/// # Examples
+///
+/// This example shows how a function can be mocked to return a well-known=
 value while testing:
+///
+/// ```
+/// # use kernel::kunit::in_kunit_test;
+/// #
+/// fn fn_mock_example(n: i32) -> i32 {
+///     if in_kunit_test() {
+///         100
+///     } else {
+///         n + 1
+///     }
+/// }
+///
+/// let mock_res =3D fn_mock_example(5);
+/// assert_eq!(mock_res, 100);
+/// ```
+///
+/// Sometimes, you don't control the code that needs to be mocked. This ex=
ample shows how the
+/// `bindings` module can be mocked:
+///
+/// ```
+/// // Import our mock naming it as the real module.
+/// #[cfg(CONFIG_KUNIT)]
+/// use bindings_mock_example as bindings;
+///
+/// // This module mocks `bindings`.
+/// mod bindings_mock_example {
+///     use kernel::kunit::in_kunit_test;
+///     use kernel::bindings::u64_;
+///
+///     // Make the other binding functions available.
+///     pub(crate) use kernel::bindings::*;
+///
+///     // Mock `ktime_get_boot_fast_ns` to return a well-known value when=
 running a KUnit test.
+///     pub(crate) unsafe fn ktime_get_boot_fast_ns() -> u64_ {
+///         if in_kunit_test() {
+///             1234
+///         } else {
+///             unsafe { kernel::bindings::ktime_get_boot_fast_ns() }
+///         }
+///     }
+/// }
+///
+/// // This is the function we want to test. Since `bindings` has been moc=
ked, we can use its
+/// // functions seamlessly.
+/// fn get_boot_ns() -> u64 {
+///     unsafe { bindings::ktime_get_boot_fast_ns() }
+/// }
+///
+/// let time =3D get_boot_ns();
+/// assert_eq!(time, 1234);
+/// ```
+pub fn in_kunit_test() -> bool {
+    // SAFETY: kunit_get_current_test() is always safe to call from C (it =
has fallbacks for
+    // when KUnit is not enabled), and we're only comparing the result to =
NULL.
+    unsafe { !bindings::kunit_get_current_test().is_null() }
+}
+
 #[kunit_tests(rust_kernel_kunit)]
 mod tests {
+    use super::*;
+
     #[test]
     fn rust_test_kunit_example_test() {
         assert_eq!(1 + 1, 2);
     }
+
+    #[test]
+    fn rust_test_kunit_in_kunit_test() {
+        let in_kunit =3D in_kunit_test();
+        assert!(in_kunit);
+    }
 }
--=20
2.47.0.199.ga7371fff76-goog


