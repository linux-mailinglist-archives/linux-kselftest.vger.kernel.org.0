Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4AD24556C
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Aug 2020 04:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgHPCFP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Aug 2020 22:05:15 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4140 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgHPCFP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Aug 2020 22:05:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3893eb0000>; Sat, 15 Aug 2020 19:03:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 15 Aug 2020 19:05:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 15 Aug 2020 19:05:13 -0700
Received: from [10.2.60.198] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 16 Aug
 2020 02:05:05 +0000
Subject: Re: [PATCH] mm/gup_benchmark: use pin_user_pages for FOLL_LONGTERM
 flag
To:     Barry Song <song.bao.hua@hisilicon.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Jan Kara <jack@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Christoph Hellwig" <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Dave Chinner" <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Jonathan Corbet" <corbet@lwn.net>, Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
References: <20200815122056.29508-1-song.bao.hua@hisilicon.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <eb62980c-2cf1-20a1-331e-8908b354c6a9@nvidia.com>
Date:   Sat, 15 Aug 2020 19:05:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200815122056.29508-1-song.bao.hua@hisilicon.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/20 5:20 AM, Barry Song wrote:
> According to Documentation/core-api/pin_user_pages.rst, FOLL_PIN is a
> prerequisite to FOLL_LONGTERM. Another way of saying that is,
> FOLL_LONGTERM is a specific case, more restrictive case of FOLL_PIN.
> 
> Almost all kernel modules are using pin_user_pages() with FOLL_LONGTERM,
> mm/gup_benchmark.c seems to the only exception in which FOLL_PIN is not
> a prerequisite to FOLL_LONGTERM.
> 
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   mm/gup_benchmark.c                         | 23 +++++++++++-----------
>   tools/testing/selftests/vm/gup_benchmark.c | 14 ++++++-------
>   2 files changed, 19 insertions(+), 18 deletions(-)
DKIM-Signature: v a a-sha256; claxed/relaxed; d idia.com; s;
	t97543403; bh MgR68sU/7ylDBje1zIHeASZNXztqkMbZmncLAvXTg	h PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
	 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
	 X-ClientProxiedBy:Content-Type:Content-Language:
	 Content-Transfer-Encoding;
	bUpDUC+nMHrjfAF7P2cj7wZXrE8nzUsgwO7si5v+/Uys92+nacgh1CLHbW1syXHM
	 mxt5KwyRUBdpZW65ued56n+Kneao+1VTejBHXumUtHN/VFk/cnr8boa1CWU2tWn/d+
	 ZXY2/sej9jXBl/ejghwFJnTlKl6oX+UY4N8l1MeEYBX/YJBGfR9bA69elnQmBvuHNd
	 CTdEa3mZ4wcaK+Pgpxyb/z1NhveEAQlAzkfs7llvB8Cgk0q7Ta0jObqzjtwI9n5kow
	 IHZsPJRmIxe05DO4LI8DKO7Etb/GyrCXklwOGW9LuB6suRsLSlSri85gc0dSAhuTkK
	 vqEWLfitNguIA
Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
> index be690fa66a46..464cae1fa3ea 100644
> --- a/mm/gup_benchmark.c
> +++ b/mm/gup_benchmark.c
> @@ -6,10 +6,10 @@
>   #include <linux/debugfs.h>
>   
>   #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
> -#define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
> -#define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
> -#define PIN_FAST_BENCHMARK	_IOWR('g', 4, struct gup_benchmark)
> -#define PIN_BENCHMARK		_IOWR('g', 5, struct gup_benchmark)
> +#define GUP_BENCHMARK		_IOWR('g', 2, struct gup_benchmark)
> +#define PIN_FAST_BENCHMARK	_IOWR('g', 3, struct gup_benchmark)
> +#define PIN_BENCHMARK		_IOWR('g', 4, struct gup_benchmark)
> +#define PIN_LONGTERM_BENCHMARK	_IOWR('g', 5, struct gup_benchmark)
>   
>   struct gup_benchmark {
>   	__u64 get_delta_usec;
> @@ -28,7 +28,6 @@ static void put_back_pages(unsigned int cmd, struct page **pages,
>   
>   	switch (cmd) {
>   	case GUP_FAST_BENCHMARK:
> -	case GUP_LONGTERM_BENCHMARK:
>   	case GUP_BENCHMARK:
>   		for (i = 0; i < nr_pages; i++)
>   			put_page(pages[i]);
> @@ -36,6 +35,7 @@ static void put_back_pages(unsigned int cmd, struct page **pages,
>   
>   	case PIN_FAST_BENCHMARK:
>   	case PIN_BENCHMARK:
> +	case PIN_LONGTERM_BENCHMARK:
>   		unpin_user_pages(pages, nr_pages);
>   		break;
>   	}
> @@ -50,6 +50,7 @@ static void verify_dma_pinned(unsigned int cmd, struct page **pages,
>   	switch (cmd) {
>   	case PIN_FAST_BENCHMARK:
>   	case PIN_BENCHMARK:
> +	case PIN_LONGTERM_BENCHMARK:
>   		for (i = 0; i < nr_pages; i++) {
>   			page = pages[i];
>   			if (WARN(!page_maybe_dma_pinned(page),
> @@ -101,11 +102,6 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
>   			nr = get_user_pages_fast(addr, nr, gup->flags,
>   						 pages + i);
>   			break;
> -		case GUP_LONGTERM_BENCHMARK:
> -			nr = get_user_pages(addr, nr,
> -					    gup->flags | FOLL_LONGTERM,
> -					    pages + i, NULL);
> -			break;
>   		case GUP_BENCHMARK:
>   			nr = get_user_pages(addr, nr, gup->flags, pages + i,
>   					    NULL);
> @@ -118,6 +114,11 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
>   			nr = pin_user_pages(addr, nr, gup->flags, pages + i,
>   					    NULL);
>   			break;
> +		case PIN_LONGTERM_BENCHMARK:
> +			nr = pin_user_pages(addr, nr,
> +					    gup->flags | FOLL_LONGTERM,
> +					    pages + i, NULL);
> +			break;
>   		default:
>   			kvfree(pages);
>   			ret = -EINVAL;
> @@ -162,10 +163,10 @@ static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
>   
>   	switch (cmd) {
>   	case GUP_FAST_BENCHMARK:
> -	case GUP_LONGTERM_BENCHMARK:
>   	case GUP_BENCHMARK:
>   	case PIN_FAST_BENCHMARK:
>   	case PIN_BENCHMARK:
> +	case PIN_LONGTERM_BENCHMARK:
>   		break;
>   	default:
>   		return -EINVAL;
> diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
> index 43b4dfe161a2..31f8bb086907 100644
> --- a/tools/testing/selftests/vm/gup_benchmark.c
> +++ b/tools/testing/selftests/vm/gup_benchmark.c
> @@ -15,12 +15,12 @@
>   #define PAGE_SIZE sysconf(_SC_PAGESIZE)
>   
>   #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
> -#define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
> -#define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
> +#define GUP_BENCHMARK		_IOWR('g', 2, struct gup_benchmark)
>   
>   /* Similar to above, but use FOLL_PIN instead of FOLL_GET. */
> -#define PIN_FAST_BENCHMARK	_IOWR('g', 4, struct gup_benchmark)
> -#define PIN_BENCHMARK		_IOWR('g', 5, struct gup_benchmark)
> +#define PIN_FAST_BENCHMARK	_IOWR('g', 3, struct gup_benchmark)
> +#define PIN_BENCHMARK		_IOWR('g', 4, struct gup_benchmark)
> +#define PIN_LONGTERM_BENCHMARK	_IOWR('g', 5, struct gup_benchmark)
>   
>   /* Just the flags we need, copied from mm.h: */
>   #define FOLL_WRITE	0x01	/* check pte is writable */
> @@ -52,6 +52,9 @@ int main(int argc, char **argv)
>   		case 'b':
>   			cmd = PIN_BENCHMARK;
>   			break;
> +		case 'L':
> +			cmd = PIN_LONGTERM_BENCHMARK;
> +			break;
>   		case 'm':
>   			size = atoi(optarg) * MB;
>   			break;
> @@ -67,9 +70,6 @@ int main(int argc, char **argv)
>   		case 'T':
>   			thp = 0;
>   			break;
> -		case 'L':
> -			cmd = GUP_LONGTERM_BENCHMARK;
> -			break;
>   		case 'U':
>   			cmd = GUP_BENCHMARK;
>   			break;
> 

