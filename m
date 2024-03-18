Return-Path: <linux-kselftest+bounces-6382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7852A87E269
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 04:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA6D0B22D2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 03:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA891DFFE;
	Mon, 18 Mar 2024 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="d8zWc7qy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F181DFC7;
	Mon, 18 Mar 2024 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710731465; cv=none; b=gob4I9Y9qO0yykXbRBjHYGMRjXaYl2kY8ccAEk6+ZUk8Z9Tp3CBjZhlcVnaytZ9NyuhXQTrIsMZaExUR3NxKKc9UeQGTkQhzQMPEayKlUDLsc0Bmy/I4wiCADAZuwraRf5F+ITGqqYPwSTngbmnwsqfBPtNDSHyFou8JLNiBr+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710731465; c=relaxed/simple;
	bh=4voy2gFagHbzzgdeYO59y5/rvHXe2ueRFE/fbxvdQR4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mP/Z9YlbQgPPNeIFvcbo3KBpyq1BGeCFPg+DU2xvinPcXjkbsBytuZlpeAwdggD9ovyjaZi84xi5ccEBg6sA6RdTyiDgfRvhQn/1CNmRk7dUsC2aEnNbxGf7nAKWLgAbVYxyqfg7FVjBQtMrDFmeBPuCatV+GAPjFiycqisyqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=d8zWc7qy; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HN1Lro032363;
	Sun, 17 Mar 2024 20:10:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=cG6+Vc30vh6fpJMkXadFZj
	NyMvkJ+uULiCmw0urycys=; b=d8zWc7qy/iTHBvpA8z4A7R1VOJkWIcbT604bhw
	CfhU+aGCTqWQ+aL9TwxIHk57pdiPH9R5VbsDkD8L/GaX8deyB7aqvSyF47R2xD0c
	ftlDVuxwetFIgjLRt0S1gNUgCKQZYPzGdgeCTFQcENtKOzH2M6wklSWfjeRplvbZ
	KydWT6JJuY+CNuX5g/VD4+Y17P9q9/dWb+aMc8m69uwOM0P6AqCNP58Yh3xXwKMJ
	l2ivEjvxz6fyMOvaRS/lrPoa/oSTNUVf2uMEQXMCLAJj/fDi3+U/DgghyMclQxRE
	zHFLDIJHHAVtkd0Sj7QdiOMbB9jGfiXsSW2qm1binTDFXv3g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ww8skkqvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Mar 2024 20:10:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 17 Mar 2024 20:10:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Sun, 17 Mar 2024 20:10:31 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 51C6D3F7067;
	Sun, 17 Mar 2024 20:10:26 -0700 (PDT)
Date: Mon, 18 Mar 2024 08:40:25 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jose Fernandez <josef@netflix.com>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend
	<john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH V2 bpf-next 2/2] selftests/bpf: add selftest for
 bpf_task_get_cgroup
Message-ID: <20240318031025.GA1312616@maili.marvell.com>
References: <20240316162241.628855-1-josef@netflix.com>
 <20240316162241.628855-2-josef@netflix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240316162241.628855-2-josef@netflix.com>
X-Proofpoint-ORIG-GUID: v9sscJHqEs07l4SXiZdLi2Ef7gDeQ64Q
X-Proofpoint-GUID: v9sscJHqEs07l4SXiZdLi2Ef7gDeQ64Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02

On 2024-03-16 at 21:52:41, Jose Fernandez (josef@netflix.com) wrote:
> This patch adds a selftest for the `bpf_task_get_cgroup` kfunc. The test
> focuses on the use case of obtaining the cgroup ID of the previous task
> in a `sched_switch` tracepoint.
>
> The selftest involves creating a test cgroup, attaching a BPF program
> that utilizes the `bpf_task_get_cgroup` during a `sched_switch`
> tracepoint, and validating that the obtained cgroup ID for the previous
> task matches the expected cgroup ID.
>
> Signed-off-by: Jose Fernandez <josef@netflix.com>
> Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
> ---
> V1 -> V2: Refactor test to work with a cgroup pointer instead of the ID
>
>  .../bpf/prog_tests/task_get_cgroup.c          | 58 +++++++++++++++++++
>  .../bpf/progs/test_task_get_cgroup.c          | 37 ++++++++++++
>  2 files changed, 95 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_task_get_cgroup.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c b/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
> new file mode 100644
> index 000000000000..67ed65d0c461
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright 2024 Netflix, Inc.
> +
> +#include <test_progs.h>
> +#include <cgroup_helpers.h>
> +#include "test_task_get_cgroup.skel.h"
> +#include <unistd.h>
> +
> +#define TEST_CGROUP "/test-task-get-cgroup/"
> +
> +void test_task_get_cgroup(void)
> +{
> +	struct test_task_get_cgroup *skel;
> +	int err, fd;
> +	pid_t pid;
> +	__u64 cgroup_id, expected_cgroup_id;
> +	const struct timespec req = {
> +		.tv_sec = 1,
> +		.tv_nsec = 0,
> +	};
Reverse Xmas tree.

> +
> +	fd = test__join_cgroup(TEST_CGROUP);
> +	if (!ASSERT_OK(fd < 0, "test_join_cgroup_TEST_CGROUP"))
> +		return;
> +
> +	skel = test_task_get_cgroup__open();
> +	if (!ASSERT_OK_PTR(skel, "test_task_get_cgroup__open"))
> +		goto cleanup;
> +
> +	err = test_task_get_cgroup__load(skel);
> +	if (!ASSERT_OK(err, "test_task_get_cgroup__load"))
> +		goto cleanup;
> +
> +	err = test_task_get_cgroup__attach(skel);
> +	if (!ASSERT_OK(err, "test_task_get_cgroup__attach"))
> +		goto cleanup;
> +
> +	pid = getpid();
> +	expected_cgroup_id = get_cgroup_id(TEST_CGROUP);
> +	if (!ASSERT_GT(expected_cgroup_id, 0, "get_cgroup_id"))
> +		goto cleanup;
> +
> +	/* Trigger nanosleep to enter the sched_switch tracepoint */
> +	/* The previous task should be this process */
> +	syscall(__NR_nanosleep, &req, NULL);
> +
> +	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.pid_to_cgid_map), &pid,
> +				  &cgroup_id);
> +
> +	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
> +		goto cleanup;
> +
> +	ASSERT_EQ(cgroup_id, expected_cgroup_id, "cgroup_id");
> +
> +cleanup:
> +	test_task_get_cgroup__destroy(skel);
> +	close(fd);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c b/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c
> new file mode 100644
> index 000000000000..580f8f0657d5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright 2024 Netflix, Inc.
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +struct cgroup *bpf_task_get_cgroup(struct task_struct *task) __ksym;
> +void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 4096);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} pid_to_cgid_map SEC(".maps");
> +
> +SEC("tp_btf/sched_switch")
> +int BPF_PROG(sched_switch, bool preempt, struct task_struct *prev,
> +	     struct task_struct *next)
> +{
> +	struct cgroup *cgrp;
> +	u64 cgroup_id;
> +	u32 pid;
> +
> +	cgrp = bpf_task_get_cgroup(prev);
> +	if (cgrp == NULL)
> +		return 0;
> +	cgroup_id = cgrp->kn->id;
> +	pid = prev->pid;
> +	bpf_map_update_elem(&pid_to_cgid_map, &pid, &cgroup_id, BPF_ANY);
> +
> +	bpf_cgroup_release(cgrp);
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.40.1
>

