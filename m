Return-Path: <linux-kselftest+bounces-2604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A6F8227A5
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 04:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D2BB22199
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 03:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1AB1119C;
	Wed,  3 Jan 2024 03:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U56pxFKn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581241798A
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Jan 2024 03:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4fa8ae9d-11fd-4728-83bd-848cb22952e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704254150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1KtxGwLzgPO9Nq6mIAzHLoKOM5jDqJNPKphZby/ZVY=;
	b=U56pxFKnf+taP0aDnFgiA/kzaTptPDy8799K5hFzcDVwXLY/UQn/dqz0Wn8FFaClkUvUSP
	bTqUQQfJs5Fdn6Z4A+6KeIvQ9Mp8FyoeokwMGlBqOOfEucszV2resPg1RFgZLLVlR+AB0y
	ZMw/ahEtQprfJ6k6u7j2ft3V/k0082E=
Date: Tue, 2 Jan 2024 19:55:37 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/2] bpf: add csum/ip_summed fields to __sk_buff
Content-Language: en-GB
To: Menglong Dong <menglong8.dong@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mykolal@fb.com, shuah@kernel.org, horms@kernel.org,
 dhowells@redhat.com, linyunsheng@huawei.com, aleksander.lobakin@intel.com,
 joannelkoong@gmail.com, laoar.shao@gmail.com, kuifeng@meta.com,
 bjorn@rivosinc.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20231229081409.1276386-1-menglong8.dong@gmail.com>
 <ZZRR1q1JrJMD1lAy@google.com>
 <c628c362-b2e8-4ad6-a34f-50c2822bccd6@linux.dev>
 <CADxym3bPjdErhZ_wgQNK3BqbeUgvGMtLJRA_rD3pRa+BVcA95A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CADxym3bPjdErhZ_wgQNK3BqbeUgvGMtLJRA_rD3pRa+BVcA95A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/2/24 6:54 PM, Menglong Dong wrote:
> On Wed, Jan 3, 2024 at 8:52 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>> On 1/2/24 10:11 AM, Stanislav Fomichev wrote:
>>> On 12/29, Menglong Dong wrote:
>>>> For now, we have to call some helpers when we need to update the csum,
>>>> such as bpf_l4_csum_replace, bpf_l3_csum_replace, etc. These helpers are
>>>> not inlined, which causes poor performance.
>>>>
>>>> In fact, we can define our own csum update functions in BPF program
>>>> instead of bpf_l3_csum_replace, which is totally inlined and efficient.
>>>> However, we can't do this for bpf_l4_csum_replace for now, as we can't
>>>> update skb->csum, which can cause skb->csum invalid in the rx path with
>>>> CHECKSUM_COMPLETE mode.
>>>>
>>>> What's more, we can't use the direct data access and have to use
>>>> skb_store_bytes() with the BPF_F_RECOMPUTE_CSUM flag in some case, such
>>>> as modifing the vni in the vxlan header and the underlay udp header has
>>>> no checksum.
>> There is bpf_csum_update(), does it work?
>> A helper call should be acceptable comparing with the csum calculation itself.
> Yeah, this helper works in this case! Now we miss the last
> piece for the tx path: ip_summed. We need to know if it is
> CHECKSUM_PARTIAL to decide if we should update the
> csum in the packet. In the tx path, the csum in the L4 is the
> pseudo header only if skb->ip_summed is CHECKSUM_PARTIAL.
>
> Maybe we can introduce a lightweight kfunc to get its
> value? Such as bpf_skb_csum_mode(). As we need only call
> it once, there shouldn't be overhead on it.

You don't need kfunc, you can do checking like
   struct sk_buff *kskb = bpf_cast_to_kern_ctx(skb);
   if (kskb->ip_summed == CHECKSUM_PARTIAL) ...
   ...
   

>
> Thanks!
> Menglong Dong
>
>>>> In the first patch, we make skb->csum readable and writable, and we make
>>>> skb->ip_summed readable. For now, for tc only. With these 2 fields, we
>>>> don't need to call bpf helpers for csum update any more.
>>>>
>>>> In the second patch, we add some testcases for the read/write testing for
>>>> skb->csum and skb->ip_summed.
>>>>
>>>> If this series is acceptable, we can define the inlined functions for csum
>>>> update in libbpf in the next step.
>>> One downside of exposing those as __sk_buff fields is that all this
>>> skb internal csum stuff now becomes a UAPI. And I'm not sure we want
>> +1. Please no new __sk_buff extension and no new conversion in
>> bpf_convert_ctx_access().
>>
>>> that :-) Should we add a lightweight kfunc to reset the fields instead?
>>> Or will it still have an unacceptable overhead?

