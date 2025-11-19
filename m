Return-Path: <linux-kselftest+bounces-46017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C72BC70EBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 20:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74A82347DF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 19:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB010371DC3;
	Wed, 19 Nov 2025 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eyetexJU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC1303A1A
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582023; cv=none; b=qn11PtoZO52sGY2LL0hnCirvt+3G/iNvd/m8btyEII90q4KBLs/PEg5coYTOU0abChWKXw6+LedFKvZ47ZNO4xYTsCUVoYDb7ABxHR57mEihScJW2rL6w5Xot5iRR5L4acQOdQTC5cX5nxUoZRuaknuEFdRUYuDdw1kApKqFR0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582023; c=relaxed/simple;
	bh=0Akz0+lNh1xHfq2Nl+iVgGPrSVUHVmkhlu32PmBwXjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JLQhuf6qEQEzR5rkT5JfT321qoA+/MkJlQiMof8aPhi0o/ywNTVT5ZYwmpPN6s1p40XhL9L/Qpj/cO0vBoOssBX1BAxKEuvJZtpNJ8gEsOypvlyCKsfHcfZ8YtkWiqqfj34nSBNGdJgNJ7XxImwEpkx7WN3Ji6e8yLKxSm/2fH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eyetexJU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so98854a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 11:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1763582016; x=1764186816; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aem5xOVJvhgpFL5eZXcfB54MezIBm+m/g090fjqNIPQ=;
        b=eyetexJU3g7mzl5x8JXkQuaQjuNUJ8y/X25XiRUh1aPv+am+NM5c9fFSidaihuD4Rs
         owOVN1HPqyroI770CSKz+YQEYz4E6AstmfWvgpXb8WVhtH8XFcmoZd8KoiL/HGk5/rbH
         9Uimo906Z2sbYO3riSx4KyLLvwwmYQ1R9QkLl/fybEAG2aHiNeOYBDmAzzYNhbxbJ31Z
         QsroQCrX9ZWu29rrHH+4WUklItbTTb/LbVmw6BgEjW1HNphCT23U/5Bin5qFm6dI+TpH
         ITe2kEzRBHkMZ3XVwQ08wZZZK3d7gGcu9MBX9AbbWxlkq5bwHxa8rrg6SLyK4Iy0Bgwn
         WVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763582016; x=1764186816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aem5xOVJvhgpFL5eZXcfB54MezIBm+m/g090fjqNIPQ=;
        b=S8X6oaJcBqFqBfcIPCyVD35LCHSWkF/yRjpM4KMrEJ6XqF0dB+CTpShaOx14VFifBm
         Z4J/EBM0ovhhpH4iWyRiFOz1JE8hagWmS0mPuxwQZWWTsnZQs8WowL71TYjjxUj/uunc
         MaOg3xhkczXAZTD/9Y48FVrQBMIlDc7yNgNxFpuZzVqjwHhNtSwOGGlJ+zGluVun7yYZ
         CLNISbS9Gn+wHfJTO1cu/Alz1zy3YNUoLjhsW+/JHw8UGXLjaqlJGik96X/pRylLrKZ6
         70RB8Jn6MiDGJlckianlR1HqHaQFgg1MpMvBQ3y/9wUBgaCJRo1yvK8Yrq8CZu/QsyJC
         wCqA==
X-Forwarded-Encrypted: i=1; AJvYcCU7W4PhdSNYwN0uBSBTGgllhXll8te8M4WfBwktfh451uJTcsbUzBh5XUbabInnANZ6RtLfx145ilzjBEzPDhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW6PNia8vrI4fingD7t+r2wwOKaTW872CFdSDZaUn3Lh4SfGF0
	Vi1fd4Q8DpNQgymxp4Ij+267oVSahuKbIimjLROjjcLeq01J/qI9QkPYDlB4OwpVH9Y=
