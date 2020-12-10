Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1492D5B24
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 14:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbgLJNCu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 08:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387506AbgLJNCt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 08:02:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94BFC0613CF;
        Thu, 10 Dec 2020 05:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8DNWVeAUd7OvyCVtE5PeUeZEuJerl3ZR6gz0ZKvmpyo=; b=QoPx6KFRU+xS+RaJr2y1Qphzjb
        s+yXByA3V4D2JJjPNrqJEj1y++RZMQ2QrVSvDnGQqtmx8Lo3LdXjBPtz6vEngpYhMZ98DjG9GIJ9N
        vXErudo8loKA59o3aKxKOwrOiETZnptD4jkclkS27O9+TI1oA9mUX0LhghbGIG1XS6WdyaqIC019R
        eJRa7Pn/tHHTPljQtMtEZc+TQJWcFm0Ef/WN0X2mlbE2Ut6pZQmyaSKeiAdBskXfwa2uDiHcEnJuN
        GdkBDPHqdcZlK7QNdKtrpU1zccUIpK/CQWvIM06IHs+Ak9gYHhzEXczcug14IEm8h+EtHPNMYGynU
        jDQ0bHzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knLZd-0004f1-BZ; Thu, 10 Dec 2020 13:01:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3D693007CD;
        Thu, 10 Dec 2020 14:01:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C5B7209B20CB; Thu, 10 Dec 2020 14:01:31 +0100 (CET)
Date:   Thu, 10 Dec 2020 14:01:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
Message-ID: <20201210130131.GP2414@hirez.programming.kicks-ass.net>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
 <20201203171118.372391-2-mlevitsk@redhat.com>
 <87a6uq9abf.fsf@nanos.tec.linutronix.de>
 <1dbbeefc7c76c259b55582468ccd3aab35a6de60.camel@redhat.com>
 <87im9dlpsw.fsf@vitty.brq.redhat.com>
 <875z5d5x9m.fsf@nanos.tec.linutronix.de>
 <b6e0656b-4e3f-cf47-5ec9-eead44b2f2e9@redhat.com>
 <20201210121417.GN2414@hirez.programming.kicks-ass.net>
 <fe3e4637-b74b-864a-9d2f-c4f2d9450f2e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe3e4637-b74b-864a-9d2f-c4f2d9450f2e@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10, 2020 at 01:22:02PM +0100, Paolo Bonzini wrote:
> On 10/12/20 13:14, Peter Zijlstra wrote:
> > On Thu, Dec 10, 2020 at 12:42:36PM +0100, Paolo Bonzini wrote:
> > > On 07/12/20 18:41, Thomas Gleixner wrote:
> > > > Right this happens still occasionally, but for quite some time this is
> > > > 100% firmware sillyness and not a fundamental property of the hardware
> > > > anymore.
> > > 
> > > It's still a fundamental property of old hardware.  Last time I tried to
> > > kill support for processors earlier than Core 2, I had to revert it. That's
> > > older than Nehalem.
> > 
> > Core2 doesn't use TSC for timekeeping anyway. KVM shouldn't either.
> 
> On Core2, KVM guests pass TSC through kvmclock in order to get something
> usable and not incredibly slow.

Which is incredibly wrong.
