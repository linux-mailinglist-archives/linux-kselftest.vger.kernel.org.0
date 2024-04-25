Return-Path: <linux-kselftest+bounces-8871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3058B276C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 19:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550911F24874
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 17:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6A314E2E3;
	Thu, 25 Apr 2024 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcbg9PHG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF514D718;
	Thu, 25 Apr 2024 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065328; cv=none; b=U48KlzWleczYMG5SWYWgntlweldu1vtBfpSYjMGPFAhfPf58duYFjDpar9zD9vin1iKNXDUBnyfi23he2F5OaJjHCO2W7vxEqP3J9ddrvzX4sR9iUGUycevU4OZ3z9cdmHcALni/AaBTICwTcJh8+Kh2OaV3v73wwNOE/1+UiiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065328; c=relaxed/simple;
	bh=2xQDR6NFZCtXF7RpfS+uji8N/vLY4TVqhQZO8U0feO8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtA1NPWLlqtOJcGPQwj45yD6LbfUfz2EdADEjyHnj2QKz9aYQ0Ff2S4+YluA/idA+QzJZROnSgimJE3BdeJ637mFVsahz5cb2UWIDbUvwgwErkwehRqHsANvtQs3yEx8KUy/1LUSn+sf1XmQpyZ/bskzG6l682MVfZ/5KKcr9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcbg9PHG; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso1528095e87.3;
        Thu, 25 Apr 2024 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714065325; x=1714670125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDfFIP9QiMHYxpbImeHAGt5krbC7PZbjLfYtRfH7qbA=;
        b=mcbg9PHGaRGI7CgKEA+WcLqm/p4uALGiPFbk4vbRJb+VI92Mr0quZsdRbE7AF/uOSs
         rSrir14+vFwS8fkO5DOz6MCJzkT2jZp7FYCuhTiSYz9T+cz+O4PjWXDsgosJhL2TlZ7q
         zyFX9MQxb9tiViWjS5J60JWpnfJ1lL8L4KZXR7GRz1mIdu3gywp++stIonXnFAVFpMfF
         FuPloKVmtJpGFYIZXIYLMstI1X/y9BRPD5fc2odlsIzjMPfWjDxsLwsv8InuEwpMw9at
         AgUH8kUnqbBEmiAT++0wjemjFudUYP1LEda8q1TMsiaZu/cVQVh1Rzdj6Mgnyh7ah4YL
         LVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714065325; x=1714670125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDfFIP9QiMHYxpbImeHAGt5krbC7PZbjLfYtRfH7qbA=;
        b=StFOAeeNBbZS0dExrv4ZBvW5K9A+g8gEDh2IfSu+yl7UxrNU2OiD+ugldltDqfZSKM
         6G/jh6PS4oSSarSszTPVOolts6Z0ZuaaEado83CieMtY9vFvLoz+gEu3KU4716L2naPz
         23xRoIDh4YxKrzLKI2o9DZVHWksdQfA5SiSLLEVow13wXB6cz3y3ZB0e71J6r1cnwukI
         +RSjMy5LUq7aXHFFsL5BMHB9Q7oFqFLh4jQaTbEuBQgsonKGSbSMWG7QvUnH/mYvEf1F
         KETvk3ZTgQtjML6x99SwwlA97iXc7f61tKQvcdLKPs7NxG88gzaMxgavRs4vzvg72k/Z
         70gA==
X-Forwarded-Encrypted: i=1; AJvYcCVWd7v+aTtOZhJrRHwV9NbjePqO6dpNvMRqy7s18VTZK/M+5Zn89nlmLBR+BkfauQ7MSu1BEPK544em5JWDpU/v/M/x7hZtaVckjWaCw6ew1jfebFeNgU4ltgNILLZ/bRItE/q483mo4pMAIyHG4+IFvJ9k2sgesBhVx+lMwqp7y0m7
X-Gm-Message-State: AOJu0YwNmi53inPtJ8hfgdtn2fSuC5EwtEPPSKIlW6dKbAfI9mxNOymv
	XpGPh9MUZy+DSnZVbd5ap0Cr3gVFM+BoP/MfgrGo/0dXzekNFYtW
X-Google-Smtp-Source: AGHT+IElR1C/Z2Be7tJG3CYWLnhU8+BKLNDALkpbBtJNqpLWZEpJsf2yzO8L//p9AuofBMVszJ8+jQ==
X-Received: by 2002:a05:6512:3606:b0:51b:400a:7d8d with SMTP id f6-20020a056512360600b0051b400a7d8dmr3838768lfs.68.1714065324325;
        Thu, 25 Apr 2024 10:15:24 -0700 (PDT)
Received: from krava ([2a00:102a:4022:13b8:3d99:aea7:b18a:a8d7])
        by smtp.gmail.com with ESMTPSA id h8-20020aa7c948000000b0057204902580sm5147729edt.48.2024.04.25.10.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 10:15:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 Apr 2024 19:15:20 +0200
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] selftests/bpf: Add ring_buffer__consume_n test.
Message-ID: <ZiqPqEIBNEwPO2Am@krava>
References: <20240425140627.112728-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425140627.112728-1-andrea.righi@canonical.com>

