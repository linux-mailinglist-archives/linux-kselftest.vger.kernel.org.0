Return-Path: <linux-kselftest+bounces-35443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC4AAE1DE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 16:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5242A5A68AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0882BD5B4;
	Fri, 20 Jun 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JRZ5pFbv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68192BD5AF;
	Fri, 20 Jun 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750431235; cv=none; b=MJgPDON//q1n61o0C5T+uoqMK7cF1K/92Hwp9N+wevN1VxU1vJInS0ucfbLG1I1Cg6IwIZDi4bLRZ2U6zBerI0vj+Fzjs3ud3bwp86dcF6NMpM9FGlMNXJmfu8FEeHPD874x2ML0rIBFdJiduuX4oxgCH5bZPQOj0oL+zlxsBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750431235; c=relaxed/simple;
	bh=5HJHKUKnSy0X8qereFxAeJBjXssNqqPNsci6MxFY3eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOBZTjtqrXANbW7+Cx/nVH7KA2A7SisV4bg/opLI0ptU/p3yWzaSBBG5YF4uJPCU5GswrIwMqE9boIqqJ/1w+0GSaOENu8x9SOfXBBT6Y+JVMrgoV7YZ/8qgv/2BdpK9FPMvLBFbG2ZD4AXPaprJkIZlrlSEVoAKvGMQnuodisE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JRZ5pFbv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K9hfjr016396;
	Fri, 20 Jun 2025 14:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vBq5jk
	WYpGasBWlEG+JUqZZjNkz2GJoDETICN+CG4pM=; b=JRZ5pFbvCCkwbotWi/CwNH
	oqjzlscI2yXCn8HXMP5mdQCQuL0EGn0oeP8iIQZETwcbOkEpz9PFMtmTK4qHraZH
	cRm85wLX99h1KKvx5xwsz7T+/U7hzh5XjgqC+1enxWKy2Xx7DR76iGgTeA6FOiWn
	HOjXrg4XaODhakRg//mBAeYLS3x0pJcAPKzcubODd1v1eJz96RkitO0uT/0zzkyc
	Qkw9j2yFvFy89V6OBPoq4yFi8yKVYjr6mvqbILbxX1+GO0Vos1pLHcxs1Yqw374g
	SqQY0cXy8fqApUJVkcw+jn9pCQ0AA14TPM1oTV78tki+CwWvd4FsrIPYqxnxMUDQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygnuvj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 14:53:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55KDidtc005514;
	Fri, 20 Jun 2025 14:53:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mwmkk8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 14:53:21 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55KErGo927656938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 14:53:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FD0E5805D;
	Fri, 20 Jun 2025 14:53:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFEB858054;
	Fri, 20 Jun 2025 14:53:17 +0000 (GMT)
Received: from [9.124.223.89] (unknown [9.124.223.89])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Jun 2025 14:53:17 +0000 (GMT)
Message-ID: <9841e7bf-7429-44fa-a8e2-a39f54c69d84@linux.ibm.com>
Date: Fri, 20 Jun 2025 20:23:16 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Fix validate_addr helper
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, ryan.roberts@arm.com,
        lorenzo.stoakes@oracle.com, david@redhat.com
References: <20250620111150.50344-1-dev.jain@arm.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250620111150.50344-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEwNSBTYWx0ZWRfX548P3ByGJ1B9 w4MIOdo7UFmZ0aX0CdaYF9MFTGlwTTG+r4Zf7tBsdH8K8bYlhTwnIERTdUFpHvwwNbram2Wo53e Swbv1ynsJjfv0lcGiHkepC9iev/9Z73O4OMrcVGRH5Jv5u7X2Sz5pEpTlIDvPVHR14UHA/BgL6t
 jP+vOqiP9ze5Xogomx0CoiBYhLeB+GHqnQ0X/53dXLNL/x9BclQ0Dk2cESPMtwpHSBd36DBCW5X leGekoiDoMgcFV2zNchlt53+7B+uipBW4n+TqqmVTtD+dgIKc7XN4EBxGT79g52hsk5Jhn/6yth bq7dwJssRpiqT2eeHc6FRMU9TiK34S954olGBXTCbzsO+9EG5AsZiTDLGBlYwdBXhfbi6HuTPIp
 qmCebe98q8GjnkDub1jM/FQpDKYXVOxxd1sGyo9ErKnwS7WPRR6zD62L08IsCs5Eimvi0gnB
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=685575e2 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=H2XVYxjsRQ50NXrrMqMA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: lRQVLwiZdDPryQ5uzdmJaZg62wJwLdtY
X-Proofpoint-GUID: lRQVLwiZdDPryQ5uzdmJaZg62wJwLdtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200105


On 6/20/25 4:41 PM, Dev Jain wrote:
> validate_addr() function checks whether the address returned by mmap()
> lies in the low or high VA space, according to whether a high addr hint
> was passed or not. The fix commit mentioned below changed the code in
> such a way that this function will always return failure when passed
> high_addr == 1; addr will be >= HIGH_ADDR_MARK always, we will fall
> down to "if (addr < HIGH_ADDR_MARK)" and return failure. Fix this.
>
> Fixes: d1d86ce28d0f ("selftests/mm: virtual_address_range: conform to TAP format output")
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   tools/testing/selftests/mm/virtual_address_range.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index b380e102b22f..169dbd692bf5 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -77,8 +77,11 @@ static void validate_addr(char *ptr, int high_addr)
>   {
>   	unsigned long addr = (unsigned long) ptr;
>   
> -	if (high_addr && addr < HIGH_ADDR_MARK)
> -		ksft_exit_fail_msg("Bad address %lx\n", addr);
> +	if (high_addr) {
> +		if (addr < HIGH_ADDR_MARK)
> +			ksft_exit_fail_msg("Bad address %lx\n", addr);
> +		return;
> +	}
>   
>   	if (addr > HIGH_ADDR_MARK)
>   		ksft_exit_fail_msg("Bad address %lx\n", addr);


This looks good to me. Feel free to add

Reviewed-by: Donet Tom <donettom@linux.ibm.com>


