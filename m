Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D344586168
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Jul 2022 22:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbiGaUoB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 31 Jul 2022 16:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbiGaUn7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 31 Jul 2022 16:43:59 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C047A120BB;
        Sun, 31 Jul 2022 13:43:57 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oIFn1-009cJ1-31; Sun, 31 Jul 2022 22:43:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID;
        bh=t0w6nMaTSVyF4dUCeXcgyGmDl4SAZy5rqFNmmcR5GoA=; b=tHju2JCWbsWi+DGafRcMBCqJw/
        B6dNTQ5Hd9DDYonWsSGijbekQQ4vIvyZtIctKGurtfcEBqjinijP4NIJOgsVRFbnGOOlaAPkS75fR
        X6w/c7WpdSHnnBRbTahgea7CMQlud76lZtG4vMBuRNe4a6+c1d7s5L8yaGnP9WRkynm0uGvUyq3k6
        aiW3Cbpo8UdbRTshJC0zl3x85Qc3pQdaf3bkRvfR6S73exI6R5DlVqtPuOSuiIPsYKwEzzLbZtMy5
        xYnUlL8VQA61CZgHAl5Re79UEU4UDxu9T6uDIpRuZ5gdiN/2PHovK/ljLGKNT9dxaDwRhPNt0JbgV
        xjpHJ7DQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oIFn0-0004yV-MT; Sun, 31 Jul 2022 22:43:54 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oIFmm-0002hM-FX; Sun, 31 Jul 2022 22:43:40 +0200
Message-ID: <3c4817e2-0e3e-2178-f7cb-0ea0b68de14e@rbox.co>
Date:   Sun, 31 Jul 2022 22:43:39 +0200
MIME-Version: 1.0
User-Agent: Thunderbird
Subject: Re: [PATCH 2/2] KVM: selftests: x86: Test illegal LEA handling
Content-Language: pl-PL
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pbonzini@redhat.com, shuah@kernel.org
References: <20220729134801.1120-1-mhal@rbox.co>
 <20220729134801.1120-2-mhal@rbox.co> <YuQQiv862oWDpgt5@google.com>
From:   Michal Luczaj <mhal@rbox.co>
In-Reply-To: <YuQQiv862oWDpgt5@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/29/22 18:53, Sean Christopherson wrote:
> On Fri, Jul 29, 2022, Michal Luczaj wrote:
>> + * To trigger the emulator and feed it with LEA, we VM-exit on IO (with a
>> + * single OUTS), then race decoder's instruction fetch - hoping to replace the
>> + * initial IO op with an illegal LEA.
> 
> Rather than play games with memory, can't we just require and use force_emulation_prefix
> to force KVM to emulate a bogus LEA encoding?  emulator.c in KVM-unit-tests already has
> most of what you need, e.g. I believe it's just a matter of implementing
> test_illegal_lea().  That test already has test_smsw_reg(), which is darn near the
> same thing, it just expects a different result (success instead of #UD).
> 
> diff --git a/x86/emulator.c b/x86/emulator.c
> index cd78e3cb..dd50578d 100644
> --- a/x86/emulator.c
> +++ b/x86/emulator.c
> @@ -1193,6 +1193,7 @@ int main(void)
>                 test_smsw_reg(mem);
>                 test_nop(mem);
>                 test_mov_dr(mem);
> +               test_illegal_lea();
>         } else {
>                 report_skip("skipping register-only tests, "
>                             "use kvm.force_emulation_prefix=1 to enable");
> 

Ahh, right. Using force_emulation_prefix seems way better. Thanks!

I'll add "kvm-unit-tests" in the subject and send as v2 PATCH.

Michal
