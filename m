Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35011711B09
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 02:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjEZAOU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 20:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjEZAOU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 20:14:20 -0400
X-Greylist: delayed 461 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 May 2023 17:14:18 PDT
Received: from out-28.mta0.migadu.com (out-28.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C84194
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 17:14:18 -0700 (PDT)
Message-ID: <8f2d47dc-b19c-eb83-c390-885b4f9980a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685059593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BIeHNJ1XVcZV8vmS7jmkvR/TSg5peYc2pW5NNIH/+uI=;
        b=KzKq7EJNna0q87U7tFoSD/MrnkRd9LS9mA90ZrzPsxhl6h7rkCrXnSWi1X+oDmabRnQRkx
        vt3kE4WV+2N8waAhGtUZ504oPn6vcxaaBt2e7g+7GA7aautQjMnsJIKMTD0PcwE4sWQTPe
        X5ga8rAmChHS329qha/QtUxxOkNEcOk=
Date:   Thu, 25 May 2023 17:06:29 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test that SO_REUSEPORT can be
 used with sk_assign helper
Content-Language: en-US
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Joe Stringer <joe@cilium.io>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
References: <20230525081923.8596-1-lmb@isovalent.com>
 <20230525081923.8596-2-lmb@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230525081923.8596-2-lmb@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/25/23 1:19 AM, Lorenz Bauer wrote:
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index a105c0cd008a..8a33bcea97de 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -423,6 +423,9 @@ struct nstoken *open_netns(const char *name)
>   
>   void close_netns(struct nstoken *token)
>   {
> +	if (!token)
> +		return;

+1. :)

> +
>   	ASSERT_OK(setns(token->orig_netns_fd, CLONE_NEWNET), "setns");
>   	close(token->orig_netns_fd);
>   	free(token);
> diff --git a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
> new file mode 100644
> index 000000000000..2cb9bb591e71
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
> @@ -0,0 +1,280 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Isovalent */
> +#include <uapi/linux/if_link.h>
> +#include <test_progs.h>
> +
> +#include <netinet/tcp.h>
> +#include <netinet/udp.h>
> +
> +#include "network_helpers.h"
> +#include "test_assign_reuse.skel.h"
> +
> +#define NS_TEST "assign_reuse"
> +#define LOOPBACK 1
> +#define PORT 4443
> +
> +static int attach_reuseport(int sock_fd, int prog_fd)
> +{
> +	return setsockopt(sock_fd, SOL_SOCKET, SO_ATTACH_REUSEPORT_EBPF,
> +			  &prog_fd, sizeof(prog_fd));
> +}
> +
> +static socklen_t inetaddr_len(const struct sockaddr_storage *addr)
> +{
> +	return addr->ss_family == AF_INET  ? sizeof(struct sockaddr_in) :
> +	       addr->ss_family == AF_INET6 ? sizeof(struct sockaddr_in6) :
> +					     0;
> +}
> +
> +static bool is_ipv6(const char *ip)
> +{
> +	return !!strchr(ip, ':');
> +}
> +
> +static int make_socket(int sotype, const char *ip, int port,
> +		       struct sockaddr_storage *addr)
> +{
> +	struct timeval timeo = { .tv_usec = 500000 /* 500 ms */ };
> +	int family = is_ipv6(ip) ? AF_INET6 : AF_INET;
> +	int ret, fd;
> +
> +	ret = make_sockaddr(family, ip, port, addr, NULL);
> +	if (!ASSERT_OK(ret, "make_sockaddr"))
> +		return -1;
> +	fd = socket(addr->ss_family, sotype, 0);
> +	if (!ASSERT_GE(fd, 0, "socket"))
> +		return -1;
> +	ret = setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeo, sizeof(timeo));
> +	if (!ASSERT_OK(ret, "sndtimeo")) {
> +		close(fd);
> +		return -1;
> +	}
> +	ret = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
> +	if (!ASSERT_OK(ret, "rcvtimeo")) {
> +		close(fd);
> +		return -1;
> +	}
> +	return fd;
> +}
> +
> +static int create_server(int sotype, const char *ip, int port, int prog_fd)
> +{
> +	struct sockaddr_storage addr = {};
> +	const int one = 1;
> +	int ret, fd;
> +
> +	fd = make_socket(sotype, ip, port, &addr);
> +	if (fd < 0)
> +		return -1;
> +	if (sotype == SOCK_STREAM) {
> +		ret = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one,
> +				 sizeof(one));
> +		if (!ASSERT_OK(ret, "reuseaddr"))
> +			goto cleanup;
> +	}
> +	if (prog_fd >= 0) {
> +		ret = setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one,
> +				 sizeof(one));
> +		if (!ASSERT_OK(ret, "reuseport"))
> +			goto cleanup;
> +		ret = attach_reuseport(fd, prog_fd);
> +		if (!ASSERT_OK(ret, "attach_reuseport"))
> +			goto cleanup;
> +	}
> +	ret = bind(fd, (void *)&addr, inetaddr_len(&addr));
> +	if (!ASSERT_OK(ret, "bind"))
> +		goto cleanup;
> +	if (sotype == SOCK_STREAM) {
> +		ret = listen(fd, SOMAXCONN);
> +		if (!ASSERT_OK(ret, "listen"))
> +			goto cleanup;
> +	}
> +	return fd;
> +cleanup:
> +	close(fd);
> +	return -1;
> +}
> +
> +static int create_client(int sotype, const char *ip, int port)
> +{
> +	struct sockaddr_storage addr = {};
> +	int ret, fd;
> +
> +	fd = make_socket(sotype, ip, port, &addr);
> +	if (fd < 0)
> +		return -1;
> +	ret = connect(fd, (void *)&addr, inetaddr_len(&addr));
> +	if (ret)
> +		goto cleanup;
> +	return fd;
> +cleanup:
> +	close(fd);
> +	return -1;
> +}

