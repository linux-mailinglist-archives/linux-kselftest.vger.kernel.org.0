Return-Path: <linux-kselftest+bounces-20021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 011459A2C22
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A979E283C8F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC7A1E00A8;
	Thu, 17 Oct 2024 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6gljklG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421971DDC31
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189600; cv=none; b=bSS49YyBVacYRc9tpzvvmU64FETHLj2g1SCjqXCYuJ65eenHedT47zcWofg5SwuZ/vLiqwt7gAD9bdLS3KPCApH3WudpmFd7D6VTlBqBi4G5d8mjkeePxDqotuYzsMcGgcvJHfW4ka0crv9Vao4rJZO4UOHL5el9W1TUdQCgf3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189600; c=relaxed/simple;
	bh=haisNRIvKp7U74tfiCQRdN/EMuS4wJwswZUPjMFaKDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0WqHgR3F5X5qDcYVE06esrUDZEBtNbuRSbT6Re07v9HFkaydOP1VuhS5S3o/tl5VY+FCcEF36aK04INB9bzjGAUjaCoP4nl5gtN8C7i9kTkqLDnmYR3dXGHtiudRywrVTBu5mzMMUpLL5Qnk5/83mtCMl0tpcnnF5ohsPmzZi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6gljklG; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e681ba70so2733e87.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 11:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729189593; x=1729794393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haisNRIvKp7U74tfiCQRdN/EMuS4wJwswZUPjMFaKDo=;
        b=D6gljklGBHopPRhkeGDbVisFgp6Y6D0Np/KrkgtfinDIMMtsPSZV4sdQFiDyLYXnJJ
         eUtM1KkidY/eQwg7skAClF2F47W7HEDRJTUh98KeNIugK1naWmykWnxUfM6QsYQN3dlq
         GenzsUW8pApTf+0VMGvkAANypma4VYBGWKS1MATsPlbnHEVbM4QOf78iH6WyLK7IYkot
         XfWJh2NZPNNH2bjE0KLgkBAPZL7yaSKcqdMx1PTfnXWJTR6VJsOqqtcooY8s4PGk3wca
         P0t/kYH+aquWbAMRpqU7lyTf8cQdIkXkL01C5cbDxO6wYtKnVxqoh4Ft5A4S15jQwQ2U
         i2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729189593; x=1729794393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haisNRIvKp7U74tfiCQRdN/EMuS4wJwswZUPjMFaKDo=;
        b=bRGI+3ilqlMdDijZdStjyNMJUaIlZZKO0hF/3u/1ig1XSpKZ779vXXyrhpa6OpPYcT
         lxiIDMif0YYaXgFhJplmzaSKbvFKH1IGqQ5T8Li8io6MM7bO5IYJCkBxC6MD6Dv1hb7C
         3GwY9xTk4XY8hXvqLsztdcLUqHqX6+3RSQrJOuq590vuxXaBcfihpi6Un5hX8q/oJIij
         fIZJRLgn0MfygUaSbl3hXZiB9RUeWFNr2+7ptpJ+gbfCtTiVHbzQjTbynfB6OR3I8LnX
         KWeAVLiennYqkPXpK4uv7NGWoByRCmE4VO0pBCY/e6/3dSFVEGN+B8gELCmyTIdsbSJ/
         OAhg==
X-Forwarded-Encrypted: i=1; AJvYcCXNbrB+legcjaH+OkQfS98u5zZw171ZsQgnhpA4UMN9w08sWFXyfsVTU+BoD4e2QOBgfbb94ggwTxWnIzo2ptU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdhuursOXjoP9nrn1hVelh0e8YiTJ3KE48FMV1uxyzoOssT+Lg
	zxNmSJ6XhGQrObhX4heSJIpaLP2gT9irafi2/ICwZUXBbE+oK+RAmUYh1inORZUGv0m5RTb//uQ
	H73+lVL9pg+ZJpXTCDiblxCs2AJSYH+tPIujD
X-Google-Smtp-Source: AGHT+IGWKDDFm8a8fBCBsG2Y6cToQ+gN2kgFUiQJyVN3BtGBkj0D5sLim/0yEM3t9pwIBqy2Wfftr8DQHh7XIKriiLA=
X-Received: by 2002:a05:6512:282b:b0:535:3d14:1313 with SMTP id
 2adb3069b0e04-53a14c82458mr25866e87.0.1729189593089; Thu, 17 Oct 2024
 11:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zw7f3YrzqnH-iWwf@x1n> <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
 <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com> <ZxAfET87vwVwuUfJ@x1n>
 <20241016225157.GQ3559746@nvidia.com> <ZxBRC-v9w7xS0xgk@x1n>
 <20241016235424.GU3559746@nvidia.com> <ZxEmFY1FcrRtylJW@x1n>
 <20241017164713.GF3559746@nvidia.com> <a63f0f7a-e367-4f0e-8d8e-ca7b632712df@redhat.com>
 <20241017171639.GN3559746@nvidia.com>
In-Reply-To: <20241017171639.GN3559746@nvidia.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 17 Oct 2024 23:56:19 +0530
Message-ID: <CAGtprH-xdXCMSwnE9umz1CHgT2A83AM+w-GJxPp4y99FKpgVtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Ackerley Tng <ackerleytng@google.com>, tabba@google.com, quic_eberman@quicinc.com, 
	roypat@amazon.co.uk, rientjes@google.com, fvdl@google.com, 
	jthoughton@google.com, seanjc@google.com, pbonzini@redhat.com, 
	zhiquan1.li@intel.com, fan.du@intel.com, jun.miao@intel.com, 
	isaku.yamahata@intel.com, muchun.song@linux.dev, erdemaktas@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 10:46=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Thu, Oct 17, 2024 at 07:11:46PM +0200, David Hildenbrand wrote:
> > On 17.10.24 18:47, Jason Gunthorpe wrote:
> > > On Thu, Oct 17, 2024 at 10:58:29AM -0400, Peter Xu wrote:
> > >
> > > > My question was more torwards whether gmemfd could still expose the
> > > > possibility to be used in VA forms to other modules that may not su=
pport
> > > > fd+offsets yet.
> > >
> > > I keep hearing they don't want to support page pinning on a guestmemf=
d
> > > mapping, so VA based paths could not work.
> >
> > For shared pages it absolutely must work. That's what I keep hearing :)
>
> Oh that's confusing. I assume non longterm pins desired on shared
> pages though??
>
> Jason

For hugepage support to work, longterm pins on guest private pages
need to be avoided [1], If this somehow was the cause of any confusion
here.

[1] https://lpc.events/event/18/contributions/1764/attachments/1409/3182/LP=
C%202024_%201G%20page%20support%20for%20guest_memfd.pdf
(slide 12)

