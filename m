Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABC32D2819
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 10:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgLHJtN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 04:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgLHJtN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 04:49:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C952C061749;
        Tue,  8 Dec 2020 01:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7bcvgstjEVppk7+MPyrtpEwXq1xns69yzQtxAznXpyE=; b=SkHw+uYjKNb2aRytJV+52kzv2l
        MvuPXaK9BuESM9VjTmzXK7/dz2iUL0/CKuWMcKZ6ylR9V4qTU7kKLJA5oLvopX9zlQZ4lr/4q0pxn
        pJ5DFi/Q9r5l3f8IE+PuhxpAgDXnh+rvAvTG3y8cWw1EoGb8l8jrm8Naru/+2I2BcKHaoig27oXck
        b5//ZGMl6IejdckF35Y9xfmYGwR5VzWAxWNuFGEd8GaLJUYm5QLsYd/K0V235dnZSO3q0PLZd8f0n
        huBpRfNObPAfLG2WG+A+Ez5TyuQpzHN9KZtrerHlyJ8KCFiD1PqDgzYQIE1W6V457XeIvQmtI4iQr
        +aaB37sA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmZbQ-0002Bc-38; Tue, 08 Dec 2020 09:48:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91DA7304BAE;
        Tue,  8 Dec 2020 10:48:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B47720812B43; Tue,  8 Dec 2020 10:48:09 +0100 (CET)
Date:   Tue, 8 Dec 2020 10:48:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20201208094809.GT2414@hirez.programming.kicks-ass.net>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
 <20201203171118.372391-2-mlevitsk@redhat.com>
 <87a6uq9abf.fsf@nanos.tec.linutronix.de>
 <1dbbeefc7c76c259b55582468ccd3aab35a6de60.camel@redhat.com>
 <87im9dlpsw.fsf@vitty.brq.redhat.com>
 <875z5d5x9m.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z5d5x9m.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 07, 2020 at 06:41:41PM +0100, Thomas Gleixner wrote:

> Right this happens still occasionally, but for quite some time this is
> 100% firmware sillyness and not a fundamental property of the hardware
> anymore.

Ever since Nehalem (2008) TSC is synchronized on <= 2 sockets, and any
observed deviation is firmware fail. I don't remember exactly where 4
socket and up got reliable.

(there's the physical hotplug case, but let's not make this complicated)

AMD has had Constant TSC since Barcelona which is roughly the same
timeframe IIRC.

So basically every TSC fail in the last decase is due to firmware being
shit.
