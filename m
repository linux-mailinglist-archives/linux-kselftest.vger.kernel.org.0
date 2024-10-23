Return-Path: <linux-kselftest+bounces-20456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E5C9ACA97
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 14:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D0E28584C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 12:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7071ABEC2;
	Wed, 23 Oct 2024 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD+HeDHz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6C5130AF6;
	Wed, 23 Oct 2024 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688000; cv=none; b=bIknLIAa+0XqIwpFJC9fu/tDfvPEpy69fE2Zy7F3McYhfGSdLkEwcgtCFaNFdKaU3efQKRsyYd8+PGZGwzYHt6vvU8mQSvJmdH8TNAdZoaK19sLPZvFwljj+VrW+frWY08F0W0fR88J76OxU1za75Dtw5QfzEXfPouQovkKk2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688000; c=relaxed/simple;
	bh=9b1bOhAZeBnM1ep/WL9U4PBR0QzVhyeZ4WRixU2ma70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKXW10gT2t6bgaqpfr1sTfVWxcP0ppz1Z9UYyPK1wwnvZMVJCGDDRvCs5YZ3641pyUPGI2vzLIWdUX5gd3Zh4pJY4tyhi0j1lZhVOs3frIzh0jumKyiIEu0OIG4/YN3ui0fTKVSHt60uRgy48qyE4ejdhfUVB/eOVlqOujQ2g7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD+HeDHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A228C4CEC6;
	Wed, 23 Oct 2024 12:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729687999;
	bh=9b1bOhAZeBnM1ep/WL9U4PBR0QzVhyeZ4WRixU2ma70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HD+HeDHziSLS/IRkYLlS7NGHmr1wPvi60BjBAyPsWPzXtX+3Cy8JG3z2Vprg9YaCd
	 2oS9nzlH4uvhUuTO60s+PHFR8WmhJAnbPl4esPRgyy3q2CHPVTk2Fdh5/6gBr+fD35
	 +/L6xKoFKlkrAe/xsqghFM6VN/H4iHVrZ+G2SQ4dwwCpcefA1XwiPE57yPFVZK1l0r
	 9itd8qG0+gNglTDrwDB/RQbudmMxptrHsBiUKKLsefXdTgTHnfGeS6cbGBOuP5dobM
	 70owuj6t9qCU4RL/GeMQqhHY8wlw6u4lNd5CkfPMkV5Km2CiRx54AmTko3mh9Y9Dr6
	 0Pf/9Ui38Wmtg==
Date: Wed, 23 Oct 2024 13:53:14 +0100
From: Simon Horman <horms@kernel.org>
To: Leo Stone <leocstone@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, 0x7f454c46@gmail.com,
	rdunlap@infradead.org, mnassiri@ciena.com,
	jiapeng.chong@linux.alibaba.com, colin.i.king@gmail.com,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] selftest/tcp-ao: Add filter tests
Message-ID: <20241023125314.GV402847@kernel.org>
References: <20241021174652.6949-1-leocstone@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021174652.6949-1-leocstone@gmail.com>

On Mon, Oct 21, 2024 at 10:46:44AM -0700, Leo Stone wrote:
> Add tests that check if getsockopt(TCP_AO_GET_KEYS) returns the right
> keys when using different filters.
> 
> Sample output:
> 
> > # ok 114 filter keys: by sndid, rcvid, address
> > # ok 115 filter keys: by is_current
> > # ok 116 filter keys: by is_rnext
> > # ok 117 filter keys: by sndid, rcvid
> > # ok 118 filter keys: correct nkeys when in.nkeys < matches
> 
> Acked-by: Dmitry Safonov <0x7f454c46@gmail.com>
> Signed-off-by: Leo Stone <leocstone@gmail.com>
> ---
> v3:
>   - Ordered locals in reverse xmas tree order
>   - Separated socket fd declaration from assignment
>   - Broke lines longer than 80 columns
> v2: https://lore.kernel.org/netdev/20241016055823.21299-1-leocstone@gmail.com/
>   - Changed 2 unnecessary test_error calls to test_fail
>   - Added another test to make sure getsockopt returns the right nkeys
>   value when the input nkeys is smaller than the number of matching keys
>   - Removed the TODO that this patch addresses
> v1: https://lore.kernel.org/netdev/20241014213313.15100-1-leocstone@gmail.com/
> 
> Thanks to the reviewers for their time and feedback!

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


