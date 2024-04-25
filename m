Return-Path: <linux-kselftest+bounces-8883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 390AE8B297D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 22:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5C61C21325
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 20:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6707152DF3;
	Thu, 25 Apr 2024 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="gN+MnxIc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C2E152E18
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075959; cv=none; b=e+EHWNaQ1xYrBL8a/BZZR4FSknhax2wSISuN8HOpL4UYdeMuTGtK5KH4lKg98E6YZx0PhWhiq9Bbf4eA1S2Z95ueWpJTfgW5nsXIAyvN7FE6/coke8IZuXyXkwJoBc9BeTWuDe6fOS4Y/SqZ1mt/NcLrY6J+wsbVm/JQ6VctYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075959; c=relaxed/simple;
	bh=LQMNL24CL+osLBg292NUUAZjCTTOPr7F9KBHA/bQFTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIg2WfPT6w3UNAn6iaZTrgEQGCfi7Ku5tpdCMMatPEUCl3OWsfWYBHG4V33/5tpAQcPGAMRo9o36vMsuFGm/7531ptaVfgIDhcCuVjlzlLlIOitNRtyMv28L7ahKsvkP0kCoVWWUBEr7TN1O5gje5sCQk0oOezX4TiOHeWvwcuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=gN+MnxIc; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DA3773F8DF
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 20:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714075955;
	bh=XQBoevb+USW2ffiD4QLRp2t0k75BnseUBr4iry6tC6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=gN+MnxIcO9AFxc9CjgwCawhegMga+470GSd0pbcvB/R+Q6tQ52RumnJSlFZnt4STu
	 pPKDVfygAPbs5gvwxfhytfr1G7UCFQ3C3Dz/F+GYPPWxfjM2z/O81vLEYM9EW6jg2l
	 J8/Ga9oZQGLHWJylqTUpDgERxAs/1ueMmE0e4w8GHSMlhzQRUYQ9Ohxs3G8janQbgo
	 oL3FiYUdEyyACW6W06s96XdxRyg9qCwVfO93hHnEo9xnG37BSx766IAULiSlN1sP3m
	 TUQRW09sLK769EXKqrZ1SGEz8Hn+oj5TJaZ9F2LN+fkzI8hFVicRyqVgAML5vg7otA
	 FQifcOoA6y52Q==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a5564a2e3a5so102400766b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 13:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714075955; x=1714680755;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQBoevb+USW2ffiD4QLRp2t0k75BnseUBr4iry6tC6k=;
        b=bQYnhbU5/jr5HR5pD9wZwiXd7eL9tzFoiNJdZOiofs+dM2JZUOCpB0oCFyCEFqwuqn
         M+++7jyWMVi+1kBa0VuJKIoDspLp9abgeShSoJQ2Ne6X8EWStnQoXtrgUMDLPfu3V0Vv
         6arF5aZT0naXAJpFe+vV9o/LFs2mRq03hZXXuItCpajb45hFSh+4T8TH8CJCQGce9lGz
         wTbfBdijGyRPLToWLhyvKRllWA9U6WUGD/rSVibcXtWH+wEBaFGdheRZSgkQ3FJj6mTl
         PgAjyfrp48Sc7lGMRmSfqE2TYsnD3NpjcP1rd/u0WGqDFih2HUZGbk98dfM4ycKVzLHp
         hRXA==
X-Forwarded-Encrypted: i=1; AJvYcCVR9Fq3Ap7ymQqOEewGfPytBOVReb8ZSYXBdtx7cpTZZnqujl62wHrOHCtBaLzKPPY341/pMjlQMBafpzDIweV9mM4Qn7xfz0ZMez97oX9v
X-Gm-Message-State: AOJu0YydTfDLl9W/1jeVU/uI44dLscQW3dahxbL/TXSRDNTmo3CchNIY
	bdDmIw5cgpw4VJy0SE32ynfWsexYefM3JthzM/YlI82mDrbAAsyczdKvRyPYOSsWXCNRHios7Tp
	oTPTVi2b6sPjwyHGQN0KMspQXi/o5VaAuZ48rlNllaSl+6jUy9rrAq7zA2bKJIQlbullIjBNZNd
	jwmNtgzQ==
