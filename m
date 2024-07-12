Return-Path: <linux-kselftest+bounces-13634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01CF92F34D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 03:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E447D1C2114C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 01:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7CD8BE8;
	Fri, 12 Jul 2024 01:10:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279495256;
	Fri, 12 Jul 2024 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720746642; cv=none; b=Y7EuHbgIEJwDyxcgb7TdxKbtnqaVrcDKy2XcH1br7XbtjDOKUeP5QXInvR668weL35JZNszRRXIpTp6CfcOtAqQsrNQtgFyyrHPFvHJYr6vlHGx9OOC/tJZXmLBEV16nmGxskmopA4nfuJPErhgE5FLt58bbDmeWhEqdz3pWZy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720746642; c=relaxed/simple;
	bh=1Vt4FW8WENAx7Dle8hz8WMlIDeg/uCm3IuldkxArTvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sabA8QgDTfwywfHZWri7gqQB1eeVCSrtcO9ZpLuRAAWW0MDWkeCPue/S+DQAteHCj5tCeT9DVukZPGsvbBWul/ORmSBQxp5EceW0In7tAgo7RvS6BSVnqdcYL32j9fCC204BT+pTCE0Yb+bID3Id3vZlYeYyZD/FsWDINySaGgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fb3cf78fa6so10165405ad.1;
        Thu, 11 Jul 2024 18:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720746639; x=1721351439;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1AVXj0tANqtPFDU7AJSgifQ21HImlVVlL3X1KaD8n0=;
        b=beIJHV7HiXGyn6kotVc82wHQxeAHuPzMBEiEw5TeAUUqznR73cVea45kFKLUZu0qNv
         7IGgZvmjJC1JoN3T3szZfRZcDUTKPVac4pT/KHNlvJD1wMttrfNbaq7et16MBhFrSHcT
         TYq+NymFXOx0zWmj+lhsW9oigX00e90v6EhqOOpLlbQAYmikxddoxDnFUdjOW+IgzLz0
         PudQ0HWEdEINVVOOV2zz6LZGsQM3O3n6dQGTZtmbBVM6VytTRtgIp7/QPxXtY9i5MzWD
         geH9bK9neP/hKugCATGTFyHmNIZd7rJ+Y0XxVvQ47YMxnkpmAx76KYe6n5Y3IC0tpilW
         ddIg==
X-Forwarded-Encrypted: i=1; AJvYcCVr8uhggtHcTy7at8wzFnFRVQAuXUYIdUcDCPSZZvdzf92PvT9ZwrB6kUYKbwLHV0R/V2REOXTxUuDxDEoQPRpn1OTR2TneAYnlhjN4K8uX5D53PwMNTGpT48DfXKmeRweJkqnMJXxW5tN3zcIVpMkUyEU7N5cRtDEzlP6exbwWDoVCGqNgR7pp7jkRMwsShOc3WRKUx0M+MC9R
X-Gm-Message-State: AOJu0Ywdb6QRz4zQP4Cjg4E9QQ/U5FaODnWm5px72EKzcl2XS+1bPvDd
	SYZxZUbnJ5D9apZfNd6f9O1dqnMlXI4LnHbXlGLZMzuu3xzkHljNaEmb2i8=
X-Google-Smtp-Source: AGHT+IExwoJb+WzSc3arL4DHBmrpKB97Gh1o8Tu8q2wnb74n5OBkQ6vQrthZY2DcdUxBvMMKaSlF5A==
X-Received: by 2002:a17:902:e5c7:b0:1fb:167e:fb0c with SMTP id d9443c01a7336-1fbb6eff6e2mr75184965ad.56.1720746639185;
        Thu, 11 Jul 2024 18:10:39 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab6d0dsm56582405ad.167.2024.07.11.18.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 18:10:38 -0700 (PDT)
Date: Thu, 11 Jul 2024 18:10:37 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/3] selftests/bpf: integrate test_xdp_veth into
 test_progs
Message-ID: <ZpCCjQP3XQeJPpwH@mini-arch>
References: <20240711-convert_test_xdp_veth-v1-0-868accb0a727@bootlin.com>
 <20240711-convert_test_xdp_veth-v1-2-868accb0a727@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240711-convert_test_xdp_veth-v1-2-868accb0a727@bootlin.com>

