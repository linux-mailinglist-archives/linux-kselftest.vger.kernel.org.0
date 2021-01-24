Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49D9301F87
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jan 2021 00:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbhAXXT0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Jan 2021 18:19:26 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14261 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbhAXXTZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Jan 2021 18:19:25 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600e00550000>; Sun, 24 Jan 2021 15:18:45 -0800
Received: from [10.2.52.243] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 24 Jan
 2021 23:18:39 +0000
Subject: Re: [PATCH v7 14/14] selftests/vm: test faulting in kernel, and
 verify pinnable pages
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <david@redhat.com>, <osalvador@suse.de>,
        <dan.j.williams@intel.com>, <sashal@kernel.org>,
        <tyhicks@linux.microsoft.com>, <iamjoonsoo.kim@lge.com>,
        <mike.kravetz@oracle.com>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <jgg@ziepe.ca>, <peterz@infradead.org>,
        <mgorman@suse.de>, <willy@infradead.org>, <rientjes@google.com>,
        <linux-doc@vger.kernel.org>, <ira.weiny@intel.com>,
        <linux-kselftest@vger.kernel.org>
References: <20210122033748.924330-1-pasha.tatashin@soleen.com>
 <20210122033748.924330-15-pasha.tatashin@soleen.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <532b1927-1b5d-83e8-f1f9-50cd5e72435f@nvidia.com>
Date:   Sun, 24 Jan 2021 15:18:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210122033748.924330-15-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611530325; bh=yU8511hV57P0w7d0jPjk2t0wmPLj/hsWdLqeK4Z4aAk=;
        h=Subject:To:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=n1b89sXKmnkyYyciV/4pAGy8Y58mJ6yJ142H0nA84BqmnOq/hxmtl49/egxvw1DMY
         7bUJwehU2KcZj00/0w18vL04z7fvUBaxyxDraB1sVzSBdnb21IUbBw2TUeBXSStgT/
         FhsI5jgRpxM+PRz7uZMfpS0rtpJTZ4XWr4ccsf3LUXdqmUZN6n4+fucqeN4X+YTltq
         81lDtJJV4kuUSTTrV7TNdllpCPYxOxnXGCRm2hoNr023ijTO+8MJNiUowIi8sLmrWP
         C1lXjH1tU9wM+YJY0lXHgOmBh35wwr1R+JR/UszDdQw3Q6NrSHqrsWiHzpjMJXDH5J
         RwAubw3Gh9xyQ==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/21/21 7:37 PM, Pavel Tatashin wrote:
> When pages are pinned they can be faulted in userland and migrated, and
> they can be faulted right in kernel without migration.
> 
> In either case, the pinned pages must end-up being pinnable (not movable).
> 
> Add a new test to gup_test, to help verify that the gup/pup
> (get_user_pages() / pin_user_pages()) behavior with respect to pinnable
> and movable pages is reasonable and correct. Specifically, provide a
> way to:
> 
> 1) Verify that only "pinnable" pages are pinned. This is checked
> automatically for you.
> 
> 2) Verify that gup/pup performance is reasonable. This requires
> comparing benchmarks between doing gup/pup on pages that have been
> pre-faulted in from user space, vs. doing gup/pup on pages that are not
> faulted in until gup/pup time (via FOLL_TOUCH). This decision is
> controlled with the new -z command line option.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>   mm/gup_test.c                         |  6 ++++++
>   tools/testing/selftests/vm/gup_test.c | 23 +++++++++++++++++++----
>   2 files changed, 25 insertions(+), 4 deletions(-)
> 

This also looks good. I do see the WARN_ON_ONCE firing in
internal_get_user_pages_fast(), when running with *only* the new -z
option.

I'll poke around the rest of the patchset and see if that is expected
and normal, but either way the test code itself looks correct and seems
to be passing my set of "run a bunch of different gup_test options" here,
so feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/mm/gup_test.c b/mm/gup_test.c
> index a6ed1c877679..d974dec19e1c 100644
> --- a/mm/gup_test.c
> +++ b/mm/gup_test.c
> @@ -52,6 +52,12 @@ static void verify_dma_pinned(unsigned int cmd, struct page **pages,
>   
>   				dump_page(page, "gup_test failure");
>   				break;
> +			} else if (cmd == PIN_LONGTERM_BENCHMARK &&
> +				WARN(!is_pinnable_page(page),
> +				     "pages[%lu] is NOT pinnable but pinned\n",
> +				     i)) {
> +				dump_page(page, "gup_test failure");
> +				break;
>   			}
>   		}
>   		break;
> diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
> index 943cc2608dc2..1e662d59c502 100644
> --- a/tools/testing/selftests/vm/gup_test.c
> +++ b/tools/testing/selftests/vm/gup_test.c
> @@ -13,6 +13,7 @@
>   
>   /* Just the flags we need, copied from mm.h: */
>   #define FOLL_WRITE	0x01	/* check pte is writable */
> +#define FOLL_TOUCH	0x02	/* mark page accessed */
>   
>   static char *cmd_to_str(unsigned long cmd)
>   {
> @@ -39,11 +40,11 @@ int main(int argc, char **argv)
>   	unsigned long size = 128 * MB;
>   	int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 1;
>   	unsigned long cmd = GUP_FAST_BENCHMARK;
> -	int flags = MAP_PRIVATE;
> +	int flags = MAP_PRIVATE, touch = 0;
>   	char *file = "/dev/zero";
>   	char *p;
>   
> -	while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHp")) != -1) {
> +	while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHpz")) != -1) {
>   		switch (opt) {
>   		case 'a':
>   			cmd = PIN_FAST_BENCHMARK;
> @@ -110,6 +111,10 @@ int main(int argc, char **argv)
>   		case 'H':
>   			flags |= (MAP_HUGETLB | MAP_ANONYMOUS);
>   			break;
> +		case 'z':
> +			/* fault pages in gup, do not fault in userland */
> +			touch = 1;
> +			break;
>   		default:
>   			return -1;
>   		}
> @@ -167,8 +172,18 @@ int main(int argc, char **argv)
>   	else if (thp == 0)
>   		madvise(p, size, MADV_NOHUGEPAGE);
>   
> -	for (; (unsigned long)p < gup.addr + size; p += PAGE_SIZE)
> -		p[0] = 0;
> +	/*
> +	 * FOLL_TOUCH, in gup_test, is used as an either/or case: either
> +	 * fault pages in from the kernel via FOLL_TOUCH, or fault them
> +	 * in here, from user space. This allows comparison of performance
> +	 * between those two cases.
> +	 */
> +	if (touch) {
> +		gup.gup_flags |= FOLL_TOUCH;
> +	} else {
> +		for (; (unsigned long)p < gup.addr + size; p += PAGE_SIZE)
> +			p[0] = 0;
> +	}
>   
>   	/* Only report timing information on the *_BENCHMARK commands: */
>   	if ((cmd == PIN_FAST_BENCHMARK) || (cmd == GUP_FAST_BENCHMARK) ||
> 

