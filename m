Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EEB69E92E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 21:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBUUzH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 15:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBUUzG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 15:55:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4930231E08;
        Tue, 21 Feb 2023 12:54:44 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677012880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hY7q006F2OND5c4UkaeS+ObHGiYQrss6TDkN8Lc6y2A=;
        b=HloeWlzplwUL15wpjuf9zlXP6WnaM7QV/Uea/+4zV7WcxgK673pkmcLFDtvFIeEjbbDC6+
        tSZRGFJLU9RUfQL34E1ahBbua9ucURnXjpoAffQ70nJ5P1K48UbOyXHv41UKDWI/1Cibwr
        1iGgZwAE92wAzJJqC7/jOw4R5zJQAqOHS44OGaua2dThvANCdZCVPpSUMyHhD2wLXYyNds
        aszmsolva7vd6XGaXoLgja3aWhZGfaxTpybNTQo9ypuOWdYwCkf6MFhoFgXcA+3y8XHtoH
        Ln6HQ+PeIc4AgMBTrVqswg76T+4aCM8wZ4xPoth5QCzuEKYc+QA1Vlj56wSrag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677012880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hY7q006F2OND5c4UkaeS+ObHGiYQrss6TDkN8Lc6y2A=;
        b=OSLdO762k0DrNIhX5/aXZ6OU+/37PP/q4zuB/opcfzruqIrVoFcVpi2P3Dkr7wCD9Pzg16
        fu+kYqDOv9n41aCg==
To:     Mingwei Zhang <mizhang@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Gao <chao.gao@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 01/13] x86/fpu/xstate: Avoid getting xstate address
 of init_fpstate if fpstate contains the component
In-Reply-To: <20230221163655.920289-2-mizhang@google.com>
References: <20230221163655.920289-1-mizhang@google.com>
 <20230221163655.920289-2-mizhang@google.com>
Date:   Tue, 21 Feb 2023 21:54:40 +0100
Message-ID: <878rgqoi27.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Mingwei!

On Tue, Feb 21 2023 at 16:36, Mingwei Zhang wrote:
> Avoid getting xstate address of init_fpstate if fpstate contains the xstate
> component. Since XTILEDATA (bit 18) was turned off in xinit, when KVM calls
> __raw_xsave_addr(xinit, 18), it triggers a warning as follows.

This does not parse. Aside of that it gets the ordering of the changelog
wrong. It explain first what the patch is doing by repeating the way too
long subject line and then tries to give some explanation about the
problem.

KVM does not call __raw_xsave_addr() and the problem is completely
independent of KVM.

> __raw_xsave_addr() is an internal function that assume caller does the
> checking, ie., all function arguments should be checked before calling.
> So, instead of removing the WARNING, add checks in
> __copy_xstate_to_uabi_buf().

I don't see checks added. The patch open codes copy_feature() and makes
the __raw_xsave_addr() invocations conditional.

So something like this:

   Subject: x86/fpu/xstate: Prevent false-positive warning in __copy_xstate_to_uabi_buf()

   __copy_xstate_to_uabi_buf() copies either from the tasks XSAVE buffer
   or from init_fpstate into the ptrace buffer. Dynamic features, like
   XTILEDATA, have an all zeroes init state and are not saved in
   init_fpstate, which means the corresponding bit is not set in the
   xfeatures bitmap of the init_fpstate header.

   But __copy_xstate_to_uabi_buf() retrieves addresses for both the
   tasks xstate and init_fpstate unconditionally via __raw_xsave_addr().

   So if the tasks XSAVE buffer has a dynamic feature set, then the
   address retrieval for init_fpstate triggers the warning in
   __raw_xsave_addr() which checks the feature bit in the init_fpstate
   header.

   Prevent this by open coding copy_feature() and making the address
   retrieval conditional on the tasks XSAVE header bit.

So the order here is (in paragraphs):

   1) Explain the context
   2) Explain whats wrong
   3) Explain the consequence
   4) Explain the solution briefly

It does not even need a backtrace, because the backtrace does not give
any relevant information which is not in the text above already.

The actual callchain is completely irrelevant for desribing this
issue. If you really want to add a backtrace, then please trim it by
removing the irrelevant information. See
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces
for further information.

So for this case this would be:

WARNING: CPU: 35 PID: 15304 at arch/x86/kernel/fpu/xstate.c:934 __raw_xsave_addr+0xc8/0xe0
Call Trace:
 <TASK>
 __copy_xstate_to_uabi_buf+0x3cb/0x520
 fpu_copy_guest_fpstate_to_uabi+0x29/0x50

But even fpu_copy_guest_fpstate_to_uabi() is already useless because
__copy_xstate_to_uabi_buf() has multiple callers which all have the very
same problem and they are very simple to find.

Backtraces are useful to illustrate a hard to understand callchain, but
having ~40 lines of backtrace which only contains two relevant lines is
just a distraction.

See?

> Fixes: e84ba47e313d ("x86/fpu: Hook up PKRU into ptrace()")

The problem did not exist at this point in time because dynamic
xfeatures did not exist, neither in hardware nor in kernel support.

Even if dynamic features would have existed then the commit would not be
the one which introduced the problem, All the commit does is to move
back then valid code into a conditional code path.

It fixes:

  471f0aa7fa64 ("x86/fpu: Fix copy_xstate_to_uabi() to copy init states correctly")

which attempted to fix exactly the problem you are seeing, but only
addressed half of it. The underlying problem was introduced with
2308ee57d93d ("x86/fpu/amx: Enable the AMX feature in 64-bit mode")

Random fixes tags are not really helpful.

> @@ -1151,10 +1152,11 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
>  			pkru.pkru = pkru_val;
>  			membuf_write(&to, &pkru, sizeof(pkru));
>  		} else {
> -			copy_feature(header.xfeatures & BIT_ULL(i), &to,
> -				     __raw_xsave_addr(xsave, i),
> -				     __raw_xsave_addr(xinit, i),
> -				     xstate_sizes[i]);

Please add a comment here to explain why this is open coded and does not
use copy_feature(). Something like:

    			/*
                         * Open code copy_feature() to prevent retrieval
                         * of a dynamic features address from xinit, which
                         * is invalid because xinit does not contain the
                         * all zeros init states of dynamic features and
                         * emits a warning.
                         */

> +			xsave_addr = (header.xfeatures & BIT_ULL(i)) ?
> +				__raw_xsave_addr(xsave, i) :
> +				__raw_xsave_addr(xinit, i);
> +
> +			membuf_write(&to, xsave_addr, xstate_sizes[i]);

Other than that. Nice detective work!

Thanks,

        tglx
