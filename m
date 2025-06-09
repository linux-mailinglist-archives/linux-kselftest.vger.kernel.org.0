Return-Path: <linux-kselftest+bounces-34487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F11E4AD2295
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 17:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86148188484B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF51F4CB7;
	Mon,  9 Jun 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MTMOvvrQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE2C1D5145;
	Mon,  9 Jun 2025 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483514; cv=none; b=RqBrlkmUNLiPG0+0tI1+fQVEAbs4F9rcVerMdH9Rz9YMjOCzdAsWBRekdd1YYC5M9WpB+u/GVfIdGORd1n1N+F9RQ0MjUWV7EmdxVdK4ZyyxCjTPlaRL04n1HkTtLXZ0xh0nvgWlzSl5cLHk3yxVPrbovJMCvqY9L2uekF12yoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483514; c=relaxed/simple;
	bh=VxYQT9iGU330Ul1J7wWmFlqE4vE/RuZMim22oK1EyWU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaAATLhrvwkOO9GKNQrbaiJ6AMnaf4Ssi3XhGdvH02YnpkOx1jjB/ffV+x44+vgPDg3KJwlhvPP5wE3kVb4fcNrUWZd04RMmXouZImHnyrd4tYvSufQpG4ZA9hsPnDW7vXvLdLdYUGuwZky9dLxD+6hAjBa+J1KdpNr4WkhsBi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MTMOvvrQ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559DtXpb022387;
	Mon, 9 Jun 2025 08:38:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=LTquAi297DdkgHCE2UAv2/ar3
	Gzzjrc2yOniHaqDHWI=; b=MTMOvvrQ5//nI5v90rHDw4RgDG+XcCwnKVaxHBHY/
	45ZfAMh8DZjPRYlD2x1YUSDszPtgKRRws8baf9ir+v97+xwBMk6QxXzi/82NSbb2
	Ugnp4B+mmflV2UybjhJsMZ4PJf0HUkFoaznhfrvP4lZRuFgSQ8ec/75zLZbRs5KI
	hUrDVmMS+oaOrRnqZBDGOddFiZLhG8V8YO6rXaOELzUAqGeaINLUEBB2Mt5opjjQ
	gVaorVIwvaFAUtS7PaHq2NZuT2TaMq6e7Z+hHQlyH68GZmz+cOhMXjZ076fmN4cy
	LnP0yAi5f+dDGmdXjxM5wGgdVdn4LDT6adGoAXt791ZPQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4760x2g6sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 08:38:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Jun 2025 08:38:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Jun 2025 08:38:18 -0700
Received: from 64799e4f873a (unknown [10.28.168.138])
	by maili.marvell.com (Postfix) with SMTP id D8AA83F7075;
	Mon,  9 Jun 2025 08:38:13 -0700 (PDT)
Date: Mon, 9 Jun 2025 15:38:12 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Gal Pressman <gal@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Simon Horman
	<horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Joe Damato
	<jdamato@fastly.com>, <linux-kselftest@vger.kernel.org>,
        Tariq Toukan
	<tariqt@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH net v2 1/2] net: ethtool: Don't check if RSS context
 exists in case of context 0
Message-ID: <aEb_5C9eDYVSkMHn@64799e4f873a>
References: <20250609120250.1630125-1-gal@nvidia.com>
 <20250609120250.1630125-2-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250609120250.1630125-2-gal@nvidia.com>
X-Proofpoint-GUID: HSASOc3I-iDdBAy-mZLQOSZcr-MvctmZ
X-Authority-Analysis: v=2.4 cv=dd2A3WXe c=1 sm=1 tr=0 ts=6846ffeb cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=Cy2GHhHaAAAA:8 a=M5GUcnROAAAA:8
 a=0MoHDKnn0XTSWLzTIuMA:9 a=CjuIK1q_8ugA:10 a=bTms1Ghn32FVZww6NAbk:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=ouN_hsFYTlP13Qa-xo9w:22
X-Proofpoint-ORIG-GUID: HSASOc3I-iDdBAy-mZLQOSZcr-MvctmZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDExNSBTYWx0ZWRfX/V6s8ZRB8ify IpDx8MZcveal8KVn7r5Fe4nE4Zero8ekUNOeBb7qBE6NpZxu/iuHUuzv+5+QZY4jUYe5orw6jMJ rxEOitxMs0KHOC4NIUkMTLnRasNeekaS7Cd4AztbM7YOY2JTBzSFaGgl7ii2OfZ6jXqsjtu5V1k
 QvdWFvrlluKbqJt34upSo8AMeRmK9/yIuZhaZOTyQeQmQ56NxP6uMxf/hdtREp9Veww9UVn6V/W OynEqmuWDGkQOq8MCXMhePTWoKWhximVMnbo83zqXmOl95nFqPH6wr+4zAii2Z4dNiynZ9Z08sJ irawkjX57+yE4M0Va6cWtEvDKqrg3U5TLYPL6WxWDVFpGelzGxWsNCTIjJSAlSNPNM6SbmhVcRJ
 y3AAKZd4eJuef9DB7Rfhsgn5lz3yLMMB0mIloa/xumdtMRvIp0g2I8CJSTDneRoegzjC+hHS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_01,2025-03-28_01

On 2025-06-09 at 12:02:49, Gal Pressman (gal@nvidia.com) wrote:
> Context 0 (default context) always exists, there is no need to check
> whether it exists or not when adding a flow steering rule.
> 
> The existing check fails when creating a flow steering rule for context
> 0 as it is not stored in the rss_ctx xarray.
> 
> For example:
> $ ethtool --config-ntuple eth2 flow-type tcp4 dst-ip 194.237.147.23 dst-port 19983 context 0 loc 618
> rmgr: Cannot insert RX class rule: Invalid argument
> Cannot insert classification rule
> 
> An example usecase for this could be:
> - A high-priority rule (loc 0) directing specific port traffic to
>   context 0.
> - A low-priority rule (loc 1) directing all other TCP traffic to context
>   1.
> 
> Fixes: de7f7582dff2 ("net: ethtool: prevent flow steering to RSS contexts which don't exist")
> Cc: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep

> ---
>  net/ethtool/ioctl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 39ec920f5de7..71c828d0bf31 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1083,7 +1083,8 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
>  		    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
>  			return -EINVAL;
>  
> -		if (!xa_load(&dev->ethtool->rss_ctx, info.rss_context))
> +		if (info.rss_context &&
> +		    !xa_load(&dev->ethtool->rss_ctx, info.rss_context))
>  			return -EINVAL;
>  	}
>  
> -- 
> 2.40.1
> 

