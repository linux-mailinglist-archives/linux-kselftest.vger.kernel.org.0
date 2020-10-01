Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5707D27FA31
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 09:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgJAHY4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Oct 2020 03:24:56 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2002 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJAHYz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Oct 2020 03:24:55 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7584380000>; Thu, 01 Oct 2020 00:24:40 -0700
Received: from [10.2.56.62] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Oct
 2020 07:24:36 +0000
Subject: Re: [PATCH 1/5] kselftests: vm: Add mremap tests
To:     Kalesh Singh <kaleshsingh@google.com>
CC:     <surenb@google.com>, <minchan@google.com>, <joelaf@google.com>,
        <lokeshgidra@google.com>, <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>, Jia He <justin.he@arm.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Zi Yan <ziy@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ram Pai <linuxram@us.ibm.com>,
        "Sandipan Das" <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        Brian Geffon <bgeffon@google.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "SeongJae Park" <sjpark@amazon.de>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
References: <20200930222130.4175584-1-kaleshsingh@google.com>
 <20200930222130.4175584-2-kaleshsingh@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <0dc41856-e406-7f00-1eb9-5e97e476afa4@nvidia.com>
Date:   Thu, 1 Oct 2020 00:24:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200930222130.4175584-2-kaleshsingh@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601537080; bh=KU02b+raxLWH6/MBrWXmT5SF+yrCs8jtMm2nneTyTus=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=ZQYl2hvc1xggUUarMSzvNAMisjtkrQul85SKbqE14jzfevglgYJqSqBhLTVB9oTPT
         Aj2vdHQ+BxNdvmAy4xx2U9IJ0fqLBvX0hq1DUM0yC+fcx6yPXkBfjLVbJOhxsrFZIe
         5MC2Dt9sUrUYbmFijaqmf2VGjjYS6JNsnLozoDR6v9Q5Q12oLEktQg5s6ztKOctZyg
         vudZv6UsekVAgSuFXKw1N2CjTq4STXZLFGJE/QVSogcgDzJQ86qiTtySyMDcT2oRK3
         okYanC/KR5KovVc4qSFJmkQKUgtBT3rgNK3eFBcX7x0vo48ocElcfFkjnZ4aNvNq2v
         G2BAxJTS8jlQw==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/30/20 3:21 PM, Kalesh Singh wrote:
> Test mremap on regions of various sizes and alignments and validate
> data after remapping. Also provide total time for remapping
> the region which is useful for performance comparison of the mremap
> optimizations that move pages at the PMD/PUD levels if HAVE_MOVE_PMD
> and/or HAVE_MOVE_PUD are enabled.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>   tools/testing/selftests/vm/.gitignore    |   1 +
>   tools/testing/selftests/vm/Makefile      |   1 +
>   tools/testing/selftests/vm/mremap_test.c | 243 +++++++++++++++++++++++
>   tools/testing/selftests/vm/run_vmtests   |  11 +
>   4 files changed, 256 insertions(+)
>   create mode 100644 tools/testing/selftests/vm/mremap_test.c
> 

Hi,

This takes 100x longer to run than it should: 1:46 min of running time on
my x86_64 test machine. The entire selftests/vm test suite takes 45 sec on a
bad day, where a bad day is defined as up until about tomorrow, when I will
post a compaction_test.c patch that will cut that time down to about half, or
24 sec total run time...for 22 tests!

In other words, most tests here should take about 1 or 2 seconds, unless they
are exceptionally special snowflakes.

At the very least, the invocation within run_vmtests could pass in a parameter
to tell it to run a shorter test. But there's also opportunities to speed it
up, too.

...
> +
> +#define MAKE_TEST(source_align, destination_align, size,	\
> +		  overlaps, should_fail, test_name)		\
> +{								\
> +	.name = test_name,					\
> +	.config = {						\
> +		.src_alignment = source_align,			\
> +		.dest_alignment = destination_align,		\
> +		.region_size = size,				\
> +		.overlapping = overlaps,			\
> +	},							\
> +	.expect_failure = should_fail				\
> +}
> +

OK...

