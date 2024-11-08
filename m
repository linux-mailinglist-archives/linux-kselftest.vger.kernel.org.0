Return-Path: <linux-kselftest+bounces-21666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ECB9C1AC3
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 11:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABFC1C228AC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 10:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487271E1A36;
	Fri,  8 Nov 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qkoCKyxZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE5D197A82;
	Fri,  8 Nov 2024 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062290; cv=none; b=Mevbcq1Y3zkN1SURJwTyFL+mPpEb7gS/AawmEKexNxjWkYjPwq1I+//6fMQQwo6PI4nWgNNNCSBF1QP33013MXopUwhRfGIKU94BHozZttWAqV3PE92XOwp/uJRfEyiwKvQUaMhJs0uSqcRlregnRxXU37sIQkiWp7ezz11dUiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062290; c=relaxed/simple;
	bh=hPhMe0l+B4N8QAoWpXk3xvhOtjEsBfoJTSFCSzFcAko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E63YcoOuM23Kf+MDsF6TrKiSFTlup4tHM2vTmB80XsgVHGT7OK8r07NUoLjKnbrlB0vZvQaaHxhguHrMgZ8U198XRe4iQAxTG1RbdjwAf0gUOd8E310nvZYHMQUM1lQPmwldRdVsphKgpXDeNylEHnZG3DYUCM7Qvop2+YZgekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qkoCKyxZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8A9oSL023429;
	Fri, 8 Nov 2024 10:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YV7dqm
	1guhPXEd+Ayv5dY9WkStJcSAGbALacM9gpk/I=; b=qkoCKyxZGO8s0i1DthAwRO
	rDJbviz+tumYreCe8m1xkt08JYEyprlQjPRVEbhpRDdgyBzLTe3nyzxfOzAWXOOl
	+e0HhaF42qtlEr1DZZvrNzPMMTuCmXex1mzRkgEt4rEBIHo4iwq1aW1pPOAqyoFm
	3eODm+BlofKzeGhDbHuGO8dOXKxyoe9Gq1MbbI1TLmM+K1v8lWhdwg9UDLHQTy0c
	3XrelxSEaTm8Mfl3/QbE64tI/xHdpoHEBtp4y7Z++H2l3vnIsUx/qABj8P3xY17V
	C7jH/hxpIDWUyCV05ELVPFvNDEfJMcyrECwNgCD20AWNXmUsR5FvydRwBPBS4dFQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42sgn7835n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 10:38:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A83XgUR023412;
	Fri, 8 Nov 2024 10:35:13 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p1411ysp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 10:35:13 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A8AZClr21758536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 10:35:13 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EC6758067;
	Fri,  8 Nov 2024 10:35:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2844858065;
	Fri,  8 Nov 2024 10:35:10 +0000 (GMT)
Received: from [9.179.28.136] (unknown [9.179.28.136])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Nov 2024 10:35:09 +0000 (GMT)
Message-ID: <5883b1c0-13c6-4593-9dd5-17f34c1319fe@linux.ibm.com>
Date: Fri, 8 Nov 2024 16:05:08 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: hugetlb_dio: Check for initial conditions to
 skip in the start
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241101141557.3159432-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20241101141557.3159432-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J3MZ_ATCNLJm_HHz-P-dL4bmOnro8wQp
X-Proofpoint-ORIG-GUID: J3MZ_ATCNLJm_HHz-P-dL4bmOnro8wQp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=945 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080086


