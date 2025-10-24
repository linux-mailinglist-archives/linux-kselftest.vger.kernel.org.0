Return-Path: <linux-kselftest+bounces-43977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C686BC067C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 15:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1893B1547
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 13:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE6531A7F7;
	Fri, 24 Oct 2025 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M1knhzh9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230EC2D3A75
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312314; cv=none; b=KqhU8wAO6xApfQInLH3uFw/kHIdo6S+8U9PNNxe3XI/ZufGkLSPfBUg8dcRGwZUDTZYEqoqvaCD7UJPLI+7qvhET4n4J9D7FtWJAuir9QJMaZ6hEZtKtWXwjvr7K+zR6C4Z06HQskr1sCb4FYc6EfOesIPHpwORGpnJTt/+6J+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312314; c=relaxed/simple;
	bh=hg+k+hXZjREUNqlY5D9HdwDqBHKx8EBqmD5V/A3aSd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKWzIwzTn7tOfV+yTHg3YY0AHdKABZmxK9PWzRW9K0DDNW0rvPvhhO11A3ZCZ/WmWuYvVOlcq0ilNYI43BrGtIp7bVW3DnoPV2XywVz8ViQ4ajGFeQkCxSBsGBba7vzSWYSo0Sv2b5ikuM2b6RVn1XNNwveG8pYsxwXy7+ht0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M1knhzh9; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-89e7a7e0256so29121585a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761312312; x=1761917112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Aj0SeoWC7WJCm+N08s/eNnhLHbhk/Wyc57uRWO4wNWo=;
        b=M1knhzh9V36Pd5IWg0mX27gwis9ueJgHp689DSb4ZkTfA1bZCE4v/VCHm512AFuIF9
         Q75f34Zw45kry7YL7HQ5fvY1GcsyNfY4icq+1S6MZnLy+ok/jkP9Tn/+1+NBjmlqlTY4
         XkoTYRID42HdiPkwi2W0d+bvAB5C/VzMplDzSyhccVgT20HFIyeZWZWhYyd75/HHtLiR
         hdaN9W/TC1Mn2p0vFRlUZlBL8nSWxudQ6jB4wzEpC9/t+yOe/U+mlNPlOU7nQ9lU3mQZ
         Wf+zPh8K6WYtwBzbkY2koVUhHGz3fOsNfDKDu8qKN6Aiy6eLehCRzEB6Gi7Ai17Fg1zO
         1bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312312; x=1761917112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aj0SeoWC7WJCm+N08s/eNnhLHbhk/Wyc57uRWO4wNWo=;
        b=kCEq45StXKGCQ5xiQTQ38bJJeOR4uUv9yx9tZD2ZKqLr3Dx9NTyI6gMDvIKXiY/a5F
         kDauZG+vCq0laNAR9yfODppV9RQXqH0jn+Rm8jAvv3/P8ILCf5/v9VFnXoT+IHKZElrq
         up0ZVQkeo7GAw/VvoOSyClmMahoNF48OYpwZsx9tqlqxCVj8Qq8bzA5NqS099Ebz/Eo2
         aMUrtIpbL0QbhgN6zKj58ZeV+fiLsRQ6E093QiZAvkSQv5Ymvx7ZqASn2Nft979hLM4U
         2tvU3WyE7qwvNQQkCoVfKxVqmSw0HcUvNGIAyMiRD09a/MwqAlhG/NZlekBaEEeGSFMV
         h3+w==
X-Forwarded-Encrypted: i=1; AJvYcCWfAbkaInbCV1msno4HG4f7UyC6F1ef+Gto69mXo4S50cVcuoXTc8nqqYUHHTd2j+gc8sMnzvayy4txOQkpCdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQSE9Lpr2ZDgY/MTQX9f0yqF1aupeCg/3v3Sx2toLk1IWHDzK
	SM0YebJOH6zQ6zPqWt7L7RjRK22H4+ctP6lxefQGKC+X4fhRMHgopJc0cq1z5YBvmCY=
