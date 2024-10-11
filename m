Return-Path: <linux-kselftest+bounces-19492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219C599992F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 03:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5EA1F24E57
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 01:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3C81759F;
	Fri, 11 Oct 2024 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LHOtBVGp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE94210A3E
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 01:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609809; cv=none; b=g2/YNucJfoyUJYeMMiYkGvcB/TWJSNlV37kkPhA9/tHBAii4GalJn1AkQTkjOh2ZynW+noZLmY+rxOn6sB0mSsGriw7HEeRKC5JWfOWl1G+kOnIMHOxBMUF80zmQ8rvkowqTmf5ChAnY8YBlgmIXYlRuqv6G9NxjNLhXPSqHuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609809; c=relaxed/simple;
	bh=ar2wYr6s0OIgN9zIT6rf04/EqL+lIR0d+I7XeEr8hHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVN3LncEJnessOSqcMkWWVN9nYDQMZeCF+r+6uiz8Sa3KR7JEMqhkyjqcNtC2oZVmIwR+N2OYXZZ4TQtVSyZzmJ7jqNM5HahATYPOkYcrcUZHgiJlrz8EaDrbKbvX8Pbvppm1d2QbX36s+agUMs0A0UNQquCN4Ooiky96O+rU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LHOtBVGp; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ffd94cd8-f29e-49e8-9c6f-23be9d9b1bc5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728609803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9MfOf/K0tLHfHGCgBhYBXCuzTy/t8riyNYLFVdWmF0=;
	b=LHOtBVGp1r/4P7VPQp+tmwTVaD1yXf5stgDP+VPEu/h/4VrZs0oIxkrzMJt9SI1dicLO9n
	biDTnKxEnXe+4N4v4wthfKaeTECHiqxvMDQcNZhXkMKcrENQT0m1q/1Q9O61gSCoqQmJto
	i1u2t/w3qn2NXKEjmxfpQ9tj0OSWLf0=
Date: Thu, 10 Oct 2024 18:23:14 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: make xdp_cpumap_attach
 keep redirect prog attached
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
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
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241009-convert_xdp_tests-v3-0-51cea913710c@bootlin.com>
 <20241009-convert_xdp_tests-v3-2-51cea913710c@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241009-convert_xdp_tests-v3-2-51cea913710c@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/9/24 3:12 AM, Alexis Lothoré (eBPF Foundation) wrote:
