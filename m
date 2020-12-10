Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42F42D599E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 12:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgLJLto (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 06:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726768AbgLJLto (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 06:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607600897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vy7qUFqmJ4w+Yqe/3zBzEgAxcvrIudav4UoG7qWP05M=;
        b=ZIA1qekM+njfi9yjrP/elOhzUDVE4DKhu+UEJo7ikMU7kvfZE7t59FaW9nNFif2lmrGWFV
        6ZXh9DGaIkHjyPIXc7alHjipdB5CuOcZqD/o+xe8Wx20EOVwyLQsGGT4vEwl9V3RTwYRPW
        iiTEdIv70FXsmrzfOcHhvyRuYsvV1+U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-TGfM8l8BNSKgw_dPt2fGGw-1; Thu, 10 Dec 2020 06:48:15 -0500
X-MC-Unique: TGfM8l8BNSKgw_dPt2fGGw-1
Received: by mail-ej1-f71.google.com with SMTP id g24so1516518ejh.22
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 03:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vy7qUFqmJ4w+Yqe/3zBzEgAxcvrIudav4UoG7qWP05M=;
        b=GLuM3rpblSsHSiOwYQODvH+Q9UZj+c3xaUMU/rEM4UCPsHG1ZvBQDM9L+WDvqf27o1
         xyIh6PGmgtWs6LpVweINLkW7pWTgceUjfYxZtwX18dQ945at65SLPtfx5xyKzOA8qoH4
         Gxi2I0ksgOxuMyj/a1dSReZNruX832nShzp9nOMx7Pa/2hEaPv3zTic2bNrU9jMNAhvd
         4eGWMzCSpHVIkFTczfvMCZs3h6olIchCKyxbmkpaNCcHqCfBVREfDIriJ1GcqedoqC3N
         xPqs7sds07AMnGFOdqPb1wiP2L3Wz2CKg4/rgM6x117bdyGbhGiyhG21DBjWv1YBYPjz
         tFbA==
X-Gm-Message-State: AOAM532fGiK9l3Kgkmcbh6d9fWWbFwhdEWgXd2QzZ3ju3y3xzMOrRbUc
        WblurE0d72PfPR27EOyaG530pWEBcKq1QLuZzURGdjaAoQcaVBGXv1BVT+vTQUoF3hJOwhPs0kL
        iNx+y3F1paAAHYVYftiaakCV528lr
X-Received: by 2002:aa7:d41a:: with SMTP id z26mr6393011edq.267.1607600893836;
        Thu, 10 Dec 2020 03:48:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwT1BgKb53bvs2L+9goeNkFTaweyYQb4Mx9OhlhD01G0jFvMtjmublR8JhvmFDTnhy+1qlKKg==
X-Received: by 2002:aa7:d41a:: with SMTP id z26mr6392996edq.267.1607600893671;
        Thu, 10 Dec 2020 03:48:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id j20sm4182609ejy.124.2020.12.10.03.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 03:48:12 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/3] RFC: Precise TSC migration
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
Message-ID: <566e8346-1e78-2737-be86-0ec27ad147a5@redhat.com>
Date:   Thu, 10 Dec 2020 12:48:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203171118.372391-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I'm queueing patches 2 and 3 for now, since the sane MSR interface is a 
prerequisite anyway.

Paolo

On 03/12/20 18:11, Maxim Levitsky wrote:
> Hi!
> 
> This is the second version of the work to make TSC migration more accurate,
> as was defined by Paulo at:
> https://www.spinics.net/lists/kvm/msg225525.html
> 
> I omitted most of the semi-offtopic points I raised related to TSC
> in the previous RFC where we can continue the discussion.
> 
> I do want to raise another thing that I almost forgot.
> 
> On AMD systems, the Linux kernel will mark the guest tsc as
> unstable unless invtsc is set which is set on recent AMD
> hardware.
> 
> Take a look at 'unsynchronized_tsc()' to verify this.
> 
> This is another thing that IMHO should be fixed at least when
> running under KVM.
> 
> Note that I forgot to mention that
> X86_FEATURE_TSC_RELIABLE also short-circuits this code,
> thus giving another reason to enable it under KVM.
> 
> Changes from V1:
> 
> - added KVM_TSC_STATE_TIMESTAMP_VALID instead of testing ns == 0
> - allow diff < 0, because it is still better that capping it to 0
> - updated tsc_msr_test unit test to cover this feature
> - refactoring
> 
> Patches to enable this feature in qemu are in the process of
> being sent to qemu-devel mailing list.
> 
> Best regards,
>      Maxim Levitsky
> 
> Maxim Levitsky (3):
>    KVM: x86: implement KVM_{GET|SET}_TSC_STATE
>    KVM: x86: introduce KVM_X86_QUIRK_TSC_HOST_ACCESS
>    kvm/selftests: update tsc_msrs_test to cover
>      KVM_X86_QUIRK_TSC_HOST_ACCESS
> 
>   Documentation/virt/kvm/api.rst                | 65 +++++++++++++
>   arch/x86/include/uapi/asm/kvm.h               |  1 +
>   arch/x86/kvm/x86.c                            | 92 ++++++++++++++++++-
>   include/uapi/linux/kvm.h                      | 15 +++
>   .../selftests/kvm/x86_64/tsc_msrs_test.c      | 79 ++++++++++++++--
>   5 files changed, 237 insertions(+), 15 deletions(-)
> 

