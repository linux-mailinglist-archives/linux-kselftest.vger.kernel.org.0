Return-Path: <linux-kselftest+bounces-29452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89456A698AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 20:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B657A4627D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 19:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B326020B808;
	Wed, 19 Mar 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="CQhlnAcG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A05D212B2D;
	Wed, 19 Mar 2025 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411165; cv=none; b=b5wOEx9PNqF/8AMH3ZmKCMwbDVYGkvvTgpTmDATttkyrT2tdqwiusgc2jlaBbKB5ifwx4Axm9WtpbfOBxxBQuptko4xzOQo8sKeepaYaAhHyvzo5X0aJwXR8Z0n7bSh4JEUxo+1fxfwTVOgfYL0g6wTo33dBokArvVIFSQFil4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411165; c=relaxed/simple;
	bh=p5HWzTSzMKc1iIwbkt52P8iFBGekfq9FZTFLXLg3fBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWstXBfLOWJ0+xF0qonMSW631SpHSnnrnN3pQLR5PD0ciHby7WIWZ5FGKwqkg07mkSut3LiJRyCZ2eL6M/EE9qmcmXKXpQ57KFjS9yddk5qtFa/FgoEbbiK37i5XwxBHGfbGfPIPVWcLNTsXm2PnTAEp91NiyA04tA5prwCh2C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=CQhlnAcG; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tuyjc-003kZx-Vt; Wed, 19 Mar 2025 20:05:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=OH569wAS1bhqlbCDaNRzqwa/Wdu0KSj+iHXXSnCOTcc=; b=CQhlnAcGLp82F3GPueRiON5w78
	JBCzBxDqeWV71gMJiePPCe59CHbVdkpBpNm7sDnNaR07TPMviwZyuZ3RMgMp6gWIK5b0tbzTOy3Xx
	p7ifAixMsShdLiDO7+f9MmDpW7DWg13R+nT61prmuonpVdyGVxbiCbziTQ1mCpytAqkljd6qW3M8Z
	YR9wHPWmfbELhQmCn+fPxPMM+ufSbinBJGWXxNVcjj6A5jgtStp0yDbIOlxBg1fz+UxmP2iU0Ot8L
	54roTTrL5r6vwze0q0BzPlzt7c4xoPoCJDbRg42ZX3q0oWY0BNb32Zi4ZcXMcvXvjddxlQBORWElk
	pgaz0aKQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tuyjb-0008FT-FJ; Wed, 19 Mar 2025 20:05:47 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tuyja-00C8ir-KT; Wed, 19 Mar 2025 20:05:46 +0100
Message-ID: <9848cb5c-d362-453f-bacc-7759c9ef8290@rbox.co>
Date: Wed, 19 Mar 2025 20:05:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/3] vsock/bpf: Fix bpf recvmsg() racing transport
 reassignment
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
 <20250317-vsock-trans-signal-race-v4-3-fc8837f3f1d4@rbox.co>
 <c7nnbp3j57mnlcglvczyimdqpc2run5vqhtea4eesymv555du4@ekcyin54mcdn>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <c7nnbp3j57mnlcglvczyimdqpc2run5vqhtea4eesymv555du4@ekcyin54mcdn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 10:34, Stefano Garzarella wrote:
> On Mon, Mar 17, 2025 at 10:52:25AM +0100, Michal Luczaj wrote:
>> ...
>> -static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
>> -			     size_t len, int flags, int *addr_len)
>> +static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>> +			     int flags, int *addr_len)
> 
> I would avoid this change, especially in a patch with the Fixes tag then 
> to be backported.

I thought that since I've modified this function in so many places, doing
this wouldn't hurt. But ok, I'll drop this change.

>> {
>> 	struct sk_psock *psock;
>> 	struct vsock_sock *vsk;
>> 	int copied;
>>
>> +	/* Since signal delivery during connect() may reset the state of socket
>> +	 * that's already in a sockmap, take the lock before checking on psock.
>> +	 * This serializes a possible transport reassignment, protecting this
>> +	 * function from running with NULL transport.
>> +	 */
>> +	lock_sock(sk);
>> +
>> 	psock = sk_psock_get(sk);
>> -	if (unlikely(!psock))
>> +	if (unlikely(!psock)) {
>> +		release_sock(sk);
>> 		return __vsock_recvmsg(sk, msg, len, flags);
>> +	}
>>
>> -	lock_sock(sk);
>> 	vsk = vsock_sk(sk);
>> -
>> 	if (WARN_ON_ONCE(!vsk->transport)) {
>> 		copied = -ENODEV;
>> 		goto out;
>> 	}
>>
>> 	if (vsock_has_data(sk, psock) && sk_psock_queue_empty(psock)) {
>> -		release_sock(sk);
>> 		sk_psock_put(sk, psock);
>> +		release_sock(sk);
> 
> But here we release it, so can still a reset happen at this point, 
> before calling __vsock_connectible_recvmsg().
> In there anyway we handle the case where transport is null, so there's 
> no problem, right?

Yes, I think we're good. That function needs to gracefully handle being
called without a transport, and it does.

Thanks,
Michal


