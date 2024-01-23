Return-Path: <linux-kselftest+bounces-3401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4FC838CF6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 12:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED22289B08
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 11:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F475EE74;
	Tue, 23 Jan 2024 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="21Y1a1Hg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C7D5DF3F
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008098; cv=none; b=ESJl8rgLTyPvnv7dl1GikSjOFzjwK6Q16tJrmA8jJM2Vec3pz0WMWCgGO/doNx8o9zbBmgWuvJVhZbPqs6WocsBP+R3QD3uARRfiDgmSjmWUPE8CIzWfGkrfRUd7fa8UWY+rYcBiyeQzuJYHl3odu9vChPhTnWAk9NTGVKKXpvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008098; c=relaxed/simple;
	bh=jzpwCo0HMVI99saI3KiX/DjK1lxlN166EymbCtXFVp8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DuSS/y3feCn+tc2Bq6ZTq7XeWEZYAoOff3ztLQTahv6HSCXH5EwcEpbuUn2qhilAW8pPrIRv1SSlfOQp1LMViZiwVUSaWoFY0MwIEOJYZOMMMcBQkApzFKmtO+X0ibk2uIYTFEzwk6j5SgxdzgGpv8H1nJZ+uog67RY1pQJuayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=21Y1a1Hg; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40e9d6a364eso34663735e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 03:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706008095; x=1706612895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=on32GNvkxWDILvYMfSVIpQ/Zr8fKHLMLlVw8UqZ+BYg=;
        b=21Y1a1HgqV17XDk72W8zaiQUgFOpz+A3umWCn6OacqzZ/FZgortPr4j30Gf+isxEfW
         +KSZSVeYFt6Ha69275CbVHA6s97JnciucZciv7lyhjfTt4LaXAbfwsj3EVV4r+KWgIiT
         HTSmNka/4NKIVB5b6vSgF/27Vie6QhFl6xkQtzV81T6iTx0+EthCA3WYGhNReiOHfQAY
         y1XCNYPukpRu0AI7NvaGLQZjsP8SqXGFF2lq0/BmZIDHmceyE7JwGirmmZAB8kBb4IFX
         gGN58ITwZB0UAOSlTUxZRG1Zz29S58OdfdFoLAc57ko0dBDjl0KOCTqKRjPgaIK+FjGd
         f11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706008095; x=1706612895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=on32GNvkxWDILvYMfSVIpQ/Zr8fKHLMLlVw8UqZ+BYg=;
        b=ayiwE9sgMT+x5xKLLydiWmvQmqnQ/mWAjyXhsQydmL41VO/TqvOx17XiiZ5O3EuD6x
         5DynEztsvm3oySH2HaFOIe8Cqas/yvfWyPQKu2wMUqqqEHsIZeRCE7SqHIoZjlTIR84D
         EqoZpqt1Z+zUCXVvrV4Y3TmpUrB9YG6NE2TWPpQWPeRP6yjuUSPxMMMqIOkJ6LxC3TJO
         aops+Q2YnbV+HLp8tMUAO+Rt/F7vmMxQoLsDkQsl0N2+V3/MSIKOC82pMx8QhfdtAr4O
         48X/vvoyne1cUbuVYmpAwbENgR6XAlpR/Ke+BrliUjorV5AM4RwKSyHoPRuu50SvlcIj
         hUVg==
X-Gm-Message-State: AOJu0YwRsNehBen5mYJa7EcL++B5fwTWyS4sh9gkPtJ2D+YUczma/9p0
	7JJBurHm8FuLr81t5W0+MYulnYS+Nc2L2EmI5o+cL+6RYrOPPY59yC8We7BF9dk+wm13yCPsAYt
	uxgfDuIlabXFG1PPvww==
X-Google-Smtp-Source: AGHT+IFczxSO95adCCP1/OQdMVdXuAbrhocNenUfZEJQ6Y/inr3mrpYKphpQLoisODALT2LTe4UZKmi4jxqxDWFY
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:5104:b0:40d:8587:3399 with
 SMTP id o4-20020a05600c510400b0040d85873399mr13616wms.6.1706008095318; Tue,
 23 Jan 2024 03:08:15 -0800 (PST)
Date: Tue, 23 Jan 2024 11:07:57 +0000
In-Reply-To: <20240123110757.3657908-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123110757.3657908-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123110757.3657908-7-vdonnefort@google.com>
Subject: [PATCH v12 6/6] ring-buffer/selftest: Add ring-buffer mapping test
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
index 000000000000..ec891e956b83
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -0,0 +1,188 @@
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
+	ASSERT_EQ(self->meta->subbufs_touched, 0);
+	ASSERT_EQ(self->meta->subbufs_lost, 0);
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
+	/* subbufs_touched doesn't take into account the commit page */
+	ASSERT_EQ(self->meta->subbufs_touched, 0);
+	ASSERT_EQ(self->meta->subbufs_lost, 0);
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