> Current test only checks attach/detach on cpu map type program, and so
> does not check that it can be properly executed, neither that it
> redirects correctly.
> 
> Update the existing test to extend its coverage:
> - keep the redirected program loaded
> - try to execute it through bpf_prog_test_run_opts with some dummy
>    context
> 
> While at it, bring the following minor improvements:
> - isolate test interface in its own namespace
> - replicate the test on a veth pair
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> This change is based on the similar update brought to xdp_devmap_attach
> ([1]) and then realigns xdp_cpumap_attach with it
> 
> [1] https://lore.kernel.org/bpf/20240911-devel-koalo-fix-ingress-ifindex-v4-2-5c643ae10258@linutronix.de/
> 
> Changes in v3:
> - new patch
> ---
>   .../selftests/bpf/prog_tests/xdp_cpumap_attach.c   | 124 +++++++++++++++++++--
>   1 file changed, 117 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
> index 481626a875d1c3db9c7bfe92c3cca6e967a6d45c..31c225f0239613f6b5adad36b5b0e6e85eeddd9a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
> @@ -2,35 +2,41 @@
>   #include <uapi/linux/bpf.h>
>   #include <linux/if_link.h>
>   #include <test_progs.h>
> +#include <network_helpers.h>
>   
>   #include "test_xdp_with_cpumap_frags_helpers.skel.h"
>   #include "test_xdp_with_cpumap_helpers.skel.h"
>   
>   #define IFINDEX_LO	1
> +#define TEST_NS "cpu_attach_ns"
>   
>   static void test_xdp_with_cpumap_helpers(void)
>   {
> -	struct test_xdp_with_cpumap_helpers *skel;
> +	struct test_xdp_with_cpumap_helpers *skel = NULL;
>   	struct bpf_prog_info info = {};
>   	__u32 len = sizeof(info);
>   	struct bpf_cpumap_val val = {
>   		.qsize = 192,
>   	};
> -	int err, prog_fd, map_fd;
> +	int err, prog_fd, prog_redir_fd, map_fd;
> +	struct nstoken *nstoken = NULL;
>   	__u32 idx = 0;
>   
> +	SYS(out_close, "ip netns add %s", TEST_NS);
> +	nstoken = open_netns(TEST_NS);
> +	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
> +		goto out_close;
> +	SYS(out_close, "ip link set dev lo up");

There is easier helper netns_{new,free} to do all these:
	netns_obj = netns_new(TEST_NS, true);

Only fyi for your future work.

> +
>   	skel = test_xdp_with_cpumap_helpers__open_and_load();
>   	if (!ASSERT_OK_PTR(skel, "test_xdp_with_cpumap_helpers__open_and_load"))
>   		return;
>   
> -	prog_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
> -	err = bpf_xdp_attach(IFINDEX_LO, prog_fd, XDP_FLAGS_SKB_MODE, NULL);
> +	prog_redir_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
> +	err = bpf_xdp_attach(IFINDEX_LO, prog_redir_fd, XDP_FLAGS_SKB_MODE, NULL);
>   	if (!ASSERT_OK(err, "Generic attach of program with 8-byte CPUMAP"))
>   		goto out_close;
>   
> -	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
> -	ASSERT_OK(err, "XDP program detach");
> -
>   	prog_fd = bpf_program__fd(skel->progs.xdp_dummy_cm);
>   	map_fd = bpf_map__fd(skel->maps.cpu_map);
>   	err = bpf_prog_get_info_by_fd(prog_fd, &info, &len);
> @@ -45,6 +51,23 @@ static void test_xdp_with_cpumap_helpers(void)
>   	ASSERT_OK(err, "Read cpumap entry");
>   	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry prog_id");
>   
> +	/* send a packet to trigger any potential bugs in there */
> +	char data[10] = {};
> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> +			    .data_in = &data,
> +			    .data_size_in = 10,
> +			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
> +			    .repeat = 1,
> +		);
> +	err = bpf_prog_test_run_opts(prog_redir_fd, &opts);
> +	ASSERT_OK(err, "XDP test run");
> +
> +	/* wait for the packets to be flushed */
> +	kern_sync_rcu();
> +
> +	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
> +	ASSERT_OK(err, "XDP program detach");
> +
>   	/* can not attach BPF_XDP_CPUMAP program to a device */
>   	err = bpf_xdp_attach(IFINDEX_LO, prog_fd, XDP_FLAGS_SKB_MODE, NULL);
>   	if (!ASSERT_NEQ(err, 0, "Attach of BPF_XDP_CPUMAP program"))
> @@ -65,6 +88,8 @@ static void test_xdp_with_cpumap_helpers(void)
>   	ASSERT_NEQ(err, 0, "Add BPF_XDP program with frags to cpumap entry");
>   
>   out_close:
> +	close_netns(nstoken);
> +	SYS_NOFAIL("ip netns del %s", TEST_NS);
>   	test_xdp_with_cpumap_helpers__destroy(skel);
>   }
>   
> @@ -111,6 +136,88 @@ static void test_xdp_with_cpumap_frags_helpers(void)
>   	test_xdp_with_cpumap_frags_helpers__destroy(skel);
>   }
>   
> +static void test_xdp_with_cpumap_helpers_veth(void)

Unlike the devmap redirect, cpumap redirects pkt to another cpu instead of 
another veth dev. veth test is not very useful here for cpumap, so I take the 
veth test out.

