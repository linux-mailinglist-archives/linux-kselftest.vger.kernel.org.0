Return-Path: <linux-kselftest+bounces-38603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D25DB1ECF8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 18:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D174618C7E20
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBA4287260;
	Fri,  8 Aug 2025 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMHbt8Kg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F557404E;
	Fri,  8 Aug 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754670435; cv=none; b=j3ihOVWh2SKI83AYhqwNUCUEZ/8CvhlKxhYocNkZKQB3CC28WHvnodmO6Xg//B3aU/cEf6yXxGI2Lxpctyl9vLNJcJJx/xVO/KuOscR7YaT5Pwe5lkJRzPfr2No6fQjvl3Gj/nPu33QEGKtjH4BpGvVdYX0i9bwOWGjJYQQ8f8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754670435; c=relaxed/simple;
	bh=rsp2CxpjFFLCkiLGoLnap1Vg9OnjX7p0W0tcn0Wnx3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mf1ze+Xe8hhDtP/Fozeh2xGH/fdzrE1+xBtVw+Qs2eK8r4blT8NNHSKaRfhSWkfJXD7afqDmEqVvHXz5lI4ovfyZoPp1MIb5T4eFGsi0p4Kad4m7U2r25M6tZ6moWUYXmEHflp0Hk830bSA3Mf7N5xmeCf/X06ryQAjINqp8nw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMHbt8Kg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-459e210bd2dso11544095e9.1;
        Fri, 08 Aug 2025 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754670432; x=1755275232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KvPmLkGGbt5wH+Uu1Ks9PURZhNKr1xUfeioKrI5T5E=;
        b=YMHbt8KgR1kWKbshXZjQFjr4RA3OQj3loz/N6DyB+EwbZhNk6EFATxbPfJpS4Xixrn
         CNleeeIJtzIaIc8HC3AoAnSUiLR5b0wr7gI8l93yfgtQevNqPMPs+WmzURXmq3dg8gup
         ixgK/6f1+Z7MI1hTPQOQMMdv73txLENp6k9u8SbaEMGNg2MuVFNrC5C6pMWX3V/3Bc3S
         O4XbrVKpFSc2u2pTT8plUIFtglXrJSc/jYLfZ4L2fglCMAF1Hocp+BdLoj8dP1WRk/N9
         x6coXJb8B7ER+LMoGmIOYpwEJHiRz7jvqyjlVkYZ+5SRHwVKtOArRdaE+MguL/apR8H3
         Efxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754670432; x=1755275232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KvPmLkGGbt5wH+Uu1Ks9PURZhNKr1xUfeioKrI5T5E=;
        b=NzICaiIVLyZsn1EWIk6aHIdOJ2y4ssYlEC057QHCJcsZky8hEmsdjnHBeAqiQ92ZFh
         xuDuoL2QlV6BxDsJQnuR/buGPG6YoIszQ/bqUfK6PsJetAyPMnhzyLyuDchfZvHDdC7m
         bPAgeGict7rkbRvhaEvAlNdEbeDWWWzACqfvTr6rPWoW8/f5sMKwX1PDhGob1NdtOOux
         Ca/HF+/MHXml5sfn8qGnr+UM2jYvLMSpSdgB3F0RSFFSELHEXQLilyq5uS/7Q9e6ghfR
         jttfkx51U/GI2B3doNFz0SYURple//Nw/Ms+glYz9sSkUGoPcv8Y3UaZr66v6wuscrnQ
         cG4w==
X-Forwarded-Encrypted: i=1; AJvYcCV4tMTquVxI3JMI0sdoqup36BlStutwrLGxyw1T3y7Fcg6NDMXy5pWJM3KjV+6DEHX3TlKbgxgD8O4Ba+eE+KHJ@vger.kernel.org, AJvYcCVnrs25p/pG7jHIqb3CJGBWDf8Y8YyCMSrmLQoCM4gx8WonITQg3iTbxsaYCu7K9qtKx/SS0Hi8wzE5gIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaqRZW9sSSAArMCjbNaIYlC7J6WgyHwDmFFNT4pz9UFDKSwr81
	KcHyNicDTLMj0kbfHW/Z+1+wTJZzfc2BuksZbjLdK9bBRuqsdUvjPHsWHx8iZYDkMONOeK3gOii
	2y0rYJ+q0pIoUzpsoh7IAv3F2o59F/diPciHC
