Return-Path: <linux-kselftest+bounces-22415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5698A9D53A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 20:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B94B21063
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17671C82E2;
	Thu, 21 Nov 2024 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ao8ygTmu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619B1C7B69
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732218892; cv=none; b=kLYsl8LdDXEbBgDc1MTz2wkB3aA6SDvpgRAl8pTxuykhYQeo5nAdD2hPL3iP8FY9YXPI4hg8Y/xmpQmfl0FYXGIHbpfdSFMou/Ec3QtrO2GtnGLQKY/YU8qRmw5KZXVEp1bcD/67HpDacwpX6Vm6SHqe1ARufZclK0xn1CgBWbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732218892; c=relaxed/simple;
	bh=cCkp6T/5ut6jxWfa0q3B3JwltBL8bFyvsA59iU+TBn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJwKUR8cw25E507286eG5R0s+FjipX8vhvXcXUoLPDdfkx+jZLkE9PoCYVR8gfVAXTthUdlP+PcGg+rVFcpHzZ7utrUVgLO0N9s/fWQhW7oKD7He2T1II3VJJ3MvzTF+pxmpjw9O9GKPhRyQjA8MfPpHk5LsQLe5O7WitB2o8Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ao8ygTmu; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tEDG1-009Hs7-1H; Thu, 21 Nov 2024 20:54:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=v/OvbCX67fiKfDPsOSvPlJ92i6d6HdXD7QxhiNZ5o1A=; b=ao8ygTmuqcjWbO3II1En1aQBkC
	2gZyAB+jNnFyLPsepBk4un1gldp7aG6CfL4pxq2OODmYGqMne6gmf7q8ZYbMTaSI27tGUJXjoWj9D
	aXnyjlmqOZ1CGFb0km8lGUqDVXthOZviHuCjjnwfICdp6N1hghhDMZLmc45R6ocXxQDMoAZcfAKZv
	A26udFzPYIwx5KWeJCUILYLMag1qqTYdTVdi2XYE1LQvxnWXObyQE7a5gCOgAqGcaS12HrYW7OZ/q
	K6tz3II2oHo7kIuIqR2ZBbmGLHyfMpp1rlOy01MwhbhTnk8U7b90aLZxI/TxaG8XLZHpc+xjD3Eat
	C5G3fgbA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tEDFz-0006kb-KT; Thu, 21 Nov 2024 20:54:27 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tEDFs-00CqIR-VC; Thu, 21 Nov 2024 20:54:21 +0100
Message-ID: <350e3a3f-7ebd-471e-95fa-05225d786f1c@rbox.co>
Date: Thu, 21 Nov 2024 20:54:19 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 3/4] bpf, vsock: Invoke proto::close on close()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
 <20241118-vsock-bpf-poll-close-v1-3-f1b9669cacdc@rbox.co>
 <7wufhaaytdjp3m3xv7jrdadqjg75is5eirv4bzmjzmezc7v7ls@p52fm6y537di>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <7wufhaaytdjp3m3xv7jrdadqjg75is5eirv4bzmjzmezc7v7ls@p52fm6y537di>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 10:22, Stefano Garzarella wrote:
