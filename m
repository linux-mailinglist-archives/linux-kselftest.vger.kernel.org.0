Return-Path: <linux-kselftest+bounces-37941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601D0B10533
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 11:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F37560F56
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4010F271452;
	Thu, 24 Jul 2025 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rziww67h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109D217996;
	Thu, 24 Jul 2025 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347938; cv=none; b=CIfM0ofON3g7FRQYZrb4fX6SI5pKJ7G3w+k6tbWG3uHHaNUoy/QLzzweaoQ8kNgnHawO9lWFaqTAi8VA0tXNOCeIIRpodUrg+QOYGqH2Zgtue9ONQIAVIjKAsDkLK1ooIe6x4a+fq+mArzRIYkg+x79+t34NgzeIniR24OlVcVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347938; c=relaxed/simple;
	bh=J4vwdNi5yleEZTeJPm7mSZNO4fVrw9u1M3Z4zlbp8jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWxh9WCKE6tBf66WMSOmnbtYPNJg0RKWdi/+ox79qi7/ed8qg/wqA4hJkCAXahNrndHuUczsXRpbptM06FGypKcOmmCE/EyrcI5VM0Ro/E8foEr+zcUEdGdhdPz6h1ExcxWQ97sUqSqklcnRL1DFlndl+l0upAJyOAT987LXQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rziww67h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5F3C4CEF5;
	Thu, 24 Jul 2025 09:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753347935;
	bh=J4vwdNi5yleEZTeJPm7mSZNO4fVrw9u1M3Z4zlbp8jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rziww67hPlk79s+sXZK6KtR5arnh/MiMAKiYoP9LJNX1BQ7tcVgQS9qEnCZsFgX9U
	 YRhq9AIFM6ZvnvtzdArV4bwRDOi8BOXB3GYw6p3z28h1I99xM/dokljTTwAly73OZV
	 SQSo0sfWGPyQcrjFb2vHSXdWWJXZHpyNDQdo1inMjQpYH4Sq88wZkT+soDdMPuLKsN
	 Fbrau4kueH1GPLNHxCrqb5I8DnCTylBPm2VGbOJRDtBTky97/8AgtJxxBXdyNKBxa+
	 iT4g5AYVUlUjRq1V1xt3aiuuOw4z0PoNBa3bc6RrCEuYjNgdYQ8A0gE/8aUtabTQsC
	 lFDJYlndMrqnA==
Date: Thu, 24 Jul 2025 10:05:28 +0100
From: Simon Horman <horms@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, netdev@vger.kernel.org, cratiu@nvidia.com,
	noren@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
	jdamato@fastly.com, sdf@fomichev.me, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net-next V6 0/5] selftests: drv-net: Test XDP native
 support
Message-ID: <20250724090528.GG1150792@horms.kernel.org>
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
 <175323423849.1016544.9128937268934260157.git-patchwork-notify@kernel.org>
 <48bb190e-073c-4ad8-841b-f6d0572cb0fd@nvidia.com>
 <20250723071253.54a97c65@kernel.org>
 <dc36ad04-c9ae-4e28-bb9e-c2670e5549ab@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc36ad04-c9ae-4e28-bb9e-c2670e5549ab@nvidia.com>

On Wed, Jul 23, 2025 at 07:01:19PM +0300, Gal Pressman wrote:
> On 23/07/2025 17:12, Jakub Kicinski wrote:
> > On Wed, 23 Jul 2025 10:11:57 +0300 Gal Pressman wrote:
> >> On 23/07/2025 4:30, patchwork-bot+netdevbpf@kernel.org wrote:
> >>> Hello:
> >>>
> >>> This series was applied to netdev/net-next.git (main)
> >>> by Jakub Kicinski <kuba@kernel.org>:  
> >>
> >> Jakub, the test was still under active discussion, and you knowingly
> >> merged it with buggy code, ignoring our comments.
> >>
> >> This is *extremely disrespectful* towards people that spent time
> >> reviewing, replying and participating in the netdev mailing list.
> >>
> >> I expect better from you, and other netdev maintainers which allow this
> >> to happen. Please uphold your responsibilities as maintainers towards
> >> the community, this is unacceptable behavior.
> > 
> > Man, I just want tests upstream. How hard is this to understand.
> > 
> > These tests even work on mlx5, AFAIU, just not if LRO is enabled.
> 
> Incorrect.
> 
> > 
> > Please at least try to think about what's good for this community.
> > At least try.
> 
> Blatantly disrespecting the community is not good, it is unprofessional.
> Don't try to justify such actions.

All,

I'd like to ask everyone to take a step back and tone things down a couple
of notches.

Let's work towards improving the tests.
Rather than pursuing the current line of discussion.

Thanks!

