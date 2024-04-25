Return-Path: <linux-kselftest+bounces-8853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8468B1D22
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 10:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EFC286256
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AA88005B;
	Thu, 25 Apr 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgQ6XWu4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E47FBB4;
	Thu, 25 Apr 2024 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035200; cv=none; b=TG6L4TppqUKSvaYpKVi7s/G8OX/etq56RwpcYatmn72wOViaN9f3m/dhuCvSPRkc9XBD2jZbRgWlTEx7UuMEpmj78I2lBJgUtB2nnL3UscLRwA82hMsya7Uik4cBJZ/xukjiVvigKrRv0WotKI5JSeR/oLKnjufMBrcg/lJQ75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035200; c=relaxed/simple;
	bh=39w5XQsRAGKnURUuXsQ1Wk8XgraObcOPly8hISIv0IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaKcqaLt733L7UuVP31Qw6x0pvp0iDCODaHf+yi18LJK3+QUIo/0IZAvvA3nVaaQej5pqVgfBhB8Id3TAc5eEXzxIMqxihJvO30tLSJr6lliCxP4h1Mj8v44irwt+Gh6hdYwnQD1gSashr0753g5Dtsxmw+tOmc357vtDiff7bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgQ6XWu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AFFC113CC;
	Thu, 25 Apr 2024 08:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714035200;
	bh=39w5XQsRAGKnURUuXsQ1Wk8XgraObcOPly8hISIv0IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgQ6XWu4j//NQ+XzmO9Edx2/vMnfoCNacDVh0oH6Igb9ft6E2ihSDh5gTNGuNBf2V
	 9ALM3rKYjIQP8K0QnFcPOz6R7zhQ3nuAo6Jw0/bCIOhRHj2QYCS0L4UE/tzAWg2a/k
	 mKycos2AMlSnwKLkFzY2So29mkpIjYmIYvKDNgrug0F91n+ZOLHbuh9wQH1aiR+peQ
	 j97t1YIB5I/8A8z73fWpma6KnBND+XcB3y5eh6iLfFYVOF9aDsC6OES1hEm6BayZKF
	 eHjxGjhzz8HVgO2XLyqdNhLSskCSBg3PYMZzT+cyyhuFN/P9vcXiNFcPiv6yKeJdbx
	 pR9r4ZFdyHTWg==
Date: Thu, 25 Apr 2024 10:53:10 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 12/16] selftests/bpf: wq: add bpf_wq_init()
 checks
Message-ID: <v7avo5guriv6vbxt25m6bf4gs6ifblolxsui2vmswkyavim4c6@w6yposzvdxtg>
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
 <20240420-bpf_wq-v2-12-6c986a5a741f@kernel.org>
 <CAEf4BzbqmrucgeXX9+Hgnhefne-go9nHYPmh_+JwuMHeNNsv-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbqmrucgeXX9+Hgnhefne-go9nHYPmh_+JwuMHeNNsv-g@mail.gmail.com>

On Apr 24 2024, Andrii Nakryiko wrote:
> On Sat, Apr 20, 2024 at 2:10 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> > Allows to test if allocation/free works
> >
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> >
> > ---
> >
> > changes in v2:
> > - dropped mark_precise checks
> > ---
> >  tools/testing/selftests/bpf/bpf_experimental.h  |  1 +
> >  tools/testing/selftests/bpf/prog_tests/wq.c     |  8 +++
> >  tools/testing/selftests/bpf/progs/wq.c          | 10 ++++
> >  tools/testing/selftests/bpf/progs/wq_failures.c | 78 +++++++++++++++++++++++++
> >  4 files changed, 97 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> > index 3329ea080865..785b91b629be 100644
> > --- a/tools/testing/selftests/bpf/bpf_experimental.h
> > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > @@ -470,4 +470,5 @@ extern int bpf_iter_css_new(struct bpf_iter_css *it,
> >  extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
> >  extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
> >
> > +extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
> >  #endif
> > diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
> > index 9a07b8bc2c52..26ab69796103 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/wq.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/wq.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright (c) 2024 Benjamin Tissoires */
> >  #include <test_progs.h>
> >  #include "wq.skel.h"
> > +#include "wq_failures.skel.h"
> >
> >  void serial_test_wq(void)
> >  {
> > @@ -9,3 +10,10 @@ void serial_test_wq(void)
> >
> >         RUN_TESTS(wq);
> >  }
> > +
> > +void serial_test_failures_wq(void)
> > +{
> > +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +
> 
> unused leftover?

Oops, yeah. Looks like it.

I'll send a removal of it while fixing 9/16

Cheers,
Benjamin

> 
> > +       RUN_TESTS(wq_failures);
> > +}
> 
> [...]

