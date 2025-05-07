Return-Path: <linux-kselftest+bounces-32545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA23AAD1FB
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 02:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39D7520729
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 00:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF1D80C02;
	Wed,  7 May 2025 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gfo4kGs0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4E79CF
	for <linux-kselftest@vger.kernel.org>; Wed,  7 May 2025 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746576655; cv=none; b=u2vLbcJnULpOkiwfh5mFM7w83G38ci8khjUc/a4eqLX1tzSVuHZ2WZkt6isbsmrbTKF+UZCsX9S8DBnLdoA8JxbGQK6NAw485sG5ceNP6ekRgZylBliTWkwVEIiSpqOdWytrYX7IIuYcODkQ/p+Jmar4M5CV5JI08K5NV5XC+cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746576655; c=relaxed/simple;
	bh=JqRu074ozUddd8kemDckp4rr15I64ivUzyflAGOFfko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F3RNWmKv4nrkg60VCvQKp6fE72FP2mSFlhcQ/gWXSE3hslBvCbA9Ld3SqJvyQbEv9UKCW6d9OmB5wwgQfI4rJnEmcFa3ATqlxpPoJyM6yR6ulXEjdMbmkhHmN0VFsCcZ1VFMGcOWLCKUqT8SZPTbO/o3xO0FLkN4kHQUm3paVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gfo4kGs0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30a0a8ddcc4so6443868a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 May 2025 17:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746576652; x=1747181452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9aSEG6reue+mhB8A31rxfEwcd9FhIVy9ERXqn2E21Vw=;
        b=gfo4kGs0E2badJoS5B5Ua5mKUUipOKPpKzzr5DuUQUQWeK2Xj3YEKECYLvYiX2cX3T
         4gGuhdsgpRfHXUT9shjSSLQbX3PKZmth1Q7DDWwW7G1Fe+/G/kQY/nFr9cKrq+zDyady
         gQ41tef4ji3AwchKwHK2/xtHdfx7y/tCYGFwZJTnPhvWbNYY3bvujZ0yc/Mq2O46j21Y
         Sfuk14YwNCUiMiNFzcsJtohV3Z1CqWAupNy2g/hIT4i/CrGVkPdVU7aDZrHl+CUlbOO+
         zrr8x7gQ4xjCwmzN1iGVP93wl0sY/T4Lm9PLKOCSAPxH8U0UdW9NjSguYn3Aetur1ir/
         WohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746576652; x=1747181452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aSEG6reue+mhB8A31rxfEwcd9FhIVy9ERXqn2E21Vw=;
        b=eWOUhQh5+a5k6B5WtTbH8uToLxM8VG4ct0XFuVSsYh/6DvMatkrxEJIw7BP118I+Gh
         C0MXVz6oZQuRCPpJzTP4876HNm3XhhPs76Pnb58cECe3snm9ewy8X1GJFzd5stqoNQr4
         GVgQ7NFpdt6sopkOY+cKRtIo84pHeJ8WGPsPq4y/tnA05Ko6Wzv40f4X97WCWov5Zm0N
         SRNN8ssyRCa0GeDBtztBtjUBNIQch34HxUbrBoyTwfnVDvPvmh1uFeCJkBQAwszWvabo
         7tScilqOb8UX/hnoyezee4F9s61gPpTOi8wX7GNXSROcJNBuUuVKaiiXVhWWtd0Kye0A
         oc3A==
X-Forwarded-Encrypted: i=1; AJvYcCVN15quFwJf9b+h9AZo+BS19QSyr5dv+/uRanxHkNo+8LZf14c8ADFVfiduJfiCp0aS8hHiOAUkcpDxkRWBg68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv9xGP0hh36L6RrAVXrjrKLDb3nnWwS37XJEwU6+sUHW4F+tGw
	TH7xfFIhxdx+UH/7JhW4IK1MM19XGWFEHH3RKXu1Z5xIvG40t9SN1DIdSDlyAglokbzRnasE8oE
	Lmv3mxESlARUQwQ==
