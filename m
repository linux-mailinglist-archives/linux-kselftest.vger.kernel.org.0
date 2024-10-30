Return-Path: <linux-kselftest+bounces-21153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F29B6B1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 18:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D46E282456
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 17:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F090C1F4738;
	Wed, 30 Oct 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZlFrTJ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC96C1EF95A;
	Wed, 30 Oct 2024 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309731; cv=none; b=MgnJZ+M6/sI6xti9XuKOlMut4tYd4uN5eUcmRK0czb2X/tswKJHbd0LHjwaVoi6zBhJwqSmYozES9kDGzxspD5v6R2CkepG47d91MR9mCOwhbEmg3u4BAUtXvD+4BuygJoQF9QhMN9QJRrZUzLVOm6oyfcdFs+obnIEVKSuDBTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309731; c=relaxed/simple;
	bh=hN96yDzjFZnW0iLyGa0XM7KqV9VA85GMqGjCMXwqqhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqMQ9ETDH0JwN/4aOBS+kULL8gThiv3+vehnhOjdWFsD4mu3BI32lgk+puxzMmg6UkdE3yj7+qeVVml8+Op9S2HrxTpZ9vHnvCGvIGBDMnX2lmcx50AH085ExxhhgEN0rxcORm5mrunmZA6Z14u/nVaUfhFxPlOwuyQ3dqlNT7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZlFrTJ4; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so34146a91.2;
        Wed, 30 Oct 2024 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730309729; x=1730914529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiP+OVHkwJ2WwEc50c1zL6X+ty2T+Id/9XryhgE+LVs=;
        b=QZlFrTJ4/x1XoNI2NR7+s7HYkA5wjEMaRyYGzb7hz7kET0F5VeO+OUZB6lnMw1e4tp
         VrtesHdWjnCVzXCM4YK7OIAnuXdhnjQ4uUiFPevSmDslLeKDK8O3Qtq1UXHKAn6rhZ7L
         vgbeYHpeAQDHGDo9UYUBuvSY82WC4BP+C8O3dkovdxYpKp7EJEW3dU9WjMmjxIk8zFio
         j9nc5sS7McavPRawn09qkkdU7HvFjgXcH+qupc896ER0JQ4FyjgiSDr+dN2CVuHR+8YJ
         +o57FINxJb8nNAfzg9TIiGGgegp4orAJCFhm8DnQjB2+EjxxfsHHOSaQ79ooiL4QFEo/
         XKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730309729; x=1730914529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiP+OVHkwJ2WwEc50c1zL6X+ty2T+Id/9XryhgE+LVs=;
        b=YyDSWd51mMp5/arTJWtVzNB9q7lctBpjoqKsioD5FDstJg7jergk2pJuXqU+fo20N8
         aes5eXl0G2qhYSbrCMrb6Eekg2ch8xbSN+uWb/AcsClDn6TokA1TCwoo9yjeQI82jSeV
         8zkf8oewHV+xAkfQfPr8JOfEkl3vp8DO3F0//T+2O5ezGl4dmbbDKLnoCn3EqaWU/L46
         toQUWhMan6IDLoqK9Pxq8mTKe4RXnbupFxUwqk7lRi9mVxKzNHhBVJIV0ailq0ADGZNk
         srb+Oy0wrA0US7kb4U7oRQKJ09nkDKwckBydk70vuiA0jwF2hqDBN2cmNcWcaIkVR0Th
         UXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbL1xgIg/MtCl70MRVd6wl4px1Ume5ZwCSxIzOf8FvATjX03NKXd/2hV/pE60fwkeiL9HJiZfDiE/prNxlMAoB@vger.kernel.org, AJvYcCWRXJku8WWp/jY3oVMiSeGJqJVxtHfZ9bfEJG2IKuxzhvHN0sPCbtEteJpszuEzWuvHE9ItTSuAaDRLmIw1@vger.kernel.org, AJvYcCWhYrW54rx6Bxdpi6h1ZS1xti7x8x+S3HWmpCkBgaB9VjlfxBftUTo3WqyGCxfP0WchOMoMfyVNqRTjJKttZUl2/Ps8@vger.kernel.org, AJvYcCXRVD8Jg12diRlMGd6MgMwEVmIFplOczG1WHIfZpgfmVK8AvsKCxPK0uVMbfJVLNJY8hSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyXeueLd/8tvXc16vmjJbDy5WULzlGhz9DtV0FrUlWveLPXNUU
	nWGUSbhPz4uEdP/J1P3WuDHxC/QGXcp+LSCf5u33s5FRhrWSxnH4M2kspp5Dxrb5mt4Hbdnsl0B
	rGYZZmBEwNCwv7wKyIOhGe8DDk2ZHwA==
