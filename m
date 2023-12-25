Return-Path: <linux-kselftest+bounces-2419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEBE81E268
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Dec 2023 22:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE6D1F21BC3
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Dec 2023 21:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0318753E08;
	Mon, 25 Dec 2023 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niNTzoT6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C14B5380C;
	Mon, 25 Dec 2023 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a269a271b5bso445045866b.1;
        Mon, 25 Dec 2023 13:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703538692; x=1704143492; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=96Ko3eY3xXoKjAdhSw7RsR0tAE0Sb6423t1pU5bzP/w=;
        b=niNTzoT69zVtnwOsVoIom7Od/dNtQu5sXu5cV/2zTltGCYYPv5rgtnQtM9G3ovIGHQ
         FypHZ7tI2wMRMYEhz/CZsT5cffNHQ/eogGiWaVHvprqMtjNIM09GBZ5+3/TnDlseui3V
         REO9BYOCUk9lIBtmF0yZL62g8c+RicMI3NsRlsmiVOElaUUxBuFQBUWTiXjOPnQV3SXc
         bHC6dzshL29SoeYirwJITtiNVgPA5O/59dYMZgKQt2bpeZNcB//3u2yKq83g8+D+HqYF
         EniyhshaF5g7tlXpon508DS2sJfR40S/Rxt6GF+wEcX8sJmZBzYUJfKk3bbeZbVj1K5e
         Y0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703538692; x=1704143492;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96Ko3eY3xXoKjAdhSw7RsR0tAE0Sb6423t1pU5bzP/w=;
        b=UnFQvpkum8/DWp1kHnIOf6yCBQS4/YhKh+Z/1O+rBFDg81F3+XK10D6rifMPLd8LEl
         a4qZupvUWu6E2M6gPxROlPvrJDki8aWWs2R+vEJXkqK/dJQkpZwp/dCmLzaxqeB2cvOU
         ha184b+4wfPq8YesF43kSRRco2JRFteEmwBsKJmddpUflCuo4OgEvYdezb6JUn/Myz02
         o9LF6CxZxW41OSeTaPbu51H66LP2JITvQTuL7tHR+GXDXbixEKWjEagY5kkMKGV5y4gx
         r4X5DCoBDMJ2Cmkoq5E9pKenBGehJobCLVG5LoNiFFmFqQw9EqlORNIEpS0dEFyf+6QV
         wqww==
X-Gm-Message-State: AOJu0YwK6XaPeZ0rn2OOfmNqmPxRtcfMmCuj7GjX7BH1TCXXalBNxl4d
	UkMWMLzYLYY8fJbaofvtvTc=
X-Google-Smtp-Source: AGHT+IE11RKQ6DVzmxbOBrw9Vr0UFckTspqTvImzjYQAz7e7hMcch6gQZ2JtT6GRUNxjjXkQAAUS/A==
X-Received: by 2002:a17:906:51d1:b0:a26:f1fc:399e with SMTP id v17-20020a17090651d100b00a26f1fc399emr596785ejk.49.1703538692295;
        Mon, 25 Dec 2023 13:11:32 -0800 (PST)
Received: from localhost ([185.220.101.80])
        by smtp.gmail.com with ESMTPSA id k3-20020a1709065fc300b00a26aad1f920sm4571122ejv.90.2023.12.25.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 13:11:31 -0800 (PST)
Date: Mon, 25 Dec 2023 23:11:30 +0200
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: Re: [PATCH bpf-next 08/15] bpf: Assign ID to scalars on spill
Message-ID: <ZYnwAt941SOohbzx@mail.gmail.com>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
 <20231220214013.3327288-9-maxtram95@gmail.com>
 <CAADnVQ+6MjSLRq5hFy=kHosoWR=RDOSuU1znCrkcRp-WeD5CMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+6MjSLRq5hFy=kHosoWR=RDOSuU1znCrkcRp-WeD5CMw@mail.gmail.com>

