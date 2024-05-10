Return-Path: <linux-kselftest+bounces-10015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3218C2644
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 16:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5701F21230
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 14:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E87017107F;
	Fri, 10 May 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xtdA59GQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48682170891
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349894; cv=none; b=rJmO9Opvxb8OW7NEjHvlJyadOk1Rk6r21crPNbK6lK5rFFuuW3enxFBSJbJbqLeaylO37bm9eJm8kEAWdpuDjSCDP8v1ad95ctFMuKOPRdzwMjRm3q/Tpj43iDJWOQFwHOxYEgUIKpX1r1ZiCkM3RV7/9rf0C87Rpdz9zNMVhkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349894; c=relaxed/simple;
	bh=MujKHSIgrtbfnILllwPdQKMT44DlKLJIWOTHYzn8uDs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jRM/qLiHeGoTDBIx8VNSit9nfzzu9EFQ3o4wt8ZCD5qQMKlYgvnPgUrZJbzW28ZE71+sGul224u+98M/tHhAxqxhA2GJkwBTkmhPtIet9sXLXTqRYkwHBXQHh2sPjuFShdkpaSuiV9knyT7GKH/Crw05GXUdMIjXx70qNKSu9+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xtdA59GQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de6054876efso3795801276.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 07:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715349891; x=1715954691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqGAkxZ2nlObBbg1zcUbRHzr41ahfYKK7MnBlN0GD4M=;
        b=xtdA59GQIeHgVhsq2mULO+XNoMWIKcdDtq5WRw5NL45LIn7HcM5/RE7CAUxCH7fkAp
         8OeJVW9Y/rxTaDvAYR9mJ/Z8kE+hQEQl/plMIZue6Ye3U6+wOd7VEJ1m/764fdey+eU1
         ZgEQCR+ribXldx36kIzmOmV6PLSd65SWOmqurLVr3FR7TjNqLQEP6lzDq9UQBe6t9rSQ
         pGJicnfoTbfYqH7lOzXVEBzROCZ+e5FlnKTdHX2hzf1VD9nmZDXpFyFeypDjeyQJYt3W
         sn6AudUpCMcokFZnfg1Y02ADm4Tg1UhHzXEtbUKUh7CiZMtbKBPL0BMGbh8ZfrbHSFhK
         YX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715349891; x=1715954691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqGAkxZ2nlObBbg1zcUbRHzr41ahfYKK7MnBlN0GD4M=;
        b=HE75IbS06Qkn8xdjN2a21YCe1O2YxWnqpC0eT1wfAv2p5FnkUWmWMXnwihNCOR75a1
         eMp15z4IQN3obDpELKD06SlZEq/AAit5JN+aUdDETP+XqqZ2H192dSWy9cEEgV/Yub/e
         oXPnt93Y9rIk+Kcki3nzOTQXQG5MRzY12UNl565S+h8KUBzdCqLzH4nD/fqEMtH1eq3y
         bvNh2IBYvxY7fmSJ15y2Jyf+0LKM8cSUruig7z/hJr2VlWviGSVcJaqvHvkwZeeUrB8N
         xZNP4nnTU9q3Fh0bGvgPWkODViI3ichVmT1wiZt/BS+p1NP6Z0XJOlUsl/0O/pJaIsow
         ATUg==
X-Forwarded-Encrypted: i=1; AJvYcCVAaXfpnu+7H2/3jSAFCst6Cy4bVGDv69Mf8X+PZdKMkHqIHJYa/9RcbVC8B945kUfnSFKfwMC8qzilW4ogNHDi613t2M29PEA6VUs9D9Zx
X-Gm-Message-State: AOJu0Ywj/tJn6p8xQe7vzJKV/tk4mWaFUDMYDW/bOPp0w1FC0J8vfvoW
	eLQZ+clyB9Yzs261CsAVFjJhLojquM5lv3cC3SqZzplHo2RyhcGqXVydd83h7IOlU9Ui90mEMbA
	Xn0AzjlfXHa/AScJjPw==
