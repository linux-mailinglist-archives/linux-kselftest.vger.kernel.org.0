Return-Path: <linux-kselftest+bounces-23646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E10AC9F8C57
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 07:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25CA7A15A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 06:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3D474059;
	Fri, 20 Dec 2024 06:05:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC5671750;
	Fri, 20 Dec 2024 06:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734674752; cv=none; b=N/h0a36MPD8t9kjEg+xZ/0n7Z0SxJ4qdr4mL9JfRDRBAOwDO93012g5MaA89eGDnvL29j1CPrLl607UMyVd2xYV0KYYExHe9tKNBLCURhtZeNjJMVeSYr3a0aurFx1QI1nHDv31uxc5jSdivzoOLUhQsy5g9E4KLsCHYq+T/TO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734674752; c=relaxed/simple;
	bh=ayvwCmYz2UZS+AuBXpAH+MXqMHUHMeRZC5BEFX0+lHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsQflXeBrGj5nhAip+l8qdMzHzhMw7Ky1Z4GiCWdjAckoP21XOMl+GQmwSV1IOQq9iz9Km0f9GmhxZbxyvIBj2zU6qPbLACOUKlGJ/59MHJS1mr5Y4Bf3/h914AJbvivrtRAF7AUW0J9hNBneXbg2zRwnx9B7fdtK052hHU1w70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D93F41480;
	Thu, 19 Dec 2024 22:06:16 -0800 (PST)
Received: from [10.162.42.20] (K4MQJ0H1H2.blr.arm.com [10.162.42.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57AFD3F58B;
	Thu, 19 Dec 2024 22:05:45 -0800 (PST)
Message-ID: <64863269-050d-47c9-81e2-135671cff23e@arm.com>
Date: Fri, 20 Dec 2024 11:35:42 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Added new test cases to the migration test
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
 David Hildenbrand <david@redhat.com>, shuah Khan <shuah@kernel.org>
References: <20241219102720.4487-1-donettom@linux.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20241219102720.4487-1-donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 19/12/24 3:57 pm, Donet Tom wrote:
> Added three new test cases to the migration tests:
>
> 1. Shared anon THP migration test
> This test will mmap shared anon memory, madvise it to
> MADV_HUGEPAGE, then do migration entry testing. One thread
> will move pages back and forth between nodes whilst other
> threads try and access them.
>
> 2. Private anon hugetlb migration test
> This test will mmap private anon hugetlb memory and then
> do the migration entry testing.
>
> 3. Shared anon hugetlb migration test
> This test will mmap shared anon hugetlb memory and then
> do the migration entry testing.
>
> Test results
> ============
>   # ./tools/testing/selftests/mm/migration
>   TAP version 13
>   1..6
>   # Starting 6 tests from 1 test cases.
>   #  RUN           migration.private_anon ...
>   #            OK  migration.private_anon
>   ok 1 migration.private_anon
>   #  RUN           migration.shared_anon ...
>   #            OK  migration.shared_anon
>   ok 2 migration.shared_anon
>   #  RUN           migration.private_anon_thp ...
>   #            OK  migration.private_anon_thp
>   ok 3 migration.private_anon_thp
>   #  RUN           migration.shared_anon_thp ...
>   #            OK  migration.shared_anon_thp
>   ok 4 migration.shared_anon_thp
>   #  RUN           migration.private_anon_htlb ...
>   #            OK  migration.private_anon_htlb
>   ok 5 migration.private_anon_htlb
>   #  RUN           migration.shared_anon_htlb ...
>   #            OK  migration.shared_anon_htlb
>   ok 6 migration.shared_anon_htlb
>   # PASSED: 6 / 6 tests passed.
>   # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
>   #
>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


