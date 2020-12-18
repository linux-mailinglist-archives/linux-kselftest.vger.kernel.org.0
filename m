Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DEE2DE03E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 10:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgLRJGx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 04:06:53 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15234 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgLRJGw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 04:06:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fdc71040000>; Fri, 18 Dec 2020 01:06:12 -0800
Received: from [10.2.61.104] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Dec
 2020 09:06:06 +0000
Subject: Re: [PATCH v4 09/10] selftests/vm: test flag is broken
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
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-10-pasha.tatashin@soleen.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <8879f12c-2aed-1615-1298-7cf9596acc95@nvidia.com>
Date:   Fri, 18 Dec 2020 01:06:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201217185243.3288048-10-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608282372; bh=5277vShgfxIqxzMFqL87T3EXD/MyoKA02zbxyfLRTE0=;
        h=Subject:To:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=ic6JlVIJztt/t4Moauhx/uH2QghTWoWzBKdcIerJyhSHODgSfWjSqcCtKEuQkg3Ie
         psMcozOGsmYlArtg98/s5pacZre1ejOQcU4lxkI6TbeinhlNrV3iIQcjkIJDScT8ja
         hDQlR7mkmG5/WhDX/ks3bbwM95sOYodbwyE0JhcY9wALe+GoA43py5Ue0Vsb+Gdkcv
         EjxULMTn0yDpoIw9kquyVYXnsobOZ4WRyCjqfn6fcQrYGgdIEtrmpDDhJvpeC9QBSO
         wEzgBoFystxRLmP+G/UI5e8r6IGemsThPIBZj5YflqRVC2RBYJS7ZNo7xTpsEZS4d4
         ytsQsHQ1KO+8g==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/17/20 10:52 AM, Pavel Tatashin wrote:
> In gup_test both gup_flags and test_flags use the same flags field.
> This is broken, because gup_flags can be passed as raw value (via -F hex),
> which can overwrite all the test flags.

Thanks for finding and fixing the "stuck at 0x1" bug!

The test is not quite as broken as you think, though, because you're not
looking at the history and intent of the FOLL_WRITE, and how that is used.
And that is leading you to make wider "fixes" than I'd recommend.

The new -F command line switch is the latest, newest (and therefore
flakiest) addition, and  *that* part is worth fixing up, because in
addition to being stuck at 0x1 as you noticed, it also misleads everyone
into thinking that it's intended for general gup flags. It's not.

It really was meant to be a subtest control flag (controlling the behavior
of the dump pages sub-test), as you can see in the commit log and documentation:

     For example:

         ./gup_test -ct -F 1 0 19 0x1000

     Meaning:
         -c:          dump pages sub-test
         -t:          use THP pages
         -F 1:        use pin_user_pages() instead of get_user_pages()
         0 19 0x1000: dump pages 0, 19, and 4096


> 
> Farther, in the actual gup_test.c all the passed gup_flags are erased and
> unconditionally replaced with FOLL_WRITE.

This is still desirable; Kirill's original intention of only allowing
FOLL_WRITE or nothing is still what we want. There is no desire to pass
in general gup_flags.

> 
> Which means that test_flags are ignored, and code like this always
> performs pin dump test:
> 
> 155  			if (gup->flags & GUP_TEST_FLAG_DUMP_PAGES_USE_PIN)
> 156  				nr = pin_user_pages(addr, nr, gup->flags,
> 157  						    pages + i, NULL);
> 158  			else
> 159  				nr = get_user_pages(addr, nr, gup->flags,
> 160  						    pages + i, NULL);
> 161  			break;
> 
> Add a new test_flags field, to allow raw gup_flags to work.

I think .test_control_flags field would be a good name, to make it very
clear that it's not destined for gup_flags. Just .test_flags is not quite
as clear a distinction from .gup_flags, as .test_control_flags is, IMHO.

> Add a new subcommand for DUMP_USER_PAGES_TEST to specify that pin test
> should be performed.

It's arguably better to just keep using the -c option instead, plus the new
.test_control_flags field. Otherwise you get a multiplication of possibilities
(and therefore, of command line options).

> Remove  unconditional overwriting of gup_flags via FOLL_WRITE. But,

Nope, let's not do that.

> preserve the previous behaviour where FOLL_WRITE was the default flag,
> and add a new option "-W" to unset FOLL_WRITE.

Or that either.

> 
> With the fix, dump works like this:
> 
> root@virtme:/# gup_test  -c
> ---- page #0, starting from user virt addr: 0x7f8acb9e4000
> page:00000000d3d2ee27 refcount:2 mapcount:1 mapping:0000000000000000
> index:0x0 pfn:0x100bcf
> anon flags: 0x300000000080016(referenced|uptodate|lru|swapbacked)
> raw: 0300000000080016 ffffd0e204021608 ffffd0e208df2e88 ffff8ea04243ec61
> raw: 0000000000000000 0000000000000000 0000000200000000 0000000000000000
> page dumped because: gup_test: dump_pages() test
> DUMP_USER_PAGES_TEST: done
> 
> root@virtme:/# gup_test  -c -p
> ---- page #0, starting from user virt addr: 0x7fd19701b000
> page:00000000baed3c7d refcount:1025 mapcount:1 mapping:0000000000000000
> index:0x0 pfn:0x108008
> anon flags: 0x300000000080014(uptodate|lru|swapbacked)
> raw: 0300000000080014 ffffd0e204200188 ffffd0e205e09088 ffff8ea04243ee71
> raw: 0000000000000000 0000000000000000 0000040100000000 0000000000000000
> page dumped because: gup_test: dump_pages() test
> DUMP_USER_PAGES_TEST: done
> 
> Refcount shows the difference between pin vs no-pin case.
> Also change type of nr from int to long, as it counts number of pages.

