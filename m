Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C0C147B8C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 10:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgAXJob (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 04:44:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41548 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387396AbgAXJob (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 04:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579859069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpZEOx03qkjAPC4DXp0y4ITh7+pvUeZvi/4/a4rEkrw=;
        b=KhcGjU1okpKfMRadx0VTbIxKLfFamLCVdqI5j29WhBPF6Nt4D/14PNoGdIA1q3aYc0ZMOD
        3713jbKc5FB2QP5pU2fzBjoB85watqT6N6ebQbkRnu33srm/TaLjZolVIKqiYaxXak21/z
        I8KyBdG397UPpbjNwX9rUgv72N/JBm4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-Izj3hFAlMr2X5HWy0FSKGw-1; Fri, 24 Jan 2020 04:44:28 -0500
X-MC-Unique: Izj3hFAlMr2X5HWy0FSKGw-1
Received: by mail-wr1-f71.google.com with SMTP id h30so901891wrh.5
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2020 01:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fpZEOx03qkjAPC4DXp0y4ITh7+pvUeZvi/4/a4rEkrw=;
        b=iCV32eMytb2nMaqirwnsn6wdI579Iwl4MgqIAHDecGK4ilqw+3Je5xLxKVTH2kPD6a
         /DDl6f2xkBGsfHmPPbrIVLnroZHWuUp2UAa9a3IqilW6QmUIavAyNtYYxB3UgQuR2eir
         OuVb0ffclQxyeHSMXe5pxOw+co5vpHt1Y6xvgJxxyHGQbZ76GvBJohwqtx4tSO0Y4qxT
         a/Z5Qytg6Wenam1TPdArun8QMdBr0yqG2Y7+4TnKEdjRrjX0K2nWnoe9un2nI1qzJ+N+
         h/IzBuHC5YeOn8rZeIiv+B7kEUkQCXDwMCgci4HjE9Wexr2A9hCD+3dc/w482RWVA0Jf
         vEBw==
X-Gm-Message-State: APjAAAVNX91e+1lkk6C68LMpDYrK5CrlusxUkaaog8irTmKcDEwJu0BE
        9b4/HHQ8gYUFWdBVPiztyJe3tc7WmKrdN8RSeuI+khzauS2ZUcEoIj+YqFAEpJtPLBGEBllrIEt
        Qgxrm0T36eBPuuMJRoPvb2fgcYFHN
X-Received: by 2002:a05:600c:2383:: with SMTP id m3mr2606044wma.32.1579859066483;
        Fri, 24 Jan 2020 01:44:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqwnRS6L4l/CFse2jZ4BHY9GuVJSgRDyRPOAzj4xk/v28DFFetlGaZsxMJx9TF/v+B2QKfxQ0w==
X-Received: by 2002:a05:600c:2383:: with SMTP id m3mr2606008wma.32.1579859066079;
        Fri, 24 Jan 2020 01:44:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id d204sm1093442wmd.30.2020.01.24.01.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 01:44:25 -0800 (PST)
Subject: Re: [PATCH v4 06/10] KVM: selftests: Add support for vcpu_args_set to
 aarch64 and s390x
To:     Andrew Jones <drjones@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-7-bgardon@google.com>
 <4dbb6d1b-3162-d9b3-4ebb-5e4061776bb6@redhat.com>
 <20200124093543.m5oqo7fnjnc2scko@kamzik.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3fd470e0-2929-c3fc-151a-ef2d682354d9@redhat.com>
Date:   Fri, 24 Jan 2020 10:44:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200124093543.m5oqo7fnjnc2scko@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 24/01/20 10:35, Andrew Jones wrote:
> On Fri, Jan 24, 2020 at 10:03:08AM +0100, Paolo Bonzini wrote:
>> CCing Marc, Conny and Christian (plus Thomas and Drew who were already
>> in the list) for review.
>>
>> Thanks,
>>
>> Paolo
>>
>> On 23/01/20 19:04, Ben Gardon wrote:
>>> Currently vcpu_args_set is only implemented for x86. This makes writing
>>> tests with multiple vCPUs difficult as each guest vCPU must either a.)
>>> do the same thing or b.) derive some kind of unique token from it's
>>> registers or the architecture. To simplify the process of writing tests
>>> with multiple vCPUs for s390 and aarch64, add set args functions for
>>> those architectures.
> 
> It'd be nice to keep the separate architecture changes in separate
> patches. Otherwise I can't really give an r-b.

