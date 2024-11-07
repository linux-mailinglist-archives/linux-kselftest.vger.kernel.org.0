Return-Path: <linux-kselftest+bounces-21648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FCC9C1102
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 22:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D107B1F24422
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 21:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E41194C92;
	Thu,  7 Nov 2024 21:34:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D138FC08
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Nov 2024 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015270; cv=none; b=OwuNbLDPqNXcak4dHVKza2z6s7816HptdvAKvVwuX+MV7BPYfWMq3oqwduyVuxBpyuXpHJj8JXuChYETmvg9Y58a2Vo9hZAoESOk6ZCQ4ygvXlFWluj9rxwVbYakJbjiCvdeTM2Vn0yhIFqytC2gEoealdTAdzO3DD1Qlf5Lo2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015270; c=relaxed/simple;
	bh=Q5vTxyTu7QmWqHf0CKeut3YepRQ9wrffnc9PwVVfmVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8NyZXfUCgOOvzTomM1GpD42pg6VRl4gqrmcc6L9qn8EluypxQUUU8xUBRK4/bxHf4psUYqLLBp/ZkJIq81d91NrmHIzYl389gKEqGVh0yPeaLTiEkRfL1HekT9Ub/8BsLnwUt/TX4+3YHtPrt6OZVRlAMeG24eu3mtDFqsf73c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B35BC4CECC;
	Thu,  7 Nov 2024 21:34:28 +0000 (UTC)
Date: Thu, 7 Nov 2024 21:34:26 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, dave.hansen@linux.intel.com,
	yury.khrustalev@arm.com, will@kernel.org,
	linux-kselftest@vger.kernel.org,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH] selftests/mm: Define PKEY_UNRESTRICTED for
 pkey_sighandler_tests
Message-ID: <Zy0yYo5feyJx1Y6D@arm.com>
References: <20241107131640.650703-1-kevin.brodsky@arm.com>
 <96cc8ce1-1f64-45d5-8567-eb2adba1b47a@linuxfoundation.org>
 <Zy0AQnqIWRM8s9kb@arm.com>
 <50f87b47-e326-4e87-a1d4-cc24ea70f432@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f87b47-e326-4e87-a1d4-cc24ea70f432@linuxfoundation.org>

On Thu, Nov 07, 2024 at 02:26:11PM -0700, Shuah Khan wrote:
> On 11/7/24 11:00, Catalin Marinas wrote:
> > On Thu, Nov 07, 2024 at 09:50:20AM -0700, Shuah Khan wrote:
> > > On 11/7/24 06:16, Kevin Brodsky wrote:
> > > > Commit 6e182dc9f268 ("selftests/mm: Use generic pkey register
> > > > manipulation") makes use of PKEY_UNRESTRICTED in
> > > > pkey_sighandler_tests. The macro has been proposed for addition to
> > > > uapi headers [1], but the patch hasn't landed yet.
> > > > 
> > > > Define PKEY_UNRESTRICTED in pkey-helpers.h for the time being to fix
> > > > the build.
> > > 
> > > What does mean to say "time being" - can this be removed in the
> > > future. If so please add a FIXME so this define can be removed
> > > later.
> > 
> > There's a dependency on this series:
> > 
> > https://lore.kernel.org/r/20241028090715.509527-2-yury.khrustalev@arm.com/
> > 
> > Which I did not notice. Typically the uapi patches are picked by Arnd
> > but first that series needs to be reposted with the comments addressed.
> > 
> > I think for now we either merge this fix from Kevin (happy to add a
> > FIXME comment when applying), change the kselftest to use 0 instead of
> > PKEY_UNRESTRICTED or revert the top two patches here:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/pkey-signal
> > 
> > I'm fine with all options really, it's not essential that we get the
> > kselftest patches above merged in 6.13.
> 
> I am good with taking this patch as is with a FIXME to cleanup
> later.

Thanks Shuah.

-- 
Catalin

