Return-Path: <linux-kselftest+bounces-8847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 749038B1ACF
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 08:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998F71C21795
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 06:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2673FBB7;
	Thu, 25 Apr 2024 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CwuXZPem"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B294F3D388
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 06:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025959; cv=none; b=S25C+8KAbnBZ2bP22cinwfOb+9VHWwpmZmjKcyXOHrJXQlWdsxn/RPm2ZFgsJjz1I9htaJGDjX9RPyUrcZgPWgY8X03f1TILXBs78NqYnsLukEahbOXwHTrhuOkgcP/+FFU5Y0EwxFUr79/TEkE/02P60q8D2WZsFZDn0BhxstU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025959; c=relaxed/simple;
	bh=//DNsUlBgI0vlLJDyF69vHpBDYm1UWrZbGpkoCdLwuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldFjyJWBiHYUZzJyq7WwO3JoEMxBT3CbiUpl0maWim8snYX7M3TlNFT8kM29PiAhte4ifZ+AFNJ9QDbtU3LIjFg+rAPpMUioaMBoMw0eiFTy/dvDFzITGBESAVN+DDtRl6As6S9uCVE41zOuT4+kU+NsZ7ytG/AMrvcX2SKQVYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CwuXZPem; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 604B13FE53
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 06:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714025949;
	bh=HoVegtVV8p+Gh2AomBAcQ2xl6o91liRpQqxeqe2byac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=CwuXZPemIJqjgsV2TDJ7MM0quiF/bUSR7AlpLSpOV1ldX5Od2QfumOXanazVcyvHl
	 TLZk7HoKbFOlUnVQNCIcIWbtYycGXohlTHpshCF8PJnsjZvHglKOutgnISvtQDhcDE
	 tDxoXST1Bpj7Y9oniPG6hzSIjLy0PAWWHF9kwF9zvxnflOmMfmQqKp0xu4xZgeZ5tA
	 SSWyRYMK/mZF0u2ZiBZ0R9ZC6b2Cd8taE3suM/6Roc0TCahzKB16LtguDf/3a34w1U
	 23u1LDTNEsZly1oDug7tI+VVZIexRPhUwqdMeos2kYHeboApbcOntXxT7fqniETVGt
	 4fRdWBMncGWaw==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57233475b0dso210758a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 23:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714025949; x=1714630749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoVegtVV8p+Gh2AomBAcQ2xl6o91liRpQqxeqe2byac=;
        b=asrSuny+95JSvweuhDqy3KYxbz9rC1kW2dYEi4y8E4MD1mPQLFgpoOoZ/5FUgHh8X9
         5uSplLqMwJ0DFLooEl4x/s030FgY8ZIqDADqhnrxP4Rw5xAMy3nWoFZyjBkrGq3GWGqJ
         2OMylDTEe0oO+aTYMf4nOa3XIIwEyCt9dvVY4kf5TkYejOyeeOJrEhfc93D/XEQJXs5r
         gXdvj508FLgllMKdgaHrhLhSayLuS6s51PXAUacA08B2Q2VYD7qd5GQr+03fsmf31c6F
         QSG5DPGfarAfPEQGqUYN2R3gLtVfv2i2hBexf7V3msSsgjKrC3u/R3aMnyUYd0bDoX1C
         IzOg==
X-Forwarded-Encrypted: i=1; AJvYcCX5hibZlhGDDiNjePWY51oyWaaOG8XgivafpfIKewrqRlTJRCY47c7riomd2yg7CC4S5P5qMjRxmutjOuz5ol3A1mFSbU6juSXbk0iG2qbF
X-Gm-Message-State: AOJu0YxFtzUKcfpD8vKcEL8cmlI4xqJLTS9DmD2iajg5vIgiJhgfRyey
	rBl+k2yZwnkwx/nZW9hGDz1QNXd2JChtorw0x/+1N1DgaJzq9WnDM3jGQ1O4ajbU122W6rDTTDh
	riYHw2maqbnwfki0kKwIxl4YdO6rZiaKicmbT389/K1ib62paeLL+c6fieSCfY9FE3yGtGGNRR+
	eObyY/Rg==
X-Received: by 2002:a05:6402:2033:b0:572:325a:851a with SMTP id ay19-20020a056402203300b00572325a851amr2448513edb.10.1714025948827;
        Wed, 24 Apr 2024 23:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmz2xFXYeIc9DsevrrNqsLxot9gX+ty/nFrxSqWAYAoTEBo9LkdsRfBz18/zGUn4b5HLfSjA==
