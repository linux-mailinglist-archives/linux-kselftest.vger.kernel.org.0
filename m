Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53195706951
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 15:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjEQNNt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 09:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjEQNNh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 09:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9AF7AA9;
        Wed, 17 May 2023 06:13:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 979336470D;
        Wed, 17 May 2023 13:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74F6C433A4;
        Wed, 17 May 2023 13:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329183;
        bh=5NC+R9L1E/fmBQ066aYfhi0qkrJ6JzVzgVjmEHMkLjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8Upc9ileCnKM5gWLC5icoFUzHvjtfIb0rGQuYHK2R2BBoJn3EQUN8YGxQGUmTe1Q
         FifVbqnrxjcKrhIPG7cfxaO7G4kNVGuqhVVgPLyBAydYBADy08TrBam1s98AjZ3ZkE
         fEnaLhk/IvZkBjNkmt3jxoFlfX2LU4F+95jXsqagxUboJmuWOZJNNv1jdEHE1lr3u3
         s+xcsbofGAKuaoNyi4GCmd9IIZYTJX4PYJbEOaUwa4IbTX4pzj82XZ+dIN+t3R5sOK
         V2OrXFjNelWdB9lEoKDuGA5pIqfrei8Z05wavf5Tyw/7qlaF5Wje21GVRxVY4Jyrxt
         HyNYPjbLmWSMQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        audit@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH 11/14] init: consolidate prototypes in linux/init.h
Date:   Wed, 17 May 2023 15:10:59 +0200
Message-Id: <20230517131102.934196-12-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517131102.934196-1-arnd@kernel.org>
References: <20230517131102.934196-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The init/main.c file contains some extern declarations for functions
defined in architecture code, and it defines some other functions that
are called from architecture code with a custom prototype. Both of those
result in warnings with 'make W=1':

init/calibrate.c:261:37: error: no previous prototype for 'calibrate_delay_is_known' [-Werror=missing-prototypes]
init/main.c:790:20: error: no previous prototype for 'mem_encrypt_init' [-Werror=missing-prototypes]
init/main.c:792:20: error: no previous prototype for 'poking_init' [-Werror=missing-prototypes]
arch/arm64/kernel/irq.c:122:13: error: no previous prototype for 'init_IRQ' [-Werror=missing-prototypes]
arch/arm64/kernel/time.c:55:13: error: no previous prototype for 'time_init' [-Werror=missing-prototypes]
arch/x86/kernel/process.c:935:13: error: no previous prototype for 'arch_post_acpi_subsys_init' [-Werror=missing-prototypes]
init/calibrate.c:261:37: error: no previous prototype for 'calibrate_delay_is_known' [-Werror=missing-prototypes]
kernel/fork.c:991:20: error: no previous prototype for 'arch_task_cache_init' [-Werror=missing-prototypes]

Add prototypes for all of these in include/linux/init.h or another
appropriate header, and remove the duplicate declarations from
architecture specific code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/irq.h          |  1 -
 arch/microblaze/include/asm/setup.h |  2 --
 arch/mips/include/asm/irq.h         |  1 -
 arch/parisc/kernel/smp.c            |  1 -
 arch/powerpc/include/asm/irq.h      |  1 -
 arch/riscv/include/asm/irq.h        |  2 --
 arch/riscv/include/asm/timex.h      |  2 --
 arch/s390/kernel/entry.h            |  2 --
 arch/sh/include/asm/irq.h           |  1 -
 arch/sh/include/asm/rtc.h           |  2 --
 arch/sparc/include/asm/irq_32.h     |  1 -
 arch/sparc/include/asm/irq_64.h     |  1 -
 arch/sparc/include/asm/timer_64.h   |  1 -
 arch/sparc/kernel/kernel.h          |  4 ----
 arch/x86/include/asm/irq.h          |  2 --
 arch/x86/include/asm/mem_encrypt.h  |  3 ---
 arch/x86/include/asm/time.h         |  1 -
 arch/x86/include/asm/tsc.h          |  1 -
 include/linux/acpi.h                |  3 ++-
 include/linux/delay.h               |  1 +
 include/linux/init.h                | 20 ++++++++++++++++++++
 init/main.c                         | 18 ------------------
 22 files changed, 23 insertions(+), 48 deletions(-)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index f62fa9f36192..ea0fdf83c397 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -23,7 +23,6 @@
 #endif
 
 #ifndef __ASSEMBLY__
