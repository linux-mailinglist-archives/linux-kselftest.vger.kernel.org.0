Return-Path: <linux-kselftest+bounces-6484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100728865E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 06:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1ED1F2447E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 05:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E65A79EF;
	Fri, 22 Mar 2024 05:12:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50C510F2;
	Fri, 22 Mar 2024 05:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711084377; cv=none; b=nUoP0lV4lM6MdmPUR1JlqUg4f70i9vi0r2igqyz78QVgo1rFaWyFrP727Kla9yvt9hCcvLW8q080w/2oKo5vc/ivCYa9RAOMstWuer4z/wv5gH1qY/tK5bHh15m7qWaJkDzr87TNeq9t1qYq3awekiHetTdm2zhjNm4OcTP+y6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711084377; c=relaxed/simple;
	bh=bt1svfdkfR6+XUmbLAUP+ZbBeUXKfxqS+J71mNiovBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3X3XHWbckEGnR6fWghq9Ujp0JZUWOplgY1DUso6IQRIkHmMtBnpplpWh6x+jvCQyEP3/6TGmE98u8vm33f1XRTMPEuJ7Y86RY+IDmINTFrBTS2J0PbN+s8Ru9RSfEuZWaidQzFreiS0IaYiyG7YPVQPCycOtgsl1e6YmlbRjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF4C71007;
	Thu, 21 Mar 2024 22:13:26 -0700 (PDT)
Received: from [10.162.40.23] (e116581.arm.com [10.162.40.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CABEE3F762;
	Thu, 21 Mar 2024 22:12:50 -0700 (PDT)
Message-ID: <d91c8c36-b01d-48f9-b0f6-8faa58edaed0@arm.com>
Date: Fri, 22 Mar 2024 10:42:47 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Confirm VA exhaustion without reliance on
 correctness of mmap()
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com
References: <20240321103522.516097-1-dev.jain@arm.com>
 <20240321145146.a3ce8a1e247371e33a437978@linux-foundation.org>
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240321145146.a3ce8a1e247371e33a437978@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/22/24 03:21, Andrew Morton wrote:
> On Thu, 21 Mar 2024 16:05:22 +0530 Dev Jain <dev.jain@arm.com> wrote:
>
>> Currently, VA exhaustion is being checked by passing a hint to mmap() and
>> expecting it to fail. This patch makes a stricter test by successful write()
>> calls from /proc/self/maps to a dump file, confirming that a free chunk is
>> indeed not available.
> What's wrong with the current approach?
While populating the lower VA space, mmap() fails because we have 
exhausted the space.

Then, in validate_lower_address_hint(), because mmap() fails, we confirm 
that we have

indeed exhausted the space. There is a circular logic involved here.

Assume that there is a bug in mmap(), also assume that it exists 
independent of whether

you pass a hint address or not; that for some reason it is not able to 
find a 1GB chunk.

My idea is to assert the exhaustion against some other method.


Also, in the following line in validate_complete_va_space():

         if (start_addr - prev_end_addr >= SZ_1GB)

I made a small error, I forgot to use MAP_CHUNK_SIZE instead of SZ_1GB.

