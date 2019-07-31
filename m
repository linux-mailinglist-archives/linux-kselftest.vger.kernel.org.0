Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732FE7BF16
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2019 13:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfGaLQk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Jul 2019 07:16:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfGaLQk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Jul 2019 07:16:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FC1C308FC4B;
        Wed, 31 Jul 2019 11:16:39 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 063D65D6A7;
        Wed, 31 Jul 2019 11:16:32 +0000 (UTC)
Subject: Re: [PATCH 1/2] KVM: selftests: Implement ucall() for s390x
To:     Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-2-thuth@redhat.com>
 <20190730104807.7uzuvd52foybakgu@kamzik.brq.redhat.com>
 <d9cb3c86-6390-3803-f2c6-d47f5c24139f@redhat.com>
 <20190731102849.x26rdan7cddmpvhe@kamzik.brq.redhat.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzRxUaG9tYXMgSHV0
 aCA8dGguaHV0aEBnbXguZGU+wsF7BBMBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIX
 gAUCUfuWKwIZAQAKCRAu2dd0/nAttbe/EACb9hafyOb2FmhUqeAiBORSsUifFacQ7laVjcgR
 I4um8CSHvxijYftpkM2EdAtmXIKgbNDpQoXcWLXB9lu9mLgTO4DVT00TRR65ikn3FCWcyT74
 ENTOzRKyKLsDCjhXKPblTPIQbYAUCOWElcyAPm0ERd62fA/rKNxgIiNo/l4UODOMoOJm2/Ox
 ZoTckW68Eqv7k9L7m7j+Hn3hoDTjAmcCBJt+j7pOhzWvCbqoNOIH8C8qvPaNlrba+R/K6jkO
 6jZkTbYQpGIofEQJ/TNn38IsNGpI1ALTHWFtoMxp3j2Imz0REO6dRE2fHRN8sVlHgkoeGhmY
 NbDsDE1jFQOEObFnu0euk//7BXU7tGOHckVAZ8T1smiRPHfQU7UEH2a/grndxJ+PNeM5w7n2
 l+FN3cf2KgPotCK2s9MjSdZA7C5e3rFYO8lqiqTJKvc62vqp3e7B0Kjyy5/QtzSOejBij2QL
 xkKSFNtxIz4MtuxN8e3IDQNxsKry3nF7R4MDvouXlMo6wP9KuyNWb+vFJt9GtbgfDMIFVamp
 ZfhEWzWRJH4VgksENA4K/BzjEHCcbTUb1TFsiB1VRnBPJ0SqlvifnfKk6HcpkDk6Pg8Q5FOJ
 gbNHrdgXsm+m/9GF2zUUr+rOlhVbK23TUqKqPfwnD7uxjpakVcJnsVCFqJpZi1F/ga9IN87B
 TQRR+3lMARAAtp831HniPHb9AuKq3wj83ujZK8lH5RLrfVsB4X1wi47bwo56BqhXpR/zxPTR
 eOFT0gnbw9UkphVc7uk/alnXMDEmgvnuxv89PwIQX6k3qLABeV7ykJQG/WT5HQ6+2DdGtVw3
 2vjYAPiWQeETsgWRRQMDR0/hwp8s8tL/UodwYCScH6Vxx9pdy353L1fK4Bb9G73a+9FPjp9l
 x+WwKTsltVqSBuSjyZQ3c3EE8qbTidXZxB38JwARH8yN3TX+t65cbBqLl/zRUUUTapHQpUEd
 yoAsHIml32e4q+3xdLtTdlLi7FgPBItSazcqZPjEcYW73UAuLcmQmfJlQ5PkDiuqcitn+KzH
 /1pqsTU7QFZjbmSMJyXY0TDErOFuMOjf20b6arcpEqse1V3IKrb+nqqA2azboRm3pEANLAJw
 iVTwK3qwGRgK5ut6N/Znv20VEHkFUsRAZoOusrIRfR5HFDxlXguAdEz8M/hxXFYYXqOoaCYy
 6pJxTjy0Y/tIfmS/g9Bnp8qg9wsrsnk0+XRnDVPak++G3Uq9tJPwpJbyO0vcqEI3vAXkAB7X
 VXLzvFwi66RrsPUoDkuzj+aCNumtOePDOCpXQGPpKl+l1aYRMN/+lNSk3+1sVuc2C07WnYyE
 gV/cbEVklPmKrNwu6DeUyD0qI/bVzKMWZAiB1r56hsGeyYcAEQEAAcLBXwQYAQIACQUCUft5
 TAIbDAAKCRAu2dd0/nAttYTwEACLAS/THRqXRKb17PQmKwZHerUvZm2klo+lwQ3wNQBHUJAT
 p2R9ULexyXrJPqjUpy7+voz+FcKiuQBTKyieiIxO46oMxsbXGZ70o3gxjxdYdgimUD6U8PPd
 JH8tfAL4BR5FZNjspcnscN2jgbF4OrpDeOLyBaj6HPmElNPtECHWCaf1xbIFsZxSDGMA6cUh
 0uX3Q8VI7JN1AR2cfiIRY7NrIlWYucJxyKjO3ivWm69nCtsHiJ0wcF8KlVo7F2eLaufo0K8A
 ynL8SHMF3VEyxsXOP2f1UR9T2Ur30MXcTBpjUxml1TX3RWY5uH89Js/jlIugBwuAmacJ7JYh
 lTg6sF/GNc4nPb4kk2yktNWTade+TzsllYlJPaorD2Qe8qX0iFUhFC6y9+O6mP4ZvWoYapp9
 ezYNuebMgEr93ob1+4sFg3812wNP01WqsGtWCJHnPv/JoonFdMzD/bIkXGEJMk6ks2kxQQZq
 g6Ik/s/vxOfao/xCn8nHt7GwvVy41795hzK6tbSl+BuyCRp0vfPRP34OnK7+jR2nvQpJu/pU
 rCELuGwT9hsYkUPjVd4lfylN3mzEc6iAv/wwjsc0DRTSQCpXT3v2ymTAsRKrVaEZLibTXaf+
 WslxWek3xNYRiqwwWAJuL652eAlxUgQ5ZS+fXBRTiQpJ+F26I/2lccScRd9G5w==
