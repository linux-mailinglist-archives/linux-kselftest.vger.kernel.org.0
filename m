Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C446650E75
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2019 16:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfFXOe6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jun 2019 10:34:58 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:53831 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfFXOdM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jun 2019 10:33:12 -0400
Received: by mail-qk1-f201.google.com with SMTP id i196so16324584qke.20
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2019 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tdsFjTMGAQv67ujvxigoDDdQZRY2KjUSUmhKVVkpkn4=;
        b=FXzFphxxhZ4gPnsyEfmwPCsKU++pk+tQLetKbeAD+kL30Os8wS6jTLC1FyOAwqzwG8
         qyqQOp0cn9zhOxk5JMc5l0oFOeAxffwozBD6EHBuMf+g1H99GLA8bpnvyE5lvxYcPoDB
         v2rQKkSx4a1aPHdMXcrdb+qKLQ+UK6soAayiCti7WfamiWLUJerS5dovTZg3VJFuihmF
         +v/xLmshrLGJKdmPtygjRvR0B/9N40Gy0gePQDOh5lqArA5l4cIbWua1LmJOGhLkH+qh
         WyoDSORUw+ozGMLmAgsxhF4/FNkbLzS7Jm3py0t8t64ITR+1csKXPcI1wZdyVVS2QdaX
         HNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tdsFjTMGAQv67ujvxigoDDdQZRY2KjUSUmhKVVkpkn4=;
        b=kQt3u8kbTB9RGY5/JbDOqlPetF23UVsq1vlcB9m5xKtDG09SRRYPfyWuqsrfOnIYGe
         j+V33oMA0DjddodRack0peYpQct/3HGK8Q33tFV2VuEI6+MezmtFxdCTpDWWmjgHbLPo
         FraAzE4kF/RzG9FXH1rzFQxegcpt6luHA90tizSXudQo2VvZI5kGMde+R6PRSRiPxxlq
         B2h97jKvVf0b4oFehVU0YxCUhwP0vcyfhWmmuMB3NgvAxohAoNa3vmgAv1amRog9RU7O
         Bqv7hmkDvcOVGH6PG5ViPVDIJiUCeluV9+Cr5Q0nYhns1hal7UGv9o02Xt8mbBSbObZY
         /x7w==
X-Gm-Message-State: APjAAAXNtam2PbwbFd6IV33d2GaJvgsxeY5rSxSJg/oEmXTEKHNCRnWP
        fDPHSNiAnjXItiYqe2EQ54Fv15IEpzEezG/v
X-Google-Smtp-Source: APXvYqyVeERW2sgue9jEe2TF8kMo+PvfnqCiNtc9+R92KlctTPl88QfcPWrcqXjDTlwAVG6RfvdUV19XlxQALH9X
X-Received: by 2002:a05:620a:1292:: with SMTP id w18mr17480585qki.416.1561386790744;
 Mon, 24 Jun 2019 07:33:10 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:32:47 +0200
In-Reply-To: <cover.1561386715.git.andreyknvl@google.com>
Message-Id: <653598b3cfcd80f0cc69f72a214e156bb1afde68.1561386715.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v18 02/15] arm64: Introduce prctl() options to control the
 tagged user addresses ABI
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

It is not desirable to relax the ABI to allow tagged user addresses into
the kernel indiscriminately. This patch introduces a prctl() interface
for enabling or disabling the tagged ABI with a global sysctl control
for preventing applications from enabling the relaxed ABI (meant for
testing user-space prctl() return error checking without reconfiguring
the kernel). The ABI properties are inherited by threads of the same
application and fork()'ed children but cleared on execve(). A Kconfig
option allows the overall disabling of the relaxed ABI.

The PR_SET_TAGGED_ADDR_CTRL will be expanded in the future to handle
MTE-specific settings like imprecise vs precise exceptions.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Kconfig                   |  9 ++++
 arch/arm64/include/asm/processor.h   |  8 ++++
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/include/asm/uaccess.h     |  4 +-
 arch/arm64/kernel/process.c          | 72 ++++++++++++++++++++++++++++
 include/uapi/linux/prctl.h           |  5 ++
 kernel/sys.c                         | 12 +++++
 7 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 697ea0510729..55fbaf20af2d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1107,6 +1107,15 @@ config ARM64_SW_TTBR0_PAN
 	  zeroed area and reserved ASID. The user access routines
 	  restore the valid TTBR0_EL1 temporarily.
 
+config ARM64_TAGGED_ADDR_ABI
+	bool "Enable the tagged user addresses syscall ABI"
+	default y
+	help
+	  When this option is enabled, user applications can opt in to a
+	  relaxed ABI via prctl() allowing tagged addresses to be passed
+	  to system calls as pointer arguments. For details, see
+	  Documentation/arm64/tagged-address-abi.txt.
+
 menuconfig COMPAT
 	bool "Kernel support for 32-bit EL0"
 	depends on ARM64_4K_PAGES || EXPERT
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index fd5b1a4efc70..ee86070a28d4 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -296,6 +296,14 @@ extern void __init minsigstksz_setup(void);
 /* PR_PAC_RESET_KEYS prctl */
 #define PAC_RESET_KEYS(tsk, arg)	ptrauth_prctl_reset_keys(tsk, arg)
 
