Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4C76B05AF
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 12:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCHLS0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 06:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCHLSZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 06:18:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B7AF50FBB
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 03:18:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97735106F;
        Wed,  8 Mar 2023 03:19:06 -0800 (PST)
Received: from [10.57.64.31] (unknown [10.57.64.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 393BD3F71A;
        Wed,  8 Mar 2023 03:18:22 -0800 (PST)
Message-ID: <77c34767-7c54-276c-d06d-fc3af10f269d@arm.com>
Date:   Wed, 8 Mar 2023 11:18:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v1 2/2] KVM: selftests: arm64: Fix pte encode/decode for
 PA bits > 48
Content-Language: en-US
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        kvmarm@lists.linux.dev
References: <20230228170756.769461-1-ryan.roberts@arm.com>
 <20230228170756.769461-3-ryan.roberts@arm.com> <ZAd4CyBM79JzqkEu@linux.dev>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZAd4CyBM79JzqkEu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07/03/2023 17:44, Oliver Upton wrote:
> Hi Ryan,
> 
> Thanks for fixing this. Couple of nits:
> 
> On Tue, Feb 28, 2023 at 05:07:56PM +0000, Ryan Roberts wrote:
>> The high bits [51:48] of a physical address should appear at [15:12] in
>> a 64K pte, not at [51:48] as was previously being programmed. Fix this
>> with new helper functions that do the conversion correctly. This also
>> sets us up nicely for adding LPA2 encodings in future.
>>
>> Fixes: 7a6629ef746d ("kvm: selftests: add virt mem support for aarch64")
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> nit: no whitespace between footers.

Sorry my bad; I'm slowly learning the conventions - I'll get there eventually!

> 
>> ---
>>  .../selftests/kvm/lib/aarch64/processor.c     | 32 ++++++++++++++-----
>>  1 file changed, 24 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
>> index 5972a23b2765..13f28d96521c 100644
>> --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
>> +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
>> @@ -58,10 +58,27 @@ static uint64_t pte_index(struct kvm_vm *vm, vm_vaddr_t gva)
>>  	return (gva >> vm->page_shift) & mask;
>>  }
>>  
>> -static uint64_t pte_addr(struct kvm_vm *vm, uint64_t entry)
>> +static uint64_t addr_pte(struct kvm_vm *vm, uint64_t pa, uint64_t attrs)
>>  {
>> -	uint64_t mask = ((1UL << (vm->va_bits - vm->page_shift)) - 1) << vm->page_shift;
>> -	return entry & mask;
>> +	uint64_t pte;
>> +
>> +	pte = pa & GENMASK(47, vm->page_shift);
>> +	if (vm->page_shift == 16)
>> +		pte |= (pa & GENMASK(51, 48)) >> (48 - 12);
> 
> nit: this is a bit of an odd transformation, of course courtesy of the
> architecture. FIELD_GET() might make it a bit more readable:
> 
> 		pte |= FIELD_GET(GENMASK(51, 48), pa) << 12;
> 

Ahh yes, that does look better. I did consider this originally, but thought I
would also need FIELD_PREP() which selftests is not currently using anywhere. So
thought I would steer clear entirely. Anyway, on review, I don't need
FIELD_PREP(), so I've just sent you a respun series using FIELD_GET() in all the
sensible places. I hope I'm not jumping the gun by respinning so quickly - I
didn't think the series was particularly controversial so unlikely to get any
more comments.

