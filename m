Return-Path: <linux-kselftest+bounces-8781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAC58B0D8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FDE281FF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20EE15EFD6;
	Wed, 24 Apr 2024 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1i5BvLP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E763515B576;
	Wed, 24 Apr 2024 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971179; cv=none; b=tLs0Tpl/IBrCNL/Y7PjSIyGn1BwVWtjxa8vEUmZNQtfRVekNsfswk4hzlB7Q4/RqmRrh3neb1VEy8a2rlVcyNLY6lhY2K7Jjx6bhd2pDJx5+U//Y82PidY6uXr40BDgxAwbHE67vPbNHcek3PtEvVse6fPc81ADvCb/e9fq59ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971179; c=relaxed/simple;
	bh=EgEVydC/a+MGqnqzvMswTVNdkQoPbsDQpWBCA74UAAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XX+g+SiD7LoYbcMWN4nnhZ4mKHYn69yyEm+yMQtskwdqO3gZx+7lZxW1F/XXYR0Q08gtmYxJy28yAdLjHn4xPv7jk846e253uK5CDFc6lxG8x7PxdjBAxShhzWZK39dy/F1Miwfz231nBZYulNX9qrmVtZ+ez9P8xYMyEntGEMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1i5BvLP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3476dcd9c46so5349351f8f.0;
        Wed, 24 Apr 2024 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713971176; x=1714575976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzJZr0V2v0getmVqm80bqd2e9vuZzQXvkJJl+LhrtKw=;
        b=c1i5BvLPCF7edmGFtb2RGEFH3mKkXiJZKuMhhhqE8BhJCSGX4msRTlSQhr5umctVG7
         Ni9Qqk+X2hfJ/U/GSkYHcGbbp1MQCBCq7tYrAQlqW6InKWYgLHTU/8iIcnx2PbnpIZJb
         R505gX76jSYmN9AQyU/pm2o1lCPJj/xiph+74HvfuugsYJqqcHXu86BUNbYCk+EQgroh
         fSxsjuyEaHrfJf7jdv9qZwbB/FFUtU0rPMYr5tFChgTxeDot27KxNBLoqXkGt94OsJEH
         AQVhX9WzKy18oM84e2v1KuRXGEMacc21nDQZjzNF8QNDgPRDMdzn/D2U/hNcz1Wbscff
         PgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713971176; x=1714575976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzJZr0V2v0getmVqm80bqd2e9vuZzQXvkJJl+LhrtKw=;
        b=tK3MwmibjIsfbRYSJkj0lbcrUN9qaDFfM+hstepM+zk3Z3gEAhoFZvDkb8nTAUyKww
         h0yyshnmN958+0sQeFUn5RKwH5cf68XGJGu3ti00/GdaCn9W9mBs+kWrVF/TwmxL1Eqt
         9Zhsowcf0FKlGd6vNtgZmTP44aJdtb58BKYqn46OmUzATwBp7yJuTHaGSIeV3EfY7Ul2
         gQxoy6VOYZ93m5MUjcqE3vPfxsSk2IV5fbg7hHHPfCWeqX3C61jCCfZL6fr2OD7upnYJ
         A/kq0pq6uJ5JpaGa8ohHDIv3QCj3ByArFuRbp7tNz3ifWI0mEh+tqbBlQJAVMXwqP4rT
         Jwmg==
X-Forwarded-Encrypted: i=1; AJvYcCVR846+Rw+UyjAvZOdfoP7OccyLrdPJgFGohulrokW6EnROekMd2BkL4RP4svvZtDoA04KR49iSt6EMyHb9oQlfB6Kql2iQwEWbE48E09aFw24W/7LTAkINWKovRUoclNXAuKnGieedw1mUA0pVdAZ5+p8IvqbDj+Bwlh7ryllv0pBc
X-Gm-Message-State: AOJu0Yyj4jl31R9JXQ6KjM9u1x147FQlfRsU31BaRLlUNU5BLqFLLLq2
	D2+hnTj1KPFc3h4AkM0m8V2djpQhHNzi1/XsD0RzFKkjLj4egOgVJy6M7ndovbUUEw5VuRJKZFC
	I26R3ru1oi8SPVC3QMkVvJ2gfczM=
