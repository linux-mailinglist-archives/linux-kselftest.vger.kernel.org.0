Return-Path: <linux-kselftest+bounces-12413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E43911F7A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC731F25F7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841FB16D9C5;
	Fri, 21 Jun 2024 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aqic3j4b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DCB16D9B9
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960091; cv=none; b=i/1Td09CsFj9HilKqoELsaOTqA3qJU9YOqxqdE0hMUYONgZ9PYnRIkUxa9QVCw9EaNFacRDNennWkDqPWMBPg2Ta9oU3Zr8b93PyiSHor2HihdjATYg6khf8yRnuAuLHNWBQyuo2RcxC9kzot4Qm4kKbYwbOKApY5Xz5Uy3PRUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960091; c=relaxed/simple;
	bh=C8ybsMTbYwXEy9pNJgGuUwtT7s6ItRLeMRTEkqLDyuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0YFf+aZRz1lVokPzIt8c277ce+1dGaNzChnyeDTYoqE42H0I7fKidDGs6uqbaTjLT9BlPAL8x+OiCvyjHzNWUTd9EXyFdk8ymuvPZlXqCOZZlWKc9I52b/ZrOq+7JpDJNx+zLd4ZHWLpC04x7dUGTxZPLuJ8P3Yjs3C5oq+xFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aqic3j4b; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4ed0c84c749so1643971e0c.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 01:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718960089; x=1719564889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYX2FT4NFr8Qk3CdgyGwyy67UucRagXIxiXFznR5hco=;
        b=Aqic3j4bVaav4Gg2qEB6BLOPTYtmvqa216ufW28qEzKQ6h2jTogR9NIfzi2Lt7kDUH
         T9mheHRM93UtSRjWr3DN4s9rNmATc+NZiJ0BDI0cwYvdweHwCZZVErQT77/ZsABXiNhA
         K71VIPKS5Ufbt4nzniweNBrZTq7Y7Sseh0SZm5zGZcYeM/96Ah7782Nu3nesOGB3vEvX
         d0wj+GvRsvpYXm7eFpsq8te4sQ/S/N7o6b8DJ2fVYu2JJ5z3MVxZV14qSthOp1EGxbYJ
         1OhkbicZ9tByuzlZH1Ok7ZzQ40/IT3zvi8hZ5N4BycOKHsPETCvyn/W5PdICiXvt4wMJ
         IQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718960089; x=1719564889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYX2FT4NFr8Qk3CdgyGwyy67UucRagXIxiXFznR5hco=;
        b=mv2rkyKeqJWZNZwqA7WsVqhAV9rJQHhWJonZjvxJU0NYKlVUF44VBG/IFGhhgzsimR
         W1aWJhzXymDD1fNNjB6TpEnMaUQebfvhZnAbIkf0JTvj+ZHpV+QueDZYzamefLhbemC8
         wRsXIXev4wk94HRjtegvLzx1N4JoqMQUNO0rK2Cf9yBDnCPA8aYuFfCzkOfG8v1XSdg/
         9AeR1qqHiZKeDceFbSxLTEI6zd8M3MzEYVcUZvTFq7vNXtPqi1VoCL4nHTxxGi3bsgx+
         yCjwhgxfhEReVQifXzj/SLHcaOeWeztSy4HNWNOifhhv3a4EW6yXABdAsdYWvlnuZ3zd
         OqlA==
X-Forwarded-Encrypted: i=1; AJvYcCVllu778y22up7pN4QLZcplALMlkv87xABGAyE420IPKiCu2vskv6m/keZPjqZJnBHYptaMiINsyvbh7BZC+djh2pCnnYOe6ZKvX1OYwP9+
X-Gm-Message-State: AOJu0Ywq5PldEoVPVCYOdPs+EhCJhGXrp3QUvzD6yV81OWvTDY+nnZ5g
	6LUyav9qZb8lR2WAJpHjjxhDa4JnQKEBcYQpYJAacOSG/1zQarDHHz9lCPwMRqV4dzQFRKCKKRX
	+/OKw0HW57JQ9L+tu+zq3H/x/lPsnFUfyBjEh
X-Google-Smtp-Source: AGHT+IE+4r9WRty/Arup00wvViToPFouwguOScRaXAgLBJYNMjH1J9pgCzwiTT3frpsC9/op0vu9j85DaYbfM+65eZo=
X-Received: by 2002:a05:6122:3688:b0:4eb:e37:2d19 with SMTP id
 71dfb90a1353d-4ef1a9e5b96mr9551360e0c.1.1718960088716; Fri, 21 Jun 2024
 01:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com> <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com> <CA+EHjTz_=J+bDpqciaMnNja4uz1Njcpg5NVh_GW2tya-suA7kQ@mail.gmail.com>
 <ZnRMn1ObU8TFrms3@google.com> <CA+EHjTxvOyCqWRMTS3mXHznQtAJzDJLgqdS0Er2GA9FGdxd1vA@mail.gmail.com>
 <4c8b81a0-3a76-4802-875f-f26ff1844955@redhat.com>
In-Reply-To: <4c8b81a0-3a76-4802-875f-f26ff1844955@redhat.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 21 Jun 2024 09:54:12 +0100
Message-ID: <CA+EHjTzvjsc4DKsNFA6LVT44YR_1C5A2JhpVSPG=R9ottfu70A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
To: David Hildenbrand <david@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	John Hubbard <jhubbard@nvidia.com>, Elliot Berman <quic_eberman@quicinc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, maz@kernel.org, kvm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Jun 21, 2024 at 9:44=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> >> Again from that thread, one of most important aspects guest_memfd is t=
hat VMAs
> >> are not required.  Stating the obvious, lack of VMAs makes it really h=
ard to drive
> >> swap, reclaim, migration, etc. from code that fundamentally operates o=
n VMAs.
> >>
> >>   : More broadly, no VMAs are required.  The lack of stage-1 page tabl=
es are nice to
> >>   : have; the lack of VMAs means that guest_memfd isn't playing second=
 fiddle, e.g.
> >>   : it's not subject to VMA protections, isn't restricted to host mapp=
ing size, etc.
> >>
> >> [1] https://lore.kernel.org/all/Zfmpby6i3PfBEcCV@google.com
> >> [2] https://lore.kernel.org/all/Zg3xF7dTtx6hbmZj@google.com
> >
> > I wonder if it might be more productive to also discuss this in one of
> > the PUCKs, ahead of LPC, in addition to trying to go over this in LPC.
>
> I don't know in  which context you usually discuss that, but I could
> propose that as a topic in the bi-weekly MM meeting.
>
> This would, of course, be focused on the bigger MM picture: how to mmap,
> how how to support huge pages, interaction with page pinning, ... So
> obviously more MM focused once we are in agreement that we want to
> support shared memory in guest_memfd and how to make that work with core-=
mm.
>
> Discussing if we want shared memory in guest_memfd might be betetr
> suited for a different, more CC/KVM specific meeting (likely the "PUCKs"
> mentioned here?).

Sorry, I should have given more context on what a PUCK* is :) It's a
periodic (almost weekly) upstream call for KVM.

[*] https://lore.kernel.org/all/20230512231026.799267-1-seanjc@google.com/

But yes, having a discussion in one of the mm meetings ahead of LPC
would also be great. When do these meetings usually take place, to try
to coordinate across timezones.

Cheers,
/fuad

> --
> Cheers,
>
> David / dhildenb
>

