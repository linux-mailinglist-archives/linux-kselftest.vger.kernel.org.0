Return-Path: <linux-kselftest+bounces-34890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD5CAD8A06
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF231899963
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 11:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9142D5C63;
	Fri, 13 Jun 2025 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eaG947V/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0E2D540C
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 11:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749812961; cv=none; b=CBBZoA4JYLzMCNyV0W9NzJFzU2XNebbNxIa7iiB4jTADc2JiBJOSPy/yJ1XqfZPgbq3BkTM9Ti6m/s6RMV6zTNVWuWwLlVxrkvoSuaYMG7LVMUr55XkEx4Bd3ZzejmmUsrUm3PCcqfEnSFhDMmnEKABLGgdaFyXSsBSF1sPvzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749812961; c=relaxed/simple;
	bh=sLM3LyGIl4AonWmOG2EJLgqpjUFWU1h8GjEFyyifGkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4W/RCfl0Y8WD6MA1VyIbwuMg537aVlfEOR51ev6gkNwaDbZOtdzdf/EV59fnBlaJufHjPeo8Ce0ytEdhhs319NuK01ItsxiVQ/c6+CZ5aPMPWvxjbc9BcCw6PewS/GZGrbKEpIS++Ezko+03f7D7BwEU33NILO7sI3gOTX1qWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eaG947V/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55D6s2ci002687;
	Fri, 13 Jun 2025 11:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aI7yWc
	UXAkTVO6INXJPDq3VoxAe3kZ0he1UHnG9lOmM=; b=eaG947V/gbC/vXv2xFO3Zl
	fxEm/eVacgDStw91Inqa4xUnXz9wcfefekqEC4YMPzKS2YMTUMwjIuFfMJ6/nAWu
	RWiFaqhCOtIgjftZ5U69Q8LDHDnzwCwhEHH11yJV9n4jR3NXOSWdU7wRX6ecIpRW
	VAEgc0JJ6SbGR5JU2I/O6y0ahJ2VclOjQinJ6JIzjHCh5q/IstbPyvVMSWKShDvk
	AQVe9fSFUTJ1jcJhJI8qsL0c7foCBV0O83eY/TJ9Pp8CaxcbGyopNwRifT8oOdgj
	SMBqI8njz0xp+78x6MWD+xoxpUlktxPh2UI7j+EiZ6s0pnGaM9Y8hXffy2MsAmvA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 477vyw6kqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 11:08:57 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55DB8uDT028887;
	Fri, 13 Jun 2025 11:08:56 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 477vyw6kq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 11:08:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55D9UBUZ015192;
	Fri, 13 Jun 2025 11:08:55 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtswt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 11:08:55 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55DB8tmu46268812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 11:08:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76AEB58065;
	Fri, 13 Jun 2025 11:08:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 071CA58062;
	Fri, 13 Jun 2025 11:08:51 +0000 (GMT)
Received: from [9.109.245.113] (unknown [9.109.245.113])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Jun 2025 11:08:50 +0000 (GMT)
Message-ID: <a481d2c4-ae77-463e-8010-33157501b131@linux.ibm.com>
Date: Fri, 13 Jun 2025 16:38:49 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm: Add configs to fix testcase failure
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
        pfalcato@suse.de
Cc: vbabka@suse.cz, jannh@google.com, pulehui@huawei.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, aishwarya.tcv@arm.com,
        broonie@kernel.org, ryan.roberts@arm.com
References: <20250613034912.53791-1-dev.jain@arm.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250613034912.53791-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=F5RXdrhN c=1 sm=1 tr=0 ts=684c06c9 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8
 a=XEzngQ3GfsX9Zgn8DdkA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: C8PaV-s6590foLgExVnDI5B1OXwvI1vh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA3OCBTYWx0ZWRfX/hRTDNXZ3CD3 Ke+y0I3Hkqwj32qIRFmfobiKFj5d85JIOYmg/z9D5W8UfRM3kK4F/q5IsAhLbU9QXmfyyaVd5Db tBpQM3lHSVTzDmOEI1ZjBgp5fOkHB94vxshTZusKJ1uUjb97inMTY9ldJwrGf1QLLU37qCWxeT2
 vdOBohkv4Qm50QwsE5GmSBoyJ366k9/wBR2puXeFHouOpk3AYcUQh2aDUqLZIVE3nZfGDdhw8Ol p3V87NyPwt951ORn5cEkyQ9Yq+3TaWuo2LniEzLaNShoLCytlr04OtLgXVw96hRvub2lU/Jfnpc 1cywT6DSePK0nIXKhmst9S7CVC2D6MEvjgYqzJ4Nhoc8U3UjYhokN+OM32hyYCIxr0CNrop0BTi
 VXuC8/iW5Z+Mq9+3ObOWZD6go5ERrw254NyXm7Ls1IhDFnrGnhoFx1H2et3GDO1RRVZHQw4a
X-Proofpoint-ORIG-GUID: JY7gRuUqZPp0GxlBzIVB-WW_dKEG2GDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130078


On 6/13/25 9:19 AM, Dev Jain wrote:
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
> CONFIG_FTRACE. Therefore add these configs to selftests/mm/config so that
> CI systems can include this config in the kernel build. To be completely
> safe, add CONFIG_PROFILING too, to enable the dependency chain
> PROFILING -> PERF_EVENTS -> UPROBE_EVENTS -> UPROBES.
>
> Fixes: efe99fabeb11b ("selftests/mm: add test about uprobe pte be orphan during vma merge")
> Reported-by: Aishwarya <aishwarya.tcv@arm.com>
> Closes: https://lore.kernel.org/all/20250610103729.72440-1-aishwarya.tcv@arm.com/
> Tested-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Tested-by : Donet Tom <donettom@linux.ibm.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> v1->v2:
>   - Add CONFIG_UPROBES (Mark Brown)
>   - Add CONFIG_PROFILING (Lorenzo)
>
>   tools/testing/selftests/mm/config | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests/mm/config
> index a28baa536332..deba93379c80 100644
> --- a/tools/testing/selftests/mm/config
> +++ b/tools/testing/selftests/mm/config
> @@ -8,3 +8,6 @@ CONFIG_GUP_TEST=y
>   CONFIG_TRANSPARENT_HUGEPAGE=y
>   CONFIG_MEM_SOFT_DIRTY=y
>   CONFIG_ANON_VMA_NAME=y
> +CONFIG_FTRACE=y
> +CONFIG_PROFILING=y
> +CONFIG_UPROBES=y


This looks good to me.

Reviewed-by: Donet Tom <donettom@linux.ibm.com>



