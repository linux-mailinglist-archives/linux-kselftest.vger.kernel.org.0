Return-Path: <linux-kselftest+bounces-49360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E16DD3AA47
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 227CC3093535
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9C6369209;
	Mon, 19 Jan 2026 13:24:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D57B368298;
	Mon, 19 Jan 2026 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768829051; cv=none; b=j1q0IqeZXcKFG9VU2/5fyjW/cZbHac7IpMz7pINBKHI0s6V7IN6b7RGbMuUgktZ3qGCqScFKqXNnxMpew5+MX6paK7c1/cVc8JbgyT+rsTl9zO9F9zqyPpHRk8n+2wj/CYoowYwxR3l32q31RiNY2Ts2RUYRXln1+UJX3UDp1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768829051; c=relaxed/simple;
	bh=jor/QInlEX+fsL9YlpJ8E8qDgLYYTGfnxOUzoIgOonw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caqYPutGMazPDOgh4rL0NxQFimEXBiWIwlMQADNPLJUwrevjzwB4beiejZ3KOKjDEsmQGQIeaAXaIy2jLzrNwML5MZ9xoxevWGXl38EizNE7F6A4Pw5GOZi5koJRLUtUKjNCXvP12UsUt8q/qPQIMAwTttrDuPv5tQ2sW0ehBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6C7E497;
	Mon, 19 Jan 2026 05:24:01 -0800 (PST)
Received: from [10.44.160.85] (e126510-lin.lund.arm.com [10.44.160.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CD3D3F740;
	Mon, 19 Jan 2026 05:24:06 -0800 (PST)
Message-ID: <4d3361e4-90e8-409f-bde5-b09de53137b1@arm.com>
Date: Mon, 19 Jan 2026 14:24:03 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] selftests/mm: fix usage of FORCE_READ() in cow
 tests
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Shuah Khan <shuah@kernel.org>
References: <20260107164842.3289559-1-kevin.brodsky@arm.com>
 <20260107164842.3289559-5-kevin.brodsky@arm.com>
 <e2d76567-44f3-4372-9490-5cae91619125@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <e2d76567-44f3-4372-9490-5cae91619125@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2026 11:50, David Hildenbrand (Red Hat) wrote:
> On 1/7/26 17:48, Kevin Brodsky wrote:
>> Commit 5bbc2b785e63 ("selftests/mm: fix FORCE_READ to read input
>> value correctly") modified FORCE_READ() to take a value instead of a
>> pointer. It also changed most of the call sites accordingly, but
>> missed many of them in cow.c. In those cases, we ended up with the
>> pointer itself being read, not the memory it points to.
>>
>> No failure occurred as a result, so it looks like the tests work
>> just fine without faulting in. However, the huge_zeropage tests
>> explicitly check that pages are populated, so those became skipped.
>
> Right, that's nasty! Thanks!
>
> For all cases, we could probably just fail if the memory is not
> populated after FORCE_READ().
>
> Would you have time to prepare a patch for that?

Sure, I guess we could even have a helper that performs a FORCE_READ()
and then returns the result of pagemap_is_populated().

- Kevin

