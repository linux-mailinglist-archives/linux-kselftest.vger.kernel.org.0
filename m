Return-Path: <linux-kselftest+bounces-17653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807D497446B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 22:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C3B1C252F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 20:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC471AAE1E;
	Tue, 10 Sep 2024 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="XnQgkFa9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l3IFiJbH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F491A7AF5;
	Tue, 10 Sep 2024 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001996; cv=none; b=mB9Fjp2ubuql3TsSeVOQhO0T6nUEP833zBDe7B76DN1wHc6CKPbRm+qX7lD16P6ci+03CNtfOeGMWE0iIQwaB+1LjhnLkCthL/2rM3DY0oySxMUsbejB/4MngTfCMglV75OKtCR2/CkMcvpkJyNpdl0y1H2VCGZ/0yoknxlAEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001996; c=relaxed/simple;
	bh=hpL9ZdGA2gm98swxaaHVvRD9QSsK84D3RZxupu+kGU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/6NI1p1XzbKrBJD6DpBWl15uERtHeabJIBbcqH39quF7XGtQYNnx1OJ8ZKFJlJIi8VY/mrjwoVZkbX7opFVwsN6oNXBxBsi5O/kiR7nxKUk3psD3zHAkN9v8MhNEauUAADZeK9xKxkMnWw3/l00kH1D7DWBTevc4E9hutjUt5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=XnQgkFa9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l3IFiJbH; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DAD8114017F;
	Tue, 10 Sep 2024 16:59:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 10 Sep 2024 16:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726001994;
	 x=1726088394; bh=hzv2BsnnQ9fdXaJsvN7avfDB7W4UEo8ZjQhFk392AnY=; b=
	XnQgkFa9N2tCOjhDBQNpIgzwWUL3m1FwqdhnLGc52Foz/LKK37h0V/1z/R6F0ui/
	5SIMKdDaShCdufFp2UNUaMfQbZylY7RsaxlRKdRPOgeeRC38JZyfYpxUn4+4VH+q
	x2onCWsDWUL+EkeOw+f/bXHgh15C0Xk9lyODIc1xFyx/WJMUbTL+GMvhEmLeMxYa
	/IXvWAlb2rfxe7ZKF4foCQxu2FOIn/k44v9pZLo9H6oc/LTigpiaqK9a4JOzZx9N
	InQwPfGiG3G2E3AkJGdoVJi+b4TLpmd9M5N4Ywfyp9HFryyFWnP1phK4VY7L0B9e
	OmdF8fILRAu+Wg89MBPz/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726001994; x=
	1726088394; bh=hzv2BsnnQ9fdXaJsvN7avfDB7W4UEo8ZjQhFk392AnY=; b=l
	3IFiJbHOrS1TXM2zXWAzL1078NCSqZIZyUojDgf/fJV6crKbcS1nqe8+l60Rt4Kh
	D+GcKOtYVIw6SXT7A9/EIQi53G43KMehGQbB3AkpD9SisKvyPy+e9rI5eyEVVjqo
	b3LiBN3xZmfGHU+dYIPP7O3fa200Gc5v0GWJOs68RIW4RGKjRGpdEViGBwiPjy2d
	nprHxFeP7b3U4xjMvMq5+JrHBfhXpqmwySqUpggnSaEmhyG69gQu7DLlIK3lxbE0
	4+4ykBAJ8a3wHhG1bhSZFKODV54bjNCQwVgBgUOkeC0RFLGFGF9DbwsX6xN2Viw7
	31EPjfhthig1wl93FBLLw==
X-ME-Sender: <xms:SbPgZtGcn4N7g8h2ur_w6gvHMIVZisf4wjRn0VMmXyjn3U2WZ1MiyQ>
    <xme:SbPgZiWne4gzlAsaWk4r6OiA6tXFX8VYacEURdAzDS9otsULLXTQuP7Fw8ql6JKoH
    GWpcqAgJoGvaEUenA>
X-ME-Received: <xmr:SbPgZvLATVg3IUJJ1KNWwk5KoYpijAfWNn9Ov1V35MDp9KVnRf37_Q8BBhM100BlHo9-FR0PIrLIiJZBw21PjtZBVUIqtRXVY-gRimhDv12M1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffk
    fhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepteffteekjeejueejueetfffh
    vddujeeiueeijedutdfgjeffhfegkefggfeggfetnecuffhomhgrihhnpehrihhnghgsuh
    hfrdhmrghpnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudelpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopegrlhgvgigvihdrshhtrghrohhvohhithhovhesghhm
    rghilhdrtghomhdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgv
    lhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrshhtsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    ohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrth
    hinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:SbPgZjH_b3SoQiwp4L0LSFK6xoEA0QlrYlXUiCrrw7ABs4D9y1aoPA>
    <xmx:SbPgZjVyZS5si3_NOc1UZk-Qf1hjDV2ispd3RvXTLUuC1ojbpWuKtg>
    <xmx:SbPgZuPaj6UdPn7YSHPHM1asD1DgyGpHQs3h5ocwv1vgsnMD99gLSQ>
    <xmx:SbPgZi22ydKr6LEHB6tcKcC8qHpeIQNZIzdr2cNei1TaTLPGU0aNWg>
    <xmx:SrPgZiZHdRgu6CikIT_e8EfIbeLUouFPAkKBwdDXlXuwUS7V1-HV8AJ2>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 16:59:50 -0400 (EDT)
Date: Tue, 10 Sep 2024 14:59:48 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eddy Z <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next] bpf: ringbuf: Support consuming
 BPF_MAP_TYPE_RINGBUF from prog
Message-ID: <ip35p7p3hkskenndnbxt6gghzyfzmwdswo3mfaqisac7r57rlq@kqpp5ftzsdxi>
References: <18a9ddacc99bb95e9802f8ad1e81214433df496c.1725929645.git.dxu@dxuuu.xyz>
 <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>

