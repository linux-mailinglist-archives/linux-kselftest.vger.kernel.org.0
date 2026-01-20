Return-Path: <linux-kselftest+bounces-49518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP3pCmywb2nMKgAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49518-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 17:42:20 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A315247D1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 17:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF6816CA044
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB332FBE1F;
	Tue, 20 Jan 2026 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HjS3uyo1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1E028853A
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921222; cv=none; b=hjKpo0ealSngIElgN+irGCTAS8/kJXkApSseJff9pcE8iWnox6nqPl9Vs3ecS143GyOjI5cy29BuQjxgaQZRFh1re7AntofCB21h/qeV076a/ebKsHsSUwlo6+DhAHOymjMwKlb9h0pWXKBEknAGyTl9vCzkLYs5LxGAVo3EZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921222; c=relaxed/simple;
	bh=OQNuI++txdRItHms+H9HPT0iX4u5oC7BFcxQfHKhPPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TAnHo8ES7XwS1yJMaoXGi3dZLOR70BBwGPWprsL/j+WpFaef83ZhMf+qQ6sSwhuPtu8t3WX8EPDOuDd3r7pDtzm1tVMhUPGzdyYLJ1mxu8XIH6xKw/1M31uaPoUBVJ/hD2WTMrJZTwLBdPP3L+RPn+/0twtKBXHLuQiTMirxc/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HjS3uyo1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b870cbd1e52so789786966b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 07:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768921218; x=1769526018; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P8fzGeTAt1Fn9dkckWUN/LqFrJSN4XLqNdQGKVVrmPA=;
        b=HjS3uyo1CkV+fFXhkEt3zBVdWSGGTCvz7rX320xb/Gaaz1SPE9DMcbXVrT6MKJNR6h
         mpo2sIDIUN4H8JXwTDJ2x3WF0+VHVegFS2ETxjJw107dBDBMSa6Yc818sXgxlFRX13WS
         acvV0AogQzchnCACQU+QKdnzhbSMxqQruNF3YayZX92N/zjJ3Tbl1PbSUHKDMwS21nV6
         Ce6E8XVzL6ba3p0lkh8d14svWkUVy47iTqDwYXRhfkO49MOXSA2DRGXzqvwRblKzB9aQ
         Dv/AfIG2aYQXrVRVmBBCPv9NrtUwMkEDCJ7thwfvibttAhShZRzXZedjDIEJXyXwJ1HV
         4uCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768921218; x=1769526018;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8fzGeTAt1Fn9dkckWUN/LqFrJSN4XLqNdQGKVVrmPA=;
        b=s+4YqleEB1fkpMyqU1td4FPgAylS2iSxNAVPEMZHkE6yhLsWxax6CZHdjn86I87/Ab
         WmbCszEmwdY4s0gr/zrh/Jn9qFrRnYxqe8aRfi0uWb7vOsjQzWAjAiqzvlkgSEDQl2w7
         ZWj9+oDp14fycsUVk/FFcKjQrhJGH/9yaU0j1nkd1mYykuL8KHX+Yb7RFYqGpfbK7CCh
         FQcb4RCNwzk41H8nAgLT6I+ByRoQZeotubERDF2Hcs0yp62ed5dfYV0NzARLKiIVWDzw
         gD+Rsop0wBd1RcnYeUWProVC9mi4VaGAK86KX76N4chljQDHUsappy1Jkcf/MFjhhrgk
         Ig6w==
X-Forwarded-Encrypted: i=1; AJvYcCUhW+cgWwkY1rvRu+H5GXzEFUelz6yN2XZBbUF6wTixWH03XnBYr/h+jG4Ch31oNaDvUEs8ZHyoVu7uBBdMnbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXqCldVxOlF559ERT+HMmTAqzA2kILe4KXA091O/oP2k3bmt0
	AS6SQg3GL8zNwP8tj5BEhDYuFGaU0LYAxSnMmimGWCHOtz8eTNXmXnxnIPIkzb0movY=
