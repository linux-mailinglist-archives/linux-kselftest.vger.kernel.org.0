Return-Path: <linux-kselftest+bounces-36537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C4AAF8F4D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6414811F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772D12EE26D;
	Fri,  4 Jul 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFRIQo4h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22A28D821;
	Fri,  4 Jul 2025 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623126; cv=none; b=LtDznqagZlXo1O4TKLOcfCLBKU5fgnZgf7hv3dIRClVQKHAo8wSeSpitZ6JOmPu2loXAcBDf8+H747AvfgMBpLqTFS2/hbtRhB3cAXBYodTwGQpVW7Q6Cewhkgt3v/SDusn2M7OayfvSnEMO+BrYhGOCMAIt8ZiT8PYULerD/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623126; c=relaxed/simple;
	bh=6y/QrROAdpMG0KepOi2ABSvBSikwo1+w0ZScUptNNMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmCFw1IwAHV0AQySD5PpT0X8vDGZyV7tA/iZJ1RMVw5DtwyRunZV2hojTGIwU8xFoMSGJGVxWiEGu87g07kxMCls1UuGsXw+NxyILtITr9WSh47VP/RqcUuEVojP/AiMcQ5zvRcDLDdtHx9bgsZSX3PgSrwNDNhNksPFj0h1+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFRIQo4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E78C4CEE3;
	Fri,  4 Jul 2025 09:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751623125;
	bh=6y/QrROAdpMG0KepOi2ABSvBSikwo1+w0ZScUptNNMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vFRIQo4haEeX4z5G3jGKdot+Ekt3XkyErGwHdiSf82A1pio97j4o+a5RUViuC0Rq4
	 5J2iAyDuCnCcHJHG9aAHo22icN2sNwSBPXudpAOpPY4u0d+5MWluuZVUjaXso3iyMj
	 EahQZNxNrzn+p8Yj3maagbM2KJADYIyh3mAQthEbWNC1hOpocQsHNnib2DRz/GOqzR
	 /sqoSfdiSs13t6LPG7HxRvr/WGdSfVaQhsQgm8qM9unLa1ofbUCuxo/qzyyQTJVM7V
	 lpaGIUtoJae4pJ9Xd5dHwaKmZ9ZEq8Z1Lo25wjRFfXp2XVD1aetV/OqzFYSpvhpbgO
	 wdjOWFkU7/CHQ==
Message-ID: <88a64a65-bd8c-4b73-af19-6764054d4572@kernel.org>
Date: Fri, 4 Jul 2025 11:58:37 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next,v3 2/2] selftests/bpf: Enhance XDP Rx metadata
 handling
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Magnus Karlsson <magnus.karlsson@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20250702165757.3278625-1-yoong.siang.song@intel.com>
 <20250702165757.3278625-3-yoong.siang.song@intel.com>
 <77463344-1b1a-443a-97be-a7ef8a88b8af@kernel.org>
 <IA3PR11MB92546301B67FB3A9FDCD716DD842A@IA3PR11MB9254.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <IA3PR11MB92546301B67FB3A9FDCD716DD842A@IA3PR11MB9254.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/07/2025 03.17, Song, Yoong Siang wrote:
> On Friday, July 4, 2025 1:05 AM, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>> On 02/07/2025 18.57, Song Yoong Siang wrote:
>>> Introduce the XDP_METADATA_SIZE macro as a conservative measure to
>>> accommodate any metadata areas reserved by Ethernet devices.
>>>
>>
>> This seems like a sloppy workaround :-(
>>
>> To me, the problem arise because AF_XDP is lacking the ability to
>> communicate the size of the data_meta area.  If we had this capability,
>> then we could allow the IGC driver to take some of the space, have the
>> BPF-prog expand it futher (bpf_xdp_adjust_meta) and then userspace
>> AF_XDP would simply be able to see the size of the data_meta area, and
>> apply the struct xdp_meta at right offset.
>>
> Thanks for your input.
> 
> I agree with you that the implementation will be simple if user application
> able to get the size of data_meta area. The intention of this patch set is to let
> developer aware of such limitations before we have a perfect solution.
> 
> Btw, do you got any suggestion on how to expose the metadata length?
> I not sure whether xdp_desc.options is a simple and good idea or not?

That is a question to the AF_XDP maintainers... added them to this email.

/* Rx/Tx descriptor */
struct xdp_desc {
	__u64 addr;
	__u32 len;
	__u32 options;
};

As far as I know, the xdp_desc.options field isn't used, right?


(Please AF_XDP experts, please verify below statements:)
Something else we likely want to document: The available headroom in the
AF_XDP frame.  When accessing the metadata in userspace AF_XDP we do a
negative offset from the UMEM packet pointer.  IIRC on RX the available
headroom will be either 255 or 192 bytes (depending on NIC drivers).

Slightly confusing when AF_XDP transmitting from userspace the UMEM
headroom is default zero (XSK_UMEM__DEFAULT_FRAME_HEADROOM is zero).
This is configurable via xsk_umem_config.frame_headroom, like I did in
this example[1].

Maybe I did something wrong in[1], because I see that the new method is
setting xsk_umem_config.tx_metadata_len + flag XDP_UMEM_TX_METADATA_LEN.
This is nicely documented in [2]. How does this interact with setting
xsk_umem_config.frame_headroom ?


[1] 
https://github.com/xdp-project/bpf-examples/blob/3f365af4be1fe6a0ef77e751ff9b12c912810453/AF_XDP-interaction/af_xdp_user.c#L423-L424
[2] https://www.kernel.org/doc/html/v6.12/networking/xsk-tx-metadata.html

--Jesper

