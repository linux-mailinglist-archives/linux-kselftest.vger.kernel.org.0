Return-Path: <linux-kselftest+bounces-43668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5F1BF7C08
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 18:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F21189F834
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 16:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589C834F47B;
	Tue, 21 Oct 2025 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjZa2+QC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D533446A0
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065046; cv=none; b=h9zeKEYmMaQZDEemxR/D+DsCOuuTFtmca+xbeGt2GB+3DT/IYAAc9dQMdQzN/41DvPlTRWzzG8RdpxggbQzqsZfV+y5rhGcDuCL9R//S5aOqYTdaOBorYQbSxjxfnvKgcBwPeFxQ/9fogzlUa+DynVIOp8g9LXQSbRxkTjr8pq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065046; c=relaxed/simple;
	bh=4YmHvcvZpSJVJYzfmLEbibQx5RFd/moigts2aPZXuSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhHUKaTUV/bvpYhv/xPiU+RbUe+ffosRQrvLy3BPFUqdEdRsfdPsDGt4Q3l/GFhKr18E6nyJDShNPRwJO1N/T2Zt5feGnWIEEURfjLOBLiydDVmb9OamX9vtoMCGwYwU1DUjGpiadyX0edsr+DU6hfo3Ao95BGMbEC5eQUDDuWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjZa2+QC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761065043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lnZSOAVMKEkF8DgY+Fx3pHUy6vCFxXk/5AE4e+Z/Gr4=;
	b=fjZa2+QCNhYcEq8Q51LtvKCGxfmeYviZmFZYCtNaMEYEccveBh4fOAiAKs5Ba5KucYY+jF
	NW3IUptmgYlf+TsPKyv3iIyIaQVptiCim4Qe3tHzDq8IHEvbbpUUvkjua6dcArTSnofyED
	MnAsP0u/IyszGtO3B9+3iP/amFKysas=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-gVHG1e4nMZ6Atetm4-XRkg-1; Tue, 21 Oct 2025 12:44:02 -0400
X-MC-Unique: gVHG1e4nMZ6Atetm4-XRkg-1
X-Mimecast-MFC-AGG-ID: gVHG1e4nMZ6Atetm4-XRkg_1761065041
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8a3d0fb09so1542731cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 09:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065041; x=1761669841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnZSOAVMKEkF8DgY+Fx3pHUy6vCFxXk/5AE4e+Z/Gr4=;
        b=h9q0RD7IDRHoTv0TzSVKu0D6OsHkhyMZfzHOUyI/HBQmdkgIQlsXrjMFZGA/lGWeSs
         a4woJwmjQrBvIyLNimvAVfGpChSdPvGTAjyFufc3BmYZZkvfWytmL/WXU+1T4RWkkwo9
         3Opkwi9FaUvRmC+U+GIAvcjO32kVAJgliG7OriWHYftpbPKPMyLc2Ypw1YXjhum3r8ei
         pj7E6eRCQ7HutW5atF/4xa7MyRzyEHiISOcRl44/e4U2E4WTJWxqDwcm/Nx8Pxl3OQm4
         mmTytyqLKstCq7IiZD7jj4ghabVIGC9S25ZkJ0WXbPP6TOnh9mkuJ3R6JYMOYJowNvQF
         JNlw==
X-Forwarded-Encrypted: i=1; AJvYcCWxmK7zihK/vBxLhbla2wnQJ/MIjix88SJeEaPv1foFegBkoo8ZUiVytjIs8vVcbWbap/DhZrjk3LXYa47Vdt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjDQ0/CywGISwxZJOmTLw7g56iFg96sysuNNOeIQPogf+/HrGL
	B1joXhUjKIHR50J/fphVUJ9/tjYqTlS641+iZSVr7D1TYBYKM+5z3RGLmukXsAWGakRDcWVTpWa
	IYreS8iXgu6x0rJ8lmnSyoDE/JSOV5et339335OHVYAX2/XqIn6MAf+KxLO347GZayfWHs9M4tw
	ja+eirnaw7WPVYd5ab08HOjXnbkzhLFwRlxE/nXWASRKRT
X-Gm-Gg: ASbGncs9uUH2I3MrWNxA5AyGJvX8RcbxGBGxULK2WbL+Qdk027SUae3UT+TiASl57Jk
	hrzhpTcg2OyxQzfTlZzFvsS1K1WXMfg2hot+QcRRBirvtlqzhjZiJdtNedJQ/q0ggxJA1yxy5hh
	XxOJgAlPdTCYanbjUnvMPiiOv8O0/UuAkASteEkFw7rxekFVA+H2w2GQMYKHR/9qk9beZQbsDon
	RLfknsNzaLHlQY=
X-Received: by 2002:a05:622a:8d:b0:4e8:a8dd:9ece with SMTP id d75a77b69052e-4e8a8dda588mr204964331cf.73.1761065041346;
        Tue, 21 Oct 2025 09:44:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAfDFlGk7bvGv6JgbTw1zj++uENryqhdqzCaeJw6qYcicQPAK2zyOIVO/t/8no07sO0cLtemg82e5bbZzJhxI=
