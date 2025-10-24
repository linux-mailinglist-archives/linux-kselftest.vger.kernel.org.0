Return-Path: <linux-kselftest+bounces-43981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A60D8C06ABB
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5724E3AF810
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668EE1F4621;
	Fri, 24 Oct 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Gy90muF8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979A1F17E8
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315618; cv=none; b=VUHGmlNQWOvsLPqXzGxGrWNlt+92Djxh+JXmdtkSnwrcuu+NNG85o8X9r0XwCWPRRuypzdQ815JmDhquiVZ3BFuNBVxn551MJWVHKSZDdX1H8Xraq1qAuIb4khC6YNlxjRtJXW7Lq8768nhRaHth0CNtVFcXXHDgjstAv3UG2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315618; c=relaxed/simple;
	bh=iD9EcYwDrVZY7o7ShtNVS9E3sbreHS0SF+srlhNtBs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4KB3COr4i9uAhely5FDek9YwYeXmiEnH4nfgyDAKT8P7G7nOi2bsPpepH8/PL8dzSIc4DnDPSPD6Fi+rU3u/Zv3SMsATmwwtbsEXgHE1bkO15w18oyCii5XvazB7iDQD3wDnStiOtTjHYfGmXwDQy6BSLO6+C+AdNmW141BuJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Gy90muF8; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87c20106cbeso29450496d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761315616; x=1761920416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMM6jx2qjRnMcPOV+lvbPLel1TW60YL6/vWevUW1Pqg=;
        b=Gy90muF8DaifrQGdeSPbtW+2dxuKHzyBFhOrUhxm1oshtGGV0uzQxDBh3dlrUt3gpw
         332U/YGT+myN1+ld10n7Qkp4wmLHcAlVLzfGrlDV0W6SZ11xl0uGNP6GYrR3Hqndq9g7
         e1ZBTARMoW6x08d04Dtd2DMDGvTsbv6lCnG6tFArEwQnWAwfWdN4HI2XKf4L0LQNc2PW
         vosboStfirT5M0kZPfTfVYgCPKsVDbbrtyJvkUbkwM5nwYrjKZ++IwJc9scfq1U4m2m3
         0vRgSRLLtozKiM5WS7cOEEJH4B7korXWmFkP9csgxHdbf2hesHIIayX71s/VpsFVHhTW
         Mdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761315616; x=1761920416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMM6jx2qjRnMcPOV+lvbPLel1TW60YL6/vWevUW1Pqg=;
        b=i3ceoGv7Ruq7qoyXXfq6w9MM/46l5gEW/n3brQSHpmV5HnLgjWTuaDYvU1/Q68M9XU
         95yGnnOXdjlf3qfPim7PgaHFiSj7eCVAkwOUmB/X+wP0TiGUWqCmAUzXYi0APm7KA+8Q
         aaPmWQv73YCYCveyUuyioyLbqobNud0E/1jRt1BueoemeG48tyybpr57BIY/K33OumZu
         9VadcutlEfIVaCt7Fay4A75+/AmAvElLO1KWXuCOy0CrQV9D+NrDNtYkAmRIimLlPw2K
         /UbsVZqbP8ZC0tK7ZX8kN3SIjiv3FcELILEqDYXz2R7CKmAi8VAojCk0TSeDIZbLnZsN
         zSzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL/J/yrKYInSp51nuM6BW+mu1v5pb6RGhi/IMdBOlOsYFu2tlCKEdzkjg48IbVkguNHcznKDZW+0XCQ/Hw/WY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+uzQ8NybAMMLQGdI01U2PFwe4wpi8GP0dDGSNua9xsR1+ccv
	SfTlWYPGhkZRusXpR2RW9oHgJ8iW6Gz+JtzqHa1ju/hKfAZ5NrgZnemBkONRQITydwg=