X-Gm-Gg: ASbGncvu/+wDEOgZmkm5UvgPEAyDU/i9LcEBBs7D80M8bRZdJaaLI4esq1M11csVLfR
	h5aiwNxjKwFFnDWADqj6zQ5jhJOsuRexUa0yV+i+Efo3mtFBJ141S8sC21QYxQtgdqWCuKEoPBZ
	7jnBwthAFTIXxXvyt/A1TVr0w2KzQkLLpIDPOqEW1LrlRi4F3crn8BAM1T+NsKogC8LdH7BNew9
	05W247IW91P/St9yTjeUiehr/3KW7pIxD6bGwxLFzz/XVQ=
X-Google-Smtp-Source: AGHT+IG9Evme4aHcdd6nrYR5lZeD6wADDRvFIyfNrpJoFoo1P/bytzRZ+hiKKbt7rFJTSNZ0YmLP6QuxRsz+uT1OYSE=
X-Received: by 2002:a05:6000:18a6:b0:3a4:f7dd:6fad with SMTP id
 ffacd0b85a97d-3b900fdd6femr2888237f8f.14.1754670432326; Fri, 08 Aug 2025
 09:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805062747.3479221-1-skb99@linux.ibm.com> <20250805062747.3479221-7-skb99@linux.ibm.com>
 <CAADnVQ+BoEMQ3i01YpzdNPAaL_mdNogkvHp0Ef73TBG8w726Zw@mail.gmail.com> <aJYXs90cMv/HC9A1@linux.ibm.com>
In-Reply-To: <aJYXs90cMv/HC9A1@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Aug 2025 09:27:01 -0700
X-Gm-Features: Ac12FXyUvmh7-9ppO5lCcBpJ1aArsrK9_eldp5dwMUa-0rnnH5koo3huzlHvDh4
Message-ID: <CAADnVQLnHSHker4S+tCyUyM4kFCMiH+ugHM0eWVOHhP1cuC-BQ@mail.gmail.com>
Subject: Re: [bpf-next 6/6] selftests/bpf: Fix arena_spin_lock selftest failure
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, sachinpb@linux.ibm.com, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Naveen N. Rao" <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 8:29=E2=80=AFAM Saket Kumar Bhaskar <skb99@linux.ibm=
.com> wrote:
>
> On Thu, Aug 07, 2025 at 03:21:42PM -0700, Alexei Starovoitov wrote:
> > On Mon, Aug 4, 2025 at 11:29=E2=80=AFPM Saket Kumar Bhaskar <skb99@linu=
x.ibm.com> wrote:
> > >
> > > @@ -60,9 +65,16 @@ static void test_arena_spin_lock_size(int size)
> > >                 return;
> > >         }
> > >
> > > -       skel =3D arena_spin_lock__open_and_load();
> > > -       if (!ASSERT_OK_PTR(skel, "arena_spin_lock__open_and_load"))
> > > +       skel =3D arena_spin_lock__open();
> > > +       if (!ASSERT_OK_PTR(skel, "arena_spin_lock__open"))
> > >                 return;
> > > +
> > > +       skel->rodata->nr_cpus =3D get_nprocs();
> >
> > ...
> >
> > > --- a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
> > > +++ b/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
> > > @@ -20,8 +20,6 @@
> > >  #define __arena __attribute__((address_space(1)))
> > >  #endif
> > >
> > > -extern unsigned long CONFIG_NR_CPUS __kconfig;
> > > -
> > >  /*
> > >   * Typically, we'd just rely on the definition in vmlinux.h for qspi=
nlock, but
> > >   * PowerPC overrides the definition to define lock->val as u32 inste=
ad of
> > > @@ -494,7 +492,7 @@ static __always_inline int arena_spin_lock(arena_=
spinlock_t __arena *lock)
> > >  {
> > >         int val =3D 0;
> > >
> > > -       if (CONFIG_NR_CPUS > 1024)
> > > +       if (nr_cpus > 1024)
> > >                 return -EOPNOTSUPP;
> >
> > We cannot do this. It will make arena_spin_lock much harder to use.
> > BPF CI doesn't run on powerpc anyway, but you can document that this
> > test is disable by creating selftests/bpf/DENYLIST.powerpc.
> Hi Alexie,
> Sorry, I did not get it. Can you please help me to understand why it
> makes arena_spin_lock harder to use.

because requiring user space to do
skel->rodata->nr_cpus =3D get_nprocs()
is a headache.

