Return-Path: <linux-kselftest+bounces-6418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D10987FDF1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 14:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73AA1F2297D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360DC3FBB9;
	Tue, 19 Mar 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yoyj1Ahn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFFD7F7C1;
	Tue, 19 Mar 2024 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853250; cv=none; b=TZFRIDb6sXM+BV2wuIpzrQnjPHJUfyPX6caATFd45CoqF977KpoWyZy4OVnMKCq7H3O8DtsbjuXNcVfpnHSA1YApYeNy/yz5/Q/C/wmsamy1qg4OA9/gMbcCODkfC82Xa9ILANBWvt/3nsmFpPDHunOrbtp3GgHroLtVd3LhXKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853250; c=relaxed/simple;
	bh=jdQKmmzqzwh98Iw0dr9vu1w/LhZiXOcHFPjsdzHyLTo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUzgkaOpXI0AmmmRt5afNup6Fk3/4cVG4m/Xv5iWBg8Fg/GZhiU+ojAHE4OR0rjT8bGnjVJBbtyKR7sZyOKjL/57rBMBh90a0nrN7+5FkkKzRbrYAFCjbFU7unlxQlu4I2D51JI1cagcgyETwrZFJo4b+bt+JKnjEp4VzBSumHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yoyj1Ahn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41465864644so3242835e9.0;
        Tue, 19 Mar 2024 06:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710853246; x=1711458046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QEQcU4Am6cFlGB3h7vopamQ/UuLga+7FMVkz+H+gtzs=;
        b=Yoyj1AhnMDIMEl6mnO0sjiAtlti83RdokXokPZoJoaUYok7HYSbkJgmwPaQdSqLs7d
         y/AqjKI0AJTpKzdq2W3TgMhjTOEZ2FR3Ad6qE/jzFfogHabkxC33zY7+GVzwCQbP8U8p
         dV53zNjYZ9HKH3OqkbObuEpzVA9GZDc/uHdj54hunUGJ2vjyX4FxJxAmJr2mO7CTQngp
         w90pNnle/yopinIBY2jOvuGLbmX/OoZ7bs7+cX1JyJ0QUpVCiTAfwAODIO1bCfLeu/M1
         ICQ3wSfeFzttxs3uSuQHykSlS04Yic8ZblyXOVS/gniYVHdxfLo+b2ShgbkwG+aTsEgq
         TtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710853246; x=1711458046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEQcU4Am6cFlGB3h7vopamQ/UuLga+7FMVkz+H+gtzs=;
        b=QyyzATMDMPsZpzRZv92+pOBSKPLJi0nQGuwiw6b/aXJVJv/+GXxeJsDc7fkHyKDfvx
         5zID/aHV8dpETmbIHbqOcfyMCYRyuDKcLXp8hWGkrwhhWLyIBPtykkg6MEyiMTf8xOjD
         sN8q6MoENJ3wazPCm1NhKzfRTN03YRv4j1JOJCT/BR6EckPT6AKSThuLa1xeoIpkBw8E
         VT+biD2lH0szaiXoR/FJ2yeynxO4hbxisgS78Ex/fcE0o3+nGFvLYkvSd9rN145MJ4ly
         6bDfTN/qIdmBwqJli2U9dG8cuc2bdgSTBmWnafsaNRcr+RXzFGLghgg17Aex6CxHJhRQ
         dfyA==
X-Forwarded-Encrypted: i=1; AJvYcCWkB0e6jV7AlvyQ83+9lWSl66+konbWrU7Z1+z968AgLBFwveswy8lHPxGLpehHpcRuWT/3rOp9apdZS3yeEdLjebJAHqOffB8TMbQKnJujQNX4MshPhMcLM80p9C8tLqEMpXN+QN7pqhw9SEOuAYKAxPSjMJ15XxQF1bkBUeTUucJD
X-Gm-Message-State: AOJu0YzKJ1vKoFuUaseB6I/ylVk4cVslsaujDosm8G3IqjBt3FCGJfmt
	n5ln9KPs/tsJZXyc25cvPhL/NaIG7gm73imGGF4evciJ969+fivo
X-Google-Smtp-Source: AGHT+IFGIUP/QaL+wCVy8GPtZXKoxIZupQ2sU/3RlZviZI1ux+zNETztYhQ3LeQQz4crdr1+3LuPJA==
X-Received: by 2002:a05:600c:1c27:b0:414:f4:c6c0 with SMTP id j39-20020a05600c1c2700b0041400f4c6c0mr2052280wms.20.1710853245765;
        Tue, 19 Mar 2024 06:00:45 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id fk5-20020a05600c0cc500b0041468b3b84dsm447258wmb.13.2024.03.19.06.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 06:00:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Mar 2024 14:00:41 +0100
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
Subject: Re: [PATCH V3 bpf-next 2/2] selftests/bpf: add selftest for
 bpf_task_get_cgroup
Message-ID: <ZfmMeTZ5HO3jXq9_@krava>
References: <20240319050302.1085006-1-josef@netflix.com>
 <20240319050302.1085006-2-josef@netflix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319050302.1085006-2-josef@netflix.com>

On Mon, Mar 18, 2024 at 11:03:02PM -0600, Jose Fernandez wrote:
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

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
> V2 -> v3: Use _open_and_load(), usleep helper, and drop map usage
> V1 -> V2: Refactor test to work with a cgroup pointer instead of the ID
> 
>  .../bpf/prog_tests/task_get_cgroup.c          | 43 +++++++++++++++++++
>  .../bpf/progs/test_task_get_cgroup.c          | 32 ++++++++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_task_get_cgroup.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c b/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
> new file mode 100644
> index 000000000000..031623067e7e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
> @@ -0,0 +1,43 @@
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
> +	__u64 expected_cgroup_id;
> +
> +	fd = test__join_cgroup(TEST_CGROUP);
> +	if (!ASSERT_OK(fd < 0, "test_join_cgroup_TEST_CGROUP"))
> +		return;
> +
> +	skel = test_task_get_cgroup__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "test_task_get_cgroup__open_and_load"))
> +		goto cleanup;
> +
> +	err = test_task_get_cgroup__attach(skel);
> +	if (!ASSERT_OK(err, "test_task_get_cgroup__attach"))
> +		goto cleanup;
> +
> +	skel->bss->pid = getpid();
> +	expected_cgroup_id = get_cgroup_id(TEST_CGROUP);
> +	if (!ASSERT_GT(expected_cgroup_id, 0, "get_cgroup_id"))
> +		goto cleanup;
> +
> +	/* Trigger nanosleep to enter the sched_switch tracepoint */
> +	/* The previous task should be this process */
> +	usleep(100);
> +
> +	ASSERT_EQ(skel->bss->cgroup_id, expected_cgroup_id, "cgroup_id");
> +
> +cleanup:
> +	test_task_get_cgroup__destroy(skel);
> +	close(fd);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c b/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c
> new file mode 100644
> index 000000000000..30d4499c6bc5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c
> @@ -0,0 +1,32 @@
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
> +int pid = 0;
> +u64 cgroup_id = 0;
> +
> +SEC("tp_btf/sched_switch")
> +int BPF_PROG(sched_switch, bool preempt, struct task_struct *prev,
> +	     struct task_struct *next)
> +{
> +	struct cgroup *cgrp;
> +
> +	if (prev->pid != pid)
> +		return 0;
> +
> +	cgrp = bpf_task_get_cgroup(prev);
> +	if (cgrp == NULL)
> +		return 0;
> +	cgroup_id = cgrp->kn->id;
> +
> +	bpf_cgroup_release(cgrp);
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.40.1
> 

