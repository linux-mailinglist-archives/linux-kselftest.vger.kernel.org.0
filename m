Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC602D6BC4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 00:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393549AbgLJXTU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 18:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393214AbgLJXTD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 18:19:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1722C061285;
        Thu, 10 Dec 2020 14:35:34 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607636890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fS6Q5Mzy8JmeMJ4Hud0TQwMZS+fqZnoguNO5e8v6TVs=;
        b=QPVSgrSjXozmKT2n8R4x08cAnYxVSNVsEJIc2eOXdokOKwJWBs2OmryPk2gbH9m6ZOKoe8
        e+FoOcRFR2pIFn5LvxJZAHjBjdUwn+McnauUHljGdaHlGQhHp7mcwOKFxgJnADdWgEa9+5
        Wjwl0ZQnBnDjijvfKOKcoVnM9bGg8ZcJUDxLZMr40Tyep1mn50l2na3vzBcnlLIfSVGPHT
        qd1Yig3bi9mFhuiQ3NybufG11BjowHHtfz+hoOB6XRlOCdjaFSoLIwD58Ra+5X0RLs4tmV
        iV22mB1VyAas66wcX/Q3IA4GgfdryNM5nXZSiSOxGRiFKZEL9m0Hzvu7gx/57A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607636890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fS6Q5Mzy8JmeMJ4Hud0TQwMZS+fqZnoguNO5e8v6TVs=;
        b=1mexZVqkZd9QyFLML/IjTcYSbIpLa2tYlJj+Jet5oFipyeOgV1RizLPTsRFrRHCrog9vOU
        wBhOpA0OtkrUPIBA==
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
In-Reply-To: <20201210152618.GB23951@fuller.cnet>
References: <20201203171118.372391-1-mlevitsk@redhat.com> <20201203171118.372391-2-mlevitsk@redhat.com> <20201207232920.GD27492@fuller.cnet> <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com> <87sg8g2sn4.fsf@nanos.tec.linutronix.de> <20201208181107.GA31442@fuller.cnet> <875z5c2db8.fsf@nanos.tec.linutronix.de> <20201209163434.GA22851@fuller.cnet> <87r1nyzogg.fsf@nanos.tec.linutronix.de> <20201210152618.GB23951@fuller.cnet>
Date:   Thu, 10 Dec 2020 22:48:10 +0100
Message-ID: <87zh2lib8l.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10 2020 at 12:26, Marcelo Tosatti wrote:
> On Wed, Dec 09, 2020 at 09:58:23PM +0100, Thomas Gleixner wrote:
>> Marcelo,
>> 
>> On Wed, Dec 09 2020 at 13:34, Marcelo Tosatti wrote:
>> > On Tue, Dec 08, 2020 at 10:33:15PM +0100, Thomas Gleixner wrote:
>> >> On Tue, Dec 08 2020 at 15:11, Marcelo Tosatti wrote:
>> >> > max_cycles overflow. Sent a message to Maxim describing it.
>> >> 
>> >> Truly helpful. Why the hell did you not talk to me when you ran into
>> >> that the first time?
>> >
>> > Because 
>> >
>> > 1) Users wanted CLOCK_BOOTTIME to stop counting while the VM 
>> > is paused (so we wanted to stop guest clock when VM is paused anyway).
>> 
>> How is that supposed to work w/o the guest kernels help if you have to
>> keep clock realtime up to date? 
>
> Upon VM resume, we notify NTP daemon in the guest to sync realtime
> clock.

Brilliant. What happens if there is no NTP daemon? What happens if the
NTP daemon is not part of the virt orchestration magic and cannot be
notified, then it will notice the time jump after the next update
interval.

What about correctness?

ALL CLOCK_* stop and resume when the VM is resumed at the point where
they stopped.

So up to the point where NTP catches up and corrects clock realtime and
TAI other processes can observe that time jumped in the outside world,
e.g. via a network packet or whatever, but there is no reason why time
should have jumped outside vs. the local one.

You really all live in a seperate universe creating your own rules how
things which other people work hard on to get it correct can be screwed
over.

Of course this all is nowhere documented in detail. At least a quick
search with about 10 different keyword combinations revealed absolutely
nothing.

This features first, correctness later frenzy is insane and it better
stops now before you pile even more crap on the existing steaming pile
of insanities.

Thanks,

        tglx




