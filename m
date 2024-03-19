Return-Path: <linux-kselftest+bounces-6411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D362E87F497
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 01:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629171F21CAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 00:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC59018D;
	Tue, 19 Mar 2024 00:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="hioRiCan"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F773D6A
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Mar 2024 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808259; cv=none; b=S1YfiD5zLOSJRFw1APyX8Zb+S32n7/ln8034KXUtSfDYr3vzdhHeDZZDAkPSpK9rdeJt9Q5WZvWonu8kPZr3YR6R0wfHaBRisUTH/kS/uAPmzBFXvFwcGQ3rGMUDM7aMtJW4PoaG7opUIBi0WaHW67VZ2rzriaIlSlskijtRDXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808259; c=relaxed/simple;
	bh=8DfVubo4KjNWHw2+1Glu8UP/tZQT++5v3hFkpgpZ4Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsNFRGAuoPJpG/Bsr3fx7HtsbcJ56yL8HWA+JuekBn+oxNfFWHCJ3wSKFD1sk3JSaEj5Ipe59rNma9RcK9fe6twcGeboOheSi26e5S0Ngpk9BD0ENK3tyh0sLGtfsG9uk0dfqIOZ14NJTTy5MWbKqCZKgG6pbPlZmetf5qg34IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=hioRiCan; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dee5ef2a7bso33000455ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Mar 2024 17:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1710808257; x=1711413057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dX5+kGt94i8LgMCxRW3yMQ+Kn76GryytdXFaAC5Pwhc=;
        b=hioRiCanH4L0PUR3MthXneI8Mg6RopWapzyK5OBNG75ES51W11rhFOeYCVD2lpneuI
         +rWCt9VwWPQ5mnK/dL7ZeYiQfmssFYF+XxU4Japfx8UA/3yVeN+Ey/SBKCIjQlLOxUBL
         UCL5uwfvGaBXU/8nh8/5xNFfuide5nzwTPefo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710808257; x=1711413057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dX5+kGt94i8LgMCxRW3yMQ+Kn76GryytdXFaAC5Pwhc=;
        b=BuT1Z2OY1IRCe5i500VjTughe5Yulmx6GAgVUXJjNXo3EPgDDYAC8qX5W1zmB3e7+5
         2bpceyEqZEjsplI/yIIzjbKl7aONN/1fqyGQncCajpjZOEu7QK7DIBJsHVDs7Ds6oZC1
         aweCkTDGoNnkQRPBTWiHwpi9j6LHIA16Mm806/vaTvWdDQiB+qjPyFP6ynJZ222kGdWJ
         y1ruH48rdqYlnxVfOJSa7H1LDWOUpKg4Z2FfhAZzc+RAerdenJbnmJcp9MR/PrBXAtZV
         cjzyrM3ZJHCvTkocAAvcC6PW6jRUuHzEtJiKUtsA4BMbIMB15v9dmBWZdZkHOWHDjpgf
         DgSA==
X-Forwarded-Encrypted: i=1; AJvYcCVGvE19RjCb0PN4YcbGfCzRoi1rHu/WWlxw0hmqAttrmKSRwpmmwdzSKmEllsXQQanWFcwEFBJMB6pOdn8tUYEjcBmrEiM1D7ENkxk0R7mi
X-Gm-Message-State: AOJu0YyEk55tzav90jIXZK0VwYJtnRjWhJqZ/wDH+XJ23ye8qvgO43iM
	5ANRv5gl6jh1TPvky2m7oA8FvIjGLTT13RGZomuxFJnpKTCxVZ8Fdth7S5dWz38=
X-Google-Smtp-Source: AGHT+IG6UAZkCVAh0gLOZ+HwUvODQs/BjE7k2nfUF76GedDJUZnBHYF3RE854UocPj9mHspVEHt3IA==
X-Received: by 2002:a17:902:ecc9:b0:1de:f3bf:a47a with SMTP id a9-20020a170902ecc900b001def3bfa47amr13747269plh.9.1710808257419;
        Mon, 18 Mar 2024 17:30:57 -0700 (PDT)
Received: from localhost ([2607:fb10:7301::3])
        by smtp.gmail.com with UTF8SMTPSA id 13-20020a170902ee4d00b001dd7d66aa18sm9884535plo.67.2024.03.18.17.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 17:30:56 -0700 (PDT)
