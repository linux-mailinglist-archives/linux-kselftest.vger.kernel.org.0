Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4496794CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 11:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjAXKJp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 05:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjAXKJp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 05:09:45 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D8E40C0;
        Tue, 24 Jan 2023 02:09:43 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 8A02481F43;
        Tue, 24 Jan 2023 10:09:37 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674554983;
        bh=Ka0PR+gOrMntYuWhm7gpYFrtchUUScBBj6G6iTCQ7H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EogxLyTeIRP8Bf3J9o6jl5n9XWNVtBCes21qAcxSEaM8Tyz4509KvB72aHFLdiIBb
         Q0iybni9K++MTznlFkyS1u8y8Y01qYp/YXYFdQCxpZqBeBj5eiU3TyLCa9TCMG5Qrh
         k1MdZ8dH+U1US2HllyuN2C+yiYIdEv47UKLzlRIxjd81DcBP14KgwUXUa+S6vPN/MX
         VG2KIxiyjwaIHgiko0f8SNnJ5Wk5TziXKnobE1Z1lQpHHGgvfsXvNd8tM6jJiL5g+g
         jnTR4dE3YRCPui6hrme2qOJhTjzk1NGEHhJQziL+bqWZ5qI7uzHfHnvix1TjdyJ8f3
         AKedwO+41FCGw==
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
Subject: [RFC PATCH v3 0/2] selftests/x86: sysret_rip update for FRED system
Date:   Tue, 24 Jan 2023 17:09:23 +0700
Message-Id: <20230124100926.637335-1-ammarfaizi2@gnuweeb.org>
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

This is an RFC patchset v3:
sysret_rip test update for Intel FRED architecture. 

Xin Li reported sysret_rip test fails at:

        assert(ctx->uc_mcontext.gregs[REG_EFL] ==
               ctx->uc_mcontext.gregs[REG_R11]);

in a FRED system. Let's handle the FRED system scenario too. The
'syscall' instruction in a FRED system doesn't set %r11=%rflags.

There are two patches in this series.

How to test this:

  $ make -C tools/testing/selftests/x86
  $ tools/testing/selftests/x86/sysret_rip_64

Link: https://lore.kernel.org/lkml/5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com
Fixes: 660602140103 ("selftests/x86: Add a selftest for SYSRET to noncanonical addresses")
Link: https://lore.kernel.org/lkml/25b96960-a07e-a952-5c23-786b55054126@zytor.com
Reported-by: Xin Li <xin3.li@intel.com>
Co-developed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

## Changelog v3:

   - Test that we don't get a mix of REGS_SAVED and REGS_SYSRET,
     which is a major part of the point (hpa).

## Changelog v2:

   - Use "+r"(rsp) as the right way to avoid redzone problems
     per Andrew's comment (hpa).
     (Ref: https://lore.kernel.org/lkml/8f5c24df-514d-5d89-f58f-ec8c3eb1e049@zytor.com )

---

Ammar Faizi (2):
  selftests/x86: sysret_rip: Handle syscall in a FRED system
  selftests/x86: sysret_rip: Add more syscall tests with respect to `%rcx` and `%r11`

 tools/testing/selftests/x86/sysret_rip.c | 120 ++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 1 deletion(-)


base-commit: e12ad468c22065a2826b2fc4c11d2113a7975301
-- 
Ammar Faizi

