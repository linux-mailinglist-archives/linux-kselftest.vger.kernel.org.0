Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F7C2D6240
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 17:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgLJQnl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 11:43:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392384AbgLJQmD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 11:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607618436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2N89GAWJh2oijgPtEoE6/Kndq4JEGomfZWV0U25Lc9I=;
        b=Me5mm9gTdrGrqBeahfBfwVOsgkqNHCv2ghZ7MQegcbZC5oiuGeXw0JChdG1I0LBj68bd6Q
        MBx5q6XdnEgXYokJldYF5iqRejyNI7yrnd8bIUopmkfQ+v4o6l2xzZIvAItdTdNJCdOMRA
        S8aiO5SS1oqlGKmbiEdFVOa3xm7eHwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-q2wahnQyOFCzTISxvSExEQ-1; Thu, 10 Dec 2020 11:40:35 -0500
X-MC-Unique: q2wahnQyOFCzTISxvSExEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08BA8107ACE4;
        Thu, 10 Dec 2020 16:40:31 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C95319718;
        Thu, 10 Dec 2020 16:40:30 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id CC8E441853FD; Thu, 10 Dec 2020 12:26:18 -0300 (-03)
Date:   Thu, 10 Dec 2020 12:26:18 -0300
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
Message-ID: <20201210152618.GB23951@fuller.cnet>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
 <20201203171118.372391-2-mlevitsk@redhat.com>
 <20201207232920.GD27492@fuller.cnet>
 <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com>
 <87sg8g2sn4.fsf@nanos.tec.linutronix.de>
 <20201208181107.GA31442@fuller.cnet>
 <875z5c2db8.fsf@nanos.tec.linutronix.de>
 <20201209163434.GA22851@fuller.cnet>
 <87r1nyzogg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1nyzogg.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 09, 2020 at 09:58:23PM +0100, Thomas Gleixner wrote:
> Marcelo,
> 
> On Wed, Dec 09 2020 at 13:34, Marcelo Tosatti wrote:
> > On Tue, Dec 08, 2020 at 10:33:15PM +0100, Thomas Gleixner wrote:
> >> On Tue, Dec 08 2020 at 15:11, Marcelo Tosatti wrote:
> >> > max_cycles overflow. Sent a message to Maxim describing it.
> >> 
> >> Truly helpful. Why the hell did you not talk to me when you ran into
> >> that the first time?
> >
> > Because 
> >
> > 1) Users wanted CLOCK_BOOTTIME to stop counting while the VM 
> > is paused (so we wanted to stop guest clock when VM is paused anyway).
> 
> How is that supposed to work w/o the guest kernels help if you have to
> keep clock realtime up to date? 

Upon VM resume, we notify NTP daemon in the guest to sync realtime
clock.
> 
> > 2) The solution to inject NMIs to the guest seemed overly
> > complicated.
> 
> Why do you need NMIs?
> 
> All you need is a way to communicate to the guest that it should prepare
> for clock madness to happen. Whether that's an IPI or a bit in a
> hyperpage which gets checked during the update of the guest timekeeping
> does not matter at all.
> 
> But you certainly do not need an NMI because there is nothing useful you
> can do within an NMI.
> 
> Thanks,
> 
>         tglx

