Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4B35087B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 14:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378406AbiDTMJv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 08:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378395AbiDTMJt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 08:09:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BB627FCE;
        Wed, 20 Apr 2022 05:07:03 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K9cP9c009788;
        Wed, 20 Apr 2022 12:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ArLI73Wo1SazBtj36Saojj2rlHPwZfm3Tsuw4CYSFB0=;
 b=U0a780jVjCalXHtyq1vEF0v6w8KyNzudF/W1ixGEO9dhPEww9p3IMbuSELpb4eHAVBpP
 iPoqZBGPQfpOu53qSvKdR1tTQ5sq2dF70iwQ8fYGb2gSjODtsr+NSRtrlpkI5tuKAuJK
 29H6rtnRji4UAkBg/ah/QSagc0u+yD6Cm+c7+J6psvKytUKzMuB1rGZcWVXQBB4DnqyG
 cCSbPyHUFlsvHi9iAPVo6NlKRsUHOEtFEaHiRaNmC4BfnqTjq8BweWjeQArcCZseonx9
 jl6BeMO1z18R/BE29DRBTZ5rtKM//JWgWIK4908A87ViVbHwJpYGCZ//LdS4vXI2PKsU rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fhxh892sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 12:06:56 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23KBul0d026896;
        Wed, 20 Apr 2022 12:06:55 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fhxh892s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 12:06:54 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KC5FGo003092;
        Wed, 20 Apr 2022 12:06:52 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3ffne8p8m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 12:06:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KC6n7P55574874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 12:06:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77BBFA404D;
        Wed, 20 Apr 2022 12:06:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1944A4040;
        Wed, 20 Apr 2022 12:06:48 +0000 (GMT)
Received: from [9.171.21.171] (unknown [9.171.21.171])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 12:06:48 +0000 (GMT)
Message-ID: <1a2eb5a1-dbdb-5767-ff84-aaf1d43b0540@linux.ibm.com>
Date:   Wed, 20 Apr 2022 14:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/4] KVM: s390: selftests: Use TAP interface in the
 tprot test
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-s390@vger.kernel.org
References: <20220419185857.128351-1-thuth@redhat.com>
 <20220419185857.128351-4-thuth@redhat.com>
 <267dc999-edc6-c8fc-b177-e06fb2d259b4@linux.ibm.com>
 <f3989523-bed1-d9d4-2007-19de8ba4d403@redhat.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <f3989523-bed1-d9d4-2007-19de8ba4d403@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PyZiokVk0qOVR0j3OzLlA8MSNrvxnF8R
X-Proofpoint-GUID: GZ7CVhLQijYEHA1j92pogLWe1X03aQfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_03,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200073
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/20/22 13:46, Thomas Huth wrote:
> On 20/04/2022 13.38, Janis Schoetterl-Glausch wrote:
>> On 4/19/22 20:58, Thomas Huth wrote:
>>> The tprot test currently does not have any output (unless one of
>>> the TEST_ASSERT statement fails), so it's hard to say for a user
>>> whether a certain new sub-test has been included in the binary or
>>> not. Let's make this a little bit more user-friendly and include
>>> some TAP output via the kselftests.h interface.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   tools/testing/selftests/kvm/s390x/tprot.c | 28 +++++++++++++++++++----
>>>   1 file changed, 23 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
>>> index c097b9db495e..baba883d7a6d 100644
>>> --- a/tools/testing/selftests/kvm/s390x/tprot.c
>>> +++ b/tools/testing/selftests/kvm/s390x/tprot.c
>>
>> We're not committing ourselves to any particular test output, are we?
>> Your patch considers the stages used for test setup tests themselves,
>> which I'm fine with, but would not want to commit to keeping that way forever.
> 
> No commitment - just somewhat more verbose output. If you don't like it, we can also drop this patch, or do it in another way, I don't mind too much.

I'm fine with it then.
With the braces changed:

Reviewed-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> 
>>> +#define HOST_SYNC(vmp, stage)            \
>>> +{                        \
>>> +    HOST_SYNC_NO_TAP(vmp, stage);        \
>>> +    ksft_test_result_pass("" #stage "\n");    \
>>> +}
>>> +
>>
>> It should not be a problem, but is there any reason you're not using
>> do { ... } while(0) or ({ ... }) instead of just braces?
> 
> Yes, that would be better, indeed.
> 
>  Thomas
> 

