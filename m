Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1FF4B68B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 11:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiBOKDk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 05:03:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiBOKDj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 05:03:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF1024F;
        Tue, 15 Feb 2022 02:03:29 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21F9RsuX032111;
        Tue, 15 Feb 2022 10:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mo53ye7ADXSil/1Dwypbuvn8sFLXAMAI+CaMqOgPWQ0=;
 b=gYfBCRz2OD3qY4WgjYDc10tYkaNCc87voqsQ+Jp5Y/czktKqw05fCnsSWdw20dMTRAWG
 sofEh6AqOd45Id+P2sko4ItNDgMwYHtOjAoJW2vT90vEKWhzGGGVkLpD9q/RD+/+//l/
 BN+aoWmE9xK+y6wxwet+SSkBBJUw8CHTqXS0q5/Siuv8Y56NMhQ0GipFWvE12t8Ip6WA
 ZLrILF52KhGyuddFgx91nmeSDDrCS0IIGSz11OcFqx7O5jfvPHv1fOnjRBJJ1uXU0CXn
 jfvwc+xyWZXy7M257QssnCKnRf4nml/xEV0m+1x2ioFpasRFQ334e2Hcpv6oRBY5S0Dp Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e878uc0eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 10:03:29 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21F8umw2019940;
        Tue, 15 Feb 2022 10:03:28 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e878uc0ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 10:03:28 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21F9c3oZ013900;
        Tue, 15 Feb 2022 10:03:25 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3e64h9m39f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 10:03:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21FA3MGA47513874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 10:03:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D878A4C040;
        Tue, 15 Feb 2022 10:03:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDD3E4C046;
        Tue, 15 Feb 2022 10:03:20 +0000 (GMT)
Received: from [9.171.66.227] (unknown [9.171.66.227])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Feb 2022 10:03:20 +0000 (GMT)
Message-ID: <a9a4bb87-2189-8c0a-8a94-6c6069fec7f7@linux.ibm.com>
Date:   Tue, 15 Feb 2022 11:03:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] selftests: kvm: Check whether SIDA memop fails for normal
 guests
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220215074824.188440-1-thuth@redhat.com>
 <801aa4ea-ca26-7561-95f3-162b0f680929@linux.ibm.com>
 <c01824a7-9d15-1356-2530-04c6112ace65@redhat.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <c01824a7-9d15-1356-2530-04c6112ace65@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3_h2FM2TnsFpSJ4vcjYx0lEUvyaSu5YI
X-Proofpoint-ORIG-GUID: x4OX1t67bnfPeUqADZDAgT048wLZlut_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_03,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202150056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/15/22 10:59, Thomas Huth wrote:
> On 15/02/2022 10.54, Janis Schoetterl-Glausch wrote:
>> On 2/15/22 08:48, Thomas Huth wrote:
>>> Commit 2c212e1baedc ("KVM: s390: Return error on SIDA memop on normal
>>> guest") fixed the behavior of the SIDA memops for normal guests. It
>>> would be nice to have a way to test whether the current kernel has
>>> the fix applied or not. Thus add a check to the KVM selftests for
>>> these two memops.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   tools/testing/selftests/kvm/s390x/memop.c | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
>>> index 9f49ead380ab..d19c3ffdea3f 100644
>>> --- a/tools/testing/selftests/kvm/s390x/memop.c
>>> +++ b/tools/testing/selftests/kvm/s390x/memop.c
>>> @@ -160,6 +160,21 @@ int main(int argc, char *argv[])
>>>       run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
>>>       vcpu_run(vm, VCPU_ID);                  /* Run to sync new state */
>>>
>>> +    /* Check that the SIDA calls are rejected for non-protected guests */
>>> +    ksmo.gaddr = 0;
>>> +    ksmo.flags = 0;
>>> +    ksmo.size = 8;
>>> +    ksmo.op = KVM_S390_MEMOP_SIDA_READ;
>>> +    ksmo.buf = (uintptr_t)mem1;
>>> +    ksmo.sida_offset = 0x1c0;
>>
>> What is the rational for that constant?
>> Any would do, as long as size + offset < PAGE_SIZE, correct?
> 
> Right, it's rather a random value.

Ah, ok.

Reviewed-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> 
>  Thomas
> 

