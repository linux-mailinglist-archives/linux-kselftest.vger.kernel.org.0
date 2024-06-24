Return-Path: <linux-kselftest+bounces-12575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8604915941
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 23:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A25B212DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 21:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5580C132122;
	Mon, 24 Jun 2024 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bP6Yshgl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CBD54757
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265823; cv=none; b=X9DfZx+GSvsQSyMvWyW8s7r8doBj9q/RZ0TRG35HN/YYygdnF2PZMFWH8rIJzrEcNsq0CEplHpftaNBiS5siQ6kDrly35iWKqT2ANz0ZCPSnGKQOCrRP+uXlmnlAWaYaxaszKMCoDFO++757Kdk9ySHLvBAyQiZE5GxBzIvytdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265823; c=relaxed/simple;
	bh=FoiUdQ7swPpEh3VgIWO/eUW1hfzGK5LLI1M3/9Im2U0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iPsVM/FyGKljO3qoDlgc3PAUj1jzn67JSfkDToEoK0RPhp9lM3KyC+KZ5iErkmZ11KmdHdy8w7pExlwp3aku3JY6ZCxq1DGNQ905N6Km7M+24tnLWcPshup6cuU5we0fh0W71EMhlOeEV1luvgj9rDOTagCIEFilPkowrk6BPBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bP6Yshgl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fa4b332645so21875ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 14:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719265821; x=1719870621; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2lDDpbzZjbYoW0ZccZa58xFekph1Nf38bp9Ut4WlNiM=;
        b=bP6YshglPnfMT1TYeGsO8YPNaNPRGJOUu9HQKh7VA7ZFNRGl0Spty3bgoLnY3UzACa
         7529QdJhEtwHQcQFKGWi4LtgsiRKFo9uJKCO5uCd+36+VM1zA0NwbtmiERRadBf4kHDy
         ra/tj857m6PZPheO9lDZ7MkzKIRji9olg5nfPC3B3mmaq6ye0b6JhGIS/hXIirbbx+8e
         aULE2s309uq3oH+MRjIdECUEq0nLUGXMYo7ttPjxEFHb4Qwj0OADZTL0CpVd5Pt+VG7T
         thntXvEzlGe7ueZqRCgcOZ8xl2CPT4AAKSwlH5eQstcpwY8SBaPwTbZERSoy3LiLGejh
         MZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719265821; x=1719870621;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lDDpbzZjbYoW0ZccZa58xFekph1Nf38bp9Ut4WlNiM=;
        b=L/oC/neyA0Qbb81r6RKJe/DTo1klmyjN/tyRFeMoohlo2STeBAVeq2a1w9ShsR8wnW
         kh6YKUKGL4lIdIJpL2fpm354/+Z8YKHAFiAp8eOy8ep7kd+5NrQVq8pyToHDo15XYpOV
         93jA26H7IY2dfYbPCAb0kTmbL4GzeL/5fYGnPGQKW29hlWkPWl59VU5+7MXt9GMb04VI
         uubZMbl9NOKWef8UvsLEVQv5V7CKCR9j3XPnpJ6VovZ5WhIcyRjH98/94eKnoDkXX3Kc
         fX2jJeWVMVdRuC41+scMm6jpfTae4HpN7rGhlaovmhhusoOaE0g45CWJf3MpEMCTiWDn
         7VQg==
X-Forwarded-Encrypted: i=1; AJvYcCXEnDD1jEx7+UuhT5X+d5nVDMqjLXl1r8ZEIYMTAm1kApbg6KyOti2d7wGYhzVeNp0B/GgnPKS6qH4sYlf31Lu8PO0qLw4bB73fMkbkBTTu
X-Gm-Message-State: AOJu0YxSWr4MEY2x2ZYcEwQBanPNh7ec5i5wxqZ1HXWodVP0DHEYuiJH
	5E7keJLlpmTMhkJKxsnWkoOePiO4CZFqW8cwgbTalT0m1UcuctHsl5M4rT753A==
X-Google-Smtp-Source: AGHT+IFeFR7zMjbNB9DCvgCjRBXeGOiI4lkJ8SgQ6QWD0Q5nCQ7py7AEvLDgXuqqLYyDF5Y75QDGNA==
X-Received: by 2002:a17:902:bd46:b0:1fa:2c8c:7e8 with SMTP id d9443c01a7336-1fa68fe3318mr1035325ad.4.1719265820845;
        Mon, 24 Jun 2024 14:50:20 -0700 (PDT)