On Thu, Apr 25, 2024 at 04:06:27PM +0200, Andrea Righi wrote:
> Add a testcase for the ring_buffer__consume_n() API.
> 
> The test produces multiple samples in a ring buffer, using a
> sys_getpid() fentry prog, and consumes them from user-space in batches,
> rather than consuming all of them greedily, like ring_buffer__consume()
> does.
> 
> Link: https://lore.kernel.org/lkml/CAEf4BzaR4zqUpDmj44KNLdpJ=Tpa97GrvzuzVNO5nM6b7oWd1w@mail.gmail.com
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/Makefile          |  2 +-
>  .../selftests/bpf/prog_tests/ringbuf.c        | 64 +++++++++++++++++++
>  .../selftests/bpf/progs/test_ringbuf_n.c      | 47 ++++++++++++++
>  3 files changed, 112 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_n.c
> 
> ChangeLog v2 -> v3:
>  - move skel_n inside ringbuf_n_subtest()
> 
> ChangeLog v1 -> v2:
>  - replace CHECK() with ASSERT_EQ()
>  - fix skel -> skel_n
>  - drop unused "seq" field from struct sample
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index edc73f8f5aef..6332277edeca 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -455,7 +455,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
>  LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
>  	trace_printk.c trace_vprintk.c map_ptr_kern.c 			\
>  	core_kern.c core_kern_overflow.c test_ringbuf.c			\
> -	test_ringbuf_map_key.c
> +	test_ringbuf_n.c test_ringbuf_map_key.c
>  
>  # Generate both light skeleton and libbpf skeleton for these
>  LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> index 48c5695b7abf..2f064d6952f0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> @@ -13,6 +13,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/ring_buffer.h>
>  #include "test_ringbuf.lskel.h"
> +#include "test_ringbuf_n.lskel.h"
>  #include "test_ringbuf_map_key.lskel.h"
>  
>  #define EDONE 7777
> @@ -326,6 +327,67 @@ static void ringbuf_subtest(void)
>  	test_ringbuf_lskel__destroy(skel);
>  }
>  
> +/*
> + * Test ring_buffer__consume_n() by producing N_TOT_SAMPLES samples in the ring
> + * buffer, via getpid(), and consuming them in chunks of N_SAMPLES.
> + */
> +#define N_TOT_SAMPLES	32
> +#define N_SAMPLES	4
> +
> +/* Sample value to verify the callback validity */
> +#define SAMPLE_VALUE	42L
> +
> +static int process_n_sample(void *ctx, void *data, size_t len)
> +{
> +	struct sample *s = data;
> +
> +	ASSERT_EQ(s->value, SAMPLE_VALUE, "sample_value");
> +
> +	return 0;
> +}
> +
> +static void ringbuf_n_subtest(void)
> +{
> +	struct test_ringbuf_n_lskel *skel_n;
> +	int err, i;
> +
> +	skel_n = test_ringbuf_n_lskel__open();
> +	if (!ASSERT_OK_PTR(skel_n, "test_ringbuf_n_lskel__open"))
> +		return;
> +
> +	skel_n->maps.ringbuf.max_entries = getpagesize();
> +	skel_n->bss->pid = getpid();
> +
> +	err = test_ringbuf_n_lskel__load(skel_n);
> +	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
> +		goto cleanup;
> +
> +	ringbuf = ring_buffer__new(skel_n->maps.ringbuf.map_fd,
> +				   process_n_sample, NULL, NULL);
> +	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
> +		goto cleanup;
> +
> +	err = test_ringbuf_n_lskel__attach(skel_n);
> +	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__attach"))
> +		goto cleanup_ringbuf;
> +
> +	/* Produce N_TOT_SAMPLES samples in the ring buffer by calling getpid() */
> +	skel_n->bss->value = SAMPLE_VALUE;
> +	for (i = 0; i < N_TOT_SAMPLES; i++)
> +		syscall(__NR_getpgid);
> +
> +	/* Consume all samples from the ring buffer in batches of N_SAMPLES */
> +	for (i = 0; i < N_TOT_SAMPLES; i += err) {
> +		err = ring_buffer__consume_n(ringbuf, N_SAMPLES);
> +		ASSERT_EQ(err, N_SAMPLES, "rb_consume");
> +	}
> +
> +cleanup_ringbuf:
> +	ring_buffer__free(ringbuf);
> +cleanup:
> +	test_ringbuf_n_lskel__destroy(skel_n);
> +}
> +
>  static int process_map_key_sample(void *ctx, void *data, size_t len)
>  {
>  	struct sample *s;
> @@ -384,6 +446,8 @@ void test_ringbuf(void)
>  {
>  	if (test__start_subtest("ringbuf"))
>  		ringbuf_subtest();
> +	if (test__start_subtest("ringbuf_n"))
> +		ringbuf_n_subtest();
>  	if (test__start_subtest("ringbuf_map_key"))
>  		ringbuf_map_key_subtest();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_n.c b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
> new file mode 100644
> index 000000000000..8669eb42dbe0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2024 Andrea Righi <andrea.righi@canonical.com>
> +
> +#include <linux/bpf.h>
> +#include <sched.h>
> +#include <unistd.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#define TASK_COMM_LEN 16
> +
> +struct sample {
> +	int pid;
> +	long value;
> +	char comm[16];
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_RINGBUF);
> +} ringbuf SEC(".maps");
> +
> +int pid = 0;
> +long value = 0;
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int test_ringbuf_n(void *ctx)
> +{
> +	int cur_pid = bpf_get_current_pid_tgid() >> 32;
> +	struct sample *sample;
> +
> +	if (cur_pid != pid)
> +		return 0;
> +
> +	sample = bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
> +	if (!sample)
> +		return 0;
> +
> +	sample->pid = pid;
> +	sample->value = value;
> +	bpf_get_current_comm(sample->comm, sizeof(sample->comm));
> +
> +	bpf_ringbuf_submit(sample, 0);
> +
> +	return 0;
> +}
> -- 
> 2.43.0
> 