Why? Is there a bug? gup only handles int sized amounts of pages so this
is just adding to the churn, yes?

> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>   mm/gup_test.c                         |  9 +++------
>   mm/gup_test.h                         |  1 +
>   tools/testing/selftests/vm/gup_test.c | 11 +++++++++--
>   3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/gup_test.c b/mm/gup_test.c
> index e3cf78e5873e..24c70c5814ba 100644
> --- a/mm/gup_test.c
> +++ b/mm/gup_test.c
> @@ -94,7 +94,7 @@ static int __gup_test_ioctl(unsigned int cmd,
>   {
>   	ktime_t start_time, end_time;
>   	unsigned long i, nr_pages, addr, next;
> -	int nr;
> +	long nr;
>   	struct page **pages;
>   	int ret = 0;
>   	bool needs_mmap_lock =
> @@ -126,9 +126,6 @@ static int __gup_test_ioctl(unsigned int cmd,
>   			nr = (next - addr) / PAGE_SIZE;
>   		}
>   
> -		/* Filter out most gup flags: only allow a tiny subset here: */
> -		gup->flags &= FOLL_WRITE;
> -
>   		switch (cmd) {
>   		case GUP_FAST_BENCHMARK:
>   			nr = get_user_pages_fast(addr, nr, gup->flags,
> @@ -152,7 +149,7 @@ static int __gup_test_ioctl(unsigned int cmd,
>   					    pages + i, NULL);
>   			break;
>   		case DUMP_USER_PAGES_TEST:
> -			if (gup->flags & GUP_TEST_FLAG_DUMP_PAGES_USE_PIN)
> +			if (gup->test_flags & GUP_TEST_FLAG_DUMP_PAGES_USE_PIN)
>   				nr = pin_user_pages(addr, nr, gup->flags,
>   						    pages + i, NULL);
>   			else
> @@ -187,7 +184,7 @@ static int __gup_test_ioctl(unsigned int cmd,
>   
>   	start_time = ktime_get();
>   
> -	put_back_pages(cmd, pages, nr_pages, gup->flags);
> +	put_back_pages(cmd, pages, nr_pages, gup->test_flags);
>   
>   	end_time = ktime_get();
>   	gup->put_delta_usec = ktime_us_delta(end_time, start_time);
> diff --git a/mm/gup_test.h b/mm/gup_test.h
> index 90a6713d50eb..b1b376b5d3b2 100644
> --- a/mm/gup_test.h
> +++ b/mm/gup_test.h
> @@ -22,6 +22,7 @@ struct gup_test {
>   	__u64 size;
>   	__u32 nr_pages_per_call;
>   	__u32 flags;
> +	__u32 test_flags;
>   	/*
>   	 * Each non-zero entry is the number of the page (1-based: first page is
>   	 * page 1, so that zero entries mean "do nothing") from the .addr base.
> diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
> index 6c6336dd3b7f..42c71483729f 100644
> --- a/tools/testing/selftests/vm/gup_test.c
> +++ b/tools/testing/selftests/vm/gup_test.c
> @@ -37,13 +37,13 @@ int main(int argc, char **argv)
>   {
>   	struct gup_test gup = { 0 };
>   	unsigned long size = 128 * MB;
> -	int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 0;
> +	int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 1;

Let's leave that alone, as noted above.

>   	unsigned long cmd = GUP_FAST_BENCHMARK;
>   	int flags = MAP_PRIVATE;
>   	char *file = "/dev/zero";
>   	char *p;
>   
> -	while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwSH")) != -1) {
> +	while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHp")) != -1) {

And also as noted above I don't think we need this or any of the remaining
hunks below.

>   		switch (opt) {
>   		case 'a':
>   			cmd = PIN_FAST_BENCHMARK;
> @@ -65,6 +65,10 @@ int main(int argc, char **argv)
>   			 */
>   			gup.which_pages[0] = 1;
>   			break;
> +		case 'p':
> +			/* works only with DUMP_USER_PAGES_TEST */
> +			gup.test_flags |= GUP_TEST_FLAG_DUMP_PAGES_USE_PIN;
> +			break;
>   		case 'F':
>   			/* strtol, so you can pass flags in hex form */
>   			gup.flags = strtol(optarg, 0, 0);
> @@ -93,6 +97,9 @@ int main(int argc, char **argv)
>   		case 'w':
>   			write = 1;
>   			break;
> +		case 'W':
> +			write = 0;
> +			break;
>   		case 'f':
>   			file = optarg;
>   			break;
> 

thanks,
-- 
John Hubbard
NVIDIA
