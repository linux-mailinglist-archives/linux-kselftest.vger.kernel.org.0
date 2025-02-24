Return-Path: <linux-kselftest+bounces-27321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2337BA41733
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 09:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F41174ADE
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 08:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1391925AB;
	Mon, 24 Feb 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C5ox613m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84BF158558;
	Mon, 24 Feb 2025 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385221; cv=none; b=NAZrrlwigNJzHupYKhcfSDE+WScNgSn10I1+Y6Vj3BOuEeaEcjoR43zEqpxv7J/ih7N2fxeTGGv4FS9eDiekl9eN2+M8XYtUAee1CoI8RUVPpmJNuukFLt4mJDKcOXAL4KgdXLSydgla8a55Usi0wQ62TuhbonudgjERqjk8748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385221; c=relaxed/simple;
	bh=bnADvqVjOnZxk0sLsbIJnA70d9jXuiQCyeY3qHVIUC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NyGv0hsDfqjUq80HmUMwGmQMWx37d0PpBWdkignzDtTntDQytyCsE4NgUZ0gitpJZgB9Oa0xPUBXtjYNzVDjgfiZIMrZgXp6Gxy1wnNijdeCV+NxX0u1rySC20AqHzHNDaNI9yFvi8dhr+0+jwHFhsHWQ4iUQRQYBhEAXR+2no0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C5ox613m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O2DZIq013806;
	Mon, 24 Feb 2025 08:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OsFn2Z
	xs78d5dqGLlCyQmgsyPmdY+R0BhdnGfkT9/Zo=; b=C5ox613mD1RC7jeghh13/A
	Om8herRKgwjAzp8Ft6qwbhw+uEIp/dXZGAxE2da9Lfbw3z4NxCCNqAODMmHhIHFI
	xleIWy83W6bCxDgy7Pe+sn+eNDZ3ZptS3tT1moGIHRjX92UyRvK9Ffv8eigBZidl
	+HUs8I28yZLVLvd6DxbXJd+tB+5dT1LXw10Ex+cvLwtIUwmcvtuKWDFVHDCK9A1o
	nzijXwcT1Hh+muS9iglEdwD85+uUbhjfPYzv2izX6sD7vwksWk4HT85OYDDEVJOU
	q9bGafHHlPtSB3vsvTzTRQmK4kHtCl4sF0HGR+ndGcEoohAvprJ9/C2iOWfYTo4A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450fm017sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 08:20:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51O5PVj5002548;
	Mon, 24 Feb 2025 08:20:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jdv4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 08:20:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51O8K0eD34865894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 08:20:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82F6C2004E;
	Mon, 24 Feb 2025 08:20:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A18F20040;
	Mon, 24 Feb 2025 08:19:59 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Feb 2025 08:19:59 +0000 (GMT)
Message-ID: <ed7386c2-50f9-4fa0-8a94-fd67ae2bba4f@linux.ibm.com>
Date: Mon, 24 Feb 2025 13:49:58 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests: sched: skip cs_prctl_test for systems
 with core scheduling disabled
To: Sinadin Shan <sinadin.shan@oracle.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.hyser@oracle.com
References: <20250221115750.631990-1-sinadin.shan@oracle.com>
 <20250221115750.631990-3-sinadin.shan@oracle.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250221115750.631990-3-sinadin.shan@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7vOjMe4Hu1fsyWyIqGqTylDuh1GtC0-3
X-Proofpoint-GUID: 7vOjMe4Hu1fsyWyIqGqTylDuh1GtC0-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240057



On 2/21/25 17:27, Sinadin Shan wrote:
> For kernels with CONFIG_SCHED_CORE=n, the sched selftest cs_prctl_test
> fails with "Not a core sched system" error. Change this to gracefully
> skip the test for systems with core scheduling disabled. Exiting early
> would also ensure failures reported in obtaining cookie are valid
> failures and not due to the config.
> 
> Skip cs_prctl_test for systems with CONFIG_SCHED_CORE=n

I tried this on kernel built with CONFIG_SCHED_CORE=y.
I did make, make modules_install and make install and reboot.

./cs_prctl_test
## Checking for CONFIG_SCHED_CORE support
Cannot find kernel config in /proc or /boot

This happens because, make install wouldnt copy the .config to 
/boot/config-<kernel-release>.

If the self-tests are to be used in development flow, these checks may 
not be sufficient.

Not sure if i have missed any steps in building process.


> 
> Signed-off-by: Sinadin Shan <sinadin.shan@oracle.com>
> ---
>   tools/testing/selftests/sched/cs_prctl_test.c | 29 ++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
> index 52d97fae4dbd8..60fd657b56c84 100644
> --- a/tools/testing/selftests/sched/cs_prctl_test.c
> +++ b/tools/testing/selftests/sched/cs_prctl_test.c
> @@ -23,6 +23,7 @@
>   #include <sys/eventfd.h>
>   #include <sys/wait.h>
>   #include <sys/types.h>
> +#include <sys/utsname.h>
>   #include <sched.h>
>   #include <sys/prctl.h>
>   #include <unistd.h>
> @@ -109,6 +110,30 @@ static void handle_usage(int rc, char *msg)
>   	exit(rc);
>   }
>   
> +static void check_core_sched_support(void)
> +{
> +	char config[128] = "/proc/config.gz";
> +	char cmd[128];
> +	struct utsname kernel;
> +
> +	printf("## Checking for CONFIG_SCHED_CORE support\n");
> +
> +	if (access(config, F_OK) != 0)
> +		if (uname(&kernel) == 0)
> +			snprintf(config, sizeof(config), "/boot/config-%s", kernel.release);
> +
> +	if (access(config, F_OK) != 0) {
> +		printf("Cannot find kernel config in /proc or /boot\n");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	snprintf(cmd, sizeof(cmd), "zgrep CONFIG_SCHED_CORE=[ym] %s", config);
> +	if (system(cmd)) {
> +		printf("Core scheduling not enabled in kernel, hence skipping tests\n");
> +		exit(4);
> +	}
> +}
> +
>   static unsigned long get_cs_cookie(int pid)
>   {
>   	unsigned long long cookie;
> @@ -117,7 +142,7 @@ static unsigned long get_cs_cookie(int pid)
>   	ret = prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid, PIDTYPE_PID,
>   		    (unsigned long)&cookie);
>   	if (ret) {
> -		printf("Not a core sched system\n");
> +		printf("Failed to get cookie\n");
>   		return -1UL;
>   	}
>   
> @@ -270,6 +295,8 @@ int main(int argc, char *argv[])
>   	if (keypress)
>   		delay = -1;
>   
> +	check_core_sched_support();
> +
>   	srand(time(NULL));
>   
>   	/* put into separate process group */


