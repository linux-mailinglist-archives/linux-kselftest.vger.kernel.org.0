Return-Path: <linux-kselftest+bounces-13885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0553C934FF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 17:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 768A8B21A2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 15:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F587143C6D;
	Thu, 18 Jul 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2t2Xmhu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA484DF5;
	Thu, 18 Jul 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316856; cv=none; b=WSJm4Q81WE0ypiF/afr2L4ZVKFbOd7FgtCPTqqufb4YNPIrcfkWNHGQamKNQBUwzzRfo5tKHfYzE49PWMdqUB79/DHHrK+OOXkgi7scSEV0YpTO+rEnxxZCz0l5xdJOqcxFOg3Raa2YECo7LULcwIwdwj5dB3ER1NMdkI9iHyoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316856; c=relaxed/simple;
	bh=d8p7JTSMNvZCbWgBO9OlvaoJIKaIcHFTnIofjqs4coY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEtNX4b1uhPYXIVMwA0Xl8amKdAej8GiBUstmPVcp6GzDEoy0wcdSudlkhJE5LQPyD4rZnT5FmqTfdr3K/5Y6zXZLw/V/VXa6Mer672FOqNUs8p+DtNSaUSIoGFCM+1MHTc7Ym8f+HXJT/9pUTvI7AjSu7nKiNlIZ4hqsD1WWzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2t2Xmhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0903C116B1;
	Thu, 18 Jul 2024 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721316855;
	bh=d8p7JTSMNvZCbWgBO9OlvaoJIKaIcHFTnIofjqs4coY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2t2XmhuV5HcuQvM7AcRwmwGB3C54/gs6iv9TwmMjv8U5IMM7fuRXuu/Mn8VQd9rF
	 GJ3hUBs1H80+5VGwtbIg1tYCcWZ2AQmRfIlYiaPJbJZ/4695469zYGcu8FWijcaVDH
	 hJayA+FovUBrisDLh0iOFcPMFEgp/xqRi23bU12layGfKGcJEMjruYYNmK7cTh+CSi
	 VqoayXNXC3mJZS1+K48tozx7e98hgFzrN0EB1RylWUj3qQssCtpBdbn/nBq5ytMBn0
	 iQaTei8XjEFcpoYaI7f2xEGJVlElkCWHVojTBFo7MgPFBONdD4YePWFFYkQFanyRTG
	 FPjhSJmumGdFg==
Date: Thu, 18 Jul 2024 16:34:10 +0100
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
Message-ID: <20240718153410.GA21354@willie-the-truck>
References: <20240712231730.2794-1-rbrasga@uci.edu>
 <f7383c8c-83f3-45da-a8c4-2cfcfa497936@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7383c8c-83f3-45da-a8c4-2cfcfa497936@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 16, 2024 at 09:49:12AM +0530, Dev Jain wrote:
> 
> On 7/13/24 04:47, Remington Brasga wrote:
> > The string passed to ksft_test_result_skip is missing the `type_name`
> > 
> > Signed-off-by: Remington Brasga <rbrasga@uci.edu>
> > ---
> > clang-tidy reported clang-diagnostic-format-insufficient-args warning
> > on this line, so I am fixing it.
> > 
> >   tools/testing/selftests/arm64/abi/ptrace.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
> > index abe4d58d731d..6144f83f8ab4 100644
> > --- a/tools/testing/selftests/arm64/abi/ptrace.c
> > +++ b/tools/testing/selftests/arm64/abi/ptrace.c
> > @@ -156,7 +156,7 @@ static void test_hw_debug(pid_t child, int type, const char *type_name)
> >   		/* Zero is not currently architecturally valid */
> >   		ksft_test_result(arch, "%s_arch_set\n", type_name);
> >   	} else {
> > -		ksft_test_result_skip("%s_arch_set\n");
> > +		ksft_test_result_skip("%s_arch_set\n", type_name);
> >   	}
> >   }
> 
> Okay, I almost forgot that I had a patch fixing this as part of another series:
> https://lore.kernel.org/all/20240625122408.1439097-6-dev.jain@arm.com/
> If that is OK, Will, can you please pull that? Or should I send that as a
> separate patch?

I think Mark already suggested sending that separately:

  | This should ideally be a separate patch, there's no overlap.

and he's right: it's best to keep fixes and features separate.

Will

