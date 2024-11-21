Return-Path: <linux-kselftest+bounces-22393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7439D49D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 10:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F503280E6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 09:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9651CB304;
	Thu, 21 Nov 2024 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkJvlmrm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7321C9DC5
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180936; cv=none; b=YhiORRQHBWLw8TvmAPdgIpd/SvP56TDCvNvkUBE9XKgD44sPju1s4gCP9GAqkJafzKM6o7ZLdmwBCZ5hMec/N956miQk8Q6EyBfa8s4RTCLJfSV5d0RAxhD3Sdze+3i8AWs5wyRszXZXXR1q9xCgf33WYKNjTkFK9rUV5KZB06o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180936; c=relaxed/simple;
	bh=Et+MyeUBBwbo+Ho9sHMO1ZkHG8oW6vT7dGJOy8DCj58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE0eTMo1R5FXTRmRxDChmsIb39tafNmuyzOg93RbBjAYvW7BL+hirk0fjy9x+OdxFEcAH5IyP7xzRo1cHoMjesTifC9ZDw7zO0XAd19E6d1qjMpLPRZZh6zQl1dtm7VhlcNeAWQBmKTunK71jtzIvBp080L5S0Cqy4uWb2CD3os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkJvlmrm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732180933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UhM3T0zK7wAUQ6aYe/q88lHTgWagB7X71lPl9l7iAQ=;
	b=LkJvlmrmpBleY5cmpMW6r5n3XU3L6KVQdk8MEB8NXhP7S3buzodOrfEBaJITWKeyBnVO2t
	/AZMxwwWBhp0+GKlVSwaNTMnn2DCqHB3BTD55NmbUk0Hl8kzmEUfUNY2daw+sC5rDd0Sq5
	qnc64j1fUIclAeA13htHOavcEbKtg4M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-9C1Q5ODZOfGgUJI1WXgAgw-1; Thu, 21 Nov 2024 04:22:11 -0500
X-MC-Unique: 9C1Q5ODZOfGgUJI1WXgAgw-1
X-Mimecast-MFC-AGG-ID: 9C1Q5ODZOfGgUJI1WXgAgw
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5cfca4c0096so450133a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 01:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180930; x=1732785730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UhM3T0zK7wAUQ6aYe/q88lHTgWagB7X71lPl9l7iAQ=;
        b=JzSeJqSRNzstFbq5RN82t7lcuwEt5HM9vIBFO6uZDGQcE8PKu5YIN7Gpowiyn+6ntz
         BHwU6A/wk+jkpttg4QqjPk7qDuAml/MPI2JCzbKBWdcO9uTpDVXN28B+kx1uwOzMEdnm
         piwUT4tYIMUTrm50uDeVOFjWYFvbIZq16lXJ8PmgCKZKZUgbIkKTyRg3+LwCmcL66BsY
         Iz4v1GrHwlaRlwyGxgOcvaSGa+SzotdSxG6fD9Pe9ccEU4oALypfCBa6kCh25M6EZm0r
         EOqPZ57UEbIDyuVEVMHJ70JG9lmxDPwwcNOPrtILQNr8RzRnSneeFUpfoknX/K7H7GE6
         U+bA==
X-Forwarded-Encrypted: i=1; AJvYcCXgnHQWVn5gme+ajwjt5ouv8Rp3B/01X68dX2I5jA3WCXKxzD7mbIAMyr1nvc95/jmWUSHQR0N8Ntdjn7E5k0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6FmBN0g700tgpS5omzjPk3T+C9QGnEReji70STjHFF6T8xjPN
	+FeGFwb0jf9nhLqQCb2i4H2znlx0t1vWLPklPXBKsH7VmQTACACo7T80Tmtjch6Gswp+qsTtIDo
	WWEMOEISaOCkdMUXcxaxn8Lz0kUVbt+JL+Sq8rx+XA/jFyncFfwn9k33UIT66JpGeSQ==
X-Gm-Gg: ASbGncuyao+7fSKEiwfzfUnGnL1Vn2ZaZLS4sHCEwBd9VEyvXwtKTJF0s8Z6wPISVol
	foJh9sNt9a59h43LE4o1Xu1zNeD10/TIJsnsPTrXvvtils1+L4AxDwiq+1CdH5wGNjvo7RSoRrz
	s0RAQMbcQifh69YFA/qUqwaUSC6TNi4IKhKV2nRodj1wG9EyWyW8AfU2zRnkr73zetq3pSfov3z
	KBwLd8PbiFvZYx3+IF2S40eapcLv5PggZUEYH/ghldVBn0vffYs2va0GaK9R1iKlT6cVzf0efdk
	VLJahsOFDFvJypQqWC8EWs8cXA==
X-Received: by 2002:a17:907:368a:b0:a9e:b287:2813 with SMTP id a640c23a62f3a-aa4dd52ad60mr613897066b.5.1732180930488;
        Thu, 21 Nov 2024 01:22:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpYURhAqi2+Iv1yCRlEqtYUTNmT6QPL+4sLpjlgm8nBJLv3Pn2th1eX/kMAyjO5FOXeHGCAQ==
X-Received: by 2002:a17:907:368a:b0:a9e:b287:2813 with SMTP id a640c23a62f3a-aa4dd52ad60mr613891666b.5.1732180929759;
        Thu, 21 Nov 2024 01:22:09 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f42d4b5dsm56844866b.112.2024.11.21.01.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 01:22:09 -0800 (PST)
