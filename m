Return-Path: <linux-kselftest+bounces-23303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A809F0615
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 09:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1E6188A203
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C031AC882;
	Fri, 13 Dec 2024 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="25CRHmzk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A51A2645
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077459; cv=none; b=UOQAuqc8BgvPtEVsxlUcO6UCWkpocnMA8LJwWYY6/4qBoxZk4P5eFUdT68q5wM5YcnABRqV+nMvLHVTPS0we9K/0Qo1ip1rHzLfWPq4uoKJw/MOl0jhRGld6RqqlMjK8HKbjOIJ9iPVP+t2k0X2i7+pR+7FfxFyiMzxY1HwqZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077459; c=relaxed/simple;
	bh=muBuT3/fw4rFJrq5xFQ+Ra6MjOtPX4OZHijECqYG8dQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eFm2W191oDG8uu4FYroWXOIl1e1eHNKj1i6Omu6kM4z4bidK2wyuA37HQ7UzlzfKbpuCDRn6HLOyWp3DKjCIacmeoA2ebBNHTSfpfgyAkHL4yN4ZLk32aKYzVOnkJpynSRptjD78OKcoSq/FoEyee/1HZfLD+Ac6NM+R2LLywHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=25CRHmzk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-72726ced3f3so1511890b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 00:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734077457; x=1734682257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrQ0AlLgEYLxlOCFUZxHBj34RLTPvztlmnit/cu7UGM=;
        b=25CRHmzk7yLY0N38jE5zROx4cARvOQ7LvdnVauXbmDR6j87VbNg2ZYa5T+OeXGvhp5
         4VCRE7q9S3l3Zt0trx2wr6ln48mqklTcWBWHgOrVPvlHm4DZPOa+REmN50cdxXMJigYR
         T7Mk4rPoPjzpliMXE5+T9hNYAh+YcabyBamuBJCMJ7Tfr7LbBEmKddfSlj6KFV4Wg3o6
         f0YTZjBY9a56g3FQzuxyesiO3Wi+JLFyAdM2mZ0EB51D+s1fsWnyKtJb8EgVhY+0MYKf
         rIELucBYct8wURa1m87jbUgj1/lihDNuaoNjcFm/aoRzxwQMKTywXzITcj7snxYOaQeq
         0jHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734077457; x=1734682257;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PrQ0AlLgEYLxlOCFUZxHBj34RLTPvztlmnit/cu7UGM=;
        b=CRJq0zcXfcSbr8m92f1jO/0SdPZmbArlsJ/0S5sx1k6Sq0WGscZ/UGF06l8pBXeXSv
         tfTBA/sLP5JvV4CqilADMDUVga3RVjqmbGusJs1NQypW4Ly0Tcd5luzvWTIE37V/fUw8
         Jomq3lu2GbdVDTeV3X4u0EDV4p2FvwZi2dhEPuhEu0ZlxMVuVd6V+s4JFeaLVuOmrvUf
         t0WbvJ1sFhgl+OlGHjvYEwRBk0e/MbQkFB5olqGG8Y150a1wSynmr9GALFHXUHxvFmKB
         x4Pq5nVNvaEb5MPru5CZQRAsrpfyROWqa6JUXUgZhtcfUWOdNFWskB9JPyBQ3W6oVRIB
         iEAA==
X-Forwarded-Encrypted: i=1; AJvYcCVXNUyZwooDn1W9cdd+X6LVD3CotJtaYHlIrBUum7g4s9rtfo20sIa9XiEexVLhs7ZUkrKthkgUP3BbrRYD0ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1Czvxqo+kRYF82TKjOUA2PK2F33yAFqH2DoxdJDSsKaNKsfv
	cMrbOhpi9HDQXL4R+O/SATW3OJv7/YFhN9rt3GtOZVa4xqpc7j3gz1m+xWrgNShjjvpP9xfi5nz
	IQ0tGUWHqcQ==
X-Google-Smtp-Source: AGHT+IE20r9i7LSXHxGlRRrGX5jraUibLl/FufsitEHqK5okZqnX9FSquFIcCA+5Lr9N/9ktxgLKuC+kX5f3rA==
X-Received: from pfbhj4.prod.google.com ([2002:a05:6a00:8704:b0:728:c6d8:5683])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c99a:b0:1e1:cd09:e08d with SMTP id adf61e73a8af0-1e1dfd3533bmr3125607637.11.1734077456782;
 Fri, 13 Dec 2024 00:10:56 -0800 (PST)
Date: Fri, 13 Dec 2024 16:10:32 +0800
In-Reply-To: <20241213081035.2069066-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213081035.2069066-1-davidgow@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213081035.2069066-4-davidgow@google.com>
Subject: [PATCH v5 3/3] rust: kunit: allow to know if we are in a test
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Rae Moar <rmoar@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
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
 rust/kernel/kunit.rs | 75 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index a92f12da77d5..2196e35e5d75 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -285,11 +285,86 @@ macro_rules! kunit_unsafe_test_suite {
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
+///     /// Mock `ktime_get_boot_fast_ns` to return a well-known value whe=
n running a KUnit test.
+///     pub(crate) fn ktime_get_boot_fast_ns() -> u64_ {
+///         if in_kunit_test() {
+///             1234
+///         } else {
+///             // SAFETY: ktime_get_boot_fast_ns() is safe to call, and j=
ust returns a u64.
+///             // Additionally, this is never actually called in this exa=
mple, as we're in a test
+///             // and it's mocked out.
+///             unsafe { kernel::bindings::ktime_get_boot_fast_ns() }
+///         }
+///     }
+/// }
+///
+/// // This is the function we want to test. Since `bindings` has been moc=
ked, we can use its
+/// // functions seamlessly.
+/// fn get_boot_ns() -> u64 {
+///     bindings::ktime_get_boot_fast_ns()
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
         #![expect(clippy::eq_op)]
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
2.47.1.613.gc27f4b7a9f-goog


