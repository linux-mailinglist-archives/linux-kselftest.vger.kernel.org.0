Return-Path: <linux-kselftest+bounces-8854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE288B218F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 14:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA6C1C21C29
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 12:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC9112BF2B;
	Thu, 25 Apr 2024 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AumrvGWY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C3D12BF28;
	Thu, 25 Apr 2024 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047816; cv=none; b=rabdoNblXKf8t5KTG3Q9am3vAKsiZDgnhKBaUUzJQfEkiqCytDn/w/6FbMFDgKp7CBMBuY7dcE2woorbNgmGrAu2WzO6Xr1D/+0EJRVJ3Hu1yK2xIhahtIBhFmxnvSLFzV+++MkfoFhHPF1YpdE10Q8IYzvjAFrpMUhH6q543iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047816; c=relaxed/simple;
	bh=f1VHBoI452sjSlBEzF3gS3BPNVPxPDbG8HPy+r6UUaU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xwg0xVepGG/kjTSPY1Iq5lMZUSNBEKwQ1TSC519nw2KNjAETzBkaXARbpkJ6GanILLy3CtEix1P47Cs/Uau53MBTlkVPo9SUmb06rvJYLAPucoPec388vRWe+JBckSOKt+WF1zOPAIXJkPSwcKdsxxmpamcUwlALP1R2kg4IAMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AumrvGWY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41b5dc5e037so2458505e9.3;
        Thu, 25 Apr 2024 05:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714047813; x=1714652613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AgAuXVrMNybkJPcYd0WLC0uuf16vwsiRqZdvN8Rkecg=;
        b=AumrvGWYseAJEGPdOyzn8EGwCltMP81+SqRpFFxs5V4LqkTK8VwBEG6a+ApsEvqZdF
         RT4ikZQbzxhCOls5muKuYL0whazrU40ylh3WzvGL9ttZD0+Wvu01dGkxob6cEHx7cdcd
         skrrmrmVDv9jJaQqlxYwloVdUYoZT8ov+opFvW46JWf/7KNM7RlddsAMBWPuDyKpaEb3
         KBVen63T8ofw9TXZQjZUBIiAksp0pQcSqjoFF1uQHaZQfP0HsBhrDsmWq4Cq5D0Q52HL
         Rfu8ETGIPQTFuvB769TaWTJrRBWgbnaLSQuNjNwa7Z61Lr3rK+OJl78Bdqj/CFOFnTJ3
         RoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714047813; x=1714652613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgAuXVrMNybkJPcYd0WLC0uuf16vwsiRqZdvN8Rkecg=;
        b=eXSjCSr2VcVC1wXzyZ7+KDDDt5SlV6olzc9SxI2+anI+QyeJjNCRVBGDKeqsVAssrB
         y8OgpFqJXE+KECuzqgZpQ8f9AIg/oX86qYVq6YgNGtl6pyvPjzYxEk46SWxdYezdLQqU
         oIlbozPLcZXW+fJtlaFQHYkLKG3Bys4yyR5Mxug3A02yvWiXBvkfDp5NDaObWuQn9CV5
         aTtjEE9Y3WGZBNl5XqRIBvrPR9GhrdgT2hGSAFDTBKBJ/kyqSfLA7gvW0uLFMxjza6MM
         L8X/Ir3h+Bn7XgrhDsBxalfM7IQyBbyUReCdDzr2rBX2r/W33XkpbIDXWlrKkc4q8fls
         nOpA==
X-Forwarded-Encrypted: i=1; AJvYcCUUBwA4kWYx+SaDhTQJeW3tC0ghrm62WE9colWR7dYL1VdvrLj6xX3bDILtMWZTIq6DqT6EAdc/ZW8//mBsc7zKWs+14JlVFlIIqiIokHPXbIrsb6n1CEWwp1pmx6L6E0f+5I4XMSmBKKPma+6cv+yj1sIn6BamlYq0AGOAktBH6ts3
X-Gm-Message-State: AOJu0YyHNhLbDDAyZV3Inr40JBAXshAfoHxnk7lVyUwnmGbpZjhcTnbG
	cB+v2XlxdreIuc4LewbXZzdfRx5vOscwWb/zISm/Tocu6HERy74x
X-Google-Smtp-Source: AGHT+IHNUfe4CB7KmaVZi60iR9F6QyAH9AoGG86U0yXvWla4HrImUyham4a+87p9u2hCClAhsT6PuQ==
X-Received: by 2002:a05:600c:1911:b0:41b:163:1e6a with SMTP id j17-20020a05600c191100b0041b01631e6amr3775208wmq.10.1714047812894;
        Thu, 25 Apr 2024 05:23:32 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c26c200b0041a68d4fe61sm1492588wmv.0.2024.04.25.05.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 05:23:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 Apr 2024 14:23:30 +0200
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
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
Message-ID: <ZipLQmwPd--EajCk@krava>
References: <20240420155904.1450768-1-andrea.righi@canonical.com>
 <ZiVy9bYrX-w24huD@krava>
 <Zin12J-emVljvVrJ@gpd>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zin12J-emVljvVrJ@gpd>