On 07/11, Alexis Lothoré (eBPF Foundation) wrote:
> test_xdp_veth.sh tests that XDP return codes work as expected, by bringing
> up multiple veth pairs isolated in different namespaces, attaching specific
> xdp programs to each interface, and ensuring that the whole chain allows to
> ping one end interface from the first one. The test runs well but is
> currently not integrated in test_progs, which prevents it from being run
> automatically in the CI infrastructure.
> 
> Rewrite it as a C test relying on libbpf to allow running it in the CI
> infrastructure. The new code brings up the same network infrastructure and
> reuses the same eBPF programs as test_xdp_veth.sh, for which skeletons are
> already generated by the bpf tests makefile.
> 
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> ---
> The new code has been tested in an aarch64 qemu instance:
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> I have also checked that some minor alterations in the network
> configuration (altering the redirect map, or not loading one of the xdp
> programs) make the test fail.
> 
> On my testing setup, the test takes a bit more than 3 seconds to run on
> average.
> ---
>  .../selftests/bpf/prog_tests/test_xdp_veth.c       | 234 +++++++++++++++++++++
>  1 file changed, 234 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> new file mode 100644
> index 000000000000..40d85aece984
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * Create 3 namespaces with 3 veth peers, and
> + * forward packets in-between using native XDP
> + *
> + *                      XDP_TX
> + * NS1(veth11)        NS2(veth22)        NS3(veth33)
> + *      |                  |                  |
> + *      |                  |                  |
> + *   (veth1,            (veth2,            (veth3,
> + *   id:111)            id:122)            id:133)
> + *     ^ |                ^ |                ^ |
> + *     | |  XDP_REDIRECT  | |  XDP_REDIRECT  | |
> + *     | ------------------ ------------------ |
> + *     -----------------------------------------
> + *                    XDP_REDIRECT
> + */
> +
> +#define _GNU_SOURCE
> +#include <net/if.h>
> +#include "test_progs.h"
> +#include "network_helpers.h"
> +#include "xdp_dummy.skel.h"
> +#include "xdp_redirect_map.skel.h"
> +#include "xdp_tx.skel.h"
> +
> +#define VETH_PAIRS_COUNT	3
> +#define NS_NAME_MAX_LEN		16
> +#define NS_SUFFIX_LEN		6
> +#define VETH_NAME_MAX_LEN	16
> +#define IP_SRC				"10.1.1.11"
> +#define IP_DST				"10.1.1.33"
> +#define IP_CMD_MAX_LEN		128
> +
> +struct skeletons {
> +	struct xdp_dummy *xdp_dummy;
> +	struct xdp_tx *xdp_tx;
> +	struct xdp_redirect_map *xdp_redirect_maps;
> +};
> +
> +struct veth_configuration {
> +	char local_veth[VETH_NAME_MAX_LEN]; /* Interface in main namespace */
> +	char remote_veth[VETH_NAME_MAX_LEN]; /* Peer interface in dedicated namespace*/
> +	char namespace[NS_NAME_MAX_LEN]; /* Namespace for the remote veth */
> +	char next_veth[VETH_NAME_MAX_LEN]; /* Local interface to redirect traffic to */
> +	char *remote_addr; /* IP address of the remote veth */
> +};
> +
> +static struct veth_configuration config[VETH_PAIRS_COUNT] = {
> +	{
> +		.local_veth = "veth1",
> +		.remote_veth = "veth11",
> +		.next_veth = "veth2",
> +		.remote_addr = IP_SRC
> +	},
> +	{
> +		.local_veth = "veth2",
> +		.remote_veth = "veth22",
> +		.next_veth = "veth3",
> +		.remote_addr = NULL
> +	},
> +	{
> +		.local_veth = "veth3",
> +		.remote_veth = "veth33",
> +		.next_veth = "veth1",
> +		.remote_addr = IP_DST
> +	}
> +};

[..]

> +static void generate_random_ns_name(int index, char *out)
> +{
> +	int random, count, i;
> +
> +	count = snprintf(out, NS_NAME_MAX_LEN, "ns%d-", index);
> +	for(i=0; i<NS_SUFFIX_LEN; i++) {
> +		random=rand() % 2;
> +		out[count++]= random ? 'a' + rand() % 26 : 'A' + rand() % 26;
> +	}
> +	out[count] = 0;
> +}

It's been customary to hard-code netns names for all the tests we have, so
maybe it's ok here as well? 

