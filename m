Return-Path: <linux-kselftest+bounces-6265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA989879952
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 17:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E362B240A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C2D80C00;
	Tue, 12 Mar 2024 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0M7GvAmw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE83D80622
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262091; cv=none; b=Q0ogRl4PYX4M0vJcVG25C2hAp2i2TR97+27PY873XdKnMCKordwd8AQxL7PNoCsW8nygH7Y934xYGeUbiPlsOJXbaQC2QP+bM3ffFegFMaNl0tH46SruwCzJdNPLVUyb09odh875R0U0HDW8S4NfU0YAeA5ocM1uwskQWW7smYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262091; c=relaxed/simple;
	bh=Q9HjHKn/d07di0Ny/VSuzvRdRoFuJ8TFJKvZUrjtdv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7nNj6zqLOe0gzKRzT3TMYmmXQCUxuhkZHTBR+nmPTxvIv31kPk5mTLonqqSVQSmgsNW5tu1Kq1CITPlfH0QAETRWgzGcVj/H1KOckUZqOnoO1aB1qjG64bhM/it02N8ta8AHFoiLT+Lb63CO52g97mVTEHYt4CgnPA4m3evk2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0M7GvAmw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41332865b05so6160295e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710262088; x=1710866888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1JdD3SjakPudHQVJ76rnnq2H2jE37lLZ/0x/M6KH0I=;
        b=0M7GvAmw5MXxK8s34JKi6K+N9SVvWcUQFaEdziy56einrtrPwp+6Sy7iNgYACkcUe0
         QwLeRyq4wVefsHU82lFwZ3dA9PzuyU3OyxizEUe3AFDS031FvDjZrf7ReRu5mLL2jTIR
         x25ZxQH9YjhhSHki1b6HdTLBrVnjEhQtERV77PJ851qQrJozFIYaA2KfXHqdNpiloVkT
         r+ngswREVrv7r/SkwALcTqUbcosyZkqxzYDwtFPxBecK18WRGlyIku0hq4N3OItRlGsf
         HC1SYAlvqxmUcvQjsCjlpVAlGhS4Yx9pUWBmpzl8ts2lxhcUmAOsPySEN7ujNhwE071j
         HwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710262088; x=1710866888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1JdD3SjakPudHQVJ76rnnq2H2jE37lLZ/0x/M6KH0I=;
        b=bEk3eot1yDVYabedOv4h/hk5kVJG5Khyp14QCYN6h8u9CM2Gq116bfz78WxtP6vPWg
         joaEsMqo+WE3OqCZSOUJj2zjXzaJMk7LKy13S7SJlxnpUeUz5+WSq6AnizrLsdKr+SVl
         EJHkbrlw3Hs9Wq6fnEhiRn1JdU/lvlfFUYRSyyXeQPBNghpwP/lDyF+t5E9XPiob5v76
         gnGGa4SHb1bJUi6GwaBGUlbaBlvccLSGSu27oXa8Gd/F2svNFwulWePzEyYmUpcqapjB
         KZkiSv+WNfzLrKPt3OM7+VLTRBgMFPQNmAinZVymhLXXGm5HiuYfmSozZ9fWFPQO2k2y
         F6+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAV78D96C/c2B2/bt8a2WvhETw9Q+DxtCs26G3Wsycl/7GLVczctpaEvzWL4AvV0sFGH0zPEq/nQY/8aqPWT2+WfrvF5BHkJD/Ow07ClTD
X-Gm-Message-State: AOJu0YyPeQuJf7NQLtagKXmp8z56kfFsayOnQ1zaTkXG6dYC9cro0cXC
	kKtzqZBw7v5iq0vg9nIBZbxYm3tR+FIFpZlC7paL+nR28EHOlRwhz7JT3/U9VQOOrJL7NpcB9BK
	3lJsPTK28UV9lbR7y8YWK8kw6glDC7nnMLikmofn7BlQ/WoXMUg==
X-Google-Smtp-Source: AGHT+IHz1t46LqyIdp7DJe0W007vNHqs968mX/S24f/EmXbCZ+L80gonmf0M4eO18CLGv4wGugu605YqTZHSHfDeU2Y=
X-Received: by 2002:a05:600c:5251:b0:412:ebce:aa81 with SMTP id
 fc17-20020a05600c525100b00412ebceaa81mr7255060wmb.23.1710262088195; Tue, 12
 Mar 2024 09:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a9e3120d-8b79-4435-b113-ceb20aa45ee2@alu.unizg.hr>
 <4a5c8d28-7f73-4c15-b288-641f0ccc91c2@redhat.com> <Ze8Wr2qH8V0LMi_5@x1n>
 <b5ff4c70-6379-4cc7-8c92-778d80a6a658@redhat.com> <Ze8fYF5I4mlUGHd9@x1n>
 <CAJHvVcie+N+4j60m_Dxh7QzbZLmsjnq2-04peuqE8VkkMq984A@mail.gmail.com>
 <Ze9bWkrD6UBZ2ErV@x1n> <CADrL8HW59nt4ztY3x5G3VgpmaXQbXoXZeAjvzMp7SpsqxgDCxw@mail.gmail.com>
 <CACw3F51vMqPBHmvj4ehSA8PadXw30s3MxCqph1op5dxtB-tV6Q@mail.gmail.com> <ZfB28NIbflrnsqiX@x1n>
