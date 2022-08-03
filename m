Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7655589130
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 19:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbiHCRWV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 13:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbiHCRWU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 13:22:20 -0400
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD8F51421
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Aug 2022 10:22:19 -0700 (PDT)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oJI4S-00HA0e-LC; Wed, 03 Aug 2022 19:22:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
        Cc:To:Subject:From:MIME-Version:Date:Message-ID;
        bh=kaAha2c4p+r3FL8cBFLLi+djePJ3e1jCPMpzllScAso=; b=TCtJKOEJ737Le18OvuzKJgkn1Q
        OxVwOb6t2y4nHI4J8HNnkiN/jvXq0xmUbl05y6zvXGhT3t8NHGPNizVvXJ4748Oze5s2J/ignR1qu
        MAL3GXs++NKLubsKAPVlrSWiOq+E90XE+qyRw25J8Dh42YrYSIGcot38nGQN/Kfr2Z2J+VwTqjSEI
        vKJ8JPrMxSLLy+ouISvsLacNqA5a2JWhwbnq9v/re1mQa+2ZdU1sGOOM9oen0+TBLOpzHem1blJsU
        L+lYNOmNftueomnq9m6nL6QylurmJpvq13gv3UayI6cp4EEnjFUZVoRT5ilL/10WwMxXEZXHdm9L7
        hmqOu15g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oJI4R-0004Nq-Qf; Wed, 03 Aug 2022 19:22:12 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oJI49-0001js-TK; Wed, 03 Aug 2022 19:21:53 +0200
Message-ID: <d40df30f-0c33-b7dd-1fc5-a57b29386a98@rbox.co>
Date:   Wed, 3 Aug 2022 19:21:52 +0200
MIME-Version: 1.0
User-Agent: Thunderbird
From:   Michal Luczaj <mhal@rbox.co>
Subject: Re: [kvm-unit-tests PATCH v2] x86: Test illegal LEA handling
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
References: <YuQQiv862oWDpgt5@google.com> <20220731204653.2516-1-mhal@rbox.co>
 <YugC4rUvdbroNk3M@google.com> <c2001bfa-7602-e99a-dc41-1d9d993581ac@rbox.co>
 <Yum2LpZS9vtCaCBm@google.com>
Content-Language: pl-PL
In-Reply-To: <Yum2LpZS9vtCaCBm@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/3/22 01:41, Sean Christopherson wrote:
> On Wed, Aug 03, 2022, Michal Luczaj wrote:
>> If so, am I supposed to restore the `check_exception_table()` handler? Or
>> maybe using `test_for_exception()` would be more elegant:
> 
> Hmm, I prefer ASM_TRY() over test_for_exception(), having to define a function
> just to emit a single instruction is silly.  What I'd really prefer is that we
> wouldn't have so many ways for doing the same basic thing (obviously not your
> fault, just ranting/whining).

All right, ASM_TRY() then.

But it does seem to have a problem with #UD thrown by the FEP-triggered
emulator. Anyway, I've cobbled together a TRY_ASM_PREFIXED variant, but I'm
not sure if that's what you want.

> If you have bandwidth, can you create a small series to clean up emulator.c to at
> least take a step in the right direction?
> 
>   1. Save/restore the handlers.
>   2. Use ASM_TRY for the UD_VECTOR cases (KVM_FEP probing and illegal MOVBE)
>   3. Add this testcase as described above.

Yeah, no problem.

Thanks,
Michal
