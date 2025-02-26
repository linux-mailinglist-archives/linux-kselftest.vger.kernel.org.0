Return-Path: <linux-kselftest+bounces-27608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED78A46038
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 14:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868293B0525
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CFD1DE2A1;
	Wed, 26 Feb 2025 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W90ilfAt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E042A8B;
	Wed, 26 Feb 2025 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575184; cv=none; b=iMgo1YX0Fvrfi9UGOxPJDoUz2HGF7NDtPlum/q5EGdBp1FbarkLN40yUF8PPeQrDJoDV03pgMOC6h4pcg10vp1JbFRUlMWjW4VXJ1Sb2J7Mg4G6ijCImxhu2ayJAccRcbXnY/WCUbTEfxnry5Vy0fq4PA7uDcDjFrpjbQ3SGeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575184; c=relaxed/simple;
	bh=ZqchcqI2FkHT1qBiJQSk6eN2q4a9QuFS8ZMIoFhRXYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvivfYQG0pw21cKXaQ5qAG7S+Y9f3R89uiyQVjXSeGOW01x9JzK+FgS1hW8+0EfcbsWYi5HokZ4o1r/FN0/19uTlWpZQt9t57feYvf/qNjHqvID+zM2G01zntDAlBpogjJGncU/Af06RG/DUkUpEUa88s+/ksLvbYcvWWGKP9Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W90ilfAt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QCjQxI012268;
	Wed, 26 Feb 2025 13:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Sjtn6a
	QSkW7Zb/PPaco0QhyyJeAQF+aQOBPQNDVG+jY=; b=W90ilfAticGKauusKeP4E9
	rdBTAI4cod+aWIc1lzirWUQepkCQtPVIBnvwNUgTDv4WbXEg9yVxhKGDxfkSjHwa
	8ZnUyj1M62G+VxRI7MUIclyKaz1NuiDVaoy2fUOiZR+ApWvitE5fJcG/6l5r/M8h
	X5XzKEZKncKmACG+p8GKR+7krvXm+pUTIHMDvLdECt51oLpLxumdbuBSjM4W6G+Z
	0q/qzxZBIsB1KpUD6a0IttFlAOiUPqxQAkmt6ZKc4H20aEaUIQ2C5NhshglO3M5V
	PPcNhhXyiXpoH0YezsxFzhr5mvJKNu89lsuiM945JjZfK+O64VOzT91rpQqVrzZw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451s19asd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 13:05:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QB6qqQ012491;
	Wed, 26 Feb 2025 13:05:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9yjx1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 13:05:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QD5si856492352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 13:05:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D000220040;
	Wed, 26 Feb 2025 13:05:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E84A2004B;
	Wed, 26 Feb 2025 13:05:53 +0000 (GMT)
Received: from [9.124.212.40] (unknown [9.124.212.40])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 13:05:53 +0000 (GMT)
Message-ID: <93e10bcf-3537-45f0-b282-ae4fd4573c6e@linux.ibm.com>
Date: Wed, 26 Feb 2025 18:35:52 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] selftests: sched: skip cs_prctl_test for systems
 with core scheduling disabled
To: Sinadin Shan <sinadin.shan@oracle.com>, shuah@kernel.org,
        chris.hyser@oracle.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250225200910.260569-1-sinadin.shan@oracle.com>
 <20250225200910.260569-3-sinadin.shan@oracle.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250225200910.260569-3-sinadin.shan@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XIZLN3TF-z33Jl9yrPg-b5kxRpLWKHfg
X-Proofpoint-ORIG-GUID: XIZLN3TF-z33Jl9yrPg-b5kxRpLWKHfg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260104



On 2/26/25 01:39, Sinadin Shan wrote:
> For kernels with CONFIG_SCHED_CORE=n, the sched selftest cs_prctl_test
> fails with "Not a core sched system" error. Change this to gracefully
> skip the test for systems with core scheduling disabled. Exiting early
> would also ensure failures reported in obtaining cookie are valid
> failures and not because core scheduling isn't supported.
> 
> Skip cs_prctl_test for systems with CONFIG_SCHED_CORE=n
> 
> Signed-off-by: Sinadin Shan <sinadin.shan@oracle.com>
> ---
>   tools/testing/selftests/sched/cs_prctl_test.c | 34 ++++++++++++++++++-
>   1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
> index 52d97fae4dbd8..5b0047b50e640 100644
> --- a/tools/testing/selftests/sched/cs_prctl_test.c
> +++ b/tools/testing/selftests/sched/cs_prctl_test.c
> @@ -109,6 +109,36 @@ static void handle_usage(int rc, char *msg)
>   	exit(rc);
>   }
>   
> +static void check_core_sched(void)
> +{
> +	unsigned long long cookie;
> +	int ret, num_max_process;
> +	char buffer[32];
> +
> +	FILE *fp = fopen("/proc/sys/kernel/pid_max", "r");
> +
> +	if (fp == NULL) {
> +		perror("Failed to obtain max process number");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (fgets(buffer, sizeof(buffer), fp) == NULL) {
> +		fclose(fp);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	num_max_process = atoi(buffer);
> +	fclose(fp);
> +
> +	ret = prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, num_max_process+1, PIDTYPE_PID,
> +			(unsigned long)&cookie);
> +	if (ret == -1 && errno != ESRCH) {
> +		perror("prctl failed");
> +		printf("Core sched not supported, hence skipping tests\n");
> +		exit(4);
> +	}
> +}
> +
>   static unsigned long get_cs_cookie(int pid)
>   {
>   	unsigned long long cookie;
> @@ -117,7 +147,7 @@ static unsigned long get_cs_cookie(int pid)
>   	ret = prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid, PIDTYPE_PID,
>   		    (unsigned long)&cookie);
>   	if (ret) {
> -		printf("Not a core sched system\n");
> +		printf("Failed to get cookie\n");
>   		return -1UL;
>   	}
>   
> @@ -270,6 +300,8 @@ int main(int argc, char *argv[])
>   	if (keypress)
>   		delay = -1;
>   
> +	check_core_sched();
> +
>   	srand(time(NULL));
>   
>   	/* put into separate process group */


This works for me in my workflow. I don't know full selftest framework 
or how to trigger it.

When CONFIG_SCHED_CORE=n
-----------------------------
./cs_prctl_test
prctl failed: Invalid argument
Core sched not supported, hence skipping tests


When CONFIG_SCHED_CORE=y
-----------------------------
./cs_prctl_test
(369) PASSED: _prctl(PR_SCHED_CORE, PR_SCHED_CORE_MAX, 0, PIDTYPE_PGID, 
0) < 0 && errno == EINVAL
-1 = prctl(62, 2, 0, 2, 1)
(372) PASSED: _prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, 0, 
PIDTYPE_PGID, 1) < 0 && errno == EINVAL
SUCCESS !!!


So for this patch,
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>


