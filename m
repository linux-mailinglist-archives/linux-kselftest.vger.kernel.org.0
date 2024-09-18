Return-Path: <linux-kselftest+bounces-18098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DE497B8B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 09:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C2D283AB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 07:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCDF17109B;
	Wed, 18 Sep 2024 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Rsqk4uOp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA353170A1A
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726645557; cv=none; b=NnMRnyGJPgjpyUFh/DSWibIF8tWadVLJjp2CYUYyTTDkVvHetJpvLMW4lK1ssBeFkr+J/WfPs+fDb6IZyw0SwDVS7Y+0QdhD6xL8DvS/lSOOWPMO58JcxWXNjRV/cNIlI6dvi/Z9WnaVZlsSpetD4An7C3ASl8lrPZOUZ6ngFkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726645557; c=relaxed/simple;
	bh=e0fPdTDwtnmoK4xu8HnZAvgPT5kDUB7AgygyE4ppIAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dB0U8+xtB1YLhbNT/whcd3CbMvS3bmtHhDB7VF5zC4bhObfe78n4HW+584SV5w3KGDIvu9igWYkJntnHy3c1hTcH1tTpynpxcsLZvcx6wlZZXxKTy/jcsJKXa+Li7C+3Hq7OIKGFqd1aFohkTg0PpMCL1/9RZBLppxDmw5Qbjfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Rsqk4uOp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-207115e3056so59099955ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 00:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726645555; x=1727250355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51Wax743nO5HpUDmJh8xGR9vIMqlrrkhnCJydTiox1Y=;
        b=Rsqk4uOpPvkSeIUizid0FrWFN/hcEGNMDFpkM4i5ddq8yddQDle/DwtR80sJgsavH3
         ZigeZQOKEGL05d/J3n5jVlmtZ2Z1QJaLtpENFF7C2AUU3/yQdlq4xuso1mJPBYvJBW4S
         5xzpZk1KpwqhXD9/gfqz6scpYIxluZNCN2EKWSF6hZLuZz7qyHzyBqxXAaZooLLno9f5
         NHJjI4e50P1rVSrZmAlhimC6QP3P8UZkvQa42s2+8ur2nqmo39HfQvuSkecmwfrkCKEE
         edaafCkQrp7s4fad+KKOuhFQHEeKt3aoDhyqc0fGg4KCCOO748WClqke0ZtJhMdORhq3
         vTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726645555; x=1727250355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51Wax743nO5HpUDmJh8xGR9vIMqlrrkhnCJydTiox1Y=;
        b=texZhhjAXdxZFsydleicIbk6aFGGBf6n7L7EKJNdoTPGS8fgsN8MgAUIpmkoytCIr6
         /XGEt61LVLodh74q5u9thTeVNvbtNi/HbOh8yHdVHUxWCbXqVQZyJIsQBYhm+wH4Z2KO
         6xus3DxhhXOfntvq7IFxY6ML1H8pGxOm76TTgkQz2KrFEOCQXFnVPWtURF0dPZRXvhW2
         1WozsyIAGL0+hslBDq1FVM5bs0Q2VX+9NJpv1JH4q4MMc40rRZsn/5AqqT2WM2IFKJiS
         e3ytfKUGPcFj3/agjFzEjR1TRKyfk5Luyo0k7hL1DNIyq7HtFdtZyIYKnX7O260xa3e0
         v0QA==
X-Forwarded-Encrypted: i=1; AJvYcCUvZpl/Xnnunuh5ao9I95C4K4AmgSS2UxoG5GCJpSNf2+fQzEqjVt+WPZ7JtCBksVTbHZ+TLngJU57lKG41bW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvvwZlksptCAwUjWCG5OULiRFyRoWtvyrbmLApgDITugvMWCU
	S+qZd2gjkqDmoGwhga+XBgZbdVSsxuyVYB2WAWS5xp7QeARFAYd9mjQVUtM+RGs=
