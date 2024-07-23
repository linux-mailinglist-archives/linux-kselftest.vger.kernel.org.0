Return-Path: <linux-kselftest+bounces-14082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AF193A2AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 16:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F62EB22D90
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 14:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581E5154448;
	Tue, 23 Jul 2024 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZwzHsRL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CAC153BC3;
	Tue, 23 Jul 2024 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744825; cv=none; b=E7OV+Pf0xMlBHWKY5+6VLBfv03qrHNm7bVSiUyvpioOrRpjxFngHgezMBwOfYJSskvrWD24mvHbJZA3IDkQE0rYRDjR4ZRpnlZq7/l3BFIKEkes6CkDHJN9fz4hCS2JfqMRk8ptr6n8ldp439E1AkzJ4pCeKPV8NJo8Z91jdeEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744825; c=relaxed/simple;
	bh=7p8+QUIt/o5u9kcobf8xw9zEjNAujtG30pEU1dtAIu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzAe8BTuNAO0KMyVO2veT95tWk1pbQ/HHZBU2juMAyhc6xv0RRxPJGGSH4XoPnHQsBSxnTHy+iSmGwgoy+FqEFEwh7zNaMffVElAmclQ/ZQEXDsou44PQ0MSHADvBhQgxqBdPrDGhW3lz4tzzrb3n33Na1uq2DMaol26VPRSVfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZwzHsRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CC2C4AF09;
	Tue, 23 Jul 2024 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721744824;
	bh=7p8+QUIt/o5u9kcobf8xw9zEjNAujtG30pEU1dtAIu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MZwzHsRLgBcFTApi8VYobhEnIruupiECkA/aXNiWV5lFnGwlBh9UpA9Smrv2uxpY3
	 LzOlvVh5y4CLiDtr+8fGDPtum1myziXesXU6w+nSNCUl0ynm1HPtQgRKjFUD/QW9O9
	 u86RMjhh9IZXRtYsuBwm2q81wYO9dpKGqaox997/8bQacX3Xmm/5ZcHD/cYds4Rlb1
	 GxldzerZCKY4TsGjoRlrozEyAcvqFt3mobQfC3lYdAtfkgPR0cgjFLRggBN+UIKxU/
	 Jj0x0ql/gl4Ku7TicIRewQbjzJeZ7cOxcU2x7WiPiHDXuxeZYEalVDYK7+XcKhimQA
	 Qa8YJp6+BVHEQ==
Date: Tue, 23 Jul 2024 15:26:59 +0100
From: Will Deacon <will@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: Remington Brasga <rbrasga@uci.edu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Anshuman.Khandual@arm.com, Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] kselftest: missing arg in ptrace.c
Message-ID: <20240723142659.GB26137@willie-the-truck>
References: <20240712231730.2794-1-rbrasga@uci.edu>
 <f7383c8c-83f3-45da-a8c4-2cfcfa497936@arm.com>
 <20240718153410.GA21354@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718153410.GA21354@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jul 18, 2024 at 04:34:10PM +0100, Will Deacon wrote:
> On Tue, Jul 16, 2024 at 09:49:12AM +0530, Dev Jain wrote:
> > 
> > On 7/13/24 04:47, Remington Brasga wrote:
> > > The string passed to ksft_test_result_skip is missing the `type_name`
> > > 
> > > Signed-off-by: Remington Brasga <rbrasga@uci.edu>
> > > ---
> > > clang-tidy reported clang-diagnostic-format-insufficient-args warning
> > > on this line, so I am fixing it.
> > > 
> > >   tools/testing/selftests/arm64/abi/ptrace.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
> > > index abe4d58d731d..6144f83f8ab4 100644
> > > --- a/tools/testing/selftests/arm64/abi/ptrace.c
> > > +++ b/tools/testing/selftests/arm64/abi/ptrace.c
> > > @@ -156,7 +156,7 @@ static void test_hw_debug(pid_t child, int type, const char *type_name)
> > >   		/* Zero is not currently architecturally valid */
> > >   		ksft_test_result(arch, "%s_arch_set\n", type_name);
> > >   	} else {
> > > -		ksft_test_result_skip("%s_arch_set\n");
> > > +		ksft_test_result_skip("%s_arch_set\n", type_name);
> > >   	}
> > >   }
> > 
> > Okay, I almost forgot that I had a patch fixing this as part of another series:
> > https://lore.kernel.org/all/20240625122408.1439097-6-dev.jain@arm.com/
> > If that is OK, Will, can you please pull that? Or should I send that as a
> > separate patch?
> 
> I think Mark already suggested sending that separately:
> 
>   | This should ideally be a separate patch, there's no overlap.
> 
> and he's right: it's best to keep fixes and features separate.

I didn't spot a patch from you, so I'm going to pick this one up instead.

Will

