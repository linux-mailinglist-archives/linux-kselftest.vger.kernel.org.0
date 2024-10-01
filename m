Return-Path: <linux-kselftest+bounces-18713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A498B218
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 04:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6D61C21A54
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 02:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1A72209B;
	Tue,  1 Oct 2024 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UAnerSJ9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D573679CF;
	Tue,  1 Oct 2024 02:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750043; cv=none; b=F/fmKz4XKqPYBxPCpfoAnnHNK/AGesdlDO+XvAIhdHqimi2PAn/3DFyqhdGzrJ8Q9k04pB9a9dNh8UQTw1iiTSSuc30tRT0sZEkXpORHsSo0LAcao5dv+X7yN2SakUONqTTqiCrtnjtz6lbGUvT9pCynAUUik4MM5zIeIyBXiyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750043; c=relaxed/simple;
	bh=3Lax1a51FpGxs8aUU8rWQPnGiqIQ+xprsIA3ixmbbTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UD1fmISLejWBkH0hG6MPcW0tJWuS+v3Qomsarig/nMjXMOAGObHJ5v4poMOUFi5BLBYxPTW3r5buZYo7C2K8Y2ch1tfah+o874ziNbv22Ik3I/tRWOOm56ZUSRNFhjjgTVj3KFu0Ziz5WUcZIsITSAnJXDRo4sPAFkFgixiUJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UAnerSJ9; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6f0cb09c-3a3b-4307-8b7e-6a7c6e45b97e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727750039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FDUIwg+b2BEQXcQCTShkc7XaViRzXKe7OyrM24xOog=;
	b=UAnerSJ9FAQbFKKHVlm3Zry60b6tYjKahxmvoHAN8VT9EfexI5+/HyDFoCGhhqKDgQV1k+
	U+7IomHnBe1GXwNtN/p1JrE1BMe+hFjF07SCpNZ81ArC7Zy54SUMdyKHIrRkBtW5UHCZc2
	OWtXZuMbu37K/ZPKB3Ahwyz97xE4Rx4=
Date: Mon, 30 Sep 2024 19:33:43 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Setget_sockopt add a test
 for tcp over ipv4 via ipv6
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org, alan.maguire@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
References: <20240914103226.71109-1-zhoufeng.zf@bytedance.com>
 <20240914103226.71109-3-zhoufeng.zf@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240914103226.71109-3-zhoufeng.zf@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/14/24 3:32 AM, Feng zhou wrote:
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
> 
> This patch adds a test for TCP over IPv4 via INET6 API.
> 
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> ---
>   .../selftests/bpf/prog_tests/setget_sockopt.c | 33 +++++++++++++++++++
>   .../selftests/bpf/progs/setget_sockopt.c      | 13 ++++++--
>   2 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
> index 7d4a9b3d3722..3cad92128e60 100644
> --- a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
> @@ -15,8 +15,11 @@
>   
>   #define CG_NAME "/setget-sockopt-test"
>   
> +#define INT_PORT	8008
> +
>   static const char addr4_str[] = "127.0.0.1";
>   static const char addr6_str[] = "::1";
> +static const char addr6_any_str[] = "::";
>   static struct setget_sockopt *skel;
>   static int cg_fd;
>   
> @@ -67,6 +70,35 @@ static void test_tcp(int family)
>   	ASSERT_EQ(bss->nr_binddev, 2, "nr_bind");
>   }
>   
> +static void test_tcp_over_ipv4_via_ipv6(void)
> +{
> +	struct setget_sockopt__bss *bss = skel->bss;
> +	int sfd, cfd;
> +
> +	memset(bss, 0, sizeof(*bss));
> +	skel->bss->test_tcp_over_ipv4_via_ipv6 = 1;
> +
> +	sfd = start_server(AF_INET6, SOCK_STREAM,
> +			   addr6_any_str, INT_PORT, 0);
> +	if (!ASSERT_GE(sfd, 0, "start_server"))
> +		return;
> +
> +	cfd = connect_to_addr_str(AF_INET, SOCK_STREAM, addr4_str, INT_PORT, NULL);
> +	if (!ASSERT_GE(cfd, 0, "connect_to_addr_str")) {
> +		close(sfd);
> +		return;
> +	}
> +	close(sfd);
> +	close(cfd);
> +
> +	ASSERT_EQ(bss->nr_listen, 1, "nr_listen");
> +	ASSERT_EQ(bss->nr_connect, 1, "nr_connect");
> +	ASSERT_EQ(bss->nr_active, 1, "nr_active");
> +	ASSERT_EQ(bss->nr_passive, 1, "nr_passive");
> +	ASSERT_EQ(bss->nr_socket_post_create, 2, "nr_socket_post_create");
> +	ASSERT_EQ(bss->nr_binddev, 2, "nr_bind");
> +}
> +
>   static void test_udp(int family)
>   {
>   	struct setget_sockopt__bss *bss = skel->bss;
> @@ -191,6 +223,7 @@ void test_setget_sockopt(void)
>   	test_udp(AF_INET);
>   	test_ktls(AF_INET6);
>   	test_ktls(AF_INET);
> +	test_tcp_over_ipv4_via_ipv6();

This has a conflict with commit d53050934e66.

pw-bot: cr

>   
>   done:
>   	setget_sockopt__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
> index 60518aed1ffc..ff834d94dd23 100644
> --- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
> +++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
> @@ -20,6 +20,7 @@ int nr_connect;
>   int nr_binddev;
>   int nr_socket_post_create;
>   int nr_fin_wait1;
> +int test_tcp_over_ipv4_via_ipv6;
>   
>   struct sockopt_test {
>   	int opt;
> @@ -262,9 +263,15 @@ static int bpf_test_sockopt(void *ctx, struct sock *sk)
>   		if (n != ARRAY_SIZE(sol_ip_tests))
>   			return -1;
>   	} else {
> -		n = bpf_loop(ARRAY_SIZE(sol_ipv6_tests), bpf_test_ipv6_sockopt, &lc, 0);
> -		if (n != ARRAY_SIZE(sol_ipv6_tests))
> -			return -1;
> +		if (test_tcp_over_ipv4_via_ipv6) {
> +			n = bpf_loop(ARRAY_SIZE(sol_ip_tests), bpf_test_ip_sockopt, &lc, 0);

Can this bpf_loop(..., bpf_test_ip_sockopt, ...) be always run? Then the above 
test_tcp_over_ipv4_via_ipv6() addition will not be needed.


> +			if (n != ARRAY_SIZE(sol_ip_tests))
> +				return -1;
> +		} else {
> +			n = bpf_loop(ARRAY_SIZE(sol_ipv6_tests), bpf_test_ipv6_sockopt, &lc, 0);
> +			if (n != ARRAY_SIZE(sol_ipv6_tests))
> +				return -1;
> +		}
>   	}
>   
>   	return 0;