X-Gm-Gg: ASbGncvCeprH61nFfF8E7JN8TpNQhA9uhEKaavn2V8PZxdryMICJ8obuZ8NuNhhKZo2
	D0RK8McuhT6xbartWmlApJL8W0w7olGYSk8va4ZUyTNEg5zAiM01SWyeHHensbyr40E0lY/hsur
	QxVydLU+6FQf4p+V8XfjJz91jtle/U+4zPd3TZ+2Yz8X6jB73CJMDo6VGOHUndMGdCYVZ4GexBc
	EvK/fMKGbOLss28vbjqddg8QyMxTjtZdWLTrzEYkYMJBFtt4Z/zBXj7B33timoRgrBq2ZPa/0oQ
	7VE8G1uIprDc5JjtWPeqTszebTiEOtR2X0m+/CCX7hWoomjoUNxdS87fHCgwULEBBh8F98GnzaV
	IxzqN7deldOv22LBfC3jldjrRFexgCDU0mfyQ7Ii45td5YTaWDwGrP6f3tgoWtqPIfezH0lT2lI
	28aJFTsG0JRcJgz450cHU6hrxV
X-Google-Smtp-Source: AGHT+IGzw2bAN/LjeUPdPS5iyXmbC02OEZ1xM5G58Srnj8lbxl9efxcDcTwBXx3YJ4DcTxSJ62ipqw==
X-Received: by 2002:a17:907:c04:b0:b73:7710:fe03 with SMTP id a640c23a62f3a-b76554a52bbmr24911466b.58.1763582016246;
        Wed, 19 Nov 2025 11:53:36 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2969::420:5c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4f4esm18582566b.45.2025.11.19.11.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:53:35 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  John Fastabend <john.fastabend@gmail.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Neal Cardwell <ncardwell@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Michal Luczaj <mhal@rbox.co>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Cong Wang <cong.wang@bytedance.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] bpf, sockmap: Fix incorrect copied_seq
 calculation
In-Reply-To: <20251117110736.293040-2-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Mon, 17 Nov 2025 19:07:05 +0800")
References: <20251117110736.293040-1-jiayuan.chen@linux.dev>
	<20251117110736.293040-2-jiayuan.chen@linux.dev>
Date: Wed, 19 Nov 2025 20:53:34 +0100
Message-ID: <87zf8h6bpd.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 17, 2025 at 07:07 PM +08, Jiayuan Chen wrote:
> A socket using sockmap has its own independent receive queue: ingress_msg.
> This queue may contain data from its own protocol stack or from other
> sockets.
>
> The issue is that when reading from ingress_msg, we update tp->copied_seq
> by default. However, if the data is not from its own protocol stack,
> tcp->rcv_nxt is not increased. Later, if we convert this socket to a
> native socket, reading from this socket may fail because copied_seq might
> be significantly larger than rcv_nxt.
>
> This fix also addresses the syzkaller-reported bug referenced in the
> Closes tag.
>
> This patch marks the skmsg objects in ingress_msg. When reading, we update
> copied_seq only if the data is from its own protocol stack.
>
>                                                      FD1:read()
>                                                      --  FD1->copied_seq++
>                                                          |  [read data]
>                                                          |
>                                 [enqueue data]           v
>                   [sockmap]     -> ingress to self ->  ingress_msg queue
> FD1 native stack  ------>                                 ^
> -- FD1->rcv_nxt++               -> redirect to other      | [enqueue data]
>                                        |                  |
>                                        |             ingress to FD1
>                                        v                  ^
>                                       ...                 |  [sockmap]
>                                                      FD2 native stack
>
> Closes: https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  include/linux/skmsg.h | 25 ++++++++++++++++++++++++-
>  net/core/skmsg.c      | 19 ++++++++++++++++---
>  net/ipv4/tcp_bpf.c    |  5 +++--
>  3 files changed, 43 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 49847888c287..b7826cb2a388 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -23,6 +23,17 @@ enum __sk_action {
>  	__SK_NONE,
>  };
>  
> +/* The BPF program sets BPF_F_INGRESS on sk_msg to indicate data needs to be
> + * redirected to the ingress queue of a specified socket. Since BPF_F_INGRESS is
> + * defined in UAPI so that we can't extend this enum for our internal flags. We
> + * define some internal flags here while inheriting BPF_F_INGRESS.
> + */
> +enum {
> +	SK_MSG_F_INGRESS	= BPF_F_INGRESS, /* (1ULL << 0) */
> +	/* internal flag */
> +	SK_MSG_F_INGRESS_SELF	= (1ULL << 1)
> +};
> +


I'm wondering if we need additional state to track this.
Can we track sk_msg's construted from skb's that were not redirected by
setting `sk_msg.sk = sk` to indicate that the source socket is us in
sk_psock_skb_ingress_self()?