Received: from [2620:0:1008:15:5ad8:4b69:7e4b:92e2] ([2620:0:1008:15:5ad8:4b69:7e4b:92e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5ef4sm67546215ad.163.2024.06.24.14.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 14:50:20 -0700 (PDT)
Date: Mon, 24 Jun 2024 14:50:19 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Sean Christopherson <seanjc@google.com>
cc: Elliot Berman <quic_eberman@quicinc.com>, Fuad Tabba <tabba@google.com>, 
    David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
    John Hubbard <jhubbard@nvidia.com>, 
    Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
    Matthew Wilcox <willy@infradead.org>, maz@kernel.org, kvm@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    pbonzini@redhat.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
In-Reply-To: <ZnnC6eh-zl16Cxn3@google.com>
Message-ID: <5e14ebf6-2a7f-3828-c3f6-5155026d59ae@google.com>
References: <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com> <20240619115135.GE2494510@nvidia.com> <CA+EHjTz_=J+bDpqciaMnNja4uz1Njcpg5NVh_GW2tya-suA7kQ@mail.gmail.com> <ZnRMn1ObU8TFrms3@google.com> <CA+EHjTxvOyCqWRMTS3mXHznQtAJzDJLgqdS0Er2GA9FGdxd1vA@mail.gmail.com>
 <4c8b81a0-3a76-4802-875f-f26ff1844955@redhat.com> <CA+EHjTzvjsc4DKsNFA6LVT44YR_1C5A2JhpVSPG=R9ottfu70A@mail.gmail.com> <8e9436f2-6ebb-4ce1-a44f-2a941d354e2a@redhat.com> <CA+EHjTzj9nDEG_ANMM3z90b08YRHegiX5ZqgvLihYS2bSyw1KA@mail.gmail.com>
 <20240621095319587-0700.eberman@hu-eberman-lv.qualcomm.com> <ZnnC6eh-zl16Cxn3@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2003064516-1965583562-1719265820=:2019105"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--2003064516-1965583562-1719265820=:2019105
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 24 Jun 2024, Sean Christopherson wrote:

> On Fri, Jun 21, 2024, Elliot Berman wrote:
> > On Fri, Jun 21, 2024 at 11:16:31AM +0100, Fuad Tabba wrote:
> > > On Fri, Jun 21, 2024 at 10:10 AM David Hildenbrand <david@redhat.com> wrote:
> > > > On 21.06.24 10:54, Fuad Tabba wrote:
> > > > > On Fri, Jun 21, 2024 at 9:44 AM David Hildenbrand <david@redhat.com> wrote:
> > > > >>
> > > > >>>> Again from that thread, one of most important aspects guest_memfd is that VMAs
> > > > >>>> are not required.  Stating the obvious, lack of VMAs makes it really hard to drive
> > > > >>>> swap, reclaim, migration, etc. from code that fundamentally operates on VMAs.
> > > > >>>>
> > > > >>>>    : More broadly, no VMAs are required.  The lack of stage-1 page tables are nice to
> > > > >>>>    : have; the lack of VMAs means that guest_memfd isn't playing second fiddle, e.g.
> > > > >>>>    : it's not subject to VMA protections, isn't restricted to host mapping size, etc.
> > > > >>>>
> > > > >>>> [1] https://lore.kernel.org/all/Zfmpby6i3PfBEcCV@google.com
> > > > >>>> [2] https://lore.kernel.org/all/Zg3xF7dTtx6hbmZj@google.com
> > > > >>>
> > > > >>> I wonder if it might be more productive to also discuss this in one of
> > > > >>> the PUCKs, ahead of LPC, in addition to trying to go over this in LPC.
> > > > >>
> > > > >> I don't know in  which context you usually discuss that, but I could
> > > > >> propose that as a topic in the bi-weekly MM meeting.
> > > > >>
> > > > >> This would, of course, be focused on the bigger MM picture: how to mmap,
> > > > >> how how to support huge pages, interaction with page pinning, ... So
> > > > >> obviously more MM focused once we are in agreement that we want to
> > > > >> support shared memory in guest_memfd and how to make that work with core-mm.
> > > > >>
> > > > >> Discussing if we want shared memory in guest_memfd might be betetr
> > > > >> suited for a different, more CC/KVM specific meeting (likely the "PUCKs"
> > > > >> mentioned here?).
> > > > >
> > > > > Sorry, I should have given more context on what a PUCK* is :) It's a
> > > > > periodic (almost weekly) upstream call for KVM.
> > > > >
> > > > > [*] https://lore.kernel.org/all/20230512231026.799267-1-seanjc@google.com/
> > > > >
> > > > > But yes, having a discussion in one of the mm meetings ahead of LPC
> > > > > would also be great. When do these meetings usually take place, to try
> > > > > to coordinate across timezones.
> 
> Let's do the MM meeting.  As evidenced by the responses, it'll be easier to get
> KVM folks to join the MM meeting as opposed to other way around.
> 
> > > > It's Wednesday, 9:00 - 10:00am PDT (GMT-7) every second week.
> > > >
> > > > If we're in agreement, we could (assuming there are no other planned
> > > > topics) either use the slot next week (June 26) or the following one
> > > > (July 10).
> > > >
> > > > Selfish as I am, I would prefer July 10, because I'll be on vacation
> > > > next week and there would be little time to prepare.
> > > >
> > > > @David R., heads up that this might become a topic ("shared and private
> > > > memory in guest_memfd: mmap, pinning and huge pages"), if people here
> > > > agree that this is a direction worth heading.
> > > 
> > > Thanks for the invite! Tentatively July 10th works for me, but I'd
> > > like to talk to the others who might be interested (pKVM, Gunyah, and
> > > others) to see if that works for them. I'll get back to you shortly.
> > > 
> > 
> > I'd like to join too, July 10th at that time works for me.
> 
> July 10th works for me too.
> 

Thanks all, and David H for the topic suggestion.  Let's tentatively 
pencil this in for the Wednesday, July 10th instance at 9am PDT and I'll 
follow-up offlist with those will be needed to lead the discussion to make 
sure we're on track.
--2003064516-1965583562-1719265820=:2019105--

