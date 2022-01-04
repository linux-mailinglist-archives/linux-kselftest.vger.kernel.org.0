Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCA5484969
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jan 2022 21:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiADUpt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jan 2022 15:45:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233207AbiADUps (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jan 2022 15:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641329147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYrqbdtdF3TH5qv2dr8q46HQl1ZSosdbS+NCJ8IVZW0=;
        b=J9QwNro22DyUx7nTglcV6kUtyj0b4q6NAwQVlzkZRGxw5OUFcm0cUx2MWPllVt97mU5mEX
        QNOHDj05qaRKtyCRumk+NMOTXAAALSOGjGG+7wXXupAdQLFoE+lIoY2dyW9VQwmQvp8hzm
        o/k1N+D6szo17GZNsU0MZa7e+6XV+ks=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-ZAJsKgilNLqe1_EANUzv4Q-1; Tue, 04 Jan 2022 15:45:46 -0500
X-MC-Unique: ZAJsKgilNLqe1_EANUzv4Q-1
Received: by mail-ed1-f69.google.com with SMTP id o20-20020a056402439400b003f83cf1e472so26233559edc.18
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jan 2022 12:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PYrqbdtdF3TH5qv2dr8q46HQl1ZSosdbS+NCJ8IVZW0=;
        b=OeTOWPNPC9/QGi+vrk/WgoK02umpDimhTjJ2KXRnDEFlJE7onN0QJU2IjZjILwgtjg
         DGEt/Qvrxw2CI9aIB/nEesZDvcRZWV7pTv1+Nxg1kfXpfiXwvU9V4sfPOjPaVsqyI4vy
         KEahZCMQvfro1ucE6gCtxfqmWlvF9z2ltIiz/QUyOZumvg+EyN5Rmn1L7pNRti1VTP1m
         uZAjB8WcD9eDmWhwwO09Bt+4iGmH0g6lIvWlDRkR416PMVMq6vCq2nmwR40xS7PMs+AB
         pgbBiN0w+MI0VrH1YcLGy8nnWpXJQIqnUENCMZgb7Yt0HLWuR5yBZ1noHuVGd2YZPy+s
         cGuQ==
X-Gm-Message-State: AOAM5339mb/iy11m6ZZHHJ3SWDDB0Rf/HA/auD+YRe75kp0XsC7+/hDv
        qx8UcCmJJkHr53FSflt4ZRByX/TAT2rNYkQLcCuhpkk+UcpPUJ8bumDy/tvB0Ff715Pkvws6vNJ
        fyUs5H76uYPHjggZHvBjrPg59kt93
X-Received: by 2002:a17:906:9746:: with SMTP id o6mr3103292ejy.112.1641329143959;
        Tue, 04 Jan 2022 12:45:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMBe92plviw0jlSVwnEa2kU3pf6epuXjoKR1YY7Y5SakD1MSKrYxN09nCveIinmPB1gzQR0w==
X-Received: by 2002:a17:906:9746:: with SMTP id o6mr3103286ejy.112.1641329143795;
        Tue, 04 Jan 2022 12:45:43 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id f5sm15075159edu.38.2022.01.04.12.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 12:45:43 -0800 (PST)
Message-ID: <c41a0458-1bfa-9dc6-71ce-f0433cd400e7@redhat.com>
Date:   Tue, 4 Jan 2022 21:45:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 18/21] kvm: x86: Add support for getting/setting
 expanded xstate buffer
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Yang Zhong <yang.zhong@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, corbet@lwn.net, shuah@kernel.org,
        jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com
References: <20211229131328.12283-1-yang.zhong@intel.com>
 <20211229131328.12283-19-yang.zhong@intel.com> <YdSkDAruycpXhNUT@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YdSkDAruycpXhNUT@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/4/22 20:46, Sean Christopherson wrote:
> On Wed, Dec 29, 2021, Yang Zhong wrote:
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index bdf89c28d2ce..76e1941db223 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -4296,6 +4296,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>   		else
>>   			r = 0;
>>   		break;
>> +	case KVM_CAP_XSAVE2:
>> +		r = kvm->vcpus[0]->arch.guest_fpu.uabi_size;
> 
> a) This does not compile against kvm/queue.
> 
>     arch/x86/kvm/x86.c: In function ‘kvm_vm_ioctl_check_extension’:
>     arch/x86/kvm/x86.c:4317:24: error: ‘struct kvm’ has no member named ‘vcpus’
>      4317 |                 r = kvm->vcpus[0]->arch.guest_fpu.uabi_size;
> 
> b) vcpu0 is not guaranteed to be non-NULL at this point.

Yang, you can post an incremental patch for this.  You can use the 
highest bit of the guest-permitted xcr0 (i.e. the OR of KVM's supported 
XCR0 an the guest-permitted dynamic features) and pass it to cpuid(0xD).

Paolo

