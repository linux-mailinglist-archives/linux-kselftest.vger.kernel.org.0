Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54497D37F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 15:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjJWNZx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 09:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjJWNZS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 09:25:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5822723;
        Mon, 23 Oct 2023 06:23:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C2AC433CB;
        Mon, 23 Oct 2023 13:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698067412;
        bh=Aen7tI3tV8QliCw4GY+TVMrWQ7BjK/IzHu4XGOJDu+I=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PUfhQYxG5F0WWBAvnGb5yUqpTjKpqij1bAq1dz2aGNEJTdM21ed2h+AqiTYM4ZCBp
         MtlbaqQgbdsQeLgLuQq1kjoALRDhtqoH5zI7zBHjKemt1ZfrhbSGovRJHa7G5yZMK/
         P/s9t+UrumP48n9xlevqPHF8V57ikEOzwivvMfmxhE3HDTyTR4z/qJ9cNEApJvKf97
         bshm3781uRRExdCR1Id9g2S7sFCxd1RGq679qLe/Egl37bSl6n3tubjvKoaUetIXay
         BaVYxt+MSMf6Hrh/HcfYZ2zf6Q6JckNeQxc1Kp1jr1WXu/DB13x+Nd32qYtFXXypvw
         jnFevocx0bv2w==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 23 Oct 2023 14:20:40 +0100
Subject: [PATCH RFC RFT 1/5] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-clone3-shadow-stack-v1-1-d867d0b5d4d0@kernel.org>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
In-Reply-To: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
To:     "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        David Hildenbrand <david@redhat.com>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2302; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Aen7tI3tV8QliCw4GY+TVMrWQ7BjK/IzHu4XGOJDu+I=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlNnPDFVIE5B+3ze9Js5B/BaPIgTybaZYHGdRh4PW0
 6Oj2umeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTZzwwAKCRAk1otyXVSH0KE8B/
 0Yhwcn5e0MrNb78oefgVk9aNyTT/WKEGRnXSgKXCdjkNFZhT2+xTmF9ITt1dweV+G4orXP7/lL+SOT
 FJvK8bgzC6IS4CdUypaNnYJYDL9hlfmWcFWgtiPmZnXOy1dLwT43nEuOhMBqgKgP8nw2AJMlvujjN7
 DHc/b3+j/+lpbkBqsT79SEqUUS0K1eUhDlGBnyNLTJaxgwFd+M9U0WNoGjYqydgXpI68STiW6dFrUa
 pKEsaxwMtgm9IUGReNwDpcsR0jrQlNIlRElT07IC2RVlr3JPw4G8QRdWPtgV+h9dmQYSjVvfQxAh9k
 u0YSVwQb/NmgC9/VB0M6Cysl/4Hp+p
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since multiple architectures have support for shadow stacks and we need to
select support for this feature in several places in the generic code
provide a generic config option that the architectures can select.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/x86/Kconfig   | 1 +
 fs/proc/task_mmu.c | 2 +-
 include/linux/mm.h | 2 +-
 mm/Kconfig         | 6 ++++++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfabae8814..2b72bae0d877 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1926,6 +1926,7 @@ config X86_USER_SHADOW_STACK
 	depends on AS_WRUSS
 	depends on X86_64
 	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARCH_HAS_USER_SHADOW_STACK
 	select X86_CET
 	help
 	  Shadow stack protection is a hardware feature that detects function
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3dd5be96691b..4101e741663a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -697,7 +697,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 	};
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf5d0b1b16f4..1728cb77540d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -341,7 +341,7 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 /*
  * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
  * support core mm.
diff --git a/mm/Kconfig b/mm/Kconfig
index 264a2df5ecf5..aaa2c353ea67 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1258,6 +1258,12 @@ config LOCK_MM_AND_FIND_VMA
 	bool
 	depends on !STACK_GROWSUP
 
+config ARCH_HAS_USER_SHADOW_STACK
+	bool
+	help
+	  The architecture has hardware support for userspace shadow call
+          stacks (eg, x86 CET, arm64 GCS, RISC-V Zisslpcfi).
+
 source "mm/damon/Kconfig"
 
 endmenu

-- 
2.30.2

