Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F424BB8F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 13:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiBRMOt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 07:14:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiBRMOs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 07:14:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960C1285707;
        Fri, 18 Feb 2022 04:14:31 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IAbx5j004757;
        Fri, 18 Feb 2022 12:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qYg3HbRvuyaDwlHM7pM6xhilL0TvYLUeas7iaFOSKs4=;
 b=oapUP9ukTBd+6fEhkmhMmghy447KM4OKaHQLx6dXARxsCoqenmY1bzxjmrUCmvRtpDRE
 5MpsEY3FTOuzaKJE8ZHv9CcdR4bYzYDb0o3+GmEAtBUvzLtFwKKn0AEh6pPXZi/ZQT47
 9a5xCn3cGHCW2Wbui7RwTpWpz1HAVFjgCJuJZ/SfHFdNONB3rgswDZBjNrtxyCU8Yjx6
 ehZh3C7JsniHLgKbd4Q8akeFVYi7dRFfQCRKI6WjQDo+UKjlh2kD/6hH6XPXdiD1ezsp
 x+FmEbWFLHWUsRnszfJgJhHHRtWgUb34xRtqSWX6FX4iCKgSQ5f+eCf2ZHGjVsLjirrk tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ea9jda9aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 12:14:30 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21ICETOO008647;
        Fri, 18 Feb 2022 12:14:29 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ea9jda9a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 12:14:29 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21IC7rRH027863;
        Fri, 18 Feb 2022 12:14:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3e645khwda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 12:14:27 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21ICEOa818940406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 12:14:24 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17B6EA4054;
        Fri, 18 Feb 2022 12:14:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1A5EA4062;
        Fri, 18 Feb 2022 12:14:22 +0000 (GMT)
Received: from [9.171.81.151] (unknown [9.171.81.151])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Feb 2022 12:14:22 +0000 (GMT)
Message-ID: <2af9c3a9-e5a1-484b-9c1e-693a25993cdb@linux.ibm.com>
Date:   Fri, 18 Feb 2022 13:14:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] KVM: s390: selftests: Test vm and vcpu memop with
 keys
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220211182215.2730017-11-scgl@linux.ibm.com>
 <20220217145336.1794778-1-scgl@linux.ibm.com>
 <20220217145336.1794778-3-scgl@linux.ibm.com>
 <7d0b5b03-21f4-0402-779a-788d4bd58071@linuxfoundation.org>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <7d0b5b03-21f4-0402-779a-788d4bd58071@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dgoOZILauosDLH8qZeOhpT3DQ9BI8vfF
X-Proofpoint-GUID: H5CqkSacmumSN9NkkxkBuif3WNkLkAdt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_04,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/17/22 18:54, Shuah Khan wrote:
> On 2/17/22 7:53 AM, Janis Schoetterl-Glausch wrote:
>> Test storage key checking for both vm and vcpu MEM_OP ioctls.
>> Test both error and non error conditions.
>>
> 
> This patch seems to combine restructuring the code and new code.
> e,g test_errors() was added in the last patch, only to be redone
> in this patch with test_errors split into test_common_errors()
> 
> Doing restructure in a separate patch and then adding new code
> makes it easier to review and also keep them simpler patches.
> 
> Please split the code in these two patches to just do restructure
> and then add new code.
> 
> I also would like to have good reasons to change existing code and
> make them into macros.
>  
>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
>> ---
>>   tools/testing/selftests/kvm/s390x/memop.c | 342 +++++++++++++++++++++-
>>   1 file changed, 328 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
>> index 4510418d73e6..bc12a9238967 100644
>> --- a/tools/testing/selftests/kvm/s390x/memop.c
>> +++ b/tools/testing/selftests/kvm/s390x/memop.c
>> @@ -201,6 +201,8 @@ static int err_memop_ioctl(struct test_vcpu vcpu, struct kvm_s390_mem_op *ksmo)
>>   #define PAGE_SHIFT 12
>>   #define PAGE_SIZE (1ULL << PAGE_SHIFT)
>>   #define PAGE_MASK (~(PAGE_SIZE - 1))
>> +#define CR0_FETCH_PROTECTION_OVERRIDE    (1UL << (63 - 38))
>> +#define CR0_STORAGE_PROTECTION_OVERRIDE    (1UL << (63 - 39))
>>     #define ASSERT_MEM_EQ(p1, p2, size) \
>>       TEST_ASSERT(!memcmp(p1, p2, size), "Memory contents do not match!")
>> @@ -235,6 +237,11 @@ static struct test_default test_default_init(void *guest_code)
>>       return t;
>>   }
>>   +static vm_vaddr_t test_vaddr_alloc(struct test_vcpu vm, size_t size, vm_vaddr_t vaddr_min)
>> +{
>> +    return vm_vaddr_alloc(vm.vm, size, vaddr_min);
>> +}
>> +
> 
> What is the value of adding a new routine that simply calls another?

I just found the vm.vm confusing/ugly and wanted to hide it,
I'm not married to that idea, tho.

> Do you see this routine changing in the future to do more?

No.
> 
> thanks,
> -- Shuah

