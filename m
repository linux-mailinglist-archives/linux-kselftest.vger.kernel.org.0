Return-Path: <linux-kselftest+bounces-36791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD65AFDEED
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 06:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54571AA0E91
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 04:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FDE26773C;
	Wed,  9 Jul 2025 04:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h7oE+Yge"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC68B3208;
	Wed,  9 Jul 2025 04:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037026; cv=none; b=mxH37f8bEeOIh7QR813aHAXuII0/BHiPsWDkC8XR7T3VoKpDkvReF//kD6W0Q2bZH0a6rMEofVKsLFVbMPvVsU5gxvSfiSsDbPA18yeJ3hWyQruk0nWDHKBj/w5eGjQnhREk8wxJKT9Hw/hDXSRjf9TvabW2ulosbj86ZAMrDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037026; c=relaxed/simple;
	bh=/l4cfGLDS6AGtndGwU5W5f0KphHso5AXugN/m/uYjPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYIVny/uBb4uvfOccKUifCG30XXQ54wg1SOYbar1xWMo3GLBk4/nw7fH/K+63FxqVAIWv3r0sVIceeLG0UrWVa6bANsz5hlLETMIbHCzv3GWQ2Nls8DX5ryiciOeWUR51yE21oFe1BCYtY1lbAdFa2Sg9nuEhJtyf3l4Bl15L9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h7oE+Yge; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568H9vHr021381;
	Wed, 9 Jul 2025 04:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DlXWq/
	411ueEkqzLGqQzZCN8hdxa3O/+rcqq+PoXxd0=; b=h7oE+YgeQ2sXh7Ov/StHpf
	61Ya+HpaOJsXF3WBMfMlOTW/iFpNIT9Y4aVslQbyRjKdCFlNf15toQPASI5VJVU1
	2KzCwjwY9vgERrXaDos9tTL0FF8WNfGXFT+AcUTtLxLQMnI3EvLDBUel7ru9LPQT
	MTkJ1Io1yIrzgRXB/YEQNA42MUjPaMIhrKWziQyzqSiMr5bY8EvtrUDoiBwSF5XO
	r45iHA7Ylag0e+RTY9Tcy98pL+I/r5nePAoJfMNU4y3f7cWfZ0xZXnAEmmNa1a87
	+o3rQ3ilgeRMTHqh47Inso3cf+T+VwVONVDIYqF6I8aMVbjJjkCWKJtrOCiS0Ufg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puss43uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 04:56:50 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5694unIp028717;
	Wed, 9 Jul 2025 04:56:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puss43ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 04:56:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5692540a010841;
	Wed, 9 Jul 2025 04:56:48 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qes06nhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 04:56:48 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5694ulDO16515588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 04:56:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7827758054;
	Wed,  9 Jul 2025 04:56:47 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D19AB5803F;
	Wed,  9 Jul 2025 04:56:41 +0000 (GMT)
Received: from [9.124.214.51] (unknown [9.124.214.51])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 04:56:41 +0000 (GMT)
Message-ID: <8f174b94-8b87-47f8-a533-d6c4020cab2a@linux.ibm.com>
Date: Wed, 9 Jul 2025 10:26:39 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: fix split_huge_page_test for folio_split()
 tests.
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250709012800.3225727-1-ziy@nvidia.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250709012800.3225727-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686df692 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=vaSJ1NGlu7uV31DG9JwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: G2H5mlqWwfGvIaxv4ojnQyuoF99dXNy2
X-Proofpoint-ORIG-GUID: a1UNkvOqO_f8zTACf69J-Ere4HV9P9N8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA0MCBTYWx0ZWRfX09BsIRavhHaD 0pRNw06GYixOVeLqqjYK+/jjiipzgUvj8+AZKtDWXK1yC9LvkXUc2BdqG+iqQgot+KXr7mXQj5b M4uG6V1w9jTHd494e0YlHC1+/x6XJxz39fn+4tGm3Qirburzkt+y1/GaOy/xaplNahBOhmU6jGb
 V5orutHiO7JPV4WJZXAhIkdqixX3khQC00yYeKhJKNdmFyRQit0F6pWH+F7lz1SxYD7oPaTxpUW ITuiCreX9EQqBoxrI0hnwAO9TKe5GzUXGOTlUBtEMpkHUzU4nrjR7zUcbN7BWq7FxI5yFwBfCcb BtjAHMO5cDmREJlRsea3iZC/8QlXMA0liwrYhmj1yic6LQNgsYWL7GrwoedhrAnclj5rBluURrl
 ySlEgGD5iWGNQ17JVojX7JayKDvo6ij1JsrqBwPUvku+XgMgJ8jgWxs3Xh/OeZXVH/6pdmTt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090040


