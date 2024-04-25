Return-Path: <linux-kselftest+bounces-8855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1488B21A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 14:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339FE2875E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 12:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CC61386A7;
	Thu, 25 Apr 2024 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgOQJc7D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF91138484;
	Thu, 25 Apr 2024 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048290; cv=none; b=E+kweQdKFqvjphINRBlQ9wE6wgryGFRPbezVo4IdCcXsX1yfK2298xwjtygZoRAlvzmHWGHSf6mP+hn8lyPxFnnWeF1fkdf5pBJ9sh0aHgyKOsiK/V2ISsYG0LVwwarraDqrldhknM+6jSwee3qzMQmhbDzdGSeQcJizF1i34K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048290; c=relaxed/simple;
	bh=NnqLYuiPmxamyrMtPWcohCrbnXsPjkNdRdMe3hkfNhg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6E6ppmlh7f2Nc1ETagDkbTjtw2ekbuzaR7XKPdOvgMI3B8AiXgMwQTz6rDVnz7Om4ZoONfaDtQuZdHU/ksnySCluLV1zktuFP05aFaRPUGvoAxCHhh6RCFFfQT432pSyw+YGs8W4shXt4X5UxzPUG0UQuYeUiU+2IZfgAcFBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgOQJc7D; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so1139633a12.1;
        Thu, 25 Apr 2024 05:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714048287; x=1714653087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mO0EKaMYJlTxWEv8jqnhkmWDvB4xKI7gbxq4S4uH4WQ=;
        b=mgOQJc7DmGDmnQ+cEU6Gfqwz8bPDYtGT4SB78UCIeKwnYeV8rlAXLMISTLmgb60Ip+
         G+lzYGVZtYXVE11w/FB52NVmaiib7bRIi2p8/Tk5KLQmIkMA+fHflctFOsfltMIdggCB
         Fgdhje0KIB1ZDEV9le+Y8htRmJ+ZighTZlnolZ1GHTkWR7fMkBDgbj1Igehv2wCUuvPU
         2kbxpPaGAp1ZxZFLiLHLajxnd0EmxPtpa/k4j3tUPDGLShP3+1QsrUxQmDAlOebVVusu
         Jev0pr7yJOBT8ansbcG4xuKUXD/Yu66vsvPNOM2HLL4Sk1gljuCr76/OezLgFj5tixRu
         fgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714048287; x=1714653087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mO0EKaMYJlTxWEv8jqnhkmWDvB4xKI7gbxq4S4uH4WQ=;
        b=bZ+2N15CVjp/RW4zYsJhQuv48/awkI7CSYCCu2TC2DITpvxlHratXpYUWY2O88PAOe
         AVYtHrvTS/Ya8qDRPu1yyN1RsHootpFD413i9QfGaTrzoW+biq1jJZBnzJEIEDosgLc0
         Src7FvpCWpfCQ3The0SIxXXmdM0EuFq2JKnrnsZMgUpHTMXv3qtTcDeWE8KOgzlj3SMi
         oE/lYyBX1ULIDFYmMstEqRZwgpW+U8dv/Ma3n1i27w4807ZOCfPyJFwLiIWkrUpjCkEn
         aSCx/a+NXmxCdQbPaUVW5WRLWpOJNljhBzFjt2xVy1fC1koMpwVA12I4f03IQROFyQv8
         EtQg==
X-Forwarded-Encrypted: i=1; AJvYcCUZA98Mqt+IMmc6ia50ekDuQQ0R7GLQabWLVLn259zLC9M+SvSag+rFvdyLVOiQ1OwcU3+iH8u0uTDZML/3Wi4kGiGWhamU1p+g2EqQCW6JDur7g9YYYoOx2Lnq52tpnz1h7+AlJbIuoZTPrsJnYllbutDPI2aWgdhnNwJJVK1ETOkH
X-Gm-Message-State: AOJu0YzgmMxp8+C8rK8tVO4Rfk6+BiI27NdhGymOtn5WgFEGVYaiMXxM
	+tjRfVY387f1LCsfIee1Lv59Sypf0b5JlNpqztHbVppf4U2SJC3l
X-Google-Smtp-Source: AGHT+IGSpK4iSQLWgV06frZeBl3VhSXx81bJY3LDjlo0ZC/Yn7Xd4dgOG3sP3+54Eb4svViSnlwc0A==
X-Received: by 2002:a50:ab0c:0:b0:56e:2b31:b111 with SMTP id s12-20020a50ab0c000000b0056e2b31b111mr3689775edc.7.1714048287002;
        Thu, 25 Apr 2024 05:31:27 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id n13-20020a50cc4d000000b005721d18a843sm3220924edi.65.2024.04.25.05.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 05:31:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 Apr 2024 14:31:24 +0200
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
Subject: Re: [PATCH v2] selftests/bpf: Add ring_buffer__consume_n test.
Message-ID: <ZipNHH568oa2zDt9@krava>
References: <20240425073319.75389-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425073319.75389-1-andrea.righi@canonical.com>

On Thu, Apr 25, 2024 at 09:33:19AM +0200, Andrea Righi wrote:
> Add a testcase for the ring_buffer__consume_n() API.
> 
> The test produces multiple samples in a ring buffer, using a
> sys_getpid() fentry prog, and consumes them from user-space in batches,
> rather than consuming all of them greedily, like ring_buffer__consume()
> does.
> 
> Link: https://lore.kernel.org/lkml/CAEf4BzaR4zqUpDmj44KNLdpJ=Tpa97GrvzuzVNO5nM6b7oWd1w@mail.gmail.com
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |  2 +-
>  .../selftests/bpf/prog_tests/ringbuf.c        | 64 +++++++++++++++++++
>  .../selftests/bpf/progs/test_ringbuf_n.c      | 47 ++++++++++++++
>  3 files changed, 112 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_n.c
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
> index 48c5695b7abf..d59500d13a41 100644
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
> @@ -60,6 +61,7 @@ static int process_sample(void *ctx, void *data, size_t len)
>  }
>  
>  static struct test_ringbuf_map_key_lskel *skel_map_key;
> +static struct test_ringbuf_n_lskel *skel_n;

nit, as I wrote in the other email, I think this could be put directly
in the ringbuf_n_subtest function, other than that lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

>  static struct test_ringbuf_lskel *skel;
>  static struct ring_buffer *ringbuf;
>  
> @@ -326,6 +328,66 @@ static void ringbuf_subtest(void)
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

