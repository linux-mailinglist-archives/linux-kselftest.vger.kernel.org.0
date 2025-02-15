Return-Path: <linux-kselftest+bounces-26711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB87A36CBE
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 10:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6F13AC1CD
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 09:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F16D19E97C;
	Sat, 15 Feb 2025 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YpMhzKaZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3623A9
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Feb 2025 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739610394; cv=none; b=A6asLThmHnUojqQ+Y2tl4X/oOCY/9CgxcOvjs/GFtPlTIcnHJ+ycB8IJo/FMWSEbovV5/RBZ0/q6aeiMVjZHfqzGukvpa1N+xepyam5JOtZtgb1WjhqyGWjyJ00zfDl0BMdhR4SkUhrMs6H14XBtXRBQ2IdAK6sWG2MwFT9kMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739610394; c=relaxed/simple;
	bh=iDAJsI0tQXq58igUlZahn2t0Z5JBIlJCkLHgREaCk1c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u8sXf0TzLGtmvfhW+eZVlNKMAx+n5+kl+n0urwOCljIKEUs6qXI+/YWW03cAsNiIDc7neFV8LILBJBqypIbSrh3PV9PPApzF/bUIQHG9xTWK34FJZ9oCSx7k76se+fce8up6h6Fxb2LIk7LAfkfrVOGzNmf1PsRs1R1oWKfXVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YpMhzKaZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22101351b1dso14227835ad.3
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Feb 2025 01:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739610391; x=1740215191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQRyd0F7BKZh087rrQFW8k6283qvnshjN9rutxPqWIc=;
        b=YpMhzKaZv5Q6gnfIVeHCm//ph0BsxWUvQt387JpJJVm6AuAi+0ARdAtRRlvcsI4/gJ
         M96XW9nYAu3X9nCqqxJOuiaowJWqkWjbYpMaVZHh9XeZ+GnAVwv797GtA+tPzYf/MnpW
         LgCngbZAvBET7hSi1SIz14mQP+4JOKhNxYkANwuLl8powqSu/8f3U9lHNIxFNzXi8Ixt
         kAyfcz+265WwFlLSKP4IKvOz/kJD05X4fP6ZP7nuLbQmreKnymD4ZhhEXlwWLVXKiJ8c
         fAL5xargg7S+nv6Ti7TRFfAygG0hKhXL78Vki3GIdeq+wSS6sg3PBMP7hzO2cBBlRrh1
         zIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739610391; x=1740215191;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQRyd0F7BKZh087rrQFW8k6283qvnshjN9rutxPqWIc=;
        b=rYIUaSuPHjNSxtGZvlZVso8EHZZBx0a2S5WNJ70Hiszx7CRYhh88kS/pSa6lqN4a4i
         TAM6zXvTwcJvKy7iJvggVLGZwNpQMa6EFwbAEPcF0Y31PqDK2sPWGGODR0Y0sxqqlr6T
         ZHm+N1Hmf+ALw1eu3r1nkPkdxazoFyYLTBcvOPW8lSuJ0Nz+lbMZ79BYu3XgBTYBhuCD
         3PmSrPZNzoW618CzLtwjgsiU1PTIAXN7LllBZDUSJCxaaNdMJSeLwbWMqWnHheokXqlV
         x518KSypaOIiY1DFNbXQS73nzesCet0J4ua89gJ4siL7CM0lQN48xMBnfKnQP8xBEnwo
         m/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB/dUyXoouDpWESon9ZnWxnBUcCeZuwCd77cTfyZ7dElwiiq/XJY8TWkGsWZKTDv+s7481yZnPWPfHM5Tgd8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFarJ6V5bCtHXESGZHRRicckBfeQDmlT/fo2DwaQaSb9etaX76
	geMShwbKrn7b2EmM9CF5s9VX1Mvah2iXVAzBEsF3jQ32OS/QWpbrdBUHcXaMsFUpFydLnTBlRn6
	GvEVJ14SRDg==
X-Google-Smtp-Source: AGHT+IECq3E5vULHURfwTLuhCmRc1tM0x9VBo1aFiYiADPBTXR68KA9qWpxKPEruAsY8LlG6aq3KJiwoPuEC7Q==
X-Received: from pgcs136.prod.google.com ([2002:a63:778e:0:b0:add:b2fa:214d])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce0d:b0:21f:89e5:272d with SMTP id d9443c01a7336-22103f0507emr44780945ad.10.1739610390714;
 Sat, 15 Feb 2025 01:06:30 -0800 (PST)
Date: Sat, 15 Feb 2025 17:06:17 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215090622.2381038-1-davidgow@google.com>
Subject: [PATCH v7 0/3] rust: kunit: Support KUnit tests with a user-space
 like syntax
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Rae Moar <rmoar@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

This is v7 of the Rust/KUnit integration patch. I think all of the
suggestions have at least been responded to (even if there are a few I'm
leaving as either future projects or matters of taste). Hopefully this
is good-to-go for 6.15, so we can start using it concurrently with
making any additional improvements we may wish.

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

Changes since v6:
https://lore.kernel.org/rust-for-linux/20250214074051.1619256-1-davidgow@go=
ogle.com/
- Fixed an [allow(unused_unsafe)] which ended up in patch 2 instead of
  patch 1. (Thanks, Tamir!)
- Doc comments now have several useful links. (Thanks, Tamir!)
- Fix a potential compile error under macos. (Thanks, Tamir!)
- Several small tidy-ups to limit unsafe usage. (Thanks, Tamir!)

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


