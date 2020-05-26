Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2261E2399
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 May 2020 16:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgEZOER (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 10:04:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726618AbgEZOEQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 10:04:16 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QE1tFs194202;
        Tue, 26 May 2020 10:04:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 316ywmwb8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 10:04:01 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04QE2BZX195754;
        Tue, 26 May 2020 10:04:00 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 316ywmwb5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 10:04:00 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04QE20fE019290;
        Tue, 26 May 2020 14:03:57 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 316uf8tes4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 14:03:57 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04QE2fnK56295680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 May 2020 14:02:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FF8AA405C;
        Tue, 26 May 2020 14:03:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ED8DA405B;
        Tue, 26 May 2020 14:03:50 +0000 (GMT)
Received: from [9.199.32.191] (unknown [9.199.32.191])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 May 2020 14:03:50 +0000 (GMT)
Subject: Re: [PATCH] selftests: powerpc: Add test for execute-disabled pkeys
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linuxram@us.ibm.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        fweimer@redhat.com, ruscur@russell.cc
References: <20200508162332.65316-1-sandipan@linux.ibm.com>
 <87367mg9h4.fsf@mpe.ellerman.id.au>
From:   Sandipan Das <sandipan@linux.ibm.com>
Message-ID: <6b73bf3f-0d10-6e8c-acd9-27de53573dec@linux.ibm.com>
Date:   Tue, 26 May 2020 19:33:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87367mg9h4.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260104
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Michael,

On 26/05/20 6:05 pm, Michael Ellerman wrote:
> [...]
>> +
>> +/* Override definitions as they might be inconsistent */
>> +#undef PKEY_DISABLE_ACCESS
>> +#define PKEY_DISABLE_ACCESS	0x3
> 
> Why would they be inconsistent?
> 

The definition in sys/mman.h still uses the value specific to
Intel's implementation i.e. 1, when this should have been 3
for powerpc. I have seen this on Ubuntu 18.04 and 20.04.

> 
>> +/* Older distros might not define this */
>> +#ifndef SEGV_PKUERR
>> +#define SEGV_PKUERR	4
>> +#endif
> ...
>> +
>> +	/* Restore permissions in order to continue */
>> +	switch (fcode) {
>> +	case SEGV_ACCERR:
>> +		if (mprotect(insns, pgsize, PROT_READ | PROT_WRITE)) {
>> +			perror("mprotect");
>> +			goto fail;
>> +		}
>> +		break;
>> +	case SEGV_PKUERR:
>> +		if (sinfo->si_pkey != fpkey)
>> +			goto fail;
> 
> This doesn't compile on older distros, eg Ubuntu 16.04:
> 
>   pkey_exec_prot.c: In function 'segv_handler':
>   pkey_exec_prot.c:121:12: error: 'siginfo_t {aka struct <anonymous>}' has no member named 'si_pkey'
>      if (sinfo->si_pkey != fpkey)
>               ^
>   pkey_exec_prot.c:151:24: error: 'siginfo_t {aka struct <anonymous>}' has no member named 'si_pkey'
>      pkey_set_rights(sinfo->si_pkey, 0);
>                           ^
>   ../../lib.mk:142: recipe for target '/output/kselftest/powerpc/mm/pkey_exec_prot' failed
> 

Thanks for reporting this.

> 
> I think a reasonable solution is to use the absence of SEGV_PKUERR to
> basically turn the whole test into a nop at build time, eg:
> 
> diff --git a/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
> index b346ad205e68..218257b89fbb 100644
> --- a/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
> +++ b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
> @@ -30,9 +30,7 @@
>  #define PKEY_DISABLE_EXECUTE   0x4
> 
>  /* Older distros might not define this */
> -#ifndef SEGV_PKUERR
> -#define SEGV_PKUERR    4
> -#endif
> +#ifdef SEGV_PKUERR
> 
>  #define SYS_pkey_mprotect      386
>  #define SYS_pkey_alloc         384
> @@ -319,6 +317,13 @@ static int test(void)
> 
>         return 0;
>  }
> +#else
> +static int test(void)
> +{
> +       printf("Test built with old libc lacking pkey support.\n");
> +       SKIP_IF(true);
> +}
> +#endif /* SEGV_PKUERR */
> 
>  int main(void)
>  {
> 
> 

Or can I use this from the pkey tests under selftests/vm?

static inline u32 *siginfo_get_pkey_ptr(siginfo_t *si)
{
#ifdef si_pkey
	return &si->si_pkey;
#else
	return (u32 *)(((u8 *)si) + si_pkey_offset);
#endif
}

Where si_pkey_offset is 0x20 for powerpc.


- Sandipan
