Return-Path: <linux-kselftest+bounces-10699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1CE8CEFDF
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 17:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E90F1C20C80
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 15:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189FC5A4D8;
	Sat, 25 May 2024 15:41:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3888B83CBD;
	Sat, 25 May 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716651678; cv=none; b=XvnofCERrkAuan3IqcNYN2KCtc2AcW3Pk4qq+Tj281BGQUpgn3mHOE0ONNFHrmwWkUkcBwqCZQhJWgq3enoJpSdAIZCFjFTCA6L0NP5jPGn9jV49/nEjA6LFcbV5H4qIlzi0uiH52dlTeYiCvzbIQqw+XMZCM6XCmlYJEcMfJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716651678; c=relaxed/simple;
	bh=PqizwEOTlFqMpVQuMh/x1K6KlzpBnxyw0yxVInJo3ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2XLdHmBPbR9em+BrlaWiDC7D2v+qiKMhS0m6+102tPzhe+WJCBL1oNp1rDlCcSFmqmGGBQ2UgVIYNWy3vyBYp9uI/EHEmexsAjh7KKVPlpfh53rN8DiXav4vS6wJsnT/ae+TN7JDmaTEbbnpVUq6fjCx28ryUKNkTkzyo5VnDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44PFFVTe001874;
	Sat, 25 May 2024 15:40:47 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dibm.com;_h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3DEoi?=
 =?UTF-8?Q?SA/lg1KnnEE0rSnE06BIpGm2yBnycaH1rnnzfo14=3D;_b=3DEeNhtuH/Evope5?=
 =?UTF-8?Q?47/3FaZ6X7clGCoo2zQ4421fvcHNRObQaHYltH1Gmvb0szZ+PdMqd9_0xIGZRL+?=
 =?UTF-8?Q?TJp4VBowBt/lAqhDnS4KBvCblOwAP46Omd31TQQB9btlZ6rgciXwnllozjLQ_yH?=
 =?UTF-8?Q?OSAzrgmT50mDvSNmWgBEthbnAFhbB1lNAJbqHd2mktF4OtWBuzRYRgCDXFrlejk?=
 =?UTF-8?Q?116_L+SodtdaZ7aTLntNjMTups7+NX9sYOUHT65EixJ/L+h2H0iOVgGRnwjazmm?=
 =?UTF-8?Q?zLQNQDU41_S/BwnscXgZ+IPvhtyoAIVtAEItDqwDsGjU8ZSACAplhZIHJCTFiS0?=
 =?UTF-8?Q?ECBI+kEBlnLZ8o6_CA=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ybhu4g3g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 May 2024 15:40:46 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44PFekcw006159;
	Sat, 25 May 2024 15:40:46 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ybhu4g3g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 May 2024 15:40:46 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44PFZW25030540;
	Sat, 25 May 2024 15:40:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yb8gftpkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 May 2024 15:40:45 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44PFegEb50070138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 May 2024 15:40:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 273085806C;
	Sat, 25 May 2024 15:40:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF6E358052;
	Sat, 25 May 2024 15:40:37 +0000 (GMT)
Received: from [9.179.11.60] (unknown [9.179.11.60])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 May 2024 15:40:37 +0000 (GMT)
Message-ID: <4c7b4ac5-126b-422a-9f6d-f4aef22920b0@linux.ibm.com>
Date: Sat, 25 May 2024 21:10:36 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: mm: Test if hugepage does not get leaked during
 __bio_release_pages()
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>, stable@vger.kernel.org
References: <20240523063905.3173-1-donettom@linux.ibm.com>
 <c94ad517-59c6-461c-98dc-1f1706c76389@collabora.com>
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <c94ad517-59c6-461c-98dc-1f1706c76389@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Md6YDFM6O2epxThMa4Z9O0bS-nnXQhAW
X-Proofpoint-GUID: uFohzGfMM9OkPk_zME6E5lBvInYwayTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-25_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405250127


On 5/24/24 23:43, Muhammad Usama Anjum wrote:
> Thank you for submitting a patch.
>
> On 5/22/24 11:39 PM, Donet Tom wrote:
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
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   tools/testing/selftests/mm/Makefile      |   1 +
>>   tools/testing/selftests/mm/hugetlb_dio.c | 118 +++++++++++++++++++++++
> Add this test to vm_runtest.sh as all the tests are run from this script in
> CIs.
>
>>   2 files changed, 119 insertions(+)
>>   create mode 100644 tools/testing/selftests/mm/hugetlb_dio.c
>>
>> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
>> index eb5f39a2668b..87d8130b3376 100644
>> --- a/tools/testing/selftests/mm/Makefile
>> +++ b/tools/testing/selftests/mm/Makefile
>> @@ -71,6 +71,7 @@ TEST_GEN_FILES += ksm_functional_tests
>>   TEST_GEN_FILES += mdwe_test
>>   TEST_GEN_FILES += hugetlb_fault_after_madv
>>   TEST_GEN_FILES += hugetlb_madv_vs_map
>> +TEST_GEN_FILES += hugetlb_dio
>>   
>>   ifneq ($(ARCH),arm64)
>>   TEST_GEN_FILES += soft-dirty
>> diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
>> new file mode 100644
>> index 000000000000..6f6587c7913c
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
>> +
>> +	writesize = end_off - start_off;
>> +
>> +	/* Get the default huge page size */
>> +	h_pagesize = default_huge_page_size();
>> +	if (!h_pagesize)
>> +		ksft_exit_fail_msg("Unable to determine huge page size\n");
>> +
>> +	/* Open the file to DIO */
>> +	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT);
>> +	if (fd < 0)
>> +		ksft_exit_fail_msg("Error opening file");
> Use ksft_exit_fail_perror to print the info about the error
>> +
>> +	/* Get the free huge pages before allocation */
>> +	free_hpage_b = get_free_hugepages();
>> +	if (free_hpage_b == 0) {
>> +		close(fd);
>> +		ksft_exit_skip("No free hugepage, exiting!\n");
>> +	}
>> +
>> +	/* Allocate a hugetlb page */
>> +	orig_buffer = mmap(NULL, h_pagesize, PROT_READ | PROT_WRITE, MAP_PRIVATE
>> +			| MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
> Better align the arguments. Put all flags in one line instead of slitting
> like this
>
>> +	if (orig_buffer == MAP_FAILED) {
>> +		close(fd);
>> +		ksft_exit_fail_msg("Error mapping memory");
> nit: "\n" is missing from here.
>
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
>> +		ksft_exit_fail_msg("Error writing to file");
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
>> +		printf("No. Free pages before allocation : %d\n", free_hpage_b);
> Use ksft_print_msg instead
>
>> +		printf("No. Free pages after munmap : %d\n", free_hpage_a);
>> +		ksft_test_result_fail(": Huge pages not freed!\n");
>> +	} else {
>> +		printf("No. Free pages before allocation : %d\n", free_hpage_b);
>> +		printf("No. Free pages after munmap : %d\n", free_hpage_a);
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
> ksft_finished() never returns. Remove the following line.

Thank you for all your suggestions.  I will make all the changes and send V2.

Thanks
Donet

>> +	return 0;
>> +}
>> +

