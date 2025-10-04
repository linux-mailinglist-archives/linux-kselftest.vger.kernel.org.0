Return-Path: <linux-kselftest+bounces-42767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A998BB900A
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 18:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EED824E5B06
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 16:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B2127FB12;
	Sat,  4 Oct 2025 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxb27xRz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5030200BA1;
	Sat,  4 Oct 2025 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759596250; cv=none; b=mR3MWajn8SN4rkLdShmEcYHY+OGR+x77gjrSl+B0ej0spRTfNotTH8BUITs1ph/v7HtcYhPOnIztoT6zVzm9uO2L27W6uibr0HJrXW8/C6PrBiCn0f6EYudeBvMOvMqT6H1QPgt4MEUhwsLOYJMO4Gv4cJbFyD5slOv9iw3ZvvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759596250; c=relaxed/simple;
	bh=jO/AbpCa4+xRJuTpkPQL04alxeWUrsAD3mII7g9X4eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayt+QeGeTgCCReddn8ynQjDcUNINBVayDdDv6yoiBLXcC4m8gT2Xo9wDGvRJevkvTlKL9AEOJEAWByO0091eMwkABORk7vmNOiHa+Ek5m3mV36pgkjCpeoScQzDdLGwrTBv1Usc7PGPsA8MAbrmuNjROSdQeA/k2mNIss8HIqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxb27xRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE27BC4CEF1;
	Sat,  4 Oct 2025 16:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759596250;
	bh=jO/AbpCa4+xRJuTpkPQL04alxeWUrsAD3mII7g9X4eU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxb27xRztngRMVmpvJ1rmBBaZ2IgyTWYar6ikdfZGOuFSNYXUDbdk+qjqpkiRRwIq
	 CG2wuIY9DBvPCyU8CJ5AxFLVNdnaQd8yVHuFto6008eFGo56uC5y/T91LHftlp0ct4
	 5xQsigT1uDxNWqk1BdCxLiRZfR4m8m+ft/vxrHAmkvO01xl76f5TlBUQNTbbu/OvrO
	 mJrx4QeGXa1WGGPfo39/7P26BcwOsqW1gqbd/efrK3wSh0j9eyxQWWueO9fN9C0QSA
	 EqeNpYxIMMJgn6qfIdqDlF3gg4ZfMaCW7a8/JMpAk3jE3yl4nRzb5KfYULAcWOmx04
	 CqOZgLDv+SN+w==
Date: Sat, 4 Oct 2025 17:44:05 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	shuah@kernel.org, johndale@cisco.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 8/9] selftests: drv-net: pp_alloc_fail: lower traffic
 expectations
Message-ID: <20251004164405.GE3060232@horms.kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
 <20251003233025.1157158-9-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003233025.1157158-9-kuba@kernel.org>

On Fri, Oct 03, 2025 at 04:30:24PM -0700, Jakub Kicinski wrote:

...

> @@ -91,9 +92,14 @@ from lib.py import cmd, tool, GenerateTraffic
>  
>          if s2['rx-alloc-fail'] - s1['rx-alloc-fail'] < 1:
>              raise KsftSkipEx("Allocation failures not increasing")
> -        if s2['rx-alloc-fail'] - s1['rx-alloc-fail'] < 100:
> -            raise KsftSkipEx("Allocation increasing too slowly", s2['rx-alloc-fail'] - s1['rx-alloc-fail'],
> -                             "packets:", s2['rx-packets'] - s1['rx-packets'])
> +        pkts = s2['rx-packets'] - s1['rx-packets']
> +        # Expecting one failure per 512 buffers, 3.1x safety margin
> +        want_fails = math.floor(pkts / 512 / 3.1)
> +        seen_fails = s2['rx-alloc-fail'] - s1['rx-alloc-fail']
> +        if s2['rx-alloc-fail'] - s1['rx-alloc-fail'] < want_fails:

I guess this could be as follows.
(Completely untested!)

        if seen_fails < want_fails:

> +            raise KsftSkipEx("Allocation increasing too slowly", seen_fails,
> +                             "packets:", pkts)
> +        ksft_pr(f"Seen: pkts:{pkts} fails:{seen_fails} (pass thrs:{want_fails})")
>  
>          # Basic failures are fine, try to wobble some settings to catch extra failures
>          check_traffic_flowing()

The nit above withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