If not, then I'd just offset the internal flags like we do in
net/core/filter.c, BPF_F_REDIRECT_INTERNAL.

>  struct sk_msg_sg {
>  	u32				start;
>  	u32				curr;
> @@ -141,8 +152,20 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
>  			     struct sk_msg *msg, u32 bytes);
>  int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  		   int len, int flags);
> +int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> +		     int len, int flags, int *from_self_copied);
>  bool sk_msg_is_readable(struct sock *sk);
>  
> +static inline bool sk_msg_is_to_self(struct sk_msg *msg)
> +{
> +	return msg->flags & SK_MSG_F_INGRESS_SELF;
> +}
> +
> +static inline void sk_msg_set_to_self(struct sk_msg *msg)
> +{
> +	msg->flags |= SK_MSG_F_INGRESS_SELF;
> +}
> +
>  static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
>  {
>  	WARN_ON(i == msg->sg.end && bytes);
> @@ -235,7 +258,7 @@ static inline struct page *sk_msg_page(struct sk_msg *msg, int which)
>  
>  static inline bool sk_msg_to_ingress(const struct sk_msg *msg)
>  {
> -	return msg->flags & BPF_F_INGRESS;
> +	return msg->flags & SK_MSG_F_INGRESS;
>  }
>  
>  static inline void sk_msg_compute_data_pointers(struct sk_msg *msg)
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2ac7731e1e0a..25d88c2082e9 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -409,14 +409,14 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
>  }
>  EXPORT_SYMBOL_GPL(sk_msg_memcopy_from_iter);
>  
> -/* Receive sk_msg from psock->ingress_msg to @msg. */
> -int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> -		   int len, int flags)
> +int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> +		     int len, int flags, int *from_self_copied)
>  {
>  	struct iov_iter *iter = &msg->msg_iter;
>  	int peek = flags & MSG_PEEK;
>  	struct sk_msg *msg_rx;
>  	int i, copied = 0;
> +	bool to_self;
>  
>  	msg_rx = sk_psock_peek_msg(psock);
>  	while (copied != len) {
> @@ -425,6 +425,7 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  		if (unlikely(!msg_rx))
>  			break;
>  
> +		to_self = sk_msg_is_to_self(msg_rx);
>  		i = msg_rx->sg.start;
>  		do {
>  			struct page *page;
> @@ -443,6 +444,9 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  			}
>  
>  			copied += copy;
> +			if (to_self && from_self_copied)
> +				*from_self_copied += copy;
> +
>  			if (likely(!peek)) {
>  				sge->offset += copy;
>  				sge->length -= copy;
> @@ -487,6 +491,14 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  out:
>  	return copied;
>  }
> +EXPORT_SYMBOL_GPL(__sk_msg_recvmsg);
> +
> +/* Receive sk_msg from psock->ingress_msg to @msg. */
> +int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> +		   int len, int flags)
> +{
> +	return __sk_msg_recvmsg(sk, psock, msg, len, flags, NULL);
> +}
>  EXPORT_SYMBOL_GPL(sk_msg_recvmsg);
>  
>  bool sk_msg_is_readable(struct sock *sk)
> @@ -616,6 +628,7 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
>  	if (unlikely(!msg))
>  		return -EAGAIN;
>  	skb_set_owner_r(skb, sk);
> +	sk_msg_set_to_self(msg);
>  	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
>  	if (err < 0)
>  		kfree(msg);
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index a268e1595b22..6332fc36ffe6 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -226,6 +226,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	int peek = flags & MSG_PEEK;
>  	struct sk_psock *psock;
>  	struct tcp_sock *tcp;
> +	int from_self_copied = 0;
>  	int copied = 0;
>  	u32 seq;
>  
> @@ -262,7 +263,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	}
>  
>  msg_bytes_ready:
> -	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
> +	copied = __sk_msg_recvmsg(sk, psock, msg, len, flags, &from_self_copied);
>  	/* The typical case for EFAULT is the socket was gracefully
>  	 * shutdown with a FIN pkt. So check here the other case is
>  	 * some error on copy_page_to_iter which would be unexpected.
> @@ -277,7 +278,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  			goto out;
>  		}
>  	}
> -	seq += copied;
> +	seq += from_self_copied;
>  	if (!copied) {
>  		long timeo;
>  		int data;