X-Google-Smtp-Source: AGHT+IEUjkd5p7hpKwqKc+YJSo6KAHhbzfpms7poYO0nPTSZHFSsud27t10U+yKBi+mXLiLiYQCgUMRlPVgqzSHhE44=
X-Received: by 2002:a5d:5610:0:b0:343:b252:2222 with SMTP id
 l16-20020a5d5610000000b00343b2522222mr1819240wrv.6.1713971176030; Wed, 24 Apr
 2024 08:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org> <20240420-bpf_wq-v2-11-6c986a5a741f@kernel.org>
 <CAADnVQJ9Qw6Lr644xRTU-n16UkBCyHoTAQs7QqGiniOdsOVAJg@mail.gmail.com>
In-Reply-To: <CAADnVQJ9Qw6Lr644xRTU-n16UkBCyHoTAQs7QqGiniOdsOVAJg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Apr 2024 08:06:05 -0700
Message-ID: <CAADnVQKfzu1F=xZxyYhiocAn1iM=8f13Ca-2Jfht2dXsXuGu9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 11/16] bpf: wq: add bpf_wq_init
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 7:55=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Apr 20, 2024 at 2:10=E2=80=AFAM Benjamin Tissoires <bentiss@kerne=
l.org> wrote:
> >
> > We need to teach the verifier about the second argument which is declar=
ed
> > as void * but which is of type KF_ARG_PTR_TO_MAP. We could have dropped
> > this extra case if we declared the second argument as struct bpf_map *,
> > but that means users will have to do extra casting to have their progra=
m
> > compile.
> >
> > We also need to duplicate the timer code for the checking if the map
> > argument is matching the provided workqueue.
> >
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> >
> > ---
> >
> > FWIW, I still have one concern with this implementation:
> > - bpf_wq_work() access ->prog without protection, but I think this migh=
t
> >   be racing with bpf_wq_set_callback(): if we have the following:
> >
> >   CPU 0                                     CPU 1
> >   bpf_wq_set_callback()
> >   bpf_start()
> >                                             bpf_wq_work():
> >                                               prog =3D cb->prog;
> >
> >   bpf_wq_set_callback()
> >     cb->prog =3D prog;
> >     bpf_prog_put(prev)
> >     rcu_assign_ptr(cb->callback_fn,
> >                    callback_fn);
> >                                            callback =3D READ_ONCE(w->cb=
.callback_fn);
> >
> >   As I understand callback_fn is fine, prog might be, but we clearly
> >   have an inconstency between "prog" and "callback_fn" as they can come
> >   from 2 different bpf_wq_set_callback() calls.
> >
> >   IMO we should protect this by the async->lock, but I'm not sure if
> >   it's OK or not.
>
> I see the concern, but I think it's overkill.
> Here 'prog' is used to pass it into __bpf_prog_enter_sleepable_recur()
> to keep the standard pattern of calling into sleepable prog.
> But it won't recurse.
> We can open code migrate_disable,etc from there except this_cpu_inc_retur=
n,
> but it's an overkill.
> The passed 'prog' is irrelevant.
> If somebody tries really hard by having two progs sharing the same
> map with bpf_wq and racing to set_callback... I can see how
> prog won't match callback, but it won't make a difference.
> prog is not going trigger recursion check (unless somebody
> tries is obsessed) and not going to UAF.
> I imagine it's possible to attach somewhere in core wq callback
> invocation path with fentry, set_callback to the same prog,
> and technically it's kinda sorta recursion, but different subprogs,
> so not a safety issue.
> The code as-is is fine. imo.

After sleeping on it, I realized that the use of
__bpf_prog_enter_sleepable_recur() here is very much incorrect :(
The tests are passing only because we don't inc prog->active
when we run the prog via prog_run cmd.
Adding the following:
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index f6aad4ed2ab2..0732dfe22204 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1514,7 +1514,9 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
        }

        rcu_read_lock_trace();
+       this_cpu_inc_return(*(prog->active));
        retval =3D bpf_prog_run_pin_on_cpu(prog, ctx);
+       this_cpu_dec(*(prog->active));
        rcu_read_unlock_trace();

makes the test fail sporadically.
Or 100% fail when the kernel is booted with 1 cpu.

Could you send a quick follow up to
replace __bpf_prog_enter_sleepable_recur() with
        rcu_read_lock_trace();
        migrate_disable();
?

Or I'll do it in an hour or so.

