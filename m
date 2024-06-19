Return-Path: <linux-kselftest+bounces-12242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED86A90EA4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 14:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A511C2168A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2213CFA0;
	Wed, 19 Jun 2024 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJ7/eVmy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E6813DDC9
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798514; cv=none; b=kJ9xYh+PmZvIXJBx8W4ci7aMMG4QpNtIAjkzh2ho/3Ldotwsde6/KXW9tPrYjHe9qRvJM/oHRSRTpt1mtfnm0BmqAsbEv7JwduVOLMwCNtOTQOt1XNodiZdlautC3cM8a5ydz3GS3BLgMRZ0KEhNblQYSyc9IBRhcnKG/UoeDj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798514; c=relaxed/simple;
	bh=FYVRkfdWOHFIaNl93eRsJCgFbdWq9Zi5DUBQJDGT+mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aj34uLwpS8GgO0mBwJBntplr8m6aHcRJGHW3hMh12FLAtfJKvHilR9sHOpS4wxt3/mz/Z/vjpyDn0ZUI+mxP/c4V66Myax6USf3Vj2pOtcyPQXhvn2CTHrteyaJLGCIdayBsjsqCASS1JyKB3VTZfNyjFOzYrX7wbNcsiZ287oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJ7/eVmy; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d229baccc4so3139189b6e.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718798511; x=1719403311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOim+GQVHsUMHPzr0/zmYaztK3VZnG5jmRJWacqKqkM=;
        b=UJ7/eVmyUTRWAT2Y60xDGiljeheMkQeOky862/m14dmhpbSvMgDHMCH4B+xRlRu994
         cpOy69zrsxh5Had2/qN3TTg1FgW58DQcKyN8F6yxkPTFULPWgJhxnjyD61pV8JhIupuz
         f336PMB+MK2r3IsdfMQykPN5q65RQKGzDqXzJ/aCYQSavtQHa6qsqKHdPKX42sqX+MdU
         Rc7Wb0/WoP5n+qztwW2vz1p0dUCh2YyBVg2qRUyVqDS+SpvebLynJijKyfu7IRSnHlS6
         TK8DzEJZfd77H2/2qmaAFr1HOQpZtrJPRGfd0F2irFZpMZg8aQmzj6MJkypNg/YIkpxd
         w6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798511; x=1719403311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOim+GQVHsUMHPzr0/zmYaztK3VZnG5jmRJWacqKqkM=;
        b=Je0iYKtJb+U/BHX2ePrSszA/Q5BfgPm2IzrqKivXovZ3k/mfjBCgndO7axmbc6e+2v
         em3y/Iz1WpGr/h6vjDwnx3kRqRogqL68EB9w7Qgx0XKkRuegOzTL+ABH55ImHwwzJpBI
         /kJY+Ch1hLiil2zbdCKH+k342QPQpACYOqMPIVCBhoXpZIufN9r2FTkDYkor/6o4DJra
         /WJndJtARXhRrjLnol8fY00/YWEax2SVV1iyRoECU7041O0Xem0iwHNY/JVG2+wQs+5R
         AZUcMtGz7MVBRAlpYWgXkvPcz8AFzA2nPRT4DlAELeRSZSehFJR4/MYqt2DaBLti7AtH
         EOew==
X-Forwarded-Encrypted: i=1; AJvYcCVDc0clgcv9RFdgEjvJtjr6Ox4G+Vd8r3FW4lEosm8Pm5liw5EWlnH8LeabRTAjOsv8MwQXKY/+J4wtrivoajjOTNyR+a+DlIx1rLbSgXH5
X-Gm-Message-State: AOJu0YzzhBE+7cpY7fEIDlJgR4ESitSYsEPlGP1iJcoGJwiGS0StKX48
	M6UENwsqkfR/Mk7PsITAMdyhZ+NR0aLAnNJppezghrGVEup+7Kza/bqBq4rkEBpbf4rQrIP/U+U
	22lTZg8GaKOiVGH+YePI9dDmv1FMvaq748aUE
