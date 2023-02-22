Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC6869F06F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 09:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjBVIiG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 03:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjBVIiF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 03:38:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D6CF769;
        Wed, 22 Feb 2023 00:38:04 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677055083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RKaCpls8Odbi3oV698IL/0TrdRJgRn7YhMcmkSP5B0=;
        b=Re7dkeVVUAQRrQts01fCXShDHCTHFiMvZajuuy4bqUEuKtDjvOWYN7fL9kR+ZVNigBc8wY
        L/BvO5qcsi7mewALM7sED/xAx3xfLDQswZT084iWp9t+LJaxfJrMVXG+j92UU6EIxKFGJJ
        TfezCfTLDYaUCUWaL5a7JRzLsSYZfGIXklSfeos7qGmBXJuc4rr7+UWWF7jHH9B0ALAlvP
        m4wh6Ky0SZsUO6jj8ucUIXt/R9VoV53wyHNe63rQpczsFowy33tyBTX3fygzbNA7PuhqhI
        5QwYy192TilS9RBp1A1p1XjWmMf9GRtKD4rjR7eu2uPYSBWCVg5sb6q48c0QnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677055083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RKaCpls8Odbi3oV698IL/0TrdRJgRn7YhMcmkSP5B0=;
        b=j6kw18pML4ZOMKTYLW/Oxk5r7hIJPZ90KzUT/pyIAPxMWHCHVuGtSB+vZ83ysPfTlyUcHU
        mvf3qS1vYJnvuNBQ==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Chao Gao <chao.gao@intel.com>
Subject: Re: [PATCH v3 01/13] x86/fpu/xstate: Avoid getting xstate address
 of init_fpstate if fpstate contains the component
In-Reply-To: <e91b9172-8a2e-e299-a84f-1e9331c51cb7@intel.com>
References: <20230221163655.920289-1-mizhang@google.com>
 <20230221163655.920289-2-mizhang@google.com>
 <e91b9172-8a2e-e299-a84f-1e9331c51cb7@intel.com>
Date:   Wed, 22 Feb 2023 09:38:02 +0100
Message-ID: <87ilfum6xh.ffs@tglx>
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

On Tue, Feb 21 2023 at 19:05, Chang S. Bae wrote:
> On 2/21/2023 8:36 AM, Mingwei Zhang wrote:
>> @@ -1151,10 +1152,11 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
>>   			pkru.pkru = pkru_val;
>>   			membuf_write(&to, &pkru, sizeof(pkru));
>>   		} else {
>> -			copy_feature(header.xfeatures & BIT_ULL(i), &to,
>> -				     __raw_xsave_addr(xsave, i),
>> -				     __raw_xsave_addr(xinit, i),
>> -				     xstate_sizes[i]);
>> +			xsave_addr = (header.xfeatures & BIT_ULL(i)) ?
>> +				__raw_xsave_addr(xsave, i) :
>> +				__raw_xsave_addr(xinit, i);
>> +
>> +			membuf_write(&to, xsave_addr, xstate_sizes[i]);
>>   		}
>>   		/*
>>   		 * Keep track of the last copied state in the non-compacted
>
> So this hunk is under for_each_extended_xfeature(i, mask) -- it skips 
> the copy routine if mask[i] == 0; instead, it fills zeros.
>
> We have this [1]:
>
> 	if (fpu_state_size_dynamic())
> 		mask &= (header.xfeatures | xinit->header.xcomp_bv);
>
> If header.xfeatures[18] = 0 then mask[18] = 0 because 
> xinit->header.xcomp_bv[18] = 0. Then, it won't hit that code. So, I'm 
> confused about the problem that you described here.

Read the suggested changelog I wrote in my reply to Mingwei.

TLDR:

        xsave.header.xfeatures[18] = 1
        xinit.header.xfeatures[18] = 0
    ->  mask[18] = 1
    ->  __raw_xsave_addr(xsave, 18)     <- Success
    ->  __raw_xsave_addr(xinit, 18)     <- WARN

Thanks,

        tglx
