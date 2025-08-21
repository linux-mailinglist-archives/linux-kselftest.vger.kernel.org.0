Return-Path: <linux-kselftest+bounces-39475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A23B2F570
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 12:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3FD1BA12BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0375522AE7A;
	Thu, 21 Aug 2025 10:34:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B541C701F;
	Thu, 21 Aug 2025 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772492; cv=none; b=ivEA+oDihvjt1H/4IGxQZEg0hXvdtN1JS+Jp+mOV8xpZAEu8uVKa0TTMRc2pAB3MURnKF2uLdwUj+knRadjiC6NpuC1sxonovOTE4poi/px1xXfFqtk9WqhH23q+xrRfsSIJjG2TZW4xqd5C+/1rMPIv24bbRJkO8nxKR1F1XYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772492; c=relaxed/simple;
	bh=red0dGa++TOzVhe/hYcvQlEOP59ONxx+JtjyD02D1/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJrHIMapd7mX8R0MqQnHwXqrGBaEBNQxndzuOcl/HySu8X0TV9mqFajWvUI6fupgx5Serw3F9SAa8OwJvadrZIbCPm+TCYqxPCgDm81oWoH3unlp3ye2fQyWU2SjO1yhDtQTHpEU0QrNUt4kbtxGDtCmq+ioCQMEAcTMKzDgzFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3830C152B;
	Thu, 21 Aug 2025 03:34:42 -0700 (PDT)
Received: from [10.57.91.188] (unknown [10.57.91.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 334CD3F63F;
	Thu, 21 Aug 2025 03:34:44 -0700 (PDT)
Message-ID: <f997a8ec-26aa-45f3-a757-d221321c8607@arm.com>
Date: Thu, 21 Aug 2025 12:34:41 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] selftests/mm: Add -Wunreachable-code and fix
 warnings
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Leon Romanovsky <leon@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com
References: <20250731160132.1795351-1-usama.anjum@collabora.com>
 <20250731160132.1795351-2-usama.anjum@collabora.com>
 <c09a2a13-8571-44e5-b780-c704598df764@arm.com>
 <46dce2ac-adb5-4a6b-8847-fe214c1599a7@collabora.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <46dce2ac-adb5-4a6b-8847-fe214c1599a7@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2025 08:19, Muhammad Usama Anjum wrote:
>>> [...]
>>>
>>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>>> index 05de1fc0005b7..a85b2e393e4e8 100644
>>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>>> @@ -296,10 +296,8 @@ void split_file_backed_thp(int order)
>>>  		ksft_exit_fail_msg("Unable to create a tmpfs for testing\n");
>>>  
>>>  	status = snprintf(testfile, INPUT_MAX, "%s/thp_file", tmpfs_loc);
>>> -	if (status >= INPUT_MAX) {
>>> +	if (status >= INPUT_MAX)
>>>  		ksft_exit_fail_msg("Fail to create file-backed THP split testing file\n");
>>> -		goto cleanup;
>> At that point the mount() call has succeeded so I think we do want to
>> keep the goto and just print the error message instead of calling
>> replace ksft_exit_fail_msg().
> The cleanup tag does cleanup and then calls ksft_exit_fail_msg() without printing the
> actual reason of failure. So current flow seems good where information about the error
> is being printed.

My point is that with this patch, ksft_exit_fail_msg() still causes the
test to exit right away without the cleanup steps (i.e.
unmounting/removing the directory) being executed. Printing a specific
error message is good but we should also run the cleanup steps.

- Kevin

