Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3DD2D355C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 22:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgLHVgJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 16:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLHVgJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 16:36:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA39EC0613CF;
        Tue,  8 Dec 2020 13:35:28 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607463327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d8xXDa+xA2WqTiRtB82k0uurlIcN0PDOr9qLhVEuoGw=;
        b=gV24dbuqb7RWhc6Cs1ie+nYy+k7y5DD4iI0bwsI+ImpsshLl2SYQSx0CfWRK/iwvzzrfu3
        66VOoamIeID7TP7zn+DceSrrJkywPK1xjRfjlaibflCt6a0Xidwb+XLR9SShvWYlASvP/H
        8Mu+xQszBPPbMruI9xKMvoipcejINjPjVUkqwAPuMLMrihdDxNzXPirzVqhOiSZdyZi+Cx
        xwPSLMJEBzhmO0Enci9zKWJOwW6FSw+YW5TEAKmu3iZfXL78W99cItlTxlrl7z3BDQhXj+
        9g6f8nAsJt84Utg7P8SvXcf8mbNCBscZpwn13zdNnidpyt7A3IXPN0YTeAL0Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607463327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d8xXDa+xA2WqTiRtB82k0uurlIcN0PDOr9qLhVEuoGw=;
        b=Dex9IGeygV6lg/lbta/FER8hior4rpg2LfZvtCQMYCSjA8PuPhqou+b4niM2XtQ9b5IJsz
        sAJoIBR9pH1Sk3Ag==
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
In-Reply-To: <20201208181232.GB31442@fuller.cnet>
References: <20201203171118.372391-1-mlevitsk@redhat.com> <20201203171118.372391-2-mlevitsk@redhat.com> <20201207232920.GD27492@fuller.cnet> <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com> <87sg8g2sn4.fsf@nanos.tec.linutronix.de> <6f64558a029574444da417754786f711c2fec407.camel@redhat.com> <20201208181232.GB31442@fuller.cnet>
Date:   Tue, 08 Dec 2020 22:35:27 +0100
Message-ID: <87360g2d7k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 08 2020 at 15:12, Marcelo Tosatti wrote:
> On Tue, Dec 08, 2020 at 06:25:13PM +0200, Maxim Levitsky wrote:
>> On Tue, 2020-12-08 at 17:02 +0100, Thomas Gleixner wrote:
>> The "bug" is that if VMM moves a hardware time counter (tsc or anything else) 
>> forward by large enough value in one go, 
>> then the guest kernel will supposingly have an overflow in the time code.
>> I don't consider this to be a buggy VMM behavior, but rather a kernel
>> bug that should be fixed (if this bug actually exists)
>
> It exists.

In the VMM. 

>> We are talking about the fact that TSC can jump forward by arbitrary large
>> value if the migration took arbitrary amount of time, which 
>> (assuming that the bug is real) can crash the guest kernel.
>
> QE reproduced it.

Sure, that's what QE is about. Just your conclusion is wrong.

Thanks,

        tglx
