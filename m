Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABAE538D71
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 May 2022 11:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245080AbiEaJHI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 May 2022 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245068AbiEaJHE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 May 2022 05:07:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C431CB01;
        Tue, 31 May 2022 02:06:58 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24V6xGdr024794;
        Tue, 31 May 2022 09:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fAHU2rGOL5A9cKDCCU+65wK9t9lX0odo/5gNkrL7RrE=;
 b=d7T4kbhPCvKczmXNb9Oyn6xkcQco5OZB0YFf37LeYzCPb/RzH21kv0bTeB/cjGtnyMsp
 cfyjwmrjS7kDi73gBz4lbiGP0bZ5vpzB2kxV32Ac5YNBYRlJbPLClXsz9fUJPtoJXROc
 hDccOi6bz2fd8ApjR3B3V9IxymKIAaJle+/xnC5oYOiAboB/5qzj7DprGwVXV6rxlOt6
 NnjY7ndf3vv8XVCTGZien0cUg6TQ4KoR/cGMdzZ7W8Kl/kZ9i+GdOmgOdTKSBTGCYo/G
 jFqdPIoNMDgbzgQsHwOgUfC8rHzQvQ3xe6erjakWaA49c/KEYggQ9JSnBH+vXWhKdC8G Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gda53e9ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 09:06:55 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24V8Zh5M030807;
        Tue, 31 May 2022 09:06:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gda53e9fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 09:06:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24V8rHbh015563;
        Tue, 31 May 2022 09:06:52 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3gbcae3ub3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 09:06:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24V95i3G29491500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 09:05:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8274AA404D;
        Tue, 31 May 2022 09:06:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5B34A4040;
        Tue, 31 May 2022 09:06:48 +0000 (GMT)
Received: from [9.171.6.109] (unknown [9.171.6.109])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 May 2022 09:06:48 +0000 (GMT)
Message-ID: <9b3c88f2-ca23-df23-4a5b-d86b0b38a6aa@linux.ibm.com>
Date:   Tue, 31 May 2022 11:06:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 0/4] KVM: s390: selftests: Provide TAP output in tests
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20220429063724.480919-1-thuth@redhat.com>
 <e39149e0-e6c4-f850-cd0f-cbdb453ee0c2@redhat.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <e39149e0-e6c4-f850-cd0f-cbdb453ee0c2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jao7N3FvW6AykUFcVV3MtLJT33K9lNIY
X-Proofpoint-ORIG-GUID: OgBash_X-XnBTBGxkmjQJ6Hhj_Rwpo9A
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_03,2022-05-30_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310047
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Am 31.05.22 um 10:02 schrieb Thomas Huth:
> On 29/04/2022 08.37, Thomas Huth wrote:
>> This patch series is motivated by Shuah's suggestion here:
>>
>>   https://lore.kernel.org/kvm/d576d8f7-980f-3bc6-87ad-5a6ae45609b8@linuxfoundation.org/
>>
>> Many s390x KVM selftests do not output any information about which
>> tests have been run, so it's hard to say whether a test binary
>> contains a certain sub-test or not. To improve this situation let's
>> add some TAP output via the kselftest.h interface to these tests,
>> so that it easier to understand what has been executed or not.
>>
>> v3:
>>   - Added comments / fixed cosmetics according to Janosch's and
>>     Janis' reviews of the v2 series
>>   - Added Reviewed-by tags from the v2 series
>>
>> v2:
>>   - Reworked the extension checking in the first patch
>>   - Make sure to always print the TAP 13 header in the second patch
>>   - Reworked the SKIP printing in the third patch
>>
>> Thomas Huth (4):
>>    KVM: s390: selftests: Use TAP interface in the memop test
>>    KVM: s390: selftests: Use TAP interface in the sync_regs test
>>    KVM: s390: selftests: Use TAP interface in the tprot test
>>    KVM: s390: selftests: Use TAP interface in the reset test
>>
>>   tools/testing/selftests/kvm/s390x/memop.c     | 90 +++++++++++++++----
>>   tools/testing/selftests/kvm/s390x/resets.c    | 38 ++++++--
>>   .../selftests/kvm/s390x/sync_regs_test.c      | 87 +++++++++++++-----
>>   tools/testing/selftests/kvm/s390x/tprot.c     | 29 ++++--
>>   4 files changed, 193 insertions(+), 51 deletions(-)

Can you refresh against latest linus master? I will apply then
