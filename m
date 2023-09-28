Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDC97B10E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 04:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjI1Cnx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 22:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjI1Cnw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 22:43:52 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A609C99;
        Wed, 27 Sep 2023 19:43:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vt.rlHd_1695869025;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0Vt.rlHd_1695869025)
          by smtp.aliyun-inc.com;
          Thu, 28 Sep 2023 10:43:46 +0800
From:   Yuanhe Shu <xiangzao@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yuanhe Shu <xiangzao@linux.alibaba.com>,
        Xingrui Yi <yixingrui@linux.alibaba.com>
Subject: [PATCH 1/5] pstore: add tty frontend
Date:   Thu, 28 Sep 2023 10:42:40 +0800
Message-Id: <20230928024244.257687-2-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
References: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Provide a pstore frontend which can log all messages that are send
to tty drivers when there are some problems with drivers or there
is no access to serial ports.

Using pmsg requires us to redirect the output of the user state.
When we need to globally view the serial output of various processes,
it is tedious to redirect the output of each process. We think pmsg is
more suitable for targeted viewing of certain processes' output, and
we also need a tool that can quickly do a global view so that we can
get user-state printed data if the tty driver is working abnormally or
if we don't have serial access.

Furthermore, by enabling tty frontend and console/dmesg frontend in
dump capture kernel, one can collect kernel and user messages to
discover why kdump service works abnormal.

Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
Signed-off-by: Xingrui Yi <yixingrui@linux.alibaba.com>
---
 drivers/tty/n_tty.c         |  1 +
 fs/pstore/Kconfig           | 23 +++++++++++++++++
 fs/pstore/Makefile          |  2 ++
 fs/pstore/blk.c             | 10 ++++++++
 fs/pstore/internal.h        |  8 ++++++
 fs/pstore/platform.c        |  5 ++++
 fs/pstore/ram.c             | 40 +++++++++++++++++++++++++++--
 fs/pstore/tty.c             | 50 +++++++++++++++++++++++++++++++++++++
 fs/pstore/zone.c            | 42 ++++++++++++++++++++++++++++++-
 include/linux/pstore.h      |  2 ++
 include/linux/pstore_blk.h  |  3 +++
 include/linux/pstore_ram.h  |  1 +
 include/linux/pstore_zone.h |  2 ++
 include/linux/tty.h         | 14 +++++++++++
 14 files changed, 200 insertions(+), 3 deletions(-)
 create mode 100644 fs/pstore/tty.c

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 552e8a741562..55ca40605e4c 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -582,6 +582,7 @@ static ssize_t process_output_block(struct tty_struct *tty,
 		}
 	}
 break_out:
+	tty_pstore_hook(buf, i);
 	i = tty->ops->write(tty, buf, i);
 
 	mutex_unlock(&ldata->output_lock);
diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index c49d554cc9ae..8a08e4ae71ba 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -147,6 +147,17 @@ config PSTORE_FTRACE
 
 	  If unsure, say N.
 
+config PSTORE_TTY
+	bool "Log tty messages"
+	depends on PSTORE
+	help
+	  When the option is enabled, pstore will log all messages send
+	  to tty drivers, even if no oops or panic happened. It can be
+	  useful to log serial information when there is no access to
+	  serial ports or the tty drivers work abnormally.
+
+	  If unsure, say N.
+
 config PSTORE_RAM
 	tristate "Log panic/oops to a RAM buffer"
 	depends on PSTORE
@@ -271,3 +282,15 @@ config PSTORE_BLK_FTRACE_SIZE
 
 	  NOTE that, both Kconfig and module parameters can configure
 	  pstore/blk, but module parameters have priority over Kconfig.
+
+config PSTORE_BLK_TTY_SIZE
+	int "Size in Kbytes of tty log to store"
+	depends on PSTORE_BLK
+	depends on PSTORE_TTY
+	default 64
+	help
+	  This just sets size of tty log (tty_size) for pstore/blk. The
+	  size is in KB and must be a multiple of 4.
+
+	  NOTE that, both Kconfig and module parameters can configure
+	  pstore/blk, but module parameters have priority over Kconfig.
diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
index c270467aeece..4e50efe1ebc8 100644
--- a/fs/pstore/Makefile
+++ b/fs/pstore/Makefile
@@ -10,6 +10,8 @@ pstore-$(CONFIG_PSTORE_FTRACE)	+= ftrace.o
 
 pstore-$(CONFIG_PSTORE_PMSG)	+= pmsg.o
 