> On Mon, Nov 18, 2024 at 10:03:43PM +0100, Michal Luczaj wrote:
>> vsock defines a BPF callback to be invoked when close() is called. However,
>> this callback is never actually executed. As a result, a closed vsock
>> socket is not automatically removed from the sockmap/sockhash.
>>
>> Introduce a dummy vsock_close() and make vsock_release() call proto::close.
>>
>> Note: changes in __vsock_release() look messy, but it's only due to indent
>> level reduction and variables xmas tree reorder.
>>
>> Fixes: 634f1a7110b4 ("vsock: support sockmap")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> net/vmw_vsock/af_vsock.c | 67 +++++++++++++++++++++++++++++-------------------
>> 1 file changed, 40 insertions(+), 27 deletions(-)
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index 919da8edd03c838cbcdbf1618425da6c5ec2df1a..b52b798aa4c2926c3f233aad6cd31b4056f6fee2 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -117,12 +117,14 @@
>> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
>> static void vsock_sk_destruct(struct sock *sk);
>> static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
>> +static void vsock_close(struct sock *sk, long timeout);
>>
>> /* Protocol family. */
>> struct proto vsock_proto = {
>> 	.name = "AF_VSOCK",
>> 	.owner = THIS_MODULE,
>> 	.obj_size = sizeof(struct vsock_sock),
>> +	.close = vsock_close,
>> #ifdef CONFIG_BPF_SYSCALL
>> 	.psock_update_sk_prot = vsock_bpf_update_proto,
>> #endif
>> @@ -797,39 +799,37 @@ static bool sock_type_connectible(u16 type)
>>
>> static void __vsock_release(struct sock *sk, int level)
>> {
>> -	if (sk) {
>> -		struct sock *pending;
>> -		struct vsock_sock *vsk;
>> -
>> -		vsk = vsock_sk(sk);
>> -		pending = NULL;	/* Compiler warning. */
>> +	struct vsock_sock *vsk;
>> +	struct sock *pending;
>>
>> -		/* When "level" is SINGLE_DEPTH_NESTING, use the nested
>> -		 * version to avoid the warning "possible recursive locking
>> -		 * detected". When "level" is 0, lock_sock_nested(sk, level)
>> -		 * is the same as lock_sock(sk).
>> -		 */
>> -		lock_sock_nested(sk, level);
>> +	vsk = vsock_sk(sk);
>> +	pending = NULL;	/* Compiler warning. */
>>
>> -		if (vsk->transport)
>> -			vsk->transport->release(vsk);
>> -		else if (sock_type_connectible(sk->sk_type))
>> -			vsock_remove_sock(vsk);
>> +	/* When "level" is SINGLE_DEPTH_NESTING, use the nested
>> +	 * version to avoid the warning "possible recursive locking
>> +	 * detected". When "level" is 0, lock_sock_nested(sk, level)
>> +	 * is the same as lock_sock(sk).
>> +	 */
>> +	lock_sock_nested(sk, level);
>>
>> -		sock_orphan(sk);
>> -		sk->sk_shutdown = SHUTDOWN_MASK;
>> +	if (vsk->transport)
>> +		vsk->transport->release(vsk);
>> +	else if (sock_type_connectible(sk->sk_type))
>> +		vsock_remove_sock(vsk);
>>
>> -		skb_queue_purge(&sk->sk_receive_queue);
>> +	sock_orphan(sk);
>> +	sk->sk_shutdown = SHUTDOWN_MASK;
>>
>> -		/* Clean up any sockets that never were accepted. */
>> -		while ((pending = vsock_dequeue_accept(sk)) != NULL) {
>> -			__vsock_release(pending, SINGLE_DEPTH_NESTING);
>> -			sock_put(pending);
>> -		}
>> +	skb_queue_purge(&sk->sk_receive_queue);
>>
>> -		release_sock(sk);
>> -		sock_put(sk);
>> +	/* Clean up any sockets that never were accepted. */
>> +	while ((pending = vsock_dequeue_accept(sk)) != NULL) {
>> +		__vsock_release(pending, SINGLE_DEPTH_NESTING);
>> +		sock_put(pending);
>> 	}
>> +
>> +	release_sock(sk);
>> +	sock_put(sk);
>> }
>>
>> static void vsock_sk_destruct(struct sock *sk)
>> @@ -901,9 +901,22 @@ void vsock_data_ready(struct sock *sk)
>> }
>> EXPORT_SYMBOL_GPL(vsock_data_ready);
>>
>> +/* Dummy callback required by sockmap.
>> + * See unconditional call of saved_close() in sock_map_close().
>> + */
>> +static void vsock_close(struct sock *sk, long timeout)
>> +{
>> +}
>> +
>> static int vsock_release(struct socket *sock)
>> {
>> -	__vsock_release(sock->sk, 0);
>> +	struct sock *sk = sock->sk;
>> +
>> +	if (!sk)
>> +		return 0;
> 
> Compared with before, now we return earlier and so we don't set SS_FREE, 
> could it be risky?
>
> I think no, because in theory we have already set it in a previous call, 
> right?

Yeah, and is there actually a way to call vsock_release() for a second
time? The only caller I see is __sock_release(), which won't allow that.

As for the sockets that never had ->sk assigned, I assume it doesn't matter.

> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
>> +
>> +	sk->sk_prot->close(sk, 0);
>> +	__vsock_release(sk, 0);
>> 	sock->sk = NULL;
>> 	sock->state = SS_FREE;


