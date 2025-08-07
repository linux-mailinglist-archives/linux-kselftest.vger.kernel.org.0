Return-Path: <linux-kselftest+bounces-38452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99703B1D4D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 11:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4957C18805B2
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9DD245014;
	Thu,  7 Aug 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NtebDZpF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC07254876
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559261; cv=none; b=ow+WUA1kLhjvDl3svAJzyGmyuCKHDpj0pWOF6WM7LW3KKrTuYii5FPfKejg21il7+2E8uF3V2NlegUG/o/ppItBi64z/D3wIOCLSdu4LYHlmAoa4IOh362J8IVCYLexlp6/5LMDs2oi9frkYBnd2SQ8u7BDK4bi9N3OUqp5KJOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559261; c=relaxed/simple;
	bh=G0ROYfl2NEUDZ7q4uTKRkVf2N0CGvgBRAc+yoxkrvGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGxR/KHiQ6Cg6KSlj7tVMMzc4GYi4ynaxyhBI1hX3QDwq4EsVtrSs78kbRsCEnEsdHmz9hlQRUbrnUpEVBor6wG7cHUT18HNCrFdurCubgx221nGsjKQah3outmsr8/i3syXUdjbCwY2uMaHGp9wfqbauIBeWnwASwo8q2rUprY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NtebDZpF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5775SDi0028233;
	Thu, 7 Aug 2025 09:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z4OY3u
	F0CmeXCfiwg6IqQhPAwqZoeH/gzHHFxL3Xd9w=; b=NtebDZpF2huz2ugNXXfiQP
	LibQKzHcHX5PHFeRk4/E0f9o8PhOqwHDlJU8sfzz2JW99rK28oOjrbyiIlnWR1K4
	sbWf9I1NgQRDB/4jXZpldfu8zJX6IXGfXYiThQz4I0tz0elEjDfeyPvJAZ/+hIOu
	O6y1rCvIEQZaKjJCApA3YWVWiq4ZAxMeTBhNn6DAO/ahJhK87b+N0wJR7RxWT0qd
	FbCrS2gWPB+aMbDd6KVjuuiTYU+mxUE3d8tU5Dr5zAL12GU3X2hsbEdRns7kJewl
	qhJBxA1UsajxbfCcLrR1IrnHYxBFXxSd3Z27zyqUWzem4WUHms/0mn8NqfqAT7nQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq611djn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 09:34:07 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5779Va7T001623;
	Thu, 7 Aug 2025 09:34:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq611djg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 09:34:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5775Ke0m022668;
	Thu, 7 Aug 2025 09:34:05 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqfxrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 09:34:05 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5779Y5fS13632106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 09:34:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FBE25805D;
	Thu,  7 Aug 2025 09:34:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9025A58059;
	Thu,  7 Aug 2025 09:34:02 +0000 (GMT)
Received: from [9.109.245.113] (unknown [9.109.245.113])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Aug 2025 09:34:02 +0000 (GMT)
Message-ID: <b9e29604-b771-4e57-a3d7-430572e552b1@linux.ibm.com>
Date: Thu, 7 Aug 2025 15:04:01 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: do check_huge_anon() with a number been
 passed in
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
        dev.jain@arm.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250807082707.30647-1-richard.weiyang@gmail.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250807082707.30647-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B2c0FcYKeIJpxkcIUxM95fKBIW4F85jc
X-Proofpoint-ORIG-GUID: WtxzAoCGKw2AFPD8a987RjY2VIgfC_m5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA3MyBTYWx0ZWRfX0z8csTYVfm2K
 N61ZrTZGvOzJqDjkxHWpy8YMgj9hoRCnd37gXvCe8YyqbmK4tG5MQzUKWH06iVamYuSmozFUVvp
 Fc15gAAB68LlBZCE66yR9P1zZ2eaJGlSDfb3MUin3wb9UhL0eO8YfhZ7Wua3KnkhH1EbuJVTJZM
 zsGBemvTlgEdiC+7fo8AvQ6+kfypVheWLY5lExLjQCF9wZdqRz5zHe2ZSUVHoG8JfgytsmTZXfK
 B1kXde7CdFcegMts0wCUrb4IvVB1g2xWUMK1VcBaHS7OiFGToGTz+/UptYT51N/SrgFycBYb3lO
 opXNAdVXTTRFm+bIPY1i2wxqmn+ZbOydZoo1tJEsALP1KlnXA+HEuBIV39KPxiwugRMLyBXj0nf
 p7Xm3CZs0KeNB+SG97soEyt7bPGoeFgGBy5BwfjKZN/A+JJMFAgnFP1puW0xdI/DgpC6H6U0
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=6894730f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=eg5YlAqusF3bNEAdQk0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=970 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508070073


On 8/7/25 1:57 PM, Wei Yang wrote:
> Currently it hard coded the number of hugepage to check for
> check_huge_anon(), but we already have the number passed in.
>
> Do the check based on the number of hugepage passed in is more
> reasonable.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>   tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 44a3f8a58806..bf40e6b121ab 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -111,7 +111,7 @@ static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hp
>   	unsigned long rss_anon_before, rss_anon_after;
>   	size_t i;
>   
> -	if (!check_huge_anon(one_page, 4, pmd_pagesize))
> +	if (!check_huge_anon(one_page, nr_hpages, pmd_pagesize))
>   		ksft_exit_fail_msg("No THP is allocated\n");
>   
>   	rss_anon_before = rss_anon();

LGTM

reviewed-by: Donet Tom <donettom@linux.ibm.com>



