Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B160678CD0
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 01:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjAXA07 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 19:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjAXA06 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 19:26:58 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462C939B89;
        Mon, 23 Jan 2023 16:26:52 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id D2214824E0;
        Tue, 24 Jan 2023 00:26:45 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674520012;
        bh=SXQXpbuiBQdiwXpH2+78kfJuScDGyhqpyjZmkT1By0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZ4AUcVqaCg4Eqketr209fH1DlzQ7tYfr4oo/RJDieFUYL3SPhUeuiFadn9JS9c/u
         cT9mBLn3vi89aAsRL6rZ7aL9Yw1Xq27Gwc32zhDxTo+IeJRgy6a8B2aEjH2rNL+z9a
         uvgGnK5S+WAwfJjetSfovuygOacgRjMorVPIfejVRtmKBUoRxDvVGeg5e/U5wt+GNr
         XsBNLifoZj/ZZJSwNqzDWWe7UXrLyuoefZlHDp7brkzMeIdM5581OlwRSIKB5BE+g+
         9Y2OUde4q6XdCj+rNvyX0Y19rF+C/nf+8/EZXoth5qbswSFnJnn2UfT+64VgJFCms8
         dyZebDu32OVmA==
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
Subject: [RFC PATCH v1 2/2] selftests/x86: sysret_rip: Add more syscall tests with respect to `%rcx` and `%r11`
Date:   Tue, 24 Jan 2023 07:26:25 +0700
Message-Id: <20230124002625.581323-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124002625.581323-1-ammarfaizi2@gnuweeb.org>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com> <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com> <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com> <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com> <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com> <25b96960-a07e-a952-5c23-786b55054126@zytor.com> <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org> <F554C5FE-5074-410A-B0B5-EFE983D57946@zytor.com> <Y88bhrDoPw5tOyKu@biznet-home.integral.gnuweeb.org> <509443c8-e0fd-935f-63d8-7264f5dd3c05@zytor.com>
 <20230124002625.581323-1-ammarfaizi2@gnuweeb.org>
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
which are extremely likely to return with SYSRET on an IDT system; check
that it returns a nonnegative value and then save the result.

Link: https://lore.kernel.org/lkml/25b96960-a07e-a952-5c23-786b55054126@zytor.com
Co-developed-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Missing a Signed-off-by tag from HPA. 

@hpa send your sign off if you like this patch.

 tools/testing/selftests/x86/sysret_rip.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index 9056f2e2674d2bc5..c55f6d04f0ae1f2d 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -252,8 +252,17 @@ static void test_syscall_fallthrough_to(unsigned long ip)
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

