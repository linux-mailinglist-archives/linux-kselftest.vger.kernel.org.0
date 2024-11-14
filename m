Return-Path: <linux-kselftest+bounces-22018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6435A9C85F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 10:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DF4281494
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC501F756F;
	Thu, 14 Nov 2024 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP/rtEcP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54231F7080;
	Thu, 14 Nov 2024 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576118; cv=none; b=pgLsCSZhAtOwo5PrXiOpDCJN2TW9jxrwwZqXEPEVxOqFZc8+3HuFp+8W8Ex2hTxhsb/2Iztal2hJkK+bCzogSY69OfaODR1vLFQWIQRFS/jMR7TJh2cerhgR3dmUWxFGoOzU7ACNI3mLHJZ1PW1lIKcxICODpWOoPZHLPs2Ln3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576118; c=relaxed/simple;
	bh=7sEaFY5IRoBtRg1w0T7nk2HUDWONRPivEmvxLWKHsew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrhHlG25J+6Tc6WwqqLVUgCDomYOpFK1w4yXBdMQAswSQWSlataEFG0drdo18RHw3EZTSO21VdQv7m8E93odqjUY9bPvYzqSIqa66Y0OxvDP330CwvAdczWTzrQOC3/y3ged5DAwGZrIwAKRJpLNMQ/0wOaUP2AGLaubqXo6ptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dP/rtEcP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43169902057so3640225e9.0;
        Thu, 14 Nov 2024 01:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731576115; x=1732180915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhD+uFwTj25ATmY0mBRTPAOZpI27ml7TJhCc2zi/lUA=;
        b=dP/rtEcPWVvsjEnnGf6ym/L8Cvd2xzT9DA1fDKGrULNH/JliuLRHCXrzQb0TCMNLKc
         leCWDfzpQ2tPWd/43wflrKr3pMxAjQwJ62eucdY1zkzTDPASL6YeWXnSoVOP05Vce6QQ
         SeXlrSt/8Y5t7qaTTTYm0OgC6k5qYahvgtzKoTNdwnRlpQIa+8a0E6WHQYyGcpkbrXUf
         Frb/y4jCSEvb/0qQLYTQDZTtOuM2o7T44H+Badesfpqfk89s3o7HDktv3TnHzFdVuBAE
         PPvnXTJHDLSX3b3xbnx7l35Y44lMCZ2g7pLYLGrKaLkY+RkCjhz46PfztrJSmzhcl+E6
         5IiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731576115; x=1732180915;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhD+uFwTj25ATmY0mBRTPAOZpI27ml7TJhCc2zi/lUA=;
        b=D02jo0z4ZLzV9G1pX+eELwdjpaQylXp2gj2XtX/Uo8R9+fPb7eKkEKOBVPV/4DnBqy
         4JUXiNy1fsgme45qlyHhqzGVFFTdX4JrMBrbKo6By7lVmkSmS9u9DJViIumNztKkghtr
         C8el7BCmZSzlOIUN5NwtAvOhmwUG1SwaVBKNrIGDX6Q3xRb0xKI16hsF9bq0Iifcm4TD
         Yj6qqpVDZAuWMMii0YjI0Di1CJsAOquFLQQOM8RyGtkLYcDwzy02AHsM80LeC++EoT4L
         TF6XERx9X4H8ZL595UG91M7PB+cPVNg8maL3AWBmF5eNqJSVH/sfTTm2s48cqu3sEwBw
         cKnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz2UlKIJa30dLXXL+DJPx6nutLi+2IrmvOTG22ew8f0TVEUPP0NTRXuBBkOcHbLYssvgOCZ0oM@vger.kernel.org, AJvYcCXaF8oNZ5+6NTqadtV1vSGGn3SJL+ftviemfpecwtFJLbEsdUxBZs9K6lYADuKD7jR67Gz6w6KVGWjhp2XuI1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6v0DJ5mIW8ny5V06RWc5whjr5E5muX/XbVKvoaXKEsnV34KaC
	3oK+Dl9FoY2yWS/3unj1dRd4LlrND2OWZEJoL8q7CM/CFaxYbLb/
X-Google-Smtp-Source: AGHT+IGg1P1+A99NyseVQJ5AXBXKpgMDrIYyFmdn1SAkeZzXEsvByjUmgNJYQpj/bUUyVHJg4kuZ0w==
X-Received: by 2002:a05:600c:1910:b0:431:680e:95ff with SMTP id 5b1f17b1804b1-432cce723d3mr82840475e9.9.1731576114738;
        Thu, 14 Nov 2024 01:21:54 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432daafc6b3sm14097595e9.0.2024.11.14.01.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:21:54 -0800 (PST)