X-Google-Smtp-Source: AGHT+IFFCLXIRuU4DBH/dPfISrZqj5UKsNOljdqhI2H24qPNDHVlFWApcakm1qhmpAiXiOLveDPBfUiXDQZpa0M=
X-Received: from pjj15.prod.google.com ([2002:a17:90b:554f:b0:2ff:84e6:b2bd])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:554e:b0:2ff:6e72:b8e9 with SMTP id 98e67ed59e1d1-30aac2837bcmr2137461a91.25.1746576652176;
 Tue, 06 May 2025 17:10:52 -0700 (PDT)
Date: Wed,  7 May 2025 00:10:35 +0000
In-Reply-To: <20250507001036.2278781-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250507001036.2278781-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250507001036.2278781-5-tjmercier@google.com>
Subject: [PATCH bpf-next v3 4/5] selftests/bpf: Add test for dmabuf_iter
From: "T.J. Mercier" <tjmercier@google.com>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com, song@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

This test creates a udmabuf, and a dmabuf from the system dmabuf heap,
and uses a BPF program that prints dmabuf metadata with the new
dmabuf_iter to verify they can be found.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/dmabuf_iter.c    | 224 ++++++++++++++++++
 .../testing/selftests/bpf/progs/dmabuf_iter.c |  53 +++++
 3 files changed, 280 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/dmabuf_iter.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index c378d5d07e02..2bdff2f3285f 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -22,6 +22,8 @@ CONFIG_CRYPTO_AES=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_DMABUF_HEAPS=y
+CONFIG_DMABUF_HEAPS_SYSTEM=y
 CONFIG_DUMMY=y
 CONFIG_DYNAMIC_FTRACE=y
 CONFIG_FPROBE=y
@@ -106,6 +108,7 @@ CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_SYN_COOKIES=y
 CONFIG_TEST_BPF=m
+CONFIG_UDMABUF=y
 CONFIG_USERFAULTFD=y
 CONFIG_VSOCKETS=y
 CONFIG_VXLAN=y
diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
new file mode 100644
index 000000000000..35745f4ce0f8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Google */
+
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include <bpf/btf.h>
+#include "dmabuf_iter.skel.h"
+
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include <linux/dma-buf.h>
+#include <linux/dma-heap.h>
+#include <linux/udmabuf.h>
+
+static int memfd, udmabuf;
+static const char udmabuf_test_buffer_name[DMA_BUF_NAME_LEN] = "udmabuf_test_buffer_for_iter";
+static size_t udmabuf_test_buffer_size;
+static int sysheap_dmabuf;
+static const char sysheap_test_buffer_name[DMA_BUF_NAME_LEN] = "sysheap_test_buffer_for_iter";
+static size_t sysheap_test_buffer_size;
+
+static int create_udmabuf(void)
+{
+	struct udmabuf_create create;
+	int dev_udmabuf;
+
+	udmabuf_test_buffer_size = 10 * getpagesize();
+
+	if (!ASSERT_LE(sizeof(udmabuf_test_buffer_name), DMA_BUF_NAME_LEN, "NAMETOOLONG"))
+		return 1;
+
+	memfd = memfd_create("memfd_test", MFD_ALLOW_SEALING);
+	if (!ASSERT_OK_FD(memfd, "memfd_create"))
+		return 1;
+
+	if (!ASSERT_OK(ftruncate(memfd, udmabuf_test_buffer_size), "ftruncate"))
+		return 1;
+
+	if (!ASSERT_OK(fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK), "seal"))
+		return 1;
+
+	dev_udmabuf = open("/dev/udmabuf", O_RDONLY);
+	if (!ASSERT_OK_FD(dev_udmabuf, "open udmabuf"))
+		return 1;
+
+	create.memfd = memfd;
+	create.flags = UDMABUF_FLAGS_CLOEXEC;
+	create.offset = 0;
+	create.size = udmabuf_test_buffer_size;
+
+	udmabuf = ioctl(dev_udmabuf, UDMABUF_CREATE, &create);
+	close(dev_udmabuf);
+	if (!ASSERT_OK_FD(udmabuf, "udmabuf_create"))
+		return 1;
+
+	if (!ASSERT_OK(ioctl(udmabuf, DMA_BUF_SET_NAME_B, udmabuf_test_buffer_name), "name"))
+		return 1;
+
+	return 0;
+}
+
+static int create_sys_heap_dmabuf(void)
+{
+	sysheap_test_buffer_size = 20 * getpagesize();
+
+	struct dma_heap_allocation_data data = {
+		.len = sysheap_test_buffer_size,
+		.fd = 0,
+		.fd_flags = O_RDWR | O_CLOEXEC,
+		.heap_flags = 0,
+	};
+	int heap_fd, ret;
+
+	if (!ASSERT_LE(sizeof(sysheap_test_buffer_name), DMA_BUF_NAME_LEN, "NAMETOOLONG"))
+		return 1;
+
+	heap_fd = open("/dev/dma_heap/system", O_RDONLY);
+	if (!ASSERT_OK_FD(heap_fd, "open dma heap"))
+		return 1;
+
+	ret = ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &data);
+	close(heap_fd);
+	if (!ASSERT_OK(ret, "syheap alloc"))
+		return 1;
+
+	sysheap_dmabuf = data.fd;
+
+	if (!ASSERT_OK(ioctl(sysheap_dmabuf, DMA_BUF_SET_NAME_B, sysheap_test_buffer_name), "name"))
+		return 1;
+
+	return 0;
+}
+
+static int create_test_buffers(void)
+{
+	int ret;
+
+	ret = create_udmabuf();
+	if (ret)
+		return ret;
+
+	return create_sys_heap_dmabuf();
+}
+
+static void destroy_test_buffers(void)
+{
+	close(udmabuf);
+	close(memfd);
+	close(sysheap_dmabuf);
+}
+
+enum Fields { INODE, SIZE, NAME, EXPORTER, FIELD_COUNT };
+struct DmabufInfo {
+	unsigned long inode;
+	unsigned long size;
+	char name[DMA_BUF_NAME_LEN];
+	char exporter[32];
+};
+
+static bool check_dmabuf_info(const struct DmabufInfo *bufinfo,
+			      unsigned long size,
+			      const char *name, const char *exporter)
+{
+	return size == bufinfo->size &&
+	       !strcmp(name, bufinfo->name) &&
+	       !strcmp(exporter, bufinfo->exporter);
+}
+
+static void subtest_dmabuf_iter_check_default_iter(struct dmabuf_iter *skel)
+{
+	bool found_test_sysheap_dmabuf = false;
+	bool found_test_udmabuf = false;
+	struct DmabufInfo bufinfo;
+	size_t linesize = 0;
+	char *line = NULL;
+	FILE *iter_file;
+	int iter_fd, f = INODE;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(skel->links.dmabuf_collector));
+	ASSERT_OK_FD(iter_fd, "iter_create");
+
+	iter_file = fdopen(iter_fd, "r");
+	ASSERT_OK_PTR(iter_file, "fdopen");
+
+	while (getline(&line, &linesize, iter_file) != -1) {
+		if (f % FIELD_COUNT == INODE) {
+			ASSERT_EQ(sscanf(line, "%ld", &bufinfo.inode), 1,
+				  "read inode");
+		} else if (f % FIELD_COUNT == SIZE) {
+			ASSERT_EQ(sscanf(line, "%ld", &bufinfo.size), 1,
+				  "read size");
+		} else if (f % FIELD_COUNT == NAME) {
+			ASSERT_EQ(sscanf(line, "%s", bufinfo.name), 1,
+				  "read name");
+		} else if (f % FIELD_COUNT == EXPORTER) {
+			ASSERT_EQ(sscanf(line, "%31s", bufinfo.exporter), 1,
+				  "read exporter");
+
+			if (check_dmabuf_info(&bufinfo,
+					      sysheap_test_buffer_size,
+					      sysheap_test_buffer_name,
+					      "system"))
+				found_test_sysheap_dmabuf = true;
+			else if (check_dmabuf_info(&bufinfo,
+						   udmabuf_test_buffer_size,
+						   udmabuf_test_buffer_name,
+						   "udmabuf"))
+				found_test_udmabuf = true;
+		}
+		++f;
+	}
+
+	ASSERT_EQ(f % FIELD_COUNT, INODE, "number of fields");
+
+	ASSERT_TRUE(found_test_sysheap_dmabuf, "found_test_sysheap_dmabuf");
+	ASSERT_TRUE(found_test_udmabuf, "found_test_udmabuf");
+
+	free(line);
+	fclose(iter_file);
+	close(iter_fd);
+}
+
+void test_dmabuf_iter(void)
+{
+	struct dmabuf_iter *skel = NULL;
+	char buf[256];
+	int iter_fd;
+
+	skel = dmabuf_iter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "dmabuf_iter__open_and_load"))
+		return;
+
+	if (!ASSERT_OK(create_test_buffers(), "create_buffers"))
+		goto destroy;
+
+	if (!ASSERT_OK(dmabuf_iter__attach(skel), "skel_attach"))
+		goto destroy;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(skel->links.dmabuf_collector));
+	if (!ASSERT_OK_FD(iter_fd, "iter_create"))
+		goto destroy;
+
+	while (read(iter_fd, buf, sizeof(buf)) > 0)
+		; /* Read out all contents */
+
+	/* Next reads should return 0 */
+	ASSERT_EQ(read(iter_fd, buf, sizeof(buf)), 0, "read");
+
+	if (test__start_subtest("default_iter"))
+		subtest_dmabuf_iter_check_default_iter(skel);
+
+	close(iter_fd);
+
+destroy:
+	destroy_test_buffers();
+	dmabuf_iter__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
new file mode 100644
index 000000000000..6e80a53c4670
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Google LLC */
+#include <vmlinux.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+
+/* From uapi/linux/dma-buf.h */
+#define DMA_BUF_NAME_LEN 32
+
+char _license[] SEC("license") = "GPL";
+
+/**
+ * Fields output by this iterator are delimited by newlines. Convert any
+ * newlines in user-provided printed strings to spaces.
+ */
+static void sanitize_string(char *src, size_t size)
+{
+	for (char *c = src; c && (size_t)(c-src) < size; ++c)
+		if (*c == '\n')
+			*c = ' ';
+}
+
+SEC("iter/dmabuf")
+int dmabuf_collector(struct bpf_iter__dmabuf *ctx)
+{
+	const struct dma_buf *dmabuf = ctx->dmabuf;
+	struct seq_file *seq = ctx->meta->seq;
+	unsigned long inode = 0;
+	size_t size;
+	const char *pname, *exporter;
+	char name[DMA_BUF_NAME_LEN] = {'\0'};
+
+	if (!dmabuf)
+		return 0;
+
+	if (BPF_CORE_READ_INTO(&inode, dmabuf, file, f_inode, i_ino) ||
+	    bpf_core_read(&size, sizeof(size), &dmabuf->size) ||
+	    bpf_core_read(&pname, sizeof(pname), &dmabuf->name) ||
+	    bpf_core_read(&exporter, sizeof(exporter), &dmabuf->exp_name))
+		return 1;
+
+	/* Buffers are not required to be named */
+	if (pname) {
+		if (bpf_probe_read_kernel(name, sizeof(name), pname))
+			return 1;
+
+		/* Name strings can be provided by userspace */
+		sanitize_string(name, sizeof(name));
+	}
+
+	BPF_SEQ_PRINTF(seq, "%lu\n%llu\n%s\n%s\n", inode, size, name, exporter);
+	return 0;
+}
-- 
2.49.0.1045.g170613ef41-goog


