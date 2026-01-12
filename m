Return-Path: <linux-kselftest+bounces-48723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DA4D1187B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F5C1304421C
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CBB30FC10;
	Mon, 12 Jan 2026 09:37:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5432426F46E;
	Mon, 12 Jan 2026 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210652; cv=none; b=CcXDwQh+bpZQyTVVhb04I+Cwf7xFEY2Zd/vtYiFh+amZ3aojxSBLwT/9e4et97CAo/qd9cPDE/PdIKY0JJVQ8GuodlN/QJYGeXPRdK2mK+HvmZw2wHBMBvxkbOVaDDjXgFtAC4rcvxrgEtdOFOsnzN6nZE4GCLjKl0FBBdqKDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210652; c=relaxed/simple;
	bh=5To1HxyXItrH5x8LfE5tOyFQih2ma4t3vydprLTVem8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvZUr3AdlKouf843cVGL+1b1nBcFX1Gpv88XgIrEiBiSIi5MPm0/TksVBqS8z0Hq+FTZBWFXpZqWpvJPwJd3gdSRJ++IV0XySPvE1UxxYFvisdJawFQ02yhR0n+sgK8CUOPsPFvoeGBiGOa/mEMbTmL8Ak31L+tEWHzVtBTuc4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2002E339;
	Mon, 12 Jan 2026 01:37:24 -0800 (PST)
Received: from [10.57.48.185] (unknown [10.57.48.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 663AA3F694;
	Mon, 12 Jan 2026 01:37:28 -0800 (PST)
Message-ID: <b785754d-ba6f-42db-9e44-66fd377aad03@arm.com>
Date: Mon, 12 Jan 2026 10:37:26 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] selftests/mm: introduce helper to read every page
 in range
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Shuah Khan <shuah@kernel.org>
References: <20260109013009.68474-1-sj@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260109013009.68474-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2026 02:30, SeongJae Park wrote:
> On Wed,  7 Jan 2026 16:48:39 +0000 Kevin Brodsky <kevin.brodsky@arm.com> wrote:
>
>> FORCE_READ(*addr) ensures that the compiler will emit a load from
>> addr. Several tests need to trigger such a load for every page in
>> the range [addr, addr + len), ensuring that every page is faulted
>> in, if it wasn't already.
>>
>> Introduce a new helper force_read_pages_in_range() that does exactly
>> that and replace existing loops with a call to it.
> Seems like a good cleanup to me.

Thanks for having a look at this series!

>> Some of those
>> loops have a different step size, but reading from every page is
>> appropriate in all cases.
> So the test program's behavior is slightly be changed.  I believe that
> shouldn't be problem, but I'm not that familiar with the test code, so not very
> sure.  I'd like to listen voices from people more familiar with those.
>
> Meanwhile, I'm curious what do you think about making the helper function
> receives the step size together, and let the callers just pass their current
> step size.

That's what I initially considered, but considering this discussion on
v1 [1] this doesn't seem to be justified. In hugetlb-madvise, reading
every page instead of every hugepage is unnecessary but still correct
and the overhead should be negligible. In split_huge_page_test, I don't
think there's any justification for reading every byte - the intention
is to fault in pages, like all the other cases this patch touches.

- Kevin

[1]
https://lore.kernel.org/all/a3ca6293-8f85-4489-a48e-eb8d0d3792c5@kernel.org/


