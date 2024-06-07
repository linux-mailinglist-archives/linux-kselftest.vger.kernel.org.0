Return-Path: <linux-kselftest+bounces-11413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7E7900A69
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B459BB23DD4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 16:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593C1154444;
	Fri,  7 Jun 2024 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p4cymL5u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79442A8D;
	Fri,  7 Jun 2024 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777865; cv=none; b=bRbvToNIaWYAnhQT0A7mcI8X1Nu5j0gxbZqlOUJVnYX/bc1WJdwJBjNWpmcPXGJ+he2vufsl3p8Tu3HzEfBUrT0jfTX+YUCGeiUQYPJvoAaPkiOESAEKvvoMJ6wmXwdzlI1fRhvnPoa5cuxlrxgfd+f7llGxJw287qJPHKUKRrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777865; c=relaxed/simple;
	bh=5fcWzP1JtsYTB5bS6Dkag0GNZfkt5dQJ7XznRIahZ1I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oCJb00aWdpOeKHW2vb0pHBCKT/YchrFu8jFMhuje8hp4aQj1q+dc22ACja/4mywA9F1LUkwrgNefZy6idBFBCqooJpsy37EE5dAn168TzwRkf6Sda5zlHDfqlWwEoBiq90l0bDlMKCAPK6rTsvFJT6ooydsWAlgUD9OJMtu8NVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p4cymL5u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457GMi7k001701;
	Fri, 7 Jun 2024 16:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=b+rgx8a9hBlcXWldkZelNn14vmoz8twzTq1om+Gm/2E=;
 b=p4cymL5uiB4uxDrJX6h3k2ONQl4XwvFzuxCNfg8g2Ug6bUJiO59rLNw8B8dxzMUvV+jn
 9aiBVf6keKDkiaKz1+/DmKq3uco6RqXJMDVBdXRpZZjwf8cJLX9qQ4dnRj9BFc2hJYNx
 OawMhqQOjrS9qijY4KvcPt5Sc21U0IqMDEUAIK4YbbGJ/5JUrqL78FO4B+rsg+GR5UqX
 QLN5WGb8nqB1vkMHgzCYfMCkvh2F4DIqS8p3qD1TnO221+1nWHxY1OOZ8Bn2PYrd7Ulz
 JbMclBHERnM27+ymmEZfZnh0DyzuGOkty21fueJnufdKOEG7DViWk/lzjTN2EbDmzKjn cg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ym5ns00cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 16:30:32 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 457GUVJT013214;
	Fri, 7 Jun 2024 16:30:31 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ym5ns00cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 16:30:31 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 457E55s8000790;
	Fri, 7 Jun 2024 16:30:30 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ygdyuhys3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 16:30:30 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 457GUSsv30540050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 16:30:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38B5F5805A;
	Fri,  7 Jun 2024 16:30:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA60F58063;
	Fri,  7 Jun 2024 16:30:22 +0000 (GMT)
Received: from [9.171.64.207] (unknown [9.171.64.207])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Jun 2024 16:30:22 +0000 (GMT)
Message-ID: <9e54991c-3f9b-446c-8825-c0754eca1f90@linux.ibm.com>
Date: Fri, 7 Jun 2024 22:00:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftest: mm: Test if hugepage does not get leaked
 during __bio_release_pages()
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>, p.raghav@samsung.com
References: <20240607055046.138650-1-donettom@linux.ibm.com>
 <5ce292b6-179c-48e0-9079-ea07defbe178@collabora.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <5ce292b6-179c-48e0-9079-ea07defbe178@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UY8ZFngSGD77LIwgvnHQJdedPZBKIOkE
X-Proofpoint-GUID: 9tX7ZUHweZstUjs3SgyarZCo6dKfEqpd
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_10,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2406070122