In-Reply-To: <ZfB28NIbflrnsqiX@x1n>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Tue, 12 Mar 2024 09:47:31 -0700
Message-ID: <CAJHvVcizoDwYVqnkroBz4nrXJRCkynC19=RBgWhT6xPdrvJ0sA@mail.gmail.com>
Subject: Re: BUG selftests/mm]
To: Peter Xu <peterx@redhat.com>
Cc: Jiaqi Yan <jiaqiyan@google.com>, James Houghton <jthoughton@google.com>, 
	David Hildenbrand <david@redhat.com>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 8:38=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Mar 11, 2024 at 03:28:28PM -0700, Jiaqi Yan wrote:
> > On Mon, Mar 11, 2024 at 2:27=E2=80=AFPM James Houghton <jthoughton@goog=
le.com> wrote:
> > >
> > > On Mon, Mar 11, 2024 at 12:28=E2=80=AFPM Peter Xu <peterx@redhat.com>=
 wrote:
> > > >
> > > > On Mon, Mar 11, 2024 at 11:59:59AM -0700, Axel Rasmussen wrote:
> > > > > I'd prefer not to require root or CAP_SYS_ADMIN or similar for
> > > > > UFFDIO_POISON, because those control access to lots more things
> > > > > besides, which we don't necessarily want the process using UFFD t=
o be
> > > > > able to do. :/
> > >
> > > I agree; UFFDIO_POISON should not require CAP_SYS_ADMIN.
> >
> > +1.
> >
> >
> > >
> > > > >
> > > > > Ratelimiting seems fairly reasonable to me. I do see the concern =
about
> > > > > dropping some addresses though.
> > > >
> > > > Do you know how much could an admin rely on such addresses?  How fr=
equent
> > > > would MCE generate normally in a sane system?
> > >
> > > I'm not sure about how much admins rely on the address themselves. +c=
c
> > > Jiaqi Yan
> >
> > I think admins mostly care about MCEs from **real** hardware. For
> > example they may choose to perform some maintenance if the number of
> > hardware DIMM errors, keyed by PFN, exceeds some threshold. And I
> > think mcelog or /sys/devices/system/node/node${X}/memory_failure are
> > better tools than dmesg. In the case all memory errors are emulated by
> > hypervisor after a live migration, these dmesgs may confuse admins to
> > think there is dimm error on host but actually it is not the case. In
> > this sense, silencing these emulated by UFFDIO_POISON makes sense (if
> > not too complicated to do).
>
> Now we have three types of such error: (1) PFN poisoned, (2) swapin error=
,
> (3) emulated.  Both 1+2 should deserve a global message dump, while (3)
> should be process-internal, and nobody else should need to care except th=
e
> process itself (via the signal + meta info).
>
> If we want to differenciate (2) v.s. (3), we may need 1 more pte marker b=
it
> to show whether such poison is "global" or "local" (while as of now 2+3
> shares the usage of the same PTE_MARKER_POISONED bit); a swapin error can
> still be seen as a "global" error (instead of a mem error, it can be a di=
sk
> error, and the err msg still applies to it describing a VA corrupt).
> Another VM_FAULT_* flag is also needed to reflect that locality, then
> ignore a global broadcast for "local" poison faults.

It's easy to implement, as long as folks aren't too offended by taking
one more bit. :) I can send a patch for this on Monday if there are no
objections.

>
> >
> > SIGBUS (and logged "MCE: Killing %s:%d due to hardware memory
> > corruption fault at %lx\n") emit by fault handler due to UFFDIO_POISON
> > are less useful to admins AFAIK. They are for sure crucial to
> > userspace / vmm / hypervisor, but the SIGBUS sent already contains the
> > poisoned address (in si_addr from force_sig_mceerr).
> >
> > >
> > > It's possible for a sane hypervisor dealing with a buggy guest / gues=
t
> > > userspace to trigger lots of these pr_errs. Consider the case where a
> > > guest userspace uses HugeTLB-1G, finds poison (which HugeTLB used to
> > > ignore), and then ignores SIGBUS. It will keep getting MCEs /
> > > SIGBUSes.
> > >
> > > The sane hypervisor will use UFFDIO_POISON to prevent the guest from
> > > re-accessing *real* poison, but we will still get the pr_err, and we
> > > still keep injecting MCEs into the guest. We have observed scenarios
> > > like this before.
> > >
> > > >
> > > > > Perhaps we can mitigate that concern by defining our own ratelimi=
t
> > > > > interval/burst configuration?
> > > >
> > > > Any details?
> > > >
> > > > > Another idea would be to only ratelimit it if !CONFIG_DEBUG_VM or
> > > > > similar. Not sure if that's considered valid or not. :)
> > > >
> > > > This, OTOH, sounds like an overkill..
> > > >
> > > > I just checked again on the detail of ratelimit code, where we by d=
efault
> > > > it has:
> > > >
> > > > #define DEFAULT_RATELIMIT_INTERVAL      (5 * HZ)
> > > > #define DEFAULT_RATELIMIT_BURST         10
> > > >
> > > > So it allows a 10 times burst rather than 2.. IIUC it means even if
> > > > there're continous 10 MCEs it won't get suppressed, until the 11th =
came, in
> > > > 5 seconds interval.  I think it means it's possibly even less of a =
concern
> > > > to directly use pr_err_ratelimited().
> > >
> > > I'm okay with any rate limiting everyone agrees on. IMO, silencing
> > > these pr_errs if they came from UFFDIO_POISON (or, perhaps, if they
> > > did not come from real hardware MCE events) sounds like the most
> > > correct thing to do, but I don't mind. Just don't make UFFDIO_POISON
> > > require CAP_SYS_ADMIN. :)
> > >
> > > Thanks.
> >
>
> --
> Peter Xu
>

