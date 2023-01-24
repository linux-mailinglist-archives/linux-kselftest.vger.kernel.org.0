Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A5F678E35
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 03:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjAXC1v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 21:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAXC1u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 21:27:50 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A72A7298;
        Mon, 23 Jan 2023 18:27:49 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 7E07682EF0;
        Tue, 24 Jan 2023 02:27:42 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674527268;
        bh=lfJPIxz6SznwA800g3Y9BeouGUR6bkc7dvZhqtUjmII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EAnyk8BQaiFAL/LUCIygK5N/vVI+cKscritKaCGXcIYPcl3l+ykpJeILaANYlIfQp
         W+2avU1oitGYw37+2u13JOuxFF4i4yKZqg55p8Pc91Po1cjCgRbpYb6VRBIjh3fV7g
         evNAijLWDotdDU96WF58MH/Y82WQmHRKs/jL6pqR95ET/qyE5vp0i0goGOZzXYlVyU
         FTN54xIEIEbxYeyPsQTJETG7kOcAt1X58ymgPXwFj6PhTmhsleg96kxB67oazhezPL
         EqpY9QExvPhMiEGCN9gr2NI60Mvwp5MuUg9j+kwGh4s01VtHxvauC/XMhUexqkESCF
         FGdVrdC/qliUA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>, x86 Mailing List <x86@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
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
Subject: [RFC PATCH v2 0/2] selftests/x86: sysret_rip update for FRED system
Date:   Tue, 24 Jan 2023 09:27:27 +0700
Message-Id: <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com> <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com> <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com> <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com> <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com> <25b96960-a07e-a952-5c23-786b55054126@zytor.com> <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org> <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com> <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
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

This is an RFC patchset v2.

Xin Li reported sysret_rip test fails at:

        assert(ctx->uc_mcontext.gregs[REG_EFL] ==
               ctx->uc_mcontext.gregs[REG_R11]);

in a FRED system. Handle the FRED system scenario too. There are two
patches in this series. Comments welcome...

Note: This patchset is only tested for 'syscall' sets %rcx=%rip and
%r11=%rflags case. I don't have a FRED system to test it.

How to test this:

  $ make -C tools/testing/selftests/x86
  $ tools/testing/selftests/x86/sysret_rip_64

Link: https://lore.kernel.org/lkml/5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

## Changelog v2:

   - Use "+r"(rsp) as the right way to avoid redzone problems
     per Andrew's comment (hpa).
     (Ref: https://lore.kernel.org/lkml/8f5c24df-514d-5d89-f58f-ec8c3eb1e049@zytor.com )

---

Ammar Faizi (2):
  selftests/x86: sysret_rip: Handle syscall in a FRED system
  selftests/x86: sysret_rip: Add more syscall tests with respect to `%rcx` and `%r11`

 tools/testing/selftests/x86/sysret_rip.c | 105 ++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)


base-commit: e12ad468c22065a2826b2fc4c11d2113a7975301
-- 
Ammar Faizi

