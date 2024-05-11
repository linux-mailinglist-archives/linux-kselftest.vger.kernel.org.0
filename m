Return-Path: <linux-kselftest+bounces-10108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DC58C32E5
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 19:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23831C20A39
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 17:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3241C6A3;
	Sat, 11 May 2024 17:19:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991741C69C;
	Sat, 11 May 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715447966; cv=none; b=C6SaR2QHt7lxJfuuacLs/d767FbR5DyFIJQfOO5/U9c9pEOcpR4RU1Dl23GW8iJWTaCCZLgkrHNj/N16SaQWdxhtx+7FAzBZtQ7h/jKfgxLTEeTyLDi636/n0KZJyv0dX+50SvzUMVOSTG+8o+pHfTc9NWfeH3mDYGmvRPGEoVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715447966; c=relaxed/simple;
	bh=pgsGnygtsFDYBZVmkmNEae+IbcuJAAlPGbGMWWujjy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwPXAsS2gC3hYu4tvCXJFTVG5uh5EJlWSwqpUsq9SBMMMTElZjNkh5Dj1vhDTDVEtVADoAH6JDaXBnY7S4epLxNzjAREmySxPW3ku+CT4kHGoBgk0CaleQRz08j/YamLZkuhi5pYssuqxr07Gz2rLLj90eydAB3PF6HhQt1tbSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A84D113E;
	Sat, 11 May 2024 10:19:44 -0700 (PDT)
Received: from [10.57.65.1] (unknown [10.57.65.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D0C53F641;
	Sat, 11 May 2024 10:19:16 -0700 (PDT)
Message-ID: <3022c21b-a34d-4592-a0da-79e047372eef@arm.com>
Date: Sat, 11 May 2024 18:19:14 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/openat2: fix clang build failures:
 -static-libasan, LOCAL_HDRS
Content-Language: en-GB
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Christian Brauner <brauner@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Alexey Gladkov <legion@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
References: <20240504044336.14411-1-jhubbard@nvidia.com>
 <c406383d-e08a-4a12-9e25-1c987b0d678f@arm.com>
 <f715719a-c835-496c-9e99-d249e5607a0b@nvidia.com>
 <b28e6bcb-dde2-4ac0-ac0d-dfddb42c4426@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <b28e6bcb-dde2-4ac0-ac0d-dfddb42c4426@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/05/2024 19:22, John Hubbard wrote:
> On 5/10/24 10:56 AM, John Hubbard wrote:
>> On 5/10/24 4:52 AM, Ryan Roberts wrote:
>>> On 04/05/2024 05:43, John Hubbard wrote:
>> ...
>>> It just occured to me that the bug report I was fixing with my attempt was
>>> invoking make like this (see [1]):
>>>
>>> # tools/testing/selftests/fchmodat2$ make CC=clang
>>> # tools/testing/selftests/openat2$ make CC=clang
>>>
>>> So LLVM is not set in this case. Perhaps my approach [2] (suggested by Arnd) of
>>> using cc-option is more robust? (cc-option is alredy used by other selftests).
>>>
>>
>> Yes, I think that would better handle the two cases: setting LLVM,
>> and/or setting CC (!).
>>
>> For that, some nits, but only worth fussing over if the patch hasn't
>> gone in yet, or if you're changing it for some other reason:
>>
> 
> I just remembered it needs the LOCAL_HDRS approach as well. Did your
> patch already go in? Should I fix up this one here to use cc-option,
> or go with yours? Either way is fine with me.

I don't think my patch has been taken into any branch - I didn't see a
notification anyway. So it would be great if you are happy to take ownership of
it? - I'm on Paternity leave for the next 3 weeks so wouldn't get it done until
I get back.

> 
> thanks,


