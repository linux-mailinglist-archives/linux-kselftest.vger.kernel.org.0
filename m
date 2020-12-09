Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751EF2D4C58
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Dec 2020 22:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgLIU7G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Dec 2020 15:59:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49336 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgLIU7G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Dec 2020 15:59:06 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607547503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U8FXkEeLmw4j1ELROJYnBZRGobC61UbHYQBmnv42St8=;
        b=fwE70pYwh2irwmwye2/3/Z34cz2hThNe+ULaC9eo2FGfieOgkb89CdwAi3x0fYvhlf3Ou4
        mYWRrOsdlmF5zj5vi8mokDrqWSblAl/mrVGCJUi4JBDVTN3SMiSVM+WpNOd5woQXyiDieN
        hLFCjiN6nri5od9k5b4g4TVRhu6oIaAAScpuFXyyvjgkMozsDZXxN72YNyOkJcuHfXnD88
        5wJul+IQfljI2YnFlQtP6GoZSW73FMATu4Yes0wkHEspqE/Svs6x2ljDq5Yru/2q3Q22Ac
        gj+SvwzADuANXLa2OpSYhatT/jb56ictDYI3iygTZxqy5R6BLUVT4OC8wXXmQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607547503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U8FXkEeLmw4j1ELROJYnBZRGobC61UbHYQBmnv42St8=;
        b=f4NE+mMs/ZqUUwRSXrP7yHu0BlPfcW+WM93A0rcst4gtUNAmF2pEncgBHUV2Qd4+bA2m26
        KFfU0BOrLpgo2dDg==
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
In-Reply-To: <20201209163434.GA22851@fuller.cnet>
References: <20201203171118.372391-1-mlevitsk@redhat.com> <20201203171118.372391-2-mlevitsk@redhat.com> <20201207232920.GD27492@fuller.cnet> <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com> <87sg8g2sn4.fsf@nanos.tec.linutronix.de> <20201208181107.GA31442@fuller.cnet> <875z5c2db8.fsf@nanos.tec.linutronix.de> <20201209163434.GA22851@fuller.cnet>
Date:   Wed, 09 Dec 2020 21:58:23 +0100
Message-ID: <87r1nyzogg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Marcelo,

On Wed, Dec 09 2020 at 13:34, Marcelo Tosatti wrote:
> On Tue, Dec 08, 2020 at 10:33:15PM +0100, Thomas Gleixner wrote:
>> On Tue, Dec 08 2020 at 15:11, Marcelo Tosatti wrote:
>> > max_cycles overflow. Sent a message to Maxim describing it.
>> 
>> Truly helpful. Why the hell did you not talk to me when you ran into
>> that the first time?
>
> Because 
>
> 1) Users wanted CLOCK_BOOTTIME to stop counting while the VM 
> is paused (so we wanted to stop guest clock when VM is paused anyway).

How is that supposed to work w/o the guest kernels help if you have to
keep clock realtime up to date? 

> 2) The solution to inject NMIs to the guest seemed overly
> complicated.

Why do you need NMIs?

All you need is a way to communicate to the guest that it should prepare
for clock madness to happen. Whether that's an IPI or a bit in a
hyperpage which gets checked during the update of the guest timekeeping
does not matter at all.

But you certainly do not need an NMI because there is nothing useful you
can do within an NMI.

Thanks,

        tglx