X-Gm-Gg: ASbGncu/jtHLjlWQUViOCeYC/jc+ie1yhJwUEjg8pnd164vLRJ6Caak9XsGgaV+fP5X
	c0YSSm9vknCHNZwIFCHheloYQvsvgPZRMlNKwlcCqBaOMFWReWlL3rYa+mqm2n/1gZYFjkSERSU
	S/Go7EkGxsXnHC5eMeaz50yn+xVmRgfbGawsvZoew2oR2pVscwM7fPfn2l+p6oNIPsoVMxExmyw
	1DO1Jea/e4xtz1lGQfRjFoSOEHtdgy8TPwXechASOMRcqh6XEFaK0xDDqo+PswFIjiGtF05KwIL
	A68hRkUM4hWjFYmMluwiSwlAfHBvXP7ico/yChSJyrFE1Gubbf/S5nqZu4rQqzPDdfxRZNMGRCZ
	s8YaJ+gwOw0Yp4Bqgo7l5xqs91cwPIK6BKGV946pLDQMTe/TgjUmo0C8uje54ETbT14uLH4n275
	gJVU2Ev1Wj7ZXqEMsFrTlSNomERhTvK7ZCrqhANV1Imq7gDCa7MkNKEqsL
X-Google-Smtp-Source: AGHT+IEGAyhhTF+yO14yTGLloo3cDyt5954pwwnLoAEIBQQ3wHdpsngyLyG6oHWxHD+JOdW4oxag0w==
X-Received: by 2002:a05:620a:178c:b0:892:eb85:53cd with SMTP id af79cd13be357-892eb855743mr2323365185a.42.1761312310446;
        Fri, 24 Oct 2025 06:25:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c12352ec2sm381880185a.52.2025.10.24.06.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 06:25:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vCHn3-00000003hrr-0bw7;
	Fri, 24 Oct 2025 10:25:09 -0300
Date: Fri, 24 Oct 2025 10:25:09 -0300
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
Message-ID: <20251024132509.GB760669@ziepe.ca>
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com>
 <mafs0v7kgjoxq.fsf@kernel.org>
 <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCG011xf7v9nGMq4WQAUta9wDt05+W8KmRuc-JE7ZTwqg@mail.gmail.com>

On Wed, Oct 15, 2025 at 10:19:08AM -0400, Pasha Tatashin wrote:
> On Wed, Oct 15, 2025 at 9:05 AM Pratyush Yadav <pratyush@kernel.org> wrote:
> >
> > +Cc Marco, Alexander
> >
> > On Wed, Oct 15 2025, Pasha Tatashin wrote:
> >
> > > KHO allocates metadata for its preserved memory map using the SLUB
> > > allocator via kzalloc(). This metadata is temporary and is used by the
> > > next kernel during early boot to find preserved memory.
> > >
> > > A problem arises when KFENCE is enabled. kzalloc() calls can be
> > > randomly intercepted by kfence_alloc(), which services the allocation
> > > from a dedicated KFENCE memory pool. This pool is allocated early in
> > > boot via memblock.
> >
> > At some point, we'd probably want to add support for preserving slab
> > objects using KHO. That wouldn't work if the objects can land in scratch
> > memory. Right now, the kfence pools are allocated right before KHO goes
> > out of scratch-only and memblock frees pages to buddy.
> 
> If we do that, most likely we will add a GFP flag that goes with it,
> so the slab can use a special pool of pages that are preservable.
> Otherwise, we are going to be leaking memory from the old kernel in
> the unpreserved parts of the pages. 

That isn't an issue. If we make slab preservable then we'd have to
preserve the page and then somehow record what order is stored in that
page and a bit map of which parts are allocated to restore the slab
state on recovery.

So long as the non-preserved memory comes back as freed on the
sucessor kernel it doesn't matter what was in it in the preceeding
kernel. The new kernel will eventually zero it. So it isn't a 'leak'.

Jason

