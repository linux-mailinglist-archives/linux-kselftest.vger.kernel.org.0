Return-Path: <linux-kselftest+bounces-26637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B63A35812
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 08:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AB41891C6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 07:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3988F2165EA;
	Fri, 14 Feb 2025 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DNipiRVN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F42163B9
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518881; cv=none; b=RGusANHIlRjESoGG8vWUoc1wQ/8U+1bXK9TjIQKskcUtjbzoS50N9+fiVVoCZUQuJOIKFC4c7Pz989UE1xj1SSBsNnrZx5gacjR/Ft33jdloqaMR/LucWOvsVqNrJkT0DCE/fRPjVES75fB4hfICB8dDvFliPh7FC96WkH3Fi2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518881; c=relaxed/simple;
	bh=wu1wYChkKBa84U+/lJlhYvBmiPd0MNbKVAR64OfX5YY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RBfuCQj/NfBoo/M8nwZo4gv7rp0AuXQ/6G1NQ/KJoc5cY4XMcDapJKp1QwSvJUqB2EWIXbIa2KO0s55a2WvYfzD8QZRznHCQoA48kl3ovO4zjwUXYwmNYPsDn231NuxLO3qbYx86dxaOCEtL6EwfVPk3vBM5lIqpHB2txn84QsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DNipiRVN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f9da17946fso6172300a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 23:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739518878; x=1740123678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qphj6TWjxMj/gif/4tS2O4Kyyc5IbUJk5s6oYOqOgqw=;
        b=DNipiRVNYB5pwNKT4xxWREnjPu8+cRIck/NsOReDCVUB/dd9nFsF7CYobqTL09s/ox
         ufdCPZ7f7liktb9ILmFVKMAYFHKBUYZi6RB8lJmLMfmRjMmYZ8Z6aVOhdjtMiNSX9hQ+
         3+cTsv8kfkRXnskVEaflpOVHC7cKfhTMmFNZrBrult+S5ZMJ670L1wG0BjBEcGfie2O4
         Rz2vnD6a9KQKKRyxQ+RdlGqQSRWjxyI5NPvzQorv8d8Z877Ga8WqxJN5PMaDJwrfhyMr
         6rbRXVInHHZi7HmXO2qed4dx93bNvBcI0S+0LEmcoBa+Tm6PVc2ijJ2ww/zrImMjkabj
         8A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739518878; x=1740123678;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qphj6TWjxMj/gif/4tS2O4Kyyc5IbUJk5s6oYOqOgqw=;
        b=cTuzb534HNPM+3yqUf00Qtwrj4xWaxkBDz7FaDn4YlGYVD4a5C+EmL183L3WDoKXzn
         cpb4OyQ7B406J+u73rtip6l1/nhaj8erydam9yL8/sRgQYwgmZlgIrTDdKducR5kJCtr
         qp0mhVB5Z76BhZKFeUyvrlztPThGb5UEraIYergsdZaTEVQN2IwOvpjFmmalEHfpKfwQ
         xahZIBL/VY7fc7dsNsaWRPDKl1RoDMbAXdlhwfDzMKCxYB4cNTaY0KVmYKStaVa+7TXW
         GUVjqhocen11nh6qwsgoD41EZRTy/U3hBy6DVGe3RyZgy3DVxhDyRrCKtWOgQCjvlSKo
         QTuw==
X-Forwarded-Encrypted: i=1; AJvYcCXm9Ha6fsnpweVmjCsfUIlXYt2HkeTs7IsYGNx1FCkrJQf7hQAY7i9o9dx6sIcgT5i5gAHTT13yGQtJQkDrRr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZlu/UHnk3pEzJ4HEwEaG5FnOA511k7/YH12GCqmUGZ8PzdLkq
	j17g0PYTLsZkS1qHxvmXkg3RcB/8NW96YuoxTXwiOSYLWZZfSfXICkVeCztX4nV45YHe7rlYMkN
	e+9lJ9WpVwA==
X-Google-Smtp-Source: AGHT+IFgeVopjebWDLNzibTUdu5X7StXLo69muuWXN8z+HL8PoMGaE8j2OZtBwMk7ckUhoqyVUCJrBYQdPwGMw==
X-Received: from pfne24.prod.google.com ([2002:aa7:8258:0:b0:730:8518:b97])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:98b:b0:732:1bad:e245 with SMTP id d2e1a72fcca58-7322c37ea39mr14491448b3a.7.1739518878328;
 Thu, 13 Feb 2025 23:41:18 -0800 (PST)
Date: Fri, 14 Feb 2025 15:40:48 +0800
In-Reply-To: <20250214074051.1619256-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250214074051.1619256-1-davidgow@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214074051.1619256-4-davidgow@google.com>
Subject: [PATCH v6 3/3] rust: kunit: allow to know if we are in a test
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Rae Moar <rmoar@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>, Brendan Higgins <brendan.higgins@linux.dev>
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
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---

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
index 9e27b74a605b..3aad7a281b6d 100644
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
+/// `bindings` module can be mocked:
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
+    unsafe { !bindings::kunit_get_current_test().is_null() }
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


