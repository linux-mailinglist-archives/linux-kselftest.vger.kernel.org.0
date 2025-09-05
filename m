Return-Path: <linux-kselftest+bounces-40829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962D7B45668
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 13:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F07E3AB9D8
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 11:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0B22F60A6;
	Fri,  5 Sep 2025 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V+FBCz9d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D692F6589
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Sep 2025 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072025; cv=none; b=Wy9EOOHBndF7CDxf/8yDQzbxOR8Vnb21VCcF4DceFWEyUcA6fK79+C1jBP0TiXIRS0e0L6cLwJuODqoe/cchnOpoHdjxQtLxPnssEIgrpfOvkVNtSAeSUK+rTXdpPtIPjf+YxC5qqTbRuzmCFdrt/1il6bdZgdjKZmcZSI4F3VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072025; c=relaxed/simple;
	bh=Grifnp/bSQ98GlLpqH82t0J5KGMKqHI5iWCBYh7zjGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZJuxnO34pCFgAhm/5oe+L0Wt/MmjBlMs/dfkT5EvzeVLiT99QGV9t9GZaRaP0aQLE491E91Tl0mOKrVUOM9jbSKJHtZgnx0AE/IIApwQtoILRgQeuw/Ehh1qYKB2sYRhKEMrJN/1UGCfF3t6iuAuASapEOqNgIe1tymSYomqrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V+FBCz9d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58589IJF019529;
	Fri, 5 Sep 2025 11:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wuqAiS
	qtLVM8nYlBBnd8XevOVCLvFHPidvOeUB3qxmk=; b=V+FBCz9dLmydZbqUnqc4u6
	OGtKTX3QTjSCrgFTksmkRTxc5JRwocrSkWR1iqPRff3qmR8KsM0GGYNQaq1WMHWE
	4VJkWyabsW9ijZLJm3Wa7Q/ANmJeP0Nffk8L/Jl9rN1L7DHvoTZ+ccKZoKEmkgUo
	9YaRLLIt251URfnEk7Qdom0vePs41hp6eZDkaRASAE0F/8fP6eorre9LOsNAcuPc
	e3n/UezskFAW3IjKcQqHpO0KpE6Gp4NJjVFKHpqJ3ectgTRGMxdCG5nvUzgH/nxs
	cPRlG2vCwiZQkXalIUY5pvdVD4X2a4GtmCkb6YR7hyEo3Q1NRc9/uX7PAf8Yl5lw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuaf8at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 11:33:32 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585BTLjZ016017;
	Fri, 5 Sep 2025 11:33:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuaf8ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 11:33:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5858Td2Q017206;
	Fri, 5 Sep 2025 11:33:31 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vc111cu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 11:33:31 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585BXVuK28050038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 11:33:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29EA758056;
	Fri,  5 Sep 2025 11:33:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E259258052;
	Fri,  5 Sep 2025 11:33:27 +0000 (GMT)
Received: from [9.124.222.158] (unknown [9.124.222.158])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Sep 2025 11:33:27 +0000 (GMT)
Message-ID: <720957f8-c50e-428e-952a-9616e9f610b8@linux.ibm.com>
Date: Fri, 5 Sep 2025 17:03:26 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: refactore split_huge_page_test with
 kselftest_harness
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20250905032431.22179-1-richard.weiyang@gmail.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250905032431.22179-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1n8ydgr1RQSo2E8Wcte-1xW2ijL9c3yX
X-Authority-Analysis: v=2.4 cv=U6uSDfru c=1 sm=1 tr=0 ts=68baca8c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=SRrdq9N9AAAA:8
 a=jg8RuVlbUl2dRGeAeboA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX8obBNwoIi9WF
 cNV8o2ghVjSgwf/d55i7UQyu/plyfX0CWjT49PrnD0MxJqnihR1646E99FpMUCXtNoj0ksDH3nO
 U6PX+fhGUIw8gPtMDWPyrb0JFwULMKPq05GrwzXuxD2CkA213yH4e2DBbAFVAjGY68xAp49YONy
 39AFJBPQ1cAgI34hBK6bfZMqdOHNRMCJ1IbwGUN5xjjKMexd5Vq7TqmZoVNJJjwI/1Kwas8Cyd9
 I4vjrtzH62KeLI8SNXuxlDQShyETJgQX732haFvFX0ReSOtv6TGSiTCe8rCao8DZJChBHQWdgAs
 xF5x7rFI5mASaO6NsLai1K4m3bjg4raqVEj6dhoyJyI7MLOUFIdHuh9pxFjEohX3A+m2Hpfvmi6
 uzG3MPJC