On 7/9/25 6:57 AM, Zi Yan wrote:

Hi Zi Yan

> PID_FMT does not have an offset field, so folio_split() tests are not
> performed. Add PID_FMT_OFFSET with an offset field and use it to perform
> folio_split() tests.
>
> Fixes: 80a5c494c89f ("selftests/mm: add tests for folio_split(), buddy allocator like split")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   tools/testing/selftests/mm/split_huge_page_test.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index aa7400ed0e99..f0d9c035641d 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -31,6 +31,7 @@ uint64_t pmd_pagesize;
>   #define INPUT_MAX 80
>   
>   #define PID_FMT "%d,0x%lx,0x%lx,%d"
> +#define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
>   #define PATH_FMT "%s,0x%lx,0x%lx,%d"
>   
>   #define PFN_MASK     ((1UL<<55)-1)
> @@ -483,7 +484,7 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
>   		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
>   			      (uint64_t)addr + fd_size, order);
>   	else
> -		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
> +		write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)addr,
>   			      (uint64_t)addr + fd_size, order, offset);
>   
>   	for (i = 0; i < fd_size; i++)
>

This looks good to me.

I tested it on my system, and the test is passing.

ok 17 Split PMD-mapped pagecache folio to order 0 at in-folio offset 0 
passed
ok 18 Split PMD-mapped pagecache folio to order 0 at in-folio offset 8 
passed
ok 19 Split PMD-mapped pagecache folio to order 0 at in-folio offset 16 
passed
ok 20 Split PMD-mapped pagecache folio to order 0 at in-folio offset 24 
passed
ok 21 Split PMD-mapped pagecache folio to order 1 at in-folio offset 0 
passed
ok 22 Split PMD-mapped pagecache folio to order 1 at in-folio offset 8 
passed
ok 23 Split PMD-mapped pagecache folio to order 1 at in-folio offset 16 
passed
ok 24 Split PMD-mapped pagecache folio to order 1 at in-folio offset 24 
passed
ok 25 Split PMD-mapped pagecache folio to order 2 at in-folio offset 0 
passed
ok 26 Split PMD-mapped pagecache folio to order 2 at in-folio offset 8 
passed
ok 27 Split PMD-mapped pagecache folio to order 2 at in-folio offset 16 
passed
ok 28 Split PMD-mapped pagecache folio to order 2 at in-folio offset 24 
passed
ok 29 Split PMD-mapped pagecache folio to order 3 at in-folio offset 0 
passed
ok 30 Split PMD-mapped pagecache folio to order 3 at in-folio offset 8 
passed
ok 31 Split PMD-mapped pagecache folio to order 3 at in-folio offset 16 
passed
ok 32 Split PMD-mapped pagecache folio to order 3 at in-folio offset 24 
passed
ok 33 Split PMD-mapped pagecache folio to order 4 at in-folio offset 0 
passed
ok 34 Split PMD-mapped pagecache folio to order 4 at in-folio offset 16 
passed


Feel free to add:

Reviewed-by: Donet Tom <donettom@linux.ibm.com>
Tested-by : Donet Tom <donettom@linux.ibm.com>




