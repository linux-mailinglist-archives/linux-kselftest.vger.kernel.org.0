Return-Path: <linux-kselftest+bounces-25502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5EBA24639
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 02:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427EF3A7D56
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 01:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6822AD31;
	Sat,  1 Feb 2025 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UH8qUpZY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C522F19
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Feb 2025 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738373663; cv=none; b=jn00tf8CoylzDgz2lVr1bX1gfTTp0OkMOWXqXq977FCJLWu0eo0oRcyUrpHLi2zRlNywcJWYA5DPSD8xhE3cjoQ8fNmj13QwdK94r9ESAdkF1yMFVVPEpNJJU8TInudYlWeDnmHq4raitWeZeZpp8TmCzZQG8K317tFjkyJ/6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738373663; c=relaxed/simple;
	bh=DIY9ki5AFOWVQITa7b++GI+M+XGBYmL948AK+b1a8TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+MGAsBzUNTozkX2J5V+GlPbkIxzDytQ5TcYo5vU+jEDDCfSNZCgWsPGUNLCHIHGRjAKdFbLgJR6+AGFoLGb6g1s37W5+NXrk03rXWWgYzB8y/KDuzyxlfqPO1deDU0EbtXogT0MQJjQWQWVbINe/kFnllQuxhTRauDR4DdCTvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UH8qUpZY; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bba86a91-e945-4ab2-825e-b915216ba3c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738373646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjl/SHPyr/rmneu05LCUCbVf8FyWrcP3Qqz6Oxc7iqE=;
	b=UH8qUpZYq8cvYiG3yEOvdXVS/iCLIIRcSMb333Apgx4+9wE70EDHqvG1ZNSQQbfSkffISz
	b8JCJi3erVbcLro9kLO2+Kk/9dOFi9LvxKZOoZDJXADX510p/mZcROMN8PauaBE8Oy51/Z
	5Hhs39cEn8wFBc9uxCWGeKm08VWdv8I=
Date: Fri, 31 Jan 2025 17:33:58 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 12/14] selftests/bpf: test_xdp_veth: Add XDP
 broadcast redirection tests
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Alexis Lothore <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250131-redirect-multi-v4-0-970b33678512@bootlin.com>
 <20250131-redirect-multi-v4-12-970b33678512@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250131-redirect-multi-v4-12-970b33678512@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/30/25 11:21 PM, Bastien Curutchet (eBPF Foundation) wrote:
