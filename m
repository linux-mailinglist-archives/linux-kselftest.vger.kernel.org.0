Return-Path: <linux-kselftest+bounces-22407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537409D4F40
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 15:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBD91F21083
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 14:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0261DE3CE;
	Thu, 21 Nov 2024 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JIAk+rly";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LQUce8H3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715D1DBB13;
	Thu, 21 Nov 2024 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200640; cv=none; b=p4s1dD2bMl9XC169r+pXDNy2mQqtgwrCF/Xj690kEjfFtWiXxOM3RT1BL9fx09JRihqRoXAGuopXtcugOM43MHLeCKDcUspIvWPwvxOTrMqSexE+hNfZEfeL/jkI94VYaaD+LwYDSU5l/d6+heIA+3elewAiqAjfc3lwHkHqEXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200640; c=relaxed/simple;
	bh=pU6rOgQVh/c7d/d9Ala3NLfLk14SMZaXD2UvOSiLR+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=p3q3VC0yTfLMJsYFm9HguPw8n8JiyIrG8gIIi2BHDcZywe0k18nquXB7iP6xz0eIt89iE5YJlOlN6ZdBDAjs5Ap5quLFemesIg+pw3T+ZyGmJimgOaQKUYOaLqg4ADeZNk9siWDl/zB6xBsTPmkUn0gpGLTAC6wA2hnssYXjwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JIAk+rly; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LQUce8H3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732200635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=USBCcfi6bUWUlnyPWKrgwcW59LiWlwxWCde2Nd+xdT4=;
	b=JIAk+rlyNjFUsLo+9I7hWTuJvovuPARwL8EDSe7bWoG+yW7xxF8ayEAdqot51IPeLYas00
	6Zrd8mDOMXzBk3sXxi/iOue3ebenafj1QsKFbEGuTmfnDVTnxwszfT6K5DahUf6MzF1TRL
	e4DFd3OUHCaUpDm9zZz1dmiKQSafWM+DeYYjrrNvP78V2cdLm8TwOClllArAq2ZUoMpZ8Z
	gwS5MCPGaxrXj/L0npUDCdIN13QoAMPW1OI7KKSwH0jkgtoycPU6vLqxp52VtlK/raf84q
	BIsSH7F5cNZidIhR3x06S+5RCGCA1n/ftAG8jaIfiDtf31bOwuiSA2M/8HEtmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732200635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=USBCcfi6bUWUlnyPWKrgwcW59LiWlwxWCde2Nd+xdT4=;
	b=LQUce8H3P4yP67nFQRowoeDR2I1MRgzMa5GktcpUpTDzluOQsqAP9zR5ZHZ/zx9/vzmXwW
	QPiXuazUFIfeVxDw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	Alice Ryhl <aliceryhl@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Mark Rutland <mark.rutland@arm.com>,
	Jann Horn <jannh@google.com>
Subject: [PATCH printk v1] printk: ringbuffer: Add KUnit test
Date: Thu, 21 Nov 2024 15:56:34 +0106
Message-Id: <20241121145034.123367-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

The KUnit test validates the correct operation of the ringbuffer.
A separate dedicated ringbuffer is used so that the global printk
ringbuffer is not touched.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
For those not familiar with KUnit, you can easily run this test
doing something like this:

$ ./tools/testing/kunit/kunit.py run \
  --arch=x86_64 \
  --qemu_args "-enable-kvm -smp 8" \
  --kunitconfig kernel/printk

 init/Kconfig                           |  12 +
 kernel/printk/.kunitconfig             |   3 +
 kernel/printk/Makefile                 |   2 +
 kernel/printk/printk_ringbuffer.c      |   4 +
 kernel/printk/printk_ringbuffer_test.c | 350 +++++++++++++++++++++++++
 5 files changed, 371 insertions(+)
 create mode 100644 kernel/printk/.kunitconfig
 create mode 100644 kernel/printk/printk_ringbuffer_test.c

diff --git a/init/Kconfig b/init/Kconfig
index 3b6ca7cce03b..46d144908191 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1576,6 +1576,18 @@ config PRINTK
 	  very difficult to diagnose system problems, saying N here is
 	  strongly discouraged.
 
+config PRINTK_RINGBUFFER_TEST
+	tristate "Test for the printk ringbuffer" if !KUNIT_ALL_TESTS
+	depends on PRINTK && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the printk ringbuffer KUnit test suite.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation.
+
+	  If unsure, say N.
+
 config BUG
 	bool "BUG() support" if EXPERT
 	default y
