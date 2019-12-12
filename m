Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64BDC11D196
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 16:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfLLP5T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 10:57:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40167 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729499AbfLLP5T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 10:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576166237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRNrufMF5ZmcT+/5HZMlWib9qPtBnpXc+naU09rmhxc=;
        b=I/1D3NeyxiyZlMNbK4bu4WwA5RQCzhKoRFQo8VNt3mEFce0g//irADh5p+53pDACxO2wIy
        NMgItXamgQAxJuD8tZ1r/rL9RN+1xBW8xioK2s1u7fgyoFYP6xvAk4Nu7uEUnkJWShBAJw
        N0zHG8T4c4sf6JA0bGDl4jWpGJhcOr4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-AqEm4mHUO6uiGdHf8Vn-fQ-1; Thu, 12 Dec 2019 10:57:16 -0500
X-MC-Unique: AqEm4mHUO6uiGdHf8Vn-fQ-1
Received: by mail-wm1-f70.google.com with SMTP id b131so1018553wmd.9
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2019 07:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rRNrufMF5ZmcT+/5HZMlWib9qPtBnpXc+naU09rmhxc=;
        b=TNrDarrbzUeadzRSTVKS3E14HSAK7aYVa1yekmlqEVdVxfiuz/lcXJHiuhGBMGKRa8
         NxO9lGoIsB5vvG91YrWfolCoI+yIM7/ugfmDjHe2+GH4BtQ+RFJCjaAVJxK9vo7rwJ3o
         vn5rVAczVrAMfIWhBRjzrLpIoRpb+G24lvjPGlPVIoREsdoT21t2UWLpszo3gBUrL819
         OF+OEH83TTLJ8Hm8X3iOqqa3vgk5n4BjxlVfyHzTqTxuFFIA3++GPhpvczXxXYh5sFOf
         RML4l2IVdBbHWtlYVa237W48p1JGOYBmVVvhk0zGDW/OaiuPsq44G1Pr0GWQVTf3EzX8
         7Q3Q==
X-Gm-Message-State: APjAAAX6QAtZbbzDblAaYmyf+jW6afpFaT+uCcK25u1Ah8yWghjzsTcW
        BUklQNYc7hdnE3O1J84xHp95r/Genh6N5yTWV9sVtyrg/dNQXNCLmGbMqej70Njvm9GXrR4Nz9B
        Nl3drdcAHMpMB1dWZla/EB61azJiJ
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr7226950wrm.284.1576166235414;
        Thu, 12 Dec 2019 07:57:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxCcJblbdBpu6fVRmTMMxd9YCps91vlO3a/KrWqDMJ5D1GjIwC7bcnVpKVuMe+qGktQ2LnvbA==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr7226922wrm.284.1576166235182;
        Thu, 12 Dec 2019 07:57:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id s10sm6451431wrw.12.2019.12.12.07.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 07:57:14 -0800 (PST)
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using
 VMX_FEATURES_*
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
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
 <4A24DE75-4E68-4EC6-B3F3-4ACB0EE82BF0@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17c6569e-d0af-539c-6d63-f4c07367d8d1@redhat.com>
Date:   Thu, 12 Dec 2019 16:57:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4A24DE75-4E68-4EC6-B3F3-4ACB0EE82BF0@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/12/19 16:52, Liran Alon wrote:
>>> virt_apic_accesses	-> vapic
>> apicv
> Frankly, I dislike APICv terminology. I prefer to enumerate the
> various VMX features which are collectively called APICv by KVM. 
> APICv currently represents in KVM terminology the combination of
> APIC-register virtualization, virtual-interrupt-delivery and
> posted-interrupts (See cpu_has_vmx_apicv()).
> 
> In fact, the coupling of “enable_apicv” module parameter have made me
> multiple times to need to disable entire APICv features when there
> for example was only a bug in posted-interrupts.
> 
> Even you got confused as virtualize-apic-access is not part of KVM’s
> APICv terminology but rather it’s enablement depend on
> flexpriority_enabled (See cpu_need_virtualize_apic_accesses()). i.e.
> It can be used for faster intercept handling of accesses to guest
> xAPIC MMIO page.

Right, I got confused with APIC-register virtualization.  Virtualize
APIC accesses is another one I wouldn't bother putting in /proc/cpuinfo,
since it's usually present together with flexpriority.

Paolo

