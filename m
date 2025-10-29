Return-Path: <linux-kselftest+bounces-44319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD3C1BF51
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81F7134BAE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4138035028C;
	Wed, 29 Oct 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gdTLfasu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B58D33A03A
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754165; cv=none; b=EU4wIcnKcZC+Fq2hWIAc7KUgULt6nSbEDCL1dz4cp5c9+j/vHWjadPqSN0H/TTjesQqnL+SffRe85JofEFQCmgYAH6JTyDLruyCJ68RxB2x/m0NbGOnoQXraIVTtD2ygiRSwpmTliTigMmiHOdzteXjoIXVveBcqPbnYYu+3MFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754165; c=relaxed/simple;
	bh=St+jGXqkVW2dPa/nwH3cBBQelX2l0ubCqkxUgbOntyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBskDnkcTyKmRHrZvDwKqNKatziBN4MlS3Znuijj99EHrx+1Lcfn+XWSXuxZrGlfWGmfObYLrHQ3GMgh8pQ7UtYK6ug4o17KOC0VPu+FCDvoRNesLGHNY9snY2/eBs+BwgvcjQPVX+H/7Nrp9We1P3URQewFvhVoSpPFdJOVoHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gdTLfasu; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8909f01bd00so800217885a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761754162; x=1762358962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ra6gE4GNLdWG7Tqyy4+9etzH3tIuFsSBjp83q0VcDV0=;
        b=gdTLfasuYTiLnQvOQsv0vLctEX8Nbe3+eTtPgWSquc2XNngV9vH7MqMz3czekR6MCB
         AuSiuzu3+zGIDzEW7orl3tlAPUcW62RcYMlCpp0bawSClLCB68BXjq0FR4J8N7nRvTYw
         WIWYqJQUVF1gi78ApZRTTsmYTdu1GN4Lupe1qkcpHqgi4v28N+eQHb4QT2D0hA5eQWB8
         3RFIRdg20YuqWs7z91/eHDN7zUXLz9nh3JzB5pa2pL2zanuFitM0zbXPnEgFcp/1dsON
         wR1p8I8pTNFYew1bSRGjg1U6ASMgwisCyZxHLAMSkDR+0H5WiAtg6bq2QwooCutgOjGU
         SBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761754162; x=1762358962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra6gE4GNLdWG7Tqyy4+9etzH3tIuFsSBjp83q0VcDV0=;
        b=bJdvEFpSBNULLyVEP9kT26JJ7DmYEFrhLKqwedQcaV/WfDgohXsySX6ZckUvcIUpe4
         ZC6sRRr0locifaSGOW0E8ZnCYTjDXG4i9dmMw2Srxy+VLYlbM+Kn4evgMCcu9Pfaa8GZ
         KlzCbqlXAZSfukR9WnhtRhpcnzjZa1I+CBQ8U7+5/LBu3YY6OvwP9HmVWiBMyJEf3iyl
         J6CE+yBaOpCZChFtS+gPb7XfxX3+oUu8GoddKStA9bn0pWccuw41OEUr6utWrhchsnQU
         K/uqrjxsje1tgSJB5lppVplICAt9V0CZeUkBJsI9oYv9rA6nHY3e89lcnRhR7eP1ll41
         MckA==
X-Forwarded-Encrypted: i=1; AJvYcCXzIgbHykaLf1fq++z6opnQzp0qGwEI5M8hwxg7R4IvyH3SJ4hGIjtXEj1HtJwWiC9tI4ejLDxT/itAhiXWlvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxchHGHCWcoZTcQheVWUsGoKJnEefNdv9NgE+eAfiuNFfKYhIq
	Dq5JQyz9V8YYQqdaFhbSt4CvGMZ3HbGtosLxgZikFk0YAaWOZOOxKqgrbxdBzoBcOC8=
X-Gm-Gg: ASbGncuRNA5IwsuM479TPMImibn9wxUta32PUdV9FwVJrh5g8DHVDniC2afysGdqoNA
	K6KLf/t6Sa/ywzjFLeWsz77lw0AVyNtsa/Jrhla2hN3xcoapSNNfpePyguasVehKqSgAaMY3Jer
	C23c+sOHZA2o4p+jJmFJUo4dQPqZGI9jm+VtX9ctGsWwxQwCaKFNMnt/Ngbz1dqCt17QcJDbqH2
	dW/R+OvlLsACDxJQbe05lb9h+M0XfhqvUKrvlRMzZaLae3u1yPl7DdqlnF7CCqQOEGPeKkpDQix
	6+wxEStMF7mfjxDGSlmCncO8HocNxDnIa3Dba2Epg9xucPmgqkz3z6humZnnPaKsTFKoBDvHBpa
	edkC8VjInTNWjdghtYeoMPIn40LgIQMowJHjCcI7WVOUSVdu8/VPffruYx8UUBKEojvelI0jqYQ
	HEBSksWzUQOcPkGh5iIMOMFWSwqwrSi9Jlk9v0skynrKhSlQ==
X-Google-Smtp-Source: AGHT+IF6rFnidmIfY6Ro1wANLijusetvx4ngsO9eh8sfxCbTUwpnkArLo2xTU45YJpn8RBXsZSHBbA==
X-Received: by 2002:a05:620a:19a5:b0:866:73f7:25a2 with SMTP id af79cd13be357-8a8ef52d830mr451427585a.64.1761754162225;
        Wed, 29 Oct 2025 09:09:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f254a41cdsm1078205885a.29.2025.10.29.09.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:09:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vE8jh-00000004ztF-0Awe;
	Wed, 29 Oct 2025 13:09:21 -0300
Date: Wed, 29 Oct 2025 13:09:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: David Matlack <dmatlack@google.com>, akpm@linux-foundation.org,
	brauner@kernel.org, corbet@lwn.net, graf@amazon.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org,
	pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org,
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Subject: Re: [PATCH v3 1/3] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
Message-ID: <20251029160921.GP760669@ziepe.ca>
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
 <20251021000852.2924827-2-pasha.tatashin@soleen.com>
 <CALzav=egQiF6tanYxR9Tow7TnT_UK9bNAR_4DQ2P=2EJ+H4ZJA@mail.gmail.com>
 <CA+CK2bAibAPzTq+edRTXS9g7Cs0w-zCiSSrXUkoFAHe7=3C0QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAibAPzTq+edRTXS9g7Cs0w-zCiSSrXUkoFAHe7=3C0QA@mail.gmail.com>

On Mon, Oct 27, 2025 at 08:01:59PM -0400, Pasha Tatashin wrote:
> > >  static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
> > >  {
> > > -       void *elm, *res;
> > > +       void *res = xa_load(xa, index);
> > >
> > > -       elm = xa_load(xa, index);
> > > -       if (elm)
> > > -               return elm;
> > > +       if (res)
> > > +               return res;
> > > +
> > > +       void *elm __free(kfree) = kzalloc(sz, GFP_KERNEL);
> >
> > nit: This breaks the local style of always declaring variables at the
> > beginning of blocks.
> 
> I think this suggestion came from Mike, to me it looks alright, as it
> is only part of the clean-up path.

It is the recommended style for using cleanup.h stuff, declare and
assign in one statement.

Jason

