Return-Path: <linux-kselftest+bounces-7896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210088A3A19
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 03:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E4E2B2214E
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896D34C80;
	Sat, 13 Apr 2024 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoHyJJTt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C58468E;
	Sat, 13 Apr 2024 01:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712971597; cv=none; b=qbe4IfiJi2n335s5AJG2TrZmWELzqwgOpaeLTe/5ZbQsi/U+ryzBm/hmJy/xc1nhFXcPYDhoqoZ50xfYrk5Jg9EJxxsEx8mj8gzc3CQKDvKdtfrZUM0dtFY6BqNzumrw/n8DOpaJ6245vXzr7Q7fN43IDDqvNcKozmX416Kvth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712971597; c=relaxed/simple;
	bh=Vm9DqjCjmTX6BXArJWwBkrWkiA7TbixehLaIIiclEsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XucRZK0CcC5/3RIvlPhgWkiaunrjfTW0MUyXJFcgGY9EVz5/YxaWzBo0GDzLe4pNjUKfejyfty4hNcXSj52nokR8SkCz1FFw6AxNNZmTl5IuAZNtGeFkkX1MH3JNkhngNn7kYOZQwmmZZD9b/ztk2Z9isNCenxTZaS5VTP9OQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoHyJJTt; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a49261093cso774076eaf.3;
        Fri, 12 Apr 2024 18:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712971595; x=1713576395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JeXs1AA0JJFHBf8znYI013aMTNwp/ncBp3e1OQ2DT0=;
        b=BoHyJJTtP8cirRQmYF5bI3Hg1vIfhKOpkGnB6Z0xNvfA9msRutaTbkB+8qwCMd3qQy
         zDfz9R1bq2zbw+cbJkDEFzfXBf2AgNGu016liP5AH0JW4ppnwyo1+E2d4JqKndcml6pq
         VXsGqkOcuQaLJbu215JtTfsw2EHjy3cHVjB2EjKrL3WULhaLrhMBr+M+532Ae3a7yjYq
         SbagA5nGHy21ugUOh4ZQIDRvUjBhe/BjHswHJDKPnqqGf6mnlO5Dp/2waopYuX1zUZ9R
         dOt37ifn4B+/ObNsokUlmY/YA4UM3jHOnEE9hYil4tJS7aAKd/TQNECvM4BBiMwv0wXk
         3Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712971595; x=1713576395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JeXs1AA0JJFHBf8znYI013aMTNwp/ncBp3e1OQ2DT0=;
        b=jYncKn4qN29IOYEp8z+lj+DcfKJv/6MX3KUJFQ9T+Hwkba1CIFHmdqzIynllMPCpN/
         /OZDSgiofaZnjgQYpE7au44b4PKalXlD0MWSkWDk2D4wgKH5FF/5/6sYfTyWPRehFGIG
         usY2kHkp7khSA7aNN/sRTJboktdpOpdiawz5CBborkk9gv377PhxBVW4a2aFJGOAnOsa
         3stKAYbCI/ATpSaQdCz0jkJ4X/6ktQtOLiTho3udUruijTqtsUWif86BLCYdfmjUktQt
         xwqLWgn0HWbIZ13/hyAV/wCmKZ9V5TzyntCpdDGyyuWCstyMsaqzAwrY4TzMywq/7G2T
         AIXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7eIH9pI2ygVpkYf2lCEc4yL/kjo4UBG8Kq7m0n9muAEX/twFJDCo88p8kFatrm8t50ZzpXE+KlPl3eDDI0wnnn+ljEnR5sB7brZdgLzFmz/YdxubUQGdoiq75
X-Gm-Message-State: AOJu0YwBXhf6QcYIawBLJH4FPYvkAtuffDVB4J8I4O/uDNc8uxtZyelh
	a1Uh9zjJ/GDWdd9JBn99h7MQ9QdnQU8F2p5WIFJxFX9dMKANcAFo
X-Google-Smtp-Source: AGHT+IHbgERyXUjCTNpNGn458G7MEcHoR52bQhLuU1xXm38vbdBRZxEYx9yIpn9ViMgTs+7MdgJnCg==
X-Received: by 2002:a05:6808:6383:b0:3c5:f0c1:f35a with SMTP id ec3-20020a056808638300b003c5f0c1f35amr5168770oib.27.1712971594772;
        Fri, 12 Apr 2024 18:26:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a1a1:7d97:cada:fa46? ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id n26-20020a0568080a1a00b003c6f8cdce92sm301717oij.13.2024.04.12.18.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 18:26:34 -0700 (PDT)