+pstore-$(CONFIG_PSTORE_TTY)	+= tty.o
+
 ramoops-objs += ram.o ram_core.o
 obj-$(CONFIG_PSTORE_RAM)	+= ramoops.o
 
diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index de8cf5d75f34..6b10c6fd7d80 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -52,6 +52,14 @@ static long ftrace_size = -1;
 module_param(ftrace_size, long, 0400);
 MODULE_PARM_DESC(ftrace_size, "ftrace size in kbytes");
 
+#if IS_ENABLED(CONFIG_PSTORE_TTY)
+static long tty_size = CONFIG_PSTORE_BLK_TTY_SIZE;
+#else
+static long tty_size = -1;
+#endif
+module_param(tty_size, long, 0400);
+MODULE_PARM_DESC(tty_size, "tty_size size in kbytes");
+
 static bool best_effort;
 module_param(best_effort, bool, 0400);
 MODULE_PARM_DESC(best_effort, "use best effort to write (i.e. do not require storage driver pstore support, default: off)");
@@ -130,6 +138,7 @@ static int __register_pstore_device(struct pstore_device_info *dev)
 	verify_size(pmsg_size, 4096, dev->flags & PSTORE_FLAGS_PMSG);
 	verify_size(console_size, 4096, dev->flags & PSTORE_FLAGS_CONSOLE);
 	verify_size(ftrace_size, 4096, dev->flags & PSTORE_FLAGS_FTRACE);
+	verify_size(tty_size, 4096, dev->flags & PSTORE_FLAGS_TTY);
 	dev->zone.max_reason = max_reason;
 
 	/* Initialize required zone ownership details. */
@@ -247,6 +256,7 @@ int pstore_blk_get_config(struct pstore_blk_config *info)
 	info->pmsg_size = check_size(pmsg_size, 4096);
 	info->ftrace_size = check_size(ftrace_size, 4096);
 	info->console_size = check_size(console_size, 4096);
+	info->tty_size = check_size(tty_size, 4096);
 
 	return 0;
 }
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index 801d6c0b170c..1205366f0523 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -33,6 +33,14 @@ static inline void pstore_register_pmsg(void) {}
 static inline void pstore_unregister_pmsg(void) {}
 #endif
 
+#ifdef CONFIG_PSTORE_TTY
+extern void pstore_register_tty(void);
+extern void pstore_unregister_tty(void);
+#else
+static inline void pstore_register_tty(void) {}
+static inline void pstore_unregister_tty(void) {}
+#endif
+
 extern struct pstore_info *psinfo;
 
 extern void	pstore_set_kmsg_bytes(int);
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index cbc0b468c1ab..a6a1df06cfe1 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -58,6 +58,7 @@ static const char * const pstore_type_names[] = {
 	"powerpc-common",
 	"pmsg",
 	"powerpc-opal",
+	"tty",
 };
 
 static int pstore_new_entry;
@@ -622,6 +623,8 @@ int pstore_register(struct pstore_info *psi)
 		pstore_register_ftrace();
 	if (psi->flags & PSTORE_FLAGS_PMSG)
 		pstore_register_pmsg();
+	if (psi->flags & PSTORE_FLAGS_TTY)
+		pstore_register_tty();
 
 	/* Start watching for new records, if desired. */
 	pstore_timer_kick();
@@ -662,6 +665,8 @@ void pstore_unregister(struct pstore_info *psi)
 		pstore_unregister_console();
 	if (psi->flags & PSTORE_FLAGS_DMESG)
 		pstore_unregister_kmsg();
+	if (psi->flags & PSTORE_FLAGS_TTY)
+		pstore_unregister_tty();
 
 	/* Stop timer and make sure all work has finished. */
 	del_timer_sync(&pstore_timer);
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 2f625e1fa8d8..f59712bc51d3 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -44,6 +44,10 @@ static ulong ramoops_pmsg_size = MIN_MEM_SIZE;
 module_param_named(pmsg_size, ramoops_pmsg_size, ulong, 0400);
 MODULE_PARM_DESC(pmsg_size, "size of user space message log");
 