+#ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
+/* PR_{SET,GET}_TAGGED_ADDR_CTRL prctl */
+long set_tagged_addr_ctrl(unsigned long arg);
+long get_tagged_addr_ctrl(void);
+#define SET_TAGGED_ADDR_CTRL(arg)	set_tagged_addr_ctrl(arg)
+#define GET_TAGGED_ADDR_CTRL()		get_tagged_addr_ctrl()
+#endif
+
 /*
  * For CONFIG_GCC_PLUGIN_STACKLEAK
  *
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 2372e97db29c..4f81c4f15404 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -88,6 +88,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_SVE			23	/* Scalable Vector Extension in use */
 #define TIF_SVE_VL_INHERIT	24	/* Inherit sve_vl_onexec across exec */
 #define TIF_SSBD		25	/* Wants SSB mitigation */
+#define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index a138e3b4f717..097d6bfac0b7 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -62,7 +62,9 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 {
 	unsigned long ret, limit = current_thread_info()->addr_limit;
 
-	addr = untagged_addr(addr);
+	if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
+	    test_thread_flag(TIF_TAGGED_ADDR))
+		addr = untagged_addr(addr);
 
 	__chk_user_ptr(addr);
 	asm volatile(
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 9856395ccdb7..60e70158a4a1 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/stddef.h>
+#include <linux/sysctl.h>
 #include <linux/unistd.h>
 #include <linux/user.h>
 #include <linux/delay.h>
@@ -307,11 +308,18 @@ static void tls_thread_flush(void)
 	}
 }
 
+static void flush_tagged_addr_state(void)
+{
+	if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI))
+		clear_thread_flag(TIF_TAGGED_ADDR);
+}
+
 void flush_thread(void)
 {
 	fpsimd_flush_thread();
 	tls_thread_flush();
 	flush_ptrace_hw_breakpoint(current);
+	flush_tagged_addr_state();
 }
 
 void release_thread(struct task_struct *dead_task)
@@ -541,3 +549,67 @@ void arch_setup_new_exec(void)
 
 	ptrauth_thread_init_user(current);
 }
+
+#ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
+/*
+ * Control the relaxed ABI allowing tagged user addresses into the kernel.
+ */
+static unsigned int tagged_addr_prctl_allowed = 1;
+
+long set_tagged_addr_ctrl(unsigned long arg)
+{
+	if (!tagged_addr_prctl_allowed)
+		return -EINVAL;
+	if (is_compat_task())
+		return -EINVAL;
+	if (arg & ~PR_TAGGED_ADDR_ENABLE)
+		return -EINVAL;
+
+	update_thread_flag(TIF_TAGGED_ADDR, arg & PR_TAGGED_ADDR_ENABLE);
+
+	return 0;
+}
+
+long get_tagged_addr_ctrl(void)
+{
+	if (!tagged_addr_prctl_allowed)
+		return -EINVAL;
+	if (is_compat_task())
+		return -EINVAL;
+
+	if (test_thread_flag(TIF_TAGGED_ADDR))
+		return PR_TAGGED_ADDR_ENABLE;
+
+	return 0;
+}
+
+/*
+ * Global sysctl to disable the tagged user addresses support. This control
+ * only prevents the tagged address ABI enabling via prctl() and does not
+ * disable it for tasks that already opted in to the relaxed ABI.
+ */
+static int zero;
+static int one = 1;
+
+static struct ctl_table tagged_addr_sysctl_table[] = {
+	{
+		.procname	= "tagged_addr",
+		.mode		= 0644,
+		.data		= &tagged_addr_prctl_allowed,
+		.maxlen		= sizeof(int),
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
+	{ }
+};
+
+static int __init tagged_addr_init(void)
+{
+	if (!register_sysctl("abi", tagged_addr_sysctl_table))
+		return -EINVAL;
+	return 0;
+}
+
+core_initcall(tagged_addr_init);
+#endif	/* CONFIG_ARM64_TAGGED_ADDR_ABI */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 094bb03b9cc2..2e927b3e9d6c 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -229,4 +229,9 @@ struct prctl_mm_map {
 # define PR_PAC_APDBKEY			(1UL << 3)
 # define PR_PAC_APGAKEY			(1UL << 4)
 
+/* Tagged user address controls for arm64 */
+#define PR_SET_TAGGED_ADDR_CTRL		55
+#define PR_GET_TAGGED_ADDR_CTRL		56
+# define PR_TAGGED_ADDR_ENABLE		(1UL << 0)
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 2969304c29fe..c6c4d5358bd3 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -124,6 +124,12 @@
 #ifndef PAC_RESET_KEYS
 # define PAC_RESET_KEYS(a, b)	(-EINVAL)
 #endif
+#ifndef SET_TAGGED_ADDR_CTRL
+# define SET_TAGGED_ADDR_CTRL(a)	(-EINVAL)
+#endif
+#ifndef GET_TAGGED_ADDR_CTRL
+# define GET_TAGGED_ADDR_CTRL()		(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2492,6 +2498,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = PAC_RESET_KEYS(me, arg2);
 		break;
+	case PR_SET_TAGGED_ADDR_CTRL:
+		error = SET_TAGGED_ADDR_CTRL(arg2);
+		break;
+	case PR_GET_TAGGED_ADDR_CTRL:
+		error = GET_TAGGED_ADDR_CTRL();
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.22.0.410.gd8fdbe21b5-goog

