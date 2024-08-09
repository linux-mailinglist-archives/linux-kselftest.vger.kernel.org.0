Return-Path: <linux-kselftest+bounces-15104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2324B94D94B
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 01:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A36281B7D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 23:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F90316D4D6;
	Fri,  9 Aug 2024 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CcmmHr6y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DF81684BB
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723247632; cv=none; b=JETIN3+/bhVptZsi4fUcLhohy7DjF8EbQvJN3NMM1VX7U+fahE+wJUtFANnofI1XHCsUEJrUn9/p3ciRZbKQo5IAmvYGe0Y+E42idwOEt36Bzx6vtLr3Rvh7P8nEtdwYZI46tcjZelAThMG6d4EXAVzRnlF8u9Aoy1+O8vY5SRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723247632; c=relaxed/simple;
	bh=HiMaJ05PvcGBJhRURAFR1FXTDjngE0Ksn22Y6TKykVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FROrlXg5cL1GxidMrAQBLxn2vgYOyQpwzVs3p0IdQgHcRBLDbDWQrVHR1aWUV0zBAHWe42buZ/SzMuZRRzbvbn05LCPV6JeXC/Nm9RmG1rZh4a7AjwZPD4bN/rz85rZi/Z3bNTY0d9ivUMFk8ifohK+PAUSmav6AwCeO/IP3Meg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CcmmHr6y; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5f91072d-fd63-4d81-8442-ef7aa62e192f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723247628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcCTKFmLpEfmRVEEyH2Kvr6lxqMjtURj8dPlApZvU4s=;
	b=CcmmHr6yNbpW8rn1ulCYH75veld/ufL6LqjFWfJAtZc3YiohjUZi6xdQRP+N0+bThDaqph
	S+vm33nuavQti0NEt/QNdzMXA91Sr5Vz9EXB6yYrvHGDHQKWmXQtPSy1J82ucXDZ8vk59F
	Tb5LnGk93bj22RibilbBWiQjwS86dkU=
Date: Fri, 9 Aug 2024 16:53:36 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: convert
 test_skb_cgroup_id_user to test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240806-convert_cgroup_tests-v2-0-180c57e5b710@bootlin.com>
 <20240806-convert_cgroup_tests-v2-4-180c57e5b710@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240806-convert_cgroup_tests-v2-4-180c57e5b710@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/6/24 12:55 AM, Alexis Lothoré (eBPF Foundation) wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c b/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c
