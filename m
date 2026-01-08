Return-Path: <linux-kselftest+bounces-48519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A97F6D039AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 15:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFF3C32CEC2F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119C34D89C5;
	Thu,  8 Jan 2026 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dw0oXzQU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E64D165F
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881451; cv=none; b=m9MpalgmRNNPA6W2PsMH0F5PrErAHYnKL9b3NIjJUJL/WNBm/U/CAH/Fyxj7Dd9N94DWslZU2F2hZYMtpnGYx7bowG84HVywEtyWl+FREoO8XV5XjmGJaKBKWqV1jnN0Spx0/6YY+8uyPVBUgZNF1pBjWSvOcuVQVo2COhx2jHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881451; c=relaxed/simple;
	bh=mOyKu2qnINj2x88v5g/B8RjO1LOcLsg2eN246pYG+9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBcBkPxBcAZ2XsDa6GMrU/SaQ9Dx06d5RUQo54NN2qBUbJhyHzD8g+vw5H58u/U7G2KvNuJq2DLHfMgnwMSE4a3QuP8mhJcJdUDkDC99n1uoLzTZ6MCMl85xKMMe28FFBv2srfKRgk16hFj4pmyhGgEIFXSk6oyJSSDXW7gk8Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Dw0oXzQU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c07bc2ad13so221519985a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 06:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767881448; x=1768486248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oDbkV3lGC5q9hIUjdqkuvar4sKouEItjHMXNdXEEOOY=;
        b=Dw0oXzQUUelmqmGXwTPn16P1HIMNpjgh5MUGjza5ljvke9CJbGeApM1iz54fcR1eJK
         Aj/osLXYekG8ctsTHFg6lq9RSd1zaDP5vVcWcPZ2SKjpAE9UIavEBwN+IyP3Y9leiOqm
         a5yW//KYkhnMn04G97HVYf3ztnxeGofHGJv7C+HuXYZtkl/rJBoPWvyWEoxE2ZcD4cKO
         LAg776359gEcA6avWMXwKBBBRrd+UNOMU+OYq9OMhi2uroi872dOZxmGoZz8jYDga6rX
         uM4+IEn5fO8ZrZ7pQN18++BY4Fg1KuIr9rM4BZ//VkeqYtDZ3Lhg13kAuCF+4FvkY6At
         fbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881448; x=1768486248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDbkV3lGC5q9hIUjdqkuvar4sKouEItjHMXNdXEEOOY=;
        b=J0GU6Dem6Uhlc4HIkkrC0kch+fPYeS7cbujD8AVz7WbxySG5cJCF+/Snowpja4ALEQ
         OCwWD2Nuw3pwIlsmbSHObesG8+SGKmdPxdCflBdxFs0Oo7uRNVP+6M7eNnUxKou2N2Uw
         YS6YKU5KpJieGYIPxBZLb/DFjmQbJR7DVc0H+CKufuKBK0Nomb7M8KPCofoyeViraPwk
         YEvbsomJMNZa47ePhgMNxTdW+Mwo2+qQp1idhWs+FRFaYBchVA5ZiDvIBelg6aRkTc56
         WS0s2jpzcnhmkfJ70rrP3WWgIMeyPnmu8B9xEqsljTQI3eMrZM/fHBI9KQeC0kqeKeef
         tGTw==
X-Forwarded-Encrypted: i=1; AJvYcCXt5kHvny4DnoCHjiGEYPxhbUAi3ibVCGK0921cnKxfnGmEt/7HRaSg7m4akR3uUHh9xkZuOikGPsp9a3NGMas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc1lKilrNYrH30sAc26yuJiklx5Hu5kLmeaGSo0XkR1PjbFFMz
	zdEOijeee4EgA2hzNu/nAzgqvNWzmif4WCUtX58EhUPJfEWVT8TqEmvvO4XL2djQ6WQv+tJ4hW5
	pn68A
X-Gm-Gg: AY/fxX5gdoEjjWMN/EuldAjD7PpO/2qzgYriPRWcj5T6kEFACr8oi9TQlkc5f9MjtZl
	YHuS81K/lQwtzV1zQbPCiYoNbyY3rln/0bvobP+2OayAWEQ2cnOnhfWB0fqotOOsOqLCLVAOYw9
	oIV6UTiiwuqZJ5cs2h7DaIH/PumXeAhjHOKplsq2L34D6nXgOM8SQrjrqT/HzgnVyKQq43iayMg
	o+imDLOfGQ6TIBP8gm0qc0O/0DtOboupFZ+lJwJM4kjgvH2c+l1cFHL6NYN1xwya9WSOYvH4Vfq
	BxwWmMkIj3hcay8tJBV0uPDVJ8AJ5DLqLPZuIadMnBw6jo2w6twva3oYn/IJwrWTMSNKE21TOJR
	B//aIq1Ts6zhyQUVEq0bemWsmasQTHUoWWh3wfvSmi3l7AHK/tWLitj+QkMYJJQi72fgLePqj9P
	WAlrGLdkyk8x4SXe8pscaQmtjyBTlaqUBKQOi81VClqvb5WCwHV8PROkbXSY7fOyKMN1E=
X-Google-Smtp-Source: AGHT+IHLFsWgRSX6V5S9B7UJ9/MDZC7xvbmTJCziAAyGWoSQBDoda9rrddhfylBRHlUYqEmcr6mSKA==
X-Received: by 2002:a05:622a:1aa8:b0:4ec:fdaa:b31e with SMTP id d75a77b69052e-4ffb4933f5bmr83200721cf.32.1767881447747;
        Thu, 08 Jan 2026 06:10:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffb813ffb8sm26637331cf.20.2026.01.08.06.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:10:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vdqiq-00000002Lxb-3Inr;
	Thu, 08 Jan 2026 10:10:44 -0400
Date: Thu, 8 Jan 2026 10:10:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <20260108141044.GC545276@ziepe.ca>
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
 <aV7yIchrL3mzNyFO@google.com>
 <20260108005406.GA545276@ziepe.ca>
 <aV8ZRoDjKzjZaw5r@devgpu015.cco6.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV8ZRoDjKzjZaw5r@devgpu015.cco6.facebook.com>

On Wed, Jan 07, 2026 at 06:41:10PM -0800, Alex Mastro wrote:
> On Wed, Jan 07, 2026 at 08:54:06PM -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 07, 2026 at 11:54:09PM +0000, David Matlack wrote:
> > > On 2026-01-07 02:13 PM, Alex Mastro wrote:
> > > > Test MMIO-backed DMA mappings by iommu_map()-ing mmap'ed BAR regions.
> > > 
> > > Thanks for adding this!
> > > 
> > > > Also update vfio_pci_bar_map() to align BAR mmaps for efficient huge
> > > > page mappings.
> > > > 
> > > > Only vfio_type1 variants are tested; iommufd variants can be added
> > > > once kernel support lands.
> > > 
> > > Are there plans to support mapping BARs via virtual address in iommufd?
> > > I thought the plan was only to support via dma-bufs. Maybe Jason can
> > > confirm.
> > 
> > Only dmabuf.
> 
> Ack. I got confused. I had thought iommufd's vfio container compatibility mode
> was going to support this, but realized that doesn't make sense given past
> discussions about the pitfalls of achieving these mappings the legacy way.

Oh, I was thinking about a compatability only flow only in the type 1
emulation that internally magically converts a VMA to a dmabuf, but I
haven't written anything.. It is a bit tricky and the type 1 emulation
has not been as popular as I expected??

Jason

