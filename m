Return-Path: <linux-kselftest+bounces-20185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFD79A4AA1
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 02:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604E7B21B38
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 00:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC561922D5;
	Sat, 19 Oct 2024 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uexD/jq8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173EB2CA7
	for <linux-kselftest@vger.kernel.org>; Sat, 19 Oct 2024 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729297848; cv=none; b=GlL7e0ermSuRqRSNO8aYyJA5SAYrwdYAX2F2JcRYHriCnooPLbqWhH5+NwuWWmDXPqH/X0LDem2FyFH8P+QysOeo+nkOLg+KOKEKCYThZYv6FXqawQmLudhI+G1YSQg5Q2ffJcP0UI/9z/4KE+ImtV1Wpx6hGKlzEBaJ6nRuNTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729297848; c=relaxed/simple;
	bh=8bjhY3fyWEYub3ts6cL8vQGQfnWUD8MKG1y4Bd6UjAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izrnC2UhuNbpnJtRUO7NiJwiqZO56w0QeIGhk+Ma3tHOd87lqoQdAqKCO/ww3taLulY8y4uhmSZ13cOl/p9bt4l0VxQ+Ml25rvVzkvsm3sY7uvIqzoKuXCXbpXhd5VesGtUo/Uc2PUtZqAvYT+5WEFbisvy9jjidoNz/DZ8cJ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uexD/jq8; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <43f0d39a-b353-4f38-85f7-e0a557f911f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729297843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQqknBHkBHp7SLl5cKxu6mLg1IO4q1QAVqIR3aA/3WI=;
	b=uexD/jq8WOw6h3h6ZEMdvCszPdwecJwYw8BOLNdGpMWovSXOzcz9Qz4ZVW1oBLtz04emvB
	XnEeEJznRSDu1zjFfODKRu0k9RvXZLVsFE8qc+8Rmar4423GTZudsur6weuEBVBn/8fOMv
	2FV0/LxAHIzDhS5du+VnOrrMcT2EUlI=
Date: Fri, 18 Oct 2024 17:30:29 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/6] selftests/bpf: add ipv4 and dual ipv4/ipv6
 support in btf_skc_cls_ingress
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lorenz Bauer <lmb@cloudflare.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241016-syncookie-v1-0-3b7a0de12153@bootlin.com>
 <20241016-syncookie-v1-4-3b7a0de12153@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241016-syncookie-v1-4-3b7a0de12153@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/16/24 11:35 AM, Alexis Lothoré (eBPF Foundation) wrote:
> btf_skc_cls_ingress test currently checks that syncookie and
> bpf_sk_assign/release helpers behave correctly in multiple scenarios,
> but only with ipv4 socket.
> 
> Increase those helpers coverage by adding testing support for IPv6-only
> sockets and IPv4/IPv6 sockets. The rework is mostly based on features
> brought earlier in test_tcp_check_syncookie.sh to cover some fixes
> performed on those helpers, but test_tcp_check_syncookie.sh is not
> integrated in test_progs. The most notable changes linked to this are:
> - some rework in the corresponding eBPF program to support both types of
>    traffic
> - the switch from start_server to start_server_str to allow to check
>    some socket options
> - the introduction of new subtests for ipv4 and ipv4/ipv6
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> The rework has been tested in a local Qemu environment and in CI:
>    # ./test_progs -a btf_skc_cls_ingress
>    #38/1    btf_skc_cls_ingress/conn_ipv4:OK
>    #38/2    btf_skc_cls_ingress/conn_ipv6:OK
>    #38/3    btf_skc_cls_ingress/conn_dual:OK
>    #38/4    btf_skc_cls_ingress/syncookie_ipv4:OK
>    #38/5    btf_skc_cls_ingress/syncookie_ipv6:OK
>    #38/6    btf_skc_cls_ingress/syncookie_dual:OK
>    #38      btf_skc_cls_ingress:OK
>    Summary: 1/6 PASSED, 0 SKIPPED, 0 FAILED
> ---
>   .../selftests/bpf/prog_tests/btf_skc_cls_ingress.c | 116 ++++++++++++++++++---
>   .../selftests/bpf/progs/test_btf_skc_cls_ingress.c |  81 +++++++++-----
>   2 files changed, 161 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
> index a20d104f9909e5ba20ddc4c107b910956f042fc1..e0f8fe818f4230a1d5bf0118133c5a9fb50345e1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
> @@ -19,6 +19,15 @@
>   
>   #define TEST_NS "skc_cls_ingress"
>   
> +#define BIT(n)		(1 << (n))
> +#define TEST_MODE_IPV4	BIT(0)
> +#define TEST_MODE_IPV6	BIT(1)
> +#define TEST_MODE_DUAL	(TEST_MODE_IPV4 | TEST_MODE_IPV6)
> +
> +#define SERVER_ADDR_IPV4	"127.0.0.1"
> +#define SERVER_ADDR_IPV6	"::1"
> +#define SERVER_ADDR_DUAL	"::0"
> +
>   static struct netns_obj *prepare_netns(struct test_btf_skc_cls_ingress *skel)
>   {
>   	LIBBPF_OPTS(bpf_tc_hook, qdisc_lo, .attach_point = BPF_TC_INGRESS);
> @@ -57,6 +66,7 @@ static struct netns_obj *prepare_netns(struct test_btf_skc_cls_ingress *skel)
>   
>   static void reset_test(struct test_btf_skc_cls_ingress *skel)
>   {
> +	memset(&skel->bss->srv_sa4, 0, sizeof(skel->bss->srv_sa4));
>   	memset(&skel->bss->srv_sa6, 0, sizeof(skel->bss->srv_sa6));
>   	skel->bss->listen_tp_sport = 0;
>   	skel->bss->req_sk_sport = 0;
> @@ -71,26 +81,84 @@ static void print_err_line(struct test_btf_skc_cls_ingress *skel)
>   		printf("bpf prog error at line %u\n", skel->bss->linum);
>   }
>   
> -static void run_test(struct test_btf_skc_cls_ingress *skel, bool gen_cookies)
> +static int v6only_true(int fd, void *opts)
> +{
> +	int mode = true;
> +
> +	return setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &mode, sizeof(mode));
> +}
> +
> +static int v6only_false(int fd, void *opts)
> +{
> +	int mode = false;
> +
> +	return setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &mode, sizeof(mode));
> +}
> +
> +static void run_test(struct test_btf_skc_cls_ingress *skel, bool gen_cookies,
> +		     int ip_mode)
>   {
>   	const char *tcp_syncookies = gen_cookies ? "2" : "1";
>   	int listen_fd = -1, cli_fd = -1, srv_fd = -1, err;
> +	struct network_helper_opts opts = { 0 };
> +	struct sockaddr_storage *addr;
>   	struct sockaddr_in6 srv_sa6;
> -	socklen_t addrlen = sizeof(srv_sa6);
> +	struct sockaddr_in srv_sa4;
> +	socklen_t addr_len;
> +	int sock_family;
> +	char *srv_addr;
>   	int srv_port;
>   
> +	switch (ip_mode) {
> +	case TEST_MODE_IPV4:
> +		sock_family = AF_INET;
> +		srv_addr = SERVER_ADDR_IPV4;
> +		addr = (struct sockaddr_storage *)&srv_sa4;
> +		addr_len = sizeof(srv_sa4);
> +		break;
> +	case TEST_MODE_IPV6:
> +		opts.post_socket_cb = v6only_true;
> +		sock_family = AF_INET6;
> +		srv_addr = SERVER_ADDR_IPV6;
> +		addr = (struct sockaddr_storage *)&srv_sa6;
> +		addr_len = sizeof(srv_sa6);
> +		break;
> +	case TEST_MODE_DUAL:
> +		opts.post_socket_cb = v6only_false;
> +		sock_family = AF_INET6;
> +		srv_addr = SERVER_ADDR_DUAL;
> +		addr = (struct sockaddr_storage *)&srv_sa6;
> +		addr_len = sizeof(srv_sa6);
> +		break;
> +	default:
> +			break;

nit. indentation is off.

better directly "return;", in case future something complains vars are not init.

> +	}
> +
>   	if (write_sysctl("/proc/sys/net/ipv4/tcp_syncookies", tcp_syncookies))
>   		return;
>   
> -	listen_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
> +	listen_fd = start_server_str(sock_family, SOCK_STREAM, srv_addr,  0,
> +				     &opts);
>   	if (!ASSERT_OK_FD(listen_fd, "start server"))
>   		return;
>   
> -	err = getsockname(listen_fd, (struct sockaddr *)&srv_sa6, &addrlen);
> +	err = getsockname(listen_fd, (struct sockaddr *)addr, &addr_len);
>   	if (!ASSERT_OK(err, "getsockname(listen_fd)"))
>   		goto done;
> -	memcpy(&skel->bss->srv_sa6, &srv_sa6, sizeof(srv_sa6));
> -	srv_port = ntohs(srv_sa6.sin6_port);
> +
> +	switch (ip_mode) {
> +	case TEST_MODE_IPV4:
> +		memcpy(&skel->bss->srv_sa4, &srv_sa4, sizeof(srv_sa4));
> +		srv_port = ntohs(srv_sa4.sin_port);
> +		break;
> +	case TEST_MODE_IPV6:
> +	case TEST_MODE_DUAL:
> +		memcpy(&skel->bss->srv_sa6, &srv_sa6, sizeof(srv_sa6));
> +		srv_port = ntohs(srv_sa6.sin6_port);
> +		break;
> +	default:
> +			break;

indentation off. also "goto done;"

> +	}
>   
>   	cli_fd = connect_to_fd(listen_fd, 0);
>   	if (!ASSERT_OK_FD(cli_fd, "connect client"))
> @@ -127,14 +195,34 @@ static void run_test(struct test_btf_skc_cls_ingress *skel, bool gen_cookies)
>   		close(srv_fd);
>   }
>   
> -static void test_conn(struct test_btf_skc_cls_ingress *skel)
> +static void test_conn_ipv4(struct test_btf_skc_cls_ingress *skel)
> +{
> +	run_test(skel, false, TEST_MODE_IPV4);
> +}
> +
> +static void test_conn_ipv6(struct test_btf_skc_cls_ingress *skel)
> +{
> +	run_test(skel, false, TEST_MODE_IPV6);
> +}
> +
> +static void test_conn_dual(struct test_btf_skc_cls_ingress *skel)
> +{
> +	run_test(skel, false, TEST_MODE_DUAL);
> +}
> +
> +static void test_syncookie_ipv4(struct test_btf_skc_cls_ingress *skel)
> +{
> +	run_test(skel, true, TEST_MODE_IPV4);
> +}
> +
> +static void test_syncookie_ipv6(struct test_btf_skc_cls_ingress *skel)
>   {
> -	run_test(skel, false);
> +	run_test(skel, true, TEST_MODE_IPV6);
>   }
>   
> -static void test_syncookie(struct test_btf_skc_cls_ingress *skel)
> +static void test_syncookie_dual(struct test_btf_skc_cls_ingress *skel)
>   {
> -	run_test(skel, true);
> +	run_test(skel, true, TEST_MODE_DUAL);
>   }
>   
>   struct test {
> @@ -144,8 +232,12 @@ struct test {
>   
>   #define DEF_TEST(name) { #name, test_##name }
>   static struct test tests[] = {
> -	DEF_TEST(conn),
> -	DEF_TEST(syncookie),
> +	DEF_TEST(conn_ipv4),
> +	DEF_TEST(conn_ipv6),
> +	DEF_TEST(conn_dual),
> +	DEF_TEST(syncookie_ipv4),
> +	DEF_TEST(syncookie_ipv6),
> +	DEF_TEST(syncookie_dual),
>   };
>   
>   void test_btf_skc_cls_ingress(void)
> diff --git a/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
> index f0759efff6ef15d2663927400dd064c53b020f78..cd528f8792ff2eb14683cbc13e8b0f3fd38329e9 100644
> --- a/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
> +++ b/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
> @@ -10,6 +10,7 @@
>   #endif
>   
>   struct sockaddr_in6 srv_sa6 = {};
> +struct sockaddr_in srv_sa4 = {};
>   __u16 listen_tp_sport = 0;
>   __u16 req_sk_sport = 0;
>   __u32 recv_cookie = 0;
> @@ -18,8 +19,8 @@ __u32 linum = 0;
>   
>   #define LOG() ({ if (!linum) linum = __LINE__; })
>   
> -static void test_syncookie_helper(struct ipv6hdr *ip6h, struct tcphdr *th,
> -				  struct tcp_sock *tp,
> +static void test_syncookie_helper(void *iphdr, int iphdr_size,
> +				  struct tcphdr *th, struct tcp_sock *tp,
>   				  struct __sk_buff *skb)
>   {
>   	if (th->syn) {
> @@ -38,7 +39,7 @@ static void test_syncookie_helper(struct ipv6hdr *ip6h, struct tcphdr *th,
>   			return;
>   		}
>   
> -		mss_cookie = bpf_tcp_gen_syncookie(tp, ip6h, sizeof(*ip6h),
> +		mss_cookie = bpf_tcp_gen_syncookie(tp, iphdr, iphdr_size,
>   						   th, 40);
>   		if (mss_cookie < 0) {
>   			if (mss_cookie != -ENOENT)
> @@ -48,7 +49,7 @@ static void test_syncookie_helper(struct ipv6hdr *ip6h, struct tcphdr *th,
>   		}
>   	} else if (gen_cookie) {
>   		/* It was in cookie mode */
> -		int ret = bpf_tcp_check_syncookie(tp, ip6h, sizeof(*ip6h),
> +		int ret = bpf_tcp_check_syncookie(tp, iphdr, iphdr_size,
>   						  th, sizeof(*th));
>   
>   		if (ret < 0) {
> @@ -60,26 +61,63 @@ static void test_syncookie_helper(struct ipv6hdr *ip6h, struct tcphdr *th,
>   	}
>   }
>   
> -static int handle_ip6_tcp(struct ipv6hdr *ip6h, struct __sk_buff *skb)
> +static int handle_ip_tcp(struct ethhdr *eth, struct __sk_buff *skb)
>   {
> -	struct bpf_sock_tuple *tuple;
> +	struct bpf_sock_tuple *tuple = NULL;
> +	unsigned int tuple_len = 0;
>   	struct bpf_sock *bpf_skc;
> -	unsigned int tuple_len;
> +	struct ipv6hdr *ip6h;
> +	void *iphdr = NULL;
> +	int iphdr_size = 0;
> +	struct iphdr *ip4h;

nit. All new "= 0;" and "= NULL;" init should not be needed.

>   	struct tcphdr *th;
>   	void *data_end;
>   
>   	data_end = (void *)(long)(skb->data_end);
>   
> -	th = (struct tcphdr *)(ip6h + 1);
> -	if (th + 1 > data_end)
> -		return TC_ACT_OK;
> +	switch (eth->h_proto) {
> +	case bpf_htons(ETH_P_IP):
> +		ip4h = (struct iphdr *)(eth + 1);
> +		if (ip4h + 1 > data_end)
> +			return TC_ACT_OK;
> +		if (ip4h->protocol != IPPROTO_TCP)
> +			return TC_ACT_OK;
> +		th = (struct tcphdr *)(ip4h + 1);
> +		if (th + 1 > data_end)
> +			return TC_ACT_OK;
> +		/* Is it the testing traffic? */
> +		if (th->dest != srv_sa4.sin_port)
> +			return TC_ACT_OK;
> +		tuple_len = sizeof(tuple->ipv4);
> +		tuple = (struct bpf_sock_tuple *)&ip4h->saddr;
> +		iphdr = ip4h;
> +		iphdr_size = sizeof(*ip4h);
> +		break;
> +	case bpf_htons(ETH_P_IPV6):
> +		ip6h = (struct ipv6hdr *)(eth + 1);
> +		if (ip6h + 1 > data_end)
> +			return TC_ACT_OK;
> +		if (ip6h->nexthdr != IPPROTO_TCP)
> +			return TC_ACT_OK;
> +		th = (struct tcphdr *)(ip6h + 1);
> +		if (th + 1 > data_end)
> +			return TC_ACT_OK;
> +		/* Is it the testing traffic? */
> +		if (th->dest != srv_sa6.sin6_port)
> +			return TC_ACT_OK;
> +		tuple_len = sizeof(tuple->ipv6);
> +		tuple = (struct bpf_sock_tuple *)&ip6h->saddr;
> +		iphdr = ip6h;
> +		iphdr_size = sizeof(*ip6h);
> +		break;
> +	default:
> +			return TC_ACT_OK;

indentation is off also.

> +	}
>   
> -	/* Is it the testing traffic? */
> -	if (th->dest != srv_sa6.sin6_port)
> +	if (!tuple) {

!tuple should not be possible. can be removed.

> +		LOG();
>   		return TC_ACT_OK;
> -
> -	tuple_len = sizeof(tuple->ipv6);
> -	tuple = (struct bpf_sock_tuple *)&ip6h->saddr;
> +	}
>   	if ((void *)tuple + tuple_len > data_end) {
>   		LOG();
>   		return TC_ACT_OK;
> @@ -126,7 +164,7 @@ static int handle_ip6_tcp(struct ipv6hdr *ip6h, struct __sk_buff *skb)
>   
>   		listen_tp_sport = tp->inet_conn.icsk_inet.sk.__sk_common.skc_num;
>   
> -		test_syncookie_helper(ip6h, th, tp, skb);
> +		test_syncookie_helper(iphdr, iphdr_size, th, tp, skb);
>   		bpf_sk_release(tp);
>   		return TC_ACT_OK;
>   	}
> @@ -142,7 +180,6 @@ static int handle_ip6_tcp(struct ipv6hdr *ip6h, struct __sk_buff *skb)
>   SEC("tc")
>   int cls_ingress(struct __sk_buff *skb)
>   {
> -	struct ipv6hdr *ip6h;
>   	struct ethhdr *eth;
>   	void *data_end;
>   
> @@ -152,15 +189,11 @@ int cls_ingress(struct __sk_buff *skb)
>   	if (eth + 1 > data_end)
>   		return TC_ACT_OK;
>   
> -	if (eth->h_proto != bpf_htons(ETH_P_IPV6))
> -		return TC_ACT_OK;
> -
> -	ip6h = (struct ipv6hdr *)(eth + 1);
> -	if (ip6h + 1 > data_end)
> +	if (eth->h_proto != bpf_htons(ETH_P_IP) &&
> +	    eth->h_proto != bpf_htons(ETH_P_IPV6))
>   		return TC_ACT_OK;
>   
> -	if (ip6h->nexthdr == IPPROTO_TCP)
> -		return handle_ip6_tcp(ip6h, skb);
> +	return handle_ip_tcp(eth, skb);
>   
>   	return TC_ACT_OK;

The last double return should have been removed also.

>   }
> 


