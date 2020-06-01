Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EB11E9B7D
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jun 2020 03:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgFAB7r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 31 May 2020 21:59:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726555AbgFAB7r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 31 May 2020 21:59:47 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0511VcAf138762;
        Sun, 31 May 2020 21:59:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31bh3y91xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 May 2020 21:59:34 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0511wfJL011028;
        Sun, 31 May 2020 21:59:34 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31bh3y91x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 May 2020 21:59:34 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0511trHO009816;
        Mon, 1 Jun 2020 01:59:32 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 31bf47u6ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Jun 2020 01:59:32 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0511xTK356033336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jun 2020 01:59:29 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5475511C052;
        Mon,  1 Jun 2020 01:59:29 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48DDF11C07A;
        Mon,  1 Jun 2020 01:59:27 +0000 (GMT)
Received: from [9.199.46.155] (unknown [9.199.46.155])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jun 2020 01:59:27 +0000 (GMT)
Subject: Re: [PATCH v2] selftests: powerpc: Add test for execute-disabled
 pkeys
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linuxram@us.ibm.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        fweimer@redhat.com, ruscur@russell.cc
References: <20200527030342.13712-1-sandipan@linux.ibm.com>
 <87tuzzik8q.fsf@mpe.ellerman.id.au>
From:   Sandipan Das <sandipan@linux.ibm.com>
Message-ID: <1eb388dc-0fde-64f3-9c05-7f9f2a398543@linux.ibm.com>
Date:   Mon, 1 Jun 2020 07:29:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87tuzzik8q.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-31_13:2020-05-28,2020-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 cotscore=-2147483648 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010006
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Michael,

Thanks for your suggestions. I had a few questions regarding some
of them.

On 29/05/20 7:18 am, Michael Ellerman wrote:
>> [...]
>> +
>> +static void pkeyreg_set(unsigned long uamr)
>> +{
>> +	asm volatile("isync; mtspr	0xd, %0; isync;" : : "r"(uamr));
>> +}
> 
> You can use mtspr() there, but you'll need to add the isync's yourself.
> 

Would it make sense to add a new macro that adds the CSI instructions?
Something like this.

diff --git a/tools/testing/selftests/powerpc/include/reg.h b/tools/testing/selftests/powerpc/include/reg.h
index 022c5076b2c5..d60f66380cad 100644
--- a/tools/testing/selftests/powerpc/include/reg.h
+++ b/tools/testing/selftests/powerpc/include/reg.h
@@ -15,6 +15,10 @@
 #define mtspr(rn, v)   asm volatile("mtspr " _str(rn) ",%0" : \
                                    : "r" ((unsigned long)(v)) \
                                    : "memory")
+#define mtspr_csi(rn, v)       ({ \
+                       asm volatile("isync; mtspr " _str(rn) ",%0; isync;" : \
+                                   : "r" ((unsigned long)(v)) \
+                                   : "memory"); })
 
 #define mb()           asm volatile("sync" : : : "memory");
 #define barrier()      asm volatile("" : : : "memory");


I also noticed that two of the ptrace-related pkey tests were also not
using CSIs. I will fix those too.

>> [...]
>> +	/* The following two cases will avoid SEGV_PKUERR */
>> +	ftype = -1;
>> +	fpkey = -1;
>> +
>> +	/*
>> +	 * Read an instruction word from the address when AMR bits
>> +	 * are not set.
> 
> You should explain for people who aren't familiar with the ISA that "AMR
> bits not set" means "read/write access allowed".
> 
>> +	 *
>> +	 * This should not generate a fault as having PROT_EXEC
>> +	 * implicitly allows reads. The pkey currently restricts
> 
> Whether PROT_EXEC implies read is not well defined (see the man page).
> If you want to test this case I think you'd be better off specifying
> PROT_EXEC | PROT_READ explicitly.
> 

But I guess specifying PROT_EXEC | PROT_READ defeats the purpose? I can
tweak the passing condition though based on whether READ_IMPLIES_EXEC is
set in the personality.

> [...]
>> +	FAIL_IF(faults != 0 || fcode != SEGV_ACCERR);
>> +
>> +	/* The following three cases will generate SEGV_PKUERR */
>> +	ftype = PKEY_DISABLE_ACCESS;
>> +	fpkey = pkey;
>> +
>> +	/*
>> +	 * Read an instruction word from the address when AMR bits
>> +	 * are set.
>> +	 *
>> +	 * This should generate a pkey fault based on AMR bits only
>> +	 * as having PROT_EXEC implicitly allows reads.
> 
> Again would be better to specify PROT_READ IMHO.
> 

I can use a personality check here too.

>> +	 */
>> +	faults = 1;
>> +	FAIL_IF(sys_pkey_mprotect(insns, pgsize, PROT_EXEC, pkey) != 0);
>> +	printf("read from %p, pkey is execute-disabled, access-disabled\n",
>> +	       (void *) faddr);
>> +	pkey_set_rights(pkey, PKEY_DISABLE_ACCESS);
>> +	i = *faddr;
>> +	FAIL_IF(faults != 0 || fcode != SEGV_PKUERR);
>> +
>> +	/*
>> +	 * Write an instruction word to the address when AMR bits
>> +	 * are set.
>> +	 *
>> +	 * This should generate two faults. First, a pkey fault based
>> +	 * on AMR bits and then an access fault based on PROT_EXEC.
>> +	 */
>> +	faults = 2;
> 
> Setting faults to the expected value and decrementing it in the fault
> handler is kind of weird.
> 
> I think it would be clearer if faults was just a zero-based counter of
> how many faults we've taken, and then you test that it's == 2 below.
> 
>> +	FAIL_IF(sys_pkey_mprotect(insns, pgsize, PROT_EXEC, pkey) != 0);
>> +	printf("write to %p, pkey is execute-disabled, access-disabled\n",
>> +	       (void *) faddr);
>> +	pkey_set_rights(pkey, PKEY_DISABLE_ACCESS);
>> +	*faddr = 0x60000000;	/* nop */
>> +	FAIL_IF(faults != 0 || fcode != SEGV_ACCERR);
> 
> ie. FAIL_IF(faults != 2 || ... )
> 

Agreed, it is weird. IIRC, I did this to make sure that if the test
kept getting repeated faults at the same address and exceeded the
maximum number of expected faults i.e. it gets another fault when
'faults' is already zero, then the signal handler will attempt to
let the program continue by giving all permissions to the page and
also the pkey. Would it make sense to just rename 'faults' to
something like 'remaining_faults'?


- Sandipan
