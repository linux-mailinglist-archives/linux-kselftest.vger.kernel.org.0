Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3B63A41BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 14:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhFKMLl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 08:11:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40294 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231537AbhFKMLb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 08:11:31 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15BC4AiN136169;
        Fri, 11 Jun 2021 08:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MH7vLqk0Ta4iyQPSYscvFja1MJcTvp1s5iOegsIKg+0=;
 b=cGSIKfhQZT15F3od1FxD6WGjqBAVl7NmQ/dL1raOHaGvTh7smJoy/7lZB73XvBpbJZz1
 pjp94Nbaa9Ylulm9mrOUTGXhyELPm0vvoHhI5nwABuPV7Hplp/E1qA5l1GjXKOKToYIZ
 oCjkIBus1efQj7AYXvpcY1xsF2v0ZM9HjIl/9KGeDXD6iFv4EsL2u92KJRG4KBbMq7qX
 T8rAp5Z+nNIpa/VTOMQ+SHP0Sw+gCjGOikbXqo+3eiMfaGAO3RqUJCdVrkg5i9up+l3y
 L5QetSxYpx+VoFI4jzfBNarxLBTC/YYkbbF7spUwcnVGZXKLUVNyBjrryMNk+b+xK4IF Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3947gwg6fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 08:09:00 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15BC4MFp139011;
        Fri, 11 Jun 2021 08:08:59 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3947gwg6dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 08:08:59 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15BC2WbT012337;
        Fri, 11 Jun 2021 12:08:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3900w8bdr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 12:08:57 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15BC8sEd10223922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 12:08:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C99FAE057;
        Fri, 11 Jun 2021 12:08:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FDBCAE056;
        Fri, 11 Jun 2021 12:08:52 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.35.90])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Jun 2021 12:08:52 +0000 (GMT)
Subject: Re: [PATCH v7 1/4] KVM: stats: Separate generic stats from
 architecture specific ones
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
References: <20210603211426.790093-1-jingzhangos@google.com>
 <20210603211426.790093-2-jingzhangos@google.com>
 <03f3fa03-6f61-7864-4867-3dc332a9d6f3@de.ibm.com>
 <bdd315f7-0615-af69-90c3-1e5646f3e259@redhat.com>
 <c0173386-0c37-73c0-736a-e904636b6c94@de.ibm.com>
 <c5199e63-762d-a731-7ef2-c2af3a8cb0c3@redhat.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <050e9d8e-278d-278c-13f7-ea0b39d13fbe@de.ibm.com>
Date:   Fri, 11 Jun 2021 14:08:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <c5199e63-762d-a731-7ef2-c2af3a8cb0c3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Au1HVP3cg7SdXgWf4Mx7saADZQlSXYZX
X-Proofpoint-ORIG-GUID: mRAbK6kdeL7gvltaAlAQwq9KvXXYgMeQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-11_05:2021-06-11,2021-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110077
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11.06.21 14:03, Paolo Bonzini wrote:
> On 11/06/21 14:00, Christian Borntraeger wrote:
>> What is the semantics of remote_tlb_flush?
> 
> I always interpreted it as "number of times the KVM page table management code needed other CPUs to learn about new page tables". Whether the broadcast is done in software or hardware shouldn't matter; either way I suppose there is still some traffic on the bus involved.


My point is that KVM page table management on s390x completely piggy-backs on the qemu address space page table management from common code for the last level.
And due to the way we handle page tables we also do not teach "other CPUs". We always teach the whole system with things like IPTE.

> 
> ARM is also not updating the stat, I'll send a patch for that.
> 
> Paolo
> 
>> For the host:
>> We usually do not do remote TLB flushes in the "IPI with a flush executed on the remote CPU" sense.
>> We do have instructions that invalidates table entries and it will take care of remote TLBs as well (IPTE and IDTE and CRDTE).
>> This is nice, but on the other side an operating system MUST use these instruction if the page table might be in use by any CPU. If not, you can get a delayed access exception machine check if the hardware detect a TLB/page table incosistency.
>> Only if you can guarantee that nobody has this page table attached you can also use a normal store + tlb flush instruction.
>>
>> For the guest (and I guess thats what we care about here?) TLB flushes are almost completely handled by hardware. There is only the set prefix instruction that is handled by KVM and this flushes the cpu local cache.
> 