X-Gm-Gg: AZuq6aJ1k2Te6SsFzP2RAoKN0AIEvjWDaMqqpIC7pmN7tQ5abT4RWCyDL5C6QIpmqvG
	lfARSds+KBy0vXFlQ2mBoW0Jopc3C1i3SPxO0ns8glsiMlOQ6++NF7TrytncRUYmjYzJMAiVQfJ
	MS2rfmJiW/JOSa/HJWP3He1mDArcl4XhxaAtdfrtBlY/RGG30ogiFsfnk2/neJAoS9CZHFXKONX
	CkJPqkRVZ+it9EZef1TJKAHFPyl7kRALG+VoEWsnZmcYnjxZ3DEaIGkRD745sBUYLv8VGKkJSlO
	PUPG7NqtzFtlL8u72l6sMKk+7Rt23ZX/sONEFJ0ec2S2FcpC0ElJjJk5GLReB4UEI2hHe7TAsE+
	LtiMTlP8Du9zoApoqwBwNbH4jWH0dEeAjvTgU0DIcCeOuZhJkRaWEgutBFZN45PUIyp9lFAcn4x
	f7wdb4o513OKhmAQ==
X-Received: by 2002:a17:907:969e:b0:b86:fca7:3dc5 with SMTP id a640c23a62f3a-b8800297f3amr222725366b.28.1768921218101;
        Tue, 20 Jan 2026 07:00:18 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2969::420:45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959fc086sm1421244466b.56.2026.01.20.07.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:00:17 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  John Fastabend <john.fastabend@gmail.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Neal Cardwell <ncardwell@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Michal Luczaj <mhal@rbox.co>,  Cong Wang
 <cong.wang@bytedance.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 2/3] bpf, sockmap: Fix FIONREAD for sockmap
In-Reply-To: <20260113025121.197535-3-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Tue, 13 Jan 2026 10:50:50 +0800")
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
	<20260113025121.197535-3-jiayuan.chen@linux.dev>