On 11/1/24 19:45, Muhammad Usama Anjum wrote:
> The test should be skipped if initial conditions aren't fulfilled in
> the start instead of failing and outputting non-compliant TAP logs. This
> kind of failure pollutes the results. The initial conditions are:
> - The test should only execute if /tmp file can be allocated.
> - The test should only execute if huge pages are free.
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Before:
> TAP version 13
> 1..4
> Bail out! Error opening file
> : Read-only file system (30)
>   # Planned tests != run tests (4 != 0)
>   # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> After:
> TAP version 13
> 1..0 # SKIP Unable to allocate file: Read-only file system
> ---
>   tools/testing/selftests/mm/hugetlb_dio.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
> index f9ac20c657ec6..60001c142ce99 100644
> --- a/tools/testing/selftests/mm/hugetlb_dio.c
> +++ b/tools/testing/selftests/mm/hugetlb_dio.c
> @@ -44,13 +44,6 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
>   	if (fd < 0)
>   		ksft_exit_fail_perror("Error opening file\n");
>   
> -	/* Get the free huge pages before allocation */
> -	free_hpage_b = get_free_hugepages();

Hi Muhammed Usman Anjum

Reading the free pages is required before starting the test. This value will be compared to the free pages after the test. If they are not the same, the test will be considered a failure.

Since reading the free pages before the test was removed,|free_hpage_b|  is always 0, causing the test to fail.

./tools/testing/selftests/mm/hugetlb_dio TAP version 13 1..4 # No. Free 
pages before allocation : 0 # No. Free pages after munmap : 100 not ok 1 
: Huge pages not freed! # No. Free pages before allocation : 0 # No. 
Free pages after munmap : 100 not ok 2 : Huge pages not freed! # No. 
Free pages before allocation : 0 # No. Free pages after munmap : 100 not 
ok 3 : Huge pages not freed! # No. Free pages before allocation : 0 # 
No. Free pages after munmap : 100 not ok 4 : Huge pages not freed! # 
Totals: pass:0 fail:4 xfail:0 xpass:0 skip:0 error:0 I think below 
changes are required. --- a/tools/testing/selftests/mm/hugetlb_dio.c +++ 
b/tools/testing/selftests/mm/hugetlb_dio.c @@ -44,6 +44,9 @@ void 
run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off) if 
(fd < 0) ksft_exit_fail_perror("Error opening file\n"); + /* Get the 
free huge pages before allocation */ + free_hpage_b = 
get_free_hugepages(); + /* Allocate a hugetlb page */ orig_buffer = 
mmap(NULL, h_pagesize, mmap_prot, mmap_flags, -1, 0); if (orig_buffer == 
MAP_FAILED) { With this change the tests are passing. 
./tools/testing/selftests/mm/hugetlb_dio TAP version 13 1..4 # No. Free 
pages before allocation : 100 # No. Free pages after munmap : 100 ok 1 : 
Huge pages freed successfully ! # No. Free pages before allocation : 100 
# No. Free pages after munmap : 100 ok 2 : Huge pages freed successfully 
! # No. Free pages before allocation : 100 # No. Free pages after munmap 
: 100 ok 3 : Huge pages freed successfully ! # No. Free pages before 
allocation : 100 # No. Free pages after munmap : 100 ok 4 : Huge pages 
freed successfully ! # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 
error:0 Thank

Donet

> -	if (free_hpage_b == 0) {
> -		close(fd);
> -		ksft_exit_skip("No free hugepage, exiting!\n");
> -	}
> -
>   	/* Allocate a hugetlb page */
>   	orig_buffer = mmap(NULL, h_pagesize, mmap_prot, mmap_flags, -1, 0);
>   	if (orig_buffer == MAP_FAILED) {
> @@ -94,8 +87,20 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
>   int main(void)
>   {
>   	size_t pagesize = 0;
> +	int fd;
>   
>   	ksft_print_header();
> +
> +	/* Open the file to DIO */
> +	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
> +	if (fd < 0)
> +		ksft_exit_skip("Unable to allocate file: %s\n", strerror(errno));
> +	close(fd);
> +
> +	/* Check if huge pages are free */
> +	if (!get_free_hugepages())
> +		ksft_exit_skip("No free hugepage, exiting\n");
> +
>   	ksft_set_plan(4);
>   
>   	/* Get base page size */

