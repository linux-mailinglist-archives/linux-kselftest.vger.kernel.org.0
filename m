Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A6E2DED5F
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Dec 2020 06:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgLSF6b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Dec 2020 00:58:31 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13136 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgLSF6b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Dec 2020 00:58:31 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fdd965d0000>; Fri, 18 Dec 2020 21:57:49 -0800
Received: from [10.2.61.104] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 19 Dec
 2020 05:57:39 +0000
Subject: Re: [PATCH v4 10/10] selftests/vm: test faulting in kernel, and
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
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-11-pasha.tatashin@soleen.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <75b6fb52-ef2c-e17b-2e43-45be913c6206@nvidia.com>
Date:   Fri, 18 Dec 2020 21:57:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201217185243.3288048-11-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608357469; bh=Urx3UezC1NjgOhw5LWwZ9F3J/vnzK66k9zUaY4YSWKw=;
        h=Subject:To:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=j6tQEZEJiZS/RosK7ErXKTFAMQWo6cywzabZ83sukknMF2Q/sgvgF/juy9/aMxbr2
         9hngN1/K/rZ3BthNx3cwg3sdo+exR62cJ192z/cZ1XmhBqiZbQuB3rpChfQqedSe9P
         AWVhHkU7NRPlsjdpuZxu2qLXt4TqaHwbuzsXxEVyow6B+qyj7oChAn+EA0IGOxYuPf
         TzWaLrt31vB39APljjskVuPr83QiPB4kKnkXQN+HiaMH+zqDlBTo/qYez6hCpWlvfP
         KbKn0pZ4KM+xfdffe9KIEID31zLhSTat9NcC9Xi5sHD4/NmJHmmh9Ov0W9IOA3kWwZ
         1q0aR4sd3NMuQ==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/17/20 10:52 AM, Pavel Tatashin wrote:
 >

Hi Pavel,

This all looks good pretty good to me, with just a couple of minor
doubts interleaved with the documentation tweaks:

a) I'm not yet sure if the is_pinnable_page() concept is a keeper. If it's
not for some reason, then we should revisit this patch.

b) I don't yet understand why FOLL_TOUCH from gup/pup is a critical part
of the test.


> When pages are pinned they can be faulted in userland and migrated, and
> they can be faulted right in kernel without migration.
> 
> In either case, the pinned pages must end-up being pinnable (not movable).

Let's delete the above two sentences, which are confusing as currently
worded, and just keep approximately the last sentence below.

> 
> Add a new test without touching pages in userland, and use FOLL_TOUCH
> instead. Also, verify that pinned pages are pinnable.

Maybe this instead:

Add a new test to gup_test, to verify that only "pinnable" pages are
pinned. Also, use gup/pup + FOLL_TOUCH to fault in the pages, rather
than faulting them in from user space.


?  But I don't know why that second point is important. Is it actually
important in order to have a valid test? If so, why?


> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>   mm/gup_test.c                         |  6 ++++++
>   tools/testing/selftests/vm/gup_test.c | 17 +++++++++++++----
>   2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/gup_test.c b/mm/gup_test.c
> index 24c70c5814ba..24fd542091ee 100644
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
> index 42c71483729f..f08cc97d424d 100644
> --- a/tools/testing/selftests/vm/gup_test.c
> +++ b/tools/testing/selftests/vm/gup_test.c
> @@ -13,6 +13,7 @@
>   
>   /* Just the flags we need, copied from mm.h: */
>   #define FOLL_WRITE	0x01	/* check pte is writable */
> +#define FOLL_TOUCH	0x02	/* mark page accessed */


Aha, now I see why you wanted to pass other GUP flags, in the previous
patch. I think it's OK to pass this set of possible flags (as
.gup_flags) through ioctl, yes.

However (this is about the previous patch), I *think* we're better off
leaving the gup_test behavior as: "default is read-only pages, but you
can pass in -w to specify FOLL_WRITE". As opposed to passing in raw
flags from the command line. And yes, I realize that my -F option seemed
to recommand the latter...I'm regretting that -F approach now.

The other direction to go might be to stop doing that, and shift over to
just let the user specify FOLL_* flags directly on the command line, but
IMHO there's no need for that (yet), and it's a little less error-prone
to constrain it.

This leads to: change the "-F 1", to some other better-named option,
perhaps. Open to suggestion there.


>   
>   static char *cmd_to_str(unsigned long cmd)
>   {
> @@ -39,11 +40,11 @@ int main(int argc, char **argv)
>   	unsigned long size = 128 * MB;
>   	int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 1;
>   	unsigned long cmd = GUP_FAST_BENCHMARK;
> -	int flags = MAP_PRIVATE;
> +	int flags = MAP_PRIVATE, touch = 0;


Silly nit, can we put it on its own line? This pre-existing mess of
declarations makes it hard to read everything. One item per line is
easier on the reader, who is often just looking for a single item at a
time. Actually why not rename it slightly while we're here (see below),
maybe to this:

	int use_foll_touch = 0;


>   	char *file = "/dev/zero";
>   	char *p;
>   
> -	while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHp")) != -1) {
> +	while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHpz")) != -1) {

Yes, this seems worth its own command line option.

>   		switch (opt) {
>   		case 'a':
>   			cmd = PIN_FAST_BENCHMARK;
> @@ -110,6 +111,10 @@ int main(int argc, char **argv)
>   		case 'H':
>   			flags |= (MAP_HUGETLB | MAP_ANONYMOUS);
>   			break;
> +		case 'z':
> +			/* fault pages in gup, do not fault in userland */

How about:
			/*
			 * Use gup/pup(FOLL_TOUCH), *instead* of faulting
			 * pages in from user space.
			 */
			use_foll_touch = 1;

> +			touch = 1;
> +			break;
>   		default:
>   			return -1;
>   		}
> @@ -167,8 +172,12 @@ int main(int argc, char **argv)
>   	else if (thp == 0)
>   		madvise(p, size, MADV_NOHUGEPAGE);
>   
> -	for (; (unsigned long)p < gup.addr + size; p += PAGE_SIZE)
> -		p[0] = 0;
> +	if (touch) {
> +		gup.flags |= FOLL_TOUCH;
> +	} else {
> +		for (; (unsigned long)p < gup.addr + size; p += PAGE_SIZE)
> +			p[0] = 0;
> +	}

OK.

>   
>   	/* Only report timing information on the *_BENCHMARK commands: */
>   	if ((cmd == PIN_FAST_BENCHMARK) || (cmd == GUP_FAST_BENCHMARK) ||
> 

thanks,
-- 
John Hubbard
NVIDIA
