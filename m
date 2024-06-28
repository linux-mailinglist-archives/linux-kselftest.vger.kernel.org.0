Return-Path: <linux-kselftest+bounces-12938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F36C91C462
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 19:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D99DAB20516
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CA61C9EBE;
	Fri, 28 Jun 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HYy0sUVa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38A1CD15
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594351; cv=none; b=kb30jWgCq6W3UcMnEo32Dsn3yHRgCRNd7YlOa7E4UtKlGj/Jsm8qQZXQrc/NnXj2vfy4ANOEd67zWz0itukaQEUVjitzWO0qoMdiv9roaot6eGV77U0R0WwrzxA2anBfwC3EiuUZOSXBMWdtzsw68um5sH7fQe59OGjEg7ftN2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594351; c=relaxed/simple;
	bh=4XHFuFA115udXlT+asJuRJ7ysS2QSvZPt5T9aUGI+rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dblsyhiMmdQzokft6V0fUAVajQbMGKAefMeim4b302AdNQ6RkmbXVYBqN4Gnu0VSHtwOYIMrk6omY15S1FXgJLaqV2UG21lVhloQem5ddYVQ6HC9DztE9D/8dp9lnsqjtKD1apLfE6wXyRBs/6WezYMJWU6/JT3uTjusQ0aR1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HYy0sUVa; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-366df217347so585119f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719594348; x=1720199148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JMuJ9WrfogZq4ya34x07iwBb8XotRWBpir1ixYVjF4=;
        b=HYy0sUVaZvUFhljs0RZg1AKC/HvwHyl0fNA9Pin+d55g3eQR4ZHCLDjeHuaPCwEI5b
         sA0WrYjnHpsKfYIepapfGGEjZJewU5RN9aqGPr8lboq7Bg8qgBNPovlxdIfC96aihKNf
         ZC0O5fJGuw+8R8qR2Om2RUxzfE9Hu8JDGBWLvdaUT4zTGd6ILRW3SoNKnQ5cFRMZMVBX
         zJz2aeYp+goxVpaCTOMF5vkjxBJA2sPs9Ozkk2ER06nB1cfEzBDYjvN0MzYsdPPAaz1K
         0B7fDZi1wSXvNMM3rrE7xexzBF9TqpLxkpCqRV1xu4pr5Q2jmgquJRX2qpYEa3XrIlJt
         jTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719594348; x=1720199148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JMuJ9WrfogZq4ya34x07iwBb8XotRWBpir1ixYVjF4=;
        b=h4vPhCecbYgMjAXsul+6BwQdA29xRutzh8offwOG45LuxIh/dVQ+QGdeV9Sf5HsqUL
         pJAGx25lSENHu8CmBDWsX6tFLrQvIeT2lS0jwjNZahFs++hdvKebxvLTYRR9eWEfX62s
         CDMH996Q6n86lWStmSmQKmnvUAMp6iX7aYHTlz/1CxLznnp08v/qhIZhc1m46ZCG2uZL
         7USC3VyUubrztAHEu2NGOhdsP2tgf2GhVAh1qsoUn219Fq1AVA1IO4IvJ3F8roJTHuoo
         FKotl/piInHhAaopTMg65aJRBNB+oP3tBlF2muPAtHb2PWuAVJTYEfW9ZrkT26rO/nc1
         xP3g==
X-Forwarded-Encrypted: i=1; AJvYcCVX7oBcyw77W9klatBoVobfyAn2AnSKrHCku6lESLp90ccDnmHc2m/NzDdWHn5klMfQTGhClnPqUDgX5XtszgzT9lR8rOCYZLxyJ1YgEg+h
X-Gm-Message-State: AOJu0YyWINuw4yzzYFjvq47EBub1Ynrr3tEhJ1BmmRRIetgcmDkXta1G
	Y+YXROWIK06KrQyHCpo5tVrw7e4MoE5qgPoQLN3ZPPpBNKPxGr1ZaVAUxqlVAOB+JnrHvcgnZ4u
	/xsTiyO/x5O7gNp84AQYxCBu1oLYNPcmOA+t1
