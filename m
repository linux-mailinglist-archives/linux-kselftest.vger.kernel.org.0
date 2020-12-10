Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AA32D5A27
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 13:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbgLJMPd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 07:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbgLJMPc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 07:15:32 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09D5C0613CF;
        Thu, 10 Dec 2020 04:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DB9D2pH9CmpJ5O5VlPeB8KKtAT8lj7o0SsGztCVyPIc=; b=v8XablaO9IAVxnRpzKKiYxZ6A4
        e3FokL4c8tO2GFLkoHXXcB0+WfLH0Md9xHCFiMF/Zvq2TUuns77qGs+SKkUsi/8z2lYxR4VCcNfgQ
        Iuo+1NrRwS+aqWX9VVo/LRALvz2V+wQg9L80vPW8+ONsZEr6OyayEEqV4aYPm+ReaXI5XP5Td9huU
        mGNPRvEdXbiDEBWQ8LHUoZme42ePDpcoOMwArsMtSrt43XH1e2iNajNXqC0j/TuNO7DHrQEA90Xqr
        9B78bCN15JC3/hk8Sq1KzmanZFyJTxThUUABuKpJHXg/DXAWxeQmeDcBgX1Eva0ZNZGKPdlf1evIJ
        EncVXFBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knKpy-00066Z-Ct; Thu, 10 Dec 2020 12:14:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1A84A3059C6;
        Thu, 10 Dec 2020 13:14:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7A2F20234B76; Thu, 10 Dec 2020 13:14:17 +0100 (CET)
Date:   Thu, 10 Dec 2020 13:14:17 +0100
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
Message-ID: <20201210121417.GN2414@hirez.programming.kicks-ass.net>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
 <20201203171118.372391-2-mlevitsk@redhat.com>
 <87a6uq9abf.fsf@nanos.tec.linutronix.de>
 <1dbbeefc7c76c259b55582468ccd3aab35a6de60.camel@redhat.com>
 <87im9dlpsw.fsf@vitty.brq.redhat.com>
 <875z5d5x9m.fsf@nanos.tec.linutronix.de>
 <b6e0656b-4e3f-cf47-5ec9-eead44b2f2e9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e0656b-4e3f-cf47-5ec9-eead44b2f2e9@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10, 2020 at 12:42:36PM +0100, Paolo Bonzini wrote:
> On 07/12/20 18:41, Thomas Gleixner wrote:
> > Right this happens still occasionally, but for quite some time this is
> > 100% firmware sillyness and not a fundamental property of the hardware
> > anymore.
> 
> It's still a fundamental property of old hardware.  Last time I tried to
> kill support for processors earlier than Core 2, I had to revert it. That's
> older than Nehalem.

Core2 doesn't use TSC for timekeeping anyway. KVM shouldn't either.