On Tue, Sep 10, 2024 at 11:36:36AM GMT, Alexei Starovoitov wrote:
> On Mon, Sep 9, 2024 at 5:55 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Right now there exists prog produce / userspace consume and userspace
> > produce / prog consume support. But it is also useful to have prog
> > produce / prog consume.
> >
> > For example, we want to track the latency overhead of cpumap in
> > production. Since we need to store enqueue timestamps somewhere and
> > cpumap is MPSC, we need an MPSC data structure to shadow cpumap. BPF
> > ringbuf is such a data structure. Rather than reimplement (possibly
> > poorly) a custom ringbuffer in BPF, extend the existing interface to
> > allow the final quadrant of ringbuf usecases to be filled. Note we
> > ignore userspace to userspace use case - there is no need to involve
> > kernel for that.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  kernel/bpf/verifier.c                         |  6 +-
> >  tools/testing/selftests/bpf/Makefile          |  3 +-
> >  .../selftests/bpf/prog_tests/ringbuf.c        | 50 +++++++++++++++
> >  .../bpf/progs/test_ringbuf_bpf_to_bpf.c       | 64 +++++++++++++++++++
> >  4 files changed, 120 insertions(+), 3 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_bpf_to_bpf.c
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 53d0556fbbf3..56bfe559f228 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -9142,7 +9142,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
> >                     func_id != BPF_FUNC_ringbuf_query &&
> >                     func_id != BPF_FUNC_ringbuf_reserve_dynptr &&
> >                     func_id != BPF_FUNC_ringbuf_submit_dynptr &&
> > -                   func_id != BPF_FUNC_ringbuf_discard_dynptr)
> > +                   func_id != BPF_FUNC_ringbuf_discard_dynptr &&
> > +                   func_id != BPF_FUNC_user_ringbuf_drain)
> >                         goto error;
> >                 break;
> >         case BPF_MAP_TYPE_USER_RINGBUF:
> > @@ -9276,7 +9277,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
> >                         goto error;
> >                 break;
> >         case BPF_FUNC_user_ringbuf_drain:
> > -               if (map->map_type != BPF_MAP_TYPE_USER_RINGBUF)
> > +               if (map->map_type != BPF_MAP_TYPE_USER_RINGBUF &&
> > +                   map->map_type != BPF_MAP_TYPE_RINGBUF)
> >                         goto error;
> 
> I think it should work.
> 
> Andrii,
> 
> do you see any issues with such use?
> 
> >                 break;
> >         case BPF_FUNC_get_stackid:
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 9905e3739dd0..233109843d4d 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -503,7 +503,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h               \
> >  LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c           \
> >         trace_printk.c trace_vprintk.c map_ptr_kern.c                   \
> >         core_kern.c core_kern_overflow.c test_ringbuf.c                 \
> > -       test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c
> > +       test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
> > +       test_ringbuf_bpf_to_bpf.c
> 
> Do you need it to be lskel ?
> 
> Regular skels are either to debug.

I'm actually unsure the difference, still. But all the other tests in
the file were using lskel so I just copy/pasted.

> 
> Also pls split selftest into a separate patch.

Ack.

> 
> >
> >  # Generate both light skeleton and libbpf skeleton for these
> >  LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
> > diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> > index da430df45aa4..3e7955573ac5 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> > @@ -17,6 +17,7 @@
> >  #include "test_ringbuf_n.lskel.h"
> >  #include "test_ringbuf_map_key.lskel.h"
> >  #include "test_ringbuf_write.lskel.h"
> > +#include "test_ringbuf_bpf_to_bpf.lskel.h"
> >
> >  #define EDONE 7777
> >
> > @@ -497,6 +498,53 @@ static void ringbuf_map_key_subtest(void)
> >         test_ringbuf_map_key_lskel__destroy(skel_map_key);
> >  }
> >
> > +static void ringbuf_bpf_to_bpf_subtest(void)
> > +{
> > +       struct test_ringbuf_bpf_to_bpf_lskel *skel;
> > +       int err, i;
> > +
> > +       skel = test_ringbuf_bpf_to_bpf_lskel__open();
> > +       if (!ASSERT_OK_PTR(skel, "test_ringbuf_bpf_to_bpf_lskel__open"))
> > +               return;
> > +
> > +       skel->maps.ringbuf.max_entries = getpagesize();
> > +       skel->bss->pid = getpid();
> > +
> > +       err = test_ringbuf_bpf_to_bpf_lskel__load(skel);
> > +       if (!ASSERT_OK(err, "test_ringbuf_bpf_to_bpf_lskel__load"))
> > +               goto cleanup;
> > +
> > +       ringbuf = ring_buffer__new(skel->maps.ringbuf.map_fd, NULL, NULL, NULL);
> > +       if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
> > +               goto cleanup;
> > +
> > +       err = test_ringbuf_bpf_to_bpf_lskel__attach(skel);
> > +       if (!ASSERT_OK(err, "test_ringbuf_bpf_to_bpf_lskel__attach"))
> > +               goto cleanup_ringbuf;
> > +
> > +       /* Produce N_SAMPLES samples in the ring buffer by calling getpid() */
> > +       skel->bss->value = SAMPLE_VALUE;
> > +       for (i = 0; i < N_SAMPLES; i++)
> > +               syscall(__NR_getpgid);
> > +
> > +       /* Trigger bpf-side consumption */
> > +       syscall(__NR_prctl);
> 
> This might conflict with other selftests that run in parallel.
> 
> Just load the skel and bpf_prog_run(prog_fd).
> No need to attach anywhere in the kernel.

Ack.

> 
> pw-bot: cr