Date: Mon, 18 Mar 2024 18:30:54 -0600
From: Jose Fernandez <josef@netflix.com>
To: Jiri Olsa <olsajiri@gmail.com>
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
Message-ID: <20240319003054.tegzffeydaec45ql@SlimPro9i>
References: <20240316162241.628855-1-josef@netflix.com>
 <20240316162241.628855-2-josef@netflix.com>
 <ZfgQXlU_wKpXScwh@krava>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfgQXlU_wKpXScwh@krava>

On 24/03/18 10:58AM, Jiri Olsa wrote:
> On Sat, Mar 16, 2024 at 10:22:41AM -0600, Jose Fernandez wrote:
> 
> SNIP
> 
> > +void test_task_get_cgroup(void)
> > +{
> > +	struct test_task_get_cgroup *skel;
> > +	int err, fd;
> > +	pid_t pid;
> > +	__u64 cgroup_id, expected_cgroup_id;
> > +	const struct timespec req = {
> > +		.tv_sec = 1,
> > +		.tv_nsec = 0,
> > +	};
> > +
> > +	fd = test__join_cgroup(TEST_CGROUP);
> > +	if (!ASSERT_OK(fd < 0, "test_join_cgroup_TEST_CGROUP"))
> > +		return;
> > +
> > +	skel = test_task_get_cgroup__open();
> > +	if (!ASSERT_OK_PTR(skel, "test_task_get_cgroup__open"))
> > +		goto cleanup;
> > +
> > +	err = test_task_get_cgroup__load(skel);
> > +	if (!ASSERT_OK(err, "test_task_get_cgroup__load"))
> > +		goto cleanup;
> 
> nit, you could call test_task_get_cgroup__open_and_load

I'll rename.

> > +
> > +	err = test_task_get_cgroup__attach(skel);
> > +	if (!ASSERT_OK(err, "test_task_get_cgroup__attach"))
> > +		goto cleanup;
> > +
> > +	pid = getpid();
> > +	expected_cgroup_id = get_cgroup_id(TEST_CGROUP);
> > +	if (!ASSERT_GT(expected_cgroup_id, 0, "get_cgroup_id"))
> > +		goto cleanup;
> > +
> > +	/* Trigger nanosleep to enter the sched_switch tracepoint */
> > +	/* The previous task should be this process */
> > +	syscall(__NR_nanosleep, &req, NULL);
> 
> would smaller sleep do? also we have our own usleep (in test_progs.c)
> that calls nanosleep

Yes a smaller sleep should be fine.
I'll reduce the sleep and use the usleep helper.

> > +
> > +	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.pid_to_cgid_map), &pid,
> > +				  &cgroup_id);
> > +
> > +	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
> > +		goto cleanup;
> > +
> > +	ASSERT_EQ(cgroup_id, expected_cgroup_id, "cgroup_id");
> > +
> > +cleanup:
> > +	test_task_get_cgroup__destroy(skel);
> > +	close(fd);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c b/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c
> > new file mode 100644
> > index 000000000000..580f8f0657d5
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c
> > @@ -0,0 +1,37 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright 2024 Netflix, Inc.
> > +
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +struct cgroup *bpf_task_get_cgroup(struct task_struct *task) __ksym;
> > +void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
> > +
> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_HASH);
> > +	__uint(max_entries, 4096);
> > +	__type(key, __u32);
> > +	__type(value, __u64);
> > +} pid_to_cgid_map SEC(".maps");
> > +
> > +SEC("tp_btf/sched_switch")
> > +int BPF_PROG(sched_switch, bool preempt, struct task_struct *prev,
> > +	     struct task_struct *next)
> > +{
> > +	struct cgroup *cgrp;
> > +	u64 cgroup_id;
> > +	u32 pid;
> > +
> 
> could you filter for your pid in here like we do in other places,
> (eg in progs/kprobe_multi.c)
> 
> in which case you won't need hash map, but just a single value
> to store the cgroup id to
> 
> jirka

I'll apply this suggestion as well and include it in V3. 
Thanks for the feedback.

> 
> > +	cgrp = bpf_task_get_cgroup(prev);
> > +	if (cgrp == NULL)
> > +		return 0;
> > +	cgroup_id = cgrp->kn->id;
> > +	pid = prev->pid;
> > +	bpf_map_update_elem(&pid_to_cgid_map, &pid, &cgroup_id, BPF_ANY);
> > +
> > +	bpf_cgroup_release(cgrp);
> > +	return 0;
> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
> > -- 
> > 2.40.1
> > 

