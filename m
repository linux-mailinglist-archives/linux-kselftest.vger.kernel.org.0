Return-Path: <linux-kselftest+bounces-39456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95ABB2EE3F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 08:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83495A00200
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8507A2C21E6;
	Thu, 21 Aug 2025 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f6Y2cmZR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB7326E70B;
	Thu, 21 Aug 2025 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757749; cv=none; b=UwBvPQjuMWokwNOfckpoZLVMBEH0Go8vwvPY1Pi0ZbyiFiHilI/LtMc2HIrK5UAjeVK9TGgn417XxrJoCS0Je0zLy37wmHMEhD9srHAqyIR0MV6HAuD2K60KyLVvhoyo8iuZ2SI2g5FpJLSBo2/gmsUs+t6X6bzMbFHdWJ829qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757749; c=relaxed/simple;
	bh=oScGVxYxElRoNaNscAJZx59aF4CUHiYp5n6VK4Ekqhc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P3INjLURdLmPSb6j+AjKDS6Mq/quK/Kle4ZZE+ERPSHUeavVs2bpwwGTfV/I6clh3GGreeHkgaM3vPmYW16PkzpVSfqr0YihPm7BAdtj7C5Id00ag0i+kwuPVMpvJkOl0aDBLrgBWRhxN9iniqIiC+Xs9H/d8l+g4hUFaVWoD9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f6Y2cmZR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755757745;
	bh=oScGVxYxElRoNaNscAJZx59aF4CUHiYp5n6VK4Ekqhc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=f6Y2cmZRdX0cSOHMuO4FqsOTJux5OXhWeAM7PKzyf/AvbVdC/hR0Ut2G60gnCOcLd
	 WHkFIy04wlGPbqrVNOkRtzxXuwp40/FsjB5F/cNFoo0snKjrhjXDL9OvJ4gakMBvSe
	 EFxgn7j03S8bcHquAEPPCMNw0oIORItPyMCa7OF+/3w7YQRe8xSzOLp8XNNNs6ED6L
	 ktwquup+Hbdil2LZuNAafnNmwFe6WUmXd2bgLQGsXEYuQlB3Ieay6kKworuFEzSyUy
	 8RRpiEKY53Rq1mxHbMxoafLh4lvtLODu2WQT4ROM/v31gkqyjUlCzhRh22bEKigAsr
	 p4ja4/QcAy+YQ==
Received: from [192.168.100.175] (unknown [103.151.43.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A1EA517E0458;
	Thu, 21 Aug 2025 08:29:00 +0200 (CEST)
Message-ID: <8e9d7c59-46b4-4e1b-8a55-1898302f5080@collabora.com>
Date: Thu, 21 Aug 2025 11:28:59 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, kernel@collabora.com
Subject: Re: [PATCH v2 4/8] selftests/mm: Add -Wunused family of flags
To: Kevin Brodsky <kevin.brodsky@arm.com>,
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
References: <20250731160132.1795351-1-usama.anjum@collabora.com>
 <20250731160132.1795351-5-usama.anjum@collabora.com>
 <57c816d6-a9ba-47c9-8f40-3978580b7f67@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <57c816d6-a9ba-47c9-8f40-3978580b7f67@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/18/25 1:16 PM, Kevin Brodsky wrote:
> On 31/07/2025 18:01, Muhammad Usama Anjum wrote:
>> [...]
>>
>> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
>> index 23d4bf6215465..d75f1effcb791 100644
>> --- a/tools/testing/selftests/mm/Makefile
>> +++ b/tools/testing/selftests/mm/Makefile
>> @@ -20,7 +20,6 @@ endif
>>  # thus tricking Make (and you!) into believing that All Is Well, in subsequent
>>  # make invocations:
>>  .DELETE_ON_ERROR:
>> -
>>  # Avoid accidental wrong builds, due to built-in rules working just a little
>>  # bit too well--but not quite as well as required for our situation here.
>>  #
>> @@ -35,6 +34,7 @@ MAKEFLAGS += --no-builtin-rules
>>  
>>  CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
>>  CFLAGS += -Wunreachable-code
>> +CFLAGS += -Wunused  -Wunused-parameter -Wunused-function -Wunused-label -Wunused-variable -Wunused-value
> 
> -Wall implies all of these except -Wunused-parameter (at least according
> to gcc(1)).
I'll remove others in separate patch.

> 
> As to -Wunused-parameter I am frankly not convinced it's worth the
> hassle. We're getting 90 lines changed in patch 6-8 just to mark
> parameters as unused, in other words noise to keep the compiler happy.
> It is not enabled by default in the kernel proper precisely because it
> is so noisy when callbacks are involved.
> 
> Patch 5 is clearly an improvement, but I'd rather take it without
> actually enabling -Wunused-parameter. The rest of this patch isn't that
> useful either IMHO.
Patch 5 removes genuinely unused parameters flagged by the compiler. If we
drop the -Wunused-parameter option, however, new unused parameters will
continue to creep in with future patches. The goal of enabling this warning
is to surface such issues early so developers can address them during
development, rather than later during review or debugging.

Long term, I’d like us to rely more on compiler and static analysis just like
kernel to catch these kinds of problems proactively, instead of waiting until
they’re reported or someone fixes them later. While it may feel like noise
initially, this is largely a one-time cleanup—once done, developers will
simply fix warnings as they arise, keeping the codebase cleaner going forward.

> 
> - Kevin


-- 
---
Thanks,
Usama