I believe a lot of the above can be done by start_reuseport_server() and 
connect_to_fd() from network_helpers.c.

[ ... ]

> +void serial_test_assign_reuse(void)

Remove "serial_" .


> +{
> +	struct nstoken *tok = NULL;
> +
> +	SYS(out, "ip netns add %s", NS_TEST);
> +	SYS(cleanup, "ip -net %s link set dev lo up", NS_TEST);
> +
> +	tok = open_netns(NS_TEST);
> +	if (!ASSERT_OK_PTR(tok, "netns token"))
> +		return;
> +
> +	if (test__start_subtest("tcpv4"))
> +		run_assign_reuse(SOCK_STREAM, "127.0.0.1", PORT);
> +	if (test__start_subtest("tcpv6"))
> +		run_assign_reuse(SOCK_STREAM, "::1", PORT);
> +	if (test__start_subtest("udpv4"))
> +		run_assign_reuse(SOCK_DGRAM, "127.0.0.1", PORT);
> +	if (test__start_subtest("udpv6"))
> +		run_assign_reuse(SOCK_DGRAM, "::1", PORT);
> +
> +cleanup:
> +	close_netns(tok);
> +	SYS_NOFAIL("ip netns delete %s", NS_TEST);
> +out:
> +	return;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_assign_reuse.c b/tools/testing/selftests/bpf/progs/test_assign_reuse.c
> new file mode 100644
> index 000000000000..c83e870b2612
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_assign_reuse.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Isovalent */
> +#include <stdbool.h>
> +#include <linux/bpf.h>
> +#include <linux/if_ether.h>
> +#include <linux/in.h>
> +#include <linux/ip.h>
> +#include <linux/ipv6.h>
> +#include <linux/tcp.h>
> +#include <linux/udp.h>
> +#include <bpf/bpf_endian.h>
> +#include <bpf/bpf_helpers.h>
> +#include <linux/pkt_cls.h>
> +
> +char LICENSE[] SEC("license") = "GPL";
> +
> +__u64 sk_cookie_seen;
> +__u64 reuseport_executed;
> +union {
> +	struct tcphdr tcp;
> +	struct udphdr udp;
> +} headers;
> +
> +const volatile __u16 dest_port;
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} sk_map SEC(".maps");
> +
> +SEC("sk_reuseport")
> +int reuse_accept(struct sk_reuseport_md *ctx)
> +{
> +	reuseport_executed++;
> +
> +	if (ctx->ip_protocol == IPPROTO_TCP) {
> +		if (ctx->data + sizeof(headers.tcp) > ctx->data_end)
> +			return SK_DROP;
> +
> +		if (__builtin_memcmp(&headers.tcp, ctx->data, sizeof(headers.tcp)) != 0)
> +			return SK_DROP;
> +	} else if (ctx->ip_protocol == IPPROTO_UDP) {
> +		if (ctx->data + sizeof(headers.udp) > ctx->data_end)
> +			return SK_DROP;
> +
> +		if (__builtin_memcmp(&headers.udp, ctx->data, sizeof(headers.udp)) != 0)
> +			return SK_DROP;
> +	} else {
> +		return SK_DROP;
> +	}
> +
> +	sk_cookie_seen = bpf_get_socket_cookie(ctx->sk);
> +	return SK_PASS;
> +}
> +
> +SEC("sk_reuseport")
> +int reuse_drop(struct sk_reuseport_md *ctx)
> +{
> +	reuseport_executed++;
> +	sk_cookie_seen = 0;
> +	return SK_DROP;
> +}
> +
> +static inline int

nit. inline is no longer a must. Same for a few functions below.

> +assign_sk(struct __sk_buff *skb)
> +{
> +	int zero = 0, ret = 0;
> +	struct bpf_sock *sk;
> +
> +	sk = bpf_map_lookup_elem(&sk_map, &zero);
> +	if (!sk)
> +		return TC_ACT_SHOT;
> +	ret = bpf_sk_assign(skb, sk, 0);
> +	bpf_sk_release(sk);
> +	return ret ? TC_ACT_SHOT : TC_ACT_OK;
> +}
> +

