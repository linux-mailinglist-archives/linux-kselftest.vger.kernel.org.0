Return-Path: <linux-kselftest+bounces-10250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C508C6458
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 11:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771E51F21D8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 09:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458E15FB8B;
	Wed, 15 May 2024 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="CyTK+oMk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D62F5B05E
	for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766785; cv=none; b=Bzu/wgk//eTampovF32FXEqTnfa7HS/8InLjYHmqPHcJfsZARKSVCfY+96EL2AZsI8zXfqPS8VO5sFC57i4xFLS4jGaz7k0hQKhomDj5Y/23LMa7P5shURhh81kVVG/6AyhEQNn8Q84HJ20Mg+WVE522UfyhSqBDSx6KYJhCsok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766785; c=relaxed/simple;
	bh=TsOk3vFqremJkiKTf83L+7lVwN7NONoMxe4kSI6IvYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANUsh0DDsu8IGzj7/gHjv4+UZfoHKVGosfLRSeZRSijz2zrYluauhw2lScgX39pNotGIltaa7DOUiNQG5jNP1AMON/Y0q10md/SrxfgdBjs3vSYVd91P8kmexke4Xe//ehxbGb7Zlx6d2oGdhLyikjMuVxYeErca8SdK7Iql7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=CyTK+oMk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-572e48f91e9so1528648a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2024 02:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1715766782; x=1716371582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1lmRXypy+tgqjJjCBelLKezDGdnEAnnPizIiNZdruM=;
        b=CyTK+oMkbUZvJX+UEpXD2WFMSiEdaF9FbbEkHgrzxqIOXJh3IjX7fUED53WyhtfNCd
         n2EIRkb6K9WTdMARS9VuK3lIcwCF+typcSHLH8KJGqwuPma5t+cvhe1NS61b8h6qwBS9
         mwkIWHGaxIqTXF7Z16UhZF5rk3gXWnzQYKdn3/bSx+l9CaYvAZ7b1mGjre/zhtmIw1DR
         RKNJlKAICoTaHxukGyzYNIJyvWGUzOle01tTAWgalCoZoqZ6ZcgK2yzNZGrfyW/vCVKi
         Cqm3jpwjE0S+sh5WKfhm6aGR9HpoF3H7IOUypLZ8RwI1GxjJa/GYPwQbzgxCpJMUYCBL
         n9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715766782; x=1716371582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1lmRXypy+tgqjJjCBelLKezDGdnEAnnPizIiNZdruM=;
        b=qxbie0Bl4zdzCTgnd5SXGsT1tCG2SXYAk2z1iC+nbYkpELael4HQXjgXy7Kin9y/fq
         u6tnCsoVY6FeNF+L8ysy5hsgZCQ4TVKY+UUIEw+Xz/6MmUS7C66sKEFIdiJ85iFFi12m
         cUYO9QDwjU9zt1+jgM8SfTR+SK0J5aNhtJSJ4rhg2gZHITpbxRDOSk1/Gyg/+08v0Y8E
         n+2hIYQf4TYEoYuCGkbyphQ8NopqiA84dCyhaLjol2aYWguFp5KLc16xoIcXX7ebypdF
         LXhTQWIH9Xa4Q0xBG3HId+qGMv3Y+SG7eq7xGo2IfCA9XmUv8Wfl7fckb374S5phaG37
         GRuA==
X-Forwarded-Encrypted: i=1; AJvYcCXLo58dkrhV80pNwAbLMTi0Igg+hIhAU2QF90T5akUbPAJlzhgU64vOpgMgJ8ujpcc+sueA3Y2yqTdYb8r38Q7fZ/HQyu9sv/sIJwOgJEKz
X-Gm-Message-State: AOJu0Yzhf6fUGoSbRkDuWZTQZnGgiJlSueLdyF+jNMgvVrxyfT0yMIHJ
	ntw9R4pJ07i0O14foHXy98Z2qLy1/T91X7Jx4VWjas13jlMg6UBh3hdAU6sz9+w=
X-Google-Smtp-Source: AGHT+IHJ/nIQ9Mj+hR5RkGPoGTlj6+iE5Zdg+QT5yPe2HHYjGXYAnkxMww7zPjsNTDTMLKdw2VFCRA==
X-Received: by 2002:a50:f699:0:b0:56e:f64:aaf6 with SMTP id 4fb4d7f45d1cf-5734d5c16dfmr11167023a12.5.1715766781663;
        Wed, 15 May 2024 02:53:01 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebb687sm8592378a12.25.2024.05.15.02.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 02:53:01 -0700 (PDT)
