Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4692D6C94
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 01:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394070AbgLKA3M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 19:29:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393591AbgLKA3H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 19:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607646461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=smSusb6V6UpqcgwJnIn5HTzBcj5wuKKaCTquGzVm8wA=;
        b=Ghc/KzfXKWaeartQ2tlocNw4Pxqm4jg2tYN6P0hRjWUtoGUvQE3OJgOxiqX8cybBruaE35
        4BS+mOv6+Ca4oTqMylKcEJLAn+CLsb0MjmTUH/Bf3vilLC5n78vYa/L04NWR34/mq9czCv
        NboWcHS0x+WRiEo5CoAZFWheAkGeY4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-01-RlXyYP0eRgWNEySdgJA-1; Thu, 10 Dec 2020 19:27:37 -0500
X-MC-Unique: 01-RlXyYP0eRgWNEySdgJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70D00180A086;
        Fri, 11 Dec 2020 00:27:34 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB44A100239F;
        Fri, 11 Dec 2020 00:27:32 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id BFCF94172EDF; Thu, 10 Dec 2020 21:27:03 -0300 (-03)
Date:   Thu, 10 Dec 2020 21:27:03 -0300
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
Message-ID: <20201211002703.GA47016@fuller.cnet>
References: <20201203171118.372391-2-mlevitsk@redhat.com>
 <20201207232920.GD27492@fuller.cnet>
 <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com>
 <87sg8g2sn4.fsf@nanos.tec.linutronix.de>
 <20201208181107.GA31442@fuller.cnet>
 <875z5c2db8.fsf@nanos.tec.linutronix.de>
 <20201209163434.GA22851@fuller.cnet>
 <87r1nyzogg.fsf@nanos.tec.linutronix.de>
 <20201210152618.GB23951@fuller.cnet>
 <87zh2lib8l.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh2lib8l.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10, 2020 at 10:48:10PM +0100, Thomas Gleixner wrote:
> On Thu, Dec 10 2020 at 12:26, Marcelo Tosatti wrote:
> > On Wed, Dec 09, 2020 at 09:58:23PM +0100, Thomas Gleixner wrote:
> >> Marcelo,
> >> 
> >> On Wed, Dec 09 2020 at 13:34, Marcelo Tosatti wrote:
> >> > On Tue, Dec 08, 2020 at 10:33:15PM +0100, Thomas Gleixner wrote:
> >> >> On Tue, Dec 08 2020 at 15:11, Marcelo Tosatti wrote:
> >> >> > max_cycles overflow. Sent a message to Maxim describing it.
> >> >> 
> >> >> Truly helpful. Why the hell did you not talk to me when you ran into
> >> >> that the first time?
> >> >
> >> > Because 
> >> >
> >> > 1) Users wanted CLOCK_BOOTTIME to stop counting while the VM 
> >> > is paused (so we wanted to stop guest clock when VM is paused anyway).
> >> 
> >> How is that supposed to work w/o the guest kernels help if you have to
> >> keep clock realtime up to date? 
> >
> > Upon VM resume, we notify NTP daemon in the guest to sync realtime
> > clock.
> 
> Brilliant. What happens if there is no NTP daemon? What happens if the
> NTP daemon is not part of the virt orchestration magic and cannot be
> notified, then it will notice the time jump after the next update
> interval.
> 
> What about correctness?
> 
> ALL CLOCK_* stop and resume when the VM is resumed at the point where
> they stopped.
> 
> So up to the point where NTP catches up and corrects clock realtime and
> TAI other processes can observe that time jumped in the outside world,
> e.g. via a network packet or whatever, but there is no reason why time
> should have jumped outside vs. the local one.
> 
> You really all live in a seperate universe creating your own rules how
> things which other people work hard on to get it correct can be screwed
> over.

	1. T = read timestamp.
	2. migrate (VM stops for a certain period).
	3. use timestamp T.

> Of course this all is nowhere documented in detail. At least a quick
> search with about 10 different keyword combinations revealed absolutely
> nothing.
> 
> This features first, correctness later frenzy is insane and it better
> stops now before you pile even more crap on the existing steaming pile
> of insanities.

Sure.

