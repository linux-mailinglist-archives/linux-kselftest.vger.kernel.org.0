Return-Path: <linux-kselftest+bounces-18203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C43297E5A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 07:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 984FDB20D6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 05:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EED6EAF6;
	Mon, 23 Sep 2024 05:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="DugNqPJF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746D0184;
	Mon, 23 Sep 2024 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727069785; cv=pass; b=Rxn1HeXMNBlZOuOwq51t4eeIWmaEA4i5H8ZHpM8F3tGQSrltmgcy061ar4EjctUg7RZTyQXTSf6jyRmXGxCtgClp8MwEtjH1f66Wa9MtxVkTYt/rsecy17j/8AG2nbN3vRA8GxBYXnpWJfM3E0KZtDVGkBgD0OOmqqhRoJl1v5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727069785; c=relaxed/simple;
	bh=jc+AGoERV8fZGu3MweyUXEhR2dgLmZVHJwtV+FA0khk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qt8c7wRr9CLlwgLEe4/ZG8NiyGr/oezl9PrnAm7ZTvb8MGri2Af/cXezIHcxji5qpOuTZ7FdR8PRfhfCAoIH9U3jTC4pDvvFz6LKFQXcX6YUXbbZ0OKIS08WRVTxyUyVo8Z/FJsjlz5t9y3wCjPFL2SyLA4god8E0+QvyhWJU/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=DugNqPJF; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1727069763; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GMaTpHGd0LWwpouQsRRcq6ruFf2xuHXgrb5Aq3er28AbUbR3KkMO+hvdccv/AnDfpBwRikdHPrxMRlQPDVDYD+QbsZl6BKzqI7nyRLDb5ds9iXr69eSIuG9MHVuSSph3ozKRZgeCE+xjeOQhComZk5WgvyKNp2O/etrdQfB4e5U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727069763; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EfD6aWYTSxhMi80whxI+ZCh5yYgjEVQIiD1705p5+tA=; 
	b=PDGOCnq0SOm3SnXNffLMJSQr3EWnt33/kGST3fM5zb7URfbMhJ9RbdOtJ38bek1TByDXOPT/Z2MuatWXI15qm0A/BiLCbEj/WLU4T87mLKQb0v77FJjANqyJ/8wZTjJ2YAjIwDZp3P5+OVlyo9nCIxuSf0G7Xjd3+uDG1ibbm3Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727069763;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EfD6aWYTSxhMi80whxI+ZCh5yYgjEVQIiD1705p5+tA=;
	b=DugNqPJFZqJ8WvbhZaql4mqylKjdjIDbLYg1rKky83Ab/6UgidWkQkO3u1qNXivt
	6XfH66m8WQMZSIQFGZ5jmSArIWyC8w4nGiS3xdAJi5ghG/vhFgHx3dtQLso0bGHx4Xr
	cVle50xK9ZXbI0XPVkvrqSy6vgrhso1CBDDI/r7U=
Received: by mx.zohomail.com with SMTPS id 1727069761276507.686379545268;
	Sun, 22 Sep 2024 22:36:01 -0700 (PDT)
Message-ID: <e4e2095e-3280-4bfc-8129-80b8d00d146d@collabora.com>
Date: Mon, 23 Sep 2024 10:35:52 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 1/2] kselftests: mm: Fix wrong __NR_userfaultfd value
To: Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Kim Phillips <kim.phillips@arm.com>
References: <20240912103151.1520254-1-usama.anjum@collabora.com>
 <a9ae7dc4-275d-43c3-bf4c-b0090cb6bb12@linuxfoundation.org>
 <3cb9d266-4d4b-4031-8603-da7fd9e3ad47@collabora.com>
 <b3caeb96-2f48-4efd-a56c-e91dae891b48@linuxfoundation.org>
 <0b847784-a95f-4ed5-a0fb-1b7b4023df13@collabora.com>
 <e2a4d2b4-ca3f-4d21-82d5-b87bc9de9358@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <e2a4d2b4-ca3f-4d21-82d5-b87bc9de9358@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

...

>> grep -rnIF "#define __NR_userfaultfd"
>> tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
>> arch/x86/include/generated/uapi/asm/unistd_32.h:374:#define
>> __NR_userfaultfd 374
>> arch/x86/include/generated/uapi/asm/unistd_64.h:327:#define
>> __NR_userfaultfd 323
>> arch/x86/include/generated/uapi/asm/unistd_x32.h:282:#define
>> __NR_userfaultfd (__X32_SYSCALL_BIT + 323)
>> arch/arm/include/generated/uapi/asm/unistd-eabi.h:347:#define
>> __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
>> arch/arm/include/generated/uapi/asm/unistd-oabi.h:359:#define
>> __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
>> include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
>>
>> The number is dependent on the architecture. The above data shows that:
>> x86    374
>> x86_64    323
> 
> Correct and the generated header files do the right thing and it is good to
> include them as this patch does.
> 
> This is a good find and fix. I wish you explained this in your changelog.
> Please add more details when you send v2.
I'm sending v2

> 
> There could be other issues lurking based on what I found.
> 
> The other two files are the problem where they hard code it to 282 without
> taking the __NR_SYSCALL_BASE for the arch into consideration:
> 
> tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
> include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
> 
>>
>> I'm unable to find the history of why it is set to 282 in unistd.h and
>> when this problem happened.
> 
> According to git history it is added in the following commit to
> include/uapi/asm-generic/unistd.h:
> 
> 09f7298100ea9767324298ab0c7979f6d7463183
> Subject: [PATCH] userfaultfd: register uapi generic syscall (aarch64)
> 
> and it is added in the following commit to
> tools/include/uapi/asm-generic/unistd.h
> 34b009cfde2b8ce20a69c7bfd6bad4ce0e7cd970
> Subject: [PATCH] tools include: Grab copies of arm64 dependent unistd.h
> files
> 
> I think, the above defines from include/uapi/asm-generic/unistd.h and
> tools/include/uapi/asm-generic/unistd.h should be removed.
> 
> Maybe others familiar with userfaultfd can determine the best course of
> action.
> We might have other NR_ defines in these two files that are causing
> problems
> for tests and tools that we haven't uncovered yet.
Added authors of these patches.

> 
> thanks,
> -- Shuah

-- 
BR,
Muhammad Usama Anjum


