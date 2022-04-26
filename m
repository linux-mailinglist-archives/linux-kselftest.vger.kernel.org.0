Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F125450FC5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 13:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiDZMAR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 08:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbiDZMAR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 08:00:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA8B53A53;
        Tue, 26 Apr 2022 04:57:09 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q9ZCEe002053;
        Tue, 26 Apr 2022 11:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=a3zMhYLA8xJP/xWtcO5iRzbIKMDvtVGp5u0drnw/ibg=;
 b=lfxkzJGUurXcetmqygvnIpGcoRSEnKIky3jbQutWyUIePuBMtN5/pbGnKkE36Q+E6vX8
 2ktEHjB5N7qIFpmx+LTy4ECRYYQYwD7CAdDJZswpuGkANhygnk1vAJcLpjgA0JEN45hp
 jB/5XpXa6HTsSKuBF6GsoPkPxSjd1Y6eIM3erTDzhU/vYE25Q0oCqiMm39vOqCJu+A6p
 v0RvIJ82xayvatn5sR7YvnxecAeEfGSs/AnBcs7l2LSucvAVzOsvuG/Ag3mfSH3mhszJ
 9V96CFxAO7delV6cXOenhNEpCVjajHSI9v82V4VHqwwMyx4zEZ8LCDDH9yW9Z4iWlnEx QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpbyh5fwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 11:57:05 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23QBv5dk002095;
        Tue, 26 Apr 2022 11:57:05 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpbyh5fvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 11:57:04 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QBrmfe027493;
        Tue, 26 Apr 2022 11:57:03 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3fm938uchc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 11:57:03 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QBuxYJ52429144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 11:56:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56F6CA405B;
        Tue, 26 Apr 2022 11:56:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F635A4054;
        Tue, 26 Apr 2022 11:56:58 +0000 (GMT)
Received: from [9.171.92.107] (unknown [9.171.92.107])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 11:56:58 +0000 (GMT)
Message-ID: <80ca4468-6b0a-e8d9-9922-1fae2a1f0fcc@linux.ibm.com>
Date:   Tue, 26 Apr 2022 13:56:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/2] Dirtying, failing memop: don't indicate
 suppression
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20220425100147.1755340-1-scgl@linux.ibm.com>
 <8095d0de-dd99-0388-b1d4-e59b01dc4be0@linux.ibm.com>
 <13d0d706-abc4-3e4d-88c3-6447636fd1fd@linux.ibm.com>
 <1ccb1333-2233-8832-4102-a6c082b29108@linux.ibm.com>
 <40038a9a-5647-c355-bad2-297b0a2baf4f@linux.ibm.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <40038a9a-5647-c355-bad2-297b0a2baf4f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0vrkjp9KAsI56VkB80KM_TaNI0Sf3ufs
X-Proofpoint-GUID: m2Zua9dnvj6lbL_fTw9YYUs0X7QiWkDl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=760 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260074
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/26/22 09:25, Janosch Frank wrote:
> On 4/26/22 08:19, Christian Borntraeger wrote:
>>
>>
>> Am 25.04.22 um 19:29 schrieb Janis Schoetterl-Glausch:
>>> On 4/25/22 18:30, Christian Borntraeger wrote:
>>>> Am 25.04.22 um 12:01 schrieb Janis Schoetterl-Glausch:
>>>>> If a memop fails due to key checked protection, after already having
>>>>> written to the guest, don't indicate suppression to the guest, as that
>>>>> would imply that memory wasn't modified.
>>>>>
>>>>> This could be considered a fix to the code introducing storage key
>>>>> support, however this is a bug in KVM only if we emulate an
>>>>> instructions writing to an operand spanning multiple pages, which I
>>>>> don't believe we do.
>>>>>
>>>>
>>>> Thanks applied. I think it makes sense for 5.18 nevertheless.
>>>
>>> Janosch had some concerns because the protection code being 000 implies
>>> that the effective address in the TEID is unpredictable.
>>> Let's see if he chimes in.
>>
>> z/VM does exactly the same on key protection crossing a page boundary. The
>> architecture was written in a way to allow all zeros exactly for this case.
>> (hypervisor emulation of key protection crossing pages).
>> This is even true for ESOP-2. See Figure 3-5 or figure 3-8 (the first line)
>> which allows to NOT have a valid address in the TEID for key controlled
>> protection.

The question is if this is the best way to do it. Janosch brought up
interruptible instructions, for those you would want to just consider
the current unit of operation to be suppressed. Now this is not actually
relevant, I guess PFMF is the only interruptible instruction we'd emulate
and that ignores keys when clearing memory.
But maybe there are other edge cases.

>>
>> The only question is, do we need to change the suppression parameter in
>> access_guest_with_key
>>
>>    (mode != GACC_STORE) || (idx == 0)
>>
>> to also check for prot != PROT_TYPE_KEYC
>> ? I think we do not need this as we have checked other reasons before.

Yes, it is not necessary, the control flow is such that a protection exception
implies that is due to keys.
> 
> To me this measure looks like a last resort option and the POP doesn't state a 100% what is to be done. Some instructions can mandate suppression instead of termination according to the architects.
> 
> My intuition tells me that if we are in a situation where this would happen then we would be much better off just doing it by hand (i.e. in the instruction emulation code) and not letting this function decide.

For the instructions we currently need to emulate in KVM we should be fine.
So the question is what's best for the future and for instructions emulated by user space.
Upward in the call stack (including user space), we don't know the failing address,
which complicates handling it in the emulation code.
You could chop up the memop in page chunks to find out, but that might have other issues.

Since this behavior is very implicit and easy to overlook maybe we should document it
in the description of the memop ioctl?
> 
> So I'm not entirely sure if we're replacing something that is not correct with something that also won't be correct for all cases.

That may be the case, which option is more correct/less incorrect tho?
It's hard to say because one would have to consider all instructions/possibilities,
but indicating not suppression when we've already written to memory, seems to make
sense more often than not doing so.
> 
> But to summarize this: I'm not entirely sure even after reading the POP for more than an hour and consulting an architect

