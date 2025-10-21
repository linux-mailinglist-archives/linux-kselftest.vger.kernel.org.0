Return-Path: <linux-kselftest+bounces-43666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC80BF7A7F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 18:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E2B0500E0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 16:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657C43491F8;
	Tue, 21 Oct 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HePrGfpu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB73491E5
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064078; cv=none; b=a0OIJ0N13AGQnlvKaFYEYlYS4wQSBQ2ficW2ULlrY++O1Z4HC24KPV1Cd8N8UeIqyPkYTrBUWS64Lov5aLRdWTT/L+ELjK2Qj9I3n/ks+MjOFabrBPDeKDT5CAvuld87vzyFE5/FbuaBmBo5cQxiiuhFe4hESpE0f/1haVeEHfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064078; c=relaxed/simple;
	bh=0JL2p2qr9N1wihmhv2SB4/CNeAvlfQqJRTz8Itd3L7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3LR7vedpzMAidIfQAHe3hz6pEo6gXF1rDfbdxW2o5PRNt/oytcM2Zgt78QGD1QHFIttvA3pykEeOuaXIZYhUZy5YEpFBWKeEq+EPBCv7e4RmDDW4LbMPkfxatR9MgREHmO6ZDuqKr4O4UQfYEavTIYv7+CA8x4CQ3lYwf/wRfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HePrGfpu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761064075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tvopacnigHBT8bombNvmTILspbaRSMSn7DFUJVL0nnc=;
	b=HePrGfpuHO0NAddAtozFro9TTREwO+F54nL37qXG2k7lTjlfJStxQvEta9+ybgZD7SmAk2
	KPVa2ai4eNz1hKabjPS514iAgO3Qx/HU1W6LMOb/1ah4PsnwQCHzt1f8BGaW+lgyetZ+NO
	aFv9EkHLSvzw1BN1LgGX44fRN/tlp1M=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-Guv7J91cNlyepetKve3u0w-1; Tue, 21 Oct 2025 12:27:54 -0400
X-MC-Unique: Guv7J91cNlyepetKve3u0w-1
X-Mimecast-MFC-AGG-ID: Guv7J91cNlyepetKve3u0w_1761064074
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e884663b25so2116081cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 09:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761064074; x=1761668874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvopacnigHBT8bombNvmTILspbaRSMSn7DFUJVL0nnc=;
        b=SQoLxSSdroRCgDTyCmhFbCVebGKvTUdY8TrB0f/3Sm7jjO1jeL+nRrK4zjYtAuslFj
         ckYzAV1pPlV/DtpCPu7vwj6dZaeBkmOoxpBwhd7BxxSOfdoQGXAfW6MC5X5LGDY/qmCI
         cjrgnucmvvbdObMCI7Yq+iQr6VDt8tXgQfK7xUWDmRxK8EUL8W+/8HqMggw9kBh9Wvzp
         xMMYSN/ZeIhEP5NgdRM8d39lRFjcEzmfhP+v6fkZPxSN+EfwprmpBzI88uNxU6KCmlj2
         X6EDK6tcY4tCrYD0L9LLdkOt3E/k9pvfRCibL2uaCZXUfqqzgIsmG9bcddCsfmO/eiSa
         aODA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ2WC4i6F2f0mPz3kzo7uJY5ekptCdyA7EefCriCW32QN3N2rTM/m05388pOFhO7OjEeqSU38bPYm/kedJUbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbu8OJ6hZ/9VVLho8iCNUSOp1onwgP864+lCnd5hdt3bBa/bjh
	1s+WV0PJufBDlPHacClfMCzjLGwidaDLsemk2VTKFDjZ+3lh9f9sa5MH6HrGmZRAG1KOrGNYp/J
	tJS0hBpTZe4MjE9E/qWNwojSBhaxZcJGwSoLRE0V47FQ8d+OK2s/WI6qMcJRefCaNztqpCO5HW3
	ga3pRf8prh2LeYeWDbpFgVL2ZxOUmhEzkyk21SPR+wn72f
X-Gm-Gg: ASbGncuoUfoUiNr4Y4L19SWlVWAYAR23zGkxWn46qzfMKG4M916lW9OMbpX1MBzVTVp
	i1Fis7wLkbVj514K2Ewi0mjXvbJAlYdLxTRrm7Hgv/12CNYdhxy3F+Wsovnw+DxKAIOijuymb+a
	1MCkqvy22sUDz2kw1Ekqd7AagkNmJkmpNIBemqYLf87PJpZ5B+wGKskb5YKcFpuaqRkwsl90yre
	oUe50ouAM3zvoY=
