Return-Path: <linux-kselftest+bounces-28706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED663A5BE0C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 11:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2E51665AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 10:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE421D595;
	Tue, 11 Mar 2025 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GTcgDXAw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E875E231A30
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689512; cv=none; b=cOuwfrfInPCclMa8vHF+uquXt3SbCdZyrGGwwO+MmOGxSDPh0NDbatkDWwCLtrARS5kgtA1LIqpPKZGTDz/qG2GFtjuZPxq2siWYuR0KHmsUm/lI7JjAw1hs9aYEyIk625nifwlN5jV/aJ8na/1mLJbzHQ93aHtj+de9Reyj7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689512; c=relaxed/simple;
	bh=bZNmeeJGdW6e1FhGKC9CeGntVL96H/2KvoayCD+biY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjfvXIWptPLQoAk5+AXgaKg8scKwugkenVAj2GtqgmUNexyDwhB/hrLR27bLSMqIFLooBxJR9reMSnDcssoi+qzAt2pNJ7SZzzYsBVJh/IWB2E/IOKfErZcjVK4nplmbCzx3xZyVtpfiOY0uPZtLZ81AYj7VyJ0LoGIfKVCwwMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GTcgDXAw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22334203781so111392145ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 03:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741689510; x=1742294310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1K76VH9GZtVs+LPd+wKDkO5SY/QeivVsM/htD74ZLE=;
        b=GTcgDXAwx/ARM9nEBghY5AJuHUStiwulWJF5XVFmWuYk0E/rHQW9hLgWUhWpBNE1Sg
         ewOZNfbb5BVRO2Nt8Tj9jnX2IlyrtX9ro9D2MgEnJ5VZM5Utt2nFmGU6I/s8O5HZWKMn
         D9p0k+uX2XkcC7bKXATp+jfmY9Akhzf694Pha5mPlB1BrlGtLdJ6t8AdZfhoRlLaKe7z
         0Z+uZKYFAa9oGNzkK5tFx/UWQyKlbyzJPg81RANgi/ICE5ZxnJjdN9zEzX48W2PN3syj
         74LxROofU8FrrXWdJiA8k0IpZsJrVVV7+FeLxyQxKXpc1obzstwQ3KbF1A3oVhPcoMGD
         306g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741689510; x=1742294310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1K76VH9GZtVs+LPd+wKDkO5SY/QeivVsM/htD74ZLE=;
        b=BSXaN05GDY7Qxft6fqK/D1mz1SxoHTTTVMrFhAQIAswB63eYaOpXLyjbh54fdNW8Ls
         X1+AZVUcCwI1GKZuoGYXML1NI6HZXUGuQKDyPvBkRICIDMKJA8g7CJftkGq9WRbPCrx9
         lkSGNltp/kitz1FiUpzHSwHoApPW/IZ5jIjkC+I6TkPwymIC5KUIAMNSL0fdx8CDzc4a
         vbhVVxQuYuxallLfmTyq4dFLaHdzNa21QUhJ3XRn5HJQ/Tc6gN+oT8S62i2o0bpBteYe
         vigXU2P6H5ZkYsE5ZxNNwjcCYNsxikqxnSa+ExoBvUslNjpruUm8Zc4LhtuIY1oFEioa
         +SZg==
X-Forwarded-Encrypted: i=1; AJvYcCVETc8R0hfn2fHtA/ZL+ai9q5dnHdgKbVUB4OZOhFyNkV8VbeTSLnRS8Hc/xAlIx3SD01A2SPTtymi0v7/6NEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNkTtSKRENA7HgmMiLW/bdS9yeR4kYwaNHdj/LdIpkP1+15bQM
	LNB7bx6NYGk/GDCuC6z0Zx+VPCdF4a4KmwnEhSBiAG94aAJGy441f2LbN0ZA+J0=
