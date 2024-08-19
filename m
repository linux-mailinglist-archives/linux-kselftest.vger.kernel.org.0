Return-Path: <linux-kselftest+bounces-15731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FE395789C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 01:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4AE284588
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 23:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635221DF694;
	Mon, 19 Aug 2024 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PQtBKgj6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DBF3C6BA
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724110130; cv=none; b=b1UGhWrcWzhFgE0lBoOlSWGgunzMGoNA4IbNU/dgSr2EK1RUSmU4Svv1Aacn5MFTwWgByfbrK/itQDAn+zgemGc75y56KiGg1zqrEKTQ7LBhyROnpgfRzzeW84aMPF9L8nOomE8h3nkR9OOjWccPZHWSuxpiTeApE/5E6jtpUq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724110130; c=relaxed/simple;
	bh=m7kxeGPfLbThsj9r9vGfFq8j8982Mb9ShTtJgvz8zDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzLBnuSY9kKVcyh5G+xvkTrFnzQTDLmeE2F7mr4pC3CKODX4xR31hKUGpr2AWgU2g8XXjGCGX9gKwV+X8ml24ZV9hikjppsqk4KsBxOxUSrUCb7Mi26SLY+BLwC/rmWCaBomHR5BimKjwTMYy00k2DzGNVoSa8VqaFumTzjFNtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PQtBKgj6; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <40a2828d-1881-416f-94ad-595b85b8dd84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724110126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0P27pgkkVQx3FMDv0ADp2wY6mPd7FvC3Vh5d2lNdR40=;
	b=PQtBKgj6/d6qzSFWj22L/PnmEYDSRKUNKqyfNnVrckfqAzgKasVutHl2ip4seg2YTLo67L
	zMImtrG2jDZn2/p3QaXhrMSFBASMFfvKZeaAgt57o0nH2Q79j679G34JZOyEyAJrpyZ3Mh
	mrjKynMgafABPD6UojuKc4gb0xTfFnM=
Date: Mon, 19 Aug 2024 16:28:37 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add mptcp subflow subtest
To: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Daniel Xu <dxu@dxuuu.xyz>, Manu Bretelle <chantra@meta.com>
References: <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-0-2b4ca6994993@kernel.org>
 <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-2-2b4ca6994993@kernel.org>
 <2136317a-3e95-4993-b2fc-1f3b2c28dbdc@linux.dev>
 <8a2ff1bd-52dc-421d-87b7-fc2f56e81da2@kernel.org>
 <716cbd56-4a44-4451-a6f3-5bacef3e0729@linux.dev>
 <db295f729981cd0eaebb93c5939b515f50882c11.camel@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <db295f729981cd0eaebb93c5939b515f50882c11.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/17/24 7:13 PM, Geliang Tang wrote:
>> Take a look at a recent example [0]. The mptcp test is under a cgroup
>> already
>> and has the cgroup setup. An extra "cgroup/getsockopt" prog should be
>> enough.
>> That prog can walk the msk->conn_list and use bpf_rdonly_cast (or the
 >> bpf_core_cast macro in libbpf) to cast a pointer to tcp_sock for

[ ... ]

> SEC("cgroup/getsockopt")
> int _getsockopt(struct bpf_sockopt *ctx)
> {
>          struct mptcp_sock *msk = bpf_core_cast(ctx->sk, struct
> mptcp_sock);
>          struct mptcp_subflow_context *subflow;
>          __u32 token = 0;
> 
>          if (!msk || ctx->level != SOL_TCP ||
> 			ctx->optname != TCP_CONGESTION)
>                  return 1;
> 
>          subflow = list_first_entry(&msk->conn_list,
> 			struct mptcp_subflow_context, node);
>          token = subflow->token;
>          bpf_trace_printk(fmt, sizeof(fmt), msk, token);
> 
>          return 1;
> }
> 
> And got some access errors:
> 
> ; token = subflow->token; @ mptcp_subflow.c:92
> 13: (61) r4 = *(u32 *)(r1 +524)
> access beyond struct list_head at off 524 size 4

Similar to your bpf_core_cast() usage earlier that casts a sock ptr to 
mptcp_sock ptr. r1 is in list_head ptr type. It needs to cast to 
mptcp_subflow_context ptr.

The same cast to tcp_sock is needed when you try to get the tcp_sock ptr from 
subflow->tcp_sock which is in "struct sock *" type in the kernel instead of 
"struct tcp_sock *".


