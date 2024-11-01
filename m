Return-Path: <linux-kselftest+bounces-21322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8165E9B99C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 22:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB4F1F22958
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 21:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449B11E2606;
	Fri,  1 Nov 2024 21:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpDhkeL5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7589E1CCEF8
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494901; cv=none; b=FIDf+wsSmN/Ol8gUxHqtZ/dLpW8kzV1m3OVRTZTPH/AgNye8myhfIC+MNRwd112ENIHbYfopbs9a9vDhesJlgUTlyma4a6eqRAU/spD2OfCHbVIF6+2xFcX3BaT2ngtJ5HLdIwcGV0VP/bRbNwCraenLznLX6wsoP6+QeXtabVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494901; c=relaxed/simple;
	bh=7WUOsbtapu1VrdSJ94c4nil6RKKgZVcwbVqFxzdBsY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3Q7tJWujHpptA81cfkCl68ZKs2Ykv85e/OT8W2l8VEgoxP/cslVPOAqHwDm/GL6z60PbXRqF0EmgJEsK77KzB0upzwT+4HxzfePJ5FPkazq/m6IbrvmYFqBW6bGGT1FVJF8qVlSIKHV7KyM2dEpcPQ4pEB/Zjd5uauT/WSwQOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpDhkeL5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso3050316a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Nov 2024 14:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730494898; x=1731099698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULQS1Fh0p2h2tCv5f59FuL6fz9MzVkqUARVb0MPWMFw=;
        b=lpDhkeL50Rf81h4YgWY/ereumJ0m2dJrYvkD1tGKQ9tcP85kcSAGhJdkXUZW53/3mS
         B8MpdHVpkxJWdyXDwDAYAP5yL+l047V9bcDRi2fP2bD8Rcpu15jR7+AeTs7Y5ClaHpCO
         EpVbOIl0l5xq1tlVxs//kadMc/c/Msg/Qn+cDA4sM8E0lvSwaIOvhoxsGF9L9hxgvhPW
         UifOBVc6VNPw3RTfiiF6wfanrENg7Cux79GIGGpgiqB9w/ea417gTwVu9NwwTBBfvuPB
         T3EErQYJuMzHV64OTG7KjQneMNbfobTvx99mTQlLNSdL09bKIWtQROcsQg1E5xTPtbA2
         amQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730494898; x=1731099698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULQS1Fh0p2h2tCv5f59FuL6fz9MzVkqUARVb0MPWMFw=;
        b=DKQQmVyWODTixnYGgXQMy2Oy+T7x7iCPbxBgTzi7m1s+Q4ObJ/EEFYx3qvucfGST2d
         UXf8wzKvywY1PmpzqiR7J1YZyl22DTxFJ1b9rg8LsjdQ7zC0TlYHIb0uNrXRP1H5nOeP
         wtNbut3o8cpvV56iNM81TIUgP9XgVHTBS+RaRIm+asC4kCOhs67/PwhRd7TZo0KPXb41
         T/cIZmgf0GUApQuf8oT3nb/G+u8br9P3L6Lns0YUWgBj4/TAnysbmtSLgjhXCBLWJ8HR
         +RD+Xe4pip8Dr5/FloJFw4MIfnje/18WNOq4F2FsIaW0Ks5DC+4sCXLS0XLFqOwHX2m9
         /GAA==
X-Forwarded-Encrypted: i=1; AJvYcCWzNyHuvKIv5cy44z6gmtHtVEdpOBZIAbW/1XybEgIldTsLKaLMNqKWWxG5YaaV8DFR0gWSnkmIIjixiMP7G+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB2eLoQ0f7Kzjz5w7F3YHXW3dIT9UlNR9q4nzIIl3OtaU0+7Eg
	PfUbxfb3FgPrL7+SDH80XCnssOSziqfg50ZeaI1le/h89XTHG++e
X-Google-Smtp-Source: AGHT+IFEApOF1Lo9/TyFpjCDhKN18ERbosd95+bzaI7jVQFZEZIKNnx9duFu7BhgRLy0vnlUL6vm9g==
X-Received: by 2002:a17:907:8693:b0:a9a:e6:a031 with SMTP id a640c23a62f3a-a9e50ba22d9mr665890566b.59.1730494896037;
        Fri, 01 Nov 2024 14:01:36 -0700 (PDT)
Received: from x13 (185-180-222-125.hosted-by-worldstream.net. [185.180.222.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564e8e6esm229051166b.94.2024.11.01.14.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 14:01:35 -0700 (PDT)
Date: Fri, 1 Nov 2024 17:01:28 -0400
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, brendan.higgins@linux.dev,
	davidgow@google.com, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, ricardo@marliere.net,
	linux-kernel-mentees@lists.linuxfoundation.org,
	andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v3] lib/math: Add int_sqrt test suite
Message-ID: <ZyVBqEgX-z3flsDT@x13>
References: <20241030134355.14294-1-luis.hernandez093@gmail.com>
 <c213dbcb-35de-4afd-9d4b-f42f6a9e3de6@linuxfoundation.org>
 <20241031173941.3487ccbfd7421d81d9b0cb97@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031173941.3487ccbfd7421d81d9b0cb97@linux-foundation.org>

On Thu, Oct 31, 2024 at 05:39:41PM -0700, Andrew Morton wrote:
> > > --- a/lib/math/Makefile
> > > +++ b/lib/math/Makefile
> > > @@ -9,3 +9,4 @@ obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
> > >   obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
> > >   obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
> > >   obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
> > > +obj-y  += tests/
> 
> What's this change about?  It seems somewhat unrelated to adding a
> single test.  I mean, there's an unrelated test listed in
> lib/math/tests/Makefile so what change does this patch have upon that
> one?
> 

Hello Andrew, I apologize about the late response. I made this change in
order to try and stay aligned with this previous patch moving all
lib/math/ kunit tests into lib/math/tests/: https://lore.kernel.org/all/20241005222446.10471-1-luis.hernandez093@gmail.com/

From my understanding, kbuild wouldn't pick up the entry if it
was just specified in lib/math/tests/Makefile without a reference to it in
it's parent lib/math/Makefile. I didn't want to this
patch to end up in a situation where it would introduce an explicit
object entry in lib/math/Makefile pointing to 
obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += tests/int_sqrt_kunit.o
as is the case in mainline at the moment: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/math/Makefile?h=v6.12-rc5#n8
This would in a sense introduce a regression in the organization of
the Makefile in lib/math/.

I apologize for not adding the reasoning behind the change in the
original patch.

Best,

Felipe

