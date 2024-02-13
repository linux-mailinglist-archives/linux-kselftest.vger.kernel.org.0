Return-Path: <linux-kselftest+bounces-4548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C8D852FDB
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 12:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CA11F21513
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 11:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1996A4F5FA;
	Tue, 13 Feb 2024 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rIMT3LUm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E944CDE1
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825066; cv=none; b=flYyWyqH2VjzInBpXyOXteuLXzRMf+84/ZeGHYRP4FB6gB3s0Yc+tipLqoUHQC9oNiLSTZA1FBkHLOfy7KLob0FORbLeKDr+C1/K3eLpB5pVR2+7baL8aqzgQBooc8F4kKyzt4/f6pmhlXyDcGm3UVF3Ohaf6+9Y7YlIr0MSZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825066; c=relaxed/simple;
	bh=yF4snXCigsdD2V4iu9JXl93VeJuVdieGXDlgLcIwa4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g0QJjq6u4ji0dfSb59Eyp5lRo4lIotSThYC0AJK1RDeInD972t5O/mYfkf0xFb4ynGAIl36E9SCvV633/ce3jJNmi6iiMYF1yxXL0Ho80yg4yj6dOYulPSMXu7qK2QWOJlMmz90pzc6wTD0+byXIK1d4x/od1F4RcCN00WIbmnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rIMT3LUm; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-411c650ec25so1861625e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 03:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707825062; x=1708429862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMbQC9Qrfc/CHbT/uyUQA9ufo0litTV7XPwdOdKcRAI=;
        b=rIMT3LUmgu5EPtNstV3CacK8gf/2cFhDNJ4l4buXH8zHygIVsxzW46JOfQLTMNeASn
         mRJXl8RX8Xx99+knDAFtGVkB/HvFtx0DesqRboqmO21AiK6Wdj15E+W2MgwmFXt/g7mo
         XVFr67cgw4GguR2CUTGQNOwEm5m+fArjjzun7TSmrgaEb/DUVhGK77lN65vbxVlH+byB
         P0MIqS+WTv9KTYI8YO1Tbg9f8QXCGz5cMrpzgdwOC7l9/4dLyQ5+mB4s2uYKWcLaJjPc
         D77Efp0R2HqiHOtunA5/yqAUHBFcNUE50IoH6V1NNX5ehmvJnxOQbVLLbu585mrPaXVV
         aXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707825062; x=1708429862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMbQC9Qrfc/CHbT/uyUQA9ufo0litTV7XPwdOdKcRAI=;
        b=m6ZTsOoBYCk/PU6uhU5J4EgmapvK8xHI27254oI4Lc1cZ+tCwsyLb+paRQObHlRWxY
         g+MBlr0hI5QYV1z4QMa/oV+Lq3uSI8x2+9cH92Be+Lfh8PsiAvmlOUNDWki8cw8nGW9f
         JS6CmERy0R6zGeAtYNKhr8efh4YUz6DW5lVae3NOmnG013hJWuoYiZmGkAPq3Q5/1N5n
         KdauCeytBVIS1HEuj5YAmVoh+DBESvrOAIQ4DpSYzHMbg1xsB0hMNupOMUg5dNb0Fc5F
         YMGsvDRt/oAqdyubx2BrdzrTMD5AAnvkh3qBwoaJOz3jIueVO/cP5iiEaO1QwafRSb4F
         yBAQ==
X-Gm-Message-State: AOJu0YzObDgDovWhErq51U05SeukfTGAgC5kplbZMTZFPrc94E0y/641
	fzlpY7HB1cIp2gk5IkZpqihxDJx8GiwRkviCArhLUBZy5Tbdlouq3bmCX51sQUAmMF4H+/0Z+hs
	qPh56Mt48+LsvKAgP3g==
X-Google-Smtp-Source: AGHT+IHMpTEZmMMgHGFaYL8F6tI2hlVwTNkExlXpra2OxGyAQEIA6Ysj/qPVwo25XRtw0RJgsv+A5W+TTeoPZvQG
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:3d16:b0:411:c736:3a17 with
 SMTP id bh22-20020a05600c3d1600b00411c7363a17mr2807wmb.3.1707825062624; Tue,
 13 Feb 2024 03:51:02 -0800 (PST)
Date: Tue, 13 Feb 2024 11:49:45 +0000
In-Reply-To: <20240213114945.3528801-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213114945.3528801-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213114945.3528801-7-vdonnefort@google.com>
Subject: [PATCH v17 6/6] ring-buffer/selftest: Add ring-buffer mapping test
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
index 000000000000..d936f8f00e78
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/config
@@ -0,0 +1,2 @@
+CONFIG_FTRACE=y
+CONFIG_TRACER_SNAPSHOT=y
diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
new file mode 100644
index 000000000000..56c44b29d998
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -0,0 +1,273 @@
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
+	void				*data;
+	int				cpu_fd;
+};
+
+int tracefs_cpu_map(struct tracefs_cpu_map_desc *desc, int cpu)
+{
+	unsigned long meta_len, data_len;
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
+	meta_len = desc->meta->meta_page_size;
+	data_len = desc->meta->subbuf_size * desc->meta->nr_subbufs;
+
+	map = mmap(NULL, data_len, PROT_READ, MAP_SHARED, desc->cpu_fd, meta_len);
+	if (map == MAP_FAILED) {
+		munmap(desc->meta, desc->meta->meta_page_size);
+		return -EINVAL;
+	}
+
+	desc->data = map;
+
+	return 0;
+}
+
+void tracefs_cpu_unmap(struct tracefs_cpu_map_desc *desc)
+{
+	munmap(desc->data, desc->meta->subbuf_size * desc->meta->nr_subbufs);
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
2.43.0.687.g38aa6559b0-goog