Organization: Red Hat
Message-ID: <0c38beb7-7383-a7ac-13d4-9d4bde4a21bb@redhat.com>
Date:   Wed, 31 Jul 2019 13:16:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190731102849.x26rdan7cddmpvhe@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 31 Jul 2019 11:16:39 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 31/07/2019 12.28, Andrew Jones wrote:
> On Wed, Jul 31, 2019 at 11:43:16AM +0200, Thomas Huth wrote:
>> On 30/07/2019 12.48, Andrew Jones wrote:
>>> On Tue, Jul 30, 2019 at 12:01:11PM +0200, Thomas Huth wrote:
>>>> On s390x, we can neither exit via PIO nor MMIO, but have to use
>>>> an instruction like DIAGNOSE. While we're at it, rename UCALL_PIO
>>>> to UCALL_DEFAULT, since PIO only works on x86 anyway, and this
>>>> way we can re-use the "default" type for the DIAGNOSE exit on s390x.
>>>>
>>>> Now that ucall() is implemented, we can use it in the sync_reg_test
>>>> on s390x, too.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  .../testing/selftests/kvm/include/kvm_util.h  |  2 +-
>>>>  tools/testing/selftests/kvm/lib/ucall.c       | 34 +++++++++++++++----
>>>>  .../selftests/kvm/s390x/sync_regs_test.c      |  6 ++--
>>>>  3 files changed, 32 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
>>>> index e0e66b115ef2..c37aea2e33e5 100644
>>>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>>>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>>>> @@ -167,7 +167,7 @@ int vm_create_device(struct kvm_vm *vm, struct kvm_create_device *cd);
>>>>  
>>>>  /* ucall implementation types */
>>>>  typedef enum {
>>>> -	UCALL_PIO,
>>>> +	UCALL_DEFAULT,
>>>
>>> I'd rather we keep explicit types defined; keep PIO and add DIAG. Then
>>> we can have
>>>
>>> /*  Set default ucall types */
>>> #if defined(__x86_64__)
>>>   ucall_type = UCALL_PIO;
>>> #elif defined(__aarch64__)
>>>   ucall_type = UCALL_MMIO;
>>>   ucall_requires_init = true;
>>> #elif defined(__s390x__)
>>>   ucall_type = UCALL_DIAG;
>>> #endif
>>>
>>> And add an assert in get_ucall()
>>>
>>>  assert(!ucall_requires_init || ucall_initialized);
>>
>> I'm not sure whether I really like that. It's yet another additional
>> #ifdef block, and yet another variable ...
>>
>> What do you think about removing the enum completely and simply code it
>> directly, without the ucall_type indirection, i.e.:
>>
>> void ucall(uint64_t cmd, int nargs, ...)
>> {
>> 	struct ucall uc = {
>> 		.cmd = cmd,
>> 	};
>> 	va_list va;
>> 	int i;
>>
>> 	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
>>
>> 	va_start(va, nargs);
>> 	for (i = 0; i < nargs; ++i)
>> 		uc.args[i] = va_arg(va, uint64_t);
>> 	va_end(va);
>>
>> #if defined(__x86_64__)
>>
>> 	/* Exit via PIO */
>> 	asm volatile("in %[port], %%al"
>> 		: : [port] "d" (UCALL_PIO_PORT), "D" (&uc) : "rax");
>>
>> #elif defined(__aarch64__)
>>
>> 	*ucall_exit_mmio_addr = (vm_vaddr_t)&uc;
>>
>> #elif defined(__s390x__)
>>
>> 	/* Exit via DIAGNOSE 0x501 (normally used for breakpoints) */
>> 	asm volatile ("diag 0,%0,0x501" : : "a"(&uc) : "memory");
>>
>> #endif
>> }
>>
>> I think that's way less confusing than having to understand the meaning
>> of ucall_type etc. before...?
>>
> 
> Sounds good to me.

Or maybe even better: Let's move this file into lib/x86_64/ and
lib/aarch64/ instead, since there is more different code between the
architectures here than common code.

 Thomas
