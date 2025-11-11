Return-Path: <linux-kselftest+bounces-45328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A425C4EA9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 16:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CABB4FF2D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B27830FC15;
	Tue, 11 Nov 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFO0Tfxh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2999309EE3;
	Tue, 11 Nov 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872964; cv=none; b=GQJAk1Nuhm8kTrDzNNU88dLsNiEN16nNK35mp0PPV2iV+4KNdxV3Iy2/cF8q7V/vGQsOcuKBis+T6SBdnEI+/YGpr6qaLBn6wQViTIzE6RhxT7XDTigHqGcInQzorlvz5PMIhlvwXGf05+KfLuSVPcWfcrw5aPKOHcj07bwxX44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872964; c=relaxed/simple;
	bh=O/PGfeis5HPQNP+TRiiTqX1JHN1m4XlZ7OUntJXfooY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXvP0oltJcfO9SfuKVr1IMXeRmxC0zhdT6wN/11vRk4MdJtFc3J95rWrn+z9RoX+FiqnkX2zCp0eeM0ApgoksrHx2AWiQST0fH4gjBU5LULUU0jxlUsyCSXLM3UAlD6Deltz/bVdbTUKrs5K1KG3mSFNXSzbLTckVAHpRDoGVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFO0Tfxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4798C19422;
	Tue, 11 Nov 2025 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762872963;
	bh=O/PGfeis5HPQNP+TRiiTqX1JHN1m4XlZ7OUntJXfooY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFO0TfxhvNiBJNj3+mPHMLHLr4rm30ye3iGgK0AAEv38u2yJYH2154KNqquD5ZSLg
	 Q3iosAzBw5AGju6tN4PGRK0nZYkYXC4NOsMIUYmpxJtpgiwqcYLxe1JYM97M1zv+d4
	 uCGTMBFP1E84GqSj4/xA/0FpTxxjBS+lG/xZh032Iqzss78c3sb42LUmlJKN/BQeyu
	 OudEJvyn5cKT/xy9SMD5eiemVzS2iIQ246tLhZfaOMQtbgFTq2SozEsxRYjx8Rq5BO
	 xePxEuHvnFI77KNnbRLulb4Azg74dKBgsvRqur6NfoVYUjyKwmnpzRsoNBiWqlDI2O
	 jTS+h12+0ATNg==
Date: Tue, 11 Nov 2025 14:55:58 +0000
From: Simon Horman <horms@kernel.org>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Xing <kernelxing@tencent.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftest: net: fix variable sized type not at the end of
 struct warnings
Message-ID: <aRNOfir6X9FmaUrd@horms.kernel.org>
References: <20251027050856.30270-1-ankitkhushwaha.linux@gmail.com>
 <aQD8AOZduY4Fit3k@horms.kernel.org>
 <aQ9-F34aW__rlMuD@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ9-F34aW__rlMuD@fedora>

On Sat, Nov 08, 2025 at 10:59:59PM +0530, Ankit Khushwaha wrote:
> On Tue, Oct 28, 2025 at 05:23:12PM +0000, Simon Horman wrote:
> > On Mon, Oct 27, 2025 at 10:38:56AM +0530, Ankit Khushwaha wrote:
> > > Some network selftests defined variable-sized types defined at the end of
> > > struct causing -Wgnu-variable-sized-type-not-at-end warning.
> > > 
> > > warning:
> > > timestamping.c:285:18: warning: field 'cm' with variable sized type 
> > > 'struct cmsghdr' not at the end of a struct or class is a GNU 
> > > extension [-Wgnu-variable-sized-type-not-at-end]
> > >   285 |                 struct cmsghdr cm;
> > >       |                                ^
> > > 
> > > ipsec.c:835:5: warning: field 'u' with variable sized type 'union 
> > > (unnamed union at ipsec.c:831:3)' not at the end of a struct or class 
> > > is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
> > >   835 |                 } u;
> > >       |                   ^
> > > 
> > > This patch move these field at the end of struct to fix these warnings.
> > > 
> > > Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
> > 
> > Hi Ankit,
> > 
> > I don't believe this change is correct.
> > 
> > I think that the intention of the code is the char arrays (buf and control)
> > provide the buffer space for the variable-length trailing field
> > of the preceding structure. Where we basically have a header followed
> > by data. But your patch would place the before the header.
> >
> Hi Simon,
> So if buf and control providing the buffer space, then i think it is
> better to suppress `-Wgnu-variable-sized-type-not-at-end` warning 
> within this block of code.
> 
> 	#pragma GCC diagnostic push
> 	#pragma GCC diagnostic ignored "-Wgnu-variable-sized-type-not-at-end"

I'm unsure of the attitude towards using #pragma like this in kernel code,
but certainly it would be a new one for me.

> 
> 	struct {
> 		union {
> 			struct xfrm_algo        alg;
> 			struct xfrm_algo_aead   aead;
> 			struct xfrm_algo_auth   auth;
> 		} u;
> 		char buf[XFRM_ALGO_KEY_BUF_SIZE];
> 	} alg = {};
> 
> 	#pragma GCC diagnostic pop
> 
> I think this would be fine.

In my view, the most promising approach I am aware of is using
TRAILING_OVERLAP(), as illustrated in [1]. However, that
approach was recently rejected, so I guess that means
it doesn't have much promise after all.

[1] https://lore.kernel.org/netdev/aPdx4iPK4-KIhjFq@kspp/

