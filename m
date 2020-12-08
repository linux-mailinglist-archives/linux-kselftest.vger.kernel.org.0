Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EFC2D2EF8
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 17:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgLHQCv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 11:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbgLHQCv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 11:02:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8F0C061749;
        Tue,  8 Dec 2020 08:02:11 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607443328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OKlRn520nT8vggcY29Ix8iyTH2l49X0B5FwK/ElYSBA=;
        b=xprSNkIX8qblXpGydmH4fm+9/uXFY2x+l1v7r+9Y5wB3RE9MMOlKMPuRSJoagVucdF+scT
        wd7jopWwCCyzBNFBLJDrcaNwAG26A1hvmFa/A5BRMEj3qXOWrxbmA7W3pMlpquS9gxgyau
        zJAHQMMiPUp3Haj3hE8joIPnM/7DAklwroxA8nv3OpSPm/XX30KNsxgjcxAKFOwdTpOzwH
        o/+I9/lfNihucVS28bZlGsiUKsxKeDzKs4vXLtMzzzFYKevBgkrvitPUmsH30is2ZncBxs
        uTzaIPC1HZnsIMnN+p+uPlJ8XwxHMF4PLtKQrkmonfu8+MQM6P0gJeR51EHbXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607443328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OKlRn520nT8vggcY29Ix8iyTH2l49X0B5FwK/ElYSBA=;
        b=ur20sQQ3aLZM8Yi1S/nMicFyMeBZoAxPPRv4Ihgbz6g/mDKXzHKljiGygWMKXt6Qji3wAS
        lsHpzczEyz0ml7AQ==
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     kvm@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
In-Reply-To: <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com>
References: <20201203171118.372391-1-mlevitsk@redhat.com> <20201203171118.372391-2-mlevitsk@redhat.com> <20201207232920.GD27492@fuller.cnet> <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com>
Date:   Tue, 08 Dec 2020 17:02:07 +0100
Message-ID: <87sg8g2sn4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 08 2020 at 16:50, Maxim Levitsky wrote:
> On Mon, 2020-12-07 at 20:29 -0300, Marcelo Tosatti wrote:
>> > +This ioctl allows to reconstruct the guest's IA32_TSC and TSC_ADJUST value
>> > +from the state obtained in the past by KVM_GET_TSC_STATE on the same vCPU.
>> > +
>> > +If 'KVM_TSC_STATE_TIMESTAMP_VALID' is set in flags,
>> > +KVM will adjust the guest TSC value by the time that passed since the moment
>> > +CLOCK_REALTIME timestamp was saved in the struct and current value of
>> > +CLOCK_REALTIME, and set the guest's TSC to the new value.
>> 
>> This introduces the wraparound bug in Linux timekeeping, doesnt it?

Which bug?

> It does.
> Could you prepare a reproducer for this bug so I get a better idea about
> what are you talking about?
>
> I assume you need very long (like days worth) jump to trigger this bug
> and for such case we can either work around it in qemu / kernel 
> or fix it in the guest kernel and I strongly prefer the latter.
>
> Thomas, what do you think about it?

For one I have no idea which bug you are talking about and if the bug is
caused by the VMM then why would you "fix" it in the guest kernel.

Aside of that I think I made it pretty clear what the right thing to do
is.

Thanks,

        tglx