On Sun, 24 Dec 2023 at 19:15:42 -0800, Alexei Starovoitov wrote:
> On Wed, Dec 20, 2023 at 1:40 PM Maxim Mikityanskiy <maxtram95@gmail.com> wrote:
> >
> > From: Maxim Mikityanskiy <maxim@isovalent.com>
> >
> > Currently, when a scalar bounded register is spilled to the stack, its
> > ID is preserved, but only if was already assigned, i.e. if this register
> > was MOVed before.
> >
> > Assign an ID on spill if none is set, so that equal scalars could be
> > tracked if a register is spilled to the stack and filled into another
> > register.
> >
> > One test is adjusted to reflect the change in register IDs.
> >
> > Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> > ---
> >  kernel/bpf/verifier.c                                     | 8 +++++++-
> >  .../selftests/bpf/progs/verifier_direct_packet_access.c   | 2 +-
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b757fdbbbdd2..caa768f1e369 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4503,9 +4503,15 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
> >
> >         mark_stack_slot_scratched(env, spi);
> >         if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) && env->bpf_capable) {
> > +               bool reg_value_fits;
> > +
> > +               reg_value_fits = get_reg_width(reg) <= BITS_PER_BYTE * size;
> > +               /* Make sure that reg had an ID to build a relation on spill. */
> > +               if (reg_value_fits)
> > +                       assign_scalar_id_before_mov(env, reg);
> 
> Thanks.
> I just debugged this issue as part of my bpf_cmp series.
> 
> llvm generated:
> 
> 1093: (7b) *(u64 *)(r10 -96) = r0     ;
> R0_w=scalar(smin=smin32=-4095,smax=smax32=256) R10=fp0
> fp-96_w=scalar(smin=smin32=-4095,smax=smax32=256)
> ; if (bpf_cmp(filepart_length, >, MAX_PATH))
> 1094: (25) if r0 > 0x100 goto pc+903          ;
> R0_w=scalar(id=53,smin=smin32=0,smax=umax=smax32=umax32=256,var_off=(0x0;
> 0x1ff))
> 
> the verifier refined the range of 'r0' here,
> but the code just read spilled value from stack:
> 
> 1116: (79) r1 = *(u64 *)(r10 -64)     ; R1_w=map_value
> ; payload += filepart_length;
> 1117: (79) r2 = *(u64 *)(r10 -96)     ;
> R2_w=scalar(smin=smin32=-4095,smax=smax32=256) R10=fp0
> fp-96=scalar(smin=smin32=-4095,smax=smax32=256)
> 1118: (0f) r1 += r2 ;
> R1_w=map_value(map=data_heap,ks=4,vs=23040,off=148,smin=smin32=-4095,smax=smax32=3344)
> 
> And later errors as:
> "R1 min value is negative, either use unsigned index or do a if (index
> >=0) check."
> 
> This verifier improvement is certainly necessary.

Glad that you found it useful!

> Since you've analyzed this issue did you figure out a workaround
> for C code on existing and older kernels?

Uhm... in my case (Cilium, it was a while ago) I did some big change
(reorganized function calls and revalidate_data() calls) that changed
codegen significantly, and the problematic pattern disappeared.

I can suggest trying to play with volatile, e.g., declare
filepart_length as volatile; if it doesn't help, create another volatile
variable and copy filepart_length to it before doing bpf_cmp (copying
reg->reg will assign an ID, but I'm not sure if they'll still be in
registers after being declared as volatile).

Unfortunately, I couldn't reproduce your issue locally, so I couldn't
try these suggestions myself. Is this the right code, or should I take
it from elsewhere?

https://patchwork.kernel.org/project/netdevbpf/list/?series=812010

What LLVM version do you see the issue on? I can try to look for a
specific C workaround if I reproduce it locally.

BTW, the asm workaround is obvious (copy reg to another reg to assign an
ID), so maybe an inline asm like this would do the thing?

asm volatile("r8 = %0" :: "r"(filepart_length) : "r8");

