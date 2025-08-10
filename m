Return-Path: <linux-kselftest+bounces-38644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C9CB1FB2D
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 18:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3919718969DA
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB88243958;
	Sun, 10 Aug 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n06X/Jfp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBFE2033A;
	Sun, 10 Aug 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754844836; cv=none; b=lRrCyZUpJukbpNeKXQkJV0nJp+k8wmeZoH2PYUm+3Qp0vbCA6Wnz5Wj0bI2ev5UuZ2KpDxJrEDah2bH7Wbz8BpmRiPpCN6pFyis0iMXvjzxiOf9Q1z2/baO4LpIUYJ8sSHMc7srpJDlgd6h4huqwt5fUnzHEOfab7OItxc7BEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754844836; c=relaxed/simple;
	bh=RpoP/hggtBrbf8HplOqyggDZuTkMDyOOtac8t25yJCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMbGff9vhufTQITh/1qLMS2MM+8Ydyg0LczITbwgGNBnRFuLr+zB8V6r84KFZSfow6AnedbYI1nTa3w/T7cOZYU/vx2jsmmFn9WR9TiP6XFfkM+Ye7vClmQZ56DKHSCjAfrc7sK3KYLEjJvQtdNvtiSTzcDq3C+hjGrcsKYH7cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n06X/Jfp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57A7m4Ra013467;
	Sun, 10 Aug 2025 16:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eZaYkx
	dq57TzHEZWXDL3LSQ0gLrm6LZX0vgoYqN25PU=; b=n06X/Jfp2Ihy0CJtKNl4IZ
	4HN469Hx+4PCJBqo0o+JmlQe58oiuXDQ7wWchz/+mK0NsiRLjU/6QVSbhGjNTrbg
	9ne7IGpIQJ6Pa0ue+6kgjjhgDL1rSlluMnIGmGoG2ITvioV4fbMTTEwHdIC/23Nj
	N4GoqCkCJSyBco1/jDESbiFRaqRgqukqZI6O1004i9f7WPyoQz14ex8elVzRjeH2
	MjLtCoOsNETlf3YVuI/lhfBEu8h3i0KAtt4Cvd9pokvMOWaV+fH7eH2OaHqCJWvD
	MaX5NMXhab4femDUqnmOQk92VzAVcRydYKiSNs8x0YN1MofKwKF1emZkxxNex4qg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnntwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 16:53:38 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57AGrcXS013512;
	Sun, 10 Aug 2025 16:53:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnntwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 16:53:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57ACLhQc026270;
	Sun, 10 Aug 2025 16:53:37 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh20tneh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 16:53:37 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57AGrbr330933520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 16:53:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09EFF58050;
	Sun, 10 Aug 2025 16:53:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B834A58045;
	Sun, 10 Aug 2025 16:53:26 +0000 (GMT)
Received: from [9.124.216.245] (unknown [9.124.216.245])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 16:53:26 +0000 (GMT)
Message-ID: <d90d8aa9-0e19-4098-ad3c-1c8069167538@linux.ibm.com>
Date: Sun, 10 Aug 2025 22:23:24 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] selftests/mm: check after-split folio orders in
 split_huge_page_test.
To: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
        wang lian <lianux.mm@gmail.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20250808190144.797076-1-ziy@nvidia.com>
 <20250808190144.797076-4-ziy@nvidia.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250808190144.797076-4-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDEyMyBTYWx0ZWRfX1KC0HXYQxXPq
 NclwyjsVZJj94pW+rX5fg2EDl5hl7jqSs2GRX8JWror7aqSrqXmIHMkMO9HHwyvucoQE/zVSaCC
 E4gHTojazdKVRHUhSzvB6yctJ82TuORKOCU+7uobQc71i7A3uNGreSxk4D0oV556G5cU0XMvZOs
 8JZGtJy4GkW7BoAeP9taQcwS6fNWdUyECkHfUI0dUXEBg4VdfYsWW5+SDW/00vINysEyqxPupSx
 gxlCkpBhOn72qMYR2/LGdgcY7LN7FFBvX+aeXFHGtC6u2dTKzy0lJLow75Z5gk+YZ5qhsKlFO49
 06tqNxLpY4RVLq0cogNuM05Wa2WJa4MOIQIru9dTdUgJ/Qi3OstjtZTzgHbPFT0h/5imAjSSGUm
 Cwt23eSsFPT3sflm6QypAzo/RiT2+VxWILu2+T4mgDxEkpBrasNgn4kinNmb85EeD69BHCqV
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=6898ce92 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Ikd4Dj_1AAAA:8 a=99-7eeOMbBYPJQNDcP0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kLZeXgm3d9BGfBZmCX8LZerUyXA6pVgp
X-Proofpoint-ORIG-GUID: Z6Z6lzQxBG4wubdRAKY4I1PN3o44dqpO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508100123


