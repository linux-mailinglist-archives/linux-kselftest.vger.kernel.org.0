Return-Path: <linux-kselftest+bounces-3690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A71584084D
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 15:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61F21F26012
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04E912CD8B;
	Mon, 29 Jan 2024 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AnjEfbgE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A6112C54B
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538507; cv=none; b=JbmEa0JUA1YsvlkEIqXepvoSbbrjp9t+x4IQCOy1+wsadA1ZvyKGt7U9YcmikhZX10fGnyRCTXIN0I1nOCv+tnL+zZUKwyuHixwnOUryLkT/TDH105R+01bt/V2RVwFcfSbCyjxPfrFbqUS/YdMt61E1JxV7KOyz4r1TdlxfS1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538507; c=relaxed/simple;
	bh=3esjCeT5ERj+IquIYdRX9jRIVPfXD/PfIosNKFpR5DM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RU01XOzOZ/ixRnCP8LtbW/ghTr/C0wOpMuvBYc3BuDtkk8f/E59euy6q/inXhKQTPlSUanQBpxI3/1dNZL2xa/o0/1C5eYA1R4EhvFbD94cM3mZmnGhT5kfiImme0P/c7zadhqU6tn1hnnGZY09iFEABXoQxmCrYk1geS1d8D7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AnjEfbgE; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40ef9dea0d1so3986695e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 06:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706538504; x=1707143304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rnsou9fzvhKkj/SAVsoOVdFIhdcGr/3PZjija/s4rd4=;
        b=AnjEfbgE1cDL5V6ICp19J8sEyNlku8X9iy5XnpuOe+EgrSyyge4o8ONw7LzzGsIk5V
         eKELiQ+VRyVksLyd4h/+SXYoOHInwy1iA/Unc2Z+cva895sdPjTOZLteIShb5VZ0Iuyk
         N26V1QIYKKVG6Qwdhs1CXk9B9SkKbhxRWYzDX/27bQOjrrQP92PT5wrWttUz3shj+wrt
         DmjWoCqRxAmPKy9dBvh3mRd7KAhYTayFpOKhHjhgXZxCrmzvtN26fejOkCkdXGwu1ER3
         eq1ZcIpjrufhDBXi3gfoVjYIpV59Dpcc+azCyEkpKHlLz7NUo2/Ghe2PqcGUIkjOtwL/
         YT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706538504; x=1707143304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rnsou9fzvhKkj/SAVsoOVdFIhdcGr/3PZjija/s4rd4=;
        b=Vem8fh6SI1s3dAGPNskHmOKbZeAU+5WkqLAq01m3Po2WpmOoW61FqWHTlDXxoAlx3Z
         3th8iy9zrVncNxdiXRYXMmz5t4mABHJSI8LQAcRBRG0OpR5/NHzJ8ve5BzIpM5ZmN5gy
         KbsBSxGtzPmJ3j24ZmT5kFQcwaju/dKDd1vB6QBTbqRrklFwIFpiuiRNl4dVhrdGBQmb
         fm3OPJGniLeHhbt9OH/B/jfu3oay99uUjY/BV4XQuFFNoD3rcFmITsCub9ZUVSX5bZN9
         1XGoywKenUtuB1b9sG7QqK7MUmVfqv52fsa5E/2m5bBadIj6yQTQfh7yV8drpa+gO3tR
         nlig==
X-Gm-Message-State: AOJu0YwbWI7SVl7YqqFlpwD3ku4ueY/YbFfZqOReTeSs9InIImFDGusw
	h9fiOE2VRpCAEpbCWfDKwoNvlnpI9TUB1LRChlmTHYBV9qikRoO4wjpZeozUIRve5UQEqSvnPCU
	IIeqtLEfAQZiJvyRPTA==
X-Google-Smtp-Source: AGHT+IGx7DP60QtcsbCWUqr1PnCe7KJb78BQjJE9iJWws6DSj1EVHOXvN6+ePGcnL5EmhamqDZLilursJ8RGvXc0
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:1f0c:b0:40e:fb3a:d85e with
 SMTP id bd12-20020a05600c1f0c00b0040efb3ad85emr3588wmb.5.1706538504423; Mon,
 29 Jan 2024 06:28:24 -0800 (PST)
