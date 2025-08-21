Return-Path: <linux-kselftest+bounces-39424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9F5B2EAE4
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 03:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D4D1CC2138
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 01:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2413A258ECE;
	Thu, 21 Aug 2025 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qm7PcABH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A16257435;
	Thu, 21 Aug 2025 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740435; cv=none; b=CTq2hSfaFRj61H1XGbsTOLZtj1ZZRAqnIK0PU7TLA0q1nAl8oOJyY/z7xmvpqvUsGes9tpERb2gVsBFJr/bwT9PXz0gZvwyrjY4+1Y+nwglAy83kYQHT9OsJy3bS3I1dvcv7d/Gun9mxvAgkVIhwaL5ShIcbWzjOQ/uCXEEz1lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740435; c=relaxed/simple;
	bh=7NzyyKQFr2eofSiUjDElzqtXmnS6djl6vapXpPdAlP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKmgR/eMr19tcQt0ke5ssFLNZ8Z7vCrWxjgtmzF0KUfuX/oECk8dj8bir+v6dhHCnvSKtlnVWpjOKvppf8usGUuxIrwHjGDTFw/KRflezxK0qNxI1+//AwY1LBZy5k3WHTyL8NCN5/ouGIJ/+7HrAgm967Pp1qpuJk2Hd+BwvpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qm7PcABH; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-71d60501806so3988927b3.2;
        Wed, 20 Aug 2025 18:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755740432; x=1756345232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vItjwoBGwkZfqnVBm2Rd+0n8q7fmA/zGpzfuFKRm3Sw=;
        b=Qm7PcABHRSLa9kdGRUeJiSV5gRET6lM/uTAxW4T4GbORQJWPpv/PCC6VmkEWyiaCru
         CTkwslmpPmloc0C4yy3cB7w6GRT8O00gDnEqOU/twqh/AlXXZx7FElisiWZFewEVTsvb
         /KNMwk9R2odsYE4JhlFtYo48Br3L9odePKy2f7IPxTSIWhcvPkRn4/ouhfBrH1bVCXgy
         dZk50njNajSu6rSzZU5/4HV3wHpRMpF9iTIkk7DG/9W4RSTJmhacvtDOF7TFN17zhadX
         z9KRR2hM/eTKoXBTSNBq/lpB80509605Ifp454uz+yZJeqv3IR879hesKR/xV+MKI1xN
         LUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755740432; x=1756345232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vItjwoBGwkZfqnVBm2Rd+0n8q7fmA/zGpzfuFKRm3Sw=;
        b=ME54X5Vn7A0Y8+Eb6HZMUtW2ZHvqtYm497+PhFE5/JLAiGmiCcy1ATeq8jmJXX1L/q
         LbhkNvrWjndC4+sK3gsU1WjiVahKe2tXEVGR2DcwOXACuL6hJerFT5TTz5HCFXFjQebR
         SkVzzipoN69xCpyaNJ4/oZLf0swzR4mHub/Wd30jN5DO1hGuLNZkcglgfi9KBt+mN5M2
         eVbdgxfV8ZwNDZjjXYJWYVHGvjvNkkSRrRYjn9T7/b28C3XUy22PIvTJFemxyXNq8oxm
         Bre/+V438lxacQ7ii2o8Ityy2gOM0gvTtusF6SuApeukKiEY0lE8weXCXlvptyzIDQyF
         xkJA==
X-Forwarded-Encrypted: i=1; AJvYcCUm2AHilC0pzlSfDFozvFr0urneH+AKjbmGWEsITfmvq7MRoccKNfw0PgIY6DFHqj5flF97X6UI@vger.kernel.org, AJvYcCW117sPvOuBvyWe2FliqjA32S5j8HbyzjFUedug3h3gsWewobdVoPS5DjhXWsG8M9gfRWFnaU4DGTAPvtsqu73f@vger.kernel.org, AJvYcCW72sfT8LtTkPL50+rYJm/E8hnun66OciHptjqtkt40ZC3rRZB2CeaGE5pPclNsBzAV8Dny7COCGuZNUwYt@vger.kernel.org, AJvYcCWw0QWyqp/6933TZloF1GrLmxOWW9ym5ZqLlPuF4VQcQqCW0ycR78YWPrvMEhfI72U0FjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2Iog2QLoo5AaEcgU5MtjCNF5r/w6GHpvhm8httHsXgVMLvNL
	vD0CPSAGdACUr2Hr3iH+QH+VNiHeXrSjtjExjeYUWGerdNGbAKPzJs49sp1YHcJ4rl58GpEHZYS
	FqqTup7qMlfJAnLfUWuPIJu4GOHsFtHE=
X-Gm-Gg: ASbGncs4Kwz1auuo4Tp0ia/vU3FrSmwArdcq9naXgWWUjd4BMisrsZ/fNKz4S9hQmIS
	bBDrOM9YB3V2SN6Eixy7jXhpCB+R7p9hx4vyUQNz6AXsBzM/ip5/7lHnLZs/PVYVaAZzz3Zxi0N
	91PXIjN6XJsi603/G2pGsDXqs2znu9IvRnOzr9qEKdkOyWtO3b8T7z/g9qE+3TZ2KtRuo5Sj818
	zzHq+IfeS0=