> +#define BROADCAST_REDIRECT_SKEL_NB	2
> +static void xdp_veth_broadcast_redirect(u32 attach_flags, u64 redirect_flags)
> +{
> +	struct prog_configuration prog_cfg[VETH_PAIRS_COUNT] = {
> +		{
> +			.local_name = "xdp_redirect_map_multi_prog",
> +			.remote_name = "xdp_count_0",
> +			.local_flags = attach_flags,
> +			.remote_flags = attach_flags,
> +		},
> +		{
> +			.local_name = "xdp_redirect_map_multi_prog",
> +			.remote_name = "xdp_count_1",
> +			.local_flags = attach_flags,
> +			.remote_flags = attach_flags,
> +		},
> +		{
> +			.local_name = "xdp_redirect_map_multi_prog",
> +			.remote_name = "xdp_count_2",
> +			.local_flags = attach_flags,
> +			.remote_flags = attach_flags,
> +		}
> +	};
> +	struct bpf_object *bpf_objs[BROADCAST_REDIRECT_SKEL_NB];
> +	struct xdp_redirect_multi_kern *xdp_redirect_multi_kern;
> +	struct veth_configuration net_config[VETH_PAIRS_COUNT];
> +	struct xdp_redirect_map *xdp_redirect_map;
> +	struct bpf_devmap_val devmap_val = {};
> +	u16 protocol = ETH_P_IP;
> +	int group_map;
> +	int flags_map;
> +	int cnt_map;
> +	u64 cnt = 0;
> +	int i, err;
> +
> +	xdp_redirect_multi_kern = xdp_redirect_multi_kern__open_and_load();
> +	if (!ASSERT_OK_PTR(xdp_redirect_multi_kern, "xdp_redirect_multi_kern__open_and_load"))
> +		return;
> +
> +	xdp_redirect_map = xdp_redirect_map__open_and_load();
> +	if (!ASSERT_OK_PTR(xdp_redirect_map, "xdp_redirect_map__open_and_load"))
> +		goto destroy_xdp_redirect_multi_kern;
> +
> +	if (!ASSERT_OK(create_network(net_config), "create network"))
> +		goto destroy_xdp_redirect_map;
> +
> +	group_map = bpf_map__fd(xdp_redirect_multi_kern->maps.map_all);
> +	if (!ASSERT_OK_FD(group_map, "open map_all"))
> +		goto destroy_xdp_redirect_map;
> +
> +	flags_map = bpf_map__fd(xdp_redirect_multi_kern->maps.redirect_flags);
> +	if (!ASSERT_OK_FD(group_map, "open map_all"))
> +		goto destroy_xdp_redirect_map;
> +
> +	err = bpf_map_update_elem(flags_map, &protocol, &redirect_flags, BPF_NOEXIST);
> +	if (!ASSERT_OK(err, "init IP count"))
> +		goto destroy_xdp_redirect_map;
> +
> +	cnt_map = bpf_map__fd(xdp_redirect_map->maps.rxcnt);
> +	if (!ASSERT_OK_FD(cnt_map, "open rxcnt map"))
> +		goto destroy_xdp_redirect_map;
> +
> +	bpf_objs[0] = xdp_redirect_multi_kern->obj;
> +	bpf_objs[1] = xdp_redirect_map->obj;
> +	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
> +		int ifindex = if_nametoindex(net_config[i].local_veth);
> +
> +		if (attach_programs_to_veth_pair(bpf_objs, BROADCAST_REDIRECT_SKEL_NB,
> +						 net_config, prog_cfg, i))
> +			goto destroy_xdp_redirect_map;
> +
> +		SYS(destroy_xdp_redirect_map,
> +		    "ip -n %s neigh add %s lladdr 00:00:00:00:00:01 dev %s",
> +		    net_config[i].namespace, IP_NEIGH, net_config[i].remote_veth);
> +
> +		devmap_val.ifindex = ifindex;
> +		err = bpf_map_update_elem(group_map, &ifindex, &devmap_val, 0);

I ran this test in a loop and failed at this line permanently (errno E2BIG -7) 
after enough iterations. I believe the problem is the group_map (aka "map_all" 
in the BPF program) has a max_entries 1024 and ifindex can go beyond 1024 after 
some "./test_progs" iterations. Understood that it is likely an existing 
assumption in the "map_all" definition but it needs to be addressed first before 
moving to test_progs.

> +		if (!ASSERT_OK(err, "bpf_map_update_elem"))
> +			goto destroy_xdp_redirect_map;
> +
> +	}
> +
> +	SYS_NOFAIL("ip netns exec %s ping %s -i 0.1 -c 4 -W1 > /dev/null ",
> +		    net_config[0].namespace, IP_NEIGH);
> +
> +	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
> +		err =  bpf_map_lookup_elem(cnt_map, &i, &cnt);
> +		if (!ASSERT_OK(err, "get IP cnt"))
> +			goto destroy_xdp_redirect_map;
> +
> +		if (redirect_flags & BPF_F_EXCLUDE_INGRESS)
> +			/* veth11 shouldn't receive the ICMP requests;
> +			 * others should
> +			 */
> +			ASSERT_EQ(cnt, i ? 4 : 0, "compare IP cnt");
> +		else
> +			/* All remote veth should receive the ICMP requests */
> +			ASSERT_EQ(cnt, 4, "compare IP cnt");
> +	}
> +
> +destroy_xdp_redirect_map:
> +	xdp_redirect_map__destroy(xdp_redirect_map);
> +destroy_xdp_redirect_multi_kern:
> +	xdp_redirect_multi_kern__destroy(xdp_redirect_multi_kern);
> +
> +	cleanup_network(net_config);
> +}
> +
>   void test_xdp_veth_redirect(void)
>   {
>   	if (test__start_subtest("0"))
> @@ -284,3 +411,26 @@ void test_xdp_veth_redirect(void)
>   	if (test__start_subtest("SKB_MODE"))
>   		xdp_veth_redirect(XDP_FLAGS_SKB_MODE);
>   }
> +
> +void test_xdp_veth_broadcast_redirect(void)
> +{
> +	if (test__start_subtest("0/BROADCAST"))
> +		xdp_veth_broadcast_redirect(0, BPF_F_BROADCAST);
> +
> +	if (test__start_subtest("0/(BROADCAST | EXCLUDE_INGRESS)"))
> +		xdp_veth_broadcast_redirect(0, BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
> +
> +	if (test__start_subtest("DRV_MODE/BROADCAST"))
> +		xdp_veth_broadcast_redirect(XDP_FLAGS_DRV_MODE, BPF_F_BROADCAST);
> +
> +	if (test__start_subtest("DRV_MODE/(BROADCAST | EXCLUDE_INGRESS)"))
> +		xdp_veth_broadcast_redirect(XDP_FLAGS_DRV_MODE,
> +					    BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
> +
> +	if (test__start_subtest("SKB_MODE/BROADCAST"))
> +		xdp_veth_broadcast_redirect(XDP_FLAGS_SKB_MODE, BPF_F_BROADCAST);
> +
> +	if (test__start_subtest("SKB_MODE/(BROADCAST | EXCLUDE_INGRESS)"))
> +		xdp_veth_broadcast_redirect(XDP_FLAGS_SKB_MODE,
> +					    BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
> index 682dda8dabbc9abbb5d1b0b22dd5f81124142e79..14385df71d7fc40c3b0ee5c6ea0760d0e7336d71 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
> @@ -1,7 +1,11 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> +#include <linux/if_ether.h>
> +#include <linux/ip.h>

I have compiler error complaining about __always_inline not defined. Likely 
ordering issue and environment specific. Regardless, I believe the ip.h is 
unnecessary, so better clean it up.

I am going to land the patch 1-10 and change the cover letter a little to 
reflect the fact that patch 11-14 will be a followup. Please post the remaining 
patches after fixing the bpf_map_update_elem issue. Thanks.

> +
>   #include <linux/bpf.h>
>   #include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_endian.h>
>   
>   struct {
>   	__uint(type, BPF_MAP_TYPE_DEVMAP);
> @@ -28,4 +32,49 @@ int xdp_redirect_map_2(struct xdp_md *xdp)
>   	return bpf_redirect_map(&tx_port, 2, 0);
>   }
>   
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 3);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} rxcnt SEC(".maps");
> +
> +static int xdp_count(struct xdp_md *xdp, __u32 key)
> +{
> +	void *data_end = (void *)(long)xdp->data_end;
> +	void *data = (void *)(long)xdp->data;
> +	struct ethhdr *eth = data;
> +	__u64 *count;
> +
> +	if (data + sizeof(*eth) > data_end)
> +		return XDP_DROP;
> +
> +	if (bpf_htons(eth->h_proto) == ETH_P_IP) {
> +		/* We only count IPv4 packets */
> +		count = bpf_map_lookup_elem(&rxcnt, &key);
> +		if (count)
> +			*count += 1;
> +	}
> +
> +	return XDP_PASS;
> +}
> +
> +SEC("xdp")
> +int xdp_count_0(struct xdp_md *xdp)
> +{
> +	return xdp_count(xdp, 0);
> +}
> +
> +SEC("xdp")
> +int xdp_count_1(struct xdp_md *xdp)
> +{
> +	return xdp_count(xdp, 1);
> +}
> +
> +SEC("xdp")
> +int xdp_count_2(struct xdp_md *xdp)
> +{
> +	return xdp_count(xdp, 2);
> +}
> +
>   char _license[] SEC("license") = "GPL";
> 