X-Received: by 2002:a05:622a:5:b0:4e8:b4d1:ece2 with SMTP id d75a77b69052e-4e8b4d1f832mr136116901cf.18.1761064073679;
        Tue, 21 Oct 2025 09:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+4bhTh0R0rxAhz5svf4CCiuJcWStZnahyEqAUmkhny4II2PoiiE/S+8ADSs8/XKYkUEz/fKi6H3YvlEckWRM=
X-Received: by 2002:a05:622a:5:b0:4e8:b4d1:ece2 with SMTP id
 d75a77b69052e-4e8b4d1f832mr136116461cf.18.1761064073103; Tue, 21 Oct 2025
 09:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910170000.6475-1-gpaoloni@redhat.com> <20250910170000.6475-2-gpaoloni@redhat.com>
 <878qifgxbj.fsf@trenco.lwn.net> <85166a8a-ad54-42d0-a09f-43e0044cf4f4@redhat.com>
 <CAB=6tBQP3aCDWch4ZcEYMqFsJ4OKXSyC_hb9V9hA7ZZty7vFeQ@mail.gmail.com> <042629f9-f295-494e-8fbd-e8751fcbe7c0@redhat.com>
In-Reply-To: <042629f9-f295-494e-8fbd-e8751fcbe7c0@redhat.com>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Tue, 21 Oct 2025 18:27:42 +0200
X-Gm-Features: AS18NWCYr1SX4wkTTAv1mmDjb6o7jALXBoi79rLo1c5c8AJEkanUrVwY-K7NzHM
Message-ID: <CA+wEVJYLF9T21-V2k0Y0zxcF0zcRG64QUVrM=qHDWHz7+4+ptw@mail.gmail.com>
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

Hi David

On Tue, Oct 21, 2025 at 5:37=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 20.10.25 23:02, Chuck Wolber wrote:
> > [Reposting with apologies for the dup and those inflicted by the broken=
 Gmail
> > defaults. I have migrated away from Gmail, but some threads are still s=
tuck
> > there.]
> >
> > On Mon, Oct 20, 2025 at 7:35=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >>>> +------------
> >>>> +The Documentation/doc-guide/kernel-doc.rst chapter describes how to=
 document the code using the kernel-doc format, however it does not specify=
 the criteria to be followed for writing testable specifications; i.e. spec=
ifications that can be used to for the semantic description of low level re=
quirements.
> >>>
> >>> Please, for any future versions, stick to the 80-column limit; this i=
s
> >>> especially important for text files that you want humans to read.
> >>>
> >>> As a nit, you don't need to start by saying what other documents don'=
t
> >>> do, just describe the purpose of *this* document.
> >>>
> >>> More substantially ... I got a way into this document before realizin=
g
> >>> that you were describing an addition to the format of kerneldoc
> >>> comments.  That would be good to make clear from the outset.
> >>>
> >>> What I still don't really understand is what is the *purpose* of this
> >>> formalized text?  What will be consuming it?  You're asking for a fai=
r
> >>> amount of effort to write and maintain these descriptions; what's in =
it
> >>> for the people who do that work?
> >>
> >> I might be wrong, but sounds to me like someone intends to feed this t=
o
> >> AI to generate tests or code.
> >
> > Absolutely not the intent. This is about the lossy process of convertin=
g human
> > ideas to code. Reliably going from code to test requires an understandi=
ng of
> > what was lost in translation. This project is about filling that gap.
>
> Thanks for clarifying. I rang my alarm bells too early :)
>
> I saw the LPC talk on this topic:
>
> https://lpc.events/event/19/contributions/2085/
>
> With things like "a test case can be derived from the testable
> expectation" one wonders how we get from the the doc to an actual test ca=
se.

Probably it is the term derived that can be a bit misleading. The point is =
that
we need documented expectations that can be used to review and verify the
test cases against; so maybe better to say "a test case can be verified aga=
inst
the testable expectation"

>
> IIRC, with things like formal verification we usually don't write  in
> natural language, because it's too imprecise. But my formal verification
> knowledge is a bit rusty.
>
> >
> >
> >> In that case, no thanks.
> >>
> >> I'm pretty sure we don't want this.
> >
> > Nor I. If you find any references in our work that amount to a validati=
on of
> > your concerns, please bring them to our attention.
>
> I guess, as the discussion with me and Jonathan showed, the cover letter
> is a bit short on the motivation, making people like me speculate a bit
> too much about the intentions.

Right, I'll keep this in mind for v2 and I will improve the motivation aspe=
ct
(also leveraging the response I gave to Jonathan).

Many thanks for your feedbacks!
Gab

>
> --
> Cheers
>
> David / dhildenb
>