diff --git a/kernel/printk/.kunitconfig b/kernel/printk/.kunitconfig
new file mode 100644
index 000000000000..8d31a5c19053
--- /dev/null
+++ b/kernel/printk/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_SMP=y
+CONFIG_PRINTK_RINGBUFFER_TEST=y
diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
index 39a2b61c7232..edb5a4cacf67 100644
--- a/kernel/printk/Makefile
+++ b/kernel/printk/Makefile
@@ -7,3 +7,5 @@ obj-$(CONFIG_PRINTK_INDEX)	+= index.o
 obj-$(CONFIG_PRINTK)                 += printk_support.o
 printk_support-y	             := printk_ringbuffer.o
 printk_support-$(CONFIG_SYSCTL)	     += sysctl.o
+
+obj-$(CONFIG_PRINTK_RINGBUFFER_TEST) += printk_ringbuffer_test.o
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 88e8f3a61922..57b80d262cb7 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <kunit/visibility.h>
 #include <linux/kernel.h>
 #include <linux/irqflags.h>
 #include <linux/string.h>
@@ -1685,6 +1686,7 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	memset(r, 0, sizeof(*r));
 	return false;
 }
+EXPORT_SYMBOL_IF_KUNIT(prb_reserve);
 
 /* Commit the data (possibly finalizing it) and restore interrupts. */
 static void _prb_commit(struct prb_reserved_entry *e, unsigned long state_val)
@@ -1759,6 +1761,7 @@ void prb_commit(struct prb_reserved_entry *e)
 	if (head_id != e->id)
 		desc_make_final(e->rb, e->id);
 }