On 8/9/25 12:31 AM, Zi Yan wrote:
> Instead of just checking the existence of PMD folios before and after folio
> split tests, use check_folio_orders() to check after-split folio orders.
>
> The following tests are not changed:
> 1. split_pte_mapped_thp: the test already uses kpageflags to check;
> 2. split_file_backed_thp: no vaddr available.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   .../selftests/mm/split_huge_page_test.c       | 98 ++++++++++++++-----
>   1 file changed, 72 insertions(+), 26 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 5ab488fab1cd..161108717f1c 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -25,6 +25,10 @@
>   uint64_t pagesize;
>   unsigned int pageshift;
>   uint64_t pmd_pagesize;
> +unsigned int pmd_order;
> +unsigned int max_order;
> +
> +#define NR_ORDERS (max_order + 1)
>   
>   #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
>   #define SMAP_PATH "/proc/self/smaps"
> @@ -36,6 +40,11 @@ uint64_t pmd_pagesize;
>   
>   #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
>   
> +const char *pagemap_proc = "/proc/self/pagemap";
> +const char *kpageflags_proc = "/proc/kpageflags";
> +int pagemap_fd;
> +int kpageflags_fd;
> +
>   int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
>   {
>   	uint64_t paddr;
> @@ -151,6 +160,11 @@ void split_pmd_thp_to_order(int order)
>   	char *one_page;
>   	size_t len = 4 * pmd_pagesize;
>   	size_t i;
> +	int *orders;
> +
> +	orders = (int *)malloc(sizeof(int) * NR_ORDERS);
> +	if (!orders)
> +		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
>   
>   	one_page = memalign(pmd_pagesize, len);
>   	if (!one_page)
> @@ -172,12 +186,20 @@ void split_pmd_thp_to_order(int order)
>   		if (one_page[i] != (char)i)
>   			ksft_exit_fail_msg("%ld byte corrupted\n", i);
>   
> +	memset(orders, 0, sizeof(int) * NR_ORDERS);
> +	/* set expected orders */
> +	orders[order] = 4 << (pmd_order - order);
> +
> +	if (check_folio_orders(one_page, len, pagemap_fd, kpageflags_fd,
> +			       orders, NR_ORDERS))
> +		ksft_exit_fail_msg("Unexpected THP split\n");
>   
>   	if (!check_huge_anon(one_page, 0, pmd_pagesize))
>   		ksft_exit_fail_msg("Still AnonHugePages not split\n");
>   
>   	ksft_test_result_pass("Split huge pages to order %d successful\n", order);
>   	free(one_page);
> +	free(orders);
>   }
>   
>   void split_pte_mapped_thp(void)
> @@ -186,22 +208,6 @@ void split_pte_mapped_thp(void)
>   	size_t len = 4 * pmd_pagesize;
>   	uint64_t thp_size;
>   	size_t i;
> -	const char *pagemap_template = "/proc/%d/pagemap";
> -	const char *kpageflags_proc = "/proc/kpageflags";
> -	char pagemap_proc[255];
> -	int pagemap_fd;
> -	int kpageflags_fd;
> -
> -	if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < 0)
> -		ksft_exit_fail_msg("get pagemap proc error: %s\n", strerror(errno));
> -
> -	pagemap_fd = open(pagemap_proc, O_RDONLY);
> -	if (pagemap_fd == -1)
> -		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
> -
> -	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
> -	if (kpageflags_fd == -1)
> -		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
>   
>   	one_page = mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
>   			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> @@ -259,8 +265,6 @@ void split_pte_mapped_thp(void)
>   
>   	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
>   	munmap(one_page, len);
> -	close(pagemap_fd);
> -	close(kpageflags_fd);
>   }
>   
>   void split_file_backed_thp(int order)
> @@ -463,10 +467,16 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
>   		int order, int offset)
>   {
>   	int fd;
> +	char *split_addr;
>   	char *addr;
>   	size_t i;
>   	char testfile[INPUT_MAX];
>   	int err = 0;
> +	int *orders;
> +
> +	orders = (int *)malloc(sizeof(int) * NR_ORDERS);
> +	if (!orders)
> +		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
>   
>   	err = snprintf(testfile, INPUT_MAX, "%s/test", fs_loc);
>   
> @@ -474,16 +484,32 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
>   		ksft_exit_fail_msg("cannot generate right test file name\n");
>   
>   	err = create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
> -	if (err)
> +	if (err) {
> +		free(orders);
>   		return;
> +	}
>   	err = 0;
>   
> -	if (offset == -1)
> -		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
> -			      (uint64_t)addr + fd_size, order);
> -	else
> -		write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)addr,
> -			      (uint64_t)addr + fd_size, order, offset);
> +	memset(orders, 0, sizeof(int) * NR_ORDERS);
> +	if (offset == -1) {
> +		for (split_addr = addr; split_addr < addr + fd_size; split_addr += pmd_pagesize)
> +			write_debugfs(PID_FMT, getpid(), (uint64_t)split_addr,
> +				      (uint64_t)split_addr + pagesize, order);
> +
> +		/* set expected orders */
> +		orders[order] = fd_size / (pagesize << order);
> +	} else {
> +		int times = fd_size / pmd_pagesize;
> +
> +		for (split_addr = addr; split_addr < addr + fd_size; split_addr += pmd_pagesize)
> +			write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)split_addr,
> +				      (uint64_t)split_addr + pagesize, order, offset);
> +
> +		/* set expected orders */
> +		for (i = order + 1; i < pmd_order; i++)
> +			orders[i] = times;
> +		orders[order] = 2 * times;
> +	}
>   
>   	for (i = 0; i < fd_size; i++)
>   		if (*(addr + i) != (char)i) {
> @@ -492,6 +518,14 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
>   			goto out;
>   		}
>   
> +	if (check_folio_orders(addr, fd_size, pagemap_fd, kpageflags_fd, orders,
> +			       NR_ORDERS)) {
> +		ksft_print_msg("Unexpected THP split\n");
> +		err = 1;
> +		goto out;
> +	}
> +
> +
>   	if (!check_huge_file(addr, 0, pmd_pagesize)) {
>   		ksft_print_msg("Still FilePmdMapped not split\n");
>   		err = EXIT_FAILURE;
> @@ -499,6 +533,7 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
>   	}
>   
>   out:
> +	free(orders);
>   	munmap(addr, fd_size);
>   	close(fd);
>   	unlink(testfile);
> @@ -522,7 +557,6 @@ int main(int argc, char **argv)
>   	const char *fs_loc;
>   	bool created_tmp;
>   	int offset;
> -	unsigned int max_order;
>   	unsigned int nr_pages;
>   	unsigned int tests;
>   
> @@ -539,6 +573,7 @@ int main(int argc, char **argv)
>   	pagesize = getpagesize();
>   	pageshift = ffs(pagesize) - 1;
>   	pmd_pagesize = read_pmd_pagesize();
> +	pmd_order = GET_ORDER(pmd_pagesize / pagesize);


I think max_order is also same as pmd_order

   nr_pages = pmd_pagesize / pagesize;
   max_order = GET_ORDER(nr_pages);

Can we use one?

>   	if (!pmd_pagesize)
>   		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
>   
> @@ -547,6 +582,14 @@ int main(int argc, char **argv)
>   	tests = 2 + (max_order - 1) + (2 * max_order) + (max_order - 1) * 4 + 2;
>   	ksft_set_plan(tests);
>   
> +	pagemap_fd = open(pagemap_proc, O_RDONLY);
> +	if (pagemap_fd == -1)
> +		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
> +
> +	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
> +	if (kpageflags_fd == -1)
> +		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
> +
>   	fd_size = 2 * pmd_pagesize;
>   
>   	split_pmd_zero_pages();
> @@ -571,6 +614,9 @@ int main(int argc, char **argv)
>   			split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, offset);
>   	cleanup_thp_fs(fs_loc, created_tmp);
>   
> +	close(pagemap_fd);
> +	close(kpageflags_fd);
> +
>   	ksft_finished();
>   
>   	return 0;

