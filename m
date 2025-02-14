Return-Path: <linux-kselftest+bounces-26634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB20A35808
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 08:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21523AB8F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 07:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CA32153FB;
	Fri, 14 Feb 2025 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pCSPyBJD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B08E2153DF
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518866; cv=none; b=M2ubdm9+El+oP3FaAo5PH668pzGAEjndxPrVFt/wsO27y5Zw8Dp+BoPp/nz7rQYnbb4D3Zvour4NQKQdDqGmOyvKe8fOGlkpcpC2rx+gpeScC1my8ypGDKrtr+PeuxjRbC/FRIWFM8H/lRkqu0jRwUYppZ1gyOhkKjgWwv+tjeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518866; c=relaxed/simple;
	bh=12kOPRWel7xFCzSXfD1ckAW3cz4eQ6lXHcEjTTfHP5s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZybOAKHxCKmWpcLNFAFC3P4gUbWvb0Pz30YenZqyMOcbYuAlRNfTo55TUFf80RgE6f5K420qF257j1zT13kxiIz5hg8NBPKHrQcI2D6MDYckP+wnjI3TXmk0Mzaanxxyl7kqDv2F9EZO+szf/zJkRlGe1MHwyeFCpSLMj1rX+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pCSPyBJD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220e7d654acso19021275ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 23:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739518864; x=1740123664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ros5ecWILQk9ViSMi46tyrMnoasJTGynME1EO90va/I=;
        b=pCSPyBJDNza5YN0gsduFf8YznwKZ+9fmLxYpU+YGZDyZS86XgPJzd/h78X5XK48QAf
         h+YEQ4p2OWwZkMPp+Sfvpe94zh6fTYfvyViAx7uFPEg5nI0Kyx/s5qX7BZLE2qmtku9x
         kmnAzs1d11NsIB/g/gGEqL5YmZ4kB81DOcGbZOly7i3CiOC2PMbIIUomnXcuKqwic0zB
         Lti2hrOJFiDjmy+GuzXnSRMmTZ8AvRXNPptzByXMegOaT3Cwz5B8HdcTRFnfzfAAXUml
         4XDXrgbKoeHQUfddC22h/J31a/grrzn8pNgk1VcFvWG3iBEiCJowoPANA8y0YHXsNZV2
         n00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739518864; x=1740123664;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ros5ecWILQk9ViSMi46tyrMnoasJTGynME1EO90va/I=;
        b=OuWTeMbnPG1YNiKtrX4mFMzwZMSZ05d1pZeNlR0w2XR+srH0XrnZopuVcSrbe9nt27
         J34lnstibGjQxJ8Yj48bJnjhQOVRpPZc81bjT/PgNcSg3rqGrnP/j6ZyiX/Pm0d3EKQC
         +tP0cMp+gB2wRbdmeXJ9hPIoL+z3mgplRFAI74GLsKvufECeqOlzKYPFgjvBty5O5WnO
         T5Ep+6k2I6lKEReXmBhLm+xm6gqIJHuvewlErqoHPNNqWgzN6vyxvLzQxhC6w/JWuVuQ
         T9bwIeUObQindY38SiM8PAM84XVTA9ph3ztzWdUjrmDRVHyoXyJhXb2nO1pcgX6wSCNu
         4fIg==
X-Forwarded-Encrypted: i=1; AJvYcCWcfILcWaV2nUKyOR6QhXo7XTSE/mJiYZCMmmhPicV1I4gm/s8uc2gcB0Ke5UKBnI49JorLbTLecRXEoqryd2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YynZxuBNCOIaYVhx+kDxGV0qaVjLQE1iUB2aIdkjBlc//Jaz2aV
	lbtrZmF3F6AZVyFld3wDtNQ3oT9O/yUDGnndbg6M7GKr0BcQmFuAM5ngqkEZDfqNkAeDbY6w6K1
	WWiTyXpk6zw==
X-Google-Smtp-Source: AGHT+IFc9mssigZBBdQeLa48hAtAvejO3PdAygZr+C8/qwDEPSonq7V87yX/QBsUdgxAuKB6Xx/+ib3gt23dEg==
X-Received: from plbjk16.prod.google.com ([2002:a17:903:3310:b0:21f:4e6:1edd])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dacc:b0:21f:6546:9adc with SMTP id d9443c01a7336-220d3517e17mr85460525ad.13.1739518864278;
 Thu, 13 Feb 2025 23:41:04 -0800 (PST)
Date: Fri, 14 Feb 2025 15:40:45 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214074051.1619256-1-davidgow@google.com>
Subject: [PATCH v6 0/3] rust: kunit: Support KUnit tests with a user-space
 like syntax
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Rae Moar <rmoar@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>, Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

After much delay, v6 of the KUnit/Rust integration patchset is here.
This change incorporates most of Miguels suggestions from v5 (save for
some of the copyright headers I wasn't comfortable unilaterally
changing). This means the documentation is much improved, and it should
work more cleanly on Rust 1.83 and 1.84, no longer requiring
static_mut_refs or const_mut_refs. (I'm not 100% sure I understand all
of the details of this, but I'm comfortable enough with how it's ended
up.)

This has been rebased against 6.14-rc1/rust-next, and should be able to
comfortably go in via either the KUnit or Rust trees. My suspicion is
that there's more likely to be conflicts with the Rust work (due to the
changes in rust/macros/lib.rs) than with KUnit, where there are no
current patches which would break the API, so maybe it makes the most
sense for it to go in via Rust for 6.15.

This series was originally written by Jos=C3=A9 Exp=C3=B3sito, and has been
modified and updated by Matt Gilbride, Miguel Ojeda, and myself. The
original version can be found here:
https://github.com/Rust-for-Linux/linux/pull/950

