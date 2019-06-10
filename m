Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47BA23BB6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2019 19:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbfFJRxf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jun 2019 13:53:35 -0400
Received: from foss.arm.com ([217.140.110.172]:47008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388174AbfFJRxf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jun 2019 13:53:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED62C337;
        Mon, 10 Jun 2019 10:53:33 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ABC63F246;
        Mon, 10 Jun 2019 10:53:29 -0700 (PDT)
Date:   Mon, 10 Jun 2019 18:53:27 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v16 02/16] arm64: untag user pointers in access_ok and
 __uaccess_mask_ptr
Message-ID: <20190610175326.GC25803@arrakis.emea.arm.com>
References: <cover.1559580831.git.andreyknvl@google.com>
 <4327b260fb17c4776a1e3c844f388e4948cfb747.1559580831.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4327b260fb17c4776a1e3c844f388e4948cfb747.1559580831.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 03, 2019 at 06:55:04PM +0200, Andrey Konovalov wrote:
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index e5d5f31c6d36..9164ecb5feca 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -94,7 +94,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
>  	return ret;
>  }
>  
> -#define access_ok(addr, size)	__range_ok(addr, size)
> +#define access_ok(addr, size)	__range_ok(untagged_addr(addr), size)

I'm going to propose an opt-in method here (RFC for now). We can't have
a check in untagged_addr() since this is already used throughout the
kernel for both user and kernel addresses (khwasan) but we can add one
in __range_ok(). The same prctl() option will be used for controlling
the precise/imprecise mode of MTE later on. We can use a TIF_ flag here
assuming that this will be called early on and any cloned thread will
inherit this.

Anyway, it's easier to paste some diff than explain but Vincenzo can
fold them into his ABI patches that should really go together with
these. I added a couple of MTE definitions for prctl() as an example,
not used currently:

------------------8<---------------------------------------------
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index fcd0e691b1ea..2d4cb7e4edab 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -307,6 +307,10 @@ extern void __init minsigstksz_setup(void);
 /* PR_PAC_RESET_KEYS prctl */
 #define PAC_RESET_KEYS(tsk, arg)	ptrauth_prctl_reset_keys(tsk, arg)
 
+/* PR_UNTAGGED_UADDR prctl */
+int untagged_uaddr_set_mode(unsigned long arg);
+#define SET_UNTAGGED_UADDR_MODE(arg)	untagged_uaddr_set_mode(arg)
+
 /*
  * For CONFIG_GCC_PLUGIN_STACKLEAK
  *
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index c285d1ce7186..89ce77773c49 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -101,6 +101,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_SVE			23	/* Scalable Vector Extension in use */
 #define TIF_SVE_VL_INHERIT	24	/* Inherit sve_vl_onexec across exec */
 #define TIF_SSBD		25	/* Wants SSB mitigation */
+#define TIF_UNTAGGED_UADDR	26
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -116,6 +117,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
 #define _TIF_32BIT		(1 << TIF_32BIT)
 #define _TIF_SVE		(1 << TIF_SVE)
+#define _TIF_UNTAGGED_UADDR	(1 << TIF_UNTAGGED_UADDR)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 9164ecb5feca..54f5bbaebbc4 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -73,6 +73,9 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 {
 	unsigned long ret, limit = current_thread_info()->addr_limit;
 
+	if (test_thread_flag(TIF_UNTAGGED_UADDR))
+		addr = untagged_addr(addr);
+
 	__chk_user_ptr(addr);
 	asm volatile(
 	// A + B <= C + 1 for all A,B,C, in four easy steps:
@@ -94,7 +97,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 	return ret;
 }
 
-#define access_ok(addr, size)	__range_ok(untagged_addr(addr), size)
+#define access_ok(addr, size)	__range_ok(addr, size)
 #define user_addr_max			get_fs
 
 #define _ASM_EXTABLE(from, to)						\
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 3767fb21a5b8..fd191c5b92aa 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -552,3 +552,18 @@ void arch_setup_new_exec(void)
 
 	ptrauth_thread_init_user(current);
 }
+
+/*
+ * Enable the relaxed ABI allowing tagged user addresses into the kernel.
+ */
+int untagged_uaddr_set_mode(unsigned long arg)
+{
+	if (is_compat_task())
+		return -ENOTSUPP;
+	if (arg)
+		return -EINVAL;
+
+	set_thread_flag(TIF_UNTAGGED_UADDR);
+
+	return 0;
+}
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 094bb03b9cc2..4afd5e2980ee 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -229,4 +229,9 @@ struct prctl_mm_map {
 # define PR_PAC_APDBKEY			(1UL << 3)
 # define PR_PAC_APGAKEY			(1UL << 4)
 
+/* Untagged user addresses for arm64 */
+#define PR_UNTAGGED_UADDR		55
+# define PR_MTE_IMPRECISE_CHECK		0
+# define PR_MTE_PRECISE_CHECK		1
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 2969304c29fe..b1f67a8cffc4 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -124,6 +124,9 @@
 #ifndef PAC_RESET_KEYS
 # define PAC_RESET_KEYS(a, b)	(-EINVAL)
 #endif
+#ifndef SET_UNTAGGED_UADDR_MODE
+# define SET_UNTAGGED_UADDR_MODE	(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2492,6 +2495,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = PAC_RESET_KEYS(me, arg2);
 		break;
+	case PR_UNTAGGED_UADDR:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = SET_UNTAGGED_UADDR_MODE(arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
------------------8<---------------------------------------------

The tag_ptr() function in the test library would become:

static void *tag_ptr(void *ptr)
{
	static int tbi_enabled = 0;
	unsigned long tag = 0;

	if (!tbi_enabled) {
		if (prctl(PR_UNTAGGED_UADDR, 0, 0, 0, 0) == 0)
			tbi_enabled = 1;
	}

	if (!ptr)
		return ptr;
	if (tbi_enabled)
		tag = rand() & 0xff;

	return (void *)((unsigned long)ptr | (tag << TAG_SHIFT));
}

-- 
Catalin
