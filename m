Return-Path: <linux-kselftest+bounces-25921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C98A2A8FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 14:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BB33A70FE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2809122E400;
	Thu,  6 Feb 2025 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihtyc1/W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE4422DF89;
	Thu,  6 Feb 2025 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847101; cv=none; b=NwNIm6kNbnY53zNvPhzmAnwrLjykxJ3uA6nBdS97nG4M2ZWFPgtQn37IEXmmsNsxOyHoOQsgAI0Tr5Hbels7U5BLdc/7DBBcc4TlKaLXfCVv+Oy4kLE4lw7h47G4arl6jxQollE4M3xAjXFQ999Rbw0DRoQ0IO1Nq2pyWegXpzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847101; c=relaxed/simple;
	bh=t2o8FDsmLuwiGZddcqgwIo19XnRmyE8T3EKEBiZzF/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcZ16Ehr/lfQPQ7E62/aaeAYL47sqNg1UH3dwc53GXkxfMhmq8153Y2LzXC/+TSnQX56w6bH1eLGB9zXo72Lo0L4Fuz4zlgHgF4kei3NRR7BsxxTWmyQY1jxQ1oTQiD6syW1kx+OEFHA89p5GNqvFxufdYV6sEA70VAw/mDxB7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihtyc1/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BC5C4CEDF;
	Thu,  6 Feb 2025 13:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738847100;
	bh=t2o8FDsmLuwiGZddcqgwIo19XnRmyE8T3EKEBiZzF/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihtyc1/WHl258ovUgszYqsIr8IWqTe1ncsvqHxfzaMmzlMDAiZe5VKnwQJY5i7Ijr
	 5DUMu69sWOS3YRh5S7dfBiPp5VISV52nS+ZUzM7B9kPDlFqM4OexEDCyiKcaIDYJ+2
	 6NiFiQ7qgBEON37koggqPwjSeNw0u/GA94B3YgIWkUTob5cR6kFKRnhon3OudALTHD
	 2xeQ8G1E2WOE4o7mjk4UzPmCC+Y4czRbe5QG1/yz1RF7czjt2MfKMslSCW7rxv4pjZ
	 ObI/iAf9a1tL74Gg7WEvZtKH9m0SoK8VQQ6C5cb7UOKei5N4OLJs/Fv1EKuYyPTQ3y
	 zBmUjIyZnBZpA==
Date: Thu, 6 Feb 2025 13:04:56 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v4 12/17] net: pktgen: fix mpls maximum labels
 list parsing
Message-ID: <20250206130456.GQ554665@kernel.org>
References: <20250205131153.476278-1-ps.report@gmx.net>
 <20250205131153.476278-13-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205131153.476278-13-ps.report@gmx.net>

On Wed, Feb 05, 2025 at 02:11:48PM +0100, Peter Seiderer wrote:
> Fix mpls maximum labels list parsing up to MAX_MPLS_LABELS/16 entries
> (instead of up to MAX_MPLS_LABELS - 1).
> 
> Fixes:

"Fixes: " has a special meaning, it  is recognised as a tag by tooling, and
implies a bug fix. Please consider some other way of describing this, e.g.

Addresses the following:

> 
> 	$ echo "mpls 00000f00,00000f01,00000f02,00000f03,00000f04,00000f05,00000f06,00000f07,00000f08,00000f09,00000f0a,00000f0b,00000f0c,00000f0d,00000f0e,00000f0f" > /proc/net/pktgen/lo\@0
> 	-bash: echo: write error: Argument list too long
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
> Changes v3 -> v4
>   - new patch (factored out of patch 'net: pktgen: fix access outside of user
>     given buffer in pktgen_if_write()')
> ---
>  net/core/pktgen.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index 84fd88e48275..0fd15f21119b 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -908,6 +908,10 @@ static int get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
>  	pkt_dev->nr_labels = 0;
>  	do {
>  		__u32 tmp;
> +
> +		if (n >= MAX_MPLS_LABELS)
> +			return -E2BIG;
> +
>  		len = hex32_arg(&buffer[i], HEX_8_DIGITS, &tmp);
>  		if (len <= 0)
>  			return len;
> @@ -919,8 +923,6 @@ static int get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
>  			return -EFAULT;
>  		i++;
>  		n++;
> -		if (n >= MAX_MPLS_LABELS)
> -			return -E2BIG;
>  	} while (c == ',');
>  
>  	pkt_dev->nr_labels = n;
> -- 
> 2.48.1
> 

