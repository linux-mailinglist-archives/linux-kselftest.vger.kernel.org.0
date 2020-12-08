Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571392D2FF1
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 17:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgLHQli (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 11:41:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40038 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgLHQlh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 11:41:37 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607445655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iq3ZgfbLiNh1DRbKNB8RtarB5zocyMl+IvwCrRY4efk=;
        b=QvT6lUSM1ljLedM+bk5U6sdWNgx9/wbsKML2tTtr4lSqF7mo+yTooxJH0tSp+Zbo3gS+6A
        VKsy2m0U+sSr88M0D50DIZW1GYnfzDUohIsA4Meax2SrU5sIIfI918x1UmzjA9FZiAMHOA
        VHSAdjMh5BoIQtuHUTllixZ6VXUX/BrteI0hBG97GyZ1Um/0DUXOPK5NVQ0xOuEoYjv1Uw
        C+5sqmmHTl9BymtN0inwXNIKB+jhDt0Fd9IXq0pnaVsWh27dnRNng6n5rGPaTvEKqdK3tx
        kGScmjSDRGBE4vvHLi+21cCGgcIxXhyJ4RILoPH8Lz8ACw03Q2gX4mjo1sxZdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607445655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iq3ZgfbLiNh1DRbKNB8RtarB5zocyMl+IvwCrRY4efk=;
        b=Mf3MTvcLP8LeKWQiIe+uRXjllsWBuKTimcyW5BgxQoQ16nudU1gZeR0rXUNtxyXtywjWHB
        cgyyKiir1JzVPZCQ==
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Oliver Upton <oupton@google.com>
Cc:     kvm list <kvm@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
In-Reply-To: <d3dd82950301517e47630cc86fa0e6dc84f63f90.camel@redhat.com>
References: <20201203171118.372391-1-mlevitsk@redhat.com> <20201203171118.372391-2-mlevitsk@redhat.com> <CAOQ_Qsj6THRPj2ta3PdOxUJeCj8KxPnLkWV8EGpvN_J=qUv74A@mail.gmail.com> <d3dd82950301517e47630cc86fa0e6dc84f63f90.camel@redhat.com>
Date:   Tue, 08 Dec 2020 17:40:54 +0100
Message-ID: <87lfe82quh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 08 2020 at 13:13, Maxim Levitsky wrote:
> On Mon, 2020-12-07 at 11:29 -0600, Oliver Upton wrote:
>> 
>> How would a VMM maintain the phase relationship between guest TSCs
>> using these ioctls?
>
> By using the nanosecond timestamp. 
>  
> While I did made it optional in the V2 it was done for the sole sake of being 
> able to set TSC on (re)boot to 0 from qemu, and for cases when qemu migrates 
> from a VM where the feature is not enabled.
> In this case the tsc is set to the given value exactly, just like you
> can do today with KVM_SET_MSRS.
> In all other cases the nanosecond timestamp will be given.
>  
> When the userspace uses the nanosecond timestamp, the phase relationship
> would not only be maintained but be exact, even if TSC reads were not
> synchronized and even if their restore on the target wasn't synchronized as well.
>  
> Here is an example:
>  
> Let's assume that TSC on source/target is synchronized, and that the guest TSC
> is synchronized as well.
>
> Let's call the guest TSC frequency F (guest TSC increments by F each second)
>  
> We do KVM_GET_TSC_STATE on vcpu0 and receive (t0,tsc0).
> We do KVM_GET_TSC_STATE on vcpu1 after 1 second passed (exaggerated) 
> and receive (t0 + 1s, tsc0 + F)

Why?

You freeeze the VM and store the realtime timestamp of doing that. At
that point assuming a full sync host system the only interesting thing
to store is the guest offset which is the same on all vCPUs and it is
known already.

So on restore the only thing which needs to be adjusted is the guest
wide offset.

     newoffset = oldoffset + (now - tfreeze)

Then set newoffset for all vCPUs. Anything else is complexity for no
value and bound to fall apart in hard to debug ways.

The offset is still the same for all vCPUs whether you can restore them
in the same nanosecond or whether you need 3 minutes for each one. It
does not matter because when you restore vCPU1 3 minutes after vCPU0
then TSC has advanced 3 minutes as well. It's still correct from the
guest POV.

Even if you support TSCADJUST and let the guest write to it does not
change the per guest offset at all. TSCADJUST is per [v]CPU and adds on
top:

    tscvcpu = tsc_host + guest_offset + TSC_ADJUST

Scaling is just orthogonal and does not change any of this.

Thanks,

        tglx