> +#define MAKE_SIMPLE_TEST(source_align, destination_align, size)	\
> +	MAKE_TEST(source_align, destination_align, size, 0, 0,	\
> +		  #size " mremap - Source " #source_align	\
> +		  " aligned, Destination " #destination_align	\
> +		  " aligned")
> +

...and not OK. :)  Because this is just obscuring things. Both the
code and the output are harder to read. For these tiny test programs,
clarity is what we want, not necessarily compactness on the screen.
Because people want to get in, understand what they seen in the code
and match it up with what is printed to stdout--without spending much
time. (And that includes run time, as hinted at above.)

...
> +
> +/* Returns the time taken for the remap on success else returns -1. */
> +static long long remap_region(struct config c)
> +{
> +	void *addr, *src_addr, *dest_addr;
> +	int i, j;
> +	struct timespec t_start = {0, 0}, t_end = {0, 0};
> +	long long  start_ns, end_ns, align_mask, ret, offset;
> +	char pattern[] = {0xa8, 0xcd, 0xfe};

I'd recommend using rand() to help choose the pattern, and using different
patterns for different runs. When testing memory, it's a pitfall to have
the same test pattern.

Normally, you'd also want to report the random seed or the test pattern(s)
or both to stdout, and provide a way to run with the same pattern, but
here I don't *think* you care: all patterns should have the same performance.

> +	int pattern_size = ARRAY_SIZE(pattern);
> +
> +	src_addr = get_source_mapping(c);
> +	if (!src_addr) {
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	/* Set byte pattern */
> +	for (i = 0; i < c.region_size; i++) {
> +		for (j = 0; i+j < c.region_size && j < pattern_size; j++)
> +			memset((char *) src_addr + i+j, pattern[j], 1);
> +		i += pattern_size-1;
> +	}
> +
> +	align_mask = ~(c.dest_alignment - 1);
> +	offset = (c.overlapping) ? -c.dest_alignment : c.dest_alignment;

A comment for what the above two lines are doing would be a nice touch.

...
> +	start_ns = t_start.tv_sec * 1000000000ULL + t_start.tv_nsec;
> +	end_ns = t_end.tv_sec * 1000000000ULL + t_end.tv_nsec;

A const or #defined for all those 0000's would help.

...
> +int main(int argc, char *argv[])
> +{
> +	int failures = 0;
> +	int i;
> +
> +	struct test test_cases[] = {
> +		/* Expected mremap failures */
> +		MAKE_TEST(_4KB, _4KB, _4KB, 1 /* overlaps */, 1 /* fails */,

Named flags instead of 1's and 0's would avoid the need for messy comments.

> +			  "mremap - Source and Destination Regions Overlapping"),
> +		MAKE_TEST(_4KB, _1KB, _4KB, 0 /* overlaps */, 1 /* fails */,
> +			  "mremap - Destination Address Misaligned (1KB-aligned)"),
> +		MAKE_TEST(_1KB, _4KB, _4KB, 0 /* overlaps */, 1 /* fails */,
> +			  "mremap - Source Address Misaligned (1KB-aligned)"),
> +
> +		/* Src addr PTE aligned */
> +		MAKE_SIMPLE_TEST(PTE, PTE, _8KB),
> +
> +		/* Src addr 1MB aligned */
> +		MAKE_SIMPLE_TEST(_1MB, PTE, _2MB),
> +		MAKE_SIMPLE_TEST(_1MB, _1MB, _2MB),
> +
> +		/* Src addr PMD aligned */
> +		MAKE_SIMPLE_TEST(PMD, PTE, _4MB),
> +		MAKE_SIMPLE_TEST(PMD, _1MB, _4MB),
> +		MAKE_SIMPLE_TEST(PMD, PMD, _4MB),
> +
> +		/* Src addr PUD aligned */
> +		MAKE_SIMPLE_TEST(PUD, PTE, _2GB),
> +		MAKE_SIMPLE_TEST(PUD, _1MB, _2GB),
> +		MAKE_SIMPLE_TEST(PUD, PMD, _2GB),
> +		MAKE_SIMPLE_TEST(PUD, PUD, _2GB),


Too concise. Not fun lining these up with the stdout report.


thanks,
-- 
John Hubbard
NVIDIA
