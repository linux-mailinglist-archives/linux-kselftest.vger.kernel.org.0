Return-Path: <linux-kselftest+bounces-41435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A47B55A94
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 02:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2043E1CC4114
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 00:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4C7C8F0;
	Sat, 13 Sep 2025 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bGYDJcYF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502AC2FB
	for <linux-kselftest@vger.kernel.org>; Sat, 13 Sep 2025 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757722701; cv=none; b=NxTWeXYY8X6QRBdvatTWbudOwI9zgjrmqdpG5YswYUtkP2ppqm5Zgup4ygzvtsN3yLlkIfu2OrDWc+bxq+PJPIMcw9Vz9hjVF6IpD0qxJGZFOPs4a3tVGTCd838cx2O2lCVSnBsJ5Xo2CSTeajHR9k+aiT0RP96o89tqobZLUiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757722701; c=relaxed/simple;
	bh=Mh6aGJrEoSKc8SjghJ9/lN7NlH7QvKqYibdt1arxBbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAHEPOAeB4USy/62f4H5yP6eoHF3LGJpH51SwJeDDvzlZqvy1AlJ0qAwQaoOgiktIjGFE190nxFpFRfTj9AqDkL6JPKUXZI/U+2m+ZIpBjPoqsfxcOPBUAKQFjj7dNKke3TMvg59mMEKwzG8WOQ8jrhj8RGTXFO2QGADJ2oIq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bGYDJcYF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24b2d018f92so41565ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 17:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757722700; x=1758327500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE3G8ORdwUU6jAQHJONdXUYaEO2BnYkTOmxj8OqkFn8=;
        b=bGYDJcYFTB8L6n5vjTI6ouZqtNyQs6JGh00JjAaQv8Ed8aFEVz694UhhtOEkwYI8mV
         6ASzX/HgppuN0Y4ZH3EbnD6hE5XBrTTLD/r1Wowp+0NpTVqfCVTLZdeIdGyoIeelpOJN
         d2j+ZEvar4GAhtHSXlzIpsJysS8WFp6nWY8Vq6G6lZPFjJfD1GdXCvhQ0sRlMN9FTJRp
         IDXhswjxb8OkVGl939tGbOFD92whrxIQTka0cNeUbi/Z3fjgDaVzkqsY92Qjmslt5fzm
         4CTfX1cAqESLcn483nYWvdCReceUV6aB3ZzrJ8frEZeySS6bATxAskN+xj17BLzZjsWf
         LwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757722700; x=1758327500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE3G8ORdwUU6jAQHJONdXUYaEO2BnYkTOmxj8OqkFn8=;
        b=FVYINQO06hdq5bgRDLgojk+TWVt55N0PUmaSlzBYjb2FVLUZ7BO+w4EBU33nH256Gp
         dqrseNUmFiheGj9CNXoiBuL1SRtkN5BiXcLGj9NJ4TYCGFwS1cTgpJQ7yU9G73hjkhQm
         zQU+j9Wzd6F2akav7uwK2kvTmRT4p+QMMn14tsLJ+KgL1JH8WZFqq6cyMPObcITs5wUN
         yL/vWmBOL1N52nuV52nIV2kJM979n754YqrJivz9icGsAgs0exER3GLmqgsMW9Qwo+EP
         sXVdPY29bN0+DHRZsNfoRY1mwHcxUdiyM8JKHEy9tdnGRbEE3Qm289EYTCQBqu2AHv8O
         Qwjw==
X-Forwarded-Encrypted: i=1; AJvYcCXi1+K5fBTxHMBM4Nj0Ow6jx2ns0EDMTf7p6U8q4C8l0kj5QV5eUJ0EjixZ0vjW1vyFkftwbikB6AYf8Dva+z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWnNcG/yzHN6GdB2C4ryL3alFj3pZ+kC5KUCtg/h4tWiFwP3b
	+eBKFZrVLZSxXmvqj+O2CTRj+/91/4BmQKc1SJwL2vRM3H2wsJr2+ItkYeht+Y+uFJTiIZVMTuY
	ulw9ifLCgCwjbmWv2VdSV/8zONyFkJ9nu+DIm307b
X-Gm-Gg: ASbGnctlaM5xR4ykVdEuQj2V4DATglSXDiEPr2ypry9Li+jxlMihpJuDB1+ntJHFQ/W
	cfstzyvHbWG3awSzH9wFWR8ZnX8pSiLlnPkDThvQ+URUGngxVH3RMvPFIzHqrkpRBt24DepIkO9
	f4a5ei65JLKVmjicoalu/PM7RK6n/POL8UHfqf/9WuwJrzbTqBzwfqH/C/Saizm/ZwnnGo0gq4H
	DjGcTGt9FLgHiZ0DmwTqDJNO6zCLriuIzcMNgff37l8
