Return-Path: <linux-kselftest+bounces-26266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26108A2FE36
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF1B3A5070
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 23:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9985D25EF9F;
	Mon, 10 Feb 2025 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvCvLL87"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED125334D
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739229064; cv=none; b=b3KG3GEk4DqMBBbBwsN9QayRZIBK+1HvmwcuoXORLk7C+90k9ZndRWGcyeuqE0BkopJuUgL4VwFXw6dYUlGAhFXPvwPdXLrY2ZKMWumi8+gdDmlmU8MCvRGgn11AcxaIiHBfLovCAX8tQAXXhjnefW8G4xrLgGWpxqxYskrLtFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739229064; c=relaxed/simple;
	bh=I85yiPeGxjB3pHp4BZM6Tvv0YClNTRfIZsY3+9214ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d74+mbhc2m8q30UEEoD5MDDvV3K34au3HwA7AZDh9jBC0ay9sYodCgzJyknrHgEvKCY0TFvXE2Wvn676qHezxPXhqkmnDlkG7+DnqrgAD8xvaTvQNN9MAst05tBN19dXETBYyk9WTgWK/r/NEVzAPR7IttVO0B918U2n7HUpBkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvCvLL87; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739229061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6ZHTPoBjg/uWcJFr6X1NHVKDtKY1RU4PIMNX3aAG8g=;
	b=TvCvLL87AhqONjn473XnS1csk9PXdgCUwXqIy/1h2hnAVJAOR/Lm+eGRP4n1WB+B+SIhaF
	QngDr0c753OlKp2V30fqRB8WTbpJPwxGGUpVPhqldlkSUJ76UKxqOnvVYC9OlHFDCOxp9H
	iTU4q7BKUGB+vaoU1T/kLMQKps7Mct4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-s9R9yfhrNNWIwyQ9RyzNNw-1; Mon, 10 Feb 2025 18:11:00 -0500
X-MC-Unique: s9R9yfhrNNWIwyQ9RyzNNw-1
X-Mimecast-MFC-AGG-ID: s9R9yfhrNNWIwyQ9RyzNNw
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6f2b386136aso73383517b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 15:10:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739229059; x=1739833859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6ZHTPoBjg/uWcJFr6X1NHVKDtKY1RU4PIMNX3aAG8g=;
        b=jrkSVjDkk5vgkJwFQl6UfYgGNLmiXFMQO+4RLiffG0WrCIEFwsFHPxPukhcT5eswP3
         nOaZzZb8+sjqCsVqVjzdY+RvVMREtEi6gxmE7rkan5xN7BjsDmMeHNU2+uGsKGbvwYxz
         6vleqfRayB2ZAGV2K1NDcH88+AKWRdUva/lyemFRl6BSb4Rs8Sgj/LLzbHqDe5kNUZJO
         OIa2I5OU7qHL3RO+9jHfRttgXIeVBTBcmaUEaTZNZQ/VrfKewzV5CD0VQ9pkwhceQH9z
         oPuD5OxRjURd9M7HftBOhzNvhQjLwu5C5Mn1PF9xXi1ANFNqxeXXL+MwkAWWKdo2S0ve
         tZmw==
X-Forwarded-Encrypted: i=1; AJvYcCWwzERhlvtPdyGU7FfSI0fJKpDUHliIX5W9g8ezRcUu0XciC4jtxMM9YWSlc9MTV0VO2eX+5M3boEyx0Q8R8so=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfSccdbI3KPS1Ou24rulkZqwE+YqqKsl8S/+932v1ztdpMKTMn
	6UpDJ+Ewlv/DgSmWxXKmgV31uQo/O+H5hwLF4obiZyNzgZLo2GDbKXi6nFiZNb9JXxj8ftX0WdO
	t6eUzWwgF+4UNbF9RXMKHvWTYij5WDNA68Ly42LoSQ/JgKTHk39rK2/ShK4jEXM4HQQdkXuELNL
	6PVTjNjZvFUxw7x035C4YxzzDZ4jiGno28/qnjhsGH
X-Gm-Gg: ASbGncswRrv3GDMb/v2DshqHMBHC49wF8jlgcRAOiRU2FFAOfDB8uOb24tUaFly6On8
	fyqwjniHrYEYc8vpggYDX/sVKI1KiGU8uWesZwJAxApRuRHCdKNoWZY0kVDB4p/Z5gFi0i8Sp3g
	8=
X-Received: by 2002:a05:6902:1707:b0:e5b:21e4:d887 with SMTP id 3f1490d57ef6-e5b4619f375mr13712174276.19.1739229059275;
        Mon, 10 Feb 2025 15:10:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+uFDoQgt7ClLP9YRwsvG8gLINyPnKkvfjeiO8adNvnnks4vYT/H56Z3CUg+P5cCKTbi1EKyjELPBxs6+aa0U=
