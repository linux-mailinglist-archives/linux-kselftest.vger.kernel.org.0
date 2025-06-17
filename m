Return-Path: <linux-kselftest+bounces-35219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 480E8ADD3B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 18:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D9D2C0F71
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 15:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274D12ED14E;
	Tue, 17 Jun 2025 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJApMhc7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886C02ED164
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175583; cv=none; b=OpiXJTixn7+1rX5WBfjSwu2qb476EfXu0J6xzacnd3uB/Hp8MXttI05DbhFe4jySDx5zqQxvS1w92tMZr947kqqUbTUWjBiZCeRUru7jqypOKQsiTnDKbwBgq9y5w33ky+punSWAesxAm3xSj01zYxZfVvWhZu6cErht4xvkLpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175583; c=relaxed/simple;
	bh=CegLsk2HTM1Hl73lhn5TKBE5LOOF2SGiJXvYLKeQAxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqVND/RxUVzAEPMZFS0GikEfMftTlE2Y6M+Z0PJt7C1KhaQvlLAZFmbfn2eMv6fNUSyAmXMSgnWnuLXznomiLgQBjHrPSJfAKW2NstSqyfNYzIfQ8JxqEeZYM4nbR4y5cPaBy7VYWyuTBiyT0aOq4fLhqRPr0LKQvbFw1oOtqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJApMhc7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750175580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4OJt/a44jwhdTN+yTSXPXvzY99d5n2WtYczgJuAvKg=;
	b=iJApMhc7A2josu5hV7jJ+RaTJicLnMlGku2LzKTqyb06HuJRcdhypp5bre4ebHVpgb25Lc
	z06pTfnt6yb0ZswTah5zr7toMzLuafmNPuZuFG58oFD4xnRx3uwARW2m5JRz5p5uaED2ij
	ml/xNdEyq5SS7Hf86m0VVlh4bHpYIKw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-UTb8-odQM8Ox1LtLs58Tlw-1; Tue, 17 Jun 2025 11:52:58 -0400
X-MC-Unique: UTb8-odQM8Ox1LtLs58Tlw-1
X-Mimecast-MFC-AGG-ID: UTb8-odQM8Ox1LtLs58Tlw_1750175578
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b1442e039eeso3615995a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 08:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175578; x=1750780378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4OJt/a44jwhdTN+yTSXPXvzY99d5n2WtYczgJuAvKg=;
        b=NlC4BSwtmoAVx7Xg6NGEUhxSBlKcwrLRQ84EYvpB/t7/uFrW1Eqw48DGLXcnh9lV53
         vugu+5MQo95h/YR1IuDtF+ftQ+J5Etf7zoD+in2kAE6e5DqJre/RRU4g1QWIwawp5HGT
         z8mHCwt3UMjS/jRzwPBMp0F2bL/nTLENz++3SKZU1a/A2bdQIhbGs93eNyoTZQ4PEdrx
         k8jmlKCPZuWIGY+0egpWltdht8dSs/7tnxBUcEvCzDX+quSoF5WjdJXYLDViAhMgVq/d
         32GTH0SG3kx7Bymk0JYVZx0hohKBesRFb9/uh2NV2NTsqZHvvZoCrnjXaMMNFkTHZciz
         JpBA==
X-Forwarded-Encrypted: i=1; AJvYcCWc68bU1UTCZuPzwDFUOfszHsXT3GseSBWhsfuy0xD7ZzcdskXmU9OrccgJ2qPct1cts81SOn5GufPin/ku+Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq0RPFH2jf+NVGfI1Gv6JtNXlo1GGjkQvvO4rjauUQu1F+XZHV
	+MmqKrVBVuE4KmqLaj6e3nlWfinHa75iI3yffBP1W4vZmEdCSJ9lUUHIhqi/MXb7KqXz3GD5gX9
	htepVSemwdsUqIwyRdY7HANMAILIwiErSvL/KTs1ZdG2vaeJUm9EZtugVhbcLuMreFmjzDQ==
X-Gm-Gg: ASbGncsQmYUM6cZkIj48sC2LtlnEz15fPYGbq00Pm7EC1siFxvJVtFYzhjfuIZLwa58
	Lf3LKT1hAnADUSlICbbOKv18dXCpfGpkMOxhjZ7ZEIFcdRQNu2bqtg+7Y0ArysQaMNIr0gWNfKA
	XjEdheox2QgIbrD9Axu0LiU6d/FOxg77NJW4teSPdJIP0F+wuzVm/IkfQgWIpmOu3OKSoHKB7/D
	A0uns4Jl1QWSEr2aL/kCOW5dkKIfeevEoWNlwFlWUvvleJIxY+geGv9UiDDwuTRgZYWqFAQv+Yi
	AIZVKI4AkY5idA==
X-Received: by 2002:a05:6a20:d04c:b0:215:e818:9fda with SMTP id adf61e73a8af0-21fbd67f904mr20435853637.27.1750175577740;
        Tue, 17 Jun 2025 08:52:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj36Oe4A2jcNoqS2BQRql6Igh2aHBYLuNua+frzBld7sGbq1gUwnVFHIYvO1JZJWclqgsPDw==
X-Received: by 2002:a05:6a20:d04c:b0:215:e818:9fda with SMTP id adf61e73a8af0-21fbd67f904mr20435835637.27.1750175577393;
        Tue, 17 Jun 2025 08:52:57 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748a6b1d620sm6123165b3a.116.2025.06.17.08.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:52:56 -0700 (PDT)
Date: Tue, 17 Jun 2025 11:52:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ujwal Kundur <ujwal.kundur@gmail.com>, shuah@kernel.org,
	jackmanb@google.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
Message-ID: <aFGPVPDKGLOIEucg@x1.local>
References: <20250501163827.2598-1-ujwal.kundur@gmail.com>
 <20250616100406.2853-1-ujwal.kundur@gmail.com>
 <20250616172618.0609127a8b1e406d4c228d24@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250616172618.0609127a8b1e406d4c228d24@linux-foundation.org>

On Mon, Jun 16, 2025 at 05:26:18PM -0700, Andrew Morton wrote:
> On Mon, 16 Jun 2025 15:34:06 +0530 Ujwal Kundur <ujwal.kundur@gmail.com> wrote:
> 
> > Refactor macros and non-composite global variable definitions into a
> > struct that is defined at the start of a test and is passed around
> > instead of relying on global vars.
> 
> Well I guess that's nicer.
> 
> >  5 files changed, 616 insertions(+), 542 deletions(-)
> 
> It needs to be!
> 
> Thanks, I'll queue it for testing while Peter thinks about it :)

I didn't pay much attention on this one as I saw Brandan was actively
reviewing it, which was great.

This is definitely an improvement to the test.  Thanks both!

-- 
Peter Xu