X-Received: by 2002:a05:622a:8d:b0:4e8:a8dd:9ece with SMTP id
 d75a77b69052e-4e8a8dda588mr204963971cf.73.1761065040848; Tue, 21 Oct 2025
 09:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910170000.6475-1-gpaoloni@redhat.com> <20250910170000.6475-2-gpaoloni@redhat.com>
 <878qifgxbj.fsf@trenco.lwn.net> <85166a8a-ad54-42d0-a09f-43e0044cf4f4@redhat.com>
 <CAB=6tBQP3aCDWch4ZcEYMqFsJ4OKXSyC_hb9V9hA7ZZty7vFeQ@mail.gmail.com>
 <042629f9-f295-494e-8fbd-e8751fcbe7c0@redhat.com> <CA+wEVJYLF9T21-V2k0Y0zxcF0zcRG64QUVrM=qHDWHz7+4+ptw@mail.gmail.com>
 <dafcdb6e-be12-4b86-959e-8510a9622358@redhat.com>
In-Reply-To: <dafcdb6e-be12-4b86-959e-8510a9622358@redhat.com>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Tue, 21 Oct 2025 18:43:49 +0200
X-Gm-Features: AS18NWCBpqAbisvSgvvqFRL4j0rCUfXKUoQLmxvhLRhTM9VY1KibLNsIgwn639M
Message-ID: <CA+wEVJZS5GErRThB7wvQ5pDoVo_j=pKD4neN-U2qJEnTgHRYXg@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 1/3] Documentation: add guidelines for writing
 testable code specifications
To: David Hildenbrand <david@redhat.com>
Cc: Chuck Wolber <chuckwolber@gmail.com>, Jonathan Corbet <corbet@lwn.net>, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org, 
	safety-architecture@lists.elisa.tech, acarmina@redhat.com, 
	kstewart@linuxfoundation.org, chuck@wolber.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 6:34=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 21.10.25 18:27, Gabriele Paoloni wrote:
> > Hi David
> >
> > On Tue, Oct 21, 2025 at 5:37=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 20.10.25 23:02, Chuck Wolber wrote:
> >>> [Reposting with apologies for the dup and those inflicted by the brok=
en Gmail
> >>> defaults. I have migrated away from Gmail, but some threads are still=
 stuck
> >>> there.]
> >>>
> >>> On Mon, Oct 20, 2025 at 7:35=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>
> >>>>>> +------------
> >>>>>> +The Documentation/doc-guide/kernel-doc.rst chapter describes how =
to document the code using the kernel-doc format, however it does not speci=
fy the criteria to be followed for writing testable specifications; i.e. sp=
ecifications that can be used to for the semantic description of low level =
requirements.
> >>>>>
> >>>>> Please, for any future versions, stick to the 80-column limit; this=
 is
> >>>>> especially important for text files that you want humans to read.
> >>>>>
> >>>>> As a nit, you don't need to start by saying what other documents do=
n't
> >>>>> do, just describe the purpose of *this* document.
> >>>>>
> >>>>> More substantially ... I got a way into this document before realiz=
ing
> >>>>> that you were describing an addition to the format of kerneldoc
> >>>>> comments.  That would be good to make clear from the outset.
> >>>>>
> >>>>> What I still don't really understand is what is the *purpose* of th=
is
> >>>>> formalized text?  What will be consuming it?  You're asking for a f=
air
> >>>>> amount of effort to write and maintain these descriptions; what's i=
n it
> >>>>> for the people who do that work?
> >>>>
> >>>> I might be wrong, but sounds to me like someone intends to feed this=
 to
> >>>> AI to generate tests or code.
> >>>
> >>> Absolutely not the intent. This is about the lossy process of convert=
ing human
> >>> ideas to code. Reliably going from code to test requires an understan=
ding of
> >>> what was lost in translation. This project is about filling that gap.
> >>
> >> Thanks for clarifying. I rang my alarm bells too early :)
> >>
> >> I saw the LPC talk on this topic:
> >>
> >> https://lpc.events/event/19/contributions/2085/
> >>
> >> With things like "a test case can be derived from the testable
> >> expectation" one wonders how we get from the the doc to an actual test=
 case.
> >
> > Probably it is the term derived that can be a bit misleading. The point=
 is that
> > we need documented expectations that can be used to review and verify t=
he
> > test cases against; so maybe better to say "a test case can be verified=
 against
> > the testable expectation"
>
> On a high level (where we usually test with things like LTP) I would
> usually expect that the man pages properly describe the semantics of
> syscalls etc.

On a high level yes however there are two issues:
1) even the Posix standard define the behaviour of certain syscalls as
implementation specific
2) if all the details required to write testable specifications were mainta=
ined
as part of the manpage, these would become unmaintainable

For this reason specification must be broken down over the code in a
maintainable way

>
> That also feels like a better place to maintain such kind of information.
>
> Having that said, man-pages are frequently a bit outdated or imprecise
> .. or missing.
>
> Anyhow, I guess that will all be discussed in your LPC session I assume,
> I'll try to attend that one, thanks!

Sure Looking FWD to see you there

Gab

>
> --
> Cheers
>
> David / dhildenb
>