X-Google-Smtp-Source: AGHT+IFNgH4nfyrA8IG4t0dWjyf/2STD4SIQw2irwD7LYdlGT6ENNd6k1P3j/VAb9T9DkpftmcAFxSshvy3X+fIMUL4=
X-Received: by 2002:a05:690c:4c09:b0:719:f37e:e69c with SMTP id
 00721157ae682-71fc89dd72emr10794537b3.36.1755740432267; Wed, 20 Aug 2025
 18:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819033956.59164-1-dongml2@chinatelecom.cn>
 <20250819033956.59164-4-dongml2@chinatelecom.cn> <CAEf4BzZOC6Zyo9sikPJH+0Xz=aCbx=dBM_RksYZMaZM4ndR+OA@mail.gmail.com>
In-Reply-To: <CAEf4BzZOC6Zyo9sikPJH+0Xz=aCbx=dBM_RksYZMaZM4ndR+OA@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 21 Aug 2025 09:40:21 +0800
X-Gm-Features: Ac12FXyC839nqzgjfLwuVWAeVwrtOk_JF8yPaPJInPdSwaHlsMvt96BJQKQzZnE
Message-ID: <CADxym3ZgRE-AN0YC50izuO63ipA-bc_Y+JAOMfJq8T3i7mKTzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add benchmark testing for kprobe-multi-all
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 6:54=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Aug 18, 2025 at 8:40=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > For now, the benchmark for kprobe-multi is single, which means there is
> > only 1 function is hooked during testing. Add the testing
> > "kprobe-multi-all", which will hook all the kernel functions during
> > the benchmark. And the "kretprobe-multi-all" is added too.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  tools/testing/selftests/bpf/bench.c           |  4 ++
> >  .../selftests/bpf/benchs/bench_trigger.c      | 54 +++++++++++++++++++
> >  .../selftests/bpf/benchs/run_bench_trigger.sh |  4 +-
> >  .../selftests/bpf/progs/trigger_bench.c       | 12 +++++
> >  tools/testing/selftests/bpf/trace_helpers.c   |  3 ++
> >  5 files changed, 75 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selfte=
sts/bpf/bench.c
> > index ddd73d06a1eb..29dbf937818a 100644
> > --- a/tools/testing/selftests/bpf/bench.c
> > +++ b/tools/testing/selftests/bpf/bench.c
> > @@ -510,6 +510,8 @@ extern const struct bench bench_trig_kretprobe;
> >  extern const struct bench bench_trig_kprobe_multi;
> >  extern const struct bench bench_trig_kretprobe_multi;
> >  extern const struct bench bench_trig_fentry;
> > +extern const struct bench bench_trig_kprobe_multi_all;
> > +extern const struct bench bench_trig_kretprobe_multi_all;
> >  extern const struct bench bench_trig_fexit;
> >  extern const struct bench bench_trig_fmodret;
> >  extern const struct bench bench_trig_tp;
> > @@ -578,6 +580,8 @@ static const struct bench *benchs[] =3D {
> >         &bench_trig_kprobe_multi,
> >         &bench_trig_kretprobe_multi,
> >         &bench_trig_fentry,
> > +       &bench_trig_kprobe_multi_all,
> > +       &bench_trig_kretprobe_multi_all,
> >         &bench_trig_fexit,
> >         &bench_trig_fmodret,
> >         &bench_trig_tp,
> > diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools=
/testing/selftests/bpf/benchs/bench_trigger.c
> > index 82327657846e..c6634a64a7c0 100644
> > --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > @@ -226,6 +226,58 @@ static void trigger_fentry_setup(void)
> >         attach_bpf(ctx.skel->progs.bench_trigger_fentry);
> >  }
> >
> > +static void attach_ksyms_all(struct bpf_program *empty, bool kretprobe=
)
> > +{
> > +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> > +       char **syms =3D NULL;
> > +       size_t cnt =3D 0;
> > +
> > +       if (bpf_get_ksyms(&syms, &cnt, true)) {
> > +               printf("failed to get ksyms\n");
>
> we seem to be using fprintf(stderr, "...") for emitting errors like
> this (at least in some benchmarks, and it makes sense to me). Do the
> same?

OK!

>
> > +               exit(1);
> > +       }
> > +
> > +       printf("found %zu ksyms\n", cnt);
>
> stray debug output?

OK!

Thanks!
Menglong Dong

>
> > +       opts.syms =3D (const char **) syms;
> > +       opts.cnt =3D cnt;
> > +       opts.retprobe =3D kretprobe;
> > +       /* attach empty to all the kernel functions except bpf_get_numa=
_node_id. */
> > +       if (!bpf_program__attach_kprobe_multi_opts(empty, NULL, &opts))=
 {
> > +               printf("failed to attach bpf_program__attach_kprobe_mul=
ti_opts to all\n");
> > +               exit(1);
> > +       }
> > +}
> > +
>
> [...]

