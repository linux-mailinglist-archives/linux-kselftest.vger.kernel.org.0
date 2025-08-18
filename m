Return-Path: <linux-kselftest+bounces-39182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D5CB296E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 04:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C18E3A906D
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 02:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8013E24729A;
	Mon, 18 Aug 2025 02:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCkrtg56"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E2217F27;
	Mon, 18 Aug 2025 02:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483715; cv=none; b=cvVcgxmLdfOIB1NlJW/MFe3Zd5gTApWid7gA+yf+ofmOpmFSayBkK0HZRvmtotGa3KMnVuxNZ576B6PgIKA+BaGUeIzEv8RM6SErxJJvvJUoOdVXBX+Rzaz2gXiAPd/1tPbcHvhIRVEZkKMyfuWc5hIUtjnEqDMWBfBalSqH3HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483715; c=relaxed/simple;
	bh=roM6kry7vyYy2Tbp5J/teH18/exNSrpcd0+kWqSk9Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0JUiFd0UfkjvXvWosX/zSFU8O5cm0hVtYVdkrfacOIraQ/YiefQGzgOwpIxp1s4bux8ctuipV+yBrhJQ67lbvc8HjeTkgIVyxyhK8uJMP+xVsOI5s1xR/jcArLT3HOnmh76TVEtuGUQDh4olpa4Yg3Hr6b48DkidgGjjd+ZjdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCkrtg56; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7acfde3so479188566b.3;
        Sun, 17 Aug 2025 19:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755483712; x=1756088512; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2VQ98bzsRDXPvAwzT0crPvEy6KznXXOPwFqZG4IBm8=;
        b=MCkrtg56awkA4N+m9K1ka6O37YDbJKI4rCb6v7a9++FQijlVK2jgh/+AyF/CzzFGpi
         /d8VoxE0h1XLiDIvBt5/Tsht6OyUaWMhUtC9Pp+yfk0MyHz/RnK0XGkbWpzg37hFBT4g
         1B/6IJ3UsGVEu12+18/31ANJIJYLuhYTV0nYh+nnjECgS2F6QPT4kv9xijpy0cv7LS11
         t9oQSxvG/PnnqFbiqx9GtRBr6HT1ilPTMv25LPcqtW2AERWQNHQoFT7YlfBA03IzGWGx
         D3xShtx8GjM1KPp6pRcLZ3JxTpt48gIR20tnZQXotrcXdUYN1mHWfJ2vo3bJOwePSLVP
         CMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755483712; x=1756088512;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q2VQ98bzsRDXPvAwzT0crPvEy6KznXXOPwFqZG4IBm8=;
        b=XUQdxhh04b8E6pgzXOpkUww92R5dRjkii6gXLxeRG9/xQg5QZ2bQRDAAM1ZM4LImhZ
         1amtSLLEQsNUuomWAeHOr7nDBI8NewRVec6zOOIVfYRA2MZEr3I/W/CSF7Qcsg6Js0CJ
         NlR7B4xVlNpvUNpWkecMO6l/qKh012M1Zxoj9EQbD4K0l7j4S3wMJaVT/5yBdcTSrG2U
         0TovzkweJVYUR3ij03AhFLRK0aFGGzpCkDLa0ZjVRaE1mvBJnQYmx04lKbQmPY4tppsY
         80xZPNrNcb2V/uRKq+gtUHb6e52bs2/PD4C+vNDT4+0wuUsUd+OsM4vz+QGOx6JCTwUY
         V/lg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ+0bFGUlkT7NW7gmYH4tQShiS69YS0KsXvswcksOpC4m/TrP8Q9vTxQmpfh1m87sw0/gLe3AVON1BDfoDmrnI@vger.kernel.org, AJvYcCX70Apsntrn5xh09zKmIqDpkRUi67XWIUvcyoJK3TRHlxpVgAXUgP0l7x6q7Rd37+HxVHQEI4EOAYsUN7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHhs4TTnpTVRudzVAFct2bcwp+kMh2KsnxUA1P5jwHW+Q/TY7Y
	+w5QfW0sl89VT3bV26NmI/ZRJcfik36tmqx1T7ubBKvp5jY93HQ7Ohyk
X-Gm-Gg: ASbGncufBh3dMCLiNnDE4/qYtHOMC4v/nPrYYER5BV9/reERop4yEbBGGWlxC6xdhE4
	3oBtTAuamxoL/bMe4QGhRUwdnYNX6p+6KBQsdsHzts8t3vRqr+6tGUldxTPe4iefn+80J3E68mx
	LxvhR7z4pLBFRjt7tE8kAPlv05V7TDf+yM8X3OAOD7mWCz/NVV4gDCTj2EAsNKlkaflk1huNxV5
	N0aKa4+Hct9d3h2iMpAXr/K53ap/ljP3IIWfTR4oXPAfa4Pc4Pb1d8KjBBZEasQHf7em02UOZIB
	S/UZ1rsHNkIcTrkabYRL0rCE66OGBfv/Gdfs5/PLz8PzXeP9aeKMS1pXM0kIh3aZGf5BkH9GTgn
	J7pADRwL3wTYKgQz2CpJTJw==
X-Google-Smtp-Source: AGHT+IGCxA/VqcVLY0AVEKjx4rmARnHxZXfwdbsFkdMFUBCtf43iqxRJcpDlvvvotEKLAkQnR9l/yQ==
X-Received: by 2002:a17:907:1c09:b0:ad8:914b:7d0b with SMTP id a640c23a62f3a-afcdc206127mr929984466b.11.1755483712007;
        Sun, 17 Aug 2025 19:21:52 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd04fbebsm702038066b.115.2025.08.17.19.21.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Aug 2025 19:21:51 -0700 (PDT)
Date: Mon, 18 Aug 2025 02:21:51 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Giant Sand Fans <rampxxxx@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"pfalcato@suse.de" <pfalcato@suse.de>,
	"ziy@nvidia.com" <ziy@nvidia.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"npache@redhat.com" <npache@redhat.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"dev.jain@arm.com" <dev.jain@arm.com>,
	"baohua@kernel.org" <baohua@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"donettom@linux.ibm.com" <donettom@linux.ibm.com>,
	"ritesh.list@gmail.com" <ritesh.list@gmail.com>
Subject: Re: [PATCH v4 4/7] mm/selftests: Fix split_huge_page_test failure on
 systems with 64KB page size
Message-ID: <20250818022151.c2haj2njkmsgbuak@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250816040113.760010-1-aboorvad@linux.ibm.com>
 <20250816040113.760010-5-aboorvad@linux.ibm.com>
 <20250816143129.u2rdwpwvfhsdptvx@master>
 <CABPJ0vja95qLmJA3uRa3MhCfDX3GoLJ6MHu881Z=sZuVdBbbEg@mail.gmail.com>
 <fb4d74b9-a92a-4040-8d3a-09c72db3f35a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb4d74b9-a92a-4040-8d3a-09c72db3f35a@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sun, Aug 17, 2025 at 10:07:01AM +0200, David Hildenbrand wrote:
[...]
>> 
>> Is it possible to have some defines here instead plain numbers?
>> Thanks
>
>I assume we should look into using kselftest_harness as a separate effort, so
>we can avoid this manual test calculation completely. I'm afraid even using
>defines will not make this significntly more readable.
>

Agree

>-- 
>Cheers
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