X-Google-Smtp-Source: AGHT+IEn8HCT0+a4ly7gvmO3sbJl6r+3UVNd8+bJNqdKRtJx00yvI5NJhWVel34eQ5lTMDMcqvOsVTaCCjBhWoD15B8=
X-Received: by 2002:a05:6808:128b:b0:3d5:1f50:188a with SMTP id
 5614622812f47-3d51f5028a9mr1376646b6e.24.1718798511327; Wed, 19 Jun 2024
 05:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com> <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com> <20240619115135.GE2494510@nvidia.com>
In-Reply-To: <20240619115135.GE2494510@nvidia.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 19 Jun 2024 13:01:14 +0100
Message-ID: <CA+EHjTz_=J+bDpqciaMnNja4uz1Njcpg5NVh_GW2tya-suA7kQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>, 
	Elliot Berman <quic_eberman@quicinc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>, maz@kernel.org, 
	kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Wed, Jun 19, 2024 at 12:51=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Wed, Jun 19, 2024 at 10:11:35AM +0100, Fuad Tabba wrote:
>
> > To be honest, personally (speaking only for myself, not necessarily
> > for Elliot and not for anyone else in the pKVM team), I still would
> > prefer to use guest_memfd(). I think that having one solution for
> > confidential computing that rules them all would be best. But we do
> > need to be able to share memory in place, have a plan for supporting
> > huge pages in the near future, and migration in the not-too-distant
> > future.
>
> I think using a FD to control this special lifetime stuff is
> dramatically better than trying to force the MM to do it with struct
> page hacks.
>
> If you can't agree with the guest_memfd people on how to get there
> then maybe you need a guest_memfd2 for this slightly different special
> stuff instead of intruding on the core mm so much. (though that would
> be sad)
>
> We really need to be thinking more about containing these special
> things and not just sprinkling them everywhere.

I agree that we need to agree :) This discussion has been going on
since before LPC last year, and the consensus from the guest_memfd()
folks (if I understood it correctly) is that guest_memfd() is what it
is: designed for a specific type of confidential computing, in the
style of TDX and CCA perhaps, and that it cannot (or will not) perform
the role of being a general solution for all confidential computing.

> > The approach we're taking with this proposal is to instead restrict
> > the pinning of protected memory. If the host kernel can't pin the
> > memory, then a misbehaving process can't trick the host into accessing
> > it.
>
> If the memory can't be accessed by the CPU then it shouldn't be mapped
> into a PTE in the first place. The fact you made userspace faults
> (only) work is nifty but still an ugly hack to get around the fact you
> shouldn't be mapping in the first place.
>
> We already have ZONE_DEVICE/DEVICE_PRIVATE to handle exactly this
> scenario. "memory" that cannot be touched by the CPU but can still be
> specially accessed by enlightened components.
>
> guest_memfd, and more broadly memfd based instead of VMA based, memory
> mapping in KVM is a similar outcome to DEVICE_PRIVATE.
>
> I think you need to stay in the world of not mapping the memory, one
> way or another.

As I mentioned earlier, that's my personal preferred option.

> > > 3) How can we be sure we don't need other long-term pins (IOMMUs?) in
> > >     the future?
> >
> > I can't :)
>
> AFAICT in the pKVM model the IOMMU has to be managed by the
> hypervisor..

I realized that I misunderstood this. At least speaking for pKVM, we
don't need other long term pins as long as the memory is private. The
exclusive pin is dropped when the memory is shared.

> > We are gating it behind a CONFIG flag :)
> >
> > Also, since pin is already overloading the refcount, having the
> > exclusive pin there helps in ensuring atomic accesses and avoiding
> > races.
>
> Yeah, but every time someone does this and then links it to a uAPI it
> becomes utterly baked in concrete for the MM forever.

I agree. But if we can't modify guest_memfd() to fit our needs (pKVM,
Gunyah), then we don't really have that many other options.

Thanks!
/fuad

> Jason