-void init_IRQ(void);
 
 #ifdef CONFIG_SMP
 #include <linux/cpumask.h>
diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/include/asm/setup.h
index a06cc1f97aa9..3657f5e78a3d 100644
--- a/arch/microblaze/include/asm/setup.h
+++ b/arch/microblaze/include/asm/setup.h
@@ -16,8 +16,6 @@ extern char *klimit;
 
 extern void mmu_reset(void);
 
-void time_init(void);
-void init_IRQ(void);
 void machine_early_init(const char *cmdline, unsigned int ram,
 		unsigned int fdt, unsigned int msr, unsigned int tlb0,
 		unsigned int tlb1);
diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index 44f9824c1d8c..75abfa834ab7 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -19,7 +19,6 @@
 #define IRQ_STACK_SIZE			THREAD_SIZE
 #define IRQ_STACK_START			(IRQ_STACK_SIZE - 16)
 
-extern void __init init_IRQ(void);
 extern void *irq_stack[NR_CPUS];
 
 /*
diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index b7fc859fa87d..83348125b524 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -271,7 +271,6 @@ void arch_send_call_function_single_ipi(int cpu)
 static void
 smp_cpu_init(int cpunum)
 {
-	extern void init_IRQ(void);    /* arch/parisc/kernel/irq.c */
 	extern void start_cpu_itimer(void); /* arch/parisc/kernel/time.c */
 
 	/* Set modes and Enable floating point coprocessor */
diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index deadd2149426..94dffa1dd223 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -50,7 +50,6 @@ extern void *hardirq_ctx[NR_CPUS];
 extern void *softirq_ctx[NR_CPUS];
 
 void __do_IRQ(struct pt_regs *regs);
-extern void __init init_IRQ(void);
 
 int irq_choose_cpu(const struct cpumask *mask);
 
diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 43b9ebfbd943..8e10a94430a2 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -16,6 +16,4 @@ void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
 
 struct fwnode_handle *riscv_get_intc_hwnode(void);
 
-extern void __init init_IRQ(void);
-
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index d6a7428f6248..a06697846e69 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -88,6 +88,4 @@ static inline int read_current_timer(unsigned long *timer_val)
 	return 0;
 }
 
-extern void time_init(void);
-
 #endif /* _ASM_RISCV_TIMEX_H */
diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index 34674e38826b..9f41853f36b9 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -34,14 +34,12 @@ void kernel_stack_overflow(struct pt_regs * regs);
 void handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 		     struct pt_regs *regs);
 
-void __init init_IRQ(void);
 void do_io_irq(struct pt_regs *regs);
 void do_ext_irq(struct pt_regs *regs);
 void do_restart(void *arg);
 void __init startup_init(void);
 void die(struct pt_regs *regs, const char *str);
 int setup_profiling_timer(unsigned int multiplier);
-void __init time_init(void);
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long sp, unsigned long ip);
 
 struct s390_mmap_arg_struct;
diff --git a/arch/sh/include/asm/irq.h b/arch/sh/include/asm/irq.h
index 1c4923502fd4..0f384b1f45ca 100644
--- a/arch/sh/include/asm/irq.h
+++ b/arch/sh/include/asm/irq.h
@@ -22,7 +22,6 @@ extern unsigned short *irq_mask_register;
 /*
  * PINT IRQs
  */
-void init_IRQ_pint(void);
 void make_imask_irq(unsigned int irq);
 
 static inline int generic_irq_demux(int irq)
diff --git a/arch/sh/include/asm/rtc.h b/arch/sh/include/asm/rtc.h
index 2d333ad60810..40b0899783d7 100644
--- a/arch/sh/include/asm/rtc.h
+++ b/arch/sh/include/asm/rtc.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_RTC_H
 #define _ASM_RTC_H
 