X-Google-Smtp-Source: AGHT+IEUi4zAkqNjNK2wzXjW69LP86lTmd/9lM8Z+VAACdWihhq8AzJAza9Qh8dAa37QGKfJaRJO+/gMxHaLD1p1
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:c10:b0:de6:1301:600a with SMTP
 id 3f1490d57ef6-dee4f374414mr680985276.9.1715349891275; Fri, 10 May 2024
 07:04:51 -0700 (PDT)
Date: Fri, 10 May 2024 15:04:34 +0100
In-Reply-To: <20240510140435.3550353-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510140435.3550353-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510140435.3550353-6-vdonnefort@google.com>
Subject: [PATCH v23 5/5] ring-buffer/selftest: Add ring-buffer mapping test
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com, 
	Vincent Donnefort <vdonnefort@google.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Map a ring-buffer, validate the meta-page before and after emitting few
events. Also check ring-buffer mapping boundaries and finally ensure the
tracing snapshot is mutually exclusive.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Acked-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ring-buffer/.gitignore b/tools/testing/selftests/ring-buffer/.gitignore
new file mode 100644
index 000000000000..3aed1a2a6c67
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/.gitignore
@@ -0,0 +1 @@
+map_test
diff --git a/tools/testing/selftests/ring-buffer/Makefile b/tools/testing/selftests/ring-buffer/Makefile
new file mode 100644
index 000000000000..627c5fa6d1ab
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -Wl,-no-as-needed -Wall
+CFLAGS += $(KHDR_INCLUDES)
+CFLAGS += -D_GNU_SOURCE
+
+TEST_GEN_PROGS = map_test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/ring-buffer/config b/tools/testing/selftests/ring-buffer/config
new file mode 100644
index 000000000000..d936f8f00e78
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/config
@@ -0,0 +1,2 @@
+CONFIG_FTRACE=y
+CONFIG_TRACER_SNAPSHOT=y
diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
new file mode 100644
index 000000000000..a9006fa7097e
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ring-buffer memory mapping tests
+ *
+ * Copyright (c) 2024 Vincent Donnefort <vdonnefort@google.com>
+ */
+#include <fcntl.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <linux/trace_mmap.h>
+
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+
+#include "../user_events/user_events_selftests.h" /* share tracefs setup */
+#include "../kselftest_harness.h"
+
+#define TRACEFS_ROOT "/sys/kernel/tracing"
+
+static int __tracefs_write(const char *path, const char *value)
+{
+	int fd, ret;
+
+	fd = open(path, O_WRONLY | O_TRUNC);
+	if (fd < 0)
+		return fd;
+
+	ret = write(fd, value, strlen(value));
+
+	close(fd);
+
+	return ret == -1 ? -errno : 0;
+}
+
+static int __tracefs_write_int(const char *path, int value)
+{
+	char *str;
+	int ret;
+
+	if (asprintf(&str, "%d", value) < 0)
+		return -1;
+
+	ret = __tracefs_write(path, str);
+
+	free(str);
+
+	return ret;
+}
+
+#define tracefs_write_int(path, value) \
+	ASSERT_EQ(__tracefs_write_int((path), (value)), 0)
+
+#define tracefs_write(path, value) \
+	ASSERT_EQ(__tracefs_write((path), (value)), 0)
+
+static int tracefs_reset(void)
+{
+	if (__tracefs_write_int(TRACEFS_ROOT"/tracing_on", 0))
+		return -1;
+	if (__tracefs_write(TRACEFS_ROOT"/trace", ""))
+		return -1;
+	if (__tracefs_write(TRACEFS_ROOT"/set_event", ""))
+		return -1;
+	if (__tracefs_write(TRACEFS_ROOT"/current_tracer", "nop"))
+		return -1;
+
+	return 0;
+}
+
+struct tracefs_cpu_map_desc {
+	struct trace_buffer_meta	*meta;
+	int				cpu_fd;
+};
+
+int tracefs_cpu_map(struct tracefs_cpu_map_desc *desc, int cpu)
+{
+	int page_size = getpagesize();
+	char *cpu_path;
+	void *map;
+
+	if (asprintf(&cpu_path,
+		     TRACEFS_ROOT"/per_cpu/cpu%d/trace_pipe_raw",
+		     cpu) < 0)
+		return -ENOMEM;
+
+	desc->cpu_fd = open(cpu_path, O_RDONLY | O_NONBLOCK);
+	free(cpu_path);
+	if (desc->cpu_fd < 0)
+		return -ENODEV;
+
+	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
+	if (map == MAP_FAILED)
+		return -errno;
+
+	desc->meta = (struct trace_buffer_meta *)map;
+
+	return 0;
+}
+
+void tracefs_cpu_unmap(struct tracefs_cpu_map_desc *desc)
+{
+	munmap(desc->meta, desc->meta->meta_page_size);
+	close(desc->cpu_fd);
+}
+
+FIXTURE(map) {
+	struct tracefs_cpu_map_desc	map_desc;
+	bool				umount;
+};
+
+FIXTURE_VARIANT(map) {
+	int	subbuf_size;
+};
+
+FIXTURE_VARIANT_ADD(map, subbuf_size_4k) {
+	.subbuf_size = 4,
+};
+
+FIXTURE_VARIANT_ADD(map, subbuf_size_8k) {
+	.subbuf_size = 8,
+};
+
+FIXTURE_SETUP(map)
+{
+	int cpu = sched_getcpu();
+	cpu_set_t cpu_mask;
+	bool fail, umount;
+	char *message;
+
+	if (getuid() != 0)
+		SKIP(return, "Skipping: %s", "Please run the test as root");
+
+	if (!tracefs_enabled(&message, &fail, &umount)) {
+		if (fail) {
+			TH_LOG("Tracefs setup failed: %s", message);
+			ASSERT_FALSE(fail);
+		}
+		SKIP(return, "Skipping: %s", message);
+	}
+
+	self->umount = umount;
+
+	ASSERT_GE(cpu, 0);
+
+	ASSERT_EQ(tracefs_reset(), 0);
+
+	tracefs_write_int(TRACEFS_ROOT"/buffer_subbuf_size_kb", variant->subbuf_size);
+
+	ASSERT_EQ(tracefs_cpu_map(&self->map_desc, cpu), 0);
+
+	/*
+	 * Ensure generated events will be found on this very same ring-buffer.
+	 */
+	CPU_ZERO(&cpu_mask);
+	CPU_SET(cpu, &cpu_mask);
+	ASSERT_EQ(sched_setaffinity(0, sizeof(cpu_mask), &cpu_mask), 0);
+}
+
+FIXTURE_TEARDOWN(map)
+{
+	tracefs_reset();
+
+	if (self->umount)
+		tracefs_unmount();
+
+	tracefs_cpu_unmap(&self->map_desc);
+}
+
+TEST_F(map, meta_page_check)
+{
+	struct tracefs_cpu_map_desc *desc = &self->map_desc;
+	int cnt = 0;
+
+	ASSERT_EQ(desc->meta->entries, 0);
+	ASSERT_EQ(desc->meta->overrun, 0);
+	ASSERT_EQ(desc->meta->read, 0);
+
+	ASSERT_EQ(desc->meta->reader.id, 0);
+	ASSERT_EQ(desc->meta->reader.read, 0);
+
+	ASSERT_EQ(ioctl(desc->cpu_fd, TRACE_MMAP_IOCTL_GET_READER), 0);
+	ASSERT_EQ(desc->meta->reader.id, 0);
+
+	tracefs_write_int(TRACEFS_ROOT"/tracing_on", 1);
+	for (int i = 0; i < 16; i++)
+		tracefs_write_int(TRACEFS_ROOT"/trace_marker", i);
+again:
+	ASSERT_EQ(ioctl(desc->cpu_fd, TRACE_MMAP_IOCTL_GET_READER), 0);
+
+	ASSERT_EQ(desc->meta->entries, 16);
+	ASSERT_EQ(desc->meta->overrun, 0);
+	ASSERT_EQ(desc->meta->read, 16);
+
+	ASSERT_EQ(desc->meta->reader.id, 1);
+
+	if (!(cnt++))
+		goto again;
+}
+
+TEST_F(map, data_mmap)
+{
+	struct tracefs_cpu_map_desc *desc = &self->map_desc;
+	unsigned long meta_len, data_len;
+	void *data;
+
+	meta_len = desc->meta->meta_page_size;
+	data_len = desc->meta->subbuf_size * desc->meta->nr_subbufs;
+
+	/* Map all the available subbufs */
+	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
+		    desc->cpu_fd, meta_len);
+	ASSERT_NE(data, MAP_FAILED);
+	munmap(data, data_len);
+
+	/* Map all the available subbufs - 1 */
+	data_len -= desc->meta->subbuf_size;
+	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
+		    desc->cpu_fd, meta_len);
+	ASSERT_NE(data, MAP_FAILED);
+	munmap(data, data_len);
+
+	/* Overflow the available subbufs by 1 */
+	meta_len += desc->meta->subbuf_size * 2;
+	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
+		    desc->cpu_fd, meta_len);
+	ASSERT_EQ(data, MAP_FAILED);
+}
+
+FIXTURE(snapshot) {
+	bool	umount;
+};
+
+FIXTURE_SETUP(snapshot)
+{
+	bool fail, umount;
+	struct stat sb;
+	char *message;
+
+	if (getuid() != 0)
+		SKIP(return, "Skipping: %s", "Please run the test as root");
+
+	if (stat(TRACEFS_ROOT"/snapshot", &sb))
+		SKIP(return, "Skipping: %s", "snapshot not available");
+
+	if (!tracefs_enabled(&message, &fail, &umount)) {
+		if (fail) {
+			TH_LOG("Tracefs setup failed: %s", message);
+			ASSERT_FALSE(fail);
+		}
+		SKIP(return, "Skipping: %s", message);
+	}
+
+	self->umount = umount;
+}
+
+FIXTURE_TEARDOWN(snapshot)
+{
+	__tracefs_write(TRACEFS_ROOT"/events/sched/sched_switch/trigger",
+			"!snapshot");
+	tracefs_reset();
+
+	if (self->umount)
+		tracefs_unmount();
+}
+
+TEST_F(snapshot, excludes_map)
+{
+	struct tracefs_cpu_map_desc map_desc;
+	int cpu = sched_getcpu();
+
+	ASSERT_GE(cpu, 0);
+	tracefs_write(TRACEFS_ROOT"/events/sched/sched_switch/trigger",
+		      "snapshot");
+	ASSERT_EQ(tracefs_cpu_map(&map_desc, cpu), -EBUSY);
+}
+
+TEST_F(snapshot, excluded_by_map)
+{
+	struct tracefs_cpu_map_desc map_desc;
+	int cpu = sched_getcpu();
+
+	ASSERT_EQ(tracefs_cpu_map(&map_desc, cpu), 0);
+
+	ASSERT_EQ(__tracefs_write(TRACEFS_ROOT"/events/sched/sched_switch/trigger",
+				  "snapshot"), -EBUSY);
+	ASSERT_EQ(__tracefs_write(TRACEFS_ROOT"/snapshot",
+				  "1"), -EBUSY);
+}
+
+TEST_HARNESS_MAIN
-- 
2.45.0.118.g7fe29c98d7-goog


