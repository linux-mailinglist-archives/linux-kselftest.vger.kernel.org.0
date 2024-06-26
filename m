Return-Path: <linux-kselftest+bounces-12766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 526099176B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 05:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6137B21075
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 03:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA42461FCA;
	Wed, 26 Jun 2024 03:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1e4lL8ER"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4E6282FD
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 03:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719371969; cv=none; b=jXJdmZgMUDospWKZlVvSzbHSlzAu/ItE12Z5VwaQ+Hmr+qhFep8DlNKNO1lNY3PLi2wTKjJIaCGaGkz6Adyc0avf8UyXljZmTibjpRUYD4BerH0K4MI6sTFAFexq6OHBZNQve557PoB4Kdwwy+2XxjJJhFiFfC5MmI/s1DuQmPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719371969; c=relaxed/simple;
	bh=hUXgHF51lPNU1tjmMUrpwQio6r+zn/EwEX1X4j6f3tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKNx0c+OCBBMBI4lpq/k5FyymH+aObUOaX3Af62518lQ2Mho0DX8Y5NY3YPewQMiYeVQ2TF8Sz72rc0VvLepkHfQiFex5G6Jx04nO3QVbufFgptNGkA80rs3SvLXAaku3KXLsZEomjhPMP2fvOWwdu9hUC5qSpu3yK+BXj2Zah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1e4lL8ER; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7252bfe773so358285166b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719371966; x=1719976766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcEpi9Xsu+1gTxbES0/HeqU1vgappATrnUAd8kYmA4U=;
        b=1e4lL8ERjSSWLxbphXZaS5DK9ZdqdrG/L9uwfr9tHN2t0G3X+oNY2KabB+uaE6niqb
         6oMvtv58lMEiIDkeObKvjRRRscpbumOer1XZZkCvibHGT4wg7PmTVDpNTGrHu1+2HHfQ
         mJNUz+AXCUCLoHSe3TMw/YtaFxH0L4TQRpJvBwlxtOBGZO/mvJzTeSTvsDaETYzc7qeQ
         F48qY0vRjJV9PdkqAvRml1Z1vwuf68jwxDBQDrDpeLguN/yZ7uyiHy0HP38Zthdiilhv
         5JY5yB6riHFog7A7BKgHkUVjH3nCBtzcNoRLlGtCDSTSLm2i9S7y/+cinMfSOJewCRwH
         kelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719371966; x=1719976766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcEpi9Xsu+1gTxbES0/HeqU1vgappATrnUAd8kYmA4U=;
        b=fun+2eeYgUoLuMd/m9cYpofZSwj5etldyeP+kzfyVrIPXFS28XxvVT/CJF0iwaTBi9
         3/4exXs7elYo/afFv8iHEoKPw/e7w7YjbfjTgUHrIlUKZS3uEWxOImdxAkeq9PeqkBWf
         6vVURjL403DHrqjyXPas+0ZmE2peGXZ2BaD09BgOa9f4ieoJVOSkNJypw7/HcWp1b6nG
         rQz3QTcO/fDW6wtm+QwxottQDR9yu7Ca+tkBbJSG4hpOGNZXrk65UJccnFcwWjXWV9on
         JNS50al/EaMNoYi+4jgEe8ulrO6Ca/JhrSRtUaudoRR3LhHGgMbaGPsER+w+Ua9kuOCI
         0uWw==
X-Forwarded-Encrypted: i=1; AJvYcCX9ICa95+2wcoQU9OIyYFR0NQICNzl0tv7RfJil00cBQ/kOvfHr2cpYY6nh2W4AUFD2a4OwsVyiB3s1IwKDPio/U8K+jCleukLYpHLpsFN/
X-Gm-Message-State: AOJu0YwDmg91YaO8Bp4NLg6N9IBHEkXKH1+Nw5tuTEp2XMhwAxw1ncs3
	NoTZme4e02VypekZkHGEuSFZr9Upog7yeVHeVQwSsm418ZD+cOEaGFehOYTWsvVQVQXREEnFQ5D
	vozcF0Z25t/L3s+lWgIoACuUXSPFwaKahz5P3
X-Google-Smtp-Source: AGHT+IFLY2qZ3ScXikR8P0OWMEtmq1PJfSmSw962tpdr7XOdzhTxVacIeRIFA9/1ZPYRAeIb5P9js56rVkdjLokuTK4=
X-Received: by 2002:a17:906:af97:b0:a6f:5609:9552 with SMTP id
 a640c23a62f3a-a7245c85b6amr586678266b.10.1719371965815; Tue, 25 Jun 2024
 20:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com> <CA+EHjTz_=J+bDpqciaMnNja4uz1Njcpg5NVh_GW2tya-suA7kQ@mail.gmail.com>
 <ZnRMn1ObU8TFrms3@google.com> <CA+EHjTxvOyCqWRMTS3mXHznQtAJzDJLgqdS0Er2GA9FGdxd1vA@mail.gmail.com>
 <4c8b81a0-3a76-4802-875f-f26ff1844955@redhat.com> <CA+EHjTzvjsc4DKsNFA6LVT44YR_1C5A2JhpVSPG=R9ottfu70A@mail.gmail.com>
 <8e9436f2-6ebb-4ce1-a44f-2a941d354e2a@redhat.com> <CA+EHjTzj9nDEG_ANMM3z90b08YRHegiX5ZqgvLihYS2bSyw1KA@mail.gmail.com>
 <20240621095319587-0700.eberman@hu-eberman-lv.qualcomm.com>
 <ZnnC6eh-zl16Cxn3@google.com> <5e14ebf6-2a7f-3828-c3f6-5155026d59ae@google.com>
