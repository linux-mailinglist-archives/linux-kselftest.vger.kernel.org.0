Return-Path: <linux-kselftest+bounces-31276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D37A95CA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 05:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2843AFAC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 03:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1938E19ABDE;
	Tue, 22 Apr 2025 03:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqU+K7ny"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E8218C00B
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 03:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745294316; cv=none; b=BWHhU79FDTpjnz6/LXIE7baTjOhjoV7Yoaz327A9spPNu+b+4AmQGn9PG7wO2jQ0WRJywl9pZ6ArYFIYss9udQ5ra4UdXOugB5Ht64/FftAz+KXdn9X0dOfikc9MouyldDqS7TJysx1UulSyw9ngZByDQuOsRwTef0cGSgLRbHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745294316; c=relaxed/simple;
	bh=yKRA8ZwqTzTG1B2kWoPv4xIY8kTNcN0dGqSKyOKdIvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rae9SuulPFf1HsM6fzWJHmC6k1O99tZnlxkAj3LsW3Fhc2GDouhkdWD3Q+sCQQg7yEKCpS85IuZ6fcO2e5jWipTyGGRXSDiUzkJZkbuLOVvYXPngUjvm17PHcjSRgkl/8jtcGMG6rwB6PM82ZYSW5riwtGmKnvY2wVQvU+9mtHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqU+K7ny; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4774611d40bso87921cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Apr 2025 20:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745294313; x=1745899113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za4w8R1db1P50GHT4MAtmBfToY4zX6t9W05URRKIDM4=;
        b=DqU+K7nyhjRgWjOlMGd124Eo8QC9G0AdECUmRWJODHAYmiqvmuSxlDXAsjDES88eTR
         hLizXaYEgAzvUJ+zLI7XA5CNaSSz8CQB1yxmwnsn4jry+IBZswbES2s+Zb5cRkK+cy1b
         nIX7isyRgTLkkEAnK/f9DbkbAPJ05CKmaMa+e8kKvOnLVtCAkzKSFoG+PDf8CRaw6VJB
         3EHwewLmNwb2hipJ+INYPbg/VUtPPzlZoH/GGfCT4GdgQJ0U2l0BXPRr3DfWM1h7mLAM
         kO/k05gYzXW7tySkXCcnjLDQ+SIqJBkwDCgx1Cx2wxGbRdHe1dLDtsEQW7OhETHoQlo4
         xB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745294313; x=1745899113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=za4w8R1db1P50GHT4MAtmBfToY4zX6t9W05URRKIDM4=;
        b=ok+i5kUSGilUegtRdcC1qnXXWQwt11qXpQ2MUnunyyjRTWfKSpbzHqWEhwItQqW4Ki
         R0Z9Raq1/y/XwXSEUQpWN4NqWWuL7Jeyyxmlrz3kqhO6iQUkJYv2dTRnzOmlKeFXKnao
         7MQwAWOfBheaTcHApz6avC6cBzGymahWKgG52fvt9Tiom1gx+p0EFrlF6qW4rIo8eFM9
         V7HM7VTJeK5Dfpcz6erN3pJxJlXaz862Z02k5bShIEhJXl0EGGr6M5EDFxfhsUQ05UFr
         vwthgl8BHzNne83ZbB+o5apGydgSuzmhvjI9PTmKlAAfDZ9OTP8pPjP8pZYMTO4LlriK
         gTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw/jAZvpNWUrsTFfGMqYkbQJRmdt30g5jNr/lDnbDUuAgWR9u2/XHLPISyOQoLx6G/CBsxd/4SpexJprMvDnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0m/N8KnfIxZpsvIrocoYuT8FZGNi3uM3yZEVXox9Gn9LMsZT7
	c6AjJfC2S7ciWC0ZUJyc6pOCqRop5TAaCa+QViNTdC4Yy4w1nbp4ZCuOI+uP8uA1BxeuFQn+2ll
	3oeMTcrhSCieAEWcUP/Eu0YxtTozhHtQqwvY+
X-Gm-Gg: ASbGncubbFakCMBP3YB032TeKr0yJjptYMWX+cip7U1n7eF5HRjjdMSTfa10/iQaMM1
	OuQjTPsGTHNPDLL8TckdMIHuy/GCbEZV+fRvUVh5AkCbIAusSyuL62ewudlirE1OXUdasaV5H1t
	ANR0ozoQ2p0NR5DYUKOlpnAsrGA5lnIKqRF0I2RIK+TNnWq+b2TjA=