X-Received: by 2002:a05:6402:2033:b0:572:325a:851a with SMTP id ay19-20020a056402203300b00572325a851amr2448483edb.10.1714025948178;
        Wed, 24 Apr 2024 23:19:08 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id c7-20020a0564021f8700b0057000ecadb0sm8680895edc.8.2024.04.24.23.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 23:19:07 -0700 (PDT)
Date: Thu, 25 Apr 2024 08:19:04 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Jiri Olsa <olsajiri@gmail.com>
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
Message-ID: <Zin12J-emVljvVrJ@gpd>
References: <20240420155904.1450768-1-andrea.righi@canonical.com>
 <ZiVy9bYrX-w24huD@krava>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiVy9bYrX-w24huD@krava>

On Sun, Apr 21, 2024 at 10:11:33PM +0200, Jiri Olsa wrote:
...
> >  static struct test_ringbuf_map_key_lskel *skel_map_key;
> > +static struct test_ringbuf_n_lskel *skel_n;
> 
> seems like there's no need for this to be static variable

Can you elaborate more? I think we want these pointers to be static to
limit the scope to this file, no?

> 
> >  static struct test_ringbuf_lskel *skel;
> >  static struct ring_buffer *ringbuf;
> >  
> > @@ -326,6 +328,67 @@ static void ringbuf_subtest(void)
> >  	test_ringbuf_lskel__destroy(skel);
> >  }
> >  
> > +/*
> > + * Test ring_buffer__consume_n() by producing N_TOT_SAMPLES samples in the ring
> > + * buffer, via getpid(), and consuming them in chunks of N_SAMPLES.
> > + */
> > +#define N_TOT_SAMPLES	32
> > +#define N_SAMPLES	4
> > +
> > +/* Sample value to verify the callback validity */
> > +#define SAMPLE_VALUE	42L
> > +
> > +static int process_n_sample(void *ctx, void *data, size_t len)
> > +{
> > +	struct sample *s = data;
> > +
> > +	CHECK(s->value != SAMPLE_VALUE,
> > +	      "sample_value", "exp %ld, got %ld\n", SAMPLE_VALUE, s->value);
> 
> I think we should use ASSERT macros instead in the new code

Good catch, I'll change this to an ASSERT_EQ().

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static void ringbuf_n_subtest(void)
> > +{
> > +	int err, i;
> > +
> > +	skel_n = test_ringbuf_n_lskel__open();
> > +	if (!ASSERT_OK_PTR(skel_n, "test_ringbuf_n_lskel__open"))
> > +		return;
> > +
> > +	skel_n->maps.ringbuf.max_entries = getpagesize();
> > +	skel_n->bss->pid = getpid();
> > +
> > +	err = test_ringbuf_n_lskel__load(skel_n);
> > +	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
> > +		goto cleanup;
> > +
> > +	ringbuf = ring_buffer__new(skel_n->maps.ringbuf.map_fd,
> > +				   process_n_sample, NULL, NULL);
> > +	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
> > +		goto cleanup;
> > +
> > +	err = test_ringbuf_n_lskel__attach(skel_n);
> > +	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__attach"))
> > +		goto cleanup_ringbuf;
> > +
> > +	/* Produce N_TOT_SAMPLES samples in the ring buffer by calling getpid() */
> > +	skel->bss->value = SAMPLE_VALUE;
> 
> skel_n ?

Absolutely... I'm suprised that it works actually, I guess pure luck
(unluck) to reuse the old pointer and have value mapped to the same
location. Anyway, I'll fix this.

> 
> > +	for (i = 0; i < N_TOT_SAMPLES; i++)
> > +		syscall(__NR_getpgid);
> > +
> > +	/* Consume all samples from the ring buffer in batches of N_SAMPLES */
> > +	for (i = 0; i < N_TOT_SAMPLES; i += err) {
> > +		err = ring_buffer__consume_n(ringbuf, N_SAMPLES);
> > +		ASSERT_EQ(err, N_SAMPLES, "rb_consume");
> > +	}
> > +
> 
> SNIP
> 
> > diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_n.c b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
> > new file mode 100644
> > index 000000000000..b98b5bb20699
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
> > @@ -0,0 +1,52 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2024 Andrea Righi <andrea.righi@canonical.com>
> > +
> > +#include <linux/bpf.h>
> > +#include <sched.h>
> > +#include <unistd.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_misc.h"
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +#define TASK_COMM_LEN 16
> > +
> > +struct sample {
> > +	int pid;
> > +	int seq;
> 
> seq does not seem to be checked, is it needed?

seq is not used at all, I can definitely drop it.

Thanks for the review! I'll send a v2.

-Andrea