X-Gm-Gg: ASbGnctLVolZ+eqf46QPH2EuRYqCedt62G1+aoYRiLpYyWXwgAgKg6F6HXXXGQfJG8l
	PBxHZAuTkzINIKFO0ah4W2GWDA7QKWjEr7kg14IZmUpYL3IyoiK1aiTP2O/ErQQu1LCyzAg9u2x
	gty2rZafPNz4QWnOI+czSMwp1NWMIj2tu1cIRvPXFE0ABLmTuRvgw1+uRlqn9/2cmO+wbpy36X0
	zWfSjSdGGoh9gE5u1wNxzgvHqG12IaDbxl6QODLtn6CIKEQqUo4L3TuMuGW1m5xcYRgKSl5kXMW
	mqxNHLGFH5tIHDiRxUnjYt6m6txloZrt4Zt/8gmt4Kis9dCxo3aLzQ==
X-Google-Smtp-Source: AGHT+IGwF00pn0ttTAwXGotu4n032tAfHEPg1cyOkGTgN8LMC/JgxCYBqIV6RS/HysJzHJ7Xm/MRrw==
X-Received: by 2002:a05:6a21:329f:b0:1f5:8cf7:de4b with SMTP id adf61e73a8af0-1f58d6ff812mr3970836637.16.1741689510077;
        Tue, 11 Mar 2025 03:38:30 -0700 (PDT)
Received: from cyan-mbp ([136.226.240.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af287c2d533sm8673120a12.23.2025.03.11.03.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:38:29 -0700 (PDT)
Date: Tue, 11 Mar 2025 18:38:25 +0800
From: Cyan Yang <cyan.yang@sifive.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm/cow: Fix the incorrect error handling
Message-ID: <Z9ASoTIastiD7utL@cyan-mbp>
References: <20250311023730.56658-1-cyan.yang@sifive.com>
 <4a068856-328f-48ae-9b1c-0ec7d65dde6b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a068856-328f-48ae-9b1c-0ec7d65dde6b@redhat.com>

On Tue, Mar 11, 2025 at 10:19:32AM +0100, David Hildenbrand wrote:
> On 11.03.25 03:37, Cyan Yang wrote:
> > There are two error handlings did not check the correct return value.
> > This patch will fix them.
> > 
> > Fixes: f4b5fd6946e244cdedc3bbb9a1f24c8133b2077a ("selftests/vm: anon_cow: THP tests")
> > Signed-off-by: Cyan Yang <cyan.yang@sifive.com>
> > ---
> >   tools/testing/selftests/mm/cow.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> > index 9446673645eb..16fcadc090a4 100644
> > --- a/tools/testing/selftests/mm/cow.c
> > +++ b/tools/testing/selftests/mm/cow.c
> > @@ -876,13 +876,13 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
> >   		mremap_size = thpsize / 2;
> >   		mremap_mem = mmap(NULL, mremap_size, PROT_NONE,
> >   				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > -		if (mem == MAP_FAILED) {
> > +		if (mremap_mem == MAP_FAILED) {
> >   			ksft_test_result_fail("mmap() failed\n");
> >   			goto munmap;
> >   		}
> 
> Yes, that check is wrong.
> 
> >   		tmp = mremap(mem + mremap_size, mremap_size, mremap_size,
> >   			     MREMAP_MAYMOVE | MREMAP_FIXED, mremap_mem);
> > -		if (tmp != mremap_mem) {
> > +		if (tmp == MAP_FAILED) {
> >   			ksft_test_result_fail("mremap() failed\n");
> >   			goto munmap;
> >   		}
> 
> As Dev says, this one is just fine. Leave it as it is.
> 

Thank you for the review.

I agree with you and Dev this is just fine. The reason I prefer to modify it is
- usually caller checks the return value directly and "tmp == mremap_mem"
should be determined by "mremap".

If you still prefer to leave it as it is, I will send out the v2 to remove it.

> -- 
> Cheers,
> 
> David / dhildenb
> 