X-Received: by 2002:a05:6902:1707:b0:e5b:21e4:d887 with SMTP id
 3f1490d57ef6-e5b4619f375mr13712146276.19.1739229058920; Mon, 10 Feb 2025
 15:10:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>
 <Z6eaDuXnT_rjVSNS@thinkpad> <CAMuHMdUsq_39kgBa8oanXeTzv44HuhS1e5MK7K2jxkVXQ7uWdw@mail.gmail.com>
 <bd71c705-5f57-4067-b200-fd80b98ddbc9@nvidia.com> <8b4bb4f0-37fc-4215-a3a9-3771394f065f@redhat.com>
In-Reply-To: <8b4bb4f0-37fc-4215-a3a9-3771394f065f@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 10 Feb 2025 16:10:33 -0700
X-Gm-Features: AWEUYZnj374O6r-fMAMQWzYmUj3jVBsErlGEBDI0ezwDzb8h1N0CVNAmtj-2QQw
Message-ID: <CAA1CXcDXs7VRp=sfyDNTr6fR7MQ+pvb+w-o+gp-N6yTgdpMBRw@mail.gmail.com>
Subject: Re: distro support for CONFIG_KUNIT: [PATCH 0/3] bitmap: convert
 self-test to KUnit
To: David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yury Norov <yury.norov@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, David Gow <davidgow@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org, Brad Figg <bfigg@nvidia.com>, 
	Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 12:46=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 10.02.25 20:35, John Hubbard wrote:
> > On 2/9/25 11:54 PM, Geert Uytterhoeven wrote:
> >> On Sat, 8 Feb 2025 at 18:53, Yury Norov <yury.norov@gmail.com> wrote:
> >>> On Fri, Feb 07, 2025 at 03:14:01PM -0500, Tamir Duberstein wrote:
> >>>> On 7/27/24 12:35 AM, Shuah Khan wrote:
> > ...
> >>>> The crux of the argument seems to be that the config help text is ta=
ken
> >>>> to describe the author's intent with the fragment "at boot". I think
> >>
> >> IMO, "at boot" is a misnomer, as most tests can be either builtin
> >> or modular.
> >
> > Right.
> >
> >>
> >>> KUNIT is disabled in defconfig, at least on x86_64. It is also disabl=
ed
> >>> on my Ubuntu 24.04 machine. If I take your patches, I'll be unable to
> >
> > OK so I just bought a shiny new test machine, and installed one of the
> > big name distros on it, hoping they've moved ahead and bought into the =
kunit
> > story...
> >
> > $ grep KUNIT /boot/config-6.8.0-52-generic
> > # CONFIG_KUNIT is not set
> >
> > ...gagghh! No such luck. One more data point, in support of Yuri's comp=
laint. :)
> >
> >>
> >> I think distros should start setting CONFIG_KUNIT=3Dm.
> >
> > Yes they should! kunit really does have important advantages for many u=
se
> > cases, including bitmaps here, and "CONFIG_KUNIT is not set" is the mai=
n
> > obstacle.
>  > > Let me add a few people to Cc who might be able to influence some
> distros.
> >
> > thanks,
>
>
> Fedora has it.
>
> CS-10 has it (-> RHEL-10):
> redhat/configs/common/generic/CONFIG_KUNIT:CONFIG_KUNIT=3Dm
>
> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/blo=
b/main/redhat/configs/common/generic/CONFIG_KUNIT?ref_type=3Dheads
>
> CS-9 has it (-> RHEL-9):
> redhat/configs/common/generic/CONFIG_KUNIT:CONFIG_KUNIT=3Dm
>
> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/blob=
/main/redhat/configs/common/generic/CONFIG_KUNIT?ref_type=3Dheads
>
> So I think from the RH side everything is properly set?
>
> Let me CC Nico, he did some KUNIT work in the past.

Yeah that is correct! I enabled KUNIT in our environments a few years
ago. We enable it as a module and use our own wrapper to exercise the
code. For RHEL and Centos these kunit modules are only shipped
internally for testing; However fedora-rawhide makes these modules
available in the kernel-modules-internal package.

To test this you can follow this to install rawhide-vm:
https://developer.fedoraproject.org/tools/virt-builder/about.html
then inside the vm:
    yum install kernel-modules-internal
    add the kunit.enable=3D1 to the cmdline
    reboot vm
    modprobe kunit
    modprobe <test_name>

Hopefully that helps!
-- Nico



>
>
> --
> Cheers,
>
> David / dhildenb
>


