Return-Path: <linux-kselftest+bounces-13516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D892DAA2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 23:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97298B20DE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 21:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118512D1F1;
	Wed, 10 Jul 2024 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djnjfIW1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C638120F;
	Wed, 10 Jul 2024 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646515; cv=none; b=K5kHlyJPQcCGt6LywUiFc9NwkhfMj5o0OCo22FimnyT3oFxlDDB0enKEJXNhb9AdnnGjBlhItFsoYrGhuQx5tuITLcXMgFp+Mk/oqyHmOLT5Hz/QnmJFSu5boImlvVfJiO31eH4WvimQqOd4EhFygv6AUpI67wPqNVJJk63yReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646515; c=relaxed/simple;
	bh=6Wnz5eF60ejRW26DHlhxGE1i9g2UxFb7NDrkpGayFEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsobGU/iIntK9aYz4J743nG0aK2LdlE8GgAZYJj9vhkBYBdYKz7Yx5Bkm2PLRbb2GfYXgqWSi0ObbatHolY8sHQKi97nhFVpX+BvhtiqSII8rCAhdNMSx1H7MzwEozV1FROMkklxjXJx2gAJyJAzF0YvY72jcnDolP6CxsEtfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djnjfIW1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77e2f51496so39318166b.0;
        Wed, 10 Jul 2024 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646512; x=1721251312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7dfLXmdXQpbgbVC6DUm3K+U3MfZya3nfYifoRkydI4=;
        b=djnjfIW1MWXELvAvOIhmEHIDtT0ugKWIRHV6dDTwBPIaGE5FVBdfRH0dtc3esQ1y5u
         krN5kgYI6Ry0UA87PfDmlN1wthitQl9tWOv5aYi8Yn5BLURG3yeeM1Takfeu4NhkDjgg
         HtYGaC53kLFTSfiC5DtYsHHjGVuBDBSZUZxquOruDlXk3YA2y+1+mNn/25iLPvJHu+ZM
         XBMb3wfEsGq9NCCOPRTcAlIW3Jd9lhoB7XfHOEa9QplgDdmWdgE+ul9yTEhnyVpGGhHK
         aqeftaxJ63OarpsQmMUe36vkDo2zHjQgIbaJ9HfjSmDmAxIQMPh8004BRs7fl5vSEOl1
         zcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646512; x=1721251312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7dfLXmdXQpbgbVC6DUm3K+U3MfZya3nfYifoRkydI4=;
        b=uK4JUiHg2gFeZerWy9T64BtFXHYuz+7j+JIzEPQwZEfI/ws2J70C7XAiT753yIqOcl
         aPlpwGsoS9jEaGyLoTjaF/dN/c2npHjadvNZoN43Tmz6if6RkfE6jfEmPWdiJalJ6lFv
         5/c12lhpad1P+HFQWZgPWRAyQPc/O/gmBzJ5ID0Z6+qH7bZWEfInI6JiQN5xP7gisWJ+
         Qfp4tHAmi2gNtR4oqfplenisuKHCulE4WCgU6fMP+VzaopY37sYxf4P5hl+NFLERBwWw
         dczdxmniQnKA4f4FSGp2gGEASKmBJoIVVm+F9Tv0JOj54Gl0JdtIEG8WQ4xgMJbNNQAv
         4VbA==
X-Forwarded-Encrypted: i=1; AJvYcCUqLxfPag4dRGkTRDFBO1QdRTW7KIjs/+PhLLHmuJ197fbymxZXACmTB1YfTrgK8MqPRsc02XMIYg7nDO25rxsrdrqwduOpYB13KoxNMKO0lKr7kj1HeMlEwmBvden+UJaw7jUbzuPV2wDT39oLi3XzM9eBJCwMl2RZRFAT20s52pY89Tm7RvPinmhzZjDEv8DXqdg56nuB5FCeuXBvZpZv5uiwPg==
X-Gm-Message-State: AOJu0YwWrTxhIf7L2+Hmt6MoRNgsBk6WsgcPl1wu0IBCkWNP1FR1fKNI
	XJ8T9wKdzYqESJ2hipdrvLqcxoAt4lRtlcBwP9oQsSwRQTOfTVHL1Eh/o6ZU6DCLlfPAZzW7e7Z
	0F97YbyMNbpTy+5Jk4ItUTFtW72s=
X-Google-Smtp-Source: AGHT+IFNlED4hD9ltutwLd15CEICSWnXQJdFn624pZNHo6QN6KygEMoGeZGSgSPGHD4DOEam2/T9znfKW3OUUCihAKA=
X-Received: by 2002:a17:906:dc93:b0:a77:e1fb:7de9 with SMTP id
 a640c23a62f3a-a780b68aabfmr471046866b.5.1720646511764; Wed, 10 Jul 2024
 14:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709005142.4044530-1-liaochang1@huawei.com>
 <20240709005142.4044530-2-liaochang1@huawei.com> <CAEf4BzYDrVJXnAruko-h5-oXCGuZ92x4KnY-2cD=XXBp1U_kBg@mail.gmail.com>
 <2336576e-1ed4-cd5e-5535-2d9b88218dae@huawei.com>
