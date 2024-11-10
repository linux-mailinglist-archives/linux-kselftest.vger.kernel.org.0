Return-Path: <linux-kselftest+bounces-21739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A79D9C3116
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 07:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1821C20B00
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 06:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E569C14884D;
	Sun, 10 Nov 2024 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iGqnZ/EM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B4233D62;
	Sun, 10 Nov 2024 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731221547; cv=none; b=XL7H1JN6zy/yj46p8sgO+D91rc3Vvm2DqL/TIWUq6as2rTPltonw06DD3MEd9Mj+j7hH1upDJ20FQ0r9fTlG/fRnjuQRiGr8WVdSlcr6zOBWqtFmEUzu53ZxL7DkfUW/xFVEm4KcFrdQ/Vqa+y/q1FM24eXPNY2MzCVWkUg3uhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731221547; c=relaxed/simple;
	bh=od8W5XkEy0ff/2q8B7R8TM67GDL06nnNwQ00rat/Y2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwgMDq9s2nR+A0E5Z8xmSg+SE7KL84w2t6UVvJE9mONTEhumbRlaOZMivN752SgQk9Zg8WWQgkVE+xwTaBHI6Cdv9navvlDHBESSa4+0O599SNvgeXvRhb4MdQ6an15LsOKPppB6xR/PC5HzWIRxft1czl6whyYhBak4E93B0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iGqnZ/EM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AA6AIgA018846;
	Sun, 10 Nov 2024 06:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RNk79E
	8usZi4lUq/C0Gd7pk/ijEnLHRf6/yYfKYkH9c=; b=iGqnZ/EMWFpEtPJnwNaBk1
	WgDIPMFAbpkzZDTta1KeA8kiAPQJDzyTNS4R3L8W0z+EtQCyqq5xD+2y68SMNm8C
	F+P06LEpeC1LQTQlQC6FK4QClkt2305Slcjjo9nYO4NrLswR8HllWuss+xuCRH69
	ngIVS7AZiBY65eaRqzyQijYBEzzqCJVIQggoqvkO2WrCEfVW8CNjMoX4iBdNOhC3
	e/51THIqOkAmVJcz9CU1Qh8BjcnC2sq447zuViqEdQGCXPYcMGcT9vdh8Ai2LNfC
	v+SBEn31B1Y3Y0wSBk/x+JqxsTUY/ZFoqPvoSVPscvo4X+xHmKWM3tOuOKbPDHsg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42tqasr2sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 06:52:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AA0BIlm010514;
	Sun, 10 Nov 2024 06:52:17 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tj2s0eag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 06:52:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AA6qG7744892610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Nov 2024 06:52:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4BE158052;
	Sun, 10 Nov 2024 06:52:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BDD258056;
	Sun, 10 Nov 2024 06:52:14 +0000 (GMT)
Received: from [9.179.28.57] (unknown [9.179.28.57])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Nov 2024 06:52:13 +0000 (GMT)
Message-ID: <433d2870-987d-4d63-a07c-287580e1d6c7@linux.ibm.com>
Date: Sun, 10 Nov 2024 12:22:12 +0530
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
X-Proofpoint-GUID: 8urxfQY0GAcF7KjpMAmCAf4QA9LoiSQp
X-Proofpoint-ORIG-GUID: 8urxfQY0GAcF7KjpMAmCAf4QA9LoiSQp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=822
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
>
>
Hi Andrew
Would you prefer I send this fixup patch as a new series, or is it okay as is?

Thanks
Donet


