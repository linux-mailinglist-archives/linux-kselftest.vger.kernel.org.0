Return-Path: <linux-kselftest+bounces-9244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C22328B9097
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 22:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769C1282D05
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 20:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8241635B0;
	Wed,  1 May 2024 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3qTnlaCH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E11649D9
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594926; cv=none; b=EahO6vZ0yoh9hxvm7a9vR7WscJn7bpSGtRcNPqguzCcEPSWTtBiJkgOamZOq3S5WGIOYw0jx6htIKNKl8mObilC+yalQq2sJP8cvFEsGl61Z2jwiBPYXLorLrTNpGSjmJXllAqw4+inWbLMYcoLYEpBfm9cqGvSoxlZKxuSx0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594926; c=relaxed/simple;
	bh=Rl7I4/w66VkXXW1jfowz8Diggq7Cxx9FBc+7jDI5OE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2WhhgHjTEbX0+gRYjIVP/h/3TVRWA/1W/GOLYAIgSjXw64hOo82um4jMeZgo+5HO0ctwj4mE7nZExwpSJ0lU2AWTVvSMT/1S/QhLX1r+8LRKbicqbMP9F45ZxMnux2nHoY2pSmZQP40731ANRo40OoryUc1nt92tgKy+ImpjHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3qTnlaCH; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso886a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 13:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714594923; x=1715199723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciChv8gSXlzNkgOKOzuvxXr84EIsn6Oq5YU3LMaJYNo=;
        b=3qTnlaCHQQdHIIlFggCnDj52ANSNopIaW6m8ssOT9lj+k7g6oiXDMrAugi+V1+6Ruq
         im89sdkjmXo4l2lR50/9fR30EDV5WOmSCSds+7l538Ybh99aFfFxQn7SOlQS6sg9olMj
         pGz6wFNPF8KV7WNDvqe8kqFF2WZva97ZDHxV86k6EtKfTyoHTqqKyKsngBp51uJ/b3rk
         LG26tY+CVHbNVmURBU+XTLloTzAeBgy/p1LLM5qZIAmVcYqFAlzcWEFrkL7Ci2oHKv8L
         lAdQKKOskrbikWJsXTbngQHo7AiOv6Uz/jqbYqAT57Esix6a+fUV1BMyEy18YX1Sf0uW
         4zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594923; x=1715199723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciChv8gSXlzNkgOKOzuvxXr84EIsn6Oq5YU3LMaJYNo=;
        b=tU8+opyrVbzX2SMMXNBvyhvfST4FJhmH/0QgdRueLmidOET9ic1G5PV7xgUIwOXglh
         IlaWQ7PntOfGemxO1YNYv2kybuOhxC1/lPzQ7CG6iitwd0SPUlpFYzVZdAlUJmW5PiQK
         BQ7rnq8ww9dua6YqmsBNJlnWIHnLl+CBg5XsO2hGfDhb4iFwF4sq35nhJQHTeYuyErYv
         SUyxmPz8LCmcQmXeEvYqza5r7JCchRS+sltmpufyt0ki89YNgre37aaVAxHH6kj/DCIw
         Qgkunql2OGZtGGieGIdBGX1AlTy6U5+OJ+qKb30m6XJzzBEaQktxAJ/VkgFp7/8NGw1s
         CFKw==
X-Forwarded-Encrypted: i=1; AJvYcCUNpFatR3AAHB3jSXJWcE6tvQ4atiwxtgVzP4ILfruv65cK9R76QC054nd36bcHFKPG6sPZuRn0zOA7+nZOPc1U+EZ0cwl7gdT7outQZZs2
X-Gm-Message-State: AOJu0YxxujuqbZsi5hSE8y5gZdj0E750V+KZSB2UXJ2bp7LmId+NgCWZ
	tDtvUCXOYs9jG2CHXY2BrjwaTKqn6+t3YWAjX5J8WB0G6iCuWQQfJw1lgiTv4kTG0TyCJohMU1n
	QNO4957CduXRZ6hyVBaW19wKInlsG/T/lRXJL