> +static int attach_programs_to_veth_pair(struct skeletons *skeletons, int index)
> +{
> +	struct bpf_program *local_prog, *remote_prog;
> +	struct bpf_link **local_link, **remote_link;
> +	struct nstoken *nstoken;
> +	struct bpf_link *link;
> +	int interface;
> +

[..]

> +	switch(index) {

Can you pls run the patch through the checkpatch.pl? The formatting
looks wrong, should be 'switch (index)'. Applies to 'if()' elsewhere as
well.

> +		case 0:
> +			local_prog = skeletons->xdp_redirect_maps->progs.xdp_redirect_map_0;
> +			local_link = &skeletons->xdp_redirect_maps->links.xdp_redirect_map_0;
> +			remote_prog = skeletons->xdp_dummy->progs.xdp_dummy_prog;
> +			remote_link = &skeletons->xdp_dummy->links.xdp_dummy_prog;
> +			break;
> +		case 1:
> +			local_prog = skeletons->xdp_redirect_maps->progs.xdp_redirect_map_1;
> +			local_link = &skeletons->xdp_redirect_maps->links.xdp_redirect_map_1;
> +			remote_prog = skeletons->xdp_tx->progs.xdp_tx;
> +			remote_link = &skeletons->xdp_tx->links.xdp_tx;
> +			break;
> +		case 2:
> +			local_prog = skeletons->xdp_redirect_maps->progs.xdp_redirect_map_2;
> +			local_link = &skeletons->xdp_redirect_maps->links.xdp_redirect_map_2;
> +			remote_prog = skeletons->xdp_dummy->progs.xdp_dummy_prog;
> +			remote_link = &skeletons->xdp_dummy->links.xdp_dummy_prog;
> +			break;
> +	}
> +	interface = if_nametoindex(config[index].local_veth);
> +	if(!ASSERT_NEQ(interface, 0, "non zero interface index"))
> +		return -1;
> +	link = bpf_program__attach_xdp(local_prog, interface);
> +	if (!ASSERT_OK_PTR(link, "attach xdp program to local veth"))
> +		return -1;
> +	*local_link = link;
> +	nstoken = open_netns(config[index].namespace);
> +	if (!ASSERT_OK_PTR(nstoken, "switch to remote veth namespace"))
> +		return -1;
> +	interface = if_nametoindex(config[index].remote_veth);
> +	if(!ASSERT_NEQ(interface, 0, "non zero interface index"))
> +		return -1;
> +	link = bpf_program__attach_xdp(remote_prog, interface);
> +	*remote_link = link;
> +	close_netns(nstoken);
> +	if (!ASSERT_OK_PTR(link, "attach xdp program to remote veth"))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int configure_network(struct skeletons *skeletons) {
> +	int interface_id;
> +	int map_fd;
> +	int err;
> +	int i=0;
> +
> +	/* First create and configure all interfaces */
> +	for(i=0; i<VETH_PAIRS_COUNT; i++) {
> +		generate_random_ns_name(i+1, config[i].namespace);
> +
> +		SYS(fail, "ip netns add %s", config[i].namespace);
> +		SYS(fail, "ip link add %s type veth peer name %s netns %s",
> +				config[i].local_veth,
> +				config[i].remote_veth,
> +				config[i].namespace);
> +		SYS(fail, "ip link set dev %s up", config[i].local_veth);
> +		if (config[i].remote_addr)
> +			SYS(fail, "ip -n %s addr add %s/24 dev %s",
> +					   config[i].namespace, config[i].remote_addr, config[i].remote_veth);
> +		SYS(fail, "ip -n %s link set dev %s up",
> +				   config[i].namespace, config[i].remote_veth);
> +	}
> +
> +	/* Then configure the redirect map and attach programs to interfaces */
> +	map_fd = bpf_map__fd(skeletons->xdp_redirect_maps->maps.tx_port);
> +	if (!ASSERT_GE(map_fd, 0, "open redirect map"))
> +		goto fail;
> +	for (i=0; i<VETH_PAIRS_COUNT; i++) {
> +		interface_id = if_nametoindex(config[i].next_veth);
> +		if(!ASSERT_NEQ(interface_id, 0, "non zero interface index"))
> +			goto fail;
> +		err = bpf_map_update_elem(map_fd, &i, &interface_id, BPF_ANY);
> +		if (!ASSERT_OK(err, "configure interface redirection through map"))
> +			goto fail;
> +		if(attach_programs_to_veth_pair(skeletons, i))
> +			goto fail;
> +	}
> +
> +	return 0;
> +
> +fail:
> +	return -1;
> +}
> +
> +static void cleanup_network()
> +{
> +	char cmd[IP_CMD_MAX_LEN];
> +	int i;
> +
> +	/* Deleting namespaces is enough to automatically remove veth pairs as well
> +	 */
> +	for(i=0; i<VETH_PAIRS_COUNT; i++) {
> +		if(config[i].namespace[0] == 0)
> +			continue;

[..]

> +		snprintf(cmd, IP_CMD_MAX_LEN, "ip netns del %s", config[i].namespace);
> +		system(cmd);

SYS_NOFAIL to avoid separate snprintf?

> +	}
> +}
> +
> +static int check_ping(struct skeletons *skeletons)
> +{
> +	char cmd[IP_CMD_MAX_LEN];
> +
> +	/* Test: if all interfaces are properly configured, we must be able to ping
> +	 * veth33 from veth11
> +	 */
> +	snprintf(cmd, IP_CMD_MAX_LEN,
> +			 "ip netns exec %s ping -c 1 -W 1 %s > /dev/null",
> +			 config[0].namespace, IP_DST);
> +	return system(cmd);

SYS_NOFAL here as well?


Btw, not sure it makes sense to split that work into 3 patches. After
you first patch the test is broken anyway, so might as well just delete
the script at that point...

