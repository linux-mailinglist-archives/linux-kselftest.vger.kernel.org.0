Return-Path: <linux-kselftest+bounces-28075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC25A4C87C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 18:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2EC18892A3
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF58232379;
	Mon,  3 Mar 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DijonD+M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703BC20E706;
	Mon,  3 Mar 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019634; cv=none; b=rf1pM93BO/1udyM3TBCaE+TT1wBu+v4TJ3H1DeZLUwr8vx1YDOsTzbl7TZIU78R2nHz/UtjvdALy/u1FNzXLXMHGv1nZri9UZ79zxWg8pwrlwIwbY5SEoSMWnyrtBym+6YMylRKm0OR0qoyC9lzhpK5/SG7PimRAvvJNaEnVJWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019634; c=relaxed/simple;
	bh=kXL73sjW9CE6qW2km9AaFyZiQTVa+1IdrzDGd3cNszo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W81V9p85kOb/1m+8JbkzSlWPW6MdpuQRWA/Zu9QpDYkhSokrrDFLN1Jtr2avZnjh95QrTnX+FzbW0EDkGOvNRq0e4i3ECF0gyCkpVtJESSQH87DVPeSMMOaDPFeeaCRvI7KxQKEu8MIGztT/XLR+Lm5e+AnFLhzEQ2Km1TTdHCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DijonD+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1ADC4CED6;
	Mon,  3 Mar 2025 16:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019634;
	bh=kXL73sjW9CE6qW2km9AaFyZiQTVa+1IdrzDGd3cNszo=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=DijonD+MX6p+TQYDSVX7lFCVR5+au+A6DEzqIx+A9Ue79cQvzZCDewi4pcu6LQeso
	 9nBl8wr7o/ZuJv0drQyGjxDyXakhIg0cUs/cB0k6ixu4ID2orKKl1NASD3R4SNE1YU
	 QkyROTUKnHSjLbYOClOAwsaYP9wMDZDy2g5IvezgJFAN0U/BilMPBtRexWzmDvGJtt
	 NKCLMUcboAekwVmhy2ZvtOrXCCgA4u+rzhAWnQu/0tEtcfglE+HxMSqhjINzAxw2/a
	 cEpDE0P+eeeEqSE3S0C59LxJKG2aWZU3fDoDJ1rPonLoljk3rV6sPcAfZhhs2Gqb2H
	 Zqux9FNh8IXNg==
Date: Mon, 3 Mar 2025 08:33:51 -0800
From: Kees Cook <kees@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org,
	akpm@linux-foundation.org, jannh@google.com,
	torvalds@linux-foundation.org, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org,
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
	ojeda@kernel.org, thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com, johannes@sipsolutions.net,
	pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org,
	anna-maria@linutronix.de, mark.rutland@arm.com,
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com, Jeff Xu <jeffxu@google.com>
Subject: Re: [PATCH v8 0/7] mseal system mappings
Message-ID: <202503030832.200CF1F46@keescook>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <o2ynggupddg2iscald76q5niaipssy3gkmsvdkvobopc5whvah@ealwojbiwsrn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o2ynggupddg2iscald76q5niaipssy3gkmsvdkvobopc5whvah@ealwojbiwsrn>

On Mon, Mar 03, 2025 at 09:59:13AM -0500, Liam R. Howlett wrote:
> * jeffxu@chromium.org <jeffxu@chromium.org> [250303 00:09]:
> 
> ...
> 
> > 
> > Link: https://lore.kernel.org/all/20240415163527.626541-1-jeffxu@chromium.org/ [1]
> > Link: Documentation/userspace-api/mseal.rst [2]
> > Link: https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/ [3]
> > Link: https://lore.kernel.org/all/CABi2SkV6JJwJeviDLsq9N4ONvQ=EFANsiWkgiEOjyT9TQSt+HA@mail.gmail.com/ [4]
> > Link: https://lore.kernel.org/all/202502251035.239B85A93@keescook/ [5]
> > 
> > -------------------------------------------
> > History:
> > 
> > V8:
> >   - Change ARCH_SUPPORTS_MSEAL_X to ARCH_SUPPORTS_MSEAL_X (Liam R. Howlett)
> 
> It looks like this was captured wrong in just this update. Change
> ARCH_HAS => ARCH_SUPPORTS.  Code looks correct.
> 
> Kees also ran down the meaning of the two more than I did, so thanks
> again Kees!

You're welcome; I'm glad I did it -- I really need to capture that
research somewhere. Perhaps a blog post ... I can't really find a good
place in Documentation/ ? Hmmm

-- 
Kees Cook

