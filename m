Return-Path: <linux-kselftest+bounces-8852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341EC8B1D11
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 10:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3EC11F23D04
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B889284047;
	Thu, 25 Apr 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWLRYv8J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96F83CD2;
	Thu, 25 Apr 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035050; cv=none; b=dYYkxl1gzBV6Y9UIXL+Y5PHcoaBkDlIW5KEAUyg3qVyeLWrcl1Jl0b9292gB58pvrZE8PVZNT6W/teFm+olsISmYEmbNESJgVMT7HWxnzvYR2nCNiaunBct4QWbGF+mTTnJQcHItDEN59TJm0Oe3o1UNqxRvZxKSgyfuvSWQ5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035050; c=relaxed/simple;
	bh=Ykyc1m6fUbjPL+SvZ1UaIcoFtggZytlQ0SlPkOJ/8aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lurUOeS026MbLWDG0nWYe2y3hA01JY9eniROafA7xeoWImsTsVfJALEMGc1QCfosjKYL4FDzq1DYUVf30N1cPfgzmu37eFoTkXQwQk2wwEClJhVBA03VCDXOY/tq170L2ZB2OKk7fAlV/VE4tlrlYXEar8rKBD8kTGiIuxQEJ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWLRYv8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E590C2BBFC;
	Thu, 25 Apr 2024 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714035050;
	bh=Ykyc1m6fUbjPL+SvZ1UaIcoFtggZytlQ0SlPkOJ/8aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PWLRYv8J+fJlpc5+N7ecHfJH4vNKOw3AeItSmvtb8mJi50tcoG6g2wzD2MTmYwk/o
	 JlFCScJnKyonQ3s1MZ+6a9zXKD1bcmjnz3wh5bKzorOPzWBtwdDiKtDwLKplSbOVWR
	 j/CfTOIv5qqmirc/TMf5P96/65QNmlpbISXOm0+8UYQRnnIYwONy8LqFOL32asCAjw
	 05dxTy//HVWp8Zj5LWL5W/Zv8NC7Q0S+I0WA8Q3LOKGwKr8T0mAb52p8afoKtqTnef
	 B6UlK87h7P21b/w8lcKfXig1lJFgi9/q0Pap17Mgti5FQl5/ZvsTBlexTotN5fUjG/
	 7Fm58wmOqwZmA==
Date: Thu, 25 Apr 2024 10:50:43 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 11/16] bpf: wq: add bpf_wq_init
Message-ID: <qdpeqhg4whvxeb7cwzex6moq63kp3sjwkkrzzwdrpsg3mfqmz6@bdmbzaa5zouc>
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
 <20240420-bpf_wq-v2-11-6c986a5a741f@kernel.org>
 <CAADnVQJ9Qw6Lr644xRTU-n16UkBCyHoTAQs7QqGiniOdsOVAJg@mail.gmail.com>
 <CAADnVQKfzu1F=xZxyYhiocAn1iM=8f13Ca-2Jfht2dXsXuGu9A@mail.gmail.com>
 <CAADnVQJTyXS--chM61Ysk7sDNXoUqPctprXwZ8DEcJMHa9Uy3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJTyXS--chM61Ysk7sDNXoUqPctprXwZ8DEcJMHa9Uy3w@mail.gmail.com>

On Apr 24 2024, Alexei Starovoitov wrote:
> On Wed, Apr 24, 2024 at 8:06 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Apr 23, 2024 at 7:55 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat, Apr 20, 2024 at 2:10 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> > > >
> > > > We need to teach the verifier about the second argument which is declared
> > > > as void * but which is of type KF_ARG_PTR_TO_MAP. We could have dropped
> > > > this extra case if we declared the second argument as struct bpf_map *,
> > > > but that means users will have to do extra casting to have their program
> > > > compile.
> > > >
> > > > We also need to duplicate the timer code for the checking if the map
> > > > argument is matching the provided workqueue.
> > > >
> > > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > >
> > > > ---
> > > >
> > > > FWIW, I still have one concern with this implementation:
> > > > - bpf_wq_work() access ->prog without protection, but I think this might
> > > >   be racing with bpf_wq_set_callback(): if we have the following:
> > > >
> > > >   CPU 0                                     CPU 1
> > > >   bpf_wq_set_callback()
> > > >   bpf_start()
> > > >                                             bpf_wq_work():
> > > >                                               prog = cb->prog;
> > > >
> > > >   bpf_wq_set_callback()
> > > >     cb->prog = prog;
> > > >     bpf_prog_put(prev)
> > > >     rcu_assign_ptr(cb->callback_fn,
> > > >                    callback_fn);
> > > >                                            callback = READ_ONCE(w->cb.callback_fn);
> > > >
> > > >   As I understand callback_fn is fine, prog might be, but we clearly
> > > >   have an inconstency between "prog" and "callback_fn" as they can come
> > > >   from 2 different bpf_wq_set_callback() calls.
> > > >
> > > >   IMO we should protect this by the async->lock, but I'm not sure if
> > > >   it's OK or not.
> > >
> > > I see the concern, but I think it's overkill.
> > > Here 'prog' is used to pass it into __bpf_prog_enter_sleepable_recur()
> > > to keep the standard pattern of calling into sleepable prog.
> > > But it won't recurse.
> > > We can open code migrate_disable,etc from there except this_cpu_inc_return,
> > > but it's an overkill.
> > > The passed 'prog' is irrelevant.
> > > If somebody tries really hard by having two progs sharing the same
> > > map with bpf_wq and racing to set_callback... I can see how
> > > prog won't match callback, but it won't make a difference.
> > > prog is not going trigger recursion check (unless somebody
> > > tries is obsessed) and not going to UAF.
> > > I imagine it's possible to attach somewhere in core wq callback
> > > invocation path with fentry, set_callback to the same prog,
> > > and technically it's kinda sorta recursion, but different subprogs,
> > > so not a safety issue.
> > > The code as-is is fine. imo.
> >
> > After sleeping on it, I realized that the use of
> > __bpf_prog_enter_sleepable_recur() here is very much incorrect :(
> > The tests are passing only because we don't inc prog->active
> > when we run the prog via prog_run cmd.
> > Adding the following:
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index f6aad4ed2ab2..0732dfe22204 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -1514,7 +1514,9 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
> >         }
> >
> >         rcu_read_lock_trace();
> > +       this_cpu_inc_return(*(prog->active));
> >         retval = bpf_prog_run_pin_on_cpu(prog, ctx);
> > +       this_cpu_dec(*(prog->active));
> >         rcu_read_unlock_trace();
> >
> > makes the test fail sporadically.
> > Or 100% fail when the kernel is booted with 1 cpu.
> >
> > Could you send a quick follow up to
> > replace __bpf_prog_enter_sleepable_recur() with
> >         rcu_read_lock_trace();
> >         migrate_disable();
> > ?
> >
> > Or I'll do it in an hour or so.
> 
> Considering two broken-build reports already
> I've applied the following fix:
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=dc92febf7b93da5049fe177804e6b1961fcc6bd7
> 
> that addresses the build issue on !JIT and fixes this recursion problem.

Thanks a lot for fixing this on my behalf. I was slightly puzzled by the
broken-build report but really I wasn't in position to think straight
yesterday (got a pretty big muscular pain in the back and had to go to
the doctor to get painkillers)

I haven't forgoten about the double list walk in 9/16, I'll hopefully
send the fix today.

Cheers,
Benjamin