> +{
> +	int err, cm_fd, cm_fd_redir, map_fd, ifindex_dst, ifindex_src;
> +	struct test_xdp_with_cpumap_helpers *skel = NULL;
> +	struct bpf_prog_info info = {};
> +	struct bpf_cpumap_val val = {
> +		.qsize = 192
> +	};
> +	struct nstoken *nstoken = NULL;
> +	__u32 len = sizeof(info);
> +	__u32 idx = 0;
> +
> +	SYS(out_close, "ip netns add %s", TEST_NS);
> +	nstoken = open_netns(TEST_NS);
> +	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
> +		goto out_close;
> +
> +	SYS(out_close, "ip link add veth_src type veth peer name veth_dst");
> +	SYS(out_close, "ip link set dev veth_src up");
> +	SYS(out_close, "ip link set dev veth_dst up");
> +
> +	ifindex_src = if_nametoindex("veth_src");
> +	ifindex_dst = if_nametoindex("veth_dst");
> +	if (!ASSERT_NEQ(ifindex_src, 0, "val.ifindex") ||
> +	    !ASSERT_NEQ(ifindex_dst, 0, "ifindex_dst"))
> +		goto out_close;
> +
> +	skel = test_xdp_with_cpumap_helpers__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "test_xdp_with_cpumap_helpers__open_and_load"))
> +		goto out_close;
> +
> +	cm_fd_redir = bpf_program__fd(skel->progs.xdp_redir_prog);
> +	err = bpf_xdp_attach(ifindex_src, cm_fd_redir, XDP_FLAGS_DRV_MODE, NULL);
> +	if (!ASSERT_OK(err, "Attach of program with 8-byte cpumap"))
> +		goto out_close;
> +
> +	cm_fd = bpf_program__fd(skel->progs.xdp_dummy_cm);
> +	map_fd = bpf_map__fd(skel->maps.cpu_map);
> +	err = bpf_prog_get_info_by_fd(cm_fd, &info, &len);
> +	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
> +		goto out_close;
> +
> +	val.bpf_prog.fd = cm_fd;
> +	err = bpf_map_update_elem(map_fd, &idx, &val, 0);
> +	ASSERT_OK(err, "Add program to cpumap entry");
> +
> +	err = bpf_map_lookup_elem(map_fd, &idx, &val);
> +	ASSERT_OK(err, "Read cpumap entry");
> +	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry prog_id");
> +
> +	/* attach dummy to other side to enable reception */
> +	cm_fd = bpf_program__fd(skel->progs.xdp_dummy_prog);
> +	err = bpf_xdp_attach(ifindex_dst, cm_fd, XDP_FLAGS_DRV_MODE, NULL);
> +	if (!ASSERT_OK(err, "Attach of dummy XDP"))
> +		goto out_close;
> +
> +	/* send a packet to trigger any potential bugs in there */
> +	char data[10] = {};
> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> +			    .data_in = &data,
> +			    .data_size_in = 10,
> +			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
> +			    .repeat = 1,
> +		);
> +	err = bpf_prog_test_run_opts(cm_fd_redir, &opts);
> +	ASSERT_OK(err, "XDP test run");
> +
> +	/* wait for the packets to be flushed */
> +	kern_sync_rcu();
> +
> +	err = bpf_xdp_detach(ifindex_src, XDP_FLAGS_DRV_MODE, NULL);
> +	ASSERT_OK(err, "XDP program detach");
> +
> +	err = bpf_xdp_detach(ifindex_dst, XDP_FLAGS_DRV_MODE, NULL);
> +	ASSERT_OK(err, "XDP program detach");
> +
> +out_close:
> +	close_netns(nstoken);
> +	SYS_NOFAIL("ip netns del %s", TEST_NS);
> +	test_xdp_with_cpumap_helpers__destroy(skel);
> +}
> +
>   void serial_test_xdp_cpumap_attach(void)

Thanks for improving the existing test by running in its netns, I also removed 
the "serial_". Applied. Thanks.

>   {
>   	if (test__start_subtest("CPUMAP with programs in entries"))
> @@ -118,4 +225,7 @@ void serial_test_xdp_cpumap_attach(void)
>   
>   	if (test__start_subtest("CPUMAP with frags programs in entries"))
>   		test_xdp_with_cpumap_frags_helpers();
> +
> +	if (test__start_subtest("CPUMAP attach with programs in entries on veth"))
> +		test_xdp_with_cpumap_helpers_veth();
>   }
> 


