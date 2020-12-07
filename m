Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53B62D2D15
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 15:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgLHOZW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 09:25:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729751AbgLHOZQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 09:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607437429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ocH5W3W6/BNUy9ovonqCXcdd/rBC0yAl/SfS8e31LM=;
        b=DkDAjNbiKX4z5iMTdN5El/2EmR+r38/bt+2145csPjOn/PjCO0PjuK1ExN62cn0adHZGIG
        3ZnFN4OL2davyTeUpXIHSfYUlywJEQ4f3VyLAVKoWbAlU8ZddfW0tz0wGo88hyzXvNygcS
        I5hUzI/YprPv5B2Dq09miKmU9ylSX7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-aK6QfRXaO3m8dgajqCgvOA-1; Tue, 08 Dec 2020 09:23:45 -0500
X-MC-Unique: aK6QfRXaO3m8dgajqCgvOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28E2E107ACE4;
        Tue,  8 Dec 2020 14:23:43 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-8.gru2.redhat.com [10.97.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 53D7760877;
        Tue,  8 Dec 2020 14:23:42 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 95B74416CD79; Mon,  7 Dec 2020 20:11:27 -0300 (-03)
Date:   Mon, 7 Dec 2020 20:11:27 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
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
Message-ID: <20201207231127.GB27492@fuller.cnet>
References: <636fecc20b0143128b484f159ff795ff65d05b82.camel@redhat.com>
 <885C1725-B479-47F6-B08D-A7181637A80A@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <885C1725-B479-47F6-B08D-A7181637A80A@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 07, 2020 at 10:04:45AM -0800, Andy Lutomirski wrote:
> 
> > On Dec 7, 2020, at 9:00 AM, Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > 
> > ﻿On Mon, 2020-12-07 at 08:53 -0800, Andy Lutomirski wrote:
> >>>> On Dec 7, 2020, at 8:38 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>> 
> >>> ﻿On Mon, Dec 07 2020 at 14:16, Maxim Levitsky wrote:
> >>>>> On Sun, 2020-12-06 at 17:19 +0100, Thomas Gleixner wrote:
> >>>>> From a timekeeping POV and the guests expectation of TSC this is
> >>>>> fundamentally wrong:
> >>>>> 
> >>>>>     tscguest = scaled(hosttsc) + offset
> >>>>> 
> >>>>> The TSC has to be viewed systemwide and not per CPU. It's systemwide
> >>>>> used for timekeeping and for that to work it has to be synchronized. 
> >>>>> 
> >>>>> Why would this be different on virt? Just because it's virt or what? 
> >>>>> 
> >>>>> Migration is a guest wide thing and you're not migrating single vCPUs.
> >>>>> 
> >>>>> This hackery just papers over he underlying design fail that KVM looks
> >>>>> at the TSC per vCPU which is the root cause and that needs to be fixed.
> >>>> 
> >>>> I don't disagree with you.
> >>>> As far as I know the main reasons that kvm tracks TSC per guest are
> >>>> 
> >>>> 1. cases when host tsc is not stable 
> >>>> (hopefully rare now, and I don't mind making
> >>>> the new API just refuse to work when this is detected, and revert to old way
> >>>> of doing things).
> >>> 
> >>> That's a trainwreck to begin with and I really would just not support it
> >>> for anything new which aims to be more precise and correct.  TSC has
> >>> become pretty reliable over the years.
> >>> 
> >>>> 2. (theoretical) ability of the guest to introduce per core tsc offfset
> >>>> by either using TSC_ADJUST (for which I got recently an idea to stop
> >>>> advertising this feature to the guest), or writing TSC directly which
> >>>> is allowed by Intel's PRM:
> >>> 
> >>> For anything halfways modern the write to TSC is reflected in TSC_ADJUST
> >>> which means you get the precise offset.
> >>> 
> >>> The general principle still applies from a system POV.
> >>> 
> >>>    TSC base (systemwide view) - The sane case
> >>> 
> >>>    TSC CPU  = TSC base + TSC_ADJUST
> >>> 
> >>> The guest TSC base is a per guest constant offset to the host TSC.
> >>> 
> >>>    TSC guest base = TSC host base + guest base offset
> >>> 
> >>> If the guest want's this different per vCPU by writing to the MSR or to
> >>> TSC_ADJUST then you still can have a per vCPU offset in TSC_ADJUST which
> >>> is the offset to the TSC base of the guest.
> >> 
> >> How about, if the guest wants to write TSC_ADJUST, it can turn off all paravirt features and keep both pieces?
> >> 
> > 
> > This is one of the things I had in mind recently.
> > 
> > Even better, we can stop advertising TSC_ADJUST in CPUID to the guest 
> > and forbid it from writing it at all.
> 
> Seems reasonable to me.
> 
> It also seems okay for some MSRs to stop working after the guest enabled new PV timekeeping.
> 
> I do have a feature request, though: IMO it would be quite nifty if the new kvmclock structure could also expose NTP corrections. In other words, if you could expose enough info to calculate CLOCK_MONOTONIC_RAW, CLOCK_MONOTONIC, and CLOCK_REALTIME, then we could have paravirt NTP.

Hi Andy,

Any reason why drivers/ptp/ptp_kvm.c does not work for you?

> Bonus points if whatever you do for CLOCK_REALTIME also exposes leap seconds in a race free way :). But I suppose that just exposing TAI and letting the guest deal with the TAI - UTC offset itself would get the job done just fine.

