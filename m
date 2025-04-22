Return-Path: <linux-kselftest+bounces-31289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6867BA96614
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 12:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4610D3A86AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 10:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A761EB18E;
	Tue, 22 Apr 2025 10:38:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7D81E231E;
	Tue, 22 Apr 2025 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318285; cv=none; b=thGqsbyCqG8aj6dC82G23oA7kpuhb2NewWnzMhXmj24aqncf2q4Ffyh/Cc5CtXJP9ajZzquslSJReuw0TqoPglItQZYCiSYPF6yKtHOjsNwxXxn6ikW9uqpqJ29chjxOI1h4LAcCFk/lavXRRfP7wmtvURfj40FCtS9A/V7AJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318285; c=relaxed/simple;
	bh=/ht7hSMYanlp/5YVMRSsNwlIM8L9bICCrtQtmixvrXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzKdGaEMqT0cwgs7bv8a31eTND8MJFSqHWHQal7zBgCk5EienzAKPuftbXXiFsx7mJr81xuN/f3yx3BBR8dz6ONJ1T5/V+FOW67L98wUTRgEb2HhejbaJ5RDLVuqXmHKdGQjDlJMtGAG8Zruv50VnjBizdGYLJOxhBeidzV4T3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34D4C152B;
	Tue, 22 Apr 2025 03:37:58 -0700 (PDT)
Received: from [10.57.90.106] (unknown [10.57.90.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC7BF3F66E;
	Tue, 22 Apr 2025 03:37:59 -0700 (PDT)
Message-ID: <a2d2766b-0ab4-437b-951a-8595a7506fe9@arm.com>
Date: Tue, 22 Apr 2025 11:37:57 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tools/selftests: expand all guard region tests to
 file-backed
Content-Language: en-GB
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
 Kalesh Singh <kaleshsingh@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <ab42228d2bd9b8aa18e9faebcd5c88732a7e5820.1739469950.git.lorenzo.stoakes@oracle.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ab42228d2bd9b8aa18e9faebcd5c88732a7e5820.1739469950.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2025 18:17, Lorenzo Stoakes wrote:
> Extend the guard region tests to allow for test fixture variants for anon,
> shmem, and local file files.
> 
> This allows us to assert that each of the expected behaviours of anonymous
> memory also applies correctly to file-backed (both shmem and an a file
> created locally in the current working directory) and thus asserts the same
> correctness guarantees as all the remaining tests do.
> 
> The fixture teardown is now performed in the parent process rather than
> child forked ones, meaning cleanup is always performed, including unlinking
> any generated temporary files.
> 
> Additionally the variant fixture data type now contains an enum value
> indicating the type of backing store and the mmap() invocation is
> abstracted to allow for the mapping of whichever backing store the variant
> is testing.
> 
> We adjust tests as necessary to account for the fact they may now reference
> files rather than anonymous memory.

Hi Lorenzo,

I'm getting a test failure in v6.15-rc3 on arm64:

----8<----
#  RUN           guard_regions.shmem.uffd ...
# guard-regions.c:1467:uffd:Expected ioctl(uffd, UFFDIO_REGISTER, &reg) (-1) ==
0 (0)
# uffd: Test terminated by assertion
#          FAIL  guard_regions.shmem.uffd
not ok 45 guard_regions.shmem.uffd
----8<----

The ioctl is returning EINVAL.

[...]

> @@ -1281,6 +1398,9 @@ TEST_F(guard_regions, uffd)
>  	struct uffdio_register reg;
>  	struct uffdio_range range;
>  
> +	if (!is_anon_backed(variant))

Perhaps this should be filtering out shmem too? Although the manual for
userfaultfd implies that shmem is supported:

"""
Up to Linux 4.11, userfaultfd can be used only with anonymous private memory
mappings.  Since Linux 4.11, userfaultfd can be also used with hugetlbfs and
shared memory mappings.
"""

But I'm not sure if that's referring specifically to UFFDIO_REGISTER_MODE_MISSING?

Any ideas before I start debugging further?

Thanks,
Ryan

> +		SKIP(return, "uffd only works on anon backing");
> +
>  	/* Set up uffd. */
>  	uffd = userfaultfd(0);
>  	if (uffd == -1 && errno == EPERM)
> @@ -1290,8 +1410,8 @@ TEST_F(guard_regions, uffd)
>  	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
>  
>  	/* Map 10 pages. */
> -	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> -		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ptr = mmap_(self, variant, NULL, 10 * page_size,
> +		    PROT_READ | PROT_WRITE, 0, 0);
>  	ASSERT_NE(ptr, MAP_FAILED);
>  
>  	/* Register the range with uffd. */


