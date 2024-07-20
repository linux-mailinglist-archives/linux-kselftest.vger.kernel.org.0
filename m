Return-Path: <linux-kselftest+bounces-13968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 570BF938266
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 20:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E824FB215AE
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 18:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6401487E1;
	Sat, 20 Jul 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB84Dxvy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382107462;
	Sat, 20 Jul 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721499135; cv=none; b=Wjf+Dwb8byvtoAiKr5To46jc0OKwnrvewVM1mxuQTN8W9QemNxOCuiGuPzL04B8oIEJ/ggZlYpnfn9dfsMjo0KXobn7iX3yHOAz2wC9eBEzoCT5fY8poqm38LDY5rXH42DUBQLum4Qg222WZ+fRnmqsjXapPKxocVt/ki0NBJXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721499135; c=relaxed/simple;
	bh=xvGkl/Q5RZm1OHzjC1CEvaV9TM/ddsiXIvui9kZdAxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrD7yhSI1NJK+oMZLyXTfYxaYqZIPCNafYB4p114k7jbjTOCsHhn9/1GVycH+rvhK99e6Vzck2mNNOY+TS8epAX915O7ht+fg3Ql1OD+NzNLgmUJ4B9kgzk6b5T5orf0vyLmV1o9azm8XOnrrVAv0ko3mGcV/vHBm/7z9D0Vt90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB84Dxvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4EDC2BD10;
	Sat, 20 Jul 2024 18:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721499134;
	bh=xvGkl/Q5RZm1OHzjC1CEvaV9TM/ddsiXIvui9kZdAxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AB84DxvybDZU1PPp2G3mtE1hLs6HalMqgJQo3syRQHPW0Y9ZIBZbxd5UBGB+EO+fV
	 bLWmVNVu510YlPs+0CmS5T54l3N1yjyJLZqdJCwcgetS1l6xcaQ1xh1u50sLiyWUqW
	 SJrkzgli6EDFqXuw37oCKl2Z1asL+623EADegqDWmdnahmHjqUlj2pMx5ZSPFg8B9d
	 eNrA6GFh1Cek1YPtzejqdgyDUzODIyz0mBLoMRJM9jlpzEqlhJcRJg1ibl8Kmgc2oZ
	 mx/bZnh8Wr6U6OLO3Dd89t9vGKO64J2UdA7LLTJ4GxuJF21VEh1UZFlB8E6xcG2bf+
	 5UryfthWGMyJw==
Date: Sat, 20 Jul 2024 11:12:14 -0700
From: Kees Cook <kees@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: KUnit: Update filename best practices
Message-ID: <202407201111.C5DE72A11C@keescook>
References: <20240720165441.it.320-kees@kernel.org>
 <c9613b11-5751-400f-ae83-4590d4593ab4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9613b11-5751-400f-ae83-4590d4593ab4@nvidia.com>

On Sat, Jul 20, 2024 at 10:59:10AM -0700, John Hubbard wrote:
> On 7/20/24 9:54 AM, Kees Cook wrote:
> > Based on feedback from Linus[1] and follow-up discussions, change the
> > suggested file naming for KUnit tests.
> > 
> > Link: https://lore.kernel.org/lkml/CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com/ [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: David Gow <davidgow@google.com>
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Cc: Rae Moar <rmoar@google.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: kunit-dev@googlegroups.com
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-hardening@vger.kernel.org
> > ---
> >   Documentation/dev-tools/kunit/style.rst | 25 +++++++++++++++----------
> >   1 file changed, 15 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-tools/kunit/style.rst
> > index b6d0d7359f00..1538835cd0e2 100644
> > --- a/Documentation/dev-tools/kunit/style.rst
> > +++ b/Documentation/dev-tools/kunit/style.rst
> > @@ -188,15 +188,20 @@ For example, a Kconfig entry might look like:
> >   Test File and Module Names
> >   ==========================
> > -KUnit tests can often be compiled as a module. These modules should be named
> > -after the test suite, followed by ``_test``. If this is likely to conflict with
> > -non-KUnit tests, the suffix ``_kunit`` can also be used.
> > -
> > -The easiest way of achieving this is to name the file containing the test suite
> > -``<suite>_test.c`` (or, as above, ``<suite>_kunit.c``). This file should be
> > -placed next to the code under test.
> > +Whether a KUnit test is compiled as a separate module or via an
> > +``#include`` in a core kernel source file, the file should be named
> > +after the test suite, followed by ``_kunit``, and live in a ``tests``
> > +subdirectory to avoid conflicting with regular modules (e.g. if "foobar"
> > +is the core module, then "foobar_kunit" is the KUnit test module) or the
> > +core kernel source file names (e.g. for tab-completion). Many existing
> > +tests use a ``_test`` suffix, but this is considered deprecated.
> 
> For this paragraph, may I suggest this wording below? It attempts to
> explain the _kunit a bit (without leaving anything behind that would need
> to be changed later, if/when people rename things from _test.c to _kunit.c),
> as well as fixing up the sentence structure slightly:
> 
> 
> Whether a KUnit test is compiled as a separate module or via an
> ``#include`` in a core kernel source file, the file should be named
> after the test suite, followed by ``_kunit``, and live in a ``tests``
> subdirectory. This is to avoid conflicting with regular modules (e.g. if
> "foobar" is the core module, then "foobar_kunit" is the KUnit test
> module) or with the core kernel source file names (e.g. for
> tab-completion). The ``_kunit`` suffix was chosen over the older (and
> now deprecated) ``_test`` suffix, because KUnit behavior is sufficiently
> distinct that it is worth identifying at file name level.

Sure! I like that.

> > +
> > +So for the common case, name the file containing the test suite
> > +``tests/<suite>_kunit.c``. The ``tests`` directory should be placed at
> > +the same level as the code under test. For example, tests for
> > +``lib/string.c`` live in ``lib/tests/string_kunit.c``.
> >   If the suite name contains some or all of the name of the test's parent
> > -directory, it may make sense to modify the source filename to reduce redundancy.
> > -For example, a ``foo_firmware`` suite could be in the ``foo/firmware_test.c``
> > -file.
> > +directory, it may make sense to modify the source filename to reduce
> > +redundancy. For example, a ``foo_firmware`` suite could be in the
> > +``tests/foo/firmware_kunit.c`` file.
> 
> Whether you use that wording or not, this looks good, so:
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thanks!

-- 
Kees Cook