Add support for writing KUnit tests in Rust. While Rust doctests are
already converted to KUnit tests and run, they're really better suited
for examples, rather than as first-class unit tests.

This series implements a series of direct Rust bindings for KUnit tests,
as well as a new macro which allows KUnit tests to be written using a
close variant of normal Rust unit test syntax. The only change required
is replacing '#[cfg(test)]' with '#[kunit_tests(kunit_test_suite_name)]'

An example test would look like:
	#[kunit_tests(rust_kernel_hid_driver)]
	mod tests {
	    use super::*;
	    use crate::{c_str, driver, hid, prelude::*};
	    use core::ptr;

	    struct SimpleTestDriver;
	    impl Driver for SimpleTestDriver {
	        type Data =3D ();
	    }

	    #[test]
	    fn rust_test_hid_driver_adapter() {
	        let mut hid =3D bindings::hid_driver::default();
	        let name =3D c_str!("SimpleTestDriver");
	        static MODULE: ThisModule =3D unsafe { ThisModule::from_ptr(ptr::n=
ull_mut()) };

        	let res =3D unsafe {
	            <hid::Adapter<SimpleTestDriver> as driver::DriverOps>::registe=
r(&mut hid, name, &MODULE)
	        };
	        assert_eq!(res, Err(ENODEV)); // The mock returns -19
	    }
	}


Please give this a go, and make sure I haven't broken it! There's almost
certainly a lot of improvements which can be made -- and there's a fair
case to be made for replacing some of this with generated C code which
can use the C macros -- but this is hopefully an adequate implementation
for now, and the interface can (with luck) remain the same even if the
implementation changes.

A few small notable missing features:
- Attributes (like the speed of a test) are hardcoded to the default
  value.
- Similarly, the module name attribute is hardcoded to NULL. In C, we
  use the KBUILD_MODNAME macro, but I couldn't find a way to use this
  from Rust which wasn't more ugly than just disabling it.
- Assertions are not automatically rewritten to use KUnit assertions.

---

Changes since v5:
https://lore.kernel.org/all/20241213081035.2069066-1-davidgow@google.com/
- Rebased against 6.14-rc1
- Fixed a bunch of warnings / clippy lints introduced in Rust 1.83 and
  1.84.
- No longer needs static_mut_refs / const_mut_refs, and is much cleaned
  up as a result. (Thanks, Miguel)
- Major documentation and example fixes. (Thanks, Miguel)

Changes since v4:
https://lore.kernel.org/linux-kselftest/20241101064505.3820737-1-davidgow@g=
oogle.com/
- Rebased against 6.13-rc1
- Allowed an unused_unsafe warning after the behaviour of addr_of_mut!()
  changed in Rust 1.82. (Thanks Boqun, Miguel)
- "Expect" that the sample assert_eq!(1+1, 2) produces a clippy warning
  due to a redundant assertion. (Thanks Boqun, Miguel)
- Fix some missing safety comments, and remove some unneeded 'unsafe'
  blocks. (Thanks Boqun)
- Fix a couple of minor rustfmt issues which were triggering checkpatch
  warnings.

Changes since v3:
https://lore.kernel.org/linux-kselftest/20241030045719.3085147-2-davidgow@g=
oogle.com/T/
- The kunit_unsafe_test_suite!() macro now panic!s if the suite name is
  too long, triggering a compile error. (Thanks, Alice!)
- The #[kunit_tests()] macro now preserves span information, so
  errors can be better reported. (Thanks, Boqun!)
- The example tests have been updated to no longer use assert_eq!() with
  a constant bool argument (which triggered a clippy warning now we
  have the span info).

Changes since v2:
https://lore.kernel.org/linux-kselftest/20241029092422.2884505-1-davidgow@g=
oogle.com/T/
- Include missing rust/macros/kunit.rs file from v2. (Thanks Boqun!)
- The kunit_unsafe_test_suite!() macro will truncate the name of the
  suite if it is too long. (Thanks Alice!)
- The proc macro now emits an error if the suite name is too long.
- We no longer needlessly use UnsafeCell<> in
  kunit_unsafe_test_suite!(). (Thanks Alice!)

Changes since v1:
https://lore.kernel.org/lkml/20230720-rustbind-v1-0-c80db349e3b5@google.com=
/T/
- Rebase on top of the latest rust-next (commit 718c4069896c)
- Make kunit_case a const fn, rather than a macro (Thanks Boqun)
- As a result, the null terminator is now created with
  kernel::kunit::kunit_case_null()
- Use the C kunit_get_current_test() function to implement
  in_kunit_test(), rather than re-implementing it (less efficiently)
  ourselves.

Changes since the GitHub PR:
- Rebased on top of kselftest/kunit
- Add const_mut_refs feature
  This may conflict with https://lore.kernel.org/lkml/20230503090708.252431=
0-6-nmi@metaspace.dk/
- Add rust/macros/kunit.rs to the KUnit MAINTAINERS entry

---

Jos=C3=A9 Exp=C3=B3sito (3):
  rust: kunit: add KUnit case and suite macros
  rust: macros: add macro to easily run KUnit tests
  rust: kunit: allow to know if we are in a test

 MAINTAINERS          |   1 +
 rust/kernel/kunit.rs | 199 +++++++++++++++++++++++++++++++++++++++++++
 rust/macros/kunit.rs | 161 ++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs   |  29 +++++++
 4 files changed, 390 insertions(+)
 create mode 100644 rust/macros/kunit.rs

--=20
2.48.1.601.g30ceb7b040-goog