X-Google-Smtp-Source: AGHT+IFmvrlSmN5CZ2AzUe/MN5NsP38k4AFUMV92kR3xGNpVWzrF7dMoaN56RroXCDL45dJrMsPtLXoabp7LiNXom+E=
X-Received: by 2002:a05:6402:54c:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-572bba25964mr35884a12.6.1714594923041; Wed, 01 May 2024
 13:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501180622.1676340-1-edliaw@google.com> <osgrbhnqlyh5yw4y4x6wjggx56dogsgje5yy3mkpu75ubs3zwg@5tliydzky37k>
In-Reply-To: <osgrbhnqlyh5yw4y4x6wjggx56dogsgje5yy3mkpu75ubs3zwg@5tliydzky37k>
From: Edward Liaw <edliaw@google.com>
Date: Wed, 1 May 2024 13:21:35 -0700
Message-ID: <CAG4es9UxQEMx9gH4-khe39x05ioNbhZpym3G6TcR6aYQYtrj-A@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/vDSO: Explicit unsigned char conversion for elf_hash
To: Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Andy Lutomirski <luto@mit.edu>, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 12:54=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi,
>
> On Wed, May 01, 2024 at 06:06:18PM +0000, Edward Liaw wrote:
> > Fixes clang compilation warnings by adding explicit unsigned conversion=
:
> >
> > parse_vdso.c:206:22: warning: passing 'const char *' to parameter of
> >  type 'const unsigned char *' converts between pointers to integer type=
s
> >  where one is of the unique plain 'char' type and the other is not
> >  [-Wpointer-sign]
> >         ver_hash =3D elf_hash(version);
> >                             ^~~~~~~
> > parse_vdso.c:59:52: note: passing argument to parameter 'name' here
> > static unsigned long elf_hash(const unsigned char *name)
> >                                                    ^
> > parse_vdso.c:207:46: warning: passing 'const char *' to parameter of
> >  type 'const unsigned char *' converts between pointers to integer type=
s
> >  where one is of the unique plain 'char' type and the other is not
> >  [-Wpointer-sign]
> >         ELF(Word) chain =3D vdso_info.bucket[elf_hash(name) % vdso_info=
.nbucket];
> >                                                     ^~~~
> > parse_vdso.c:59:52: note: passing argument to parameter 'name' here
> > static unsigned long elf_hash(const unsigned char *name)
> >
> > Fixes: 98eedc3a9dbf ("Document the vDSO and add a reference parser")
> > Signed-off-by: Edward Liaw <edliaw@google.com>
>
> > ---
> > v2: update commit message with correct compiler warning
> > v3: fix checkpatch errors and indentation
> > ---
> >  tools/testing/selftests/vDSO/parse_vdso.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/=
selftests/vDSO/parse_vdso.c
> > index 413f75620a35..9e29ff0657ea 100644
> > --- a/tools/testing/selftests/vDSO/parse_vdso.c
> > +++ b/tools/testing/selftests/vDSO/parse_vdso.c
> > @@ -203,8 +203,9 @@ void *vdso_sym(const char *version, const char *nam=
e)
>
> Is it possible to just change the types of the parameters of vdso_sym()
> or does that trigger even more warnings on the callsites of vdso_sym()?

It does trigger more warnings on the callsites unfortunately.

>
> Either way, this looks ok to me.
>
> Acked-by: Justin Stitt <justinstitt@google.com>
>
> >       if (!vdso_info.valid)
> >               return 0;
> >
> > -     ver_hash =3D elf_hash(version);
> > -     ELF(Word) chain =3D vdso_info.bucket[elf_hash(name) % vdso_info.n=
bucket];
> > +     ver_hash =3D elf_hash((const unsigned char *)version);
> > +     ELF(Word) chain =3D vdso_info.bucket[
> > +             elf_hash((const unsigned char *)name) % vdso_info.nbucket=
];
> >
> >       for (; chain !=3D STN_UNDEF; chain =3D vdso_info.chain[chain]) {
> >               ELF(Sym) *sym =3D &vdso_info.symtab[chain];
> > --
> > 2.45.0.rc0.197.gbae5840b3b-goog
> >
>
> Thanks
> Justin

