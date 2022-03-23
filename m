Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F3C4E56B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 17:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbiCWQqf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 12:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbiCWQqe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 12:46:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897EDBE24;
        Wed, 23 Mar 2022 09:45:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648053900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uzs116Cx6QxGxyZNdiwD2DBJ6Q8TGefySKft58qWAhs=;
        b=kVYxzKLpUcw5AUj5B+Vw3cSVjmJZpcw+yHJSUsPRKCm47g+TPuEL8G/EZIOwPTANE0G9ib
        OyhKi9RLBwtVC8o0t5ajpQrwOreRXxW91XxDD9+XJWEA7mmrja7CUW+9BvTeNwjC7LoWQB
        OQssfrBE7ifOnnfribdpGVOPjJLa94sbEyMFqc919rL6biHJBAOysNSomGMDvz5lS1y3yf
        j8yRqnvDAekAXovKPSKV5RCDzavsaI/k3NaiL4DZH5CXYCppGcgr7VQMKaw7HfAyVI+uwS
        cwlSKHmWSuBJA9XhB6r8tKPZdLXfOuc0aEBroAlekR8k/OYSN8KqJ2avuytKpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648053900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uzs116Cx6QxGxyZNdiwD2DBJ6Q8TGefySKft58qWAhs=;
        b=R18Y3GePYLi/wsvpnPDTj4OKCit9PT5A1YX0qDjoA8M0XzIwBfglJtuTGYfePxa8o5xuSj
        xS2wZx01rMfDyxDw==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com
Cc:     yang.zhong@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 2/2] selftests/x86/amx: Update the
 ARCH_REQ_XCOMP_PERM test
In-Reply-To: <20220129173647.27981-3-chang.seok.bae@intel.com>
References: <20220129173647.27981-1-chang.seok.bae@intel.com>
 <20220129173647.27981-3-chang.seok.bae@intel.com>
Date:   Wed, 23 Mar 2022 17:44:59 +0100
Message-ID: <8735j8aa9g.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 29 2022 at 09:36, Chang S. Bae wrote:
> Update the arch_prctl test to check the permission bitmap whether the
> requested feature is added as expected or not.
>
> Every non-dynamic feature that is enabled is permitted already for use.
> TILECFG is not dynamic feature. Ensure the bit is always on from
> ARCH_GET_XCOMP_PERM.

Running it on a machine which does not have AMX results in:

 amx_64: [FAIL]	xstate cpuid: invalid tile data size/offset: 0/0: Success

It's not a failure, really. Selftests are supposed to run on all
machines and the proper thing to do if a hardware feature is not
available is to SKIP the test and return 0.

Thanks,

        tglx
