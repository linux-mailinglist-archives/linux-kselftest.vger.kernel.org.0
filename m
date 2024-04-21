Return-Path: <linux-kselftest+bounces-8586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4E48AC129
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 22:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A1F280C9C
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 20:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ED942057;
	Sun, 21 Apr 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxdGJcjn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533B79FD;
	Sun, 21 Apr 2024 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713730300; cv=none; b=kkWeRd72Xr8LbSWvmy99XtufEv4+4w7OqOd/zWlH+hmGOOPe/OqjmjIuFTg2OexfcnZ+QNpTCgRVqVyFRQjXIzSBheBxovdjz+C1O56HYPpC92z9jXfJwUU2C0ibDzWpfdbddXuPeyl3NmNIyLfyj2EiY5vJ0/cMgbEx1sMnYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713730300; c=relaxed/simple;
	bh=t2o17rLSe++urX4SU4i5hevvE/YgLFP38Y7QNFWRusQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bU5EHvFF4O99GqhYRbMlv8ESMKq0UvwuwIGztLKvXc8+eZpDhrMjV7WlyykSLgxa9T8RaqM4LcnghtCctdJx/zqKGt9dTOX+JOeNDWkAU1QLIvuZw36f1XkUfuUXOOns14/gGS0w6JKCh+uOJZ2FfqZR3JdJw5g+3D0H3dPEdf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxdGJcjn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso15330515e9.2;
        Sun, 21 Apr 2024 13:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713730297; x=1714335097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JXVu37VABeK4P83h3UsDVma3/BTYLFUhb8L1GTMIPrw=;
        b=VxdGJcjnmDfUG5+jKwB8g9qYbph+Wp/4z4+ZN5lRyPDPfFIfimeq/IBEzzAngabKK+
         bvhqxtIt3SJyiuZUJnOBQ4lphc5bkWHYS91bbK3jq8yISGi5678cab0MbKlEizhy8QYD
         /6dAg/0FG1E9YelnuENoCNuH7j8oGujurzrNipq02BUf3PiUrwwLf/Ro4RI0erAoAD8R
         OpwD4rTFYdcdEE9IuEt8VWL3qAH3VLsXHr8kJOyEDNHIHkg4DArFJT7ydqwpRu80VlIk
         GxHov4ETR3fy/jk0IQInZTLRmAAfcaNT2QL5Fi2rMSKnW8t2zfDMqSnGtbOBKs6gSY5k
         ESIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713730297; x=1714335097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXVu37VABeK4P83h3UsDVma3/BTYLFUhb8L1GTMIPrw=;
        b=qbnhDp/HFQsiWeWQNgpwyHx277S0HgbITm1ll7/GfFJrAtlPolICHX6pWJPJLI52I2
         BX11bj+F/yzb78eg+6pSv+4JYVAOR5opdR4tDkIEsXRan7c8g4Z9RJ6L+fIg29pCxtKB
         bqfGyzseyUVSNx4hLW2FCz+K2p636OxjLGizwiT3yVCG+Z3FRGnRS3KEw8G2uFG5GB+e
         Rl84/NDpB0RutmQqIkFMDszlTLyvOMyFsqoOTtYkrhdwqr8l6xYrLG01UVCYSzGLeHXL
         cSUTwJkReU2CcHM65FcxM3ED/z5/lm8ACrvJRg9J7Db6Lt8f0GYS1mNVYki1nIyTvJRc
         7Deg==
X-Forwarded-Encrypted: i=1; AJvYcCVHZG5ShZZ7x+T9T1Jgwr6Vsr5geBLRySfM03zPsiouH/pwtsbh0BvkaDCA2FlnTUOBeSQhVBIdA9w+8zgcEOk6I1SnCtjf5p//RAQKmjCXKfEm7sC/M54osXca30HELjV/CSCIKLg+zfDMig7ebNwW1uJKsB0bwawWvbS8Uvh8FqgX
X-Gm-Message-State: AOJu0YzI7O3jKHYxjj4XnTUjt4zoXRYg8bcgqyLCtTE7SdHV7Hsc6h9Z
	dv+SU2hSqYcx+RPHviu3HQkWK4Cuc+JTAVypXV4BpVuy4fyGRXHh
X-Google-Smtp-Source: AGHT+IE82YXTNvlh1Eiz1wzOklKZhSo74I21CZGNQRGXTIzoskPyWkAaPXH4xF73p4G/n8DnE1GSOQ==
X-Received: by 2002:a05:600c:310d:b0:41a:6209:aa03 with SMTP id g13-20020a05600c310d00b0041a6209aa03mr330770wmo.2.1713730296635;
        Sun, 21 Apr 2024 13:11:36 -0700 (PDT)
Received: from krava ([83.240.61.103])
        by smtp.gmail.com with ESMTPSA id ay33-20020a05600c1e2100b0041a4c94db44sm1767662wmb.43.2024.04.21.13.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 13:11:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 21 Apr 2024 22:11:33 +0200
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
Subject: Re: [PATCH] selftests/bpf: Add ring_buffer__consume_n test.
Message-ID: <ZiVy9bYrX-w24huD@krava>
References: <20240420155904.1450768-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420155904.1450768-1-andrea.righi@canonical.com>

On Sat, Apr 20, 2024 at 05:59:04PM +0200, Andrea Righi wrote:
> Add a testcase for the ring_buffer__consume_n() API.
> 
> The test produces multiple samples in a ring buffer, using a
> sys_getpid() fentry prog, and consumes them from user-space in batches,
> rather than consuming all of them greedily, like ring_buffer__consume()
> does.
> 

SNIP

> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> index 48c5695b7abf..7e085bfce9b5 100644
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

seems like there's no need for this to be static variable

>  static struct test_ringbuf_lskel *skel;
>  static struct ring_buffer *ringbuf;
>  
> @@ -326,6 +328,67 @@ static void ringbuf_subtest(void)
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
> +	CHECK(s->value != SAMPLE_VALUE,
> +	      "sample_value", "exp %ld, got %ld\n", SAMPLE_VALUE, s->value);

I think we should use ASSERT macros instead in the new code

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
> +	skel->bss->value = SAMPLE_VALUE;

skel_n ?

> +	for (i = 0; i < N_TOT_SAMPLES; i++)
> +		syscall(__NR_getpgid);
> +
> +	/* Consume all samples from the ring buffer in batches of N_SAMPLES */
> +	for (i = 0; i < N_TOT_SAMPLES; i += err) {
> +		err = ring_buffer__consume_n(ringbuf, N_SAMPLES);
> +		ASSERT_EQ(err, N_SAMPLES, "rb_consume");
> +	}
> +

SNIP

> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_n.c b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
> new file mode 100644
> index 000000000000..b98b5bb20699
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
> @@ -0,0 +1,52 @@
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
> +	int seq;

seq does not seem to be checked, is it needed?

jirka

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
> +/* inner state */
> +long seq = 0;
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
> +	sample->seq = seq++;
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
> 

