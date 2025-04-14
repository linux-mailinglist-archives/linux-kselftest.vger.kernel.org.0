Return-Path: <linux-kselftest+bounces-30806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE1A88F9F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 00:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BDB3AD0C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 22:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5C11FC7E7;
	Mon, 14 Apr 2025 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3f2VI4SZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6341F9EC1
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 22:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744671194; cv=none; b=AQE+O4CMTodzUW430u5mKkCgTxkW3S2ehebekcLeYnppb7T9ME7vFzUUb5k93n/fDaQXBPKyx8sx+N0RTkK3SvfE9XIKmzl32/XhCCdtsAuON3yAz23xm1a190ZQeBleGDvUTC5b4JyeuEcAR+nXlirRyn1H1w17SWKW7FrLD/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744671194; c=relaxed/simple;
	bh=44K8Q6AuXoj9xzMQOWpJBkB6xYoeWfYRTbJFsXJgX2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WQeGJh3VXxDCV3r4IfhwwrNhKq+MO64q4NJfNFtRk7bGUyL8X40L98EzNjLS5qGqcIXiPD+sFOJTc+y1t3gD83DgCsQlT7hb4io+J4CLQP5E+tLFg8cIvrip+nu1rSxKCxwA0TzghOk13/9Tyysak29D9Cu8vsE2UxlsUqAhpTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3f2VI4SZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242ce15cc3so37670425ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 15:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744671192; x=1745275992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ydypiDmSY/+9aTdOoLn3KGMnPAKqHC/nE4rz3DKuBno=;
        b=3f2VI4SZpOwBVeZaxwxwg81rJAAtSBgWK6pmxINN9YqO6NE28j6y30K7SyrFZohgcw
         8NMybLAPcTTfmTpZzg5K3hkHz1jqWhv6YPZfuXlXpFzQeKo9V3BXyFR5IK2D5fLXEKs2
         CcIkfNpizha8A7jEwAXPWiCuHiQBi7b53V6tMmOsqIBbCfWGCN/vqHB/23Hyrxme3QIy
         TRwGkDUs8q396uON/JLvTQTDVYi/yU580A8k9qExESlThuukBh+AZKGkJK2u0nGSrX/2
         zHBNAh++CW4FlnPdtUU1GiHf7zpbj52l0pKyfXsPCqFhrl+je9m8Cr3zLE56933fks5U
         7JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744671192; x=1745275992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydypiDmSY/+9aTdOoLn3KGMnPAKqHC/nE4rz3DKuBno=;
        b=HxnoDnsjTT4OFxP53WfG7EeXhYC93emIZfwf/i2QQ1SvyJaZS59NkkG70qtuXbg4P7
         kENlqQ0/hpLPIEBVinDcyqp8QHD/QLMMIbp39iQaIrxFR3fsGZ95hswrpwgD64CE9vqk
         8ftkaRBaZQRPTOnOAKyFxsEICSLn1C0TAGk6yo4fcSTA84NxYL/ps5rI57Xlyuj3e3ae
         qAQvZPOFvLeBvVOKfz0fS/LUjdD9L1MFkjnH1DaNEOO34W9DKp0kK9v+o3F5TrHzzktJ
         UBAyyLj5bIxrp9DSn05z8XkvsKplH4f9y8egzQxcGJukdGMqRVr5vbpKSY2BjfTkaY7J
         BsCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoGPGHnftrKq+9AWB6LClEP2YjXriBfuvBwvf3wmNMz6KvsPk8oPK2Boy+F16JcxnL7blV8MSPSUEHGWlRWos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXyC4bEvpr0NEz9IZ7V8U8OL8CB73d/AA4uirWuQeEjYHxGOLx
	EpgigLaBrafxuRopqM3TgBlC7aeVyLv6DfS0fKKGGl7K6XaRO57zHgwqMUF7xKdY04m7wif38BX
	JyeVdtWNXC8fcYQ==
X-Google-Smtp-Source: AGHT+IFYnfgagwAj8LEq72zmQEywyp03lQ11DjIPICX26P76uoggK3MsLH2X1HxcUGfeP/V9KBZCY8CkokiG/G0=
X-Received: from plbba2.prod.google.com ([2002:a17:902:7202:b0:223:8233:a96c])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e842:b0:220:e9f5:4b7c with SMTP id d9443c01a7336-22bea4ab795mr182315935ad.17.1744671191895;
 Mon, 14 Apr 2025 15:53:11 -0700 (PDT)
Date: Mon, 14 Apr 2025 22:52:26 +0000
In-Reply-To: <20250414225227.3642618-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414225227.3642618-4-tjmercier@google.com>
Subject: [PATCH 3/4] selftests/bpf: Add test for dmabuf_iter
From: "T.J. Mercier" <tjmercier@google.com>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, android-mm@google.com, simona@ffwll.ch, 
	corbet@lwn.net, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

