Return-Path: <linux-kselftest+bounces-12372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AD49115C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 00:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CAB1C20D27
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 22:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750668288F;
	Thu, 20 Jun 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ziWgiCQs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8B464A98
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922751; cv=none; b=BTQRreXBc1Fpmvq/XVU16G4lZcen+XlRTv5HMoafUXJyfTJIZ6jNUZKR0GuiocV/upDdutHeonfrwSAn79Iv9GHbMzh7RqeKqnfCOAVxmtcqWCPv83S+/5GgG207SGi/bEsVVgznoJ1+J7htc1tpVZpAgwLC/RUb2C3S7ThObs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922751; c=relaxed/simple;
	bh=wPyrfyOcJKrFlQqdsvbVInKDWmVrmJ7EXk00664mnVY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bbIv6gg2bnb+xEg5TY876Hhe0JH4LUZ9jV+aDdh3PTXsXCChJiG8d17grE3Y+gPXYe5efTBmcdTj09zOeDtQreVTEkbkuddUjO0zljd0D6Ba1W9u5Mjck+GPVuQsbqicCdnzqZZI0tfz6OLkV3m77GMdKmitBnKY+22qFBwSvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ziWgiCQs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63bb7fb3229so24736187b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 15:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718922749; x=1719527549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=auxotihlkK8h83W2bzIbhNSOdi4xEkdwqnFVqelIJic=;
        b=ziWgiCQsN9kHQVwWz8Jd4IxEBbuqnWoj8jhuS3W+HMzXKnyaXj1Y7wW9Odo/BEkVXs
         WOHDy9T3CvcmONF+9FL8ZxJM7EJ+f9wHhnLJly+WbDucpb7feu9MfCYbiqkyRrL8o6dF
         pKV04Rn/3VVE+BQwZaKhb3kDrSgMIWT9KHajvToounQ+NkOffF6IHQ0Xybr6mCz7+beX
         h6Mytig4cQZtgcHnC3kKSveZ6tBEDqepaA4iXjqa0oJKLngkhHHUFI5PVZUYn2yLpotE
         iM8x0bdOAcQ2fYQzEWFCHJfAXTuhtoOk/M6Aoj5lNFyopW1lqj+32WX0dg3Nd5qCYc1C
         AA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718922749; x=1719527549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=auxotihlkK8h83W2bzIbhNSOdi4xEkdwqnFVqelIJic=;
        b=oNil3Vy/ygLxghdmGeAJFQXAmFYs8qztQ/rgprDyvbIsUXRUY36AJrOY9FRErDwXZF
         Ga4y5B+fDTPVr69i/mBlxOZsfmHdgMQ+V42f1JJWOTIkMbzXq2BFCW1NgDzV5UrC3E8Q
         SKanDDh2gl/vn5QyZ5PHU6SWT7udrKnRohzJKpm1GnHqzYldKZkRzoufibbK5BEHNu/x
         rM5NydnokMT+utlVO7Xmn+qXeuTbzNIc4gZVziyIO5d7RUuq5lc39BHFoC30Hq93NyEL
         6jWYyCUWBKKMcd7fv3e7z8Pz33+Adiq1KcAx3u4yiy9Tolly+lXswQ2k/mmRPaxQmMoj
         oT+g==
X-Forwarded-Encrypted: i=1; AJvYcCWJfrRkibS5zxNslKEWCEAP77fGFzPChcqoLmxq4JnfYfZCM9w4i+m8ig6Cq4PZy/V5GRDREn/IyXgWY6RL0AOClJZ/XeNykLfknGUlUKq0
X-Gm-Message-State: AOJu0Ywld161QG4XJSbhdwOmODeCYy+yGN1M8+EhqVcEa21u7NyMxhsj
	zNd+Na7GfsnuxPzGrtxWYH2crycPJKvNWEJIYNlVkhFDrFr3eEGlajHMcwJ5qlerdRF/PQGQQnj
	Vbw==
X-Google-Smtp-Source: AGHT+IGHcNRLshBOMyztBLTs8rVKhKRXiJZQJYiLLVyOYcXhh1aFZDp6gOCGM/6iHRYpAGgEpAN5Al5CfjI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6105:b0:62f:5d17:3628 with SMTP id
 00721157ae682-63a8ae564c0mr15344897b3.0.1718922748971; Thu, 20 Jun 2024
 15:32:28 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:32:27 -0700