Date: Thu, 14 Nov 2024 09:21:52 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: edward.cree@amd.com
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, Edward Cree <ecree.xilinx@gmail.com>,
	netdev@vger.kernel.org, linux-net-drivers@amd.com, horms@kernel.org,
	andrew+netdev@lunn.ch, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: ethtool: only allow set_rxnfc with rss
 + ring_cookie if driver opts in
Message-ID: <20241114092152.GA666860@gmail.com>
Mail-Followup-To: edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, horms@kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1731499021.git.ecree.xilinx@gmail.com>
 <cc3da0844083b0e301a33092a6299e4042b65221.1731499022.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc3da0844083b0e301a33092a6299e4042b65221.1731499022.git.ecree.xilinx@gmail.com>

On Wed, Nov 13, 2024 at 12:13:09PM +0000, edward.cree@amd.com wrote:
> 
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Ethtool ntuple filters with FLOW_RSS were originally defined as adding
>  the base queue ID (ring_cookie) to the value from the indirection table,
>  so that the same table could distribute over more than one set of queues
>  when used by different filters.
> However, some drivers / hardware ignore the ring_cookie, and simply use
>  the indirection table entries as queue IDs directly.  Thus, for drivers
>  which have not opted in by setting ethtool_ops.cap_rss_rxnfc_adds to
>  declare that they support the original (addition) semantics, reject in
>  ethtool_set_rxnfc any filter which combines FLOW_RSS and a nonzero ring.
> (For a ring_cookie of zero, both behaviours are equivalent.)
> Set the cap bit in sfc, as it is known to support this feature.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/ef100_ethtool.c | 1 +
>  drivers/net/ethernet/sfc/ethtool.c       | 1 +
>  include/linux/ethtool.h                  | 4 ++++
>  net/ethtool/ioctl.c                      | 5 +++++
>  4 files changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/ef100_ethtool.c b/drivers/net/ethernet/sfc/ef100_ethtool.c
> index 5c2551369812..6c3b74000d3b 100644
> --- a/drivers/net/ethernet/sfc/ef100_ethtool.c
> +++ b/drivers/net/ethernet/sfc/ef100_ethtool.c
> @@ -59,6 +59,7 @@ const struct ethtool_ops ef100_ethtool_ops = {
>  	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
>  	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
>  	.rxfh_per_ctx_key	= true,
> +	.cap_rss_rxnfc_adds	= true,
>  	.rxfh_priv_size		= sizeof(struct efx_rss_context_priv),
>  	.get_rxfh		= efx_ethtool_get_rxfh,
>  	.set_rxfh		= efx_ethtool_set_rxfh,
> diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
> index bb1930818beb..83d715544f7f 100644
> --- a/drivers/net/ethernet/sfc/ethtool.c
> +++ b/drivers/net/ethernet/sfc/ethtool.c
> @@ -263,6 +263,7 @@ const struct ethtool_ops efx_ethtool_ops = {
>  	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
>  	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
>  	.rxfh_per_ctx_key	= true,
> +	.cap_rss_rxnfc_adds	= true,
>  	.rxfh_priv_size		= sizeof(struct efx_rss_context_priv),
>  	.get_rxfh		= efx_ethtool_get_rxfh,
>  	.set_rxfh		= efx_ethtool_set_rxfh,
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 1199e308c8dd..299280c94d07 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -734,6 +734,9 @@ struct kernel_ethtool_ts_info {
>   * @rxfh_per_ctx_key: device supports setting different RSS key for each
>   *	additional context. Netlink API should report hfunc, key, and input_xfrm
>   *	for every context, not just context 0.
> + * @cap_rss_rxnfc_adds: device supports nonzero ring_cookie in filters with
> + *	%FLOW_RSS flag; the queue ID from the filter is added to the value from
> + *	the indirection table to determine the delivery queue.
>   * @rxfh_indir_space: max size of RSS indirection tables, if indirection table
>   *	size as returned by @get_rxfh_indir_size may change during lifetime
>   *	of the device. Leave as 0 if the table size is constant.
> @@ -956,6 +959,7 @@ struct ethtool_ops {
>  	u32     cap_rss_ctx_supported:1;
>  	u32	cap_rss_sym_xor_supported:1;
>  	u32	rxfh_per_ctx_key:1;
> +	u32	cap_rss_rxnfc_adds:1;
>  	u32	rxfh_indir_space;
>  	u16	rxfh_key_space;
>  	u16	rxfh_priv_size;
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 7da94e26ced6..d86399bcf223 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -992,6 +992,11 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
>  	if (rc)
>  		return rc;
>  
> +	/* Nonzero ring with RSS only makes sense if NIC adds them together */
> +	if (info.flow_type & FLOW_RSS && !ops->cap_rss_rxnfc_adds &&
> +	    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
> +		return -EINVAL;
> +
>  	if (ops->get_rxfh) {
>  		struct ethtool_rxfh_param rxfh = {};
>  