X-Google-Smtp-Source: AGHT+IH95yXMclFnAHy8QB+eHNc4rmInj2I+LJ/8aDsx3EJqpaOzdT6/yEgEZy6tveL6Lgr1C9KElhWkO7Mhr4OuAnE=
X-Received: by 2002:a17:90b:1d0c:b0:2e2:d7db:41fc with SMTP id
 98e67ed59e1d1-2e8f10683a4mr18135770a91.10.1730309729183; Wed, 30 Oct 2024
 10:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029002208.1947947-1-dolinux.peng@gmail.com>
 <20241029002208.1947947-2-dolinux.peng@gmail.com> <CAEf4BzbVjkhtQPcsDOLX_aR_vvB1nCQj357EQ5xwey8486=Niw@mail.gmail.com>
 <CAErzpmuHJ-qZqzS11GPK5_=UsuxtPk1gbexbhJ7nj59M-NzSHA@mail.gmail.com>
In-Reply-To: <CAErzpmuHJ-qZqzS11GPK5_=UsuxtPk1gbexbhJ7nj59M-NzSHA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 30 Oct 2024 10:35:17 -0700
Message-ID: <CAEf4BzaXHrjoEWmEcvK62bqKuT3de__+juvGctR3=e8avRWpMQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] libbpf: Sort btf_types in ascending order by name
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:13=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Wed, Oct 30, 2024 at 5:58=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Oct 28, 2024 at 5:22=E2=80=AFPM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > To enhance the searching performance of btf_find_by_name_kind, we
> > > can sort the btf_types in ascending order based on their names.
> > > This allows us to implement a binary search method.
> > >
> > > Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > > ---
> > > v4:
> > >  - Divide the patch into two parts: kernel and libbpf
> > >  - Use Eduard's code to sort btf_types in the btf__dedup function
> > >  - Correct some btf testcases due to modifications of the order of bt=
f_types.
> > > ---
> > >  tools/lib/bpf/btf.c                           | 115 +++++--
> > >  tools/testing/selftests/bpf/prog_tests/btf.c  | 296 +++++++++-------=
--
> > >  .../bpf/prog_tests/btf_dedup_split.c          |  64 ++--
> > >  3 files changed, 268 insertions(+), 207 deletions(-)
> > >
> >
> > I don't think we should do any extra sorting by default. Maybe we need
> > some extra API to explicitly re-sort underlying types. But then again,
>
> How do you feel about adding a new feature to the '--btf_features' option=
,
> which could be used to control sorting?

This is pahole question, and yes, having a --btf_features makes sense to me=
.

>
> > why just by type name? What if type names are equal, what do we use to
> > disambiguate. None of this is considered in this patch.
>
> If there are multiple btf_types with identical names in a btf file,
> they will have different kinds. These btf_types will be grouped

Not necessarily, you can easily have types of the same kind with the
same name. But this changes nothing, I'd still define fuller search
criteria.

> together after being sorted according to their names. We can
> determine the range of the group and verify the btf_types within
> that range by their kind to obtain the appropriate btf_type.
>
> >
> > pw-bot: cr
> >
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index 3c131039c523..5290e9d59997 100644
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -1,6 +1,9 @@
> > >  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > >  /* Copyright (c) 2018 Facebook */
> > >

[...]

