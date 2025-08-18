Return-Path: <linux-kselftest+bounces-39207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED83B29BBF
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 10:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8A418A7AC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 08:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CD22FB965;
	Mon, 18 Aug 2025 08:12:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9DB2E5D17;
	Mon, 18 Aug 2025 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504752; cv=none; b=YbM8WYpJmaGD/FL9CxeG/xxdIsbn8VEAbFqQlmGc02ucLU25aFVLyUKku0Inox2Ur6ebzKTaupYSsNyGZRHUOx2Eiv3eIfbwYo0gVgplPcBCgnctGh1tG4j26CJsJ/hWI25huFszwgg5WHL6Cxa4LVhsRkVdmAWlPMO3cPmpmGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504752; c=relaxed/simple;
	bh=rfG+bDQCMIrxcWKkGWLjiNUJRMU06555nagMsdM4YOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQjPwCmNk3JfCEgTqL5RDG3l/ofIwYswLvJhZjxIc4aZkLRor3laSRN0/X0l0jmatrNcwDaztkLSl02ZXBCJEGQobKE3fAn7GeUKz2GLchJTXv66WbIsuiIsgzn/u8I48ZDOFvKfJqxVrItAvI+ys+r7c986pgIbO01Z+F5CfN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 028561762;
	Mon, 18 Aug 2025 01:12:22 -0700 (PDT)
Received: from [10.57.58.12] (unknown [10.57.58.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A60AF3F63F;
	Mon, 18 Aug 2025 01:12:24 -0700 (PDT)
Message-ID: <28d7d186-5068-4546-90af-f9a9a0147f21@arm.com>
Date: Mon, 18 Aug 2025 10:12:22 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] selftests/mm: protection_keys: Fix dead code
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
 linux-riscv@lists.infradead.org, Shuah Khan <shuah@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: kernel@collabora.com
References: <20250731160132.1795351-1-usama.anjum@collabora.com>
 <20250731160132.1795351-3-usama.anjum@collabora.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20250731160132.1795351-3-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+Dave Hansen

On 31/07/2025 18:01, Muhammad Usama Anjum wrote:
> The while loop doesn't execute and following warning gets generated:
>
> protection_keys.c:561:15: warning: code will never be executed
> [-Wunreachable-code]
>                 int rpkey = alloc_random_pkey();
>
> Let's enable the while loop such that it gets executed nr_iterations
> times. Simplify the code a bit as well.
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/mm/protection_keys.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
> index 23ebec367015f..6281d4c61b50e 100644
> --- a/tools/testing/selftests/mm/protection_keys.c
> +++ b/tools/testing/selftests/mm/protection_keys.c
> @@ -557,13 +557,11 @@ int mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
>  	int nr_iterations = random() % 100;
>  	int ret;
>  
> -	while (0) {
> +	while (nr_iterations-- >= 0) {

Now that is a good catch! I had never realised this whole loop was dead
code...

The question is whether we really want it. This code looked exactly this
way when it was merged [1] so it has never been run. It looks
suspiciously like debug code.

Dave, should we just remove this?

- Kevin

[1]
https://lore.kernel.org/all/20160729163024.FC5A0C2D@viggo.jf.intel.com/T/#u

>  		int rpkey = alloc_random_pkey();
>  		ret = sys_mprotect_pkey(ptr, size, orig_prot, pkey);
>  		dprintf1("sys_mprotect_pkey(%p, %zx, prot=0x%lx, pkey=%ld) ret: %d\n",
>  				ptr, size, orig_prot, pkey, ret);
> -		if (nr_iterations-- < 0)
> -			break;
>  
>  		dprintf1("%s()::%d, ret: %d pkey_reg: 0x%016llx"
>  			" shadow: 0x%016llx\n",

