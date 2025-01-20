Return-Path: <linux-kselftest+bounces-24766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D929CA166A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 07:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53ED01884B52
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 06:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6077C18787F;
	Mon, 20 Jan 2025 06:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsI8qbEj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C325383;
	Mon, 20 Jan 2025 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737354385; cv=none; b=Qu92wBZ1/Rqs0LDozU/ywQQEucVW3q8AsyON+MXifLpjNzapg9Caqfhb9mELJzkWAftb6pJap0TNQxeD9Rq6s/hGg3p+4LUplobMqUcIXAdStvlpolEBmvdbeCMO8MgZqWqSTnfAyRXoeb2gPrWt8I+U8ZVBZhZIccfZ5qx84xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737354385; c=relaxed/simple;
	bh=tnsWXzYfmvn62Lbs810i3rTWmbN0EXhNDxrDhCk8CD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7B0wRIT3T0OYAw6HeF0oFydEgCtFWhx2/GnUPlvEzG8h1SEL0FIoD6c/4HVRjXJaqwXmRPln0SKBy2kjYpIERQcxDOv9uNfC7++w9WonNej9itGDo70PVF4c9+szl8JPHQASNW9e0fIqvPgA9TKoAn5z4fIJGwYhRwy/afEBNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsI8qbEj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737354384; x=1768890384;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tnsWXzYfmvn62Lbs810i3rTWmbN0EXhNDxrDhCk8CD8=;
  b=gsI8qbEjoLH2YfFIFL5USV/VmJlo6fYr1VpQ6dWImJJyzOnnxknHu57t
   xbtijikuJ6lN+R0mSlBYF6Jn/qCBvxUCMtC/3u4A3/5BWlsnHN1ysa5UT
   ICHMMEXh0hkhxJtQQ2wwlFadd/mrJj+vh985wPccLawqx356IXy8zzkfv
   6/S8XrQY3RVVgWv7R8V/UaXcrBI1Gyj0zJuo6Vl+LV95u5Qq3DK9rvNNK
   yQKJNFHX2XNHCRV0CpapQF/EGgFJC5n13wdMNc11WiQ2gXlJBH6IyTzL8
   Ttpg84BoVUa/WUXX7VkrU+cqb0v9sTbimDgdBS2DLv8aDdF/jTkMM2kR6
   Q==;
X-CSE-ConnectionGUID: 32tkYXHESoCIyNNDKXjxTQ==
X-CSE-MsgGUID: y9NCaxrOQiKk4j+wIU0ehQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="37622989"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="37622989"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 22:26:15 -0800
X-CSE-ConnectionGUID: 2o19Sr1rR0+02sq9LFLQ2g==
X-CSE-MsgGUID: X0kZiFOHTdmNQOkx3eVPsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106227294"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.64.131]) ([10.247.64.131])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 22:26:01 -0800
Message-ID: <84770113-2546-4035-8bd4-bf9cedcfb00f@linux.intel.com>
Date: Mon, 20 Jan 2025 14:25:45 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 4/4] igc: Add launch time support to XDP ZC
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
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
 xdp-hints@xdp-project.net
References: <20250116155350.555374-1-yoong.siang.song@intel.com>
 <20250116155350.555374-5-yoong.siang.song@intel.com>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250116155350.555374-5-yoong.siang.song@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Siang.