X-Google-Smtp-Source: AGHT+IFAQcMpksnOj6/LnVgDGD6JBzpXjxag/1e/85G4VIYTdvOtZFPDNyNK6UlAnIZAd4e91YTRU2x31r5jjnrdFuU=
X-Received: by 2002:a05:622a:198f:b0:476:f1a6:d8e8 with SMTP id
 d75a77b69052e-47aecc701e8mr15481851cf.11.1745294313032; Mon, 21 Apr 2025
 20:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com> <20231206103702.3873743-3-surenb@google.com>
 <8bcb7e5f-3c05-4d92-98f7-b62afa17e2fb@lucifer.local> <rns3bplwlxhdkueowpehtrej6avjbmh6mauwl33pfvr4qptmlg@swctg52xpyya>
 <CAJuCfpFjx2NB8X8zVSGyrcaOfwMApZRfGfuia3ERBKj0XaPgaw@mail.gmail.com>
In-Reply-To: <CAJuCfpFjx2NB8X8zVSGyrcaOfwMApZRfGfuia3ERBKj0XaPgaw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 21 Apr 2025 20:58:22 -0700
X-Gm-Features: ATxdqUGzQHMqMLsQ2-GAAF2yokj3Za5US38h-1Y3L1CGlUceuA7t_asl_5wY1T0
Message-ID: <CAJuCfpHpdAn6yNVq1HXqO0qspj6DLb4qa_QufT+Z9RLTTa-N9Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] userfaultfd: UFFDIO_MOVE uABI
To: Alejandro Colomar <alx@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, aarcange@redhat.com, 
	linux-man@vger.kernel.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, shuah@kernel.org, lokeshgidra@google.com, 
	peterx@redhat.com, david@redhat.com, ryan.roberts@arm.com, hughd@google.com, 
	mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org, 
	willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com, 
	zhangpeng362@huawei.com, bgeffon@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 10:16=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Sat, Apr 19, 2025 at 12:26=E2=80=AFPM Alejandro Colomar <alx@kernel.or=
g> wrote:
> >
> > Hi Lorenzo, Suren, Andrea,
> >
> > On Sat, Apr 19, 2025 at 07:57:36PM +0100, Lorenzo Stoakes wrote:
> > > +cc Alejandro
> >
> > Thanks!
> >
> > > On Wed, Dec 06, 2023 at 02:36:56AM -0800, Suren Baghdasaryan wrote:
> > > > From: Andrea Arcangeli <aarcange@redhat.com>
> > > >
> > > > Implement the uABI of UFFDIO_MOVE ioctl.
> >
> > [...]
> >
> > > >
> > > > [1] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aa=
rcange@redhat.com/
> > > > [2] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5=
nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com/
> > > >
> > > > Update for the ioctl_userfaultfd(2)  manpage:
> > >
> > > Sorry to resurrect an old thread but... I don't think this update was=
 ever
> > > propagated anywhere?
> > >
> > > If you did send separately to man-pages list or whatnot maybe worth n=
udging
> > > again?
> > >
> > > I don't see anything at [0].
>
> Thanks for bringing it up! This must have slipped from my attention.
>
> > >
> > > [0]: https://man7.org/linux/man-pages/man2/ioctl_userfaultfd.2.html
> > >
> > > Thanks!
> > >
> > > >
> > > >    UFFDIO_MOVE
> > > >        (Since Linux xxx)  Move a continuous memory chunk into the
> >
> > Nope, it seems this was never sent to linux-man@.
> > <https://lore.kernel.org/linux-man/?q=3DUFFDIO_MOVE>:
>
> Sorry for missing that part.
>
> >
> >         [No results found]
> >
> > Please re-send including linux-man@ in CC, as specified in
> > <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/CONTR=
IBUTING>
>
> Thanks for the reference. Will post the documentation update later today.

Was planning to post today but I'm a bit rusty with the syntax. Will
try to send it out tomorrow after verifying the results.

> Thanks,
> Suren.
>
> >
> >
> > Have a lovely night!
> > Alex
> >
> > --
> > <https://www.alejandro-colomar.es/>

