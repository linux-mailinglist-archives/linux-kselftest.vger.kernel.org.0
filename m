Return-Path: <linux-kselftest+bounces-13852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891FA934497
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 00:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360C31F223C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 22:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B932040848;
	Wed, 17 Jul 2024 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYZ2OIRd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8323E2BCF7;
	Wed, 17 Jul 2024 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721254276; cv=none; b=eB5lPIVsi/GOdWWCbdiCinWNU81yxOosoCppkoz/W/jhOTd0hWYYV4kTL/Wo328ODKRWtmATWJQjlp7pgjNunGKk/y2L5A4mSAEHtDs+IVg7cUF8aBWgIjagE0nnyIzO4Y31ghsyaNFpM5jBNTkIl0rioLE+J++FDA+8KGr0sbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721254276; c=relaxed/simple;
	bh=fKhM1tyNRfbmKB/nD4xsxgWIOHKRVRmfo3oa/afGcfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHsdV0j4OfkCsWvC8DfdLWAk10ZlGs6+pfuzc5w4u5NARLDAcHTYvkksATUso1r8fD6ARIU4RM2pU/fuL0QDMH02qy51b6dmnopwfxr1zObqmnGaGoVybanATfaL1QeimPAD1vKRm6T98QAWAOcAeNkshuSULCpN9XDUtZ01peE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYZ2OIRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0659CC2BD10;
	Wed, 17 Jul 2024 22:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721254276;
	bh=fKhM1tyNRfbmKB/nD4xsxgWIOHKRVRmfo3oa/afGcfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sYZ2OIRdO+cd71ru2Pl62zWKakK7gTtrPSbyI1E2Cn7pLf1KQQeJZs4Jf1iubAvUq
	 flrhASNVB//X+1AXITe9g3ZYb6a1IzsCH2v+hTFdPZ4F6R1CRp0Og0YV0tWmBpnWKT
	 WwEcWADArRQ4nmNxkAC3ppbRqy+L5xtzH9eQRm5j8NEswWGgj3LMSYneOJ57ReGrzy
	 mQtLMczX+YwvIulN703WmxmDS5dRpcGWdq1lu5ySjCR+XsBSkxHm9xEky53OhleSXA
	 3hZYdQZ6zMZ1qbW1eeB2yiWnKlCjhVXczC7AkhpCHgOwOt3Dm0SDt+5BoXLUt6uM2R
	 FzuIaWwObiFpw==
Date: Wed, 17 Jul 2024 15:11:15 -0700
From: Kees Cook <kees@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Documentation: KUnit: Update filename best practices
Message-ID: <202407171510.88EECF3857@keescook>
References: <20240717210047.work.412-kees@kernel.org>
 <a5005f1e-5bbc-49f2-bd1f-4c4878b98d26@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5005f1e-5bbc-49f2-bd1f-4c4878b98d26@nvidia.com>

On Wed, Jul 17, 2024 at 02:16:30PM -0700, John Hubbard wrote:
> On 7/17/24 2:00 PM, Kees Cook wrote:
> > Based on feedback from Linus[1], change the suggested file naming for
> > KUnit tests.
> > 
> > Link: https://lore.kernel.org/lkml/CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com/ [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: David Gow <davidgow@google.com>
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Cc: Rae Moar <rmoar@google.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: kunit-dev@googlegroups.com
> > Cc: linux-doc@vger.kernel.org
> > ---
> >   Documentation/dev-tools/kunit/style.rst | 21 +++++++++++++--------
> >   1 file changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-tools/kunit/style.rst
> > index b6d0d7359f00..761dee3f89ca 100644
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
> > +``#include`` in a core kernel source file, the files should be named
> > +after the test suite, followed by ``_test``, and live in a ``tests``
> 
> I read the previous discussion in the other thread and thought about it.
> And ran some kunit tests on baremetal. Delightful! I love this approach.
> 
> However! It is rather distinct and not just any old test module. Kunit
> has clear conventions and behavior.
> 
> As such, I have quickly become convinced that distinct naming is
> required here. So I'd like to suggest going with the the suffix:
> 
>     _kunit
> 
> ...unconditionally. After all, sometimes you'll end up with that
> anyway, so clearly, the _test suffix isn't strictly required.
> 
> And given that we are putting these in tests/ , a _test suffix is
> redundant.
> 
> Yes?

I would agree. David, what do you think? I realize drm already does
tests/*_test.c, but it does seem like better information density to use
the tests/*_kunit.c pattern by default?

-- 
Kees Cook