X-Google-Smtp-Source: AGHT+IGzaRnKMgioFkIn9MZTAWIdQlLt1DnmIKhZcaFLkMy9Q3yssinqrzxX1g/AzMrr4tSaSGNncmZBKNCa8ms9HGE=
X-Received: by 2002:a17:903:2343:b0:25b:fba3:afa7 with SMTP id
 d9443c01a7336-260e5f7673cmr1151165ad.10.1757722699324; Fri, 12 Sep 2025
 17:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902111951.58315-1-kalyazin@amazon.com> <20250902111951.58315-2-kalyazin@amazon.com>
 <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com>
 <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com> <8e55ba3a-e7ae-422a-9c79-11aa0e17eae9@redhat.com>
 <bc26eaf1-9f01-4a65-87a6-1f73fcd00663@amazon.com> <55b727fc-8fd3-4e03-8143-1ed6dcab2781@redhat.com>
In-Reply-To: <55b727fc-8fd3-4e03-8143-1ed6dcab2781@redhat.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 12 Sep 2025 17:18:06 -0700
X-Gm-Features: Ac12FXw70ExrJvBQi4rgyWRbyc1xOL8CupFdmrDzb2GfYcck5L74n4hu4AFRWBE
Message-ID: <CAGtprH8QjeuR90QJ7byxoAPfb30kmUEDhRhzqNZqSpR8y_+z9g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
To: David Hildenbrand <david@redhat.com>
Cc: kalyazin@amazon.com, James Houghton <jthoughton@google.com>, 
	"Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "michael.day@amd.com" <michael.day@amd.com>, 
	"Roy, Patrick" <roypat@amazon.co.uk>, "Thomson, Jack" <jackabt@amazon.co.uk>, 
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 8:39=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> >>>> What's meant to happen if we do use this for CoCo VMs? I would expec=
t
> >>>> write() to fail, but I don't see why it would (seems like we need/wa=
nt
> >>>> a check that we aren't write()ing to private memory).
> >>>
> >>> I am not so sure that write() should fail even in CoCo VMs if we acce=
ss
> >>> not-yet-prepared pages.  My understanding was that the CoCoisation of
> >>> the memory occurs during "preparation".  But I may be wrong here.
> >>
> >> But how do you handle that a page is actually inaccessible and should
> >> not be touched?
> >>
> >> IOW, with CXL you could crash the host.
> >>
> >> There is likely some state check missing, or it should be restricted t=
o
> >> VM types.
> >
> > Sorry, I'm missing the link between VM types and CXL.  How are they rel=
ated?
>
> I think what you explain below clarifies it.
>
> >
> > My thinking was it is a regular (accessible) page until it is "prepared=
"
> > by the CoCo hardware, which is currently tracked by the up-to-date flag=
,
> > so it is safe to assume that until it is "prepared", it is accessible
> > because it was allocated by filemap_grab_folio() ->
> > filemap_alloc_folio() and hasn't been taken over by the CoCo hardware.
> > What scenario can you see where it doesn't apply as of now?
>
> Thanks for clarifying, see below.
>
> >
> > I am aware of an attempt to remove preparation tracking from
> > guest_memfd, but it is still at an RFC stage AFAIK [1].
> >
> >>
> >> Do we know how this would interact with the direct-map removal?
> >
> > I'm using folio_test_uptodate() to determine if the page has been
> > removed from the direct map as kvm_gmem_mark_prepared() is what
> > currently removes the page from the direct map and marks it as
> > up-to-date.  [2] is a Firecracker feature branch where the two work in
> > combination.
>
> Ah, okay. Yes, I recalled [1] that we wanted to change these semantics
> to be "uptodate: was zeroed", and that preparation handling would be
> essentially handled by the arch backend.

Yes, I think we should not be overloading uptodate flag to be an
indicator of what is private for CoCo guests. Uptodate flag should
just mean zeroed/fresh folio. It's possible that future allocator
backing for huge pages already provides uptodate folios.

If there is no current use case for read/write for CoCo VMs, I think
it makes sense to disable it for now by checking the VM type before
adding further overloading of uptodate flags.

>
> --
> Cheers
>
> David / dhildenb
>
>

