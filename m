Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF372D59BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 12:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbgLJLw3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 06:52:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbgLJLtv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 06:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607600905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYPQDiAhm8hSh2USepS5FHexuq2b5Pq9ywrQrkIfNpo=;
        b=Hyy25Z2afntXyb6wipTl2pKeT4dsSiYn6NS3NGjdNsfQ4JOD9UubNlfZaF9RelilOxBHp4
        WFIRRvXMSSC7tG1Uyi+NWKO61E3Nkmry7gWTDll9qn5M4vqZ+0sbLGkrg/+4qc1SkyOR18
        v4/WAFzv5yp5PutkRYnSq+Mpw3WXWGw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-33MaG1fsO1GvGYiXf2QGBw-1; Thu, 10 Dec 2020 06:48:24 -0500
X-MC-Unique: 33MaG1fsO1GvGYiXf2QGBw-1
Received: by mail-ed1-f69.google.com with SMTP id a9so2339420edy.8
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 03:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nYPQDiAhm8hSh2USepS5FHexuq2b5Pq9ywrQrkIfNpo=;
        b=hRkRYv82ivHXs0IWVktEUVFgflP3vALzE3hNJHUUJSCOXOCoDBh1+fLhf+7oufcbaN
         QxyYvEUI2QbNlZvFOXuUM0tDVH2rYh6/yEjn5MRwlx+tjUca6kj4aCE5d8Qin3rJWVdo
         N0h2p8hkKG1LozcO4oa0/Xbdl+irXe37Vx5Q69U7Qo50oFDiHeZr16MOT0ibvqfqWP9M
         A0uZMcEV5m+HdORGxQHi6EFBZFR7DtF2g+G8Khs8jfnJsDQoea+Q1IlLoKDdzDoxuvvN
         /cnLL1tzz9qStvglxzhuJQxvTKxAcV30XxTRbSKqEQ8/OEYahcBXIFXouXLi5Pe0hWiz
         QJlw==
X-Gm-Message-State: AOAM531qG+0tG61Cu/xXh1NlaIYpfwnbNj8W5MW9JvEjZ5SkIedQn4xO
        BfiUBb16+N1kIGOU//mVgebsR9rsX3l1ZEimArcLzXETQowAWeQmAC4xDnmxO4/YbHFzkAKyZ8T
        SApfIfnIzfDE3iYPh2oF6L2faQ7HT
X-Received: by 2002:a17:906:60c4:: with SMTP id f4mr5984862ejk.336.1607600903198;
        Thu, 10 Dec 2020 03:48:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQgXMt4toLvnNgD5Cb9xhVQ4EUd7Fk1QIvNq7IrqgtLyqfYak4c6SknAeDik9vCfyF8qAaQg==
X-Received: by 2002:a17:906:60c4:: with SMTP id f4mr5984837ejk.336.1607600903022;
        Thu, 10 Dec 2020 03:48:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id rk12sm4108614ejb.75.2020.12.10.03.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 03:48:22 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oliver Upton <oupton@google.com>
Cc:     kvm list <kvm@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
 <20201203171118.372391-2-mlevitsk@redhat.com>
 <CAOQ_Qsj6THRPj2ta3PdOxUJeCj8KxPnLkWV8EGpvN_J=qUv74A@mail.gmail.com>
 <d3dd82950301517e47630cc86fa0e6dc84f63f90.camel@redhat.com>
 <87lfe82quh.fsf@nanos.tec.linutronix.de>
 <047afdde655350a6701803aa8ae739a8bd1c1c14.camel@redhat.com>
Message-ID: <7c25e8c0-a7d4-8906-ae47-20714e6699fe@redhat.com>
Date:   Thu, 10 Dec 2020 12:48:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <047afdde655350a6701803aa8ae739a8bd1c1c14.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 08/12/20 18:08, Maxim Levitsky wrote:
>> Even if you support TSCADJUST and let the guest write to it does not
>> change the per guest offset at all. TSCADJUST is per [v]CPU and adds on
>> top:
>>
>>      tscvcpu = tsc_host + guest_offset + TSC_ADJUST
>>
>> Scaling is just orthogonal and does not change any of this.
>
> I agree with this, and I think that this is what we will end up doing.
> Paulo, what do you think about this?

Yes, you can have a VM ioctl that saves/restores cur_tsc_nsec and 
cur_tsc_write.  The restore side would loop on all vcpus.

However, it is not so easy: 1) it would have to be usable only if 
KVM_X86_QUIRK_TSC_HOST_ACCESS is false, 2) it would fail if 
kvm->arch.nr_vcpus_matched_tsc == kvm->online_vcpus (which basically 
means that userspace didn't mess up the TSC configuration).  If not, it 
would return -EINVAL.

Also, while at it let's burn and pour salt on the support for 
KVM_SET_TSC_KHZ unless TSC scaling is supported, together with 
vcpu->tsc_catchup and all the "tolerance" crap that is in 
kvm_set_tsc_khz.  And initialize vcpu->arch.virtual_tsc_khz to 
kvm->arch.last_tsc_khz before calling kvm_synchronize_tsc.

Paolo

