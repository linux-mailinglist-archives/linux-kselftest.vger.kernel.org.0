Return-Path: <linux-kselftest+bounces-36826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D87FAFEBF1
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 16:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8F447A8369
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A466C2E5411;
	Wed,  9 Jul 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="h6BYp9kP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88079199BC;
	Wed,  9 Jul 2025 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071398; cv=none; b=qda5QveULRsX8+7RnWVktNH60HV12YSMGbQOVPKjdphw59HTan0XC+WNYc2T6I7QBdv3uYS6QV+xD//DPT4SnRx3OHam5cc192Ppiu3BvhTW0MJRzVf0by8lVy0Y6fHD7Ud0dvY7lATj2VdaDJXlJ+/l0Ej1PV4zQBGlUYhM/3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071398; c=relaxed/simple;
	bh=OUT7KbF6CQ9rHPR3HGruIExLwL/ZtqXhyih9LkgnWSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgiSGmZQRWFRc7g4iw5djOqMHvAQSdQ0TN22TmwUSUFljYyTGs1mEt/gD7trgiHwjZGC2x5YaIc0YjMM2facyZO0cmJM/El2LowBdVQoDVuENT44oCU/REOM7RtE0dwGeLUO/gWcSPPEWYgAiatGrDFcGrLDImwciWCKWd+q40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=h6BYp9kP; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Yb0tB2UsNC9QnGsUbM1FKMTHaAE1j+r2KMc0JBfGmc8=; b=h6BYp9kPNLeDg6ZE5fs+3fr9Dx
	/Ghoe7c+YcnY/e2gEuX3pk+GRK43M8BpYvU2GdsQehoEl13SQk1z1Nnbkig3Al4LNaTgAZ6P4v+0Q
	WkY5ehslhN9syfUvDrLD+/7UDaKSJiR58tI+fkGjSckg4MKFTt70h+7eLGaQyLr8wB172sIeRCY5e
	WY51hLaHFpKFeip1bMkUX3xspkGGB8Kw5A3PHVvFwp9SPbNEmNIAS9nv0lXtvkaZLcqn8p9rRgCl1
	3/dtusmNS6gaKeRG9Y8BVvGRMAudZT1bWDC3yRIBmUBjXRqitgY3DEFYTVGBGOEtAlFllhnj/WIyR
	BE78wqDw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uZVLI-000G7K-19;
	Wed, 09 Jul 2025 16:00:12 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uZVLH-0002jV-1i;
	Wed, 09 Jul 2025 16:00:10 +0200
Message-ID: <27edae8a-f1a8-4000-ac1e-fd4d5b01e807@iogearbox.net>
Date: Wed, 9 Jul 2025 16:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next,v3 2/2] selftests/bpf: Enhance XDP Rx metadata
 handling
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 "Song, Yoong Siang" <yoong.siang.song@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Magnus Karlsson <magnus.karlsson@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20250702165757.3278625-1-yoong.siang.song@intel.com>
 <20250702165757.3278625-3-yoong.siang.song@intel.com>
 <77463344-1b1a-443a-97be-a7ef8a88b8af@kernel.org>
 <IA3PR11MB92546301B67FB3A9FDCD716DD842A@IA3PR11MB9254.namprd11.prod.outlook.com>
 <88a64a65-bd8c-4b73-af19-6764054d4572@kernel.org>
 <f5d724ab-0eb6-41a1-b694-8aea566e99ab@iogearbox.net>
 <aGvhzDLSuOolCCWW@mini-arch>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <aGvhzDLSuOolCCWW@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27694/Wed Jul  9 10:42:34 2025)