X-Received: by 2002:a17:906:3391:b0:a58:aa82:778d with SMTP id v17-20020a170906339100b00a58aa82778dmr465575eja.63.1714075955339;
        Thu, 25 Apr 2024 13:12:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdIMz095ulb0g5HF4BtTjFGYe+I2OvSiQHWWq0t8YGwnvWGcKMvzBMfvmfgP35M3ocRtkqxQ==
X-Received: by 2002:a17:906:3391:b0:a58:aa82:778d with SMTP id v17-20020a170906339100b00a58aa82778dmr465551eja.63.1714075954779;
        Thu, 25 Apr 2024 13:12:34 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id qu20-20020a170907111400b00a5242ec4573sm9813171ejb.29.2024.04.25.13.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 13:12:34 -0700 (PDT)
Date: Thu, 25 Apr 2024 22:12:33 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] selftests/bpf: Add ring_buffer__consume_n test.
Message-ID: <Ziq5MVRnraMPzGMS@gpd>
References: <20240425140627.112728-1-andrea.righi@canonical.com>
 <CAEf4BzYO=yo15WidtJqe_QaMrj+h7VUyufw7xN2XS0GG8Xh8fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYO=yo15WidtJqe_QaMrj+h7VUyufw7xN2XS0GG8Xh8fQ@mail.gmail.com>

On Thu, Apr 25, 2024 at 11:47:07AM -0700, Andrii Nakryiko wrote:
> On Thu, Apr 25, 2024 at 7:06 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > Add a testcase for the ring_buffer__consume_n() API.
> >
> > The test produces multiple samples in a ring buffer, using a
> > sys_getpid() fentry prog, and consumes them from user-space in batches,
> > rather than consuming all of them greedily, like ring_buffer__consume()
> > does.
> >
> > Link: https://lore.kernel.org/lkml/CAEf4BzaR4zqUpDmj44KNLdpJ=Tpa97GrvzuzVNO5nM6b7oWd1w@mail.gmail.com
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > ---
> >  tools/testing/selftests/bpf/Makefile          |  2 +-
> >  .../selftests/bpf/prog_tests/ringbuf.c        | 64 +++++++++++++++++++
> >  .../selftests/bpf/progs/test_ringbuf_n.c      | 47 ++++++++++++++
> >  3 files changed, 112 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_n.c
> >
> > ChangeLog v2 -> v3:
> >  - move skel_n inside ringbuf_n_subtest()
> >
> > ChangeLog v1 -> v2:
> >  - replace CHECK() with ASSERT_EQ()
> >  - fix skel -> skel_n
> >  - drop unused "seq" field from struct sample
> >
> 
> [...]
> 
> > +       /* Produce N_TOT_SAMPLES samples in the ring buffer by calling getpid() */
> > +       skel_n->bss->value = SAMPLE_VALUE;
> > +       for (i = 0; i < N_TOT_SAMPLES; i++)
> > +               syscall(__NR_getpgid);
> > +
> > +       /* Consume all samples from the ring buffer in batches of N_SAMPLES */
> > +       for (i = 0; i < N_TOT_SAMPLES; i += err) {
> > +               err = ring_buffer__consume_n(ringbuf, N_SAMPLES);
> > +               ASSERT_EQ(err, N_SAMPLES, "rb_consume");
> 
> if something goes wrong and err is < 0, we might end up with a very
> long loop. I changed this to:
> 
> if (!ASSERT_EQ(...))
>     goto cleanup_ringbuf;
> 
> to avoid this problem

Looks good, tested, just in case, and it works a expected.

Thanks!
-Andrea

> 
> > +       }
> > +
> > +cleanup_ringbuf:
> > +       ring_buffer__free(ringbuf);
> > +cleanup:
> > +       test_ringbuf_n_lskel__destroy(skel_n);
> > +}
> > +
> 
> [...]