Message-ID: <2f5b9a1f-ddbd-43c0-93e1-aca09552ef6b@gmail.com>
Date: Fri, 12 Apr 2024 18:26:32 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 2/6] selftests/bpf: Implement socket kfuncs
 for bpf_testmod
To: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>,
 Artem Savkov <asavkov@redhat.com>, Dave Marchevsky <davemarchevsky@fb.com>,
 Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>,
 David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20240412165230.2009746-1-jrife@google.com>
 <20240412165230.2009746-3-jrife@google.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240412165230.2009746-3-jrife@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/12/24 09:52, Jordan Rife wrote:
> This patch adds a set of kfuncs to bpf_testmod that can be used to
> manipulate a socket from kernel space.
> 
> Signed-off-by: Jordan Rife <jrife@google.com>
> ---
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 139 ++++++++++++++++++
>   .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  27 ++++
>   2 files changed, 166 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 39ad96a18123f..663df8148097e 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -10,18 +10,29 @@
>   #include <linux/percpu-defs.h>
>   #include <linux/sysfs.h>
>   #include <linux/tracepoint.h>
> +#include <linux/net.h>
> +#include <linux/socket.h>
> +#include <linux/nsproxy.h>
> +#include <linux/inet.h>
> +#include <linux/in.h>
> +#include <linux/in6.h>
> +#include <linux/un.h>
> +#include <net/sock.h>
>   #include "bpf_testmod.h"
>   #include "bpf_testmod_kfunc.h"
>   
>   #define CREATE_TRACE_POINTS
>   #include "bpf_testmod-events.h"
>   
> +#define CONNECT_TIMEOUT_SEC 1
> +
>   typedef int (*func_proto_typedef)(long);
>   typedef int (*func_proto_typedef_nested1)(func_proto_typedef);
>   typedef int (*func_proto_typedef_nested2)(func_proto_typedef_nested1);
>   
>   DEFINE_PER_CPU(int, bpf_testmod_ksym_percpu) = 123;
>   long bpf_testmod_test_struct_arg_result;
> +static struct socket *sock;
>   
>   struct bpf_testmod_struct_arg_1 {
>   	int a;
> @@ -494,6 +505,124 @@ __bpf_kfunc static u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused
>   	return arg;
>   }
>   
> +__bpf_kfunc int bpf_kfunc_init_sock(struct init_sock_args *args)
> +{
> +	int proto;
> +
> +	if (sock)
> +		pr_warn("%s called without releasing old sock", __func__);
> +
> +	switch (args->af) {
> +	case AF_INET:
> +	case AF_INET6:
> +		proto = args->type == SOCK_STREAM ? IPPROTO_TCP : IPPROTO_UDP;
> +		break;
> +	case AF_UNIX:
> +		proto = PF_UNIX;
> +		break;
> +	default:
> +		pr_err("invalid address family %d\n", args->af);
> +		return -EINVAL;
> +	}
> +
> +	return sock_create_kern(&init_net, args->af, args->type, proto, &sock);
> +}
> +
> +__bpf_kfunc void bpf_kfunc_close_sock(void)
> +{
> +	if (sock) {
> +		sock_release(sock);
> +		sock = NULL;
> +	}
> +}
> +
> +__bpf_kfunc int bpf_kfunc_call_kernel_connect(struct addr_args *args)
> +{
> +	/* Set timeout for call to kernel_connect() to prevent it from hanging,
> +	 * and consider the connection attempt failed if it returns
> +	 * -EINPROGRESS.
> +	 */
> +	sock->sk->sk_sndtimeo = CONNECT_TIMEOUT_SEC * HZ;
> +
> +	return kernel_connect(sock, (struct sockaddr *)&args->addr,
> +			      args->addrlen, 0);
> +}
> +
> +__bpf_kfunc int bpf_kfunc_call_kernel_bind(struct addr_args *args)
> +{
> +	return kernel_bind(sock, (struct sockaddr *)&args->addr, args->addrlen);
> +}
> +
> +__bpf_kfunc int bpf_kfunc_call_kernel_listen(void)
> +{
> +	return kernel_listen(sock, 128);
> +}
> +
> +__bpf_kfunc int bpf_kfunc_call_kernel_sendmsg(struct sendmsg_args *args)
> +{
> +	struct msghdr msg = {
> +		.msg_name	= &args->addr.addr,
> +		.msg_namelen	= args->addr.addrlen,
> +	};
> +	struct kvec iov;
> +	int err;
> +
> +	iov.iov_base = args->msg;
> +	iov.iov_len  = args->msglen;

It would be better to check if args->msglen > sizeof(arg->msg) although
this function is just for test cases. Same for args->addr.addrlen.

> +
> +	err = kernel_sendmsg(sock, &msg, &iov, 1, args->msglen);
> +	args->addr.addrlen = msg.msg_namelen;
> +
> +	return err;
> +}
> +
> +__bpf_kfunc int bpf_kfunc_call_sock_sendmsg(struct sendmsg_args *args)
> +{
> +	struct msghdr msg = {
> +		.msg_name	= &args->addr.addr,
> +		.msg_namelen	= args->addr.addrlen,
> +	};
> +	struct kvec iov;
> +	int err;
> +
> +	iov.iov_base = args->msg;
> +	iov.iov_len  = args->msglen;
> +
> +	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, args->msglen);
> +	err = sock_sendmsg(sock, &msg);
> +	args->addr.addrlen = msg.msg_namelen;
> +
> +	return err;
> +}
> +
> +__bpf_kfunc int bpf_kfunc_call_kernel_getsockname(struct addr_args *args)
> +{
> +	int err;
> +
> +	err = kernel_getsockname(sock, (struct sockaddr *)&args->addr);
> +	if (err < 0)
> +		goto out;
> +
> +	args->addrlen = err;
> +	err = 0;
> +out:
> +	return err;
> +}
> +
> +__bpf_kfunc int bpf_kfunc_call_kernel_getpeername(struct addr_args *args)
> +{
> +	int err;
> +
> +	err = kernel_getpeername(sock, (struct sockaddr *)&args->addr);
> +	if (err < 0)
> +		goto out;
> +
> +	args->addrlen = err;
> +	err = 0;
> +out:
> +	return err;
> +}
> +
>   BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
>   BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
> @@ -520,6 +649,15 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS | KF_RCU)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
> +BTF_ID_FLAGS(func, bpf_kfunc_init_sock)
> +BTF_ID_FLAGS(func, bpf_kfunc_close_sock)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_connect)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_bind)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_listen)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_sendmsg)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_sock_sendmsg)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getsockname)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getpeername)
>   BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
>   
>   static int bpf_testmod_ops_init(struct btf *btf)
> @@ -650,6 +788,7 @@ static int bpf_testmod_init(void)
>   		return ret;
>   	if (bpf_fentry_test1(0) < 0)
>   		return -EINVAL;
> +	sock = NULL;
>   	return sysfs_create_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
>   }
>   
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> index 7c664dd610597..cdf7769a7d8ca 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> @@ -64,6 +64,22 @@ struct prog_test_fail3 {
>   	char arr2[];
>   };
>   
> +struct init_sock_args {
> +	int af;
> +	int type;
> +};
> +
> +struct addr_args {
> +	char addr[sizeof(struct __kernel_sockaddr_storage)];
> +	int addrlen;
> +};
> +
> +struct sendmsg_args {
> +	struct addr_args addr;
> +	char msg[10];
> +	int msglen;
> +};
> +
>   struct prog_test_ref_kfunc *
>   bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
>   void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
> @@ -106,4 +122,15 @@ void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p);
>   void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len);
>   
>   void bpf_kfunc_common_test(void) __ksym;
> +
> +int bpf_kfunc_init_sock(struct init_sock_args *args) __ksym;
> +void bpf_kfunc_close_sock(void) __ksym;
> +int bpf_kfunc_call_kernel_connect(struct addr_args *args) __ksym;
> +int bpf_kfunc_call_kernel_bind(struct addr_args *args) __ksym;
> +int bpf_kfunc_call_kernel_listen(void) __ksym;
> +int bpf_kfunc_call_kernel_sendmsg(struct sendmsg_args *args) __ksym;
> +int bpf_kfunc_call_sock_sendmsg(struct sendmsg_args *args) __ksym;
> +int bpf_kfunc_call_kernel_getsockname(struct addr_args *args) __ksym;
> +int bpf_kfunc_call_kernel_getpeername(struct addr_args *args) __ksym;
> +
>   #endif /* _BPF_TESTMOD_KFUNC_H */

