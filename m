Return-Path: <linux-kselftest+bounces-38641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AADB1FA23
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 15:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB4B7A58F7
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 13:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6382D247282;
	Sun, 10 Aug 2025 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mw2w8paM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7A5680
	for <linux-kselftest@vger.kernel.org>; Sun, 10 Aug 2025 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754833088; cv=none; b=jkhwnf/A/5dhFnTbecM9/na+U4OCe44EV078a9Zwa2Qcx3+Ql2GxPFO8mwplH1VRYf9RpWhg/hTn/+vmTfOq4QUGnMLneJQp+9u9Ad18ry4vDaPAC1W4LOm6GmA43w1wvzijZCJ3c+z2IoZDfY/asnX8XMpYk04MYy/HUeY4o1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754833088; c=relaxed/simple;
	bh=G6ANFum5iZlrhVQzFRadyxFqcJIadz+HtCHwsytqYjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lp76cl5iPXsKzjNw0LCiVdXs7W/36Evn6HwZ0lnuzzmv1mEKif5efJM5qSjLiwUaR7BnYSCyKm17jQhg8CRXIjCQ7AKKVncqj0UhJC5kmyhVQ+6yGBnOeSPgWHGxBoZ9NiYAlVul6rZ7eMrKIgfI4I1j/9x/7Qqq84ZXB6jHDtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mw2w8paM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57A0tUqh005822;
	Sun, 10 Aug 2025 13:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D7bLjF
	L6R/Q9uB4qwTKOFnu7RvfXn2IQ4E/SNr7xIDg=; b=mw2w8paM1fRpw13GyY747e
	Lz5qJRNZrIHMUJ7aKTlhmL6m091313mm8voDLFFDFTkJE1z+D0I1cdIFhfrBl903
	UV14XcTwRPx7X+o4O9zEgp0CEQwtBFwVMq/RbqiUtsLjo19kdsjO/ADwsChzBYL5
	yWis4JGQLC+1joeykIvKcqUC/EsITNBb8wKJ/xYVw91R8LFmkYmEt/2FnElKa7Fy
	nfSYXTHm/CbdW972koD4xmaeayeqMpxjcTHyYOxmq5JzGJwezIQUXVYnhLtF3GVw
	TFpcBsAC9rpRUEwIlrmz7zhGmNsxOMZYIU+Mf814LIfpKg4dUhH6U3mm7NhL/aKw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9ss86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:37:55 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57ADbsOl015672;
	Sun, 10 Aug 2025 13:37:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9ss81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:37:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57AC4t0r026485;
	Sun, 10 Aug 2025 13:37:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh20t4c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:37:54 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ADbrep10027558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 13:37:53 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B639658050;
	Sun, 10 Aug 2025 13:37:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 532E058045;
	Sun, 10 Aug 2025 13:37:49 +0000 (GMT)
Received: from [9.124.216.245] (unknown [9.124.216.245])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 13:37:48 +0000 (GMT)
Message-ID: <7fcea8e2-4393-4a21-b6fc-39b853f07d3c@linux.ibm.com>
Date: Sun, 10 Aug 2025 19:07:47 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] selftests/mm: do check_huge_anon() with a number been
 passed in
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>, Dev Jain <dev.jain@arm.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>
References: <20250809194209.30484-1-richard.weiyang@gmail.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250809194209.30484-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=6898a0b3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=Ikd4Dj_1AAAA:8 a=ktfKDUQsDJOdS9iR4bQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: ijnXgxkVvTXl2cVXx0w5J98Pa-1MSBpS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA5NyBTYWx0ZWRfXwiQS2kfLGXaC
 JebGCXSWTBDARstNpjroZ0vcl2aQvcKpjH3E4XW4TMDD8AH3U1iTV/UC3GLAaNLRv/2naiH11GI
 ewjeHzKDU6rEWRkcSa3VDqO/CNBRMrLLRIKOz2pypfo1Xd93x+thHXCpUPV6bvAd2G0uNVzpnbk
 0gelC/fJR82FrGkKey1OpXn8L5/2pY8aW+kNJ0ewmLI7fjirdW9LWqt0vXyWj3+att7LXjOeZzo
 EdKqz2Y2a8xOF8PANsTrXi7YKfuAwvsCDDhXUGeI5bmYSDkZxJ/gEQ9vC4ez3mQiFjfXN3fFlC2
 nxSnX77+ihW+ib0BEBucL8WMuMOigFjn4I9F0ExBxzhOfJWTU7P3M72t0BWNxYubxvD2Dl2YNVC
 wahVzIpe9f1ZM4MMhnqlaxYSLpQysnquX3X7V7ebVdijWUtKs6yUeh4UeQ+bKjwmyYC25OQP
X-Proofpoint-GUID: 5TJHmXUiqUs4UUV5oHllXv2ASL_R5ug_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508100097


On 8/10/25 1:12 AM, Wei Yang wrote:
> Currently it hard codes the number of hugepage to check for
> check_huge_anon(), but it would be more reasonable to do the check based
> on a number passed in.
>
> Pass in the hugepage number and do the check based on it.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Donet Tom <donettom@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
>
> ---
> v2:
>    * use mm-new
>    * add back nr_hpages which is removed by an early commit
>    * adjust the change log a little
>    * drop RB and resend
> ---
>   tools/testing/selftests/mm/split_huge_page_test.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 5ab488fab1cd..63ac82f0b9e0 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -105,12 +105,12 @@ static char *allocate_zero_filled_hugepage(size_t len)
>   	return result;
>   }
>   
> -static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, size_t len)
> +static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hpages, size_t len)


We are re-adding this argument because nr_hpages should be the same in both
split_pmd_zero_pages and verify_rss_anon_split_huge_page_all_zeroes,
correct? I was just wondering — since the value is currently hardcoded
in both functions, would it be preferable to pass it as an argument,
or keep it hardcoded, What benefit do we gain by re-adding this argument?


>   {
>   	unsigned long rss_anon_before, rss_anon_after;
>   	size_t i;
>   
> -	if (!check_huge_anon(one_page, 4, pmd_pagesize))
> +	if (!check_huge_anon(one_page, nr_hpages, pmd_pagesize))
>   		ksft_exit_fail_msg("No THP is allocated\n");
>   
>   	rss_anon_before = rss_anon();
> @@ -141,7 +141,7 @@ void split_pmd_zero_pages(void)
>   	size_t len = nr_hpages * pmd_pagesize;
>   
>   	one_page = allocate_zero_filled_hugepage(len);
> -	verify_rss_anon_split_huge_page_all_zeroes(one_page, len);
> +	verify_rss_anon_split_huge_page_all_zeroes(one_page, nr_hpages, len);
>   	ksft_test_result_pass("Split zero filled huge pages successful\n");
>   	free(one_page);
>   }