On Thu, Apr 25, 2024 at 08:19:04AM +0200, Andrea Righi wrote:
> On Sun, Apr 21, 2024 at 10:11:33PM +0200, Jiri Olsa wrote:
> ...
> > >  static struct test_ringbuf_map_key_lskel *skel_map_key;
> > > +static struct test_ringbuf_n_lskel *skel_n;
> > 
> > seems like there's no need for this to be static variable
> 
> Can you elaborate more? I think we want these pointers to be static to
> limit the scope to this file, no?

I meant to move it directly inside ringbuf_n_subtest function,
I don't see reason why it's defined outside of that function

jirka

> 
> > 
> > >  static struct test_ringbuf_lskel *skel;
> > >  static struct ring_buffer *ringbuf;
> > >  
> > > @@ -326,6 +328,67 @@ static void ringbuf_subtest(void)
> > >  	test_ringbuf_lskel__destroy(skel);
> > >  }
> > >  
> > > +/*
> > > + * Test ring_buffer__consume_n() by producing N_TOT_SAMPLES samples in the ring
> > > + * buffer, via getpid(), and consuming them in chunks of N_SAMPLES.
> > > + */
> > > +#define N_TOT_SAMPLES	32
> > > +#define N_SAMPLES	4
> > > +
> > > +/* Sample value to verify the callback validity */
> > > +#define SAMPLE_VALUE	42L
> > > +
> > > +static int process_n_sample(void *ctx, void *data, size_t len)
> > > +{
> > > +	struct sample *s = data;
> > > +
> > > +	CHECK(s->value != SAMPLE_VALUE,
> > > +	      "sample_value", "exp %ld, got %ld\n", SAMPLE_VALUE, s->value);
> > 
> > I think we should use ASSERT macros instead in the new code
> 
> Good catch, I'll change this to an ASSERT_EQ().
> 
> > 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void ringbuf_n_subtest(void)
> > > +{
> > > +	int err, i;
> > > +
> > > +	skel_n = test_ringbuf_n_lskel__open();
> > > +	if (!ASSERT_OK_PTR(skel_n, "test_ringbuf_n_lskel__open"))
> > > +		return;
> > > +
> > > +	skel_n->maps.ringbuf.max_entries = getpagesize();
> > > +	skel_n->bss->pid = getpid();
> > > +
> > > +	err = test_ringbuf_n_lskel__load(skel_n);
> > > +	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
> > > +		goto cleanup;
> > > +
> > > +	ringbuf = ring_buffer__new(skel_n->maps.ringbuf.map_fd,
> > > +				   process_n_sample, NULL, NULL);
> > > +	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
> > > +		goto cleanup;
> > > +
> > > +	err = test_ringbuf_n_lskel__attach(skel_n);
> > > +	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__attach"))
> > > +		goto cleanup_ringbuf;
> > > +
> > > +	/* Produce N_TOT_SAMPLES samples in the ring buffer by calling getpid() */
> > > +	skel->bss->value = SAMPLE_VALUE;
> > 
> > skel_n ?
> 
> Absolutely... I'm suprised that it works actually, I guess pure luck
> (unluck) to reuse the old pointer and have value mapped to the same
> location. Anyway, I'll fix this.
> 
> > 
> > > +	for (i = 0; i < N_TOT_SAMPLES; i++)
> > > +		syscall(__NR_getpgid);
> > > +
> > > +	/* Consume all samples from the ring buffer in batches of N_SAMPLES */
> > > +	for (i = 0; i < N_TOT_SAMPLES; i += err) {
> > > +		err = ring_buffer__consume_n(ringbuf, N_SAMPLES);
> > > +		ASSERT_EQ(err, N_SAMPLES, "rb_consume");
> > > +	}
> > > +
> > 
> > SNIP
> > 
> > > diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_n.c b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
> > > new file mode 100644
> > > index 000000000000..b98b5bb20699
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
> > > @@ -0,0 +1,52 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +// Copyright (c) 2024 Andrea Righi <andrea.righi@canonical.com>
> > > +
> > > +#include <linux/bpf.h>
> > > +#include <sched.h>
> > > +#include <unistd.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +#include "bpf_misc.h"
> > > +
> > > +char _license[] SEC("license") = "GPL";
> > > +
> > > +#define TASK_COMM_LEN 16
> > > +
> > > +struct sample {
> > > +	int pid;
> > > +	int seq;
> > 
> > seq does not seem to be checked, is it needed?
> 
> seq is not used at all, I can definitely drop it.
> 
> Thanks for the review! I'll send a v2.
> 
> -Andrea

