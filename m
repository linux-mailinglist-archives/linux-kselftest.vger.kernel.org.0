Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5F76794D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 11:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjAXKKG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 05:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjAXKKE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 05:10:04 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDE73F2A0;
        Tue, 24 Jan 2023 02:09:57 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id EAAB681F43;
        Tue, 24 Jan 2023 10:09:50 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674554997;
        bh=Wtv+AsktmrHEJu4sqZpZQqKp3hbHJtzo/pQLwrCbSiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BcxNpSrRTw0Cd842CIrFaRmNT73gQKqkY4nmh2hnPSc+eRPb2mgjRA0CiZAuUkOmJ
         4s+cO3JqHoQWu/izjcJ+Sk9mboN+wwtqkEHCrXwdSaYPGMlBtJXSPeJsFjSsd537By
         Qly7emodmr8zBk3fUrY0QVX5NEA892TbUzY34fEMETD49WtgvW8nlYP2VkxI1Lcyof
         u52uliLRWW7Fm2BBrC54rr13Pnh8lw8aBtXi2r2VnZr0qyH1GmgspV6vRk2y2GatrQ
         wrTBx8HA/yoZcTyB0JGLIVhaUQBuXeyRc//zW/h56qRVhEvZRhs0uOrucEOnT28Ii2
         jSCg1/X45RUfA==
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
Subject: [RFC PATCH v3 2/2] selftests/x86: sysret_rip: Add more syscall tests with respect to `%rcx` and `%r11`
Date:   Tue, 24 Jan 2023 17:09:25 +0700
Message-Id: <20230124100926.637335-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124100926.637335-1-ammarfaizi2@gnuweeb.org>
References: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com> <25b96960-a07e-a952-5c23-786b55054126@zytor.com> <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org> <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com> <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com> <20230124022729.596997-1-ammarfaizi2@gnuweeb.org> <20230124022729.596997-3-ammarfaizi2@gnuweeb.org> <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com> <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org> <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com> <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230124100926.637335-1-ammarfaizi2@gnuweeb.org>
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

Test that:

 - "syscall" in a FRED system doesn't clobber %rcx and %r11.
 - "syscall" in a non-FRED system sets %rcx=%rip and %r11=%rflags.

Test them out with a trivial system call like __NR_getppid and friends
which are extremely likely to return with SYSRET on an IDT system.

Link: https://lore.kernel.org/lkml/25b96960-a07e-a952-5c23-786b55054126@zytor.com
Co-developed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/testing/selftests/x86/sysret_rip.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index b0d271c19ddd7834..bf90fac95a264e2d 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -267,8 +267,17 @@ static void test_syscall_fallthrough_to(unsigned long ip)
 	printf("[OK]\tWe survived\n");
 }
 
+static void test_syscall_rcx_r11(void)
+{
+	do_syscall(__NR_getpid, 0, 0, 0, 0, 0, 0);
+	do_syscall(__NR_gettid, 0, 0, 0, 0, 0, 0);
+	do_syscall(__NR_getppid, 0, 0, 0, 0, 0, 0);
+}
+
 int main()
 {
+	test_syscall_rcx_r11();
+
 	/*
 	 * When the kernel returns from a slow-path syscall, it will
 	 * detect whether SYSRET is appropriate.  If it incorrectly
-- 
Ammar Faizi

