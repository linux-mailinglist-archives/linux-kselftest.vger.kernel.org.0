Return-Path: <linux-kselftest+bounces-41030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6C0B4A5A6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40421899C0D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E9C24677D;
	Tue,  9 Sep 2025 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n9nlN2sw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C01812CDA5;
	Tue,  9 Sep 2025 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407268; cv=none; b=P9QUlTXxnDyoyXTki0LM+/q+mWtr4iJco34zEoQnPhpoQUtPXJb54aORm/tmTAOgJcLGcZSkUoKsteyHtpdOvNBNFriTVTHdShB/dH4YaTuEIm/1/DhOcv7a8UMahzC3fi0q+Jkg5wca3fdPnrqAsDL09kyIHwha7J5YljmBUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407268; c=relaxed/simple;
	bh=uGMEncP4lHGM2Qp/+McTsbe9kY1ggJx8acYpyzupD0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MM8hrTjBxOgz+JybQUR8pdQO4LhTsY+2i7R08hQ5oKtyaVXFXFHdnm8V/vgqkfRe3/8gwFRXYJWh7cHkCxzu6vGQT5lq2CdccSemIvl8jlpk5bc9Wzwg+gJyc+6sKsXZ5CGtmaKyD5G5UOBrJ1ubaBg9JCT469V48iGyxdUGXak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n9nlN2sw; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D1B927A0186;
	Tue,  9 Sep 2025 04:41:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 09 Sep 2025 04:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757407264; x=1757493664; bh=gi7Pj5E1v28dezpa9bz0Nq1rTfOXCLwcpi8
	93ag3yOI=; b=n9nlN2swWRzimk73YF2KLuCISCz0MUY3PJbPNGLMOPWATPhYRUZ
	86lGBKEAlSP9qRpuXZCgm8Itvl1eeObaecoxpDK7FORPEMW9WguHTNJ69XVZFW2R
	/hRdkc4D+MQ7Y5+J7fAK7l1KW9DaSe+tD99VjTl0EnxTabWXvlP+Ehyb36Fh0vfw
	zFU8Sdrv9wXE58aeeiRGu8yXlCAUGFY3UqWz9UPNxUT/FMg0rBF6RCeK4fuW9rlQ
	mokJt/P63U2mgK8SfcvsyY4RAiTpIWxdSLrMYLK947E+IUdDwEnZFI+oHW/POHsR
	Dqwo3H1/vfMDjT7JUxqy0SxZn2epjQg8vqg==
X-ME-Sender: <xms:IOi_aBl_krOwA77Dbn9_S-BlrAAYpnJWAeuY_wC_4Y-5flVftP5z2A>
    <xme:IOi_aLyYx4CWMsxGciuAwd2obIbbqKBb52CfqBYU09l6tM3DBU8YbSXwnPzcIxU-W
    Opcx8OTiwFCTuo>
X-ME-Received: <xmr:IOi_aDtjLzEdgdUX9SEjal-abm3A2yfx_G7dy9hEqu3tZqO-TVu2sIUVnI6ZFhoaPSKRFcVvrsXWzRkj4llrxNM1FCEH7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughosh
    gthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepihdrmhgrgihimhgvthhssehovhhnrdhorhhgpdhrtghpth
    htohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggr
    vhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsth
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IOi_aFGym4lRSDvwMpvdy1mli_8Yc6qRh1hfyG1zZuNrAnRzQoKo4Q>
    <xmx:IOi_aB6CvXBBS2g3BOyqlb_E2WFvFdXRm7QXRgDqFVF7Z6HhMq3_uw>
    <xmx:IOi_aGxl6lWQ8U_GlYGM3trwAe1F1tDN7F4-jw8qt1TdvuE7f5Xpjw>
    <xmx:IOi_aH2WLwd1kqHKna2KhdJw8NNnK0ZTp8SQ_ihc03_L6Wvus6amcg>
    <xmx:IOi_aBNzIqSAVbXQFpnG7AoFvbHyjvd1Nq8SbrHhCbzvBRbrT4EtBTGj>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 04:41:03 -0400 (EDT)
Date: Tue, 9 Sep 2025 11:41:01 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, dev@openvswitch.org,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net 1/2] net: dst_metadata: fix IP_DF bit not extracted
 from tunnel headers
Message-ID: <aL_oHVTjm6zw9AJO@shredder>
References: <20250905133105.3940420-1-i.maximets@ovn.org>
 <20250905133105.3940420-2-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905133105.3940420-2-i.maximets@ovn.org>

On Fri, Sep 05, 2025 at 03:30:55PM +0200, Ilya Maximets wrote:
> @@ -220,9 +221,15 @@ static inline struct metadata_dst *ip_tun_rx_dst(struct sk_buff *skb,
>  						 int md_size)
>  {
>  	const struct iphdr *iph = ip_hdr(skb);
> +	struct metadata_dst *tun_dst;
> +
> +	tun_dst = __ip_tun_set_dst(iph->saddr, iph->daddr, iph->tos, iph->ttl,
> +				   0, flags, tunnel_id, md_size);
>  
> -	return __ip_tun_set_dst(iph->saddr, iph->daddr, iph->tos, iph->ttl,
> -				0, flags, tunnel_id, md_size);
> +	if (iph->frag_off & htons(IP_DF))
> +		__set_bit(IP_TUNNEL_DONT_FRAGMENT_BIT,
> +			  tun_dst->u.tun_info.key.tun_flags);

Shouldn't you check that tun_dst isn't NULL?

> +	return tun_dst;
>  }

