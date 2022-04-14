Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0900F500DA5
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 14:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbiDNMgb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiDNMga (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 08:36:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876238D6BC;
        Thu, 14 Apr 2022 05:34:05 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EC5IWv029780;
        Thu, 14 Apr 2022 12:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fiwlBWLOFq5oL0tobKxxQ4iltTjdOXEPJXlvllyuO4w=;
 b=kxrXgazTAoSpI5JLseaOkexWWOdD2WXyhElOiHax73RGDQdox78vzVMouu0hyXlWmz2q
 Xn8pNUAAD+pjGqXNTmTb70oCcXD7Hc+f/xEeBaYKreuIys+qBHAlhB+KZwUICIMhmZ5j
 o3mG3CS2R8S9fGMn+ZBSYNaWRUUj7qmpf9JV/iufvknDtzQY64QTijx449bW0JIrEUxO
 5nP/sDbFGVuyi+vhNWIH0N2rHqlc8VEthNFxwIQYHekOzMwsvEcUjG7lpopPq5g9uV1D
 6OBZ+6oRtJrFXrgolgHwmTwhAhbLe7tYIvgL1Gt0Ban26fA0+PzTWzY90/ZlazBnPIZ7 aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fef2mnpw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 12:34:01 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23ECY1T2025809;
        Thu, 14 Apr 2022 12:34:01 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fef2mnpvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 12:34:01 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23ECRr0q014463;
        Thu, 14 Apr 2022 12:33:59 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3fb1s8pvbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 12:33:59 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23ECY5xO25035230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 12:34:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 414FF42041;
        Thu, 14 Apr 2022 12:33:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF7B24203F;
        Thu, 14 Apr 2022 12:33:55 +0000 (GMT)
Received: from [9.171.78.130] (unknown [9.171.78.130])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Apr 2022 12:33:55 +0000 (GMT)
Message-ID: <baa53445-b4de-7a05-24f5-46fa38e61666@linux.ibm.com>
Date:   Thu, 14 Apr 2022 14:33:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] KVM: s390: selftests: Use TAP interface in the tprot
 test
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
References: <20220414105322.577439-1-thuth@redhat.com>
 <20220414105322.577439-4-thuth@redhat.com>
 <20220414135110.6b2baead@p-imbrenda>
 <03f62ec7-2f7f-1f90-3029-d93713ab5afc@redhat.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <03f62ec7-2f7f-1f90-3029-d93713ab5afc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sVebo3Zlhuz3arkf1Wo4usjhuJGbPUl0
X-Proofpoint-GUID: mUCFAyuncBa_4o60m4fzRfF62s25-nZZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-14_04,2022-04-14_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140068
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/14/22 14:08, Thomas Huth wrote:
> On 14/04/2022 13.51, Claudio Imbrenda wrote:
>> On Thu, 14 Apr 2022 12:53:21 +0200
>> Thomas Huth <thuth@redhat.com> wrote:
>>
>>> The tprot test currently does not have any output (unless one of
>>> the TEST_ASSERT statement fails), so it's hard to say for a user
>>> whether a certain new sub-test has been included in the binary or
>>> not. Let's make this a little bit more user-friendly and include
>>> some TAP output via the kselftests.h interface.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   tools/testing/selftests/kvm/s390x/tprot.c | 12 +++++++++++-
>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
>>> index c097b9db495e..a714b4206e95 100644
>>> --- a/tools/testing/selftests/kvm/s390x/tprot.c
>>> +++ b/tools/testing/selftests/kvm/s390x/tprot.c
>>> @@ -8,6 +8,7 @@
>>>   #include <sys/mman.h>
>>>   #include "test_util.h"
>>>   #include "kvm_util.h"
>>> +#include "kselftest.h"
>>>     #define PAGE_SHIFT 12
>>>   #define PAGE_SIZE (1 << PAGE_SHIFT)
>>> @@ -69,6 +70,7 @@ enum stage {
>>>       STAGE_INIT_FETCH_PROT_OVERRIDE,
>>>       TEST_FETCH_PROT_OVERRIDE,
>>>       TEST_STORAGE_PROT_OVERRIDE,
>>> +    NUM_STAGES            /* this must be the last entry */

You could move STAGE_END down and use that instead.

>>>   };
>>>     struct test {
>>> @@ -196,6 +198,7 @@ static void guest_code(void)
>>>       }                                    \
>>>       ASSERT_EQ(uc.cmd, UCALL_SYNC);                        \
>>>       ASSERT_EQ(uc.args[1], __stage);                        \
>>> +    ksft_test_result_pass("" #stage "\n");                    \
>>>   })
>>>     int main(int argc, char *argv[])
>>> @@ -204,6 +207,9 @@ int main(int argc, char *argv[])
>>>       struct kvm_run *run;
>>>       vm_vaddr_t guest_0_page;
>>>   +    ksft_print_header();
>>> +    ksft_set_plan(NUM_STAGES - 1);    /* STAGE_END is not counted, thus - 1 */
>>> +
>>>       vm = vm_create_default(VCPU_ID, 0, guest_code);
>>>       run = vcpu_state(vm, VCPU_ID);
>>>   @@ -213,7 +219,7 @@ int main(int argc, char *argv[])
>>>         guest_0_page = vm_vaddr_alloc(vm, PAGE_SIZE, 0);
>>>       if (guest_0_page != 0)
>>> -        print_skip("Did not allocate page at 0 for fetch protection override tests");
>>> +        ksft_print_msg("Did not allocate page at 0 for fetch protection override tests\n");
>>
>> will this print a skip, though?
> 
> No, it's now only a message.
> 
>> or you don't want to print a skip because then the numbering in the
>> planning doesn't match anymore?
> 
> Right.
> 
>> in which case, is there an easy way to fix it?
> 
> Honestly, this part of the code is a little bit of a riddle to me - I wonder why this was using "print_skip()" at all, since the HOST_SYNC below is executed anyway... so this sounds rather like a warning message to me that says that the following test might not work as expected, instead of a real test-is-skipped message?
> 
> Janis, could you please clarify the intention here?

Both the host and the guest check the same condition independently, the host just to print the message,
then the guest is run and skips those stages.
> 
>  Thomas
> 
>>>       HOST_SYNC(vm, STAGE_INIT_FETCH_PROT_OVERRIDE);
>>>       if (guest_0_page == 0)
>>>           mprotect(addr_gva2hva(vm, (vm_vaddr_t)0), PAGE_SIZE, PROT_READ);
>>> @@ -224,4 +230,8 @@ int main(int argc, char *argv[])
>>>       run->s.regs.crs[0] |= CR0_STORAGE_PROTECTION_OVERRIDE;
>>>       run->kvm_dirty_regs = KVM_SYNC_CRS;
>>>       HOST_SYNC(vm, TEST_STORAGE_PROT_OVERRIDE);
>>> +
>>> +    kvm_vm_free(vm);
>>> +
>>> +    ksft_finished();
>>>   }
>>
> 