Date: Mon, 29 Jan 2024 14:28:02 +0000
In-Reply-To: <20240129142802.2145305-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129142802.2145305-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129142802.2145305-7-vdonnefort@google.com>
Subject: [PATCH v13 6/6] ring-buffer/selftest: Add ring-buffer mapping test
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This test maps a ring-buffer and validate the meta-page after reset and
after emitting few events.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

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
index 000000000000..ef8214661612
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/config
@@ -0,0 +1 @@
+CONFIG_FTRACE=y
diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
new file mode 100644
index 000000000000..e3220f8d618b
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -0,0 +1,183 @@
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
+	FILE *file;
+
+	file = fopen(path, "w");
+	if (!file)
+		return -1;
+
+	fputs(value, file);
+	fclose(file);
+
+	return 0;
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
+static int tracefs_reset(void)
+{
+	if (__tracefs_write_int(TRACEFS_ROOT"/tracing_on", 0))
+		return -1;
+	if (__tracefs_write_int(TRACEFS_ROOT"/trace", 0))
+		return -1;
+	if (__tracefs_write(TRACEFS_ROOT"/set_event", ""))
+		return -1;
+	if (__tracefs_write(TRACEFS_ROOT"/current_tracer", "nop"))
+		return -1;
+
+	return 0;
+}
+
+FIXTURE(map) {
+	struct trace_buffer_meta	*meta;
+	void				*data;
+	int				cpu_fd;
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
+	int cpu = sched_getcpu(), page_size = getpagesize();
+	unsigned long meta_len, data_len;
+	char *cpu_path, *message;
+	bool fail, umount;
+	cpu_set_t cpu_mask;
+	void *map;
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
+	ASSERT_GE(asprintf(&cpu_path,
+			   TRACEFS_ROOT"/per_cpu/cpu%d/trace_pipe_raw",
+			   cpu), 0);
+
+	self->cpu_fd = open(cpu_path, O_RDONLY | O_NONBLOCK);
+	ASSERT_GE(self->cpu_fd, 0);
+	free(cpu_path);
+
+	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, self->cpu_fd, 0);
+	ASSERT_NE(map, MAP_FAILED);
+	self->meta = (struct trace_buffer_meta *)map;
+
+	meta_len = self->meta->meta_page_size;
+	data_len = self->meta->subbuf_size * self->meta->nr_subbufs;
+
+	map = mmap(NULL, data_len, PROT_READ, MAP_SHARED, self->cpu_fd, meta_len);
+	ASSERT_NE(map, MAP_FAILED);
+	self->data = map;
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
+	munmap(self->data, self->meta->subbuf_size * self->meta->nr_subbufs);
+	munmap(self->meta, self->meta->meta_page_size);
+	close(self->cpu_fd);
+}
+
+TEST_F(map, meta_page_check)
+{
+	int cnt = 0;
+
+	ASSERT_EQ(self->meta->entries, 0);
+	ASSERT_EQ(self->meta->overrun, 0);
+	ASSERT_EQ(self->meta->read, 0);
+
+	ASSERT_EQ(self->meta->reader.id, 0);
+	ASSERT_EQ(self->meta->reader.read, 0);
+
+	ASSERT_EQ(ioctl(self->cpu_fd, TRACE_MMAP_IOCTL_GET_READER), 0);
+	ASSERT_EQ(self->meta->reader.id, 0);
+
+	tracefs_write_int(TRACEFS_ROOT"/tracing_on", 1);
+	for (int i = 0; i < 16; i++)
+		tracefs_write_int(TRACEFS_ROOT"/trace_marker", i);
+again:
+	ASSERT_EQ(ioctl(self->cpu_fd, TRACE_MMAP_IOCTL_GET_READER), 0);
+
+	ASSERT_EQ(self->meta->entries, 16);
+	ASSERT_EQ(self->meta->overrun, 0);
+	ASSERT_EQ(self->meta->read, 16);
+
+	ASSERT_EQ(self->meta->reader.id, 1);
+
+	if (!(cnt++))
+		goto again;
+}
+
+TEST_HARNESS_MAIN
-- 
2.43.0.429.g432eaa2c6b-goog


