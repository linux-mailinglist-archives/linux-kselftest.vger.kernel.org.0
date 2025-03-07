Return-Path: <linux-kselftest+bounces-28465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF90A56334
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 10:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019061894FD3
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189C8204C28;
	Fri,  7 Mar 2025 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s73t25w8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7214C1E1E06
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Mar 2025 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338311; cv=none; b=L6qnCL6QvOq38tS6rDC5C7gFXlKcTQUyi0lDbQc8bv9x42hSNnM/cQR6f3ExD3M3F6X5S+I+0tkYZE+BxkvyE8yKfx77aHqGvx+AvANrBTJSUCLIG8/MQBqabA7xbfVbxaz2YUCTzVKItomnAoMnV1U5EATE/hxwBzK1lMfHr38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338311; c=relaxed/simple;
	bh=sIgpg5Z+kT4ZxmXKrwRqNpariABEca6JU6hGPKgiICg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E0JwSoN/eFd2WxMhcBCnsTEiXa+pZkEm054t4cq4DUGghZAUUuYR+pK7CzY0XW9zgshhlmuGEO6byekS1cmhJwAeeQc91PUkqcWyHXLySz3lEe/bwWufC7lKGp2VC/+m8D3ibDYq3IWtavLF6W/ZrJmxw9ZnBeCBkfFshGWfEBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s73t25w8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso1412412a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Mar 2025 01:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741338308; x=1741943108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRuk23B1HYGUDb1k19WG8K3aurYaMSpuYJ0SBDb3Nis=;
        b=s73t25w8ILowIGPNhtVATVkiv6a1IqrQug3t+eZAkgSMoU+3IWHx/U8+1CY0+JHVmt
         62V1eBTK1ffjiguIhObFhG2Q5XLmvPnP2xNbNce23Fkdk6lSKzF+m2k2vBHtVdlzC0ml
         yShcae8msH1WBXMZHgWUrLwH/+IhEIHqzUPMBnXa7MauK7y89GnG1zV4CPQS7rrmhFV1
         0hh8RHu7ptgJkyVW0kZRWA/f1hOcf/qB95vPGxJvsNBrZDXHk4l/Ht+MHEZ5NweVGXwL
         qBKSMrKAYU5SJEITdlprifqJKl+7XRUoJgRfJEHHv3KgyQX4HRSbih8DmumcW634J9ri
         PNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741338308; x=1741943108;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zRuk23B1HYGUDb1k19WG8K3aurYaMSpuYJ0SBDb3Nis=;
        b=D7sxmIe4iZTebMps/i8WLf2fK8rjqFgyfE9t07X+xP1db8m1vwmIWVjjkrUD2QWadH
         +GjDu8rz2wwHnzx2qV6cuMsRKnYuwaOZSxo1rc9SAu56qDfEeiM1xheztWdwOw0YuLyy
         2d2QPbX/ZEuKw5r26kKQUyPJir0ca+qX8yXioWLXxQ7yQrD8Hs8MeXI48EmWfki4qQLU
         7LM3kBjcPliGMBqLfihupeiTova+bAX8ADm5YsacSLGSUM8Udbx6Cs2PlicvTWNzsgzK
         +3DtPd3Vd1vOw2/9KSaf60K95nJhupcewCc8YOCtFLVF36Su5Ib32mwinOguMKSKYMID
         +zeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0Cm+z4DEttp5pHv7F3o5QYGAe+Pf0SQh/O3oFrFQVq+t3yUf1W6TztmjpBE3ttbJLRKzmVBBVj7asDfOyURw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb6A8agJVKcprQ2GqFKu5q+YDJbyhO0G9CJdYSwVXEmtc4I+VO
	aJWjbSiUXlKurhXeAF+jMiJQImZx6e6hA1qj6pYhmk6xVo8B431YvJiVUX7RabHTFJkby7/UBDg
	M6KHt2ivQwQ==
X-Google-Smtp-Source: AGHT+IEMh2qJqItWBdivwZ20S1IgBdnlDDo2ThbaF/uKAWdN2IAz2GUfOQGkeHgejgR3WFapaEocrzpWeyAa/Q==
X-Received: from pfie21.prod.google.com ([2002:a62:ee15:0:b0:732:6425:de9a])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a11f:b0:1f2:f1a8:fbc8 with SMTP id adf61e73a8af0-1f544ad7265mr5374068637.2.1741338308594;
 Fri, 07 Mar 2025 01:05:08 -0800 (PST)
Date: Fri,  7 Mar 2025 17:00:58 +0800
In-Reply-To: <20250307090103.918788-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307090103.918788-1-davidgow@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307090103.918788-4-davidgow@google.com>
Subject: [PATCH v8 3/3] rust: kunit: allow to know if we are in a test
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

Changes since v7:
https://lore.kernel.org/rust-for-linux/20250214074051.1619256-4-davidgow@go=
ogle.com/
- Remove the second example, which shadowed a function in order to mock
  it, as it was (a) unclear that it is only useful for code in the same
  file as the test, and (b) didn't use in_kunit_test(), which would've
  made it more useful (but still limited). The first example should be
  good enough to point people in the right direction for now. (Thanks,
  Tamir)

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
 rust/kernel/kunit.rs | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 97e99b52e4a9..7388fa831b8e 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -288,11 +288,47 @@ macro_rules! kunit_unsafe_test_suite {
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
2.49.0.rc0.332.g42c0ae87b1-goog


