Return-Path: <linux-kselftest+bounces-10244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 579C58C634E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 11:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB0C1C225F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 09:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BE02AF0E;
	Wed, 15 May 2024 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aScdMWp/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A75FB9B;
	Wed, 15 May 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763626; cv=none; b=WwN7igKIbPF2DXxdXPTRpfm8ukZkWSiHJ7+nnEqEjB+g0OEtU251CXB9Va+RCnEI8qIt7KBUpBhMC5pieoxVLJHf0ERFVDg0sTQZUySFRHmlZYcbN2YWMoUSlOIXkuqldft+KqIibHNoXOFKYq2f7L6oiwLFAkL1Y5NFydvTnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763626; c=relaxed/simple;
	bh=NKHHtdns4RBHpoQzvy4ZHGmWu1zbZfFnKsjEvnUAZsg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QYFehYSEDV1ZvcvMEzEWD5RyVs5dPcTqe06PEZY6tKBHiqHUCJD7LWCNz+2yXULCxyO0bwXaO5OHk1Qufn3Kr10eJppE5zKSddwQQcweg8YGWgCf0XJ7DvH0TswIQAeHIuRshTn/NQHtiSreDS/kPf9czRm4SHSu1f4oU/qSvNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aScdMWp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00356C116B1;
	Wed, 15 May 2024 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715763625;
	bh=NKHHtdns4RBHpoQzvy4ZHGmWu1zbZfFnKsjEvnUAZsg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=aScdMWp/nyB9Bfi9YcRUduuU/MaUUzYf0nqAS15w7x4aGxnMVElI2uQLHGQ/e4yJh
	 BvE1CuzvsbbFjyWuxTB8kgT5ZCklL4ltWRDjomVL44kSF3QBWAiSHtYXPZHSSQAJzU
	 b9RF/QoIDX02RHFMFhoGAVJhflD/x08tI6hF+aX4Oja5nJujFk5/GQLiX7ILIuO5rt
	 7YRsI29QoRfm6wRHrbfnyFQP2dJqaaFLChfEMMn7kuBiuMNT+8Pfj+2FS2JUJnTH70
	 m3zDTDjurG4bFrsVpGRBqMfvsfJp6cor1E8HLdbigmE0JiqLSD5XkvNKGjpZUUUG4S
	 1TY5VRm5XqMag==
Message-ID: <9a207f7b3fc0d915781041a143dfccdd672db68c.camel@kernel.org>
Subject: Re: [PATCH bpf-next 9/9] selftests/bpf: Use netns helpers in
 test_tunnel
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org
Date: Wed, 15 May 2024 17:00:16 +0800
In-Reply-To: <a1d1035cefdeb675ae561fdb1fd49cddb4ba4bb6.1715751995.git.tanggeliang@kylinos.cn>
References: <cover.1715751995.git.tanggeliang@kylinos.cn>
	 <a1d1035cefdeb675ae561fdb1fd49cddb4ba4bb6.1715751995.git.tanggeliang@kylinos.cn>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry, this patch breaks CI.

Changes Requested.

-Geliang

On Wed, 2024-05-15 at 13:59 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch uses netns helpers create_netns() and cleanup_netns() in
> test_tunnel.c instead of using open_netns() and close_netns()
> directly.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../selftests/bpf/prog_tests/test_tunnel.c    | 19 +++++++++--------
> --
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> index cec746e77cd3..6706ee1cb36d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
> @@ -102,7 +102,6 @@
>  
>  static int config_device(void)
>  {
> -	SYS(fail, "ip netns add at_ns0");
>  	SYS(fail, "ip link add veth0 address " MAC_VETH1 " type veth
> peer name veth1");
>  	SYS(fail, "ip link set veth0 netns at_ns0");
>  	SYS(fail, "ip addr add " IP4_ADDR1_VETH1 "/24 dev veth1");
> @@ -117,7 +116,7 @@ static int config_device(void)
>  
>  static void cleanup(void)
>  {
> -	SYS_NOFAIL("test -f /var/run/netns/at_ns0 && ip netns delete
> at_ns0");
> +	SYS_NOFAIL("test -f /var/run/netns/at_ns0");
>  	SYS_NOFAIL("ip link del veth1");
>  	SYS_NOFAIL("ip link del %s", VXLAN_TUNL_DEV1);
>  	SYS_NOFAIL("ip link del %s", IP6VXLAN_TUNL_DEV1);
> @@ -444,7 +443,7 @@ static void test_vxlan_tunnel(void)
>  		goto done;
>  
>  	/* load and attach prog set_md to tunnel dev tc hook point
> at_ns0 */
> -	nstoken = open_netns("at_ns0");
> +	nstoken = create_netns("at_ns0");
>  	if (!ASSERT_OK_PTR(nstoken, "setns src"))
>  		goto done;
>  	ifindex = if_nametoindex(VXLAN_TUNL_DEV0);
> @@ -456,7 +455,7 @@ static void test_vxlan_tunnel(void)
>  		goto done;
>  	if (attach_tc_prog(&tc_hook, -1, set_dst_prog_fd))
>  		goto done;
> -	close_netns(nstoken);
> +	cleanup_netns(nstoken);
>  
>  	/* use veth1 ip 2 as tunnel source ip */
>  	local_ip_map_fd = bpf_map__fd(skel->maps.local_ip_map);
> @@ -517,7 +516,7 @@ static void test_ip6vxlan_tunnel(void)
>  		goto done;
>  
>  	/* load and attach prog set_md to tunnel dev tc hook point
> at_ns0 */
> -	nstoken = open_netns("at_ns0");
> +	nstoken = create_netns("at_ns0");
>  	if (!ASSERT_OK_PTR(nstoken, "setns src"))
>  		goto done;
>  	ifindex = if_nametoindex(IP6VXLAN_TUNL_DEV0);
> @@ -529,7 +528,7 @@ static void test_ip6vxlan_tunnel(void)
>  		goto done;
>  	if (attach_tc_prog(&tc_hook, -1, set_dst_prog_fd))
>  		goto done;
> -	close_netns(nstoken);
> +	cleanup_netns(nstoken);
>  
>  	/* use veth1 ip 2 as tunnel source ip */
>  	local_ip_map_fd = bpf_map__fd(skel->maps.local_ip_map);
> @@ -611,13 +610,13 @@ static void test_ipip_tunnel(enum ipip_encap
> encap)
>  		goto done;
>  
>  	/* ping from at_ns0 namespace test */
> -	nstoken = open_netns("at_ns0");
> +	nstoken = create_netns("at_ns0");
>  	if (!ASSERT_OK_PTR(nstoken, "setns"))
>  		goto done;
>  	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
>  	if (!ASSERT_OK(err, "test_ping"))
>  		goto done;
> -	close_netns(nstoken);
> +	cleanup_netns(nstoken);
>  
>  done:
>  	/* delete ipip tunnel */
> @@ -667,11 +666,11 @@ static void test_xfrm_tunnel(void)
>  		goto done;
>  
>  	/* ping from at_ns0 namespace test */
> -	nstoken = open_netns("at_ns0");
> +	nstoken = create_netns("at_ns0");
>  	if (!ASSERT_OK_PTR(nstoken, "setns"))
>  		goto done;
>  	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
> -	close_netns(nstoken);
> +	cleanup_netns(nstoken);
>  	if (!ASSERT_OK(err, "test_ping"))
>  		goto done;
>  


