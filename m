Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2652DAC26
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Dec 2020 12:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgLOLgw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Dec 2020 06:36:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728092AbgLOLgj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Dec 2020 06:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608032112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fHDy6tJb7RYpPzJn6EeCeZW9kiSrKc2JfgDfxvwFlAk=;
        b=D7iyaPEFCKZ6eDyiAKbFFLxj25VJZgRrf0W8YXPdYbfO4wwGl3VngftqJF0/ZjFySWRqKz
        YfaYoa3GV9eYBcOFHCjenveclhOLS1WxbnRaYZMi65lkPMAWndTJxE/V5RqSGZUHXV8lZk
        0n9G8H8pLNgnSx9i+g1Jc2eU3y/XMuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-CSk_adk_PgiG3AJ3UeaTzw-1; Tue, 15 Dec 2020 06:35:10 -0500
X-MC-Unique: CSk_adk_PgiG3AJ3UeaTzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F238B80ED8A;
        Tue, 15 Dec 2020 11:35:07 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E055C710DB;
        Tue, 15 Dec 2020 11:35:05 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 777A9417F260; Tue, 15 Dec 2020 07:59:27 -0300 (-03)
Date:   Tue, 15 Dec 2020 07:59:27 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
Message-ID: <20201215105927.GA3321@fuller.cnet>
References: <875z5c2db8.fsf@nanos.tec.linutronix.de>
 <20201209163434.GA22851@fuller.cnet>
 <87r1nyzogg.fsf@nanos.tec.linutronix.de>
 <20201210152618.GB23951@fuller.cnet>
 <87zh2lib8l.fsf@nanos.tec.linutronix.de>
 <20201211002703.GA47016@fuller.cnet>
 <87v9d8h3lx.fsf@nanos.tec.linutronix.de>
 <20201211141822.GA67764@fuller.cnet>
 <87k0togikr.fsf@nanos.tec.linutronix.de>
 <d9063c37-a965-d5cf-e923-c0c9f6ddc044@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9063c37-a965-d5cf-e923-c0c9f6ddc044@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 11, 2020 at 10:59:59PM +0100, Paolo Bonzini wrote:
> On 11/12/20 22:04, Thomas Gleixner wrote:
> > > Its 100ms off with migration, and can be reduced further (customers
> > > complained about 5 seconds but seem happy with 0.1ms).
> > What is 100ms? Guaranteed maximum migration time?
> 
> I suppose it's the length between the time from KVM_GET_CLOCK and
> KVM_GET_MSR(IA32_TSC) to KVM_SET_CLOCK and KVM_SET_MSR(IA32_TSC).  But the
> VM is paused for much longer, the sequence for the non-live part of the
> migration (aka brownout) is as follows:
> 
>     pause
>     finish sending RAM            receive RAM               ~1 sec
>     send paused-VM state          finish receiving RAM     \
>                                   receive paused-VM state   ) 0.1 sec
>                                   restart                  /
> 
> The nanosecond and TSC times are sent as part of the paused-VM state at the
> very end of the live migration process.
> 
> So it's still true that the time advances during live migration brownout;
> 0.1 seconds is just the final part of the live migration process.  But for
> _live_ migration there is no need to design things according to "people are
> happy if their clock is off by 0.1 seconds only".  

Agree. What would be a good way to fix this? 

It seems to me using CLOCK_REALTIME as in the interface Maxim is
proposing is prone to difference in CLOCK_REALTIME itself.

Perhaps there is another way to measure that 0.1 sec which is
independent of the clock values of the source and destination hosts
(say by sending a packet once the clock stops counting).

Then on destination measure delta = clock_restart_time - packet_receival
and increase clock by that amount.



> Again, save-to-disk,
> reverse debugging and the like are a different story, which is why KVM
> should delegate policy to userspace (while documenting how to do it right).
> 
> Paolo
> 
> > CLOCK_REALTIME and CLOCK_TAI are off by the time the VM is paused and
> > this state persists up to the point where NTP corrects it with a time
> > jump.
> > 
> > So if migration takes 5 seconds then CLOCK_REALTIME is not off by 100ms
> > it's off by 5 seconds.
> > 
> > CLOCK_MONOTONIC/BOOTTIME might be off by 100ms between pause and resume.
> > 

