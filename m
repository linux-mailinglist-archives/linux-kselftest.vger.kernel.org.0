Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE191A396E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Apr 2020 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDIR5d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Apr 2020 13:57:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57176 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIR5c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Apr 2020 13:57:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039HsSOG035049;
        Thu, 9 Apr 2020 17:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Pg2OcDUKrQfVlPFmsJbhzB5QRTvU/ra77BrxPivOjCk=;
 b=aJOV2O28pGHnYxaGUOpq3gEQsm+KBTq0ovFCGerImenOU3OlEUNBR1kidQYxOuUrIigS
 NMttosRIXkYqgyqF8GVCFsxlRMl+7QiIZjmfR+oR0irLWSp8w5FOhRPQhgWN5L/1wslr
 +zAYnCciAIoK6EKu4IQf+9vVNIADnVJUNlU0p+eUkqSilbbhX9r3Sy9hqf5mfc+F8leZ
 DlmmxISYAy+Yyx+6EGIfcp3BCYOFI7f1lAjpI93e80Wkl1T+SedRlRqsTPylDqwozqu/
 SgKvoZe+UuDNvMwQp4QDUrg1mODBfnDd3pqX5AvBx/fpNKHMOFvRNrBLMVgYGFZjJ3kD Dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3091m3k0cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 17:57:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039HucHx048444;
        Thu, 9 Apr 2020 17:57:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 309gdcchrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 17:57:27 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 039HvQpw031931;
        Thu, 9 Apr 2020 17:57:27 GMT
Received: from localhost.localdomain (/10.159.147.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Apr 2020 10:57:26 -0700
Subject: Re: [PATCH v4 1/2] selftests: kvm: Add vm_get_fd() in kvm_util
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>,
        pbonzini@redhat.com, kvm@vger.kernel.org
Cc:     drjones@redhat.com, david@redhat.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20200408220818.4306-1-wainersm@redhat.com>
 <20200408220818.4306-2-wainersm@redhat.com>
 <734ebc46-ff31-708b-5a2f-8bda248cd290@oracle.com>
 <a21f3ae5-fb4e-1b9d-c8e7-ac4628c763c2@redhat.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <aed511d0-a51e-bc4c-a265-d9ede82e18f2@oracle.com>
Date:   Thu, 9 Apr 2020 10:57:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a21f3ae5-fb4e-1b9d-c8e7-ac4628c763c2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090129
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/8/20 7:45 PM, Wainer dos Santos Moschetta wrote:
>
> On 4/8/20 10:25 PM, Krish Sadhukhan wrote:
>>
>> On 4/8/20 3:08 PM, Wainer dos Santos Moschetta wrote:
>>> Introduces the vm_get_fd() function in kvm_util which returns
>>> the VM file descriptor.
>>>
>>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>>> ---
>>>   tools/testing/selftests/kvm/include/kvm_util.h | 1 +
>>>   tools/testing/selftests/kvm/lib/kvm_util.c     | 5 +++++
>>>   2 files changed, 6 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h 
>>> b/tools/testing/selftests/kvm/include/kvm_util.h
>>> index a99b875f50d2..4e122819ee24 100644
>>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>>> @@ -254,6 +254,7 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm);
>>>   unsigned int vm_get_page_size(struct kvm_vm *vm);
>>>   unsigned int vm_get_page_shift(struct kvm_vm *vm);
>>>   unsigned int vm_get_max_gfn(struct kvm_vm *vm);
>>> +int vm_get_fd(struct kvm_vm *vm);
>>>     unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, 
>>> size_t size);
>>>   unsigned int vm_num_host_pages(enum vm_guest_mode mode, unsigned 
>>> int num_guest_pages);
>>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c 
>>> b/tools/testing/selftests/kvm/lib/kvm_util.c
>>> index 8a3523d4434f..3e36a1eb8771 100644
>>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>>> @@ -1734,6 +1734,11 @@ unsigned int vm_get_max_gfn(struct kvm_vm *vm)
>>>       return vm->max_gfn;
>>>   }
>>>   +int vm_get_fd(struct kvm_vm *vm)
>>> +{
>>> +        return vm->fd;
>>> +}
>>> +
>>
>>
>> I am just trying to understand why we need a separate function when 
>> the 'vm' variable is all local within the same file. There are a 
>> number of places in kvm_util.c where it is used directly.
>
>
> The problem is to access of kvm_vm attributes outside of kvm_utils.c. 
> For example, if I try to vm->fd in my test I get the compiler error:
>
> mem_slot_test.c: In function ‘test_add_max_slots’:
> mem_slot_test.c:62:16: error: dereferencing pointer to incomplete type 
> ‘struct kvm_vm’
>   ret = ioctl(vm->fd, KVM_SET_USER_MEMORY_REGION,
>                 ^~


My bad !  I missed the fact that the structure is defined in 
kvm_util_internal.h and not in kvm_util.h.


Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>

>
>>
>>
>>>   static unsigned int vm_calc_num_pages(unsigned int num_pages,
>>>                         unsigned int page_shift,
>>>                         unsigned int new_page_shift,
>>
>
