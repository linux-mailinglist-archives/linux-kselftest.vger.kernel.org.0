Return-Path: <linux-kselftest+bounces-48040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59064CECB4C
	for <lists+linux-kselftest@lfdr.de>; Thu, 01 Jan 2026 01:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14D8C301FF66
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jan 2026 00:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B119A207A32;
	Thu,  1 Jan 2026 00:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GwHgbc9r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1EB1F1932
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Jan 2026 00:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767227324; cv=none; b=nZKLIasr/e3nt864+YTNJpK9RPhDxFLLrQAQlmaec4tIGEv4400re+jPApdQQWUvK2PUWTI2y6XjhJ+oGCwu/MelcYEr5TnX+1Mzuf0u/rrzRfarAXunyoUgAYb9x9ruq/jf9uuGlgMeQQ6MuuhSeESeaW0x9mRasgasqaXOL2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767227324; c=relaxed/simple;
	bh=+kPcMSmk7R+Gdq2EzKirCklN8/HPtQfdcLKStyPOwlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmSjB9gqQp4g2To0HSq/shXydE46b5gvERzAE6fZo4VvBO6pkXF9oPqOBF5LKM5x1ms+uzqw0sneCZd2Oajna8b9ZQieiBAjE4F7tUNqFMd7Idb4NS+vldKKP146+6LQA0+QSj4GQCd4BmhHlnQ2b2H5X7hojJMZwh9YK7ScwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GwHgbc9r; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a08cb5e30eso21811185ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 16:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767227321; x=1767832121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2uWD+3+uKcWSebatXzToxK0XPCm9Txe1uJXgdjEiEI=;
        b=GwHgbc9r30Ug/mgssLkcZMbvvGVTEIKLD02ashIzCLtfm6ZCgTMRZW6nX+ldXWlhMO
         18m0rs+7ZizGE9ulyqa78mVGaPbsUs1NhfftCftyPExezEdexRD0QEMN/R6W+QPvATWe
         Ld+mCKpk1/dRRsnqU0CUEo8L0+UeSEJut4YtxkAKjlHDX7t5YB8e9fJTGEOdPjN3qGnR
         acEcVh1hqQNbzHUgxw2BDa9fURZZwe+2M/IS9VEJRARrlxkPBM71IdWz/Mm9G/LnLuMx
         tdl91nW0Ocdpir1EYE2CPjQhfsm0tT7hWQlQyQSVW9XVppr20DG1VRMUJjKQvTJXzAUt
         ROLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767227321; x=1767832121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S2uWD+3+uKcWSebatXzToxK0XPCm9Txe1uJXgdjEiEI=;
        b=eGi8arTFTDOorEaTyLk21YbeJuInj0vZm29HVYLAifqSMVPCLeuVlQ1BbJT0ubXukW
         +ynNUnqhObRyIVxUgnGQw44W6+4nJK8oM63/N0rI+mPOeOciumkyPikt9j9GF8co9yjd
         Sbe5kzeqAYt9R5yGxjjG2lXo3kSuQZ1b1aFkab90rXLdQf76fABLxyAZtxz3Nv9KbYxY
         16SkRj2vsBo0tm3ETW07pO8F/XkkO24pSaDAXkezBUsExA2qfRcMj6A4L+E38js9K1u5
         LUHSn42j0msuuxisGypL9kmBHtU+2j+AGccHZcleckk1r0CP2II3fCtj6J2Jkx2gP20s
         NCWw==
X-Forwarded-Encrypted: i=1; AJvYcCVTbQ8CfzACnFhda1xnCSkTTmwhWSqLZueoXWVn4a5hPNsyWgfmPoeAeF/NLd71dgPiAuHRwQ1ffxlJXZhJ2wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW6P8S8dnJ5RtIijAdqPn7PN+7JDcO5iCd/EBF6g98xq+WXt+a
	dN7S9oPoVTxCXSHZYgch36gn1SZ3cl2CwSDaDtAUoO/ms9NJ5TNeCaiVKRv7s54YuPQe1ebURZc
	bltM3fsAOx3go8dPRWJ3Y6TfNR4BvVTkfWfsoz7OmcA==
