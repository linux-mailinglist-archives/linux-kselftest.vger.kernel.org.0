Return-Path: <linux-kselftest+bounces-25640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29624A26A1B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 03:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD291885EEF
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 02:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E193613E02D;
	Tue,  4 Feb 2025 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUz7AUxy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB84179BD;
	Tue,  4 Feb 2025 02:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738636960; cv=none; b=SaJ6rH5Spy7WCNKkkFrFok6D2DLESMqPLcwKQZZXCBoQ4v/MRvhlYARpWUVM4MQ3Okj43ckmftqezgBU0fOYNP/VLVKu1WvdfaS8twhKp731I3U/+opD08936KVAeL8WSj37YdXoFg3ogtWeVe/Dn68fxGVUPDPTylC/6GAr3/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738636960; c=relaxed/simple;
	bh=192aj1QJsPyGtAMkRPhiiiupVd6SXNH3StPpurpmAIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJi73Rzdvu66y50e9NpMrLzAd8rUrT4wolPNTDZttygXpG+o2HgsD5gv38hhw2WkcjRS6usipVZMhLoO8lKiz9uASCRF3KNs84oQLKwSoB4QDf+1b5kCvPIpjQ3TQlUHnHa0p7yJb7aJpnTUNKbgRYv6Y0nDCV/rQysS2MhpAmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUz7AUxy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738636959; x=1770172959;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=192aj1QJsPyGtAMkRPhiiiupVd6SXNH3StPpurpmAIo=;
  b=CUz7AUxyvo+hz+6dXm+UfXIJDV4141D5LUFGcCPvrV2JtdSwHzCfoqg2
   3aipezKWVU8xhO2K9Q4Qcm5jHtMQ/BsGOrntygGt5GW9B1H8QKYDP0tQZ
   kGEGG4rdmVrQK+H9tFBLMYoDJhVijjmSCpUPeWI1SxoORSNPOvp94/kD1
   PxF9ZWc1npKJ84LIiSxI+J9Ft2i9DJ2DyhfjLN2UM+HGwoRwWzc11JhOq
   B1tHr7OtCREEKTgoKwzAhvozXS9zltSxgt3o5FXBYFGZt5KL53tXXl8EY
   v4Eu5CAnybWuIJgTkst4+V2CKO8TX/VC/uFjNuA8E/+Orb50FnI4y1hXc
   Q==;
X-CSE-ConnectionGUID: pmTCF2+cTOyHvAepcbTjhw==
X-CSE-MsgGUID: x/zZL4pORVyPg4atGXm7Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50564140"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50564140"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 18:42:37 -0800
X-CSE-ConnectionGUID: k5pMJs/eS1KFJUS51BcEEw==
X-CSE-MsgGUID: LsDoyXyXTwW06yE4uEzP3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,257,1732608000"; 
   d="scan'208";a="111051867"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.89.75]) ([10.247.89.75])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 18:42:26 -0800
Message-ID: <a374fa88-433e-4fc9-a63c-fa56f619abd0@linux.intel.com>
Date: Tue, 4 Feb 2025 10:42:13 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 4/5] igc: Refactor empty packet insertion into
 a reusable function
To: Song Yoong Siang <yoong.siang.song@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Topel <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Mina Almasry <almasrymina@google.com>,
 Daniel Jurgens <danielj@nvidia.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Bouska Zdenek <zdenek.bouska@siemens.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
 xdp-hints@xdp-project.net
References: <20250204004907.789330-1-yoong.siang.song@intel.com>
 <20250204004907.789330-5-yoong.siang.song@intel.com>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250204004907.789330-5-yoong.siang.song@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/2/2025 8:49 am, Song Yoong Siang wrote:
> Refactor the code for inserting an empty packet into a new function
> igc_insert_empty_packet(). This change extracts the logic for inserting
> an empty packet from igc_xmit_frame_ring() into a separate function,
> allowing it to be reused in future implementations, such as the XDP
> zero copy transmit function.
> 
> This patch introduces no functional changes.
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 42 ++++++++++++-----------
>   1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 56a35d58e7a6..c3edd8bcf633 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1566,6 +1566,26 @@ static bool igc_request_tx_tstamp(struct igc_adapter *adapter, struct sk_buff *s
>   	return false;
>   }
>   
> +static void igc_insert_empty_packet(struct igc_ring *tx_ring)
> +{
> +	struct igc_tx_buffer *empty_info;
> +	struct sk_buff *empty;
> +	void *data;
> +
> +	empty_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> +	empty = alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
> +	if (!empty)
> +		return;
> +
> +	data = skb_put(empty, IGC_EMPTY_FRAME_SIZE);
> +	memset(data, 0, IGC_EMPTY_FRAME_SIZE);
> +
> +	igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
> +
> +	if (igc_init_tx_empty_descriptor(tx_ring, empty, empty_info) < 0)
> +		dev_kfree_skb_any(empty);
> +}
> +
>   static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>   				       struct igc_ring *tx_ring)
>   {
> @@ -1603,26 +1623,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>   	skb->tstamp = ktime_set(0, 0);
>   	launch_time = igc_tx_launchtime(tx_ring, txtime, &first_flag, &insert_empty);
>   
> -	if (insert_empty) {
> -		struct igc_tx_buffer *empty_info;
> -		struct sk_buff *empty;
> -		void *data;
> -
> -		empty_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> -		empty = alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
> -		if (!empty)
> -			goto done;
> -
> -		data = skb_put(empty, IGC_EMPTY_FRAME_SIZE);
> -		memset(data, 0, IGC_EMPTY_FRAME_SIZE);
> -
> -		igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
> -
> -		if (igc_init_tx_empty_descriptor(tx_ring,
> -						 empty,
> -						 empty_info) < 0)
> -			dev_kfree_skb_any(empty);
> -	}
> +	if (insert_empty)
> +		igc_insert_empty_packet(tx_ring);
>   
>   done:
>   	/* record the location of the first descriptor for this packet */

Reviewed-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