On 7/7/25 5:03 PM, Stanislav Fomichev wrote:
> On 07/04, Daniel Borkmann wrote:
>> On 7/4/25 11:58 AM, Jesper Dangaard Brouer wrote:
>>> On 04/07/2025 03.17, Song, Yoong Siang wrote:
>>>> On Friday, July 4, 2025 1:05 AM, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>>>> On 02/07/2025 18.57, Song Yoong Siang wrote:
>>>>>> Introduce the XDP_METADATA_SIZE macro as a conservative measure to
>>>>>> accommodate any metadata areas reserved by Ethernet devices.
>>>>>
>>>>> This seems like a sloppy workaround :-(
>>>>>
>>>>> To me, the problem arise because AF_XDP is lacking the ability to
>>>>> communicate the size of the data_meta area.  If we had this capability,
>>>>> then we could allow the IGC driver to take some of the space, have the
>>>>> BPF-prog expand it futher (bpf_xdp_adjust_meta) and then userspace
>>>>> AF_XDP would simply be able to see the size of the data_meta area, and
>>>>> apply the struct xdp_meta at right offset.
>>>>>
>>>> Thanks for your input.
>>>>
>>>> I agree with you that the implementation will be simple if user application
>>>> able to get the size of data_meta area. The intention of this patch set is to let
>>>> developer aware of such limitations before we have a perfect solution.
>>>>
>>>> Btw, do you got any suggestion on how to expose the metadata length?
>>>> I not sure whether xdp_desc.options is a simple and good idea or not?
>>>
>>> That is a question to the AF_XDP maintainers... added them to this email.
>>>
>>> /* Rx/Tx descriptor */
>>> struct xdp_desc {
>>>       __u64 addr;
>>>       __u32 len;
>>>       __u32 options;
>>> };
>>>
>>> As far as I know, the xdp_desc.options field isn't used, right?
>>
>> The options holds flags, see also XDP_PKT_CONTD and XDP_TX_METADATA.
>>
>>> (Please AF_XDP experts, please verify below statements:)
>>> Something else we likely want to document: The available headroom in the
>>> AF_XDP frame.  When accessing the metadata in userspace AF_XDP we do a
>>> negative offset from the UMEM packet pointer.  IIRC on RX the available
>>> headroom will be either 255 or 192 bytes (depending on NIC drivers).
>>>
>>> Slightly confusing when AF_XDP transmitting from userspace the UMEM
>>> headroom is default zero (XSK_UMEM__DEFAULT_FRAME_HEADROOM is zero).
>>> This is configurable via xsk_umem_config.frame_headroom, like I did in
>>> this example[1].
>>>
>>> Maybe I did something wrong in[1], because I see that the new method is
>>> setting xsk_umem_config.tx_metadata_len + flag XDP_UMEM_TX_METADATA_LEN.
>>> This is nicely documented in [2]. How does this interact with setting
>>> xsk_umem_config.frame_headroom ?
>>
>> If you request XDP_UMEM_TX_METADATA_LEN then on TX side you can fill
>> struct xsk_tx_metadata before the start of packet data, that is,
>> meta = data - sizeof(struct xsk_tx_metadata). The validity of the
>> latter is indicated via desc->options |= XDP_TX_METADATA and then
>> you fill meta->flags with things like XDP_TXMD_FLAGS_CHECKSUM to
>> tell that the related fields are valid (ex. request.csum_start,
>> request.csum_offset) and that you expect the driver to do the
>> offload with this info. This is also what I mentioned in the other
>> thread some time ago that imho it would make sense to have this also
>> on RX side somewhat similar to virtio_net_hdr..
> 
> Let's at least document the current behavior where some (small minority of)
> drivers can reuse the rx metadata area for some of its state? If we want
> to improve on that by adding another knob, we can follow up?
> (but I remember last time it was discussed, about a year ago, people
> were not enthusiastic about another parameter exported as uapi)

But its still fundamentally broken no? Unless there is no harm for BPF devs
to override that rx metadata area when the pkt later on goes up the stack, but
it sounds this is not the case here. Iiuc, Yoong is trying a different approach
now to prepend before data_hard_start [0]? Then if BPF prog needs it, igc
already implements xmo_rx_timestamp callback which can copy it from there.

   [0] https://lore.kernel.org/bpf/20250707191742.662aeffb@kernel.org/

