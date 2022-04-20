Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D11508672
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 12:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377860AbiDTK6J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 06:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377902AbiDTK57 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 06:57:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFFC1A060;
        Wed, 20 Apr 2022 03:55:13 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KAQoVh017318;
        Wed, 20 Apr 2022 10:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VivLBdsQO0JnQidm5KpyRvobjfYrJqCPs/+J/I/661I=;
 b=ldDUGG5FVfryO6pgB6fJtyppTtTdB6h0QT7vWjBmrI5y6kRzN+XkKlfNPxh71Vv6i+Bz
 IMYIyXMSlSDFLQedzSYQzSEoiQavO6KJMf303anwOT9tYFUPlbM/ctWEVY7OS3/EDtbw
 kgMFmrlF867WVwTBW2XGfm7U+IED0XWqmaD9dvHlFLO0vr314PIiSiOu166lrFosRcu4
 0BRTZkDFKBwmR8b3woc9hfCzcM88w3rYvzuF1WuP7E82FybIrscvvAvPR6mOetrazFHw
 Yry8M0E7FAaHdE1bnmjDsBFj/zkEsdpAipOjALzzpggJnhfAFLJXmBQ/C8FJ17/SyRLW OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7kb7d1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 10:55:10 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23KAiVpB014157;
        Wed, 20 Apr 2022 10:55:09 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7kb7d19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 10:55:09 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KArChk019949;
        Wed, 20 Apr 2022 10:55:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3ffne965xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 10:55:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KAt4f655574880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 10:55:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73163A4040;
        Wed, 20 Apr 2022 10:55:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDF6BA4051;
        Wed, 20 Apr 2022 10:55:03 +0000 (GMT)
Received: from [9.171.21.171] (unknown [9.171.21.171])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 10:55:03 +0000 (GMT)
Message-ID: <2eb0545c-7ffd-fe3a-b6ad-d30ba7bd9177@linux.ibm.com>
Date:   Wed, 20 Apr 2022 12:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/4] KVM: s390: selftests: Use TAP interface in the memop
 test
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
References: <20220414105322.577439-1-thuth@redhat.com>
 <20220414105322.577439-2-thuth@redhat.com>
 <3c627856-5e66-3cbe-adab-464ae573e23d@linux.ibm.com>
 <07903c7d-5afc-ce95-0f51-3c643eab8b37@redhat.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <07903c7d-5afc-ce95-0f51-3c643eab8b37@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E-Y3t3m0OSYnz-JVLlTltTW4VSjrgo5a
X-Proofpoint-GUID: 8Zc2X_8gsJO_6wD93xuPvFl488SMsKz3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_02,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200065
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/19/22 19:40, Thomas Huth wrote:
> On 14/04/2022 14.48, Janis Schoetterl-Glausch wrote:
>> On 4/14/22 12:53, Thomas Huth wrote:
>>> The memop test currently does not have any output (unless one of the
>>> TEST_ASSERT statement fails), so it's hard to say for a user whether
>>> a certain new sub-test has been included in the binary or not. Let's
>>> make this a little bit more user-friendly and include some TAP output
>>> via the kselftests.h interface.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   tools/testing/selftests/kvm/s390x/memop.c | 90 ++++++++++++++++++-----
>>>   1 file changed, 73 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
>>> index b04c2c1b3c30..a2783d9afcac 100644
>>> --- a/tools/testing/selftests/kvm/s390x/memop.c
>>> +++ b/tools/testing/selftests/kvm/s390x/memop.c
>>> @@ -12,6 +12,7 @@
>>>     #include "test_util.h"
>>>   #include "kvm_util.h"
>>> +#include "kselftest.h"
>>>     enum mop_target {
>>>       LOGICAL,
>>> @@ -648,33 +649,88 @@ static void test_errors(void)
>>>       kvm_vm_free(t.kvm_vm);
>>>   }
>>>   +struct testdef {
>>> +    const char *name;
>>> +    void (*test)(void);
>>> +    bool needs_extension;
>>
>> Please make this numeric. You could also rename it to required_extension or similar.
> [...]
>>> +
>>> +    for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
>>> +        if (!testlist[idx].needs_extension || extension_cap) {
>>
>> Then check here that extension_cap >= the required extension.
>> This way the test can easily be adapted in case of future extensions.
> 
> Not sure whether a ">=" will really be safe, since a future extension does not necessarily assert that previous extensions are available at the same time.

Hmm, I intend for that to hold. In any case, for the existing extension we have committed to it, e.g.
the documentation says:

Absolute accesses are permitted for the VM ioctl if KVM_CAP_S390_MEM_OP_EXTENSION
is > 0.

So, if we introduce an extension and allow for it to be removed with a higher extension number,
when we add testing support for that extension we'd have to change the capability check,
but the existing test case would not break.

I guess the most flexible way would be to initialize the array in the middle of main, then
you could do .skip = !extension_cap and in the future whatever expression makes sense, but
it's kinda ugly and should not be necessary anyway.
> 
> But I can still turn the bool into a numeric to make it a little bit more flexible for future use.
> 
>  Thomas
> 

