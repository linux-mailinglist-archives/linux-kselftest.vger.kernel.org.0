Return-Path: <linux-kselftest+bounces-21740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3389C311A
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 07:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD125281A54
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 06:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE4D14A09C;
	Sun, 10 Nov 2024 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RMR97txm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E276C233D62;
	Sun, 10 Nov 2024 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731221815; cv=none; b=APR7AKm4nOjZ2PIYf/wrtCZM93G9JgZQRP4XQ2uOZ+PuWIdmEeBoBzbVigIKNgalDtApIhrICC6aoD1zwEY/pNUH5NHyU4DcKCULmXR0fNhZAqi5pMfJsVvYHOeClnqnu+4yQjp6mLZxRJ08RmByo8VLeNK5TEr13tfEL2WDTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731221815; c=relaxed/simple;
	bh=UA9Tmd0gNaeVpuxU3ELNYYIYThrrxAtZREPsYTGTYOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVXQgwLon9wEfLKAglNtN/gIv5JV5p+QK1Jgj+26oI1oqLys/J6rwHyEYpHoH7MGBGNoQm7xAWBtYuHWOLS68NkPSIOGfZhCcL8ixCPyUlcJk//ZXtbceBFzlNyzpdbUVrNF5C+7XnW9voOyZ8aZDaJlnIHJevb1rSxGx7bhUlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RMR97txm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AA5iZ9X005330;
	Sun, 10 Nov 2024 06:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gEnGDq
	b+zG5GUHMaGP68rcwcqiWBlcYETbX8g4yNnTo=; b=RMR97txmjnP7gyvTI4Tsz5
	8EUqMAgIJMIU6evD+A/zeYbQzynr1w5nzyEl1IXiu/mdBmzCkp9/CBmxMZiby0pA
	PE0Ty+Pete8mlYrgsqe5iZMTxa4HfZ6opFxt9/AU/878yfdyZgbmTqWY918ziu6c
	t4PoA5RLi8Nou5op3V9xV744U7JmvmCPHNfumBulK4o9WKjnpkuRi+FATZQhnPnY
	Ad2JXgpvE1ZJ1KOHxO39Lv9XLmHKIrr3+a3mOO2HAfctHNIu7HzDcB2ahNB+V2HI
	Hdz/ToOCoGADBScoR61R8fteqIzhHjLM7Ne/jn2HEO7qbsDBsRlpQDQoZLuvErsQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42tnjqga3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 06:56:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AA4pvI8008445;
	Sun, 10 Nov 2024 06:56:39 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjextg26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 06:56:39 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AA6ucX25833362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Nov 2024 06:56:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F87258065;
	Sun, 10 Nov 2024 06:56:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E03FE58056;
	Sun, 10 Nov 2024 06:56:35 +0000 (GMT)
Received: from [9.179.28.57] (unknown [9.179.28.57])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Nov 2024 06:56:35 +0000 (GMT)
Message-ID: <8a1cd578-2dce-4013-a92a-ede437b91593@linux.ibm.com>
Date: Sun, 10 Nov 2024 12:26:34 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: hugetlb_dio: Fixup Check for initial
 conditions to skip in the start
To: akpm@linux-foundation.org
Cc: Usama.Anjum@collabora.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, shuah@kernel.org
References: <20241109223436.3ddeaf1d60e1ade8f562d757@linux-foundation.org>
 <20241110064903.23626-1-donettom@linux.ibm.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20241110064903.23626-1-donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m5GBIoX7PwTonTIMmzQzOrlt3w_q_xg1
X-Proofpoint-GUID: m5GBIoX7PwTonTIMmzQzOrlt3w_q_xg1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=733
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411100058


On 11/10/24 12:19, Donet Tom wrote:
> This test verifies that a hugepage, used as a user buffer for
> DIO operations, is correctly freed upon unmapping. To test this,
> we read the count of free hugepages before and after the mmap,
> DIO, and munmap operations, then check if the free hugepage count
> is the same.
>
> Reading free hugepages before the test was removed by commit
> 0268d4579901 ('selftests: hugetlb_dio: check for initial conditions
> to skip at the start'), causing the test to always fail.
>
> This patch adds back reading the free hugepages before starting
> the test. With this patch, the tests are now passing.
>
> Test Results without this patch
>
> ./tools/testing/selftests/mm/hugetlb_dio
> TAP version 13
> 1..4
>   # No. Free pages before allocation : 0
>   # No. Free pages after munmap : 100
> not ok 1 : Huge pages not freed!
>   # No. Free pages before allocation : 0
>   # No. Free pages after munmap : 100
> not ok 2 : Huge pages not freed!
>   # No. Free pages before allocation : 0
>   # No. Free pages after munmap : 100
> not ok 3 : Huge pages not freed!
>   # No. Free pages before allocation : 0
>   # No. Free pages after munmap : 100
> not ok 4 : Huge pages not freed!
>   # Totals: pass:0 fail:4 xfail:0 xpass:0 skip:0 error:0
>
> Test results with this patch.

Sorry the test results with this patch is below.

Test results With this patch

/tools/testing/selftests/mm/hugetlb_dio
TAP version 13
1..4
# No. Free pages before allocation : 100
# No. Free pages after munmap : 100
ok 1 : Huge pages freed successfully !
# No. Free pages before allocation : 100
# No. Free pages after munmap : 100
ok 2 : Huge pages freed successfully !
# No. Free pages before allocation : 100
# No. Free pages after munmap : 100
ok 3 : Huge pages freed successfully !
# No. Free pages before allocation : 100
# No. Free pages after munmap : 100
ok 4 : Huge pages freed successfully !

# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

Thank

Donet

>
> ./tools/testing/selftests/mm/hugetlb_dio
> TAP version 13
> 1..4
>   # No. Free pages before allocation : 0
>   # No. Free pages after munmap : 100
> not ok 1 : Huge pages not freed!
>   # No. Free pages before allocation : 0
>   # No. Free pages after munmap : 100
> not ok 2 : Huge pages not freed!
>   # No. Free pages before allocation : 0
>   # No. Free pages after munmap : 100
> not ok 3 : Huge pages not freed!
>   # No. Free pages before allocation : 0
>   # No. Free pages after munmap : 100
> not ok 4 : Huge pages not freed!
>   # Totals: pass:0 fail:4 xfail:0 xpass:0 skip:0 error:0
>
> Fixes: 0268d4579901 ("selftests: hugetlb_dio: check for initial conditions to skip in the start")
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/hugetlb_dio.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
> index 60001c142ce9..432d5af15e66 100644
> --- a/tools/testing/selftests/mm/hugetlb_dio.c
> +++ b/tools/testing/selftests/mm/hugetlb_dio.c
> @@ -44,6 +44,13 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
>   	if (fd < 0)
>   		ksft_exit_fail_perror("Error opening file\n");
>   
> +	/* Get the free huge pages before allocation */
> +	free_hpage_b = get_free_hugepages();
> +	if (free_hpage_b == 0) {
> +		close(fd);
> +		ksft_exit_skip("No free hugepage, exiting!\n");
> +	}
> +
>   	/* Allocate a hugetlb page */
>   	orig_buffer = mmap(NULL, h_pagesize, mmap_prot, mmap_flags, -1, 0);
>   	if (orig_buffer == MAP_FAILED) {

