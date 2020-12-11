Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01222D7B1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 17:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgLKQjh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Dec 2020 11:39:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727321AbgLKQjM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Dec 2020 11:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607704665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cdTuLvtPwt3VYNUDiFde6cWBAI4tq1wL3wORhmXo5h0=;
        b=JB9loP8czo4Pz9Xe+Os9D4RNu6x5eByt5u/4/NyAGdV49xagVcf+hOr6rEfCCCXTJn2OKT
        FSRCCN5YPzdTybn7rExb+FVS5pmXcbCP2GsNToMeUMp1awC0QrcF2nfxl+Eb3qtRUw4b2F
        K/Tbh3Ul3/+7xEo6xFXBMfqJuxtsC3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-kd-9L3KwMaOHzx_xia9-HA-1; Fri, 11 Dec 2020 11:37:43 -0500
X-MC-Unique: kd-9L3KwMaOHzx_xia9-HA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCE66100C66F;
        Fri, 11 Dec 2020 16:37:39 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD82C19C78;
        Fri, 11 Dec 2020 16:37:38 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 1DF444172ED8; Fri, 11 Dec 2020 11:18:22 -0300 (-03)
Date:   Fri, 11 Dec 2020 11:18:22 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20201211141822.GA67764@fuller.cnet>
References: <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com>
 <87sg8g2sn4.fsf@nanos.tec.linutronix.de>
 <20201208181107.GA31442@fuller.cnet>
 <875z5c2db8.fsf@nanos.tec.linutronix.de>
 <20201209163434.GA22851@fuller.cnet>
 <87r1nyzogg.fsf@nanos.tec.linutronix.de>
 <20201210152618.GB23951@fuller.cnet>
 <87zh2lib8l.fsf@nanos.tec.linutronix.de>
 <20201211002703.GA47016@fuller.cnet>
 <87v9d8h3lx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9d8h3lx.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 11, 2020 at 02:30:34PM +0100, Thomas Gleixner wrote:
> On Thu, Dec 10 2020 at 21:27, Marcelo Tosatti wrote:
> > On Thu, Dec 10, 2020 at 10:48:10PM +0100, Thomas Gleixner wrote:
> >> You really all live in a seperate universe creating your own rules how
> >> things which other people work hard on to get it correct can be screwed
> >> over.
> >
> > 	1. T = read timestamp.
> > 	2. migrate (VM stops for a certain period).
> > 	3. use timestamp T.
> 
> This is exactly the problem. Time stops at pause and continues where it
> stopped on resume.
> 
> But CLOCK_REALTIME and CLOCK_TAI advanced in reality. So up to the point
> where NTP fixes this - if there is NTP at all - the guest CLOCK_REALTIME
> and CLOCK_TAI are off by tpause.
> 
> Now the application gets a packet from the outside world with a
> CLOCK_REALTIME timestamp which is suddenly ahead of the value it reads
> from clock_gettime(CLOCK_REALTIME) by tpause. So what is it supposed to
> do with that? Make stupid assumptions that the other end screwed up
> timekeeping, throw an error that the system it is running on screwed up
> timekeeping? And a second later when NTP catched up it gets the next
> surprise because the systems CLOCK_REALTIME jumped forward unexpectedly
> or if there is no NTP it's confused forever.

This can happen even with a "perfect" solution that syncs time
instantly on the migration destination. See steps 1,2,3.

Unless you notify applications to invalidate their time reads,
i can't see a way to fix this.

Therefore if you use VM migration in the first place, a certain amount of
timestamp accuracy error must be tolerated.

> How can you even assume that this is correct?

As noted above, even without a window of unsynchronized time (due to
delay for NTP to sync time), time reads can be stale.

> It is exactly the same problem as we had many years ago with hardware
> clocks suddenly stopping to tick which caused quite some stuff to go
> belly up.

Customers complained when it was 5 seconds off, now its 0.1ms (and
people seem happy).

> In a proper suspend/resume scenario CLOCK_REALTIME/TAI are advanced
> (with a certain degree of accuracy) to compensate for the sleep time, so
> the other end of a communication is at least in the same ballpark, but
> not 50 seconds off.

Its 100ms off with migration, and can be reduced further (customers
complained about 5 seconds but seem happy with 0.1ms).

> >> This features first, correctness later frenzy is insane and it better
> >> stops now before you pile even more crap on the existing steaming pile
> >> of insanities.
> >
> > Sure.
> 
> I wish that would be true. OS people - you should know that - are
> fighting forever with hardware people over feature madness and the
> attitude of 'we can fix that in software' which turns often enough out
> to be wrong.
> 
> Now sadly enough people who suffered from that madness work on
> virtualization and instead of trying to avoid the same problem they go
> off and make it even worse.

So you think its important to reduce the 100ms offset? 

> It's the same problem again as with hardware people. Not talking to the
> other people _before_ making uninformed assumptions and decisions.
> 
> We did it that way because big customer asked for it is not a
> justification for inflicting this on everybody else and thereby
> violating correctness. Works for me and my big customer is not a proof
> of correctness either.
> 
> It's another proof that this industry just "works" by chance.
> 
> Thanks,
> 
>         tglx

OK, makes sense, then reducing the 0.1ms window even further
is a useful thing to do. What would be an acceptable 
CLOCK_REALTIME accuracy error, on migration?



