Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4FC3A4194
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 14:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhFKMDe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 08:03:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60564 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231489AbhFKMDd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 08:03:33 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15BBXDPL101354;
        Fri, 11 Jun 2021 08:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mbHNpsEeNzEvHddb7n05jQiVtEGHVhDGgdGI3qgT5cU=;
 b=iRzgFIYvoDbpwIwZ8cf1+4qafFIBZ9IK4gVOJb6pb5MQzNjfOOE5Gx2p4dnRA1vKGWuk
 shAH/zG7A4YfT5imRMBvl53mhjzVQcjBSWzJtiuGWzQMco0Ye5Kid1aA2hpvVlPpKw3Y
 WahmxjtU7CRu+Sk0I/Z4QrCTH7onWjUNGoTzt6JGVfpR4jJ+oVUTOiwjwwxAcSFnlnpA
 7bsgG1gqqP27txRSYkNO5BthxoWenMfHL4Hpv8wIrYQzxyI2K2QWJF8ohTpIWmM8qVNj
 PDdPjmfSfukd0Q2GBk3IXye1DgD8Rm9INMC3SGzjPbCYxFlsnomUwwUUPfqxldRmXFOv Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39457f40xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 08:00:55 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15BBYTaO105704;
        Fri, 11 Jun 2021 08:00:55 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39457f40r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 08:00:54 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15BBxCWJ008598;
        Fri, 11 Jun 2021 12:00:48 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3900w8bdjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 12:00:48 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15BBxoUV33489284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 11:59:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C87AAE065;
        Fri, 11 Jun 2021 12:00:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4546CAE057;
        Fri, 11 Jun 2021 12:00:44 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.35.90])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Jun 2021 12:00:44 +0000 (GMT)
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
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <c0173386-0c37-73c0-736a-e904636b6c94@de.ibm.com>
Date:   Fri, 11 Jun 2021 14:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <bdd315f7-0615-af69-90c3-1e5646f3e259@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8MP2ezwEt9170vbChq_FRz0xBregGrk3
X-Proofpoint-ORIG-GUID: GqhBvqOjrdf5YHNLJ4FCXl4R-mUl-zgg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-11_05:2021-06-11,2021-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110073
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11.06.21 12:51, Paolo Bonzini wrote:
> On 11/06/21 08:57, Christian Borntraeger wrote:
>>> @@ -755,12 +750,12 @@ struct kvm_vcpu_arch {
>>>   };
>>>   struct kvm_vm_stat {
>>> +    struct kvm_vm_stat_generic generic;
>>
>> s390 does not have remote_tlb_flush. I guess this does not hurt?
> 
> It would have to be accounted in gmap_flush_tlb, but there is no struct kvm in there.  A slightly hackish possibility would be to include the gmap by value (instead of by pointer) in struct kvm, and then use container_of.

What is the semantics of remote_tlb_flush?
For the host:
We usually do not do remote TLB flushes in the "IPI with a flush executed on the remote CPU" sense.
We do have instructions that invalidates table entries and it will take care of remote TLBs as well (IPTE and IDTE and CRDTE).
This is nice, but on the other side an operating system MUST use these instruction if the page table might be in use by any CPU. If not, you can get a delayed access exception machine check if the hardware detect a TLB/page table incosistency.
Only if you can guarantee that nobody has this page table attached you can also use a normal store + tlb flush instruction.

For the guest (and I guess thats what we care about here?) TLB flushes are almost completely handled by hardware. There is only the set prefix instruction that is handled by KVM and this flushes the cpu local cache.
> 
> This reminds me that I have never asked you why the gmap code is not in arch/s390/kvm, 

Because we share the last level of the page tables with userspace so the KVM address space is somewhat tied to the user address space.
This is partly because Martin wanted to have control over this due to some oddities about our page tables and partly because of the rule from above. Using a IPTE of such a page table entry will take care of the TLB entries for both (user and guest) mappings in an atomic fashion when the page table changes.


and also that there is no code in QEMU that uses KVM_VM_S390_UCONTROL or KVM_S390_VCPU_FAULT.  It would be nice to have some testcases for that, and also for KVM_S390_VCPU_FAULT with regular virtual machines... or to remove the code if it's unused.

This is used by an internal firmware test tool that uses KVM to speed up simulation of hardware instructions.
Search for CECSIM to get an idea (the existing papers still talk about the same approach using z/VM).
I will check what we can do regarding regression tests.

