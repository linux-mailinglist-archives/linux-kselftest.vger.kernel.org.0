Return-Path: <linux-kselftest+bounces-21079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F3E9B5AF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 05:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750F31F24A33
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 04:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15661990A8;
	Wed, 30 Oct 2024 04:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NbmhR6S9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3E19884C
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 04:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730264372; cv=none; b=J1O2CfZB7QkMzmf45tbVYyGQn4eThD+X+Z/q88E0DWmGs69nnmpVZXfEnGkoXByPFNHkmt7Vv9haHt+GiMWaBVIPCKy+wbBw+LH/JWhhLwPefQF1y/EYvNvp8JEPltzg7oV4iHD1EDyXmCb5PLgmVJq3PZm1f+QUwX8+/zFny0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730264372; c=relaxed/simple;
	bh=ckB9pUMTNSWy4prV1cOfoPbmEn3v96IADds04sKuQUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=udS76Svp6vuYlxWbuEWOQfXWwIgQNm86d2lnCJryml/CfCT5hDwSiG8mVf5R/oyrffF3RXmLBIS7FGaZgP4hbmqmOUZQ3R8zgTCI+E4kCb1VYBix0xdsLk2azIWQMnUwmQwDuE4iyXyu3T74ll0cNNagQqXGh5jYB8ijyTJl/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NbmhR6S9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30daaf5928so107518276.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 21:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730264369; x=1730869169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDWFvWINPVq6lF2SwqYloaVF+/6pFtfjGvv1V4TTOR4=;
        b=NbmhR6S974n+ai2b4Qud6M1FvQaoW2Ur6A0b+gM3CnyOni2Hu5wTAMNC7W598m97si
         TctBB5qV9nxUskP8XtQj1fYI3m/KKZxBoltwX08xBb6ZQuVoLiPI3Ik/uMFh2Gi/WbG7
         +IrSQXkXaYUhG9L1c12uhr/tDwmflhm+wzTW+MpCsjl6QrYqwqMivKg8SSOmHBZmJsFc
         51R8ABuNsRn7JLq+8GtHaIADlNXXMSdHGmBOzrKxC2olC2HprfbK3OUd1/9+QE2sqEvi
         H/LTD8nMzARq9SsNzerAcZFRwZy2Xv2boN39gQ7uR+I7s+9cowG+R001kNLXQSyjvjCB
         UpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730264369; x=1730869169;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FDWFvWINPVq6lF2SwqYloaVF+/6pFtfjGvv1V4TTOR4=;
        b=hcCWpAVHnLdzLDvHlqMV0LcpoiBB6MhBmS8KCicClXDwfT/scx9lzNGmzSe+i0Omjp
         sP8rCQGt32IzmQd9gdzDv6dyFYy3mYxEl7cM5FrV8kbEPc9lnzX3uZZHIMxusidF3gvU
         dn+c9Y3qwlnruMPPhzMrUstVCLch6xcxUR7QcdN/J++L2Vga3IDerK+Cc+czBECSbdMV
         NRRVnmhfWBnp76p315U/mc8+L3zrrgXX+KHywry1UwVE7KeDJD5Xq4s/vRI3L+XUCvGK
         iIkH3eUKfxjtqWXl0YJCVGMKq7U+P50aVW5emfJKeCuLtvFtWC/LhiPxUuRkPnLVzjIu
         FCng==
X-Forwarded-Encrypted: i=1; AJvYcCVSPNhzLMUgIVKdtCwCt+ajX58aSpnf3j+Y8DzzMRvOnk0qh87lAhN40zKrW/nMc+rU52SZywGXvtuOvH/IcrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwooRdM7Ba2TlZJtU/oRTpMDGWCN4Sa7Bf+W7x+CNdbXNJtQcQi
	T6F7ZlYeQLRBA5jodFoWrTR980OqChy2ATawqTteZ/tQQ/A3PVQ9Gw5wr8GP8SCfifIwkm7qy4w
	6j/yRjY2XqQ==
X-Google-Smtp-Source: AGHT+IGekxcLmEJS2haephcXYwaPtTFGVJy9oILsQ6O/T5joWShJw7lDLxlgK2wdbCm786occ2gOaxQlBRU5Nw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a25:a549:0:b0:e30:c6ce:1165 with SMTP id
 3f1490d57ef6-e30c6ce1d94mr23975276.1.1730264369395; Tue, 29 Oct 2024 21:59:29
 -0700 (PDT)
Date: Wed, 30 Oct 2024 12:57:16 +0800
In-Reply-To: <20241030045719.3085147-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030045719.3085147-2-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030045719.3085147-8-davidgow@google.com>
Subject: [PATCH v3 3/3] rust: kunit: allow to know if we are in a test
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
index ac296467a552..d5926f7ef405 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -272,11 +272,83 @@ macro_rules! kunit_unsafe_test_suite {
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
     fn rust_test_kunit_kunit_tests() {
         let running =3D true;
         assert_eq!(running, true);
     }
+
+    #[test]
+    fn rust_test_kunit_in_kunit_test() {
+        let in_kunit =3D in_kunit_test();
+        assert_eq!(in_kunit, true);
+    }
 }
--=20
2.47.0.163.g1226f6d8fa-goog


