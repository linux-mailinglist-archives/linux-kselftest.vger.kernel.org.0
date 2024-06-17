Return-Path: <linux-kselftest+bounces-12098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D865D90BA62
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 21:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869B9281F28
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E28198838;
	Mon, 17 Jun 2024 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTxV83cA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753CF16B381;
	Mon, 17 Jun 2024 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650823; cv=none; b=pxcpNb+hHzKg4vEA9mPx+rFuiqOIPAnFl6WrLo0/ycT1Fxt3kNd03zcfMXnu0c5rSUng+mkHBY1/baOfUn/GfGlka2S8g3Dme6ikuzEvg1UsGQ1WsCzcYPILJsxaHdnR/MbkziSnCpkqzq7W3iqKvqAofkaDhr5ioU4oVtVcUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650823; c=relaxed/simple;
	bh=tVw8aWviI/EJ8IxtzGYCDNXdKhTgHY4FFE6xq4UtSC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgmEAL+h84u1LzaimPo/og72pri+twGeWGvD6nb8P84vvbcuWHymZt5Ar4z+evwunoY7gbULrBnA0r2i12J52VsCITj3m+GrKuDGE5TbZihFIjvM4bETnhevn6OOVH3b3zgIEDXgU4+B46L0NzEAhIW4PiP2wysv/HMeKjKaFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTxV83cA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419D0C2BD10;
	Mon, 17 Jun 2024 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718650823;
	bh=tVw8aWviI/EJ8IxtzGYCDNXdKhTgHY4FFE6xq4UtSC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aTxV83cAgs2vdiqVeZSZDLAXnH8MWuHABPWTE2n5EM4wwzo1bjB++fVnI0uOl0RRK
	 raz0xgXgD9BBGEpmisIqv1c5TvBxrT4fcoZ51eNorYMUwgdD+8EYHjBzSvD02P9llR
	 PR+CFIjNKHVNWi1k1G+mqdu84l7GVerQyMl3W8lHnvfQevOVK720okpdkdO/8KZKCE
	 jTVGFR9f3958X9RwzQ8Lqrkybn6ai5bPpRGK6dpKJYeMoP6iNmp3ODqCZ39YhyAI61
	 X8XGc9Sfh420biaE7W1SUYncXwdGdsbl+9n9HPrcpvtf1qNFFFG0jikFvCsOMs4opF
	 q83AFy89FItfw==
Date: Mon, 17 Jun 2024 12:00:22 -0700
From: Kees Cook <kees@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Vitor Massaru Iha <vitor@massaru.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usercopy: Convert test_user_copy to KUnit test
Message-ID: <202406171157.A97ACED1B@keescook>
References: <20240612195412.make.760-kees@kernel.org>
 <20240612195921.2685842-2-kees@kernel.org>
 <90e61842-e933-4d6f-a3b5-c802382fe96a@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90e61842-e933-4d6f-a3b5-c802382fe96a@linuxfoundation.org>

On Fri, Jun 14, 2024 at 09:50:05AM -0600, Shuah Khan wrote:
> On 6/12/24 13:59, Kees Cook wrote:
> > Convert the runtime tests of hardened usercopy to standard KUnit tests.
> > 
> > Additionally disable usercopy_test_invalid() for systems with separate
> > address spaces (or no MMU) since it's not sensible to test for address
> > confusion there (e.g. m68k).
> > 
> > Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > Link: https://lore.kernel.org/r/20200721174654.72132-1-vitor@massaru.org
> > Tested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> > Reviewed-by: David Gow <davidgow@google.com>
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >   MAINTAINERS                                |   1 +
> >   lib/Kconfig.debug                          |  21 +-
> >   lib/Makefile                               |   2 +-
> >   lib/{test_user_copy.c => usercopy_kunit.c} | 282 ++++++++++-----------
> >   4 files changed, 151 insertions(+), 155 deletions(-)
> >   rename lib/{test_user_copy.c => usercopy_kunit.c} (46%)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8754ac2c259d..0cd171ec6010 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11962,6 +11962,7 @@ F:	arch/*/configs/hardening.config
> >   F:	include/linux/overflow.h
> >   F:	include/linux/randomize_kstack.h
> >   F:	kernel/configs/hardening.config
> > +F:	lib/usercopy_kunit.c
> >   F:	mm/usercopy.c
> >   K:	\b(add|choose)_random_kstack_offset\b
> >   K:	\b__check_(object_size|heap_object)\b
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 59b6765d86b8..561e346f5cb0 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2505,18 +2505,6 @@ config TEST_VMALLOC
> >   	  If unsure, say N.
> > -config TEST_USER_COPY
> > -	tristate "Test user/kernel boundary protections"
> > -	depends on m
> > -	help
> > -	  This builds the "test_user_copy" module that runs sanity checks
> > -	  on the copy_to/from_user infrastructure, making sure basic
> > -	  user/kernel boundary testing is working. If it fails to load,
> > -	  a regression has been detected in the user/kernel memory boundary
> > -	  protections.
> > -
> > -	  If unsure, say N.
> > -
> >   config TEST_BPF
> >   	tristate "Test BPF filter functionality"
> >   	depends on m && NET
> > @@ -2814,6 +2802,15 @@ config SIPHASH_KUNIT_TEST
> >   	  This is intended to help people writing architecture-specific
> >   	  optimized versions.  If unsure, say N.
> > +config USERCOPY_KUNIT_TEST
> > +	tristate "KUnit Test for user/kernel boundary protections"
> > +	depends on KUNIT
> > +	default KUNIT_ALL_TESTS
> > +	help
> > +	  This builds the "usercopy_kunit" module that runs sanity checks
> > +	  on the copy_to/from_user infrastructure, making sure basic
> > +	  user/kernel boundary testing is working.
> > +
> 
> Please carry the following line forward as well to be complete assuming
> it is relevant.
> 
> If unsure, say N.

I've explicitly removed that because it would be repetitive if it were
included for all KUnit tests.

-- 
Kees Cook