In-Reply-To: <5e14ebf6-2a7f-3828-c3f6-5155026d59ae@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 25 Jun 2024 20:19:12 -0700
Message-ID: <CAGtprH8VT6B6efy0dC=6cQEf6mpz3dfh2q4gGp2S-m+wNJn5ew@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
To: David Rientjes <rientjes@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Elliot Berman <quic_eberman@quicinc.com>, 
	Fuad Tabba <tabba@google.com>, David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>, maz@kernel.org, 
	kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 2:50=E2=80=AFPM David Rientjes <rientjes@google.com=
> wrote:
>
> On Mon, 24 Jun 2024, Sean Christopherson wrote:
>
> > On Fri, Jun 21, 2024, Elliot Berman wrote:
> > > On Fri, Jun 21, 2024 at 11:16:31AM +0100, Fuad Tabba wrote:
> > > > On Fri, Jun 21, 2024 at 10:10=E2=80=AFAM David Hildenbrand <david@r=
edhat.com> wrote:
> > > > > On 21.06.24 10:54, Fuad Tabba wrote:
> > > > > > On Fri, Jun 21, 2024 at 9:44=E2=80=AFAM David Hildenbrand <davi=
d@redhat.com> wrote:
> > > > > >>
> > > > > >>>> Again from that thread, one of most important aspects guest_=
memfd is that VMAs
> > > > > >>>> are not required.  Stating the obvious, lack of VMAs makes i=
t really hard to drive
> > > > > >>>> swap, reclaim, migration, etc. from code that fundamentally =
operates on VMAs.
> > > > > >>>>
> > > > > >>>>    : More broadly, no VMAs are required.  The lack of stage-=
1 page tables are nice to
> > > > > >>>>    : have; the lack of VMAs means that guest_memfd isn't pla=
ying second fiddle, e.g.
> > > > > >>>>    : it's not subject to VMA protections, isn't restricted t=
o host mapping size, etc.
> > > > > >>>>
> > > > > >>>> [1] https://lore.kernel.org/all/Zfmpby6i3PfBEcCV@google.com
> > > > > >>>> [2] https://lore.kernel.org/all/Zg3xF7dTtx6hbmZj@google.com
> > > > > >>>
> > > > > >>> I wonder if it might be more productive to also discuss this =
in one of
> > > > > >>> the PUCKs, ahead of LPC, in addition to trying to go over thi=
s in LPC.
> > > > > >>
> > > > > >> I don't know in  which context you usually discuss that, but I=
 could
> > > > > >> propose that as a topic in the bi-weekly MM meeting.
> > > > > >>
> > > > > >> This would, of course, be focused on the bigger MM picture: ho=
w to mmap,
> > > > > >> how how to support huge pages, interaction with page pinning, =
... So
> > > > > >> obviously more MM focused once we are in agreement that we wan=
t to
> > > > > >> support shared memory in guest_memfd and how to make that work=
 with core-mm.
> > > > > >>
> > > > > >> Discussing if we want shared memory in guest_memfd might be be=
tetr
> > > > > >> suited for a different, more CC/KVM specific meeting (likely t=
he "PUCKs"
> > > > > >> mentioned here?).
> > > > > >
> > > > > > Sorry, I should have given more context on what a PUCK* is :) I=
t's a
> > > > > > periodic (almost weekly) upstream call for KVM.
> > > > > >
> > > > > > [*] https://lore.kernel.org/all/20230512231026.799267-1-seanjc@=
google.com/
> > > > > >
> > > > > > But yes, having a discussion in one of the mm meetings ahead of=
 LPC
> > > > > > would also be great. When do these meetings usually take place,=
 to try
> > > > > > to coordinate across timezones.
> >
> > Let's do the MM meeting.  As evidenced by the responses, it'll be easie=
r to get
> > KVM folks to join the MM meeting as opposed to other way around.
> >
> > > > > It's Wednesday, 9:00 - 10:00am PDT (GMT-7) every second week.
> > > > >
> > > > > If we're in agreement, we could (assuming there are no other plan=
ned
> > > > > topics) either use the slot next week (June 26) or the following =
one
> > > > > (July 10).
> > > > >
> > > > > Selfish as I am, I would prefer July 10, because I'll be on vacat=
ion
> > > > > next week and there would be little time to prepare.
> > > > >
> > > > > @David R., heads up that this might become a topic ("shared and p=
rivate
> > > > > memory in guest_memfd: mmap, pinning and huge pages"), if people =
here
> > > > > agree that this is a direction worth heading.
> > > >
> > > > Thanks for the invite! Tentatively July 10th works for me, but I'd
> > > > like to talk to the others who might be interested (pKVM, Gunyah, a=
nd
> > > > others) to see if that works for them. I'll get back to you shortly=
.
> > > >
> > >
> > > I'd like to join too, July 10th at that time works for me.
> >
> > July 10th works for me too.
> >
>
> Thanks all, and David H for the topic suggestion.  Let's tentatively
> pencil this in for the Wednesday, July 10th instance at 9am PDT and I'll
> follow-up offlist with those will be needed to lead the discussion to mak=
e
> sure we're on track.

I would like to join the call too.

Regards,
Vishal

