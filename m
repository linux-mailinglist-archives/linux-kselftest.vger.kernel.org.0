Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADFF67A926
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 04:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjAYDXY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 22:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAYDXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 22:23:23 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B765521FA;
        Tue, 24 Jan 2023 19:23:21 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id EAD1A82EFE;
        Wed, 25 Jan 2023 03:23:14 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674617000;
        bh=rGbWyt6oBdryMhDnVY96kKf9w96vMwTYuR17PdQO6Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkYxAs7XUy7oPnGIJLW0W4Ky3y2dqJmJ/igMBvznp2TL3cZpDsnq3Yz/pIPkHYPra
         +MT/3cex/IRLjOQh6HnxLpJ/xNLGQo6+0Aw5JFSNJKxVUV6wGtQmlRIUKVfgVUBuWS
         HBO1Rvhj/8PiDbqnCQIodg0C1yn7NGR2MAfp7LdTlEGwoWc8yKFasrbr73I1oFcf2O
         4iRhUc3JmUyOuKYPMG+ejtRb2hf5Pu1kXyWFkYhSUagUgNmZ5MthWt9LC/62ddfJ//
         vL96B0hPIIaTVihBa4fyQX1VnXbfTbITZtfBw1laNEtZIrskfkJMLVpoyFyW6IxTLM
         Y1X2NTOsLR8Bg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
Subject: [RFC PATCH v4 0/2] sysret_rip update for the Intel FRED architecture
Date:   Wed, 25 Jan 2023 10:22:38 +0700
Message-Id: <20230125032240.728463-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
References: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com> <25b96960-a07e-a952-5c23-786b55054126@zytor.com> <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org> <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com> <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com> <20230124022729.596997-1-ammarfaizi2@gnuweeb.org> <20230124022729.596997-3-ammarfaizi2@gnuweeb.org> <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com> <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org> <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com> <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
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

This is an RFC patchset v4. There are two patches in this series.

Xin Li reported that the sysret_rip test fails at:

        assert(ctx->uc_mcontext.gregs[REG_EFL] ==
               ctx->uc_mcontext.gregs[REG_R11]);

on the Intel FRED architecture. Let's handle the FRED system scenario
too. The 'syscall' instruction in a FRED system doesn't set %rcx=%rip
and %r11=%rflags.

Syscall and sysenter in a FRED system are treated equivalently to
software interrupts, e.g. INT 0x80. They do not modify any registers.

Link: https://lore.kernel.org/lkml/5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com

#### Changelog v4:

   - Fix the assertion condition inside the SIGUSR1 handler (Xin Li).

   - Explain the purpose of patch #2 in the commit message (HPA).

   - Update commit message (Ammar).

   - Repeat test_syscall_rcx_r11_consistent() 32 times to be more sure
     that the result is really consistent (Ammar).

#### Changelog v3:

   - Test that we don't get a mix of REGS_SAVED and REGS_SYSRET,
     which is a major part of the point (HPA).

#### Changelog v2:

   - Use "+r"(rsp) as the right way to avoid redzone problems
     per Andrew's comment (HPA).


Co-developed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Ammar Faizi (2):
  selftests/x86: sysret_rip: Handle syscall in a FRED system
  selftests/x86: sysret_rip: Add more syscall tests with respect to `%rcx` and `%r11`

 tools/testing/selftests/x86/sysret_rip.c | 147 +++++++++++++++++++++--
 1 file changed, 138 insertions(+), 9 deletions(-)


base-commit: e12ad468c22065a2826b2fc4c11d2113a7975301
-- 
Ammar Faizi

