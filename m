Return-Path: <linux-kselftest+bounces-48399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6A7CFDD59
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 14:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8D753031A0F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 13:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C073A318130;
	Wed,  7 Jan 2026 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YS0lg+fh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D022D8DDB
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790892; cv=none; b=Cg+ZwhWKAluaETxeSTIme75rTdKfO/8gaOfINMzogNUYYqrHEzcMnPlmXbKRoKfJ5orTVk62eZTOsQI4sdGurTT/q8MSRLP9ZYQXDn3RF5dYs0Gb6CikmAOt9Nmaq3FQPdOCU+rQxaf59SqPf+EfXDp1fKhRgJOU2PgSCK01bjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790892; c=relaxed/simple;
	bh=ZFBHKnCoBPdFWOIGkoJWE8ZkaUPWI6yc4PvUJ0tWoVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CIUzZXpCJCOHyJIEJgkyWPEYEYFsPJQdEe+wlM2y2BS6YkYciZh7IZNRk9fqglAe/tBi6/5EpFT2lxPIK0oMKEsA69v9PNIETI35KYGe/ImwfLEN8TD71QBPS/uUu9ul7yvivoIuRvSPti8AqA0QHG8yUqswY9VBUjfI0qT6oIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YS0lg+fh; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-650854c473fso1596972a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 05:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767790889; x=1768395689; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xir3ca+ukIVh/RHVo7Ct0xUP1DZl1QDE+zdc0E28knM=;
        b=YS0lg+fhzEioA+R8RLxRY1rbXQ6hSQLdrteJEAnmTIu0R23HV2yEDITk58AnTuRfc8
         mMZRMYrKgIIH25vtVbeqvp7dS/epFGw+cfX9TG3LOmnIXSuIpgz16MRuBjYCJN04xI+j
         BuVpJvCmmzY7GyyyiZP59ttTQMJBhI+F+woOAt1DHnMfXBJKOQbIU0HouBJXA7qBgXnx
         AbTZChIiXkOhQUWKjaZja9nkhUcOwqTL0EQqj63+/Qkx31KwgeyEKtOZpgRS1qLD1lh5
         bDy2NTZkWngCLIFhGY1vvVffQXTLoOf3DHvizYVnzt9/EE4vI/9Lke+kCY/WBZ99J4gu
         dNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767790889; x=1768395689;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xir3ca+ukIVh/RHVo7Ct0xUP1DZl1QDE+zdc0E28knM=;
        b=SuVLjr1ANPVX2BPpTQKTAGKpYWk5cDdoLoPcDw1JkXVcP9+VYlppiaYb7T7CC3EPh1
         duRCBHdxTZhLBNW4Az9D0Cg1qrT1rglTwUhiKHuI//HEs62w/KON+XgB7Mck5aH6WGH6
         dTHaQ2IKGIVyZ5iC48nW0NvKq0L+9NVYrKIYzcx9sZjJO4qzS3a5dUmsDUmJc37/8dyk
         7Kya3F2PjeFU4YYX0qXk2fJvhxNDl+EAQDVjlXhgm2VNSKnWusjR46QhdrzJGJyWyi0F
         0Vt93492vngGuc2wVLKF0v+2plJr3cYuCLXWy3E8Zrg/tO7A2szyAkWHFk/4NP9nW9pf
         t6iw==
X-Forwarded-Encrypted: i=1; AJvYcCVIOM6YUicVtpqSikGSHV0Z1p6kQ1p5Ft5H5Q12jwnfRrhmrkzPQuOeGfNFTzPvDvLIK0w/UCrX3QFFc4VqT4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIBtmeH54/BAOS5QyZHdZbMRsUGH4cHz/htbmylAzhXtE3nZJi
	bhzBZnwDgJUhOUjlHOx1F3Dz8sTtIUUpkzmJDFUu0WY9ZFsSwndNqTI1E/SBi+dYSWQ=
X-Gm-Gg: AY/fxX7x+z6cWYJSmLZj1RLSn+Ral3BEb3uXxRc0TY99rWa+YPYC1lsb10w/MH75vc4
	/LkI892hvp89lUfmHxuP8vwkLrVqKHNWMPP00ikAeX61zj2cs8nQoLwmYh9WYGW0ZpENTWSWFPq
	bCawbAnUOk/Q968KFsR0Zq690nacMcu7UIGMVu17TpM4NEnV1ShlZMT/jai8z6W9UDjqT48ahck
	uU/BAizlM+8Q/fswxaGKxcc6Ux28xe4vtdwRAJKbvTkB/dZcohr5Yi74OzaCx/j13UxSH5Trcrf
	SluiWo/IulkrE0G9MvGhAlQY+MwDLYjWXtn2nDeixBHeqyXjo2CCtsbMgMqLKF4ahI8sgj/dkQA
	XFKEGALtqMo07STmxFZZS7iMKOCoCYDoJIosD0Q4Mt0Ta2ZGjR97BXCP3spYXh1oLYpGZlEjcrb
	d9fBVg/atn3uBAiQ==
X-Google-Smtp-Source: AGHT+IEHgppdZ9+MA6XjO99QW33t8OQ8GPnpF0g3kbKM6o5sKERqSqJ/zi1nzB6V76byczxXQVMLPg==
X-Received: by 2002:aa7:d74d:0:b0:649:81d7:581c with SMTP id 4fb4d7f45d1cf-6507bc3d7fbmr4690740a12.1.1767790888994;
        Wed, 07 Jan 2026 05:01:28 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2969::420:12])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4429789a12.10.2026.01.07.05.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 05:01:28 -0800 (PST)
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
 <shuah@kernel.org>,  Stefano Garzarella <sgarzare@redhat.com>,  Michal
 Luczaj <mhal@rbox.co>,  Cong Wang <cong.wang@bytedance.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf, sockmap: Fix incorrect copied_seq
 calculation
In-Reply-To: <20260106051458.279151-2-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Tue, 6 Jan 2026 13:14:27 +0800")
References: <20260106051458.279151-1-jiayuan.chen@linux.dev>
	<20260106051458.279151-2-jiayuan.chen@linux.dev>
Date: Wed, 07 Jan 2026 14:01:27 +0100
Message-ID: <87ms2pinko.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 06, 2026 at 01:14 PM +08, Jiayuan Chen wrote:
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
>  include/linux/skmsg.h |  2 ++
>  net/core/skmsg.c      | 25 ++++++++++++++++++++++---
>  net/ipv4/tcp_bpf.c    |  5 +++--
>  3 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 49847888c287..0323a2b6cf5e 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -141,6 +141,8 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
>  			     struct sk_msg *msg, u32 bytes);
>  int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  		   int len, int flags);
> +int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
> +		     int len, int flags, int *from_self_copied);
>  bool sk_msg_is_readable(struct sock *sk);
>  
>  static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2ac7731e1e0a..d73e03f7713a 100644
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

Nit: Can we unify the naming and make it read more naturally?

s/to_self/from_self/
s/from_self_copied/copied_from_self/

Otherwise LGTM:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