X-Gm-Gg: ASbGncuDwLs164QGQWOkXC0FmZtMaObLHpzQPf9asVK8vlubb8RhKWlxdEU0D2TEQdm
	jlrOuX8+cfxQouJwMHMwi2Ajy3NZdOBabnb8Jw2K8Zwgl/1SC3BwXYjJHsJT3qwcmnpAt/PRW7s
	PBiU3J761GfbMtqKPexraW/vXT3BlFHBxd0hOsQORwd2LB0MZRQ7ezT0mSbHvdB0RHBGXwofjtE
	X3FNNk2nyuVaQFrDMA24gFG9rX5W2Ejwb5oQ+5aLz8lVtI7AGZcwglr0Lr1TT0H/v9tAibSbEQF
	MHB/xnUIaUJMrlsqeS5Ip4XltiKCvcmmgY/i1rtWNiOjcBY0nUDCKyo92aT9sjf6b5pD+cMwDj7
	q/J/wvPPuH12BR2adCKN6v2E4BsHPaCTaqMqk/FNrPaaxpHgqFKN1+qcqu4kdBAZqIqlsyQL3Eh
	G5kYabdP19GCgVthVIsja406l7TP9jAVW+oCxjES3Px3SV1iWqa6ruq1U8
X-Google-Smtp-Source: AGHT+IFeDksjp1ulZ1Jx2CLnCwxxUl6vBkLTwJZHNmUsnFK2qP03K8WdGRN+VgPtJR0tDr8FPMO6aw==
X-Received: by 2002:a05:6214:2021:b0:87b:ca1c:1aa1 with SMTP id 6a1803df08f44-87fb6458d24mr22936406d6.46.1761315615589;
        Fri, 24 Oct 2025 07:20:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9e8237cdsm36788926d6.56.2025.10.24.07.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:20:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vCIeM-00000003j94-10Nr;
	Fri, 24 Oct 2025 11:20:14 -0300
Date: Fri, 24 Oct 2025 11:20:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org,
	brauner@kernel.org, corbet@lwn.net, graf@amazon.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org,
	rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org,
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com,
	glider@google.com, elver@google.com
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
Message-ID: <20251024142014.GC760669@ziepe.ca>
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com>
 <mafs0v7kgjoxq.fsf@kernel.org>
 <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com>
 <20251024132509.GB760669@ziepe.ca>
 <CA+CK2bA_Qb9csWvEQb-zpxgMg7vy+gw9eh0z88QBEdiFdtopMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bA_Qb9csWvEQb-zpxgMg7vy+gw9eh0z88QBEdiFdtopMQ@mail.gmail.com>

On Fri, Oct 24, 2025 at 09:57:24AM -0400, Pasha Tatashin wrote:

> You're right the new kernel will eventually zero memory, but KHO
> preserves at page granularity. If we preserve a single slab object,
> the entire page is handed off. When the new kernel maps that page
> (e.g., to userspace) to access the preserved object, it also exposes
> the unpreserved portions of that same page. Those portions contain
> stale data from the old kernel and won't have been zeroed yet,
> creating an easy-to-miss data leak vector. 

Do we zero any of the memory on KHO? Honestly, I wouldn't worry about
the point it zeros, slab guarentees it will be zero when it should be
zero.

> There's also the inefficiency. The unpreserved parts of that page are
> unusable by the new kernel until the preserved object is freed.

Thats not how I see slab preservation working. When the slab page
is unpreserved all the free space in that page should be immediately
available to the sucessor kernel.

> As I see it, the only robust solution is to use a special GFP flag.
> This would force these allocations to come from a dedicated pool of
> pages that are fully preserved, with no partial/mixed-use pages and
> also retrieved as slabs.

It is certainly more efficient to preserve fewer slab pages in total
and pooling would help get there.

> That said, I'm not sure preserving individual slab objects is a high
> priority right now. It might be simpler to avoid it altogether.

I think we will need something, a lot of the structs I'm seeing in
other patches are small and allocating a whole page is pretty wasteful
too.

Jason