In-Reply-To: <53d1e7c5-3e77-467b-be33-a618c3bb6cb3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZnOsAEV3GycCcqSX@infradead.org> <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com> <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com> <385a5692-ffc8-455e-b371-0449b828b637@redhat.com>
 <20240620163626.GK2494510@nvidia.com> <66a285fc-e54e-4247-8801-e7e17ad795a6@redhat.com>
 <ZnSRZcap1dc2_WBV@google.com> <53d1e7c5-3e77-467b-be33-a618c3bb6cb3@redhat.com>
Message-ID: <ZnSt-_dkjStvT1WB@google.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Fuad Tabba <tabba@google.com>, 
	Christoph Hellwig <hch@infradead.org>, John Hubbard <jhubbard@nvidia.com>, 
	Elliot Berman <quic_eberman@quicinc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>, maz@kernel.org, 
	kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 20, 2024, David Hildenbrand wrote:
> On 20.06.24 22:30, Sean Christopherson wrote:
> > On Thu, Jun 20, 2024, David Hildenbrand wrote:
> > > On 20.06.24 18:36, Jason Gunthorpe wrote:
> > > > On Thu, Jun 20, 2024 at 04:45:08PM +0200, David Hildenbrand wrote:
> > > > 
> > > > > If we could disallow pinning any shared pages, that would make life a lot
> > > > > easier, but I think there were reasons for why we might require it. To
> > > > > convert shared->private, simply unmap that folio (only the shared parts
> > > > > could possibly be mapped) from all user page tables.
> > > > 
> > > > IMHO it should be reasonable to make it work like ZONE_MOVABLE and
> > > > FOLL_LONGTERM. Making a shared page private is really no different
> > > > from moving it.
> > > > 
> > > > And if you have built a VMM that uses VMA mapped shared pages and
> > > > short-term pinning then you should really also ensure that the VM is
> > > > aware when the pins go away. For instance if you are doing some virtio
> > > > thing with O_DIRECT pinning then the guest will know the pins are gone
> > > > when it observes virtio completions.
> > > > 
> > > > In this way making private is just like moving, we unmap the page and
> > > > then drive the refcount to zero, then move it.
> > > Yes, but here is the catch: what if a single shared subpage of a large folio
> > > is (validly) longterm pinned and you want to convert another shared subpage
> > > to private?
> > > 
> > > Sure, we can unmap the whole large folio (including all shared parts) before
> > > the conversion, just like we would do for migration. But we cannot detect
> > > that nobody pinned that subpage that we want to convert to private.
> > > 
> > > Core-mm is not, and will not, track pins per subpage.
> > > 
> > > So I only see two options:
> > > 
> > > a) Disallow long-term pinning. That means, we can, with a bit of wait,
> > >     always convert subpages shared->private after unmapping them and
> > >     waiting for the short-term pin to go away. Not too bad, and we
> > >     already have other mechanisms disallow long-term pinnings (especially
> > >     writable fs ones!).
> > 
> > I don't think disallowing _just_ long-term GUP will suffice, if we go the "disallow
> > GUP" route than I think it needs to disallow GUP, period.  Like the whole "GUP
> > writes to file-back memory" issue[*], which I think you're alluding to, short-term
> > GUP is also problematic.  But unlike file-backed memory, for TDX and SNP (and I
> > think pKVM), a single rogue access has a high probability of being fatal to the
> > entire system.
> 
> Disallowing short-term should work, in theory, because the

By "short-term", I assume you mean "long-term"?  Or am I more lost than I realize?

> writes-to-fileback has different issues (the PIN is not the problem but the
> dirtying).
>
> It's more related us not allowing long-term pins for FSDAX pages, because
> the lifetime of these pages is determined by the FS.
> 
> What we would do is
> 
> 1) Unmap the large folio completely and make any refaults block.
> -> No new pins can pop up
> 
> 2) If the folio is pinned, busy-wait until all the short-term pins are
>    gone.

This is the step that concerns me.   "Relatively short time" is, well, relative.
Hmm, though I suppose if userspace managed to map a shared page into something
that pins the page, and can't force an unpin, e.g. by stopping I/O?, then either
there's a host userspace bug or a guest bug, and so effectively hanging the vCPU
that is waiting for the conversion to complete is ok.

> 3) Safely convert the relevant subpage from shared -> private
> 
> Not saying it's the best approach, but it should be doable.

