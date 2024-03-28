Return-Path: <linux-kselftest+bounces-6614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E90388BEE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 11:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D648529DF5F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 10:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA5570CC7;
	Tue, 26 Mar 2024 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BwNWZq+l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EAC6E61B
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447731; cv=none; b=fd7MceLupETSWbdl4UEx60wljQrfqAhEVA/0maHhpmLPnig1RDbwH+6db7wRtTRiFbqTMaLADkpISLAuNC0GQwwT57CksEoQtd07q+pdX7mbt1gb8rakdYS76wUwJhV8mgtdtYGt8YRSeNL4QOEfyaO0n8dwGPsXPTUOHQX9weA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447731; c=relaxed/simple;
	bh=X4fNxkqHrvNilL5EJi7n4AWaFPh2JTq2Sk7Rj6AwTU4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oqoLzucXSeRx9QoHgycn2jXGT5Da1G+2W133U9MRoRCtwMxIG8ZQfBi+OSpPR8sfxSVNzsPfzCto6vfBoDsCppoQmdfJtACcnJP3po37iRoQLlo6EtUTySwgPzIN2jdj0+dZyTkku+nUqj6nNxGAJAjMK9mG3jxdfuEU3i5vNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BwNWZq+l; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a2b82039bso72916927b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 03:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711447728; x=1712052528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+UuIkN0zX2MQNfbCDwIEOWActo/+STrYH1ER+CouzEs=;
        b=BwNWZq+lqafTcisbTfYm24Jt9DBkKkLWxSXDn0plcPTVOIISUG+T1mx9HHF/gWhLQ5
         6ogNovwLfKMqrKm3WAkBdiSYPg//Yztyz/CUiaTWhYNrR4Ackz1XgpiZH+Xe3qbd7rsD
         e+6cAfqyKVdoQ/GoiDBrKn1p1YfjTtupCiOEtH5H356g1IrQwi8fH8iZGl2MfA/Ek9aJ
         moBoUzPLqdJYy30rG1rmoZynhTaHKI1Lq2qZESGNuhgl6eoordKvhXCyfafbNDUTJfv0
         va5+guoA1OUmZTVjZxbQpzRddPSf/QdYYKjF6uP/6nRfJSc19cK186DWOfEzcwYBE31H
         J6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447728; x=1712052528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UuIkN0zX2MQNfbCDwIEOWActo/+STrYH1ER+CouzEs=;
        b=iKuhx1BXr7NeklZlvmSfDp124eiLIoblzepnEmnSHCo30ue3VrQXHi6hIXxsYFZ8VX
         iJKoZM5zEYSsBvuELyxC/4Qfd10hrrzUidQqStsv5OmwFnjPZa7HUw6yOJuPU9UxN44E
         QKr3Wbt3za5RjAndAR+WzKgmbxacUeAX+HotzAvNAgzHJmqGF1UPwNaQK1EXI30c7Ulp
         SQiCMFypVtWlfomqmuF95q5J3uu6X1/rAhQyrfGATgrcOBuRxYvG2G5+QjbAtTpFZLTQ
         /uTPevgJEPJ5a1XhNnoKw7TnndqoSw3oJQQOy4Y6sqO2gOD1JYoEs+r+va1EEEeMPr6P
         yOcg==
X-Forwarded-Encrypted: i=1; AJvYcCUd7NAhUsE71bvxs35zScmKWKy30ZgLdeYV8kxRcFePkag5m4CqVOLGh0cXjxicsQKfBFSYw9piIWqkeQj+64ato+dylZRXxU5lewvRkeXC
X-Gm-Message-State: AOJu0YxDMhaj1bYUCXRcEk8TVnN9Cy4sGgKI9mCTupw74JCgOJNp3liq
	uQadLVEaVcdNGbUNqSMkj3gnK59CByW6DeJy6rW/uQnweNIYsHxS7r0j8Hh/uvD6VM5lQ+tYTEM
	TwrhXJLeGVhVMa/D5cA==
X-Google-Smtp-Source: AGHT+IGphbkHhDnYiU+Le2PvvIp9ir0PpZ1EMWWjLv2MlMb8vaL3b0z6rqmehPj/QqoAX6ldVak1VKAb1goUFYCO
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a81:9105:0:b0:610:f5e6:375a with SMTP
 id i5-20020a819105000000b00610f5e6375amr1662579ywg.9.1711447727696; Tue, 26
 Mar 2024 03:08:47 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:08:30 +0000
In-Reply-To: <20240326100830.1326610-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326100830.1326610-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326100830.1326610-6-vdonnefort@google.com>
Subject: [PATCH v19 RESEND 5/5] ring-buffer/selftest: Add ring-buffer mapping test
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
index 000000000000..50a09e1371d4
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -0,0 +1,302 @@
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
+
+	/* Verify meta-page padding */
+	if (desc->meta->meta_page_size > getpagesize()) {
+		void *addr;
+
+		data_len = desc->meta->meta_page_size;
+		data = mmap(NULL, data_len,
+			    PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
+		ASSERT_NE(data, MAP_FAILED);
+
+		addr = (void *)((unsigned long)data + getpagesize());
+		ASSERT_EQ(*((int *)addr), 0);
+		munmap(data, data_len);
+	}
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
2.44.0.396.g6e790dbe36-goog


