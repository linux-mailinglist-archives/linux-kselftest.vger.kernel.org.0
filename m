Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2851678CCA
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 01:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjAXA0k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 19:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjAXA0j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 19:26:39 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A779217173;
        Mon, 23 Jan 2023 16:26:38 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 294AD824E0;
        Tue, 24 Jan 2023 00:26:31 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674519998;
        bh=Rm91CZ7I/MJC6OiVuT0l3UbvtdpMXxbIrv7tQGRv8Uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zx2jdgGWhRdcd9E3uozALYXl5fyP7p2/C3Wr4os4Fby9zXCH/xihfP2eUUkzFM+s/
         CI/UkIH4pMHrCIdokYu/2/HHoYCYAdRhzL7MnnB2RiKr/XsCvDtkhLLxkzf6nXof/x
         iEvY6Rjm93sw5UFDv4GY8lY8DZz/A+d5xle7t1rq4flobpKLjInO+1zQ5VVsx0x2ua
         Mdnf36OQs+PxRiTAuUCrwzc5gx9l9OGY2gaPAPARvZc908oUIqOt+sVZKDT63gMgME
         tqZwWesDvfKqphg9wovl/It3RX0Ivw/B/U2H6qiUVNRZiTxXvuFF3LcZamTDyTjITR
         D09dyd8f/qPwA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     x86 Mailing List <x86@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xin Li <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 0/2] selftests/x86: sysret_rip update for FRED system
Date:   Tue, 24 Jan 2023 07:26:23 +0700
Message-Id: <20230124002625.581323-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <509443c8-e0fd-935f-63d8-7264f5dd3c05@zytor.com>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com> <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com> <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com> <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com> <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com> <25b96960-a07e-a952-5c23-786b55054126@zytor.com> <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org> <F554C5FE-5074-410A-B0B5-EFE983D57946@zytor.com> <Y88bhrDoPw5tOyKu@biznet-home.integral.gnuweeb.org> <509443c8-e0fd-935f-63d8-7264f5dd3c05@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

On Mon, 23 Jan 2023 15:58:12 -0800, "H. Peter Anvin" wrote:
> On 1/23/23 15:43, Ammar Faizi wrote:
> > 
> > Align them to spot differences:
> > 
> >      0x200893 = 0b1000000000100010010011
> >      0x200a93 = 0b1000000000101010010011
> >                               ^
> > 
> > Or just xor them to find the differences:
> > 
> >      (gdb) p/x 0x200893 ^ 0x200a93
> >      $3 = 0x200
> > 
> > ** Checks my Intel SDM cheat sheets. **
> > 
> > Then, I was like "Oh, that's (1 << 9) a.k.a. IF. Of course we can't
> > change rflags[IF] from userspace!!!".
> > 
> > In short, we can't use 0x200893 as the rflags_sentinel value because it
> > clears the interrupt flag.
> > 
> 
> Right, my mistake.

I changed it to 0x200a93. The test passed on my machine. But I don't
have a FRED system to test the special case.

Didn't manage to apply the feedback from Andrew about the way to handle
redzone properly, though.

Something like this...

----------

This is just an RFC patchset.

Xin Li reported sysret_rip test fails at:

        assert(ctx->uc_mcontext.gregs[REG_EFL] ==
               ctx->uc_mcontext.gregs[REG_R11]);

in a FRED system. Handle the FRED system scenario too. There are two
patches in this series. Comments welcome...

Note: Only tested for 'syscall' sets %rcx=%rip and %r11=%rflags case.
I don't have a FRED system to test it.

How to test this:

  $ make -C tools/testing/selftests/x86
  $ tools/testing/selftests/x86/sysret_rip_64

Link: https://lore.kernel.org/lkml/5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Ammar Faizi (2):
  selftests/x86: sysret_rip: Handle syscall in a FRED system
  selftests/x86: sysret_rip: Add more syscall tests with respect to `%rcx` and `%r11`

 tools/testing/selftests/x86/sysret_rip.c | 105 ++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)


base-commit: e12ad468c22065a2826b2fc4c11d2113a7975301
-- 
Ammar Faizi