In-Reply-To: <2336576e-1ed4-cd5e-5535-2d9b88218dae@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 14:21:36 -0700
Message-ID: <CAEf4BzYDvh2Ynrttk4NLyCGB8AVM2d-2tKSzRZF_cXVA80qucw@mail.gmail.com>
Subject: Re: [PATCH 1/2] uprobes: Optimize the return_instance related routines
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, mykolal@fb.com, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 1:19=E2=80=AFAM Liao, Chang <liaochang1@huawei.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/7/10 7:55, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Mon, Jul 8, 2024 at 6:00=E2=80=AFPM Liao Chang <liaochang1@huawei.co=
m> wrote:
> >>
> >> Reduce the runtime overhead for struct return_instance data managed by
> >> uretprobe. This patch replaces the dynamic allocation with statically
> >> allocated array, leverage two facts that are limited nesting depth of
> >> uretprobe (max 64) and the function call style of return_instance usag=
e
> >> (create at entry, free at exit).
> >>
> >> This patch has been tested on Kunpeng916 (Hi1616), 4 NUMA nodes, 64
> >> cores @ 2.4GHz. Redis benchmarks show a throughput gain by 2% for Redi=
s
> >> GET and SET commands:
> >>
> >> ------------------------------------------------------------------
> >> Test case       | No uretprobes | uretprobes     | uretprobes
> >>                 |               | (current)      | (optimized)
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> Redis SET (RPS) | 47025         | 40619 (-13.6%) | 41529 (-11.6%)
> >> ------------------------------------------------------------------
> >> Redis GET (RPS) | 46715         | 41426 (-11.3%) | 42306 (-9.4%)
> >> ------------------------------------------------------------------
> >>
> >> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >> ---
> >>  include/linux/uprobes.h |  10 ++-
> >>  kernel/events/uprobes.c | 162 ++++++++++++++++++++++++---------------=
-
> >>  2 files changed, 105 insertions(+), 67 deletions(-)
> >>
> >
> > [...]
> >
> >> +static void cleanup_return_instances(struct uprobe_task *utask, bool =
chained,
> >> +                                    struct pt_regs *regs)
> >> +{
> >> +       struct return_frame *frame =3D &utask->frame;
> >> +       struct return_instance *ri =3D frame->return_instance;
> >> +       enum rp_check ctx =3D chained ? RP_CHECK_CHAIN_CALL : RP_CHECK=
_CALL;
> >> +
> >> +       while (ri && !arch_uretprobe_is_alive(ri, ctx, regs)) {
> >> +               ri =3D next_ret_instance(frame, ri);
> >> +               utask->depth--;
> >> +       }
> >> +       frame->return_instance =3D ri;
> >> +}
> >> +
> >> +static struct return_instance *alloc_return_instance(struct uprobe_ta=
sk *task)
> >> +{
> >> +       struct return_frame *frame =3D &task->frame;
> >> +
> >> +       if (!frame->vaddr) {
> >> +               frame->vaddr =3D kcalloc(MAX_URETPROBE_DEPTH,
> >> +                               sizeof(struct return_instance), GFP_KE=
RNEL);
> >
> > Are you just pre-allocating MAX_URETPROBE_DEPTH instances always?
> > I.e., even if we need just one (because there is no recursion), you'd
> > still waste memory for all 64 ones?
>
> This is the truth. On my testing machines, each struct return_instance da=
ta
> is 28 bytes, resulting in a total pre-allocated 1792 bytes when the first
> instrumented function is hit.
>
> >
> > That seems rather wasteful.
> >
> > Have you considered using objpool for fast reuse across multiple CPUs?
> > Check lib/objpool.c.
>
> After studying how kretprobe uses objpool, I'm convinced it is a right so=
lution for
> managing return_instance in uretporbe. While I need some time to fully un=
derstand
> the objpool code itself and run some benchmark to verify its performance.
>
> Thanks for the suggestion.

Keep in mind that there are two patch sets under development/review,
both of which touch this code. [0] will make return_instance
variable-sized, so think how to accommodate that. And [1] in general
touches a bunch of this code. So I'd let those two settle and land
before optimizing return_instance allocations further.

  [0] https://lore.kernel.org/linux-trace-kernel/20240701164115.723677-1-jo=
lsa@kernel.org/
  [1] https://lore.kernel.org/linux-kernel/20240708091241.544262971@infrade=
ad.org/

>
> >
> >> +               if (!frame->vaddr)
> >> +                       return NULL;
> >> +       }
> >> +
> >> +       if (!frame->return_instance) {
> >> +               frame->return_instance =3D frame->vaddr;
> >> +               return frame->return_instance;
> >> +       }
> >> +
> >> +       return ++frame->return_instance;
> >> +}
> >> +
> >> +static inline bool return_frame_empty(struct uprobe_task *task)
> >> +{
> >> +       return !task->frame.return_instance;
> >>  }
> >>
> >>  /*
> >
> > [...]
>
> --
> BR
> Liao, Chang