On 6/7/24 11:53, Muhammad Usama Anjum wrote:
> On 6/7/24 10:50 AM, Donet Tom wrote:
>> Commit 1b151e2435fc ("block: Remove special-casing of compound
>> pages") caused a change in behaviour when releasing the pages
>> if the buffer does not start at the beginning of the page. This
>> was because the calculation of the number of pages to release
>> was incorrect.
>> This was fixed by commit 38b43539d64b ("block: Fix page refcounts
>> for unaligned buffers in __bio_release_pages()").
>>
>> We pin the user buffer during direct I/O writes. If this buffer is a
>> hugepage, bio_release_page() will unpin it and decrement all references
>> and pin counts at ->bi_end_io. However, if any references to the hugepage
>> remain post-I/O, the hugepage will not be freed upon unmap, leading
>> to a memory leak.
>>
>> This patch verifies that a hugepage, used as a user buffer for DIO
>> operations, is correctly freed upon unmapping, regardless of whether
>> the offsets are aligned or unaligned w.r.t page boundary.
>>
>> Test Result  Fail Scenario (Without the fix)
>> --------------------------------------------------------
>> []# ./hugetlb_dio
>> TAP version 13
>> 1..4
>> No. Free pages before allocation : 7
>> No. Free pages after munmap : 7
>> ok 1 : Huge pages freed successfully !
>> No. Free pages before allocation : 7
>> No. Free pages after munmap : 7
>> ok 2 : Huge pages freed successfully !
>> No. Free pages before allocation : 7
>> No. Free pages after munmap : 7
>> ok 3 : Huge pages freed successfully !
>> No. Free pages before allocation : 7
>> No. Free pages after munmap : 6
>> not ok 4 : Huge pages not freed!
>> Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
>>
>> Test Result  PASS Scenario (With the fix)
>> ---------------------------------------------------------
>> []#./hugetlb_dio
>> TAP version 13
>> 1..4
>> No. Free pages before allocation : 7
>> No. Free pages after munmap : 7
>> ok 1 : Huge pages freed successfully !
>> No. Free pages before allocation : 7
>> No. Free pages after munmap : 7
>> ok 2 : Huge pages freed successfully !
>> No. Free pages before allocation : 7
>> No. Free pages after munmap : 7
>> ok 3 : Huge pages freed successfully !
>> No. Free pages before allocation : 7
>> No. Free pages after munmap : 7
>> ok 4 : Huge pages freed successfully !
>> Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
>>
>> V3:
>> - Fixed the build error when it is compiled with _FORTIFY_SOURCE.
>>
>> V2:
>> - Addressed all review commets from Muhammad Usama Anjum
>> https://lore.kernel.org/all/20240604132801.23377-1-donettom@linux.ibm.com/
>>
>> V1:
>> https://lore.kernel.org/all/20240523063905.3173-1-donettom@linux.ibm.com/#t
>>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   tools/testing/selftests/mm/Makefile      |   1 +
>>   tools/testing/selftests/mm/hugetlb_dio.c | 118 +++++++++++++++++++++++
> Missed my feedback on adding the test to vm_test.sh
I was not able to find vm_test.sh file to add this test in selftests/mm. 
could you please help me to get the correct vm_test.sh to add this?

Thanks
Donet
>
> Other than this, LGTM. Please add following tag after the above change:
>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>
>>   2 files changed, 119 insertions(+)
>>   create mode 100644 tools/testing/selftests/mm/hugetlb_dio.c
>>
>> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
>> index 3b49bc3d0a3b..a1748a4c7df1 100644
>> --- a/tools/testing/selftests/mm/Makefile
>> +++ b/tools/testing/selftests/mm/Makefile
>> @@ -73,6 +73,7 @@ TEST_GEN_FILES += ksm_functional_tests
>>   TEST_GEN_FILES += mdwe_test
>>   TEST_GEN_FILES += hugetlb_fault_after_madv
>>   TEST_GEN_FILES += hugetlb_madv_vs_map
>> +TEST_GEN_FILES += hugetlb_dio
>>   
>>   ifneq ($(ARCH),arm64)
>>   TEST_GEN_FILES += soft-dirty
>> diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
>> new file mode 100644
>> index 000000000000..986f3b6c7f7b
>> --- /dev/null
>> +++ b/tools/testing/selftests/mm/hugetlb_dio.c
>> @@ -0,0 +1,118 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * This program tests for hugepage leaks after DIO writes to a file using a
>> + * hugepage as the user buffer. During DIO, the user buffer is pinned and
>> + * should be properly unpinned upon completion. This patch verifies that the
>> + * kernel correctly unpins the buffer at DIO completion for both aligned and
>> + * unaligned user buffer offsets (w.r.t page boundary), ensuring the hugepage
>> + * is freed upon unmapping.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <stdio.h>
>> +#include <sys/stat.h>
>> +#include <stdlib.h>
>> +#include <fcntl.h>
>> +#include <stdint.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <sys/mman.h>
>> +#include "vm_util.h"
>> +#include "../kselftest.h"
>> +
>> +void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
>> +{
>> +	int fd;
>> +	char *buffer =  NULL;
>> +	char *orig_buffer = NULL;
>> +	size_t h_pagesize = 0;
>> +	size_t writesize;
>> +	int free_hpage_b = 0;
>> +	int free_hpage_a = 0;
>> +	const int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB;
>> +	const int mmap_prot  = PROT_READ | PROT_WRITE;
>> +
>> +	writesize = end_off - start_off;
>> +
>> +	/* Get the default huge page size */
>> +	h_pagesize = default_huge_page_size();
>> +	if (!h_pagesize)
>> +		ksft_exit_fail_msg("Unable to determine huge page size\n");
>> +
>> +	/* Open the file to DIO */
>> +	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
>> +	if (fd < 0)
>> +		ksft_exit_fail_perror("Error opening file\n");
>> +
>> +	/* Get the free huge pages before allocation */
>> +	free_hpage_b = get_free_hugepages();
>> +	if (free_hpage_b == 0) {
>> +		close(fd);
>> +		ksft_exit_skip("No free hugepage, exiting!\n");
>> +	}
>> +
>> +	/* Allocate a hugetlb page */
>> +	orig_buffer = mmap(NULL, h_pagesize, mmap_prot, mmap_flags, -1, 0);
>> +	if (orig_buffer == MAP_FAILED) {
>> +		close(fd);
>> +		ksft_exit_fail_perror("Error mapping memory\n");
>> +	}
>> +	buffer = orig_buffer;
>> +	buffer += start_off;
>> +
>> +	memset(buffer, 'A', writesize);
>> +
>> +	/* Write the buffer to the file */
>> +	if (write(fd, buffer, writesize) != (writesize)) {
>> +		munmap(orig_buffer, h_pagesize);
>> +		close(fd);
>> +		ksft_exit_fail_perror("Error writing to file\n");
>> +	}
>> +
>> +	/* unmap the huge page */
>> +	munmap(orig_buffer, h_pagesize);
>> +	close(fd);
>> +
>> +	/* Get the free huge pages after unmap*/
>> +	free_hpage_a = get_free_hugepages();
>> +
>> +	/*
>> +	 * If the no. of free hugepages before allocation and after unmap does
>> +	 * not match - that means there could still be a page which is pinned.
>> +	 */
>> +	if (free_hpage_a != free_hpage_b) {
>> +		ksft_print_msg("No. Free pages before allocation : %d\n", free_hpage_b);
>> +		ksft_print_msg("No. Free pages after munmap : %d\n", free_hpage_a);
>> +		ksft_test_result_fail(": Huge pages not freed!\n");
>> +	} else {
>> +		ksft_print_msg("No. Free pages before allocation : %d\n", free_hpage_b);
>> +		ksft_print_msg("No. Free pages after munmap : %d\n", free_hpage_a);
>> +		ksft_test_result_pass(": Huge pages freed successfully !\n");
>> +	}
>> +}
>> +
>> +int main(void)
>> +{
>> +	size_t pagesize = 0;
>> +
>> +	ksft_print_header();
>> +	ksft_set_plan(4);
>> +
>> +	/* Get base page size */
>> +	pagesize  = psize();
>> +
>> +	/* start and end is aligned to pagesize */
>> +	run_dio_using_hugetlb(0, (pagesize * 3));
>> +
>> +	/* start is aligned but end is not aligned */
>> +	run_dio_using_hugetlb(0, (pagesize * 3) - (pagesize / 2));
>> +
>> +	/* start is unaligned and end is aligned */
>> +	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3));
>> +
>> +	/* both start and end are unaligned */
>> +	run_dio_using_hugetlb(pagesize / 2, (pagesize * 3) + (pagesize / 2));
>> +
>> +	ksft_finished();
>> +}
>> +

