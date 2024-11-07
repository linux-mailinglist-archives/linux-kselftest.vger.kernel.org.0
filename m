Return-Path: <linux-kselftest+bounces-21626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB829C0D68
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8961C213BB
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CFA20B1E2;
	Thu,  7 Nov 2024 18:00:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5A374CB
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Nov 2024 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731002438; cv=none; b=hjJFEHrMOp+7VIvhHezeBfeCNNvqkQYYEUjec7QVErUaol9nPXlKv97YdXLmYhluBk7M0gR79wuNp5OnZqVPaFtsauHFjGNQJDVC4CZrUcK3u51pyHWYfmn6KXCo9sgD4cVHZAE9tgtigVkksRY7xFouGEYeTOIeyQ5kt7EXx5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731002438; c=relaxed/simple;
	bh=6jBTLNeiX11C9EC0GdgiRPR7CvkDdUg30M+pf03qc+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4dnfBjNJZN0X3Awxv9OCQrVdQ4gljxvMdqnuF8JmzT2dugPXucr8jQPAj7mHrjT/zPDkqEqZGIkV8cJFCa4q7KyLRvjkfK3/zL2QY+Ot0GuzIQixpX/ff5vQy3LcCQZolZ72EW+ban8the+MJyUL/mjrauSawgCpeVAqX4YlrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7B4C4CED0;
	Thu,  7 Nov 2024 18:00:36 +0000 (UTC)
Date: Thu, 7 Nov 2024 18:00:34 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, dave.hansen@linux.intel.com,
	yury.khrustalev@arm.com, will@kernel.org,
	linux-kselftest@vger.kernel.org,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH] selftests/mm: Define PKEY_UNRESTRICTED for
 pkey_sighandler_tests
Message-ID: <Zy0AQnqIWRM8s9kb@arm.com>
References: <20241107131640.650703-1-kevin.brodsky@arm.com>
 <96cc8ce1-1f64-45d5-8567-eb2adba1b47a@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96cc8ce1-1f64-45d5-8567-eb2adba1b47a@linuxfoundation.org>

On Thu, Nov 07, 2024 at 09:50:20AM -0700, Shuah Khan wrote:
> On 11/7/24 06:16, Kevin Brodsky wrote:
> > Commit 6e182dc9f268 ("selftests/mm: Use generic pkey register
> > manipulation") makes use of PKEY_UNRESTRICTED in
> > pkey_sighandler_tests. The macro has been proposed for addition to
> > uapi headers [1], but the patch hasn't landed yet.
> > 
> > Define PKEY_UNRESTRICTED in pkey-helpers.h for the time being to fix
> > the build.
> 
> What does mean to say "time being" - can this be removed in the
> future. If so please add a FIXME so this define can be removed
> later.

There's a dependency on this series:

https://lore.kernel.org/r/20241028090715.509527-2-yury.khrustalev@arm.com/

Which I did not notice. Typically the uapi patches are picked by Arnd
but first that series needs to be reposted with the comments addressed.

I think for now we either merge this fix from Kevin (happy to add a
FIXME comment when applying), change the kselftest to use 0 instead of
PKEY_UNRESTRICTED or revert the top two patches here:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/pkey-signal

I'm fine with all options really, it's not essential that we get the
kselftest patches above merged in 6.13.

-- 
Catalin