This test creates a udmabuf and uses a BPF program that prints dmabuf
metadata with the new dmabuf_iter to verify it can be found.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/dmabuf_iter.c    | 116 ++++++++++++++++++
 .../testing/selftests/bpf/progs/dmabuf_iter.c |  31 +++++
 3 files changed, 148 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/dmabuf_iter.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index c378d5d07e02..a791c60813df 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -106,6 +106,7 @@ CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_SYN_COOKIES=y
 CONFIG_TEST_BPF=m
+CONFIG_UDMABUF=y
 CONFIG_USERFAULTFD=y
 CONFIG_VSOCKETS=y
 CONFIG_VXLAN=y
diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
new file mode 100644
index 000000000000..af215a4e0520
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
@@ -0,0 +1,116 @@
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
+#include <linux/udmabuf.h>
+
+
+static void subtest_dmabuf_iter_check_udmabuf(struct dmabuf_iter *skel)
+{
+	static const char test_buffer_name[] = "udmabuf_test_buffer_for_iter";
+	const size_t test_buffer_size = 10 * getpagesize();
+
+	ASSERT_LE(sizeof(test_buffer_name), DMA_BUF_NAME_LEN, "NAMETOOLONG");
+
+	int memfd = memfd_create("memfd_test", MFD_ALLOW_SEALING);
+	ASSERT_OK_FD(memfd, "memfd_create");
+
+	ASSERT_OK(ftruncate(memfd, test_buffer_size), "ftruncate");
+
+	ASSERT_OK(fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK), "seal");
+
+	int dev_udmabuf = open("/dev/udmabuf", O_RDONLY);
+	ASSERT_OK_FD(dev_udmabuf, "open udmabuf");
+
+	struct udmabuf_create create;
+	create.memfd = memfd;
+	create.flags = UDMABUF_FLAGS_CLOEXEC;
+	create.offset = 0;
+	create.size = test_buffer_size;
+
+	int udmabuf = ioctl(dev_udmabuf, UDMABUF_CREATE, &create);
+	close(dev_udmabuf);
+	ASSERT_OK_FD(udmabuf, "udmabuf_create");
+
+	ASSERT_OK(ioctl(udmabuf, DMA_BUF_SET_NAME_B, test_buffer_name), "name");
+
+	int iter_fd = bpf_iter_create(bpf_link__fd(skel->links.dmabuf_collector));
+	ASSERT_OK_FD(iter_fd, "iter_create");
+
+	FILE *iter_file = fdopen(iter_fd, "r");
+	ASSERT_OK_PTR(iter_file, "fdopen");
+
+	char *line = NULL;
+	size_t linesize = 0;
+	bool found_test_udmabuf = false;
+	while (getline(&line, &linesize, iter_file) != -1) {
+		long inode, size;
+		char name[DMA_BUF_NAME_LEN], exporter[32];
+
+		int nelements = sscanf(line, "ino:%ld size:%ld name:%s exp_name:%s",
+				       &inode, &size, name, exporter);
+
+		if (nelements == 4 && size == test_buffer_size &&
+				!strcmp(name, test_buffer_name) &&
+				!strcmp(exporter, "udmabuf")) {
+			found_test_udmabuf = true;
+			break;
+		}
+	}
+
+	ASSERT_TRUE(found_test_udmabuf, "found_test_buffer");
+
+	free(line);
+	fclose(iter_file);
+	close(iter_fd);
+	close(udmabuf);
+	close(memfd);
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
+	if (!ASSERT_OK(dmabuf_iter__attach(skel), "skel_attach"))
+		goto destroy;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(skel->links.dmabuf_collector));
+	if (!ASSERT_GE(iter_fd, 0, "iter_create"))
+		goto destroy;
+
+	memset(buf, 0, sizeof(buf));
+	while (read(iter_fd, buf, sizeof(buf) > 0)) {
+		/* Read out all contents */
+	}
+
+	/* Next reads should return 0 */
+	ASSERT_EQ(read(iter_fd, buf, sizeof(buf)), 0, "read");
+
+	if (test__start_subtest("check_udmabuf"))
+		subtest_dmabuf_iter_check_udmabuf(skel);
+
+	close(iter_fd);
+
+destroy:
+	dmabuf_iter__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
new file mode 100644
index 000000000000..b2af14ceb609
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Google LLC */
+#include <vmlinux.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("iter/dmabuf")
+int dmabuf_collector(struct bpf_iter__dmabuf *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	const struct dma_buf *dmabuf = ctx->dmabuf;
+
+	if (dmabuf) {
+		size_t size;
+		unsigned long inode;
+		const char *name, *exp_name;
+
+		if (bpf_core_read(&size, sizeof(size), &dmabuf->size) ||
+		    BPF_CORE_READ_INTO(&inode, dmabuf, file, f_inode, i_ino) ||
+		    bpf_core_read(&name, sizeof(name), &dmabuf->name) ||
+		    bpf_core_read(&exp_name, sizeof(exp_name), &dmabuf->exp_name))
+			return 1;
+
+		BPF_SEQ_PRINTF(seq, "ino:%lu size:%llu name:%s exp_name:%s\n",
+			inode, size, name ? name : "", exp_name ? exp_name : "");
+	}
+
+	return 0;
+}
-- 
2.49.0.604.gff1f9ca942-goog


