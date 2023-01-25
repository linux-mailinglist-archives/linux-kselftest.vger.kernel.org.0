Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41567C0C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 00:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjAYXY2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 18:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjAYXY1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 18:24:27 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E04EB43;
        Wed, 25 Jan 2023 15:24:26 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 68211824E0;
        Wed, 25 Jan 2023 23:24:19 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674689065;
        bh=zhEhASVFM/Au5cThaAVr8lOzqAVrP1V8SBnPOSUlAds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfnpgP1gwAvctQdGaPovsk+HWtJf1Bg3IRFpUq0p8YF87IASfmnBs8XkcF/9qTFIi
         utlFTPX6kEKPmFEDxRgamtXR5Dw+K44F+QZlLQJwe/2puvmqegrVzczv2F6hnHESgt
         jyxi9TPWCUJ1rxuIOUtyNozmbZhI6C+mhc/tqKAbD/9BpyjDZ9I7ImpcGjdUJd5r8g
         TLIGvS6vHzadmyN3boa2PftPeVf6RQrOrKY3lCMSiN+l/wp1S/VSQUR8NkI7S4VilK
         IcvTttCV1W5BrIBk9WAmjY00cnj9nNw9GQwPekIbZ5y8tu4wq/PWpGfAhR65XzXBI6
         B4r16r+bbuE+A==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Shuah Khan <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v7 0/3] sysret_rip update for the Intel FRED architecture
Date:   Thu, 26 Jan 2023 06:24:12 +0700
Message-Id: <20230125232415.860397-1-ammarfaizi2@gnuweeb.org>
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

Hi,

This is an RFC patchset v7. There are three patches in this series.

Xin Li reported that the sysret_rip test fails at:

        assert(ctx->uc_mcontext.gregs[REG_EFL] ==
               ctx->uc_mcontext.gregs[REG_R11]);

on the Intel FRED architecture. Let's handle the FRED system scenario
too. The 'syscall' instruction in a FRED system doesn't set %rcx=%rip
and %r11=%rflags.

Syscall and sysenter in a FRED system are treated equivalently to
software interrupts, e.g. INT 0x80. They do not modify any registers.

Link: https://lore.kernel.org/lkml/5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com

## Changelog v7:

   - Fix comment, REGS_ERROR no longer exists in the enum (Ammar).

   - Update commit message (Ammar).

## Changelog v6:

   - Move the check-regs assertion in sigusr1() to check_regs_result()
     (HPA).

   - Add a new test just like sigusr1(), but don't modify REG_RCX and
     REG_R11. This is used to test SYSRET behavior consistency (HPA).

## Changelog v5:

   - Fix do_syscall() return value (Ammar).

## Changelog v4:

   - Fix the assertion condition inside the SIGUSR1 handler (Xin Li).

   - Explain the purpose of patch #2 in the commit message (HPA).

   - Update commit message (Ammar).

   - Repeat test_syscall_rcx_r11_consistent() 32 times to be more sure
     that the result is really consistent (Ammar).

## Changelog v3:

   - Test that we don't get a mix of REGS_SAVED and REGS_SYSRET,
     which is a major part of the point (HPA).

## Changelog v2:

   - Use "+r"(rsp) as the right way to avoid redzone problems
     per Andrew's comment (HPA).


Co-developed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Ammar Faizi (3):
  selftests/x86: sysret_rip: Handle syscall in a FRED system
  selftests/x86: sysret_rip: Add more syscall tests with respect to `%rcx` and `%r11`
  selftests/x86: sysret_rip: Test SYSRET with a signal handler

 tools/testing/selftests/x86/sysret_rip.c | 171 +++++++++++++++++++++--
 1 file changed, 162 insertions(+), 9 deletions(-)


base-commit: e12ad468c22065a2826b2fc4c11d2113a7975301
-- 
Ammar Faizi