X-Proofpoint-ORIG-GUID: CEfrRqEcKTcjIBy_KCv3EtMvmWn9ndaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034


On 9/5/25 8:54 AM, Wei Yang wrote:
> Refactor split_huge_page_test with kselftest_harness, since there is a
> magic counting about valid tests.
>
> The idea is simple:
>
> For standalone test, put it into TEST().
>
> For tests iterating order/offset, define fixture and variant with
> order and offset. And skip it if order/offset is not valid.
>
> No functional change is expected.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Donet Tom <donettom@linux.ibm.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   .../selftests/mm/split_huge_page_test.c       | 308 ++++++++++++++----
>   1 file changed, 238 insertions(+), 70 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 7731191cc8e9..2376c3530b26 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -20,14 +20,16 @@
>   #include <stdbool.h>
>   #include <time.h>
>   #include "vm_util.h"
> -#include "../kselftest.h"
> +#include "../kselftest_harness.h"
>   
>   uint64_t pagesize;
> -unsigned int pageshift;
>   uint64_t pmd_pagesize;
>   unsigned int pmd_order;
>   int *expected_orders;
>   
> +char *optional_xfs_path;
> +char fs_loc_template[] = "/tmp/thp_fs_XXXXXX";
> +
>   #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
>   #define SMAP_PATH "/proc/self/smaps"
>   #define INPUT_MAX 80
> @@ -41,6 +43,20 @@ const char *kpageflags_proc = "/proc/kpageflags";
>   int pagemap_fd;
>   int kpageflags_fd;
>   
> +#define ADD_VARIANT_ORDER(fixture_name, ord)			\
> +	FIXTURE_VARIANT_ADD(fixture_name, order_##ord)		\
> +	{							\
> +		.order = ord,					\
> +	}
> +
> +#define ADD_VARIANT_ORDER_OFFSET(fixture_name, ord, stp)		\
> +	FIXTURE_VARIANT_ADD(fixture_name, order_##ord##_stp_##stp)	\
> +	{								\
> +		.order = ord,						\
> +		.step = stp,						\
> +	}
> +
> +
>   static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
>   		int kpageflags_fd)
>   {
> @@ -255,6 +271,26 @@ static int check_after_split_folio_orders(char *vaddr_start, size_t len,
>   	return status;
>   }
>   
> +void prepare_proc_fd(void)
> +{
> +	pagemap_fd = open(pagemap_proc, O_RDONLY);
> +	if (pagemap_fd == -1)
> +		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
> +
> +	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
> +	if (kpageflags_fd == -1)
> +		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
> +}
> +
> +void cleanup_proc_fd(void)
> +{
> +	if (pagemap_fd != -1)
> +		close(pagemap_fd);
> +
> +	if (kpageflags_fd != -1)
> +		close(kpageflags_fd);
> +}
> +
>   static void write_file(const char *path, const char *buf, size_t buflen)
>   {
>   	int fd;
> @@ -292,10 +328,8 @@ static char *allocate_zero_filled_hugepage(size_t len)
>   	size_t i;
>   
>   	result = memalign(pmd_pagesize, len);
> -	if (!result) {
> -		printf("Fail to allocate memory\n");
> -		exit(EXIT_FAILURE);
> -	}
> +	if (!result)
> +		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
>   
>   	madvise(result, len, MADV_HUGEPAGE);
>   
> @@ -334,16 +368,19 @@ static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hp
>   		       rss_anon_before, rss_anon_after);
>   }
>   
> -static void split_pmd_zero_pages(void)
> +TEST(split_pmd_zero_pages)
>   {
>   	char *one_page;
>   	int nr_hpages = 4;
>   	size_t len = nr_hpages * pmd_pagesize;
>   
> +	prepare_proc_fd();
> +
>   	one_page = allocate_zero_filled_hugepage(len);
>   	verify_rss_anon_split_huge_page_all_zeroes(one_page, nr_hpages, len);
> -	ksft_test_result_pass("Split zero filled huge pages successful\n");
>   	free(one_page);
> +
> +	cleanup_proc_fd();
>   }
>   
>   static void split_pmd_thp_to_order(int order)
> @@ -383,11 +420,10 @@ static void split_pmd_thp_to_order(int order)
>   	if (!check_huge_anon(one_page, 0, pmd_pagesize))
>   		ksft_exit_fail_msg("Still AnonHugePages not split\n");
>   
> -	ksft_test_result_pass("Split huge pages to order %d successful\n", order);
>   	free(one_page);
>   }
>   
> -static void split_pte_mapped_thp(void)
> +TEST(split_pte_mapped_thp)
>   {
>   	const size_t nr_thps = 4;
>   	const size_t thp_area_size = nr_thps * pmd_pagesize;
> @@ -395,6 +431,8 @@ static void split_pte_mapped_thp(void)
>   	char *thp_area, *tmp, *page_area = MAP_FAILED;
>   	size_t i;
>   
> +	prepare_proc_fd();
> +
>   	thp_area = mmap((void *)(1UL << 30), thp_area_size, PROT_READ | PROT_WRITE,
>   			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>   	if (thp_area == MAP_FAILED) {
> @@ -470,14 +508,43 @@ static void split_pte_mapped_thp(void)
>   		ksft_test_result_fail("THP %zu not split\n", i);
>   	}
>   
> -	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
>   out:
>   	munmap(thp_area, thp_area_size);
>   	if (page_area != MAP_FAILED)
>   		munmap(page_area, page_area_size);
> +	cleanup_proc_fd();
> +}
> +
> +FIXTURE(split_file_backed_thp) {
> +};
> +
> +FIXTURE_VARIANT(split_file_backed_thp) {
> +	int order;
> +};
> +
> +FIXTURE_SETUP(split_file_backed_thp)
> +{
> +	if (variant->order >= pmd_order)
> +		SKIP(return, "order %d is not supported", variant->order);
> +	prepare_proc_fd();
> +}
> +
> +FIXTURE_TEARDOWN(split_file_backed_thp)
> +{
> +	cleanup_proc_fd();
>   }
>   
> -static void split_file_backed_thp(int order)
> +ADD_VARIANT_ORDER(split_file_backed_thp, 0);
> +ADD_VARIANT_ORDER(split_file_backed_thp, 1);
> +ADD_VARIANT_ORDER(split_file_backed_thp, 2);
> +ADD_VARIANT_ORDER(split_file_backed_thp, 3);
> +ADD_VARIANT_ORDER(split_file_backed_thp, 4);
> +ADD_VARIANT_ORDER(split_file_backed_thp, 5);
> +ADD_VARIANT_ORDER(split_file_backed_thp, 6);
> +ADD_VARIANT_ORDER(split_file_backed_thp, 7);
> +ADD_VARIANT_ORDER(split_file_backed_thp, 8);
> +
> +TEST_F(split_file_backed_thp, orders)
>   {
>   	int status;
>   	int fd;
> @@ -487,7 +554,7 @@ static void split_file_backed_thp(int order)
>   	ssize_t num_written, num_read;
>   	char *file_buf1, *file_buf2;
>   	uint64_t pgoff_start = 0, pgoff_end = 1024;
> -	int i;
> +	int i, order = variant->order;
>   
>   	ksft_print_msg("Please enable pr_debug in split_huge_pages_in_file() for more info.\n");
>   
> @@ -567,7 +634,6 @@ static void split_file_backed_thp(int order)
>   		ksft_exit_fail_msg("cannot remove tmp dir: %s\n", strerror(errno));
>   
>   	ksft_print_msg("Please check dmesg for more information\n");
> -	ksft_test_result_pass("File-backed THP split to order %d test done\n", order);
>   	return;
>   
>   close_file:
> @@ -579,6 +645,45 @@ static void split_file_backed_thp(int order)
>   	ksft_exit_fail_msg("Error occurred\n");
>   }
>   
> +FIXTURE(split_pmd_thp_to_order) {
> +};
> +
> +FIXTURE_VARIANT(split_pmd_thp_to_order) {
> +	int order;
> +};
> +
> +FIXTURE_SETUP(split_pmd_thp_to_order)
> +{
> +	if (variant->order >= pmd_order)
> +		SKIP(return, "order %d is not supported", variant->order);


On a 64 KB page size system, the page order is 5, so the remaining tests
are getting skipped. On such systems, these tests are effectively invalid.
Instead of skipping them, would it be better to simply not account those 
tests?

  # PASSED: 64 / 64 tests passed.
  # 30 skipped test(s) detected. Consider enabling relevant config 
options to improve coverage.
  # Totals: pass:34 fail:0 xfail:0 xpass:0 skip:30 error:0


Here, the 30 skipped tests are invalid, and the total valid tests are 34.
Would it make sense to exclude the 30 invalid tests entirely for 64KB 
page size systems?


> +
> +	expected_orders = (int *)malloc(sizeof(int) * (pmd_order + 1));
> +	if (!expected_orders)
> +		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
> +
> +	prepare_proc_fd();
> +}
> +
> +FIXTURE_TEARDOWN(split_pmd_thp_to_order)
> +{
> +	free(expected_orders);
> +	cleanup_proc_fd();
> +}
> +
> +ADD_VARIANT_ORDER(split_pmd_thp_to_order, 0);
> +ADD_VARIANT_ORDER(split_pmd_thp_to_order, 2);
> +ADD_VARIANT_ORDER(split_pmd_thp_to_order, 3);
> +ADD_VARIANT_ORDER(split_pmd_thp_to_order, 4);
> +ADD_VARIANT_ORDER(split_pmd_thp_to_order, 5);
> +ADD_VARIANT_ORDER(split_pmd_thp_to_order, 6);
> +ADD_VARIANT_ORDER(split_pmd_thp_to_order, 7);
> +ADD_VARIANT_ORDER(split_pmd_thp_to_order, 8);
> +
> +TEST_F(split_pmd_thp_to_order, order)
> +{
> +	split_pmd_thp_to_order(variant->order);
> +}
> +
>   static bool prepare_thp_fs(const char *xfs_path, char *thp_fs_template,
>   		const char **thp_fs_loc)
>   {
> @@ -757,81 +862,144 @@ static void split_thp_in_pagecache_to_order_at(size_t fd_size,
>   	}
>   }
>   
> -int main(int argc, char **argv)
> -{
> -	int i;
> -	size_t fd_size;
> -	char *optional_xfs_path = NULL;
> -	char fs_loc_template[] = "/tmp/thp_fs_XXXXXX";
> +FIXTURE(split_thp_in_pagecache_to_order) {
> +	bool created_tmp;
>   	const char *fs_loc;
> +};
> +
> +FIXTURE_VARIANT(split_thp_in_pagecache_to_order) {
> +	int order;
> +};
> +
> +FIXTURE_SETUP(split_thp_in_pagecache_to_order)
> +{
> +	/* limit order to less than pmd_order */
> +	if (variant->order >= pmd_order)
> +		SKIP(return, "order %d is not supported", variant->order);
> +	expected_orders = (int *)malloc(sizeof(int) * (pmd_order + 1));
> +	if (!expected_orders)
> +		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
> +
> +	self->created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
> +					&self->fs_loc);
> +	prepare_proc_fd();
> +}
> +
> +FIXTURE_TEARDOWN(split_thp_in_pagecache_to_order)
> +{
> +	cleanup_proc_fd();
> +	cleanup_thp_fs(self->fs_loc, self->created_tmp);
> +	free(expected_orders);
> +}
> +
> +ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 8);
> +ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 7);
> +ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 6);
> +ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 5);
> +ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 4);
> +ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 3);
> +ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 2);
> +ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 1);
> +ADD_VARIANT_ORDER(split_thp_in_pagecache_to_order, 0);
> +
> +TEST_F(split_thp_in_pagecache_to_order, order)
> +{
> +	size_t fd_size = 2 * pmd_pagesize;
> +
> +	split_thp_in_pagecache_to_order_at(fd_size, self->fs_loc, variant->order, -1);
> +}
> +
> +FIXTURE(split_thp_in_pagecache_to_order_offset) {
>   	bool created_tmp;
> +	const char *fs_loc;
>   	int offset;
> -	unsigned int nr_pages;
> -	unsigned int tests;
> +};
>   
> -	ksft_print_header();
> +FIXTURE_VARIANT(split_thp_in_pagecache_to_order_offset) {
> +	int order;
> +	int step;
> +};
>   
> -	if (geteuid() != 0) {
> -		ksft_print_msg("Please run the benchmark as root\n");
> -		ksft_finished();
> -	}
> -
> -	if (argc > 1)
> -		optional_xfs_path = argv[1];
> +FIXTURE_SETUP(split_thp_in_pagecache_to_order_offset)
> +{
> +	int nr_pages = pmd_pagesize / pagesize;
> +	int offset = variant->step * MAX(nr_pages / 4, 1 << variant->order);
>   
> -	pagesize = getpagesize();
> -	pageshift = ffs(pagesize) - 1;
> -	pmd_pagesize = read_pmd_pagesize();
> -	if (!pmd_pagesize)
> -		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
> +	/* limit order to less than pmd_order */
> +	if (variant->order >= pmd_order)
> +		SKIP(return, "order %d is not supported", variant->order);
>   
> -	nr_pages = pmd_pagesize / pagesize;
> -	pmd_order = sz2ord(pmd_pagesize, pagesize);
> +	if (offset < nr_pages)
> +		self->offset = offset;
> +	else
> +		SKIP(return, "offset out of thp range");
>   
>   	expected_orders = (int *)malloc(sizeof(int) * (pmd_order + 1));
>   	if (!expected_orders)
>   		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
>   
> -	tests = 2 + (pmd_order - 1) + (2 * pmd_order) + (pmd_order - 1) * 4 + 2;
> -	ksft_set_plan(tests);
> -
> -	pagemap_fd = open(pagemap_proc, O_RDONLY);
> -	if (pagemap_fd == -1)
> -		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
> -
> -	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
> -	if (kpageflags_fd == -1)
> -		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
> +	self->created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
> +					&self->fs_loc);
> +	prepare_proc_fd();
> +}
>   
> -	fd_size = 2 * pmd_pagesize;
> +FIXTURE_TEARDOWN(split_thp_in_pagecache_to_order_offset)
> +{
> +	cleanup_proc_fd();
> +	cleanup_thp_fs(self->fs_loc, self->created_tmp);
> +	free(expected_orders);
> +}
>   
> -	split_pmd_zero_pages();
> +#define SPLIT_IN_PAGECACHE_ORDER_OFFSETS(ord)					 \
> +	ADD_VARIANT_ORDER_OFFSET(split_thp_in_pagecache_to_order_offset, ord, 0);\
> +	ADD_VARIANT_ORDER_OFFSET(split_thp_in_pagecache_to_order_offset, ord, 1);\
> +	ADD_VARIANT_ORDER_OFFSET(split_thp_in_pagecache_to_order_offset, ord, 2);\
> +	ADD_VARIANT_ORDER_OFFSET(split_thp_in_pagecache_to_order_offset, ord, 3)\
> +
> +SPLIT_IN_PAGECACHE_ORDER_OFFSETS(0);
> +SPLIT_IN_PAGECACHE_ORDER_OFFSETS(1);
> +SPLIT_IN_PAGECACHE_ORDER_OFFSETS(2);
> +SPLIT_IN_PAGECACHE_ORDER_OFFSETS(3);
> +SPLIT_IN_PAGECACHE_ORDER_OFFSETS(4);
> +SPLIT_IN_PAGECACHE_ORDER_OFFSETS(5);
> +SPLIT_IN_PAGECACHE_ORDER_OFFSETS(6);
> +SPLIT_IN_PAGECACHE_ORDER_OFFSETS(7);
> +SPLIT_IN_PAGECACHE_ORDER_OFFSETS(8);
> +
> +TEST_F(split_thp_in_pagecache_to_order_offset, order_offset)
> +{
> +	size_t fd_size = 2 * pmd_pagesize;
>   
> -	for (i = 0; i < pmd_order; i++)
> -		if (i != 1)
> -			split_pmd_thp_to_order(i);
> +	split_thp_in_pagecache_to_order_at(fd_size, self->fs_loc,
> +			variant->order, self->offset);
> +}
>   
> -	split_pte_mapped_thp();
> -	for (i = 0; i < pmd_order; i++)
> -		split_file_backed_thp(i);
> +int main(int argc, char **argv)
> +{
> +	int i;
>   
> -	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
> -			&fs_loc);
> -	for (i = pmd_order - 1; i >= 0; i--)
> -		split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, -1);
> +	if (geteuid() != 0) {
> +		ksft_print_msg("Please run the benchmark as root\n");
> +		ksft_finished();
> +	}
>   
> -	for (i = 0; i < pmd_order; i++)
> -		for (offset = 0;
> -		     offset < nr_pages;
> -		     offset += MAX(nr_pages / 4, 1 << i))
> -			split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, offset);
> -	cleanup_thp_fs(fs_loc, created_tmp);
> +	for (i = 1; i < argc; i++) {
> +		/* only one parameter supported */
> +		if (*argv[i] != '-') {
> +			optional_xfs_path = argv[i];
> +			break;
> +		}
>   
> -	close(pagemap_fd);
> -	close(kpageflags_fd);
> -	free(expected_orders);
> +		/* option -l/-h has no parameter */
> +		if (*(argv[i] + 1) != 'l' && *(argv[i] + 1) != 'h')
> +			i++;
> +	}
>   
> -	ksft_finished();
> +	pagesize = getpagesize();
> +	pmd_pagesize = read_pmd_pagesize();
> +	if (!pmd_pagesize)
> +		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
> +	pmd_order = sz2ord(pmd_pagesize, pagesize);
>   
> -	return 0;
> +	return test_harness_run(argc, argv);
>   }