-void time_init(void);
-
 #define RTC_CAP_4_DIGIT_YEAR	(1 << 0)
 
 struct sh_rtc_platform_data {
diff --git a/arch/sparc/include/asm/irq_32.h b/arch/sparc/include/asm/irq_32.h
index 43ec2609b811..6ee48321cbc2 100644
--- a/arch/sparc/include/asm/irq_32.h
+++ b/arch/sparc/include/asm/irq_32.h
@@ -17,7 +17,6 @@
 
 #define irq_canonicalize(irq)	(irq)
 
-void __init init_IRQ(void);
 void __init sun4d_init_sbi_irq(void);
 
 #define NO_IRQ		0xffffffff
diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
index 154df2cf19f4..b436029f1ced 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -61,7 +61,6 @@ void sun4u_destroy_msi(unsigned int irq);
 unsigned int irq_alloc(unsigned int dev_handle, unsigned int dev_ino);
 void irq_free(unsigned int irq);
 
-void __init init_IRQ(void);
 void fixup_irqs(void);
 
 static inline void set_softint(unsigned long bits)
diff --git a/arch/sparc/include/asm/timer_64.h b/arch/sparc/include/asm/timer_64.h
index dcfad4613e18..ffff52c8b760 100644
--- a/arch/sparc/include/asm/timer_64.h
+++ b/arch/sparc/include/asm/timer_64.h
@@ -34,7 +34,6 @@ extern struct sparc64_tick_ops *tick_ops;
 
 unsigned long sparc64_get_clock_tick(unsigned int cpu);
 void setup_sparc64_timer(void);
-void __init time_init(void);
 
 #define TICK_PRIV_BIT		BIT(63)
 #define TICKCMP_IRQ_BIT		BIT(63)
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 9cd09a3ef35f..970ef8dec86e 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -62,9 +62,6 @@ asmlinkage void do_rt_sigreturn32(struct pt_regs *regs);
 void do_signal32(struct pt_regs * regs);
 asmlinkage int do_sys32_sigstack(u32 u_ssptr, u32 u_ossptr, unsigned long sp);
 
-/* time_64.c */
-void __init time_init_early(void);
-
 /* compat_audit.c */
 extern unsigned int sparc32_dir_class[];
 extern unsigned int sparc32_chattr_class[];
@@ -91,7 +88,6 @@ extern int static_irq_count;
 extern spinlock_t irq_action_lock;
 
 void unexpected_irq(int irq, void *dev_id, struct pt_regs * regs);
-void init_IRQ(void);
 
 /* sun4m_irq.c */
 void sun4m_init_IRQ(void);
diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 768aa234cbb4..29e083b92813 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -40,8 +40,6 @@ extern void __handle_irq(struct irq_desc *desc, struct pt_regs *regs);
 
 extern void init_ISA_irqs(void);
 
-extern void __init init_IRQ(void);
-
 #ifdef CONFIG_X86_LOCAL_APIC
 void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
 				    bool exclude_self);
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index b7126701574c..1c22c86d13e6 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -87,9 +87,6 @@ static inline void mem_encrypt_free_decrypted_mem(void) { }
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
-/* Architecture __weak replacement functions */
-void __init mem_encrypt_init(void);
-
 void add_encrypt_protection_map(void);
 
 /*
diff --git a/arch/x86/include/asm/time.h b/arch/x86/include/asm/time.h
index a53961c64a56..f360104ed172 100644
--- a/arch/x86/include/asm/time.h
+++ b/arch/x86/include/asm/time.h
@@ -6,7 +6,6 @@
 #include <asm/mc146818rtc.h>
 
 extern void hpet_time_init(void);
-extern void time_init(void);
 extern bool pit_timer_init(void);
 extern bool tsc_clocksource_watchdog_disabled(void);
 
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index fbdc3d951494..1992ef5e41a9 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -32,7 +32,6 @@ extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
 
 extern void tsc_early_init(void);
 extern void tsc_init(void);
-extern unsigned long calibrate_delay_is_known(void);
 extern void mark_tsc_unstable(char *reason);
 extern int unsynchronized_tsc(void);
 extern int check_tsc_unstable(void);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7b71dd74baeb..f4c2a87d02c1 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -712,7 +712,6 @@ int acpi_match_platform_list(const struct acpi_platform_list *plat);
 
 extern void acpi_early_init(void);
 extern void acpi_subsystem_init(void);
-extern void arch_post_acpi_subsys_init(void);
 
 extern int acpi_nvs_register(__u64 start, __u64 size);
 
@@ -1084,6 +1083,8 @@ static inline bool acpi_sleep_state_supported(u8 sleep_state)
 
 #endif	/* !CONFIG_ACPI */
 
