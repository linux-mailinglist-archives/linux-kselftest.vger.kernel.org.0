Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA8F1479EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 10:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAXJDP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 04:03:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46117 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726436AbgAXJDP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 04:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579856593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DWQzuLSC9rbGUSX9W5MY+bqvNOnhUYtM5PXQwvcZHL4=;
        b=ABf0OelnwMfI60h/BmxL/T1f7ByUMYAXRTGTwAtuvztqp4+wKZIf7T1RYNSnzYHL6TaXrQ
        /frM5xq7gsSVocAX/6e0ZVopi7gfg3fRVZ2boTG4bETfc6dFb8ocDxQuRoQu9JrZWoqcDt
        n/0lncfe8lVMfv8bDmjjuKVaF4d28XY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-8DpvduoFN1ihLXsZWGbxOw-1; Fri, 24 Jan 2020 04:03:12 -0500
X-MC-Unique: 8DpvduoFN1ihLXsZWGbxOw-1
Received: by mail-wm1-f72.google.com with SMTP id y24so410310wmj.8
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2020 01:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DWQzuLSC9rbGUSX9W5MY+bqvNOnhUYtM5PXQwvcZHL4=;
        b=eOZvreVDAGi/3mfMM1rQdoqXMN4tIJBjjriTnSK029Q3xRAYJyAqbK8kd42isYJoyH
         w+49jgjTLRuWJXrybCpuSZjZT+ZC6wWCcSPovhWfshRhpG8VKjo6kinbXIsdCW6fPj09
         c2SFpp/c9VzdofREewt60ADYL/XQm7FakKR9bJ7Ur28SYwNA94JUzVxqaWct+4IGDB9Z
         My/ElQx+7PUuay1UXt93GVshVhQMpJhQyQ6E+3OoApP4tzpqJVp/qa4OFN4B8i1QzcRc
         av3QtNuriMccQQW2gGL0+B2f28xZHHzdJ82AJUvj3ixtNXBH5OVP3ltuwO4of0gbf9hg
         3Xhg==
X-Gm-Message-State: APjAAAWXFkxAlig7HB0qZ5VmkLvT4GOtsFrcS774CHzbqgDP9rB0TeFn
        m6htFQ3se3sHTmaOf5msZ0j4r0nYklljNP91Tpx+dkXMwgpfoGnveS1KsiVdw5ZUKsCi0OAX7Nk
        dmTtLt5yMHOKC0oLnq5uD+nvF/K5X
X-Received: by 2002:a05:6000:367:: with SMTP id f7mr3012946wrf.174.1579856590911;
        Fri, 24 Jan 2020 01:03:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyaGN3UdvCYTbeY28CNwrJyBQf51wQAGG6tGLv/4g4kU1JLQtjF80zQAsYzfL+f+qFWL+9rYA==
X-Received: by 2002:a05:6000:367:: with SMTP id f7mr3012903wrf.174.1579856590638;
        Fri, 24 Jan 2020 01:03:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id b17sm6672643wrx.15.2020.01.24.01.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 01:03:10 -0800 (PST)
Subject: Re: [PATCH v4 06/10] KVM: selftests: Add support for vcpu_args_set to
 aarch64 and s390x
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-7-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4dbb6d1b-3162-d9b3-4ebb-5e4061776bb6@redhat.com>
Date:   Fri, 24 Jan 2020 10:03:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200123180436.99487-7-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CCing Marc, Conny and Christian (plus Thomas and Drew who were already
in the list) for review.

Thanks,

Paolo

On 23/01/20 19:04, Ben Gardon wrote:
> Currently vcpu_args_set is only implemented for x86. This makes writing
> tests with multiple vCPUs difficult as each guest vCPU must either a.)
> do the same thing or b.) derive some kind of unique token from it's
> registers or the architecture. To simplify the process of writing tests
> with multiple vCPUs for s390 and aarch64, add set args functions for
> those architectures.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  .../selftests/kvm/lib/aarch64/processor.c     | 33 +++++++++++++++++
>  .../selftests/kvm/lib/s390x/processor.c       | 35 +++++++++++++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> index 86036a59a668e..a2ff90a75f326 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> @@ -333,3 +333,36 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
>  {
>  	aarch64_vcpu_add_default(vm, vcpuid, NULL, guest_code);
>  }
> +
> +/* VM VCPU Args Set
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   vcpuid - VCPU ID
> + *   num - number of arguments
> + *   ... - arguments, each of type uint64_t
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * Sets the first num function input arguments to the values
> + * given as variable args.  Each of the variable args is expected to
> + * be of type uint64_t. The registers set by this function are r0-r7.
> + */
> +void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
> +{
> +	va_list ap;
> +
> +	TEST_ASSERT(num >= 1 && num <= 8, "Unsupported number of args,\n"
> +		    "  num: %u\n",
> +		    num);
> +
> +	va_start(ap, num);
> +
> +	for (i = 0; i < num; i++)
> +		set_reg(vm, vcpuid, ARM64_CORE_REG(regs.regs[num]),
> +			va_arg(ap, uint64_t));
> +
> +	va_end(ap);
> +}
> diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
> index 32a02360b1eb0..680f37be9dbc9 100644
> --- a/tools/testing/selftests/kvm/lib/s390x/processor.c
> +++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
> @@ -269,6 +269,41 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
>  	run->psw_addr = (uintptr_t)guest_code;
>  }
>  
> +/* VM VCPU Args Set
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   vcpuid - VCPU ID
> + *   num - number of arguments
> + *   ... - arguments, each of type uint64_t
> + *
> + * Output Args: None
> + *
> + * Return: None
> + *
> + * Sets the first num function input arguments to the values
> + * given as variable args.  Each of the variable args is expected to
> + * be of type uint64_t. The registers set by this function are r2-r6.
> + */
> +void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
> +{
> +	va_list ap;
> +	struct kvm_regs regs;
> +
> +	TEST_ASSERT(num >= 1 && num <= 5, "Unsupported number of args,\n"
> +		    "  num: %u\n",
> +		    num);
> +
> +	va_start(ap, num);
> +	vcpu_regs_get(vm, vcpuid, &regs);
> +
> +	for (i = 0; i < num; i++)
> +		regs.gprs[i + 2] = va_arg(ap, uint64_t);
> +
> +	vcpu_regs_set(vm, vcpuid, &regs);
> +	va_end(ap);
> +}
> +
>  void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
>  {
>  	struct vcpu *vcpu = vm->vcpu_head;
> 