X-Google-Smtp-Source: AGHT+IEtGSMHTUSiuH4qecwoSYwDClax9Ks0+jknR4nUZCpYb5T2i0hSeDcSxau3zWfrEW3QMVrBGqKb9lvnYn+w+Tg=
X-Received: by 2002:adf:e706:0:b0:367:3ce2:31e2 with SMTP id
 ffacd0b85a97d-3673ce2329dmr4096604f8f.23.1719594347672; Fri, 28 Jun 2024
 10:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626050818.2277273-1-jiaqiyan@google.com> <20240626050818.2277273-3-jiaqiyan@google.com>
 <e61fa5ea-09f3-c5f4-96be-ab0c5e7b233e@google.com>
In-Reply-To: <e61fa5ea-09f3-c5f4-96be-ab0c5e7b233e@google.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 28 Jun 2024 10:05:34 -0700
Message-ID: <CACw3F53LoA_4PPxUdTYFzEdxOkAPJWBRp1mx9JafybZYvCYBLQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] mm/memory-failure: userspace controls
 soft-offlining pages
To: David Rientjes <rientjes@google.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
	rdunlap@infradead.org, ioworker0@gmail.com, muchun.song@linux.dev, 
	akpm@linux-foundation.org, shuah@kernel.org, corbet@lwn.net, 
	osalvador@suse.de, duenwen@google.com, fvdl@google.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 8:27=E2=80=AFPM David Rientjes <rientjes@google.com=
> wrote:
>
> On Wed, 26 Jun 2024, Jiaqi Yan wrote:
>
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 6f5ac334efba..1559e773537f 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -68,6 +68,8 @@ static int sysctl_memory_failure_early_kill __read_mo=
stly;
> >
> >  static int sysctl_memory_failure_recovery __read_mostly =3D 1;
> >
> > +static int sysctl_enable_soft_offline __read_mostly =3D 1;
> > +
> >  atomic_long_t num_poisoned_pages __read_mostly =3D ATOMIC_LONG_INIT(0)=
;
> >
> >  static bool hw_memory_failure __read_mostly =3D false;
> > @@ -141,6 +143,15 @@ static struct ctl_table memory_failure_table[] =3D=
 {
> >               .extra1         =3D SYSCTL_ZERO,
> >               .extra2         =3D SYSCTL_ONE,
> >       },
> > +     {
> > +             .procname       =3D "enable_soft_offline",
> > +             .data           =3D &sysctl_enable_soft_offline,
> > +             .maxlen         =3D sizeof(sysctl_enable_soft_offline),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_dointvec_minmax,
> > +             .extra1         =3D SYSCTL_ZERO,
> > +             .extra2         =3D SYSCTL_ONE,
> > +     }
> >  };
> >
> >  /*
> > @@ -2749,8 +2760,9 @@ static int soft_offline_in_use_page(struct page *=
page)
> >   * @pfn: pfn to soft-offline
> >   * @flags: flags. Same as memory_failure().
> >   *
> > - * Returns 0 on success
> > - *         -EOPNOTSUPP for hwpoison_filter() filtered the error event
> > + * Returns 0 on success,
> > + *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,=
 or
> > + *         disabled by /proc/sys/vm/enable_soft_offline,
> >   *         < 0 otherwise negated errno.
> >   *
> >   * Soft offline a page, by migration or invalidation,
> > @@ -2786,6 +2798,13 @@ int soft_offline_page(unsigned long pfn, int fla=
gs)
> >               return -EIO;
> >       }
> >
> > +     if (!sysctl_enable_soft_offline) {
> > +             pr_info_once("%#lx: disabled by /proc/sys/vm/enable_soft_=
offline\n",
> > +                     pfn);
>
> Any strong reason to include the pfn in the log message?
>
> I'm concerned about allowing a user to deduce the physical mapping for an=
y
> arbitrary page since this is possible to do through MADV_SOFT_OFFLINE and
> I don't think that it adds value, especially if this is pr_info_once().

Agreed printing pfn value doesn't add value. Will get rid of it in v7.

>
> If we remove the pfn, feel free to add
>
>         Acked-by: David Rientjes <rientjes@google.com>

Thanks David!

>
> > +             put_ref_page(pfn, flags);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> >       mutex_lock(&mf_mutex);
> >
> >       if (PageHWPoison(page)) {
> > --
> > 2.45.2.741.gdbec12cfda-goog
> >
> >

