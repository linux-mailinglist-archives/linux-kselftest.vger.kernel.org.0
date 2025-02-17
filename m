Return-Path: <linux-kselftest+bounces-26805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F943A38CAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 20:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B357164016
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 19:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0A522688C;
	Mon, 17 Feb 2025 19:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="hUH7EMpM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD562237163;
	Mon, 17 Feb 2025 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821548; cv=none; b=ls33H806B7xeJ+ceUdmx7bTYoXesRUiE2rRpNbF0cEEit/5hLGe3XhcSt9RWv+7+jMwVXs3g5y2pwsyAA06IkJXbl4yfrZ4WO3OoVJHYGkO6/R9aTfE8N84/61L3XmsD0gw3GNnK7C0nRqH4c/Gf6CDqM/5FD76K1U6UNtxpMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821548; c=relaxed/simple;
	bh=gjNqkkz7GydmC9eTiXSZ42lRqtAwMlrmeFsafJmNxPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7qhEuts4ttHnlkFCzXbB6Ot68oHxIihhnMCVDPiiVc2fxHh1hkxFiuZ3blK7r4Zw3hEOi5Tp1Tzt8sl0XMAodhV3iCwz+N/Iy58Yk++otrTp7Q4252uIw5VBWN1OXR919KoCoowcw36DH4Zb8dpciaojHz3CzPkO39fwcgzZ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=hUH7EMpM; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tk73N-00Ebxo-3d; Mon, 17 Feb 2025 20:45:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=k7zBAw62f8CGK9eZB2Y+XwwO5jM/cjEH314OvyzHJac=; b=hUH7EMpMlN0QW7SjSTXEmgMqia
	BLGiio0JmXBIq5cpqUgi9VIo+qjegSNUed7WXxuwGW5Pp2pmLenhl1mAiYPZqEs3dR5LrynZjxiXR
	R0m6REyjrBYCPr562bM+1zPCs4kIW8gwoyFyTHq9cPPbEbLn2+gbpBez4p4lnMg6Ni+0rna2cBWNx
	PTUzdAiTuzmzFfFHfNuW4GynCJzqMe/E5nZoFv2m6M/f7C0iSvQqaxsZ8SKiWUnBkTip5f6MqSdud
	BnZ9SHZG72hzbzGr3oe+7cPFqlcCY55xJMHYezbTX9Gga/AkvcxzayH0kbEByBwNWHPgiMJ0GCeJi
	jD+NRDIg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tk73K-0005aP-Kr; Mon, 17 Feb 2025 20:45:14 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tk73E-00GBTp-W7; Mon, 17 Feb 2025 20:45:09 +0100
Message-ID: <ff1d32c8-e01e-45e3-8811-eb19a5cb6960@rbox.co>
Date: Mon, 17 Feb 2025 20:45:06 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] vsock/bpf: Warn on socket without transport
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
 <20250213-vsock-listen-sockmap-nullptr-v1-2-994b7cd2f16b@rbox.co>
 <ygqdky4py42soj6kovk5z3l65h6xpglcse4mp37jsmlm6rjwzu@dcntngtsygj3>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <ygqdky4py42soj6kovk5z3l65h6xpglcse4mp37jsmlm6rjwzu@dcntngtsygj3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 11:59, Stefano Garzarella wrote:
> On Thu, Feb 13, 2025 at 12:58:50PM +0100, Michal Luczaj wrote:
>> In the spirit of commit 91751e248256 ("vsock: prevent null-ptr-deref in
>> vsock_*[has_data|has_space]"), armorize the "impossible" cases with a
>> warning.
>>
>> Fixes: 634f1a7110b4 ("vsock: support sockmap")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> net/vmw_vsock/af_vsock.c  | 3 +++
>> net/vmw_vsock/vsock_bpf.c | 2 +-
>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index 53a081d49d28ac1c04e7f8057c8a55e7b73cc131..7e3db87ae4333cf63327ec105ca99253569bb9fe 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -1189,6 +1189,9 @@ static int vsock_read_skb(struct sock *sk, skb_read_actor_t read_actor)
>> {
>> 	struct vsock_sock *vsk = vsock_sk(sk);
>>
>> +	if (WARN_ON_ONCE(!vsk->transport))
>> +		return -ENODEV;
>> +
>> 	return vsk->transport->read_skb(vsk, read_actor);
>> }
>>
>> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>> index f201d9eca1df2f8143638cf7a4d08671e8368c11..07b96d56f3a577af71021b1b8132743554996c4f 100644
>> --- a/net/vmw_vsock/vsock_bpf.c
>> +++ b/net/vmw_vsock/vsock_bpf.c
>> @@ -87,7 +87,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
>> 	lock_sock(sk);
>> 	vsk = vsock_sk(sk);
>>
>> -	if (!vsk->transport) {
>> +	if (WARN_ON_ONCE(!vsk->transport)) {
>> 		copied = -ENODEV;
>> 		goto out;
>> 	}
> 
> I'm not a sockmap expert, so I don't understand why here print an
> error.
> 
> Since there was already a check, I expected it to be a case that can 
> happen, but instead calling `rcvmsg()` on a socket not yet connected is 
> impossible?

That's right, calling vsock_bpf_recvmsg() on a not-yet-connected
connectible socket is impossible since PATCH 1/4 of this series.

That is because to reach vsock_bpf_recvmsg(), you must have sock's proto
replaced in vsock_bpf_update_proto(). For that you need to run
sock_map_init_proto(), which you can't because the patched
sock_map_sk_state_allowed() will stop you.


