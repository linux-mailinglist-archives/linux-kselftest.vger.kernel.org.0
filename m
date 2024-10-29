Return-Path: <linux-kselftest+bounces-20919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2599B45A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D8228349A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC881E32A0;
	Tue, 29 Oct 2024 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wf7+CFGW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1921E102D
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193874; cv=none; b=nLFbL7ZbDwucwGDId616T31YkeGQ5IjunufWopsazffIFWkz8qgCLzLJnWPj/j3CRoBoCajTKxJfk5J4lhkdZjrMqsoZJfg+VdOQgtUYCBp35fkkqs3eKRT0WNsZCCO3pxVTuQzDbvnNQhm4ZjPJT7LnqNrNNDruIfK9NE1jU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193874; c=relaxed/simple;
	bh=UTc6KxPryWSJ7soBdBEQQsIFrovCwOrroDeykYKubkA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kvMj+Vao8zOWtEK3JjXnhadkuzd1/I+HtP4LZsLoi9F68epopgRHTL6rvQYiH1mQWLzxdsw4t0gvVoDK+oWHcMjPOl/sAnIUvDHBkBx/JphW6CW6Ih/3ZB4yNfsO45VIfw0kwpdLi7kDigFOAKEa8w/DeTU0X0h13eXdBT/bEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wf7+CFGW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e293b3e014aso8515223276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730193871; x=1730798671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lOv1XNqhzSTi2v1xjBl65HyN11WbqhoetLuPTUihhNM=;
        b=wf7+CFGWiGFsCLaWMGtdp6N05yholN3SpkS+Vjb2leNNAKobeKr3s+/pQ9nVpUqPCw
         cTfJrlK+tMykNbqoLcWcS5E2W7wEerJxCzfqbm3Awp/aZ0Z2QuWiGFB6JTpV5u7DI4UC
         ylDJAQe8udwFNnY7h/bbvyFooPJ3bk66+e51z3fo/o38/PY28gaY9iFUgMV3TYrGCAl+
         E4MwKcUIzTvN+pKYO9qoU6plzWvMMdne2AW6OA+KPwwaO9F9B4Dll2RcOERSfjvMQY7f
         YsV/IMrJWRE7wqVf9jaG/Bpp8jdKrbF9YIYLCDNxP+K24fgVvFMdgQEr8uPDFpNVNgNT
         oUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730193871; x=1730798671;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOv1XNqhzSTi2v1xjBl65HyN11WbqhoetLuPTUihhNM=;
        b=crRwRKv0ej0JsxeibDvYYNqjXEjj0pz31jW8k2Kw2ibTS1WPg/d7752o7xvy9LMqO0
         p4ux/Qpl7GfixTIVGd2xWF1zn98HHLFer29nMtLlNDOUjEs/K3Nr1NTy7VeZ3ZFaKPc4
         ulQCyX1RbZFXkf2qViIjh2KbqHY8uQOi5BSkYOvl7VpsYLeVOU4SEtALbRkjIJ6ByR3e
         KWnXPFQmd0tlemtgCze0tr82HRKz/rdvDf2Pmh46N8TJErN/CXB2Z/qbLqN+wcLT/gau
         AGH/f6Y22i0Mni/q/wOLgKg0Qyvh9j4usBIiOh8Xgx5m3vIXQqe0HEkjasfrDSrfGoFh
         QiYw==
X-Forwarded-Encrypted: i=1; AJvYcCXNm/EnpCIaUvnkWWC647UYrKDbgrpcVeanXTFjEuX98QxCsF2vdX0fxSathZP0LXQlAVGp63AFo+xM9lYcZP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykSr/1c7ELQxUaxoDMsWEkNdC55egukiLZuVqRvTJDSkeEJGhM
	fx2afMAjtRZ2KcmfbhiYmcw48gi3fy+BfYTeUmDC0F5rEd3tlRLiS6lybR6AX2/ZqikjoBonNWK
	Re351gBOd6A==
X-Google-Smtp-Source: AGHT+IG/46UeBOug7p4Ly1YH4lLjvx8EExzDPr//o0o5DvNHCO5mK2Ewif9tZkVgP9PjRPWZ0rP5D9bCD72H4g==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a25:9086:0:b0:e29:74e3:616c with SMTP id
 3f1490d57ef6-e3087a4f19cmr7832276.3.1730193870982; Tue, 29 Oct 2024 02:24:30
 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:24:16 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029092422.2884505-1-davidgow@google.com>
Subject: [PATCH v2 0/3] rust: kunit: Support KUnit tests with a user-space
 like syntax
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>
Cc: David Gow <davidgow@google.com>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This series was originally written by Jos=C3=A9 Exp=C3=B3sito, and has been
modified and updated by Matt Gilbride and myself. The original version
can be found here:
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
 rust/kernel/kunit.rs | 191 +++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs   |   1 +
 rust/macros/lib.rs   |  29 +++++++
 4 files changed, 222 insertions(+)

--=20
2.47.0.163.g1226f6d8fa-goog