+extern void arch_post_acpi_subsys_init(void);
+
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 int acpi_ioapic_add(acpi_handle root);
 #else
diff --git a/include/linux/delay.h b/include/linux/delay.h
index 039e7e0c7378..ff9cda975e30 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -56,6 +56,7 @@ static inline void ndelay(unsigned long x)
 
 extern unsigned long lpj_fine;
 void calibrate_delay(void);
+unsigned long calibrate_delay_is_known(void);
 void __attribute__((weak)) calibration_delay_done(void);
 void msleep(unsigned int msecs);
 unsigned long msleep_interruptible(unsigned int msecs);
diff --git a/include/linux/init.h b/include/linux/init.h
index c5fe6d26f5b1..1200fa99e848 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -152,6 +152,24 @@ extern unsigned int reset_devices;
 void setup_arch(char **);
 void prepare_namespace(void);
 void __init init_rootfs(void);
+
+void init_IRQ(void);
+void time_init(void);
+void mem_encrypt_init(void);
+void poking_init(void);
+void pgtable_cache_init(void);
+
+extern initcall_entry_t __initcall_start[];
+extern initcall_entry_t __initcall0_start[];
+extern initcall_entry_t __initcall1_start[];
+extern initcall_entry_t __initcall2_start[];
+extern initcall_entry_t __initcall3_start[];
+extern initcall_entry_t __initcall4_start[];
+extern initcall_entry_t __initcall5_start[];
+extern initcall_entry_t __initcall6_start[];
+extern initcall_entry_t __initcall7_start[];
+extern initcall_entry_t __initcall_end[];
+
 extern struct file_system_type rootfs_fs_type;
 
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
@@ -309,6 +327,8 @@ struct obs_kernel_param {
 	int early;
 };
 
+extern const struct obs_kernel_param __setup_start[], __setup_end[];
+
 /*
  * Only for really core code.  See moduleparam.h for the normal way.
  *
diff --git a/init/main.c b/init/main.c
index af50044deed5..d4400efbef0a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -115,10 +115,6 @@
 
 static int kernel_init(void *);
 
-extern void init_IRQ(void);
-extern void radix_tree_init(void);
-extern void maple_tree_init(void);
-
 /*
  * Debug helper: via this flag we know that we are in 'early bootup code'
  * where only the boot processor is running with IRQ disabled.  This means
@@ -137,7 +133,6 @@ EXPORT_SYMBOL(system_state);
 #define MAX_INIT_ARGS CONFIG_INIT_ENV_ARG_LIMIT
 #define MAX_INIT_ENVS CONFIG_INIT_ENV_ARG_LIMIT
 
-extern void time_init(void);
 /* Default late time init is NULL. archs can override this later. */
 void (*__initdata late_time_init)(void);
 
@@ -196,8 +191,6 @@ static const char *argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 const char *envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
 static const char *panic_later, *panic_param;
 
-extern const struct obs_kernel_param __setup_start[], __setup_end[];
-
 static bool __init obsolete_checksetup(char *line)
 {
 	const struct obs_kernel_param *p;
@@ -1263,17 +1256,6 @@ int __init_or_module do_one_initcall(initcall_t fn)
 }
 
 
-extern initcall_entry_t __initcall_start[];
-extern initcall_entry_t __initcall0_start[];
-extern initcall_entry_t __initcall1_start[];
-extern initcall_entry_t __initcall2_start[];
-extern initcall_entry_t __initcall3_start[];
-extern initcall_entry_t __initcall4_start[];
-extern initcall_entry_t __initcall5_start[];
-extern initcall_entry_t __initcall6_start[];
-extern initcall_entry_t __initcall7_start[];
-extern initcall_entry_t __initcall_end[];
-
 static initcall_entry_t *initcall_levels[] __initdata = {
 	__initcall0_start,
 	__initcall1_start,
-- 
2.39.2