You can say:

For ARM parts:

Reviewed-by: ...

Paolo

>>>
>>> Signed-off-by: Ben Gardon <bgardon@google.com>
>>> ---
>>>  .../selftests/kvm/lib/aarch64/processor.c     | 33 +++++++++++++++++
>>>  .../selftests/kvm/lib/s390x/processor.c       | 35 +++++++++++++++++++
>>>  2 files changed, 68 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
>>> index 86036a59a668e..a2ff90a75f326 100644
>>> --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
>>> +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
>>> @@ -333,3 +333,36 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
>>>  {
>>>  	aarch64_vcpu_add_default(vm, vcpuid, NULL, guest_code);
>>>  }
>>> +
>>> +/* VM VCPU Args Set
>>> + *
>>> + * Input Args:
>>> + *   vm - Virtual Machine
>>> + *   vcpuid - VCPU ID
>>> + *   num - number of arguments
>>> + *   ... - arguments, each of type uint64_t
>>> + *
>>> + * Output Args: None
>>> + *
>>> + * Return: None
>>> + *
>>> + * Sets the first num function input arguments to the values
>>> + * given as variable args.  Each of the variable args is expected to
>>> + * be of type uint64_t. The registers set by this function are r0-r7.
>>> + */
> 
> lib/aarch64/processor.c so far doesn't have big function headers like
> this. Also, since this function is common for all architectures [now],
> I feel like the documentation should be in common code - so in the header
> file.
> 
>>> +void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
>>> +{
>>> +	va_list ap;
>>> +
>>> +	TEST_ASSERT(num >= 1 && num <= 8, "Unsupported number of args,\n"
>>> +		    "  num: %u\n",
>>> +		    num);
> 
> Weird line breaking. I see it came from the x86 implementation, but it's
> weird there too... Personally I'd just put it all on one line, because
> my vt100 died two decades ago.
> 
>>> +
>>> +	va_start(ap, num);
>>> +
>>> +	for (i = 0; i < num; i++)
>>> +		set_reg(vm, vcpuid, ARM64_CORE_REG(regs.regs[num]),
>                                                              ^^ should be 'i'
> 
>>> +			va_arg(ap, uint64_t));
> 
> nit: I'd use {} because of the line break. Or just not break the line and
> bust the 80 char "limit" (RIP vt100).
> 
> Thanks,
> drew
> 
>>> +
>>> +	va_end(ap);
>>> +}
>>> diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
>>> index 32a02360b1eb0..680f37be9dbc9 100644
>>> --- a/tools/testing/selftests/kvm/lib/s390x/processor.c
>>> +++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
>>> @@ -269,6 +269,41 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
>>>  	run->psw_addr = (uintptr_t)guest_code;
>>>  }
>>>  
>>> +/* VM VCPU Args Set
>>> + *
>>> + * Input Args:
>>> + *   vm - Virtual Machine
>>> + *   vcpuid - VCPU ID
>>> + *   num - number of arguments
>>> + *   ... - arguments, each of type uint64_t
>>> + *
>>> + * Output Args: None
>>> + *
>>> + * Return: None
>>> + *
>>> + * Sets the first num function input arguments to the values
>>> + * given as variable args.  Each of the variable args is expected to
>>> + * be of type uint64_t. The registers set by this function are r2-r6.
>>> + */
>>> +void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
>>> +{
>>> +	va_list ap;
>>> +	struct kvm_regs regs;
>>> +
>>> +	TEST_ASSERT(num >= 1 && num <= 5, "Unsupported number of args,\n"
>>> +		    "  num: %u\n",
>>> +		    num);
>>> +
>>> +	va_start(ap, num);
>>> +	vcpu_regs_get(vm, vcpuid, &regs);
>>> +
>>> +	for (i = 0; i < num; i++)
>>> +		regs.gprs[i + 2] = va_arg(ap, uint64_t);
>>> +
>>> +	vcpu_regs_set(vm, vcpuid, &regs);
>>> +	va_end(ap);
>>> +}
>>> +
>>>  void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
>>>  {
>>>  	struct vcpu *vcpu = vm->vcpu_head;
>>>
>>
> 

