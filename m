Return-Path: <linux-kselftest+bounces-2008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A7D814302
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 08:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E7F2820C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 07:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FBD107A5;
	Fri, 15 Dec 2023 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HNR/1eHL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F278A12E49;
	Fri, 15 Dec 2023 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702626974;
	bh=mAzpZ2f4BJM5eR5FSSU8TV6Mxhh8Z/aAMsRv8jD1bRc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HNR/1eHLnd0viOV+aHNDzc5a5U78Wf9gw9Icr/gmxIVPhttHLtgIvzp7opGestxOG
	 e7mk87G1bvLJS+zRHnZnv0sB+u+hJ0XHbdwSU7jPqYGfouz4XYqJJhl5dAcCM5++vK
	 7hYPE1b25KDIovETWldP0/Mp8wFrumdO1uKfZnYVx5lA6CeIBmP746k7NmR9VYrOMc
	 Z6hkSGq2LZTpncvoPdeYtIuqPeoS5tvGS5HGrFkvi+z3OiDDos90/H6hfPCGEaMl++
	 N66XufmXLvrvr9aB4IvUIQfzZRudt641+hmkvnsxWrV38wKksLp3tjnnGNGd4wOXfU
	 A1nb09D5Hu2VQ==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6CE0C3781433;
	Fri, 15 Dec 2023 07:56:11 +0000 (UTC)
Message-ID: <90939a1f-8519-4645-b869-5c1f8e701a3c@collabora.com>
Date: Fri, 15 Dec 2023 12:56:08 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 kernel@collabora.com, "kernelci.org bot" <bot@kernelci.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: secretmem: Floor the memory size to the
 multiple of page_size
To: Andrew Morton <akpm@linux-foundation.org>
References: <20231214101931.1155586-1-usama.anjum@collabora.com>
 <20231214114056.ec687939a411961db10e73df@linux-foundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231214114056.ec687939a411961db10e73df@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 12/15/23 12:40 AM, Andrew Morton wrote:
> On Thu, 14 Dec 2023 15:19:30 +0500 Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> 
>> The "locked-in-memory size" limit per process can be non-multiple of
>> page_size. The mmap() fails if we try to allocate locked-in-memory
>> with same size as the allowed limit if it isn't multiple of the
>> page_size because mmap() rounds off the memory size to be allocated
>> to next multiple of page_size.
>>
>> Fix this by flooring the length to be allocated with mmap() to the
>> previous multiple of the page_size.
> 
> I'd like to understand how this was noticed, what the ongoing effect
> might be, etc.  To help decide which kernel version(s) need the patch.
This was getting triggered on KernelCI regularly because of different
ulimit settings which wasn't multiple of the page_size. Find logs here:
https://linux.kernelci.org/test/plan/id/657654bd8e81e654fae13532/ The bug
in was present from the time test was first added.
> 
>> Fixes: 76fe17ef588a ("secretmem: test: add basic selftest for memfd_secret(2)")
>> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> 
> Which is one of the reasons we're now placing a Closes: tag after a
> Reported-by:.
I was looking for email report from KernelCI. But I didn't find it. Not
sure if we can do something like following:
Closes: https://linux.kernelci.org/test/plan/id/657654bd8e81e654fae13532/

> 
> 

-- 
BR,
Muhammad Usama Anjum