On 16/1/2025 11:53 pm, Song Yoong Siang wrote:
> Enable Launch Time Control (LTC) support to XDP zero copy via XDP Tx
> metadata framework.
> 
> This patch is tested with tools/testing/selftests/bpf/xdp_hw_metadata on
> Intel I225-LM Ethernet controller. Below are the test steps and result.
> 
> Test Steps:
> 1. At DUT, start xdp_hw_metadata selftest application:
>     $ sudo ./xdp_hw_metadata enp2s0 -l 1000000000 -L 1
> 
> 2. At Link Partner, send an UDP packet with VLAN priority 1 to port 9091 of
>     DUT.
> 
> When launch time is set to 1s in the future, the delta between launch time
> and transmit hardware timestamp is equal to 0.016us, as shown in result
> below:
>    0x562ff5dc8880: rx_desc[4]->addr=84110 addr=84110 comp_addr=84110 EoP
>    rx_hash: 0xE343384 with RSS type:0x1
>    HW RX-time:   1734578015467548904 (sec:1734578015.4675) delta to User RX-time sec:0.0002 (183.103 usec)
>    XDP RX-time:   1734578015467651698 (sec:1734578015.4677) delta to User RX-time sec:0.0001 (80.309 usec)
>    No rx_vlan_tci or rx_vlan_proto, err=-95
>    0x562ff5dc8880: ping-pong with csum=561c (want c7dd) csum_start=34 csum_offset=6
>    HW RX-time:   1734578015467548904 (sec:1734578015.4675) delta to HW Launch-time sec:1.0000 (1000000.000 usec)
>    0x562ff5dc8880: complete tx idx=4 addr=4018
>    HW Launch-time:   1734578016467548904 (sec:1734578016.4675) delta to HW TX-complete-time sec:0.0000 (0.016 usec)
>    HW TX-complete-time:   1734578016467548920 (sec:1734578016.4675) delta to User TX-complete-time sec:0.0000 (32.546 usec)
>    XDP RX-time:   1734578015467651698 (sec:1734578015.4677) delta to User TX-complete-time sec:0.9999 (999929.768 usec)
>    HW RX-time:   1734578015467548904 (sec:1734578015.4675) delta to HW TX-complete-time sec:1.0000 (1000000.016 usec)
>    0x562ff5dc8880: complete rx idx=132 addr=84110

To be cautious, could we perform a stress test by sending a higher number 
of packets with launch time? For example, we could send 200 packets, each 
configured with a launch time, and verify that the driver continues to 
function correctly afterward.

> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 78 ++++++++++++++++-------
>   1 file changed, 56 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 27872bdea9bd..6857f5f5b4b2 100644
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

The function igc_insert_empty_packet() appears to wrap existing code to 
enhance reusability, with no new changes related to enabling launch-time 
XDP ZC functionality. If so, could we split this into a separate commit? 
This would make it clearer for the reader to distinguish between the 
refactoring changes and the new changes related to enabling launch-time XDP 
ZC support.

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
> @@ -2955,9 +2957,33 @@ static u64 igc_xsk_fill_timestamp(void *_priv)
>   	return *(u64 *)_priv;
>   }
>   
> +static void igc_xsk_request_launch_time(u64 launch_time, void *_priv)
> +{
> +	struct igc_metadata_request *meta_req = _priv;
> +	struct igc_ring *tx_ring = meta_req->tx_ring;
> +	__le32 launch_time_offset;
> +	bool insert_empty = false;
> +	bool first_flag = false;
> +
> +	if (!tx_ring->launchtime_enable)
> +		return;
> +
> +	launch_time_offset = igc_tx_launchtime(tx_ring,
> +					       ns_to_ktime(launch_time),
> +					       &first_flag, &insert_empty);
> +	if (insert_empty) {
> +		igc_insert_empty_packet(tx_ring);
> +		meta_req->tx_buffer =
> +			&tx_ring->tx_buffer_info[tx_ring->next_to_use];
> +	}
> +
> +	igc_tx_ctxtdesc(tx_ring, launch_time_offset, first_flag, 0, 0, 0);
> +}
> +
>   const struct xsk_tx_metadata_ops igc_xsk_tx_metadata_ops = {
>   	.tmo_request_timestamp		= igc_xsk_request_timestamp,
>   	.tmo_fill_timestamp		= igc_xsk_fill_timestamp,
> +	.tmo_request_launch_time	= igc_xsk_request_launch_time,
>   };
>   
>   static void igc_xdp_xmit_zc(struct igc_ring *ring)
> @@ -2980,7 +3006,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>   	ntu = ring->next_to_use;
>   	budget = igc_desc_unused(ring);
>   
> -	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
> +	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget >= 4) {

Could we add some explanation on what & why the value "4" is used ?