Message-ID: <0e5007fb-2d95-4cbb-b0a6-baa0d20e9469@blackwall.org>
Date: Wed, 15 May 2024 12:52:57 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 12/14] net: add SO_DEVMEM_DONTNEED setsockopt
 to release RX frags
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240510232128.1105145-1-almasrymina@google.com>
 <20240510232128.1105145-13-almasrymina@google.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240510232128.1105145-13-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/05/2024 02:21, Mina Almasry wrote:
> Add an interface for the user to notify the kernel that it is done
> reading the devmem dmabuf frags returned as cmsg. The kernel will
> drop the reference on the frags to make them available for reuse.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v7:
> - Updated SO_DEVMEM_* uapi to use the next available entry (Arnd).
> 
> v6:
> - Squash in locking optimizations from edumazet@google.com. With his
>   changes we lock the xarray once per sock_devmem_dontneed operation
>   rather than once per frag.
> 
> Changes in v1:
> - devmemtoken -> dmabuf_token (David).
> - Use napi_pp_put_page() for refcounting (Yunsheng).
> - Fix build error with missing socket options on other asms.
> 
> ---
>  arch/alpha/include/uapi/asm/socket.h  |  1 +
>  arch/mips/include/uapi/asm/socket.h   |  1 +
>  arch/parisc/include/uapi/asm/socket.h |  1 +
>  arch/sparc/include/uapi/asm/socket.h  |  1 +
>  include/uapi/asm-generic/socket.h     |  1 +
>  include/uapi/linux/uio.h              |  4 ++
>  net/core/sock.c                       | 61 +++++++++++++++++++++++++++
>  7 files changed, 70 insertions(+)
> 
[snip]
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 8d6e638b5426d..2edb988259e8d 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -124,6 +124,7 @@
>  #include <linux/netdevice.h>
>  #include <net/protocol.h>
>  #include <linux/skbuff.h>
> +#include <linux/skbuff_ref.h>
>  #include <net/net_namespace.h>
>  #include <net/request_sock.h>
>  #include <net/sock.h>
> @@ -1049,6 +1050,62 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PAGE_POOL
> +static noinline_for_stack int
> +sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
> +{
> +	unsigned int num_tokens, i, j, k, netmem_num = 0;
> +	struct dmabuf_token *tokens;
> +	netmem_ref netmems[16];
> +	int ret;
> +
> +	if (sk->sk_type != SOCK_STREAM || sk->sk_protocol != IPPROTO_TCP)
> +		return -EBADF;
> +
> +	if (optlen % sizeof(struct dmabuf_token) ||
> +	    optlen > sizeof(*tokens) * 128)
> +		return -EINVAL;
> +
> +	tokens = kvmalloc_array(128, sizeof(*tokens), GFP_KERNEL);
> +	if (!tokens)
> +		return -ENOMEM;
> +
> +	num_tokens = optlen / sizeof(struct dmabuf_token);
> +	if (copy_from_sockptr(tokens, optval, optlen))
> +		return -EFAULT;

tokens isn't freed in this error case

> +
> +	ret = 0;
> +
> +	xa_lock_bh(&sk->sk_user_frags);
> +	for (i = 0; i < num_tokens; i++) {
> +		for (j = 0; j < tokens[i].token_count; j++) {
> +			netmem_ref netmem = (__force netmem_ref)__xa_erase(
> +				&sk->sk_user_frags, tokens[i].token_start + j);
> +
> +			if (netmem &&
> +			    !WARN_ON_ONCE(!netmem_is_net_iov(netmem))) {
> +				netmems[netmem_num++] = netmem;
> +				if (netmem_num == ARRAY_SIZE(netmems)) {
> +					xa_unlock_bh(&sk->sk_user_frags);
> +					for (k = 0; k < netmem_num; k++)
> +						WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> +					netmem_num = 0;
> +					xa_lock_bh(&sk->sk_user_frags);
> +				}
> +				ret++;
> +			}
> +		}
> +	}
> +
> +	xa_unlock_bh(&sk->sk_user_frags);
> +	for (k = 0; k < netmem_num; k++)
> +		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> +
> +	kvfree(tokens);
> +	return ret;
> +}
> +#endif
> +
>  void sockopt_lock_sock(struct sock *sk)
>  {
>  	/* When current->bpf_ctx is set, the setsockopt is called from
> @@ -1200,6 +1257,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  			ret = -EOPNOTSUPP;
>  		return ret;
>  		}
> +#ifdef CONFIG_PAGE_POOL
> +	case SO_DEVMEM_DONTNEED:
> +		return sock_devmem_dontneed(sk, optval, optlen);
> +#endif
>  	}
>  
>  	sockopt_lock_sock(sk);


