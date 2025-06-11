Return-Path: <linux-kselftest+bounces-34713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4820AD57F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC04B1729BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B452367AF;
	Wed, 11 Jun 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Udt7Nh4+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1850E44C63
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650590; cv=none; b=TwdVtbQNTnVWY6zJG0TCA3j3GRPLRicDuQwr0um7kjxehMMtVUOx4tCjpWHc0W8yhcSm/L7h4Wr2dqoM/T6VdJA+8FnYTgcpH4xl/NuxSJb9Ry/MrGICpwwaiRnDtvux53HPWqs8O4YZKtYebx5x9cE8pD4s30KQUCIYtT1s1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650590; c=relaxed/simple;
	bh=yDTLhokVKH2eYpHnFVKFxlnXiOi0gGqzJkf3c1/4lFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSBAwQaPbZPW/3t29N5+PAFJ3zQE8QShgzpRvMunssXkbbC4TZJK5JhOskwnBQOavoTEvFKbYTHAtm25f/L+QdJYcKJSKdWm91yF0sslB/P7Fl4pf+Ut6nFuizD2jgcQ1JJcVmC9U0WyPZ2GRSYhHEocnYHt/Pwai7LDqBtT8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Udt7Nh4+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B3x433026302;
	Wed, 11 Jun 2025 14:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4mtF0C
	60/o8tiA4LgpsglfOrD+yXNiNe2UWozzIZjns=; b=Udt7Nh4+CZMiqrffIQp5Od
	x3XCAb/r8AklLkBwszkmeVHLu9RK8fNY/eTTbt6PatkSupHdkMvdfnTwwQZBjpPG
	XkIHDeeaDMW0shTq0uBUAqvN/DqaWNTKoB6eY6k/LbK/AaUgKONSnFaxCdTAGEbE
	m3rdHWeZA/8AhAnAaQ/OGHqjZ9qobA9ikyAh0aXBr+1l35eUB+2IJnAwNzG0euna
	17rcSaSZXo/y37NnZ8YFsjnxAh1JVVYeEwMPF9LLZ/gG86eYaVDpaKr4m2eeAXdK
	jSPGjn7HENAqIUI4NrmpcOYfOa/PzKQbSXcyv0v5PuFSzN3kIXthOcqwkOdMppKA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup4vjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 14:02:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55BDtGEf012037;
	Wed, 11 Jun 2025 14:02:06 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup4vjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 14:02:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55BATopd003333;
	Wed, 11 Jun 2025 14:02:05 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4751ykqrsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 14:02:05 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55BE24a564094596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 14:02:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97A7C58061;
	Wed, 11 Jun 2025 14:02:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5CE25805D;
	Wed, 11 Jun 2025 14:01:59 +0000 (GMT)
Received: from [9.109.245.113] (unknown [9.109.245.113])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 14:01:59 +0000 (GMT)
Message-ID: <90159bff-4747-4ea5-914a-b4a06f0409c9@linux.ibm.com>
Date: Wed, 11 Jun 2025 19:31:58 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Add CONFIG_FTRACE to config
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
        pfalcato@suse.de
Cc: vbabka@suse.cz, jannh@google.com, pulehui@huawei.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, aishwarya.tcv@arm.com,
        broonie@kernel.org, ryan.roberts@arm.com
References: <20250611121011.23888-1-dev.jain@arm.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250611121011.23888-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=68498c5e cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=XEzngQ3GfsX9Zgn8DdkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDExNSBTYWx0ZWRfXxAIBAcvxP0EW 04ZtUulwRSxMgDBs5hHFwuqfw3rC+nQi9+/lBvatZw1+k/ROAg2N28UlNs63nwg2Td3Ym1s+lJe v9LTChtJAtWYRcvLll7pmSTVtXQ86ayeqe/X+4yMEKkHMoWjbwOujBKgAnhY0jaq5mzLqPGokBq
 lm6i3CXM9swxvUd7tshCIptlXbAzInRLxJRiia5TZI3rpaCRLLMmDx2mW5mtECNyqEawnKu2KQo Cp2YH/GPUgCFyBD6+A9BjvNBHdcE1athDj4LFdXGELQcVgnIYYFTcoWMFkc8Ny1vmITia5+iZVr 2Ofn+3fQw1qZAt4pf6y213IctOVjEZj4esg8P+WaYhq6gM5ufXIOZyGIITuzSlsie7R65Kmzfbi
 Gga805FPOWkJ//sFRuWv0I0KHdZWeYzFa/h/TVu1Q3USOQYqPZQu03nunR4eIunuHLrSAaFY
X-Proofpoint-GUID: B8ZbJ8-SYOAYRMs2hvb70-kHGfp4ARTc
X-Proofpoint-ORIG-GUID: lYAi-sABKWSOYAzxPuwwH7-9W-tNIQTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110115


On 6/11/25 5:40 PM, Dev Jain wrote:
> If CONFIG_UPROBES is not set, a merge subtest fails:
>
> Failure log:
>
>    7151 12:46:54.627936  # # #  RUN           merge.handle_uprobe_upon_merged_vma ...
>    7152 12:46:54.639014  # # f /sys/bus/event_source/devices/uprobe/type
>    7153 12:46:54.639306  # # fopen: No such file or directory
>    7154 12:46:54.650451  # # # merge.c:473:handle_uprobe_upon_merged_vma:Expected read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) (1) == 0 (0)
>    7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test terminated by assertion
>    7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_merged_vma
>    7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vma
>
> CONFIG_UPROBES is enabled by CONFIG_UPROBE_EVENTS, which gets enabled by
> CONFIG_FTRACE. Therefore add this config to selftests/mm/config so that
> CI systems can include this config in the kernel build.
>
> Fixes: efe99fabeb11b ("selftests/mm: add test about uprobe pte be orphan during vma merge")
> Reported-by: Aishwarya <aishwarya.tcv@arm.com>
> Closes: https://lore.kernel.org/all/20250610103729.72440-1-aishwarya.tcv@arm.com/
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   tools/testing/selftests/mm/config | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests/mm/config
> index a28baa536332..e600b41030c1 100644
> --- a/tools/testing/selftests/mm/config
> +++ b/tools/testing/selftests/mm/config
> @@ -8,3 +8,4 @@ CONFIG_GUP_TEST=y
>   CONFIG_TRANSPARENT_HUGEPAGE=y
>   CONFIG_MEM_SOFT_DIRTY=y
>   CONFIG_ANON_VMA_NAME=y
> +CONFIG_FTRACE=y

I have tested this patch, and it is working fine.

ok 7 merge.forked_source_vma
#  RUN           merge.handle_uprobe_upon_merged_vma ...
#            OK  merge.handle_uprobe_upon_merged_vma
ok 8 merge.handle_uprobe_upon_merged_vma
# PASSED: 8 / 8 tests passed.


Tested-by : Donet Tom <donettom@linux.ibm.com>



