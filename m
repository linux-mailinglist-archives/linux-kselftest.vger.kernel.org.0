Return-Path: <linux-kselftest+bounces-6386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED3B87E68B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 10:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE8C1F21B17
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D80E2D043;
	Mon, 18 Mar 2024 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1XeQo4B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E74A2D042;
	Mon, 18 Mar 2024 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755940; cv=none; b=NvIq8MFQaxo61U19Medg8HpCDp8F2XE1pfRERj6NzegcqhHJdL/WhpFGXJJwwrL3nDM2sHd/D5L/C1fxt5mwEsZavrCWCXSsLRCXKgN8iQEDYeyFvO+lQSJKp0Q0YiniLNCI0tv5A1RMFdn33U27eA+PUZeouEk82KfEnLOJjQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755940; c=relaxed/simple;
	bh=I+VtirlGaO5XQypB/iW+pl/U2DC+1oeoFF1FpJF7WWE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj217CLv1MysgwXzYNPxR+ZLlBQvrdzD6Is3JbF1/cN/TRswIVHk/EYRk+naWvpH8HI1bprupluGvJ1yYXYyOLom2582QGzykVN0hOmcdhaXKu4tAauw3xMi0JBmqnMO5352Iwcpdl83KaHv6BcU/bwjm6CrcVjuafwEMrisCBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1XeQo4B; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46ba1a05e0so108545766b.3;
        Mon, 18 Mar 2024 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710755937; x=1711360737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ONh/xK/jFPgMmE/BPfenaXVIJ3UzwGWaKueLvZY8ZxA=;
        b=b1XeQo4B1HrQMA5BdfI8efye75+6g1BegsVHi4dbuqGajF4g1vYioOtSZGOWDyXDg7
         B+tUUHYUDUZ3dDDUiCX/cypR8xglvriJvDDZwZlzC8G21/K3UeZwFDidaJo943Vihz3P
         kKxgILMaOLOfUKLHKMVGZZzEIZWjndbDefCJsHtd0pfmXZTh3C7pU9e3zns78NJukV+D
         9MeuxECZONy6+UC8H95LcdixswxKAJ4agOr3w/1uX9075L3tIxKZdMNp9y3BQPTahKIV
         Wtkas/MpjzZ0VP3mEHsKw36EX3dUEabyRrsp8p3JdXZEUPjYe3KE/24Tawf3ZPSWhNH2
         cEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710755937; x=1711360737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONh/xK/jFPgMmE/BPfenaXVIJ3UzwGWaKueLvZY8ZxA=;
        b=bClFwOZ99G/TW/2gO4BE/zXzpX5ajJUgg8rZ7KnvgF5WqoNoDmJiYdXuj0SZMCLLr6
         02ei8or6aKIEVVWHP+10aajU5vrOu3LCPFSb51CZMxYuHTJWWIV8rqWmujaMIOTL3VYs
         /NY6LWLD5ZonJofU6XQvu40vuiy9NPGe45dT/3eYCULxxSqqWnftvzMXR5fP0rnAjFDR
         zsUecOXZVjM1fPuz7rxTryfNDjg+AqFMNRQv+ccDEz6tXm53c7NdG+tYXpcBejx9Ru1Z
         HepVvF8NtHhJmrq2E+bOGgtwTe5kuP639PK0efmYxfFmJoMzBw08PoRLb424fTDFAKVT
         M6cw==
X-Forwarded-Encrypted: i=1; AJvYcCXWJp7tzrffQyGRaOILG6dBtj69uAWNk5cmWDE5B3VHHwkv/B8z/DUqfQBc9kq6jlDmg41j2KqOVAyY6Jc92c18hnVZisx5AOybdqGqA2D9oQRF9VSl2sxKKfL6NhdRTyT92ZTC9IYMdWOGb0TYW1tRIz6kh1Ao/CEpfrO1FJtVIyTL
X-Gm-Message-State: AOJu0YyAMk8cTI8aJyitgjwC8qjJsz8r/hHIIgDunP9M5Hcpg/XAgvxg
	V2+ojAfzNJAfzFIVGR4lupwhxKgXsQx6Ea5Fsprqx30Wr7U1Rs3C
X-Google-Smtp-Source: AGHT+IFf9R0j+CpAvFbLb+ddJKp+YmZ/hwEPg2bCmLauAHG/jbNLaduwPmXpBJmxmaYjADdJmKdAvg==
X-Received: by 2002:a17:906:4c4e:b0:a46:d049:6de2 with SMTP id d14-20020a1709064c4e00b00a46d0496de2mr127002ejw.70.1710755936599;
        Mon, 18 Mar 2024 02:58:56 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ef3-20020a17090697c300b00a468c3295d5sm3366846ejb.25.2024.03.18.02.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:58:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 Mar 2024 10:58:54 +0100
To: Jose Fernandez <josef@netflix.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH V2 bpf-next 2/2] selftests/bpf: add selftest for
 bpf_task_get_cgroup
Message-ID: <ZfgQXlU_wKpXScwh@krava>
References: <20240316162241.628855-1-josef@netflix.com>
 <20240316162241.628855-2-josef@netflix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240316162241.628855-2-josef@netflix.com>

On Sat, Mar 16, 2024 at 10:22:41AM -0600, Jose Fernandez wrote:

SNIP

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

nit, you could call test_task_get_cgroup__open_and_load

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

would smaller sleep do? also we have our own usleep (in test_progs.c)
that calls nanosleep

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

could you filter for your pid in here like we do in other places,
(eg in progs/kprobe_multi.c)

in which case you won't need hash map, but just a single value
to store the cgroup id to

jirka

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

