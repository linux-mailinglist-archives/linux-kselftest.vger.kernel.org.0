Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745152D27C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 10:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgLHJg7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 04:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgLHJg6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 04:36:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB08C061749;
        Tue,  8 Dec 2020 01:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rfxjMnKfa23WCYW/uF05Lo63iUpOoHmG+cW0xP/UtyU=; b=SSGKYnga74+cAFWbhRPcCOdcBP
        JDqUwZsReurrIA9rgUdaHS+L9ewZyFAgZ7Fs5LCRZmTdJHjZT7Xo+U926ln6+dqOc6LWjAQEFBakC
        FjNyhVCXMu9Ok5QpiThTlRsKU1MzVXRpL0I2WtN1Nkf5Rjda09Br44yQjhoUI9EN66z/Ct4dFLdq6
        lvnxhAITpjvh6D2bASrQboKrnwAEKv+YK5L8aqOVKQe9b6RrzqMpo3K4cuedPIh+iFwVlSR4bWu0z
        MR0xFyc2NjgwGDedU96N9Mc7+O8QACNWFQgkBIct7vFOuz8dWqGthwCAQmNbSukNAtz+LXT+YMDF0
        84K1QaZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmZPF-0001SM-Fi; Tue, 08 Dec 2020 09:35:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7037F3007CD;
        Tue,  8 Dec 2020 10:35:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55E43200C65DC; Tue,  8 Dec 2020 10:35:35 +0100 (CET)
Date:   Tue, 8 Dec 2020 10:35:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
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
        Marcelo Tosatti <mtosatti@redhat.com>,
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
Message-ID: <20201208093535.GS2414@hirez.programming.kicks-ass.net>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
 <20201203171118.372391-2-mlevitsk@redhat.com>
 <87a6uq9abf.fsf@nanos.tec.linutronix.de>
 <1dbbeefc7c76c259b55582468ccd3aab35a6de60.camel@redhat.com>
 <87a6up606r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6up606r.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 07, 2020 at 05:38:36PM +0100, Thomas Gleixner wrote:
> For anything halfways modern the write to TSC is reflected in TSC_ADJUST
> which means you get the precise offset.

IIRC this is true for everything that has TSC_ADJUST.