> new file mode 100644
> index 000000000000..4e41463533c0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "test_progs.h"
> +#include "network_helpers.h"
> +#include "cgroup_helpers.h"
> +#include "cgroup_ancestor.skel.h"
> +
> +#define VETH_PREFIX "test_cgid_"
> +#define VETH_1 VETH_PREFIX "1"
> +#define VETH_2 VETH_PREFIX "2"
> +#define CGROUP_PATH "/skb_cgroup_test"
> +#define NUM_CGROUP_LEVELS 4
> +#define WAIT_AUTO_IP_MAX_ATTEMPT 10
> +#define DST_ADDR "ff02::1"
> +#define DST_PORT 1234
> +#define MAX_ASSERT_NAME 32
> +
> +struct test_data {
> +	struct cgroup_ancestor *skel;
> +	struct bpf_tc_hook qdisc;
> +	struct bpf_tc_opts tc_attach;
> +};
> +
> +static int send_datagram(void)
> +{
> +	unsigned char buf[] = "some random test data";
> +	struct sockaddr_in6 addr = { .sin6_family = AF_INET6,
> +				     .sin6_port = htons(DST_PORT),
> +				     .sin6_scope_id = if_nametoindex(VETH_1) };
> +	int sock, n;
> +
> +	if (!ASSERT_EQ(inet_pton(AF_INET6, DST_ADDR, &addr.sin6_addr), 1,
> +		       "inet_pton"))
> +		return -1;
> +
> +	sock = socket(AF_INET6, SOCK_DGRAM, 0);

sock is leaked.

> +	if (!ASSERT_OK_FD(sock, "create socket"))
> +		return sock;
> +
> +	n = sendto(sock, buf, sizeof(buf), 0, (const struct sockaddr *)&addr,
> +		   sizeof(addr));
> +	if (!ASSERT_EQ(n, sizeof(buf), "send data"))
> +		return n;
> +
> +	return 0;
> +}
> +
> +static int wait_local_ip(void)
> +{
> +	char *ping_cmd = ping_command(AF_INET6);
> +	int i, err;
> +
> +	for (i = 0; i < WAIT_AUTO_IP_MAX_ATTEMPT; i++) {
> +		err = SYS_NOFAIL("%s -c 1 -W 1 %s%%%s", ping_cmd, DST_ADDR,
> +				 VETH_1);
> +		if (!err)
> +			break;
> +	}
> +
> +	return err;
> +}
> +
> +static int setup_network(struct test_data *t)
> +{
> +	int ret;
> +
> +	SYS(fail, "ip link add dev %s type veth peer name %s", VETH_1, VETH_2);
> +	SYS(fail, "ip link set %s up", VETH_1);
> +	SYS(fail, "ip link set %s up", VETH_2);

Same. Do it under a new netns.

> +
> +	ret = wait_local_ip();
> +	if (!ASSERT_EQ(ret, 0, "wait local ip"))
> +		goto fail;
> +
> +	memset(&t->qdisc, 0, sizeof(t->qdisc));
> +	t->qdisc.sz = sizeof(t->qdisc);
> +	t->qdisc.attach_point = BPF_TC_EGRESS;
> +	t->qdisc.ifindex = if_nametoindex(VETH_1);
> +	if (!ASSERT_NEQ(t->qdisc.ifindex, 0, "if_nametoindex"))
> +		goto cleanup_interfaces;
> +	if (!ASSERT_OK(bpf_tc_hook_create(&t->qdisc), "qdisc add"))
> +		goto cleanup_interfaces;
> +
> +	memset(&t->tc_attach, 0, sizeof(t->tc_attach));
> +	t->tc_attach.sz = sizeof(t->tc_attach);
> +	t->tc_attach.prog_fd = bpf_program__fd(t->skel->progs.log_cgroup_id);
> +	if (!ASSERT_OK(bpf_tc_attach(&t->qdisc, &t->tc_attach), "filter add"))
> +		goto cleanup_qdisc;
> +
> +	return 0;
> +
> +cleanup_qdisc:
> +	bpf_tc_hook_destroy(&t->qdisc);
> +cleanup_interfaces:
> +	SYS_NOFAIL("ip link del %s", VETH_1);
> +fail:
> +	return 1;
> +}
> +
> +static void cleanup_network(struct test_data *t)
> +{
> +	bpf_tc_detach(&t->qdisc, &t->tc_attach);
> +	bpf_tc_hook_destroy(&t->qdisc);
> +	/* Deleting first interface will also delete peer interface */
> +	SYS_NOFAIL("ip link del %s", VETH_1);
> +}
> +
> +static void check_ancestors_ids(struct test_data *t)
> +{
> +	__u64 expected_ids[NUM_CGROUP_LEVELS];
> +	char assert_name[MAX_ASSERT_NAME];
> +	__u32 level;
> +
> +	expected_ids[0] = get_cgroup_id("/.."); /* root cgroup */
> +	expected_ids[1] = get_cgroup_id("");
> +	expected_ids[2] = get_cgroup_id(CGROUP_PATH);
> +	expected_ids[3] = 0; /* non-existent cgroup */
> +
> +	for (level = 0; level < NUM_CGROUP_LEVELS; level++) {
> +		snprintf(assert_name, MAX_ASSERT_NAME,
> +			 "ancestor id at level %d", level);
> +		ASSERT_EQ(t->skel->bss->cgroup_ids[level], expected_ids[level],
> +			  assert_name);
> +	}
> +}
> +
> +void test_cgroup_ancestor(void)
> +{
> +	struct test_data t;
> +	int cgroup_fd;
> +
> +	t.skel = cgroup_ancestor__open_and_load();
> +	if (!ASSERT_OK_PTR(t.skel, "open and load"))
> +		return;
> +
> +	if (setup_network(&t))
> +		goto cleanup_progs;
> +
> +	cgroup_fd = cgroup_setup_and_join(CGROUP_PATH);

cgroup_fd is leaked.

Thanks for working on this.

> +	if (cgroup_fd < 0)
> +		goto cleanup_network;
> +
> +	if (send_datagram())
> +		goto cleanup_cgroups;
> +
> +	check_ancestors_ids(&t);
> +
> +cleanup_cgroups:
> +	cleanup_cgroup_environment();
> +cleanup_network:
> +	cleanup_network(&t);
> +cleanup_progs:
> +	cgroup_ancestor__destroy(t.skel);
> +}

