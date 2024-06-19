Return-Path: <linux-kselftest+bounces-12267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFDE90F78F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 22:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F841C22254
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 20:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8143015A85C;
	Wed, 19 Jun 2024 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0UDKG4J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EBD76413;
	Wed, 19 Jun 2024 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829305; cv=none; b=DeAWlI/jluoxDSmRrjcU60oQ8w+wMALfhwRZ6gwGDuOR4UUHjWpQeGE6Fgtq31DifWQZRCEo0rarIhXlCjV28idYx9f0uvQbV6JpWmZe67vcLFc/Ii+7ipLScPVCWPqbMySLVrBJQ08e/DSZfjAQkZAoFRfbSu1k9vTYW+aBRtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829305; c=relaxed/simple;
	bh=DwSqGIFWO7qDKpdb7yKEj89W14i4MmRr2Boksk1EBcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGJkb1aelHb9GX7xW1CWfTW0i3iRcZoeRP+XM/MLtfwZTTr9coBCdGDODC5LcKjtKPenDPcBrTRsh/YDjqVtlbkIXNY7h0vfQl87ZB7LTrVpvtts3xllKJa08FQCzRILpu53zZyCXJq3BB+ecrxnq1G+foc9gisFdCWBbsABGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0UDKG4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC36EC2BBFC;
	Wed, 19 Jun 2024 20:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718829304;
	bh=DwSqGIFWO7qDKpdb7yKEj89W14i4MmRr2Boksk1EBcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0UDKG4J2YCeJh6+iV+ePsRpBg3SQwdej1LXQaTZIlskG82dYIRsd2pGoH4HpIVS2
	 ZX0hNnkT1QRrhB/KJc1RqESOfCHG7lBITUHChxXFhNvoTXGtPCnqpPBMzZwlcyK9cg
	 U3G7EVRkF2pKVSGLjOPaeWOVSuczuTzENulES88Aj0w2n7kQPJ74YBZFU2XZnP1rWC
	 NXUFLn7vA5L+HWgwjyvnOU8wbLlAdTIS4h+yJG6lZ+Q03N8qSwKIjyLaHcgN/LC9Ho
	 hDCwEJO4E2RnLN0bjIh7oTLVjKDEzVE9NJ8Ni5tabMNFnKmR7jw2j0fsgfR2Yab9nP
	 gtR5cfU5VSPTA==
Date: Wed, 19 Jun 2024 13:35:04 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
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
Message-ID: <202406191334.EBF96371@keescook>
References: <20240612195412.make.760-kees@kernel.org>
 <20240612195921.2685842-2-kees@kernel.org>
 <e91728af-83e7-453e-816f-add3b0011a66@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e91728af-83e7-453e-816f-add3b0011a66@quicinc.com>

On Wed, Jun 19, 2024 at 11:38:31AM -0700, Jeff Johnson wrote:
> On 6/12/24 12:59, Kees Cook wrote:
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
> ...
> > +kunit_test_suites(&usercopy_test_suite);
> > +MODULE_AUTHOR("Kees Cook <kees@kernel.org>");
> >   MODULE_LICENSE("GPL");
> 
> Can you add the missing MODULE_DESCRIPTION() to remove the W=1 warning?
> 
> The fix to the current file is part of:
> https://lore.kernel.org/all/20240601-md-lib-test-v1-1-a728620e37d8@quicinc.com/

Thanks for the reminder! I've split it out and sent a separate patch to
Shuah.

-- 
Kees Cook

