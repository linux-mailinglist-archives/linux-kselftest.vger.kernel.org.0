Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0063679129
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 07:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjAXGlc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 01:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjAXGlb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 01:41:31 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F1416ADA;
        Mon, 23 Jan 2023 22:41:30 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 4EDF082EF1;
        Tue, 24 Jan 2023 06:41:24 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674542490;
        bh=FQnxWh95uCNGyT0gTIyVUSAFILOzF/Wnxr5sBHSX71E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gnB2UTWr1Qlq6HPz7vX6i0ynWcgIAr0LoxBViAnZhAzqWDPlLgaybkPzl64GDr5E7
         QqGj37b6c9ffXumlYMjMGxgxk1U5Q9LBfmWd6Z7izSrCf3vw4RVRoTQFSys1kJzKT0
         0HpRFsrQb/jVQ5qRrrfCCzQPG3aAqln0TJKspK11Y/aKlYMfMtt6t7vgDzuLU1AztF
         ihMZRCy9mz9JLG1prV2QWAGtvlj5KSRsQqWdguz72ZhuukuyKq552qowfY9n9wk1LN
         x3Mkheq7AT4Ye3UwIpU8nkCSRB6p+KN9vuVQTI6BqehrTNGaDP73j4wRaS4uxqcVw2
         9t+k7F0TmH4Eg==
Date:   Tue, 24 Jan 2023 13:41:20 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86 Mailing List <x86@kernel.org>,
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
Subject: Re: [RFC PATCH v2 2/2] selftests/x86: sysret_rip: Add more syscall
 tests with respect to `%rcx` and `%r11`
Message-ID: <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
References: <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
 <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
 <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 23, 2023 at 10:16:01PM -0800, H. Peter Anvin wrote:
> On 1/23/23 18:27, Ammar Faizi wrote:
> > Test that:
> > 
> >   - "syscall" in a FRED system doesn't clobber %rcx and %r11.
> >   - "syscall" in a non-FRED system sets %rcx=%rip and %r11=%rflags.
> > 
> > Test them out with a trivial system call like __NR_getppid and friends
> > which are extremely likely to return with SYSRET on an IDT system; check
> > that it returns a nonnegative value and then save the result.
> > 
> 
> "Nonnegative" here should be "valid"; it is an implementation detail that
> the error value is -1.

Copy-paste error, will fix that!

> However, you are not checking that you don't get a mix of REGS_SAVED and
> REGS_SYSRET, which is a major part of the point.

Good point!

What do you think of adding this on top of patch #1?

diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index 75c72d34dbc5840c..3da827713831acbc 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -47,11 +47,14 @@ static const unsigned long rcx_sentinel = 0x5ca1ab1e0b57ac1e;
 static const unsigned long rflags_sentinel = 0x200a93;
 
 enum regs_ok {
-	REGS_ERROR  = -1,	/* Invalid register contents */
-	REGS_SAVED  =  0,	/* Registers properly preserved */
-	REGS_SYSRET =  1	/* Registers match syscall/sysret */
+	REGS_INIT_VAL	= -2,	/* For init value checker, never returned */
+	REGS_ERROR 	= -1,	/* Invalid register contents */
+	REGS_SAVED 	=  0,	/* Registers properly preserved */
+	REGS_SYSRET	=  1	/* Registers match syscall/sysret */
 };
 
+static enum regs_ok regs_ok_state = REGS_INIT_VAL;
+
 /*
  * Returns:
  *  0 = %rcx and %r11 preserved.
@@ -86,6 +89,7 @@ static long do_syscall(long nr_syscall, unsigned long arg1, unsigned long arg2,
 	register unsigned long r9 asm("%r9");
 	register void *rsp asm("%rsp");
 	unsigned long rcx, rbx;
+	enum regs_ok ret;
 
 	r11 = r11_sentinel;
 	rcx = rcx_sentinel;
@@ -124,7 +128,14 @@ static long do_syscall(long nr_syscall, unsigned long arg1, unsigned long arg2,
 	 * - "syscall" in a non-FRED system sets %rcx=%rip and %r11=%rflags.
 	 *
 	 */
-	assert(check_regs_result(r11, rcx, rbx) != REGS_ERROR);
+	ret = check_regs_result(r11, rcx, rbx);
+	assert(ret != REGS_ERROR);
+
+	if (regs_ok_state == REGS_INIT_VAL)
+		regs_ok_state = ret;
+	else
+		assert(ret == regs_ok_state);
+
 	return nr_syscall;
 }
 
-- 
Ammar Faizi

