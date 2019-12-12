Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A67C11D541
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 19:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfLLSXx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 13:23:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21878 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730305AbfLLSXw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 13:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576175031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8xkoB5cjmgUHQdkZ5cb+CrM+r0RqlkKkbDVU3rOPMZ8=;
        b=KGuFALjCm5agyZb0cP0y3uNsm4Zc+mcit9Azsp+owViUP3oh3+Rx9ntr/dUZJyFMrMYfPg
        6axo+J+r1GERlfyqr4svvOOyhGCnYFZ11S3R7gt1nW6c2FIdaW/4HK5KKybzVH/9SpAZ0U
        MdZ4Tw0aoBkkDNPoSiMiYqWZNk13rz0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-yPG7XeJiM9acj3PYW3tvlw-1; Thu, 12 Dec 2019 13:23:50 -0500
X-MC-Unique: yPG7XeJiM9acj3PYW3tvlw-1
Received: by mail-wr1-f71.google.com with SMTP id h30so1348015wrh.5
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2019 10:23:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8xkoB5cjmgUHQdkZ5cb+CrM+r0RqlkKkbDVU3rOPMZ8=;
        b=RdgxTWMlXoqIA6phakftVL+ajxXY+u70h9CMXr6qJ0X9739122pcsdYM8loZnqamij
         kAl4RspnZfH7+fpD83NqzOHCf56+lOxHIq/ffbLhtfZiwcGWdplgjmEmOENhe2707dzg
         OEp1832WuFdDOR9bUVVdB0GTCTvMLEldtvYn9VRhf0iKCagm/frkROk/59w4NxN2tRAa
         uXjZb7r7j8BC9q27aSBIbXxsmrNPBfKRE3GHF6u9eUoLD73FdNXuVfqmSDSfnngbaU7/
         IBjpMRKsdCOWTIi/VnDtRjuCiHQuZEeyUGd8gbiVFa/3G9OVt8VhZZcsQDOW7FLdXGLE
         vZWQ==
X-Gm-Message-State: APjAAAWwQ617ebFshpMNPtk7jGS9pNL0xNhStfY8FgQUAkPy2UZWMNqN
        uYYUZo0tOZPdCDXreD4i0UMcX/GrFz1jj1NyBdr6JJvfAP8qGpSTRyS8peZ69A6ID1HpumsPN1B
        O7YOd0JQfRbYy+pu379BbA2VCGoEa
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr1926340wml.110.1576175028867;
        Thu, 12 Dec 2019 10:23:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqwd0K98LLLLMzVZpxkLM2pTQcUwdjipnXu8DaxkR8GuX/5jLVy+o+UUfsD7E3+5ZFzP6L279w==
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr1926312wml.110.1576175028600;
        Thu, 12 Dec 2019 10:23:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id h2sm6896950wrv.66.2019.12.12.10.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 10:23:47 -0800 (PST)
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using
 VMX_FEATURES_*
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-12-sean.j.christopherson@intel.com>
 <20191212122646.GE4991@zn.tnic>
 <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com>
 <20191212181802.GH3163@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d6c0344-ccfa-13fc-695b-1e69298507dc@redhat.com>
Date:   Thu, 12 Dec 2019 19:23:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191212181802.GH3163@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/12/19 19:18, Sean Christopherson wrote:
> Using v<feature> across the board makes sense to keep things consistent,
> i.e. vnmi, vtpr, vapic, etc...
> 
> Anyone have thoughts on how to shorten "APIC-register virtualization"
> without colliding with vapic or apicv?  I currently have apic_reg_virt,
> which is a bit wordy.  apic_regv isn't awful, but I don't love it.

Perhaps vapic_access and vapic_register?

> 
> The other control that will be awkard is "Virtual Interrupt Delivery".
> vint_delivery?

We can just use vid I think.  And posted_intr.

>>> unrestricted_guest	-> unres_guest
>>
>> Full? Or just unrestricted
> 
> I prefer unrestricted_guest, a bare unrestricted just makes me wonder
> "unrestricted what?".   But I can live with "unrestricted" if that's the
> consensus.

I do prefer unrestricted_guest actually.

>> In general I would stick to the same names as kvm_intel module
>> parameters (sans "enable_" if applicable) and not even bother publishing
>> the others.  Some features are either not used by KVM or available on
>> all VMX processors.
> 
> IMO there's value in printing features that are not 1:1 with module params.
> 
> I also think it makes sense to print features of interest even if KVM
> doesn't (yet) support the feature, e.g. to allow a user/developer to check
> if they can use/test a KVM build with support for a new feature without
> having to build and install the new kernel.
> 
>> Paolo
>>
>>> and so on. Those are just my examples - I betcha the SDM is more
>>> creative here with abbreviations. But you guys are going to grep for
>>> them. If it were me, I'd save on typing. :-)
> 

