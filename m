Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6EE67AF04
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 10:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjAYJ5b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 04:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjAYJ5a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 04:57:30 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E875BE390;
        Wed, 25 Jan 2023 01:57:25 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 5E4D981845;
        Wed, 25 Jan 2023 09:57:19 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674640645;
        bh=hHJo1f1VdgMLHi128ynBoLkRu88SC927lUpBq5ebd+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pUW5s03UMlOmjwyGkBh1mFR5gYzOpvBE3niZybqi+0gFLgwWiuTDPimq71RIEYzO5
         UVtj7iewz30KNCPD9UQGf04TB/XsaOaKy6DjFMqfqX4N+zAHzBDzDXv4DDddP4AsPM
         PT7ToJIdeQPe/TQUWBa6DZLNrG+JnbqeAdutMds72zVCmyncIfBDKQjt6LDKNni8eA
         dQeZ50ARWyjs1YbhxrUNZevKduwL9g27rXA6TsbfX3WLSATce5msjUdvkqjAn2uHq8
         VFOJK/pwVnz1PlHTldjGq13g3pFh8D44PBd9qFVaGlKpmVZH5p+QFburaHP5WbJWXD
         mtFSyDCDJ1MAw==
Date:   Wed, 25 Jan 2023 16:57:15 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Xin Li <xin3.li@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 1/2] selftests/x86: sysret_rip: Handle syscall in
 a FRED system
Message-ID: <Y9D8++DxphJS1oc4@biznet-home.integral.gnuweeb.org>
References: <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125034958.734527-1-ammarfaizi2@gnuweeb.org>
 <20230125034958.734527-2-ammarfaizi2@gnuweeb.org>
 <8770815f-0f23-d0c5-e56a-d401827842c9@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8770815f-0f23-d0c5-e56a-d401827842c9@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 25, 2023 at 12:39:26AM -0800, H. Peter Anvin wrote:
> >   	/* Set IP and CX to match so that SYSRET can happen. */
> >   	ctx->uc_mcontext.gregs[REG_RIP] = rip;
> >   	ctx->uc_mcontext.gregs[REG_RCX] = rip;
> 
> It would be interesting to have the syscall handler try both with and
> without this (so it would end up doing both IRET and SYSCALL on legacy.)
> Perhaps SIGUSR1 versus SIGUSR2...

Just to clarify this more so I am sure I understand it correctly.

Did you mean to have the same signal handler without modifiying
'REG_RCX' but still change 'REG_RIP'?

IOW, we want to only *remove*:

   ctx->uc_mcontext.gregs[REG_RCX] = rip;

and *keep*:

   ctx->uc_mcontext.gregs[REG_RIP] = rip;

for the SIGUSR2 handler. Thus, inside the entry64 we will jump to the
iret path because %rcx != %r11 upon rt_sigreturn()?

-- 
Ammar Faizi