X-Gm-Gg: AY/fxX7RCXgdoBRKqpxR3QAP4NQcGzmiQ4go6Z9zhb1gbhcTc0MXbTDOjqBfAnpCtCg
	EZ57KYzwhaE3U/f2rnkQ+UdZu3Gf8rsfw78/oSzUHfqccNVPzIExEhDf5ZEqmlpqkBueJTO3L9t
	1SG5+TwFP7WwurUFPk5dS5alfzXbfFpIGB8wNJ9C0OXV8PU5ZcwfP246sCN4h7yDlEfeYEnWaDd
	7bDSsk38anf0pYhW6gsefGoXv/KGT3T28edOoHpTVLooZN8D2r1oov9HQxVoWErriCXvJiIajLJ
	ptJEERQ=
X-Google-Smtp-Source: AGHT+IFdBMje3pnEFdkXLIfnRWJ5hysTabkkamtVS8bCSG8FnqVHfzLw8gfE0QdSc/2hoIrXIja460pqGNnL6T+duQk=
X-Received: by 2002:a05:7022:f007:b0:11e:3e9:3e89 with SMTP id
 a92af1059eb24-12172312c16mr18360486c88.7.1767227320930; Wed, 31 Dec 2025
 16:28:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231173633.3981832-6-csander@purestorage.com>
 <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
 <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com> <CAADnVQKXUUNn=P=2-UECF1X7SR+oqm4xsr-2trpgTy1q+0c5FQ@mail.gmail.com>
In-Reply-To: <CAADnVQKXUUNn=P=2-UECF1X7SR+oqm4xsr-2trpgTy1q+0c5FQ@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 31 Dec 2025 19:28:29 -0500
X-Gm-Features: AQt7F2r4zx9aMRYNSaKUcm0Gdej6msD8c2I3CLYONDae3Dt0B2iooTor-dsXV_A
Message-ID: <CADUfDZq5Bf8mVD9o=VHsUqYgqyMJx82_fhy73ZzkvawQi2Ko2g@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "D. Wythe" <alibuda@linux.alibaba.com>, 
	Dust Li <dust.li@linux.alibaba.com>, sidraya@linux.ibm.com, wenjia@linux.ibm.com, 
	mjambigi@linux.ibm.com, Tony Lu <tonylu@linux.alibaba.com>, guwen@linux.alibaba.com, 
	Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, sched-ext@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 10:13=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 31, 2025 at 10:09=E2=80=AFAM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Wed, Dec 31, 2025 at 10:04=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
> > >
> > > > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > > index 90c4b1a51de6..5e460b1dbdb6 100644
> > > > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > >
> > > [ ... ]
> > >
> > > > @@ -1275,7 +1275,7 @@ bpf_testmod_ops__test_return_ref_kptr(int dum=
my, struct task_struct *task__ref,
> > > >       return NULL;
> > > >  }
> > > >
> > > > -static struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > > > +static const struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > > >       .test_1 =3D bpf_testmod_test_1,
> > > >       .test_2 =3D bpf_testmod_test_2,
> > >
> > > Is it safe to make __bpf_testmod_ops const here? In bpf_testmod_init(=
),
> > > this struct is modified at runtime:
> > >
> > >     tramp =3D (void **)&__bpf_testmod_ops.tramp_1;
> > >     while (tramp <=3D (void **)&__bpf_testmod_ops.tramp_40)
> > >         *tramp++ =3D bpf_testmod_tramp;
> > >
> > > Writing to a const-qualified object is undefined behavior and may cau=
se a
> > > protection fault when the compiler places this in read-only memory. W=
ould
> > > the module fail to load on systems where .rodata is actually read-onl=
y?
> >
> > Yup, that's indeed the bug caught by KASAN. Missed this mutation at
> > init time, I'll leave __bpf_testmod_ops as mutable.
>
> No. You're missing the point. The whole patch set is no go.
> The pointer to cfi stub can be updated just as well.

Do you mean the BPF core code would modify the struct pointed to by
cfi_stubs? Or some BPF struct_ops implementation (like this one in
bpf_testmod.c) would modify it? If you're talking about the BPF core
code, could you point out where this happens? I couldn't find it when
looking through the handful of uses of cfi_stubs (see patch 1/5). Or
are you talking about some hypothetical future code that would write
through the cfi_stubs pointer? If you're talking about a struct_ops
implementation, I certainly agree it could modify the struct pointed
to by cfi_stubs (before calling register_bpf_struct_ops()). But then
the struct_ops implementation doesn't have to declare the global
variable as const. A non-const pointer is allowed anywhere a const
pointer is expected.

Thanks,
Caleb

