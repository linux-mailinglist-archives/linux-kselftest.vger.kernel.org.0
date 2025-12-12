Return-Path: <linux-kselftest+bounces-47509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F415CCB8C31
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 13:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 076663064E60
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC09D3161A5;
	Fri, 12 Dec 2025 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EAB+6RXg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC83218A6;
	Fri, 12 Dec 2025 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765540924; cv=none; b=iTkLP8ejjgwoPAiZirJV1pPoyF5Zml+qV0AnKOff7fjATd9tSbWDtRev3ix2E3neNmV9gBIgT7FgDjeucYf8gFb3q05uZjglVkE+/iY7UPfqGgcb7I4K4YhsNBB7j7TnK4AgpcYz+7mnOs+/awPbPsd3tkLcWOEeRd0JPHczvis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765540924; c=relaxed/simple;
	bh=bgISNmaIgWcegkblebGKLzHkBeTWyZt2bMBC3KFX/mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K5Kdc5eq0MDvrvZPYeAYLoNI6hPm2yQk1PZvlS6/K0kQ/ewyzwE9chojzegAo2I090Q1J72jL18JeYWvdJGWcEWDpiTypSjJkwv58bqZbkWhapZ6Eg8yzG2aA3HZLo9QPFXXMQ+g5p02WdiQBUBZlUVO42Wfszbu5AWeba3561A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EAB+6RXg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC4RkhQ022275;
	Fri, 12 Dec 2025 12:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3z+tc1
	NpR5UUK27rqzSVFLKc+7teQZCqO8GScwzmUXA=; b=EAB+6RXgQzo6yFR44YXZf5
	X3tDcwqkeIZO7uOFv+tB/jh4A0Pj5biLs9UUy60/zTS43JRWRj9KNMzMa+rYDIjA
	jYV46CB5n9wthbViCsWDOij84+/r6jLhFA6bWusK+4CysHSOp9p/Z+gFYzBpf7SC
	ZueIHjqc85ZB+y0gnkXGKcextCJpDQrUXF8jptqm2x7Ta7+41coQZPsylNKAv8G0
	Xu/nfEI76z65z1w0WJpW0iQtmzFC4c0lCCcIHXaLrBtoVzZOShJY/Mb/EmGoRZPI
	WkcEXRR/Kqt8c8vkYEHL9RE+hp5WhaT5Le1nGciBJoHqF+EPnJx1qQiNJ4TWjd4g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0kd65b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 12:01:45 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BCBxjH7003043;
	Fri, 12 Dec 2025 12:01:45 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0kd657-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 12:01:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC9uA5e030331;
	Fri, 12 Dec 2025 12:01:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4avxtskvb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 12:01:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BCC1gYJ44171672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 12:01:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FC422004D;
	Fri, 12 Dec 2025 12:01:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C66620040;
	Fri, 12 Dec 2025 12:01:36 +0000 (GMT)
Received: from [9.61.250.41] (unknown [9.61.250.41])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Dec 2025 12:01:36 +0000 (GMT)
Message-ID: <60dfb410-b814-4db5-b928-6793fba012a4@linux.ibm.com>
Date: Fri, 12 Dec 2025 17:31:34 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests/powerpc/pmu/: Add
 check_extended_reg_test to .gitignore
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        shuah@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org
References: <20250922004439.2395-1-krishnagopi487@gmail.com>
Content-Language: en-US
From: Aditya Bodkhe <adityab1@linux.ibm.com>
In-Reply-To: <20250922004439.2395-1-krishnagopi487@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=693c0429 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=wQKQ9SNmtxRVP8ipeUEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nV8BXba4YoY5DJvZBK1AYrhH6zswStZi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfX8HnwRLd2e+WU
 zk1orW3QtNGqzd7dsilTBoaLnt8QEdltcd8WJepODGKC0h9obrpws6VWLZmzHmAmCNGgdf1xneg
 CKRChMzUtw4wbmSgypk9Dn4GxMmJ8ox6nzHn+LEji9fhgIyOjgfpPII4xp3Av1QzzFFU378T4GR
 zpfjWWDqm8hMUek18MbSAbSVngEP3UUcZQ0i0JDAlrIYfBUPC6jPBtT77+h0rgUJxPsRWYabz4a
 crWiNSseSYQ2P0eBvQZ5tqzkJKUDznE7TX6chBvvAUe/2ORzQJDHXgtfHj3NMb+tsu4iPWk8EyI
 /FB8lCIcJVeO3F5xUQtx7A+ljyAzWOqKv3dhGtd+44z3d7zO+ZaaTTp3WCE9KV4RT0iTPqcPQJP
 dHedoZh/8J3ptgxz0QrU/gHq3hZpbA==
X-Proofpoint-GUID: GxgCxAftOxTNCp4AAKpB7jSYyLNmPx95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016


On 22/09/25 6:11 am, Gopi Krishna Menon wrote:
> Add the check_extended_reg_test binary to .gitignore to avoid accidentally
> staging the build artifact.
>
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
>   tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore b/tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore
> index f93b4c7c3a8a..ea29228334e8 100644
> --- a/tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore
> +++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/.gitignore
> @@ -1,5 +1,6 @@
>   bhrb_filter_map_test
>   bhrb_no_crash_wo_pmu_test
> +check_extended_reg_test
>   intr_regs_no_crash_wo_pmu_test
>   mmcr0_cc56run_test
>   mmcr0_exceptionbits_test

I tested this patch , the file is correctly ignored through the updated 
.gitignore entry.

Tested-by: Aditya Bodkhe <adityab1@linux.ibm.com>

Thanks,
Aditya


