Return-Path: <linux-kselftest+bounces-8093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96588A6438
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 08:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEBC1C204DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 06:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929EC6D1AE;
	Tue, 16 Apr 2024 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SV6Vg2yu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E26DCE3
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249798; cv=none; b=qrgymwxxCt8H3ihvkB4dVDQuXdqcBKOwNnWxdNH/uk/jktBjlzFWtmgW8KvJPimmUf8dWLyXR8Js0oU8/1Ug3oU+7qmiBjPrLOD/tIVAl9I54+upbyhCYJO3D5awtH/36Zge0iH0trpptl2WY8d6aFddWgX8orzaJxAZlzfJKoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249798; c=relaxed/simple;
	bh=JX7u0eAT9laF5OqFBEbzA3MeKlzTde+IW4g6vNnkCJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYy4QwuirsufvUd2quWN56rbPq6Yl0ce0v8Lu2ZusnaurDUYDKYLAYEIwxG2eRq9lYT6GTvfVbv148NQ87h/ZkWaXUfLBpd6mPUPKfhIYPrLvl3UzCl7wLcusOoYpQHJZNGgahNFZhPDIM/CEoBrNvgnPJxRGzWn1xmFqaKQ2+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SV6Vg2yu; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <65b2f4a3-bd8e-495b-adca-1e7adce5301d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713249794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Geb7VzEqMjYzAO7zNesb0ZwM1g2E3vvuXzZr+6H8y3I=;
	b=SV6Vg2yuYYeZMlrVzxs2jpESLyN5X1wvUYcJTYRpvgGdVxBABdZKQPy3ImzUx+4lADbMV/
	/z05Gr3OwH2bmoyQNa9XKKT5XLVGxABeRcknJUY8H8Xja79XWp9whsJ9aE8y0yI4ZdJDVb
	uiERJ0KQcfQ/rdhmozjWdepGAupaFoY=
Date: Mon, 15 Apr 2024 23:43:06 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/6] selftests/bpf: Implement socket kfuncs
 for bpf_testmod
To: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240412165230.2009746-3-jrife@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/12/24 9:52 AM, Jordan Rife wrote:
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

hmm...this global sock pointer is quite unease. e.g. what if multiple tasks 
trying to use init/close/connect... in parallel.

Storing sock in a bpf map will be better but that may be overkill for testing. 
Can a separate global lock/mutex (not the lock_sock) be acquired first before 
using the sock pointer in the kfuncs?

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

bpf_testmod_exit() should probably do this NULL check and sock_release() also.

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

Is it better to set sk_sndtimeo in bpf_kfunc_init_sock() ?

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

All these new kfunc should have the KF_SLEEPABLE flag.

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

nit. Can "struct sockaddr_storage addr;" be directly used instead of a char array?

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