+EXPORT_SYMBOL_IF_KUNIT(prb_commit);
 
 /**
  * prb_final_commit() - Commit and finalize (previously reserved) data to
@@ -2181,6 +2184,7 @@ bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
 {
 	return _prb_read_valid(rb, &seq, r, NULL);
 }
+EXPORT_SYMBOL_IF_KUNIT(prb_read_valid);
 
 /**
  * prb_read_valid_info() - Non-blocking read of meta data for a requested
diff --git a/kernel/printk/printk_ringbuffer_test.c b/kernel/printk/printk_ringbuffer_test.c
new file mode 100644
index 000000000000..79331ea2b739
--- /dev/null
+++ b/kernel/printk/printk_ringbuffer_test.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/random.h>
+#include <linux/sched/clock.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+
+#include <kunit/test.h>
+
+#include "printk_ringbuffer.h"
+
+/*
+ * This KUnit tests the data integrity of the lockless printk_ringbuffer.
+ * From multiple CPUs it writes messages of varying length and content while
+ * a reader validates the correctness of the messages.
+ *
+ * IMPORTANT: The more CPUs you can use for this KUnit, the better!
+ *
+ * The test works by starting "num_online_cpus() - 1" writer threads, each
+ * pinned to their own CPU. Each writer thread loops, writing data of varying
+ * length into a printk_ringbuffer as fast as possible. The data content is
+ * an embedded data struct followed by string content repeating the byte:
+ *
+ *      'A' + CPUID
+ *
+ * A reader thread is started on the remaining online CPU and ensures that
+ * embedded struct content is consistent with the string and that the string
+ * is terminated and is composed of the same repeating byte as its first byte.
+ *
+ * Because the threads are running in such tight loops, they will call
+ * schedule() from time to time so the system stays functional.
+ *
+ * If the reader encounters an error, the test is aborted and some
+ * information about the error is provided via printk. The runtime of
+ * the test can be configured with the runtime_ms module parameter.
+ *
+ * Note that the test is performed on a separate printk_ringbuffer instance
+ * and not the instance used by printk().
+ */
+
+static unsigned long runtime_ms = 10000;
+module_param(runtime_ms, ulong, 0400);
+
+/* used by writers to signal reader of new records */
+static DECLARE_WAIT_QUEUE_HEAD(test_wait);
+
+/* test data structure */
+struct rbdata {
+	unsigned int len;
+	char text[] __counted_by(len);
+};
+
+#define MAX_RBDATA_LEN (0x7f + 1)
+#define MAX_RECORD_SIZE (sizeof(struct rbdata) + MAX_RBDATA_LEN + 1)
+
+static struct test_running {
+	int runstate;
+	unsigned long num;
+	struct kunit *test;
+} *test_running;
+static int halt_test;
+
+static void fail_record(struct kunit *test, struct rbdata *dat, u64 seq)
+{
+	char buf[MAX_RBDATA_LEN + 1];
+
+	snprintf(buf, sizeof(buf), "%s", dat->text);
+	buf[sizeof(buf) - 1] = 0;
+
+	KUNIT_FAIL(test, "BAD RECORD: seq=%llu len=%u text=%s\n",
+		   seq, dat->len, dat->len < sizeof(buf) ? buf : "<invalid>");
+}
+
+static bool check_data(struct rbdata *dat)
+{
+	unsigned int len;
+
+	len = strnlen(dat->text, MAX_RBDATA_LEN + 1);
+
+	/* Sane length? */
+	if (len != dat->len || !len || len > MAX_RBDATA_LEN)
+		return false;
+
+	/* String repeats with the same character? */
+	while (len) {
+		len--;
+		if (dat->text[len] != dat->text[0])
+			return false;
+	}
+
+	return true;
+}
+
+/* Equivalent to CONFIG_LOG_BUF_SHIFT=13 */
+DEFINE_PRINTKRB(test_rb, 8, 5);
+
+static int prbtest_writer(void *data)
+{
+	struct test_running *tr = data;
+	char text_id = 'A' + tr->num;
+	struct prb_reserved_entry e;
+	unsigned long count = 0;
+	struct printk_record r;
+	u64 min_ns = (u64)-1;
+	struct rbdata *dat;
+	u64 total_ns = 0;
+	u64 max_ns = 0;
+	u64 post_ns;
+	u64 pre_ns;
+	int len;
+
+	set_cpus_allowed_ptr(current, cpumask_of(tr->num));
+
+	kunit_info(tr->test, "start thread %03lu (writer)\n", tr->num);
+
+	tr->runstate = 1;
+
+	for (;;) {
+		/* +2 to ensure at least 1 character + terminator. */
+		len = sizeof(struct rbdata) + (get_random_u32() & 0x7f) + 2;
+
+		/* specify the text sizes for reservation */
+		prb_rec_init_wr(&r, len);
+
+		pre_ns = local_clock();
+
+		if (prb_reserve(&e, &test_rb, &r)) {
+			r.info->text_len = len;
+
+			len -= sizeof(struct rbdata) + 1;
+
+			dat = (struct rbdata *)&r.text_buf[0];
+			dat->len = len;
+			memset(&dat->text[0], text_id, len);
+			dat->text[len] = 0;
+
+			prb_commit(&e);
+
+			post_ns = local_clock();
+
+			wake_up_interruptible(&test_wait);
+
+			post_ns -= pre_ns;
+			if (post_ns < min_ns)
+				min_ns = post_ns;
+			if (post_ns > max_ns)
+				max_ns = post_ns;
+			total_ns += post_ns;
+		}
+
+		if ((count++ & 0x3fff) == 0)
+			schedule();
+
+		if (READ_ONCE(halt_test) == 1)
+			break;
+	}
+
+	kunit_info(tr->test, "end thread %03lu: wrote=%lu min_ns=%llu avg_ns=%llu max_ns=%llu\n",
+		   tr->num, count, min_ns, total_ns / (u64)count, max_ns);
+
+	tr->runstate = 2;
+
+	return 0;
+}
+
+static int prbtest_reader(void *data)
+{
+	struct test_running *tr = data;
+	char text_buf[MAX_RECORD_SIZE];
+	unsigned long total_lost = 0;
+	unsigned long max_lost = 0;
+	unsigned long count = 0;
+	struct printk_info info;
+	struct printk_record r;
+	int did_sched = 1;
+	u64 seq = 0;
+
+	set_cpus_allowed_ptr(current, cpumask_of(tr->num));
+
+	prb_rec_init_rd(&r, &info, &text_buf[0], sizeof(text_buf));
+
+	kunit_info(tr->test, "start thread %03lu (reader)\n", tr->num);
+
+	tr->runstate = 1;
+
+	while (!wait_event_interruptible(test_wait,
+				kthread_should_stop() ||
+				prb_read_valid(&test_rb, seq, &r))) {
+		bool error = false;
+
+		if (kthread_should_stop())
+			break;
+		/* check/track the sequence */
+		if (info.seq < seq) {
+			KUNIT_FAIL(tr->test, "BAD SEQ READ: request=%llu read=%llu\n",
+				   seq, info.seq);
+			error = true;
+		} else if (info.seq != seq && !did_sched) {
+			total_lost += info.seq - seq;
+			if (max_lost < info.seq - seq)
+				max_lost = info.seq - seq;
+		}
+
+		if (!check_data((struct rbdata *)&r.text_buf[0])) {
+			fail_record(tr->test, (struct rbdata *)&r.text_buf[0], info.seq);
+			error = true;
+		}
+
+		if (error)
+			WRITE_ONCE(halt_test, 1);
+
+		did_sched = 0;
+		if ((count++ & 0x3fff) == 0) {
+			did_sched = 1;
+			schedule();
+		}
+
+		if (READ_ONCE(halt_test) == 1)
+			break;
+
+		seq = info.seq + 1;
+	}
+
+	kunit_info(tr->test,
+		   "end thread %03lu: read=%lu seq=%llu total_lost=%lu max_lost=%lu\n",
+		   tr->num, count, info.seq, total_lost, max_lost);
+
+	while (!kthread_should_stop())
+		msleep(1000);
+	tr->runstate = 2;
+
+	return 0;
+}
+
+static int module_test_running;
+static struct task_struct *reader_thread;
+
+static int start_test(void *arg)
+{
+	struct kunit *test = arg;
+	struct task_struct *thread;
+	unsigned long i;
+	int num_cpus;
+
+	num_cpus = num_online_cpus();
+	if (num_cpus == 1)
+		kunit_skip(test, "need >1 CPUs for at least one reader and writer");
+
+	test_running = kcalloc(num_cpus, sizeof(*test_running), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, test_running);
+
+	module_test_running = 1;
+
+	kunit_info(test, "starting test\n");
+
+	for (i = 0; i < num_cpus; i++) {
+		test_running[i].test = test;
+		test_running[i].num = i;
+		if (i < num_cpus - 1) {
+			thread = kthread_run(prbtest_writer, &test_running[i],
+					     "prbtest writer");
+		} else {
+			thread = kthread_run(prbtest_reader, &test_running[i],
+					     "prbtest reader");
+			reader_thread = thread;
+		}
+		if (IS_ERR(thread)) {
+			kunit_err(test, "unable to create thread %lu\n", i);
+			test_running[i].runstate = 2;
+		}
+	}
+
+	/* wait until all threads finish */
+	for (;;) {
+		msleep(1000);
+
+		for (i = 0; i < num_cpus; i++) {
+			if (test_running[i].runstate < 2)
+				break;
+		}
+		if (i == num_cpus)
+			break;
+	}
+
+	kunit_info(test, "completed test\n");
+
+	module_test_running = 0;
+
+	return 0;
+}
+
+static void test_readerwriter(struct kunit *test)
+{
+	static bool already_run;
+	int num_cpus;
+	int i;
+
+	if (already_run)
+		KUNIT_FAIL_AND_ABORT(test, "test can only be run once");
+	already_run = true;
+
+	kunit_info(test, "running for %lu ms\n", runtime_ms);
+
+	kthread_run(start_test, test, "prbtest");
+
+	/* wait until all threads active */
+	num_cpus = num_online_cpus();
+	for (;;) {
+		msleep(1000);
+
+		for (i = 0; i < num_cpus; i++) {
+			if (test_running[i].runstate == 0)
+				break;
+		}
+		if (i == num_cpus)
+			break;
+	}
+
+	msleep(runtime_ms);
+
+	if (reader_thread && !IS_ERR(reader_thread))
+		kthread_stop(reader_thread);
+
+	WRITE_ONCE(halt_test, 1);
+
+	while (module_test_running)
+		msleep(1000);
+	kfree(test_running);
+}
+
+static struct kunit_case prb_test_cases[] = {
+	KUNIT_CASE_SLOW(test_readerwriter),
+	{}
+};
+
+static struct kunit_suite prb_test_suite = {
+	.name       = "printk-ringbuffer",
+	.test_cases = prb_test_cases,
+};
+kunit_test_suite(prb_test_suite);
+
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+MODULE_AUTHOR("John Ogness <john.ogness@linutronix.de>");
+MODULE_DESCRIPTION("printk_ringbuffer test");
+MODULE_LICENSE("GPL");

base-commit: 4022ef25504db2fb79a2acac0afe9bac934f8dd6
-- 
2.39.5