+static ulong ramoops_tty_size = MIN_MEM_SIZE;
+module_param_named(tty_size, ramoops_tty_size, ulong, 0400);
+MODULE_PARM_DESC(tty_size, "size of tty message log");
+
 static unsigned long long mem_address;
 module_param_hw(mem_address, ullong, other, 0400);
 MODULE_PARM_DESC(mem_address,
@@ -81,6 +85,7 @@ struct ramoops_context {
 	struct persistent_ram_zone *cprz;	/* Console zone */
 	struct persistent_ram_zone **fprzs;	/* Ftrace zones */
 	struct persistent_ram_zone *mprz;	/* PMSG zone */
+	struct persistent_ram_zone *tprz;	/* TTY zone */
 	phys_addr_t phys_addr;
 	unsigned long size;
 	unsigned int memtype;
@@ -88,6 +93,7 @@ struct ramoops_context {
 	size_t console_size;
 	size_t ftrace_size;
 	size_t pmsg_size;
+	size_t tty_size;
 	u32 flags;
 	struct persistent_ram_ecc_info ecc_info;
 	unsigned int max_dump_cnt;
@@ -98,6 +104,7 @@ struct ramoops_context {
 	unsigned int max_ftrace_cnt;
 	unsigned int ftrace_read_cnt;
 	unsigned int pmsg_read_cnt;
+	unsigned int tty_read_cnt;
 	struct pstore_info pstore;
 };
 
@@ -111,6 +118,7 @@ static int ramoops_pstore_open(struct pstore_info *psi)
 	cxt->console_read_cnt = 0;
 	cxt->ftrace_read_cnt = 0;
 	cxt->pmsg_read_cnt = 0;
+	cxt->tty_read_cnt = 0;
 	return 0;
 }
 
@@ -214,6 +222,9 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 	if (!prz_ok(prz) && !cxt->pmsg_read_cnt++)
 		prz = ramoops_get_next_prz(&cxt->mprz, 0 /* single */, record);
 
+	if (!prz_ok(prz) && !cxt->tty_read_cnt++)
+		prz = ramoops_get_next_prz(&cxt->tprz, 0 /* single */, record);
+
 	/* ftrace is last since it may want to dynamically allocate memory. */
 	if (!prz_ok(prz)) {
 		if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU) &&
@@ -335,6 +346,11 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
 	} else if (record->type == PSTORE_TYPE_PMSG) {
 		pr_warn_ratelimited("PMSG shouldn't call %s\n", __func__);
 		return -EINVAL;
+	} else if (record->type == PSTORE_TYPE_TTY) {
+		if (!cxt->tprz)
+			return -ENOMEM;
+		persistent_ram_write(cxt->tprz, record->buf, record->size);
+		return 0;
 	}
 
 	if (record->type != PSTORE_TYPE_DMESG)
@@ -426,6 +442,9 @@ static int ramoops_pstore_erase(struct pstore_record *record)
 	case PSTORE_TYPE_PMSG:
 		prz = cxt->mprz;
 		break;
+	case PSTORE_TYPE_TTY:
+		prz = cxt->tprz;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -458,6 +477,9 @@ static void ramoops_free_przs(struct ramoops_context *cxt)
 	/* Free console PRZ */
 	persistent_ram_free(&cxt->cprz);
 
+	/* Free tty PRZ */
+	persistent_ram_free(&cxt->tprz);
+
 	/* Free dump PRZs */
 	if (cxt->dprzs) {
 		for (i = 0; i < cxt->max_dump_cnt; i++)
@@ -685,6 +707,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 	parse_u32("console-size", pdata->console_size, 0);
 	parse_u32("ftrace-size", pdata->ftrace_size, 0);
 	parse_u32("pmsg-size", pdata->pmsg_size, 0);
+	parse_u32("tty-size", pdata->tty_size, 0);
 	parse_u32("ecc-size", pdata->ecc_info.ecc_size, 0);
 	parse_u32("flags", pdata->flags, 0);
 	parse_u32("max-reason", pdata->max_reason, pdata->max_reason);
@@ -705,9 +728,10 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 	parent_node = of_get_parent(of_node);
 	if (!of_node_name_eq(parent_node, "reserved-memory") &&
 	    !pdata->console_size && !pdata->ftrace_size &&
-	    !pdata->pmsg_size && !pdata->ecc_info.ecc_size) {
+	    !pdata->pmsg_size && !pdata->tty_size && !pdata->ecc_info.ecc_size) {
 		pdata->console_size = pdata->record_size;
 		pdata->pmsg_size = pdata->record_size;
+		pdata->tty_size = pdata->record_size;
 	}
 	of_node_put(parent_node);
 
@@ -765,6 +789,8 @@ static int ramoops_probe(struct platform_device *pdev)
 		pdata->ftrace_size = rounddown_pow_of_two(pdata->ftrace_size);
 	if (pdata->pmsg_size && !is_power_of_2(pdata->pmsg_size))
 		pdata->pmsg_size = rounddown_pow_of_two(pdata->pmsg_size);
+	if (pdata->tty_size && !is_power_of_2(pdata->tty_size))
+		pdata->tty_size = rounddown_pow_of_two(pdata->tty_size);
 
 	cxt->size = pdata->mem_size;
 	cxt->phys_addr = pdata->mem_address;
@@ -773,13 +799,14 @@ static int ramoops_probe(struct platform_device *pdev)
 	cxt->console_size = pdata->console_size;
 	cxt->ftrace_size = pdata->ftrace_size;
 	cxt->pmsg_size = pdata->pmsg_size;
+	cxt->tty_size = pdata->tty_size;
 	cxt->flags = pdata->flags;
 	cxt->ecc_info = pdata->ecc_info;
 
 	paddr = cxt->phys_addr;
 
 	dump_mem_sz = cxt->size - cxt->console_size - cxt->ftrace_size
-			- cxt->pmsg_size;
+			- cxt->pmsg_size - cxt->tty_size;
 	err = ramoops_init_przs("dmesg", dev, cxt, &cxt->dprzs, &paddr,
 				dump_mem_sz, cxt->record_size,
 				&cxt->max_dump_cnt, 0, 0);
@@ -796,6 +823,11 @@ static int ramoops_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_init;
 
+	err = ramoops_init_prz("tty", dev, cxt, &cxt->tprz, &paddr,
+				cxt->tty_size, 0);
+	if (err)
+		goto fail_init;
+
 	cxt->max_ftrace_cnt = (cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)
 				? nr_cpu_ids
 				: 1;
@@ -825,6 +857,8 @@ static int ramoops_probe(struct platform_device *pdev)
 		cxt->pstore.flags |= PSTORE_FLAGS_FTRACE;
 	if (cxt->pmsg_size)
 		cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
+	if (cxt->tty_size)
+		cxt->pstore.flags |= PSTORE_FLAGS_TTY;
 
 	/*
 	 * Since bufsize is only used for dmesg crash dumps, it
@@ -858,6 +892,7 @@ static int ramoops_probe(struct platform_device *pdev)
 	ramoops_console_size = pdata->console_size;
 	ramoops_pmsg_size = pdata->pmsg_size;
 	ramoops_ftrace_size = pdata->ftrace_size;
+	ramoops_tty_size = pdata->tty_size;
 
 	pr_info("using 0x%lx@0x%llx, ecc: %d\n",
 		cxt->size, (unsigned long long)cxt->phys_addr,
@@ -929,6 +964,7 @@ static void __init ramoops_register_dummy(void)
 	pdata.console_size = ramoops_console_size;
 	pdata.ftrace_size = ramoops_ftrace_size;
 	pdata.pmsg_size = ramoops_pmsg_size;
+	pdata.tty_size = ramoops_tty_size;
 	/* If "max_reason" is set, its value has priority over "dump_oops". */
 	if (ramoops_max_reason >= 0)
 		pdata.max_reason = ramoops_max_reason;
diff --git a/fs/pstore/tty.c b/fs/pstore/tty.c
new file mode 100644
index 000000000000..432ed7194188
--- /dev/null
+++ b/fs/pstore/tty.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Provide a pstore frontend which can log all messages that are send
+ * to tty drivers when there are some problems with drivers or there
+ * is no access to serial ports.
+ */
+
+#include <linux/kernel.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include "internal.h"
+
+DEFINE_STATIC_KEY_FALSE(tty_key);
+
+#define TTY_NAME "tty"
+#undef pr_fmt
+#define pr_fmt(fmt) TTY_NAME ": " fmt
+
+static void do_write_ttymsg(const unsigned char *buf, int count,
+							struct pstore_info *psinfo)
+{
+	struct pstore_record record, newline;
+
+	pstore_record_init(&record, psinfo);
+	record.type = PSTORE_TYPE_TTY;
+	record.size = count;
+	record.buf = (char *)buf;
+	psinfo->write(&record);
+
+	pstore_record_init(&newline, psinfo);
+	newline.type = PSTORE_TYPE_TTY;
+	newline.size = strlen("\n");
+	newline.buf = "\n";
+	psinfo->write(&newline);
+}
+
+void pstore_register_tty(void)
+{
+	static_branch_enable(&tty_key);
+}
+
+void pstore_start_tty(const unsigned char *buf, int count)
+{
+	do_write_ttymsg(buf, count);
+}
+
+void pstore_unregister_tty(void)
+{
+	static_branch_disable(&tty_key);
+}
diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 2770746bb7aa..ca985e9493d7 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -93,6 +93,7 @@ struct pstore_zone {
  * @ppsz: pmsg storage zone
  * @cpsz: console storage zone
  * @fpszs: ftrace storage zones
+ * @tpsz: tty storage zone
  * @kmsg_max_cnt: max count of @kpszs
  * @kmsg_read_cnt: counter of total read kmsg dumps
  * @kmsg_write_cnt: counter of total kmsg dump writes
@@ -100,6 +101,7 @@ struct pstore_zone {
  * @console_read_cnt: counter of total read console zone
  * @ftrace_max_cnt: max count of @fpszs
  * @ftrace_read_cnt: counter of max read ftrace zone
+ * @tty_read_cnt: counter of total read tty zone
  * @oops_counter: counter of oops dumps
  * @panic_counter: counter of panic dumps
  * @recovered: whether finished recovering data from storage
@@ -113,6 +115,7 @@ struct psz_context {
 	struct pstore_zone *ppsz;
 	struct pstore_zone *cpsz;
 	struct pstore_zone **fpszs;
+	struct pstore_zone *tpsz;
 	unsigned int kmsg_max_cnt;
 	unsigned int kmsg_read_cnt;
 	unsigned int kmsg_write_cnt;
@@ -120,6 +123,7 @@ struct psz_context {
 	unsigned int console_read_cnt;
 	unsigned int ftrace_max_cnt;
 	unsigned int ftrace_read_cnt;
+	unsigned int tty_read_cnt;
 	/*
 	 * These counters should be calculated during recovery.
 	 * It records the oops/panic times after crashes rather than boots.
@@ -325,6 +329,8 @@ static void psz_flush_all_dirty_zones(struct work_struct *work)
 		ret |= psz_flush_dirty_zones(cxt->kpszs, cxt->kmsg_max_cnt);
 	if (cxt->fpszs)
 		ret |= psz_flush_dirty_zones(cxt->fpszs, cxt->ftrace_max_cnt);
+	if (cxt->tpsz)
+		ret |= psz_flush_dirty_zone(cxt->tpsz);
 	if (ret && cxt->pstore_zone_info)
 		schedule_delayed_work(&psz_cleaner, msecs_to_jiffies(1000));
 }
@@ -617,6 +623,10 @@ static inline int psz_recovery(struct psz_context *cxt)
 	if (ret)
 		goto out;
 
+	ret = psz_recover_zone(cxt, cxt->tpsz);
+	if (ret)
+		goto out;
+
 	ret = psz_recover_zones(cxt, cxt->fpszs, cxt->ftrace_max_cnt);
 
 out:
@@ -637,6 +647,7 @@ static int psz_pstore_open(struct pstore_info *psi)
 	cxt->pmsg_read_cnt = 0;
 	cxt->console_read_cnt = 0;
 	cxt->ftrace_read_cnt = 0;
+	cxt->tty_read_cnt = 0;
 	return 0;
 }
 
@@ -713,6 +724,8 @@ static int psz_pstore_erase(struct pstore_record *record)
 		if (record->id >= cxt->ftrace_max_cnt)
 			return -EINVAL;
 		return psz_record_erase(cxt, cxt->fpszs[record->id]);
+	case PSTORE_TYPE_TTY:
+		return psz_record_erase(cxt, cxt->tpsz);
 	default: return -EINVAL;
 	}
 }
@@ -891,6 +904,8 @@ static int notrace psz_pstore_write(struct pstore_record *record)
 		return psz_record_write(cxt->cpsz, record);
 	case PSTORE_TYPE_PMSG:
 		return psz_record_write(cxt->ppsz, record);
+	case PSTORE_TYPE_TTY:
+		return psz_record_write(cxt->tpsz, record);
 	case PSTORE_TYPE_FTRACE: {
 		int zonenum = smp_processor_id();
 
@@ -935,6 +950,13 @@ static struct pstore_zone *psz_read_next_zone(struct psz_context *cxt)
 			return zone;
 	}
 
+	if (cxt->tty_read_cnt == 0) {
+		cxt->tty_read_cnt++;
+		zone = cxt->tpsz;
+		if (psz_old_ok(zone))
+			return zone;
+	}
+
 	return NULL;
 }
 
@@ -1081,6 +1103,7 @@ static ssize_t psz_pstore_read(struct pstore_record *record)
 		readop = psz_ftrace_read;
 		break;
 	case PSTORE_TYPE_CONSOLE:
+	case PSTORE_TYPE_TTY:
 	case PSTORE_TYPE_PMSG:
 		readop = psz_record_read;
 		break;
@@ -1145,6 +1168,8 @@ static void psz_free_all_zones(struct psz_context *cxt)
 		psz_free_zone(&cxt->cpsz);
 	if (cxt->fpszs)
 		psz_free_zones(&cxt->fpszs, &cxt->ftrace_max_cnt);
+	if (cxt->tpsz)
+		psz_free_zone(&cxt->tpsz);
 }
 
 static struct pstore_zone *psz_init_zone(enum pstore_type_id type,
@@ -1255,6 +1280,15 @@ static int psz_alloc_zones(struct psz_context *cxt)
 		goto free_out;
 	}
 
+	off_size += info->tty_size;
+	cxt->tpsz = psz_init_zone(PSTORE_TYPE_TTY, &off,
+			info->tty_size);
+	if (IS_ERR(cxt->tpsz)) {
+		err = PTR_ERR(cxt->tpsz);
+		cxt->tpsz = NULL;
+		goto free_out;
+	}
+
 	off_size += info->ftrace_size;
 	cxt->fpszs = psz_init_zones(PSTORE_TYPE_FTRACE, &off,
 			info->ftrace_size,
@@ -1305,7 +1339,7 @@ int register_pstore_zone(struct pstore_zone_info *info)
 	}
 
 	if (!info->kmsg_size && !info->pmsg_size && !info->console_size &&
-	    !info->ftrace_size) {
+	    !info->ftrace_size && !info->tty_size) {
 		pr_warn("at least one record size must be non-zero\n");
 		return -EINVAL;
 	}
@@ -1330,6 +1364,7 @@ int register_pstore_zone(struct pstore_zone_info *info)
 	check_size(pmsg_size, SECTOR_SIZE);
 	check_size(console_size, SECTOR_SIZE);
 	check_size(ftrace_size, SECTOR_SIZE);
+	check_size(tty_size, SECTOR_SIZE);
 
 #undef check_size
 
@@ -1358,6 +1393,7 @@ int register_pstore_zone(struct pstore_zone_info *info)
 	pr_debug("\tpmsg size : %ld Bytes\n", info->pmsg_size);
 	pr_debug("\tconsole size : %ld Bytes\n", info->console_size);
 	pr_debug("\tftrace size : %ld Bytes\n", info->ftrace_size);
+	pr_debug("\ttty size : %ld Bytes\n", info->tty_size);
 
 	err = psz_alloc_zones(cxt);
 	if (err) {
@@ -1399,6 +1435,10 @@ int register_pstore_zone(struct pstore_zone_info *info)
 		cxt->pstore.flags |= PSTORE_FLAGS_FTRACE;
 		pr_cont(" ftrace");
 	}
+	if (info->tty_size) {
+		cxt->pstore.flags |= PSTORE_FLAGS_TTY;
+		pr_cont(" tty");
+	}
 	pr_cont("\n");
 
 	err = pstore_register(&cxt->pstore);
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 638507a3c8ff..791c86552921 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -38,6 +38,7 @@ enum pstore_type_id {
 	PSTORE_TYPE_PPC_COMMON	= 6,
 	PSTORE_TYPE_PMSG	= 7,
 	PSTORE_TYPE_PPC_OPAL	= 8,
+	PSTORE_TYPE_TTY		= 9,
 
 	/* End of the list */
 	PSTORE_TYPE_MAX
@@ -206,6 +207,7 @@ struct pstore_info {
 #define PSTORE_FLAGS_CONSOLE	BIT(1)
 #define PSTORE_FLAGS_FTRACE	BIT(2)
 #define PSTORE_FLAGS_PMSG	BIT(3)
+#define PSTORE_FLAGS_TTY	BIT(4)
 
 extern int pstore_register(struct pstore_info *);
 extern void pstore_unregister(struct pstore_info *);
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 924ca07aafbd..8cebd317527f 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -33,6 +33,7 @@ void unregister_pstore_device(struct pstore_device_info *dev);
  * @pmsg_size:		Total size of the pmsg storage area
  * @console_size:	Total size of the console storage area
  * @ftrace_size:	Total size for ftrace logging data (for all CPUs)
+ * @tty_size:		Total size of the tty storage area
  */
 struct pstore_blk_config {
 	char device[80];
@@ -41,6 +42,8 @@ struct pstore_blk_config {
 	unsigned long pmsg_size;
 	unsigned long console_size;
 	unsigned long ftrace_size;
+	unsigned long tty_size;
+
 };
 
 /**
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 9d65ff94e216..ad343e36ce18 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -34,6 +34,7 @@ struct ramoops_platform_data {
 	unsigned long	console_size;
 	unsigned long	ftrace_size;
 	unsigned long	pmsg_size;
+	unsigned long	tty_size;
 	int		max_reason;
 	u32		flags;
 	struct persistent_ram_ecc_info ecc_info;
diff --git a/include/linux/pstore_zone.h b/include/linux/pstore_zone.h
index 1e35eaa33e5e..80d95e02750f 100644
--- a/include/linux/pstore_zone.h
+++ b/include/linux/pstore_zone.h
@@ -21,6 +21,7 @@ typedef ssize_t (*pstore_zone_erase_op)(size_t, loff_t);
  * @pmsg_size:	The size of pmsg zone which is the same as @kmsg_size.
  * @console_size:The size of console zone which is the same as @kmsg_size.
  * @ftrace_size:The size of ftrace zone which is the same as @kmsg_size.
+ * @tty_size:The size of tty zone which is the same as @kmsg_size.
  * @read:	The general read operation. Both of the function parameters
  *		@size and @offset are relative value to storage.
  *		On success, the number of bytes should be returned, others
@@ -48,6 +49,7 @@ struct pstore_zone_info {
 	unsigned long pmsg_size;
 	unsigned long console_size;
 	unsigned long ftrace_size;
+	unsigned long tty_size;
 	pstore_zone_read_op read;
 	pstore_zone_write_op write;
 	pstore_zone_erase_op erase;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index e8d5d9997aca..88c9412d671a 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -434,6 +434,20 @@ void tty_termios_encode_baud_rate(struct ktermios *termios, speed_t ibaud,
 void tty_encode_baud_rate(struct tty_struct *tty, speed_t ibaud,
 		speed_t obaud);
 
+#ifdef CONFIG_PSTORE_TTY
+DECLARE_STATIC_KEY_FALSE(tty_key);
+extern void pstore_start_tty(const unsigned char *buf, int count);
+
+static inline void tty_pstore_hook(const unsigned char *buf, int count)
+{
+	if (static_branch_unlikely(&tty_key))
+		pstore_start_tty(buf, count);
+}
+
+#else
+static inline void tty_pstore_hook(const unsigned char *buf, int count) {}
+#endif
+
 /**
  *	tty_get_baud_rate	-	get tty bit rates
  *	@tty: tty to query
-- 
2.39.3