Date: Tue, 20 Jan 2026 16:00:16 +0100
Message-ID: <87a4y8uy67.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-6.96 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	DMARC_POLICY_ALLOW(0.00)[cloudflare.com,reject];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,fomichev.me,rbox.co,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-49518-lists,linux-kselftest=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,linux-kselftest@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-kselftest];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,cloudflare.com:mid,cloudflare.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A315247D1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 13, 2026 at 10:50 AM +08, Jiayuan Chen wrote:
> A socket using sockmap has its own independent receive queue: ingress_msg.
> This queue may contain data from its own protocol stack or from other
> sockets.
>
> Therefore, for sockmap, relying solely on copied_seq and rcv_nxt to
> calculate FIONREAD is not enough.
>
> This patch adds a new msg_tot_len field in the psock structure to record
> the data length in ingress_msg. Additionally, we implement new ioctl
> interfaces for TCP and UDP to intercept FIONREAD operations.
>
> Unix and VSOCK sockets have similar issues, but fixing them is outside
> the scope of this patch as it would require more intrusive changes.
>
> Previous work by John Fastabend made some efforts towards FIONREAD support:
> commit e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Although the current patch is based on the previous work by John Fastabend,
> it is acceptable for our Fixes tag to point to the same commit.
>
>                                                       FD1:read()
>                                                       --  FD1->copied_seq++
>                                                           |  [read data]
>                                                           |
>                                    [enqueue data]         v
>                   [sockmap]     -> ingress to self ->  ingress_msg queue
> FD1 native stack  ------>                                 ^
> -- FD1->rcv_nxt++               -> redirect to other      | [enqueue data]
>                                        |                  |
>                                        |             ingress to FD1
>                                        v                  ^
>                                       ...                 |  [sockmap]
>                                                      FD2 native stack
>
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  include/linux/skmsg.h | 68 +++++++++++++++++++++++++++++++++++++++++--
>  net/core/skmsg.c      |  3 ++
>  net/ipv4/tcp_bpf.c    | 32 ++++++++++++++++++++
>  net/ipv4/udp_bpf.c    | 23 ++++++++++++---
>  4 files changed, 120 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index dfdc158ab88c..829b281d6c9c 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -97,6 +97,8 @@ struct sk_psock {
>  	struct sk_buff_head		ingress_skb;
>  	struct list_head		ingress_msg;
>  	spinlock_t			ingress_lock;
> +	/** @msg_tot_len: Total bytes queued in ingress_msg list. */
> +	u32				msg_tot_len;
>  	unsigned long			state;
>  	struct list_head		link;
>  	spinlock_t			link_lock;
> @@ -321,6 +323,27 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
>  	kfree_skb(skb);
>  }
>  
> +static inline u32 sk_psock_get_msg_len_nolock(struct sk_psock *psock)
> +{
> +	/* Used by ioctl to read msg_tot_len only; lock-free for performance */
> +	return READ_ONCE(psock->msg_tot_len);
> +}
> +
> +static inline void sk_psock_msg_len_add_locked(struct sk_psock *psock, int diff)
> +{
> +	/* Use WRITE_ONCE to ensure correct read in sk_psock_get_msg_len_nolock().
> +	 * ingress_lock should be held to prevent concurrent updates to msg_tot_len
> +	 */
> +	WRITE_ONCE(psock->msg_tot_len, psock->msg_tot_len + diff);
> +}
> +
> +static inline void sk_psock_msg_len_add(struct sk_psock *psock, int diff)
> +{
> +	spin_lock_bh(&psock->ingress_lock);
> +	sk_psock_msg_len_add_locked(psock, diff);
> +	spin_unlock_bh(&psock->ingress_lock);
> +}
> +
>  static inline bool sk_psock_queue_msg(struct sk_psock *psock,
>  				      struct sk_msg *msg)
>  {
> @@ -329,6 +352,7 @@ static inline bool sk_psock_queue_msg(struct sk_psock *psock,
>  	spin_lock_bh(&psock->ingress_lock);
>  	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
>  		list_add_tail(&msg->list, &psock->ingress_msg);
> +		sk_psock_msg_len_add_locked(psock, msg->sg.size);
>  		ret = true;
>  	} else {
>  		sk_msg_free(psock->sk, msg);
> @@ -345,18 +369,25 @@ static inline struct sk_msg *sk_psock_dequeue_msg(struct sk_psock *psock)
>  
>  	spin_lock_bh(&psock->ingress_lock);
>  	msg = list_first_entry_or_null(&psock->ingress_msg, struct sk_msg, list);
> -	if (msg)
> +	if (msg) {
>  		list_del(&msg->list);
> +		sk_psock_msg_len_add_locked(psock, -msg->sg.size);
> +	}
>  	spin_unlock_bh(&psock->ingress_lock);
>  	return msg;
>  }
>  
> +static inline struct sk_msg *sk_psock_peek_msg_locked(struct sk_psock *psock)
> +{
> +	return list_first_entry_or_null(&psock->ingress_msg, struct sk_msg, list);
> +}
> +
>  static inline struct sk_msg *sk_psock_peek_msg(struct sk_psock *psock)
>  {
>  	struct sk_msg *msg;
>  
>  	spin_lock_bh(&psock->ingress_lock);
> -	msg = list_first_entry_or_null(&psock->ingress_msg, struct sk_msg, list);
> +	msg = sk_psock_peek_msg_locked(psock);
>  	spin_unlock_bh(&psock->ingress_lock);
>  	return msg;
>  }
> @@ -523,6 +554,39 @@ static inline bool sk_psock_strp_enabled(struct sk_psock *psock)
>  	return !!psock->saved_data_ready;
>  }
>  
> +/* for tcp only, sk is locked */
> +static inline ssize_t sk_psock_msg_inq(struct sock *sk)
> +{
> +	struct sk_psock *psock;
> +	ssize_t inq = 0;
> +
> +	psock = sk_psock_get(sk);
> +	if (likely(psock)) {
> +		inq = sk_psock_get_msg_len_nolock(psock);
> +		sk_psock_put(sk, psock);
> +	}
> +	return inq;
> +}
> +
> +/* for udp only, sk is not locked */
> +static inline ssize_t sk_msg_first_len(struct sock *sk)
> +{
> +	struct sk_psock *psock;
> +	struct sk_msg *msg;
> +	ssize_t inq = 0;
> +
> +	psock = sk_psock_get(sk);
> +	if (likely(psock)) {
> +		spin_lock_bh(&psock->ingress_lock);
> +		msg = sk_psock_peek_msg_locked(psock);
> +		if (msg)
> +			inq = msg->sg.size;
> +		spin_unlock_bh(&psock->ingress_lock);
> +		sk_psock_put(sk, psock);
> +	}
> +	return inq;
> +}
> +
>  #if IS_ENABLED(CONFIG_NET_SOCK_MSG)
>  
>  #define BPF_F_STRPARSER	(1UL << 1)
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index ca22ecdbf192..dd1965bf8f6a 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -458,6 +458,7 @@ int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg
>  					atomic_sub(copy, &sk->sk_rmem_alloc);
>  				}
>  				msg_rx->sg.size -= copy;
> +				sk_psock_msg_len_add(psock, -copy);
>  
>  				if (!sge->length) {
>  					sk_msg_iter_var_next(i);
> @@ -822,9 +823,11 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
>  		list_del(&msg->list);
>  		if (!msg->skb)
>  			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
> +		sk_psock_msg_len_add(psock, -msg->sg.size);
>  		sk_msg_free(psock->sk, msg);
>  		kfree(msg);
>  	}
> +	WARN_ON_ONCE(psock->msg_tot_len);
>  }
>  
>  static void __sk_psock_zap_ingress(struct sk_psock *psock)
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 5c698fd7fbf8..476101533349 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -10,6 +10,7 @@
>  
>  #include <net/inet_common.h>
>  #include <net/tls.h>
> +#include <asm/ioctls.h>
>  
>  void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
>  {
> @@ -332,6 +333,36 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	return copied;
>  }
>  
> +static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
> +{
> +	bool slow;
> +
> +	if (cmd != SIOCINQ)
> +		return tcp_ioctl(sk, cmd, karg);
> +
> +	/* works similar as tcp_ioctl */
> +	if (sk->sk_state == TCP_LISTEN)
> +		return -EINVAL;
> +
> +	slow = lock_sock_fast(sk);
> +
> +	/* sk_receive_queue being non-empty only occurs if the sk received
> +	 * data before being accepted, and no new data has arrived to trigger
> +	 * read_skb. If data comes from the sk's native stack, we will also
> +	 * consume sk_receive_queue using read_skb.
> +	 */

You mean "before being added to sockmap"?

> +	if (unlikely(!skb_queue_empty(&sk->sk_receive_queue))) {
> +		unlock_sock_fast(sk, slow);
> +		return tcp_ioctl(sk, cmd, karg);
> +	}
> +
> +	*karg = sk_psock_msg_inq(sk);
> +
> +	unlock_sock_fast(sk, slow);
> +
> +	return 0;
> +}
> +
>  static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  			   int flags, int *addr_len)
>  {
> @@ -610,6 +641,7 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
>  	prot[TCP_BPF_BASE].close		= sock_map_close;
>  	prot[TCP_BPF_BASE].recvmsg		= tcp_bpf_recvmsg;
>  	prot[TCP_BPF_BASE].sock_is_readable	= sk_msg_is_readable;
> +	prot[TCP_BPF_BASE].ioctl		= tcp_bpf_ioctl;
>  
>  	prot[TCP_BPF_TX]			= prot[TCP_BPF_BASE];
>  	prot[TCP_BPF_TX].sendmsg		= tcp_bpf_sendmsg;
> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index 0735d820e413..91233e37cd97 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c
> @@ -5,6 +5,7 @@
>  #include <net/sock.h>
>  #include <net/udp.h>
>  #include <net/inet_common.h>
> +#include <asm/ioctls.h>
>  
>  #include "udp_impl.h"
>  
> @@ -111,12 +112,26 @@ enum {
>  static DEFINE_SPINLOCK(udpv6_prot_lock);
>  static struct proto udp_bpf_prots[UDP_BPF_NUM_PROTS];
>  
> +static int udp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
> +{
> +	if (cmd != SIOCINQ)
> +		return udp_ioctl(sk, cmd, karg);
> +
> +	/* Since we don't hold a lock, sk_receive_queue may contain data.
> +	 * BPF might only be processing this data at the moment. We only
> +	 * care about the data in the ingress_msg here.
> +	 */

I think we should strive for a design where FIONREAD does not go down
after you add your socket to sockmap, if there was no recvmsg call in
between. To show what I mean, I added this test that's currently failing
for udp:

---8<---
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1f1289f5a8c2..123c96fcaef0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1229,6 +1229,66 @@ static void test_sockmap_copied_seq(bool strp)
 	test_sockmap_pass_prog__destroy(skel);
 }
 
+/* Test FIONREAD when data exists in sk_receive_queue before sockmap insertion */
+static void test_sockmap_fionread_pre_insert(int sotype)
+{
+	int map, err, sent, recvd, zero = 0, avail = 0;
+	struct test_sockmap_pass_prog *skel = NULL;
+	int c = -1, p = -1;
+	char buf[10] = "0123456789", rcv[11];
+	struct bpf_program *prog;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	prog = skel->progs.prog_skb_verdict;
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+
+	err = bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach verdict"))
+		goto end;
+
+	err = create_pair(AF_INET, sotype, &c, &p);
+	if (!ASSERT_OK(err, "create_pair"))
+		goto end;
+
+	/* Step 1: Send data BEFORE sockmap insertion - lands in sk_receive_queue */
+	sent = xsend(p, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(sent, sizeof(buf), "xsend pre-insert"))
+		goto end;
+
+	/* Step 2: Verify FIONREAD reports data in sk_receive_queue */
+	err = poll_read(c, IO_TIMEOUT_SEC);
+	if (!ASSERT_OK(err, "poll_read pre-insert"))
+		goto end;
+	err = ioctl(c, FIONREAD, &avail);
+	ASSERT_OK(err, "ioctl(FIONREAD) pre-insert error");
+	ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD) pre-insert");
+
+	/* Step 3: Insert socket into sockmap */
+	err = bpf_map_update_elem(map, &zero, &c, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(c)"))
+		goto end;
+
+	/* Step 4: FIONREAD should still report the data in sk_receive_queue */
+	err = ioctl(c, FIONREAD, &avail);
+	ASSERT_OK(err, "ioctl(FIONREAD) post-insert error");
+	ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD) post-insert");
+
+	/* Verify we can still read the data */
+	recvd = recv_timeout(c, rcv, sizeof(rcv), MSG_DONTWAIT, IO_TIMEOUT_SEC);
+	ASSERT_EQ(recvd, sizeof(buf), "recv post-insert");
+	ASSERT_OK(memcmp(buf, rcv, recvd), "data mismatch");
+
+end:
+	if (c >= 0)
+		close(c);
+	if (p >= 0)
+		close(p);
+	test_sockmap_pass_prog__destroy(skel);
+}
+
 /* it is used to send data to via native stack and BPF redirecting */
 static void test_sockmap_multi_channels(int sotype)
 {
@@ -1373,4 +1433,8 @@ void test_sockmap_basic(void)
 		test_sockmap_multi_channels(SOCK_STREAM);
 	if (test__start_subtest("sockmap udp multi channels"))
 		test_sockmap_multi_channels(SOCK_DGRAM);
+	if (test__start_subtest("sockmap tcp fionread pre-insert"))
+		test_sockmap_fionread_pre_insert(SOCK_STREAM);
+	if (test__start_subtest("sockmap udp fionread pre-insert"))
+		test_sockmap_fionread_pre_insert(SOCK_DGRAM);
 }
--->8---


> +	*karg = sk_msg_first_len(sk);
> +	return 0;
> +}
> +
>  static void udp_bpf_rebuild_protos(struct proto *prot, const struct proto *base)
>  {
> -	*prot        = *base;
> -	prot->close  = sock_map_close;
> -	prot->recvmsg = udp_bpf_recvmsg;
> -	prot->sock_is_readable = sk_msg_is_readable;
> +	*prot			= *base;
> +	prot->close		= sock_map_close;
> +	prot->recvmsg		= udp_bpf_recvmsg;
> +	prot->sock_is_readable	= sk_msg_is_readable;
> +	prot->ioctl		= udp_bpf_ioctl;
>  }
>  
>  static void udp_bpf_check_v6_needs_rebuild(struct proto *ops)

