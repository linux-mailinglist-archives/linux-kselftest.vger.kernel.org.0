Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19AA2D17B4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Dec 2020 18:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgLGRmY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Dec 2020 12:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGRmY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Dec 2020 12:42:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B6DC061749;
        Mon,  7 Dec 2020 09:41:43 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607362901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L32qUYNVEpBe9pHXHARYKfmodEfeLdlaSl0E/tFjVbY=;
        b=exKT3dqL8Az3jX6xDH5KYgocsTqh4E6l2rVscnGGw8gltDmUGbZ3D3ZQk5bhdBxjfXTa6U
        7RArTzjQbzr2wMV22+0SRKQST2bcl551qSxw348hbuvSNGCkskqDqQsj07+Klr0+BBws/V
        e5/mAKlSNDUOTvpmtoKZA5zQGkhYsVuIBuS+7aUkzlwUQLIPtT4cuqdTMTUO36HRMr6LvL
        sSneVlZbR9KBfW39Dyqtykn6dQnc7Fh2r8Fv7BADk4iIeFvtRNKuFjDYHqcvOccnar3+Dc
        bVMB17gzSRx0T9BpFiVKLBLUdAmH8OO45KTuppw64aNU2Ul1lShochFAN/OFRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607362901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L32qUYNVEpBe9pHXHARYKfmodEfeLdlaSl0E/tFjVbY=;
        b=Gzsj99alnWOe/KUs+jKp4LzquDn7Xo7eVyT96prRvS8wWKKUofOND0uezBo6rcQGjEoqZp
        kOIaHBXdnbtGhuCg==
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
In-Reply-To: <87im9dlpsw.fsf@vitty.brq.redhat.com>
References: <20201203171118.372391-1-mlevitsk@redhat.com> <20201203171118.372391-2-mlevitsk@redhat.com> <87a6uq9abf.fsf@nanos.tec.linutronix.de> <1dbbeefc7c76c259b55582468ccd3aab35a6de60.camel@redhat.com> <87im9dlpsw.fsf@vitty.brq.redhat.com>
Date:   Mon, 07 Dec 2020 18:41:41 +0100
Message-ID: <875z5d5x9m.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 07 2020 at 14:16, Vitaly Kuznetsov wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
>> But other than that I don't mind making TSC offset global per VM thing.
>> Paulo, what do you think about this?
>>
>
> Not Paolo here but personally I'd very much prefer we go this route but
> unsynchronized TSCs are, unfortunately, still a thing: I was observing
> it on an AMD Epyc server just a couple years ago (cured with firmware
> update).

Right this happens still occasionally, but for quite some time this is
100% firmware sillyness and not a fundamental property of the hardware
anymore. Interestingly enough has the number of reports on Intel based
systems vs. such wreckage as obvservable via TSC_ADJUST gone down after
we added support for it and yelled prominently. I wish AMD would have
that as well.

> We try to catch such situation in KVM instead of blowing up but
> this may still result in subtle bugs I believe. Maybe we would be better
> off killing all VMs in case TSC ever gets unsynced (by default).

I just ran a guest on an old machine with unsynchronized TSCs and was
able to observe clock monotonic going backwards between two threads
pinned on two vCPUs, which _is_ bad. Getting unsynced clocks reliably
under control is extremly hard.

> Another thing to this bucket is kvmclock which is currently per-cpu. If
> we forbid TSC to un-synchronize (he-he), there is no point in doing
> that. We can as well use e.g. Hyper-V TSC page method which is
> per-VM. Creating another PV clock in KVM may be a hard sell as all
> modern x86 CPUs support TSC scaling (in addition to TSC offsetting which
> is there for a long time) and when it's there we don't really need a PV
> clock to make migration possible.

That should be the long term goal.

Thanks,

        tglx
