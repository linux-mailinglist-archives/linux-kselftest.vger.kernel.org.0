Return-Path: <linux-kselftest+bounces-42451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBD5BA3096
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 11:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2840F4C0F8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 09:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463D329B8CF;
	Fri, 26 Sep 2025 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/RKfhzK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18670F4F1;
	Fri, 26 Sep 2025 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877200; cv=none; b=mav6V2l/Wc8z/dnZ6WaijvW/6Fun8ng2ziD4TjTsnbW1wjbm7caJZaqBxgmtvDUL2dN5wB3ujgvtUKMeWIR6Nx5Iilpx5BOP/uwzkOgpJkz0g4OOBlkNyPlpDQ6ozMTY5W35/jgcR4e8znp5KS9cFX+3gf68bz588AMFk1L9hyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877200; c=relaxed/simple;
	bh=L0oABFhpwRrsTJJhUFzKMLEuhir4Lfkj64YL/jUGDeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ag5YBmtV3Ng2K5p2fYIn3q9JesbOKHpHRRfEEFD4ItEsJ5K/q8cTpzjvcXUWteFEiEhDwNZZxpOl1YU7puGCgdYDjR/LOghghAZto8ZjbxQrLv1rARE6AqRtuPhbyf4XL56ipHcDIZRRjsA8mvtnG1Yho53heA/wjWAsW/51+cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/RKfhzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFC2C4CEF5;
	Fri, 26 Sep 2025 08:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758877199;
	bh=L0oABFhpwRrsTJJhUFzKMLEuhir4Lfkj64YL/jUGDeU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R/RKfhzKCAHUUHOUZQQWDSgUR4W9XLp4aoZd/Afp2edAjWaep1kDpOlJX2gReYj2A
	 jKLIeyPDMVYtUt74x3sHfkfe4kqaSnD5spOFAIO0nG5UbVS9gtfc+apHJioZ/lv6s3
	 otvv4LEC9cu1rolLxcTo1LCKrUGNMvPwD10gBAGJ+wNRJDKkRMqu+xtphkGmB2lxrr
	 CFHNGXW+d37fQVoc+j+rvHWaYjntwimBQ0vKZViCqawTt1pUu+0lwg/php8jyujIeu
	 rrqzPzV8NrRogP/53UvNcGN+1SbnoIyM2u3EPKUafk7ZTG0uc2cUz/AGqreYfF+FLp
	 MdMhUzVHxolUw==
Message-ID: <e03d6d69-73ea-46dc-b632-149ef5831f85@kernel.org>
Date: Fri, 26 Sep 2025 10:59:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
 <20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>
 <aNYUqdaIJV1cvFCb@mini-arch>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <aNYUqdaIJV1cvFCb@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/09/2025 06.20, Stanislav Fomichev wrote:
> On 09/25, Lorenzo Bianconi wrote:
>> Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
>> checksum will be use by devices capable of exposing receive checksum
>> result via bpf_xdp_metadata_rx_checksum().
>> Moreover, introduce xmo_rx_checksum netdev callback in order allow the
>> eBPF program bounded to the device to retrieve the RX checksum result
>> computed by the hw NIC.
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> ---
>>   Documentation/netlink/specs/netdev.yaml |  5 +++++
>>   include/net/xdp.h                       | 14 ++++++++++++++
>>   net/core/xdp.c                          | 29 +++++++++++++++++++++++++++++
>>   3 files changed, 48 insertions(+)
>>
>> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
>> index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7fdb67c6b9ee3548098b0c933fd39a4 100644
>> --- a/Documentation/netlink/specs/netdev.yaml
>> +++ b/Documentation/netlink/specs/netdev.yaml
>> @@ -61,6 +61,11 @@ definitions:
>>           doc: |
>>             Device is capable of exposing receive packet VLAN tag via
>>             bpf_xdp_metadata_rx_vlan_tag().
>> +      -
>> +        name: checksum
>> +        doc: |
>> +          Device is capable of exposing receive checksum result via
>> +          bpf_xdp_metadata_rx_checksum().
>>     -
>>       type: flags
>>       name: xsk-flags
>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>> index aa742f413c358575396530879af4570dc3fc18de..9ab9ac10ae2074b70618a9d4f32544d8b9a30b63 100644
>> --- a/include/net/xdp.h
>> +++ b/include/net/xdp.h
>> @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
>>   			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
>>   			   bpf_xdp_metadata_rx_vlan_tag, \
>>   			   xmo_rx_vlan_tag) \
>> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
>> +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
>> +			   bpf_xdp_metadata_rx_checksum, \
>> +			   xmo_rx_checksum)
>>   
>>   enum xdp_rx_metadata {
>>   #define XDP_METADATA_KFUNC(name, _, __, ___) name,
>> @@ -643,12 +647,22 @@ enum xdp_rss_hash_type {
>>   	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
>>   };
>>   
>> +enum xdp_checksum {
>> +	XDP_CHECKSUM_NONE		= CHECKSUM_NONE,
>> +	XDP_CHECKSUM_UNNECESSARY	= CHECKSUM_UNNECESSARY,
>> +	XDP_CHECKSUM_COMPLETE		= CHECKSUM_COMPLETE,
>> +	XDP_CHECKSUM_PARTIAL		= CHECKSUM_PARTIAL,
>> +};
> 
> Btw, might be worth mentioning, awhile ago we had settled on a smaller set of
> exposed types:
> 
> https://lore.kernel.org/netdev/20230811161509.19722-13-larysa.zaremba@intel.com/
> 
> Maybe go through the previous postings and check if the arguments are
> still relevant? (or explain why we want more checksum now)

IHMO the linked proposal reduced the types too much.

I think Lorenzo's suggested types are much better. One argument is of-
cause that the types corresponds directly to the (time proven) types
used by the SKB.

I could argue, that we are lacking a type that indicate hardware
"failed" to do the checksum, but that is indirectly covered by
CHECKSUM_NONE case.  And having BPF-developers deal with both
CHECKSUM_NONE and CHECKSUM_FAIL correctly is a recipe for bugs.

I will explain in another email, why we need to document what
CHECKSUM_NONE actually means.

--Jesper