Date: Thu, 21 Nov 2024 10:22:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 3/4] bpf, vsock: Invoke proto::close on close()
Message-ID: <7wufhaaytdjp3m3xv7jrdadqjg75is5eirv4bzmjzmezc7v7ls@p52fm6y537di>
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
 <20241118-vsock-bpf-poll-close-v1-3-f1b9669cacdc@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-3-f1b9669cacdc@rbox.co>

On Mon, Nov 18, 2024 at 10:03:43PM +0100, Michal Luczaj wrote:
>vsock defines a BPF callback to be invoked when close() is called. However,
>this callback is never actually executed. As a result, a closed vsock
>socket is not automatically removed from the sockmap/sockhash.
>
>Introduce a dummy vsock_close() and make vsock_release() call proto::close.
>
>Note: changes in __vsock_release() look messy, but it's only due to indent
>level reduction and variables xmas tree reorder.
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 67 +++++++++++++++++++++++++++++-------------------
> 1 file changed, 40 insertions(+), 27 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 919da8edd03c838cbcdbf1618425da6c5ec2df1a..b52b798aa4c2926c3f233aad6cd31b4056f6fee2 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -117,12 +117,14 @@
> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
> static void vsock_sk_destruct(struct sock *sk);
> static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
>+static void vsock_close(struct sock *sk, long timeout);
>
> /* Protocol family. */
> struct proto vsock_proto = {
> 	.name = "AF_VSOCK",
> 	.owner = THIS_MODULE,
> 	.obj_size = sizeof(struct vsock_sock),
>+	.close = vsock_close,
> #ifdef CONFIG_BPF_SYSCALL
> 	.psock_update_sk_prot = vsock_bpf_update_proto,
> #endif
>@@ -797,39 +799,37 @@ static bool sock_type_connectible(u16 type)
>
> static void __vsock_release(struct sock *sk, int level)
> {
>-	if (sk) {
>-		struct sock *pending;
>-		struct vsock_sock *vsk;
>-
>-		vsk = vsock_sk(sk);
>-		pending = NULL;	/* Compiler warning. */
>+	struct vsock_sock *vsk;
>+	struct sock *pending;
>
>-		/* When "level" is SINGLE_DEPTH_NESTING, use the nested
>-		 * version to avoid the warning "possible recursive locking
>-		 * detected". When "level" is 0, lock_sock_nested(sk, level)
>-		 * is the same as lock_sock(sk).
>-		 */
>-		lock_sock_nested(sk, level);
>+	vsk = vsock_sk(sk);
>+	pending = NULL;	/* Compiler warning. */
>
>-		if (vsk->transport)
>-			vsk->transport->release(vsk);
>-		else if (sock_type_connectible(sk->sk_type))
>-			vsock_remove_sock(vsk);
>+	/* When "level" is SINGLE_DEPTH_NESTING, use the nested
>+	 * version to avoid the warning "possible recursive locking
>+	 * detected". When "level" is 0, lock_sock_nested(sk, level)
>+	 * is the same as lock_sock(sk).
>+	 */
>+	lock_sock_nested(sk, level);
>
>-		sock_orphan(sk);
>-		sk->sk_shutdown = SHUTDOWN_MASK;
>+	if (vsk->transport)
>+		vsk->transport->release(vsk);
>+	else if (sock_type_connectible(sk->sk_type))
>+		vsock_remove_sock(vsk);
>
>-		skb_queue_purge(&sk->sk_receive_queue);
>+	sock_orphan(sk);
>+	sk->sk_shutdown = SHUTDOWN_MASK;
>
>-		/* Clean up any sockets that never were accepted. */
>-		while ((pending = vsock_dequeue_accept(sk)) != NULL) {
>-			__vsock_release(pending, SINGLE_DEPTH_NESTING);
>-			sock_put(pending);
>-		}
>+	skb_queue_purge(&sk->sk_receive_queue);
>
>-		release_sock(sk);
>-		sock_put(sk);
>+	/* Clean up any sockets that never were accepted. */
>+	while ((pending = vsock_dequeue_accept(sk)) != NULL) {
>+		__vsock_release(pending, SINGLE_DEPTH_NESTING);
>+		sock_put(pending);
> 	}
>+
>+	release_sock(sk);
>+	sock_put(sk);
> }
>
> static void vsock_sk_destruct(struct sock *sk)
>@@ -901,9 +901,22 @@ void vsock_data_ready(struct sock *sk)
> }
> EXPORT_SYMBOL_GPL(vsock_data_ready);
>
>+/* Dummy callback required by sockmap.
>+ * See unconditional call of saved_close() in sock_map_close().
>+ */
>+static void vsock_close(struct sock *sk, long timeout)
>+{
>+}
>+
> static int vsock_release(struct socket *sock)
> {
>-	__vsock_release(sock->sk, 0);
>+	struct sock *sk = sock->sk;
>+
>+	if (!sk)
>+		return 0;

Compared with before, now we return earlier and so we don't set SS_FREE, 
could it be risky?

I think no, because in theory we have already set it in a previous call, 
right?

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>+
>+	sk->sk_prot->close(sk, 0);
>+	__vsock_release(sk, 0);
> 	sock->sk = NULL;
> 	sock->state = SS_FREE;
>
>
>-- 
>2.46.2
>