X-Google-Smtp-Source: AGHT+IGAGrQ7T/LTGDHFLHHxnP/Q17eKGNrI6ExFScNumI/xIpXTn7piGZ925jdHHFgVSgT8qy7eMw==
X-Received: by 2002:a17:903:41cc:b0:207:6d2:2645 with SMTP id d9443c01a7336-2076e46177cmr318284595ad.47.1726645555086;
        Wed, 18 Sep 2024 00:45:55 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794747379sm60412995ad.288.2024.09.18.00.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 00:45:54 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	geliang@kernel.org,
	laoar.shao@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v2 2/2] bpf, selftests: Add test case for cgroup skb to get net_cls classid helpers
Date: Wed, 18 Sep 2024 15:45:15 +0800
Message-Id: <20240918074516.5697-3-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240918074516.5697-1-zhoufeng.zf@bytedance.com>
References: <20240918074516.5697-1-zhoufeng.zf@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

This patch adds a test for cgroup skb to get classid.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 .../bpf/prog_tests/cg_skb_get_classid.c       | 87 +++++++++++++++++++
 .../selftests/bpf/progs/cg_skb_get_classid.c  | 19 ++++
 2 files changed, 106 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c
 create mode 100644 tools/testing/selftests/bpf/progs/cg_skb_get_classid.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c b/tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c
new file mode 100644
index 000000000000..13a5943c387d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright 2024 Bytedance.
+ */
+
+#include <test_progs.h>
+
+#include "cg_skb_get_classid.skel.h"
+
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+
+static int run_test(int cgroup_fd, int server_fd)
+{
+	struct cg_skb_get_classid *skel;
+	int fd, err = 0;
+
+	skel = cg_skb_get_classid__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return -1;
+
+	skel->links.cg_skb_classid =
+		bpf_program__attach_cgroup(skel->progs.cg_skb_classid,
+					   cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.cg_skb_classid, "prog_attach")) {
+		err = -1;
+		goto out;
+	}
+
+	if (!ASSERT_OK(join_classid(), "join_classid")) {
+		err = -1;
+		goto out;
+	}
+
+	errno = 0;
+	fd = connect_to_fd_opts(server_fd, NULL);
+	if (fd >= 0) {
+		if (skel->bss->classid != getpid()) {
+			log_err("Get unexpected classid");
+			err = -1;
+		}
+
+		close(fd);
+	} else {
+		log_err("Unexpected errno from connect to server");
+		err = -1;
+	}
+out:
+	cg_skb_get_classid__destroy(skel);
+	return err;
+}
+
+void test_cg_skb_get_classid(void)
+{
+	struct network_helper_opts opts = {};
+	int server_fd, client_fd, cgroup_fd;
+	static const int port = 60120;
+
+	/* Step 1: Check base connectivity works without any BPF. */
+	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, port, 0);
+	if (!ASSERT_GE(server_fd, 0, "server_fd"))
+		return;
+	client_fd = connect_to_fd_opts(server_fd, &opts);
+	if (!ASSERT_GE(client_fd, 0, "client_fd")) {
+		close(server_fd);
+		return;
+	}
+	close(client_fd);
+	close(server_fd);
+
+	/* Step 2: Check BPF prog attached to cgroups. */
+	cgroup_fd = test__join_cgroup("/cg_skb_get_classid");
+	if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
+		return;
+	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, port, 0);
+	if (!ASSERT_GE(server_fd, 0, "server_fd")) {
+		close(cgroup_fd);
+		return;
+	}
+	setup_classid_environment();
+	set_classid();
+	ASSERT_OK(run_test(cgroup_fd, server_fd), "cg_skb_get_classid");
+	cleanup_classid_environment();
+	close(server_fd);
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/cg_skb_get_classid.c b/tools/testing/selftests/bpf/progs/cg_skb_get_classid.c
new file mode 100644
index 000000000000..aef0265d24eb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cg_skb_get_classid.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright 2024 Bytedance.
+ */
+
+#include <errno.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+__u32 classid = 0;
+
+SEC("cgroup_skb/egress")
+int cg_skb_classid(struct __sk_buff *ctx)
+{
+	classid = bpf_skb_cgroup_classid(ctx);
+
+	return 1;
+}
-- 
2.30.2


