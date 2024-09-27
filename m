Return-Path: <linux-kselftest+bounces-18455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A7F98803F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 10:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529C7281C6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 08:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413BE18950E;
	Fri, 27 Sep 2024 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GxlUJFf4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7918BC17;
	Fri, 27 Sep 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425409; cv=none; b=RYquKEfK+kTBOuscBsJnJT2HW8flW/KI+pl/VbJklyMOgqDNezMhoGBfvoUYVvurThtrReKkIbbBryEKGCpPq2OkcsBL7fpbhHg7rKvhD0gcSUbMZSF6LNe6JosQ8Xt8YngCKZx2DWzXVNF9wfGd3+7vTszzHLHInlDvEQY7vAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425409; c=relaxed/simple;
	bh=1huYT4EgmCex0ujaHKFX4m5ujtUQmNyO4sHj4DnU+UY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=byfZTszuqklIO/RDjST2naPkHhG1vSNkzT/ovziz4+GfWWNi6ZwpOjDE37yshOMmeaOgh4P4quXy7c1cBPRy6xztSgRbeyy9X/8pAIEO0EYugjopRrITu2eqJ9jlGEWfRMIfESlJh16c7wa0jwEYs2JHRPktdWCikEPk9+yQBLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GxlUJFf4; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727425403; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=WNqbE4DH8C3sckUEs77lvuuGox/FHMYfPKfFVASWlaQ=;
	b=GxlUJFf4eBaS73t3uDu8kwfIhY70JCCTrMJp1QBYO2+OzLatZ7BlRgfLx1BYkdE/CgrAGDXtTs+D1930T99Q24CqTCr+D5EqsBiGqY2wNDScXcY7wiDQq3LHMSKhDdwS27DQhRiKm9sDzfPBdgJzQNG/AC140gSDZs46PW3Nh18=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WFpys77_1727425394)
          by smtp.aliyun-inc.com;
          Fri, 27 Sep 2024 16:23:22 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] selftests/bpf: Use ARRAY_SIZE for array length
Date: Fri, 27 Sep 2024 16:23:13 +0800
Message-Id: <20240927082313.116139-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of macro ARRAY_SIZE to calculate array size minimizes
the redundant code and improves code reusability.

./tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c:98:34-35: WARNING: Use ARRAY_SIZE.
./tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c:93:29-30: WARNING: Use ARRAY_SIZE.
./tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c:101:34-35: WARNING: Use ARRAY_SIZE.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11167
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
index a18d3680fb16..5e576c6cecca 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
@@ -7,7 +7,7 @@
 #include <sys/syscall.h>
 #include <bpf/libbpf.h>
 #include <bpf/btf.h>
-
+#include "kselftest.h"
 #include "test_progs.h"
 #include "test_btf.h"
 #include "bpf/libbpf_internal.h"
@@ -90,15 +90,15 @@ static void test_bad_local_id(void)
 	attr.prog_type = BPF_TRACE_RAW_TP;
 	attr.license = (__u64)"GPL";
 	attr.insns = (__u64)&insns;
-	attr.insn_cnt = sizeof(insns) / sizeof(*insns);
+	attr.insn_cnt = ARRAY_SIZE(insns);
 	attr.log_buf = (__u64)log;
 	attr.log_size = sizeof(log);
 	attr.log_level = log_level;
 	attr.func_info = (__u64)funcs;
-	attr.func_info_cnt = sizeof(funcs) / sizeof(*funcs);
+	attr.func_info_cnt = ARRAY_SIZE(funcs);
 	attr.func_info_rec_size = sizeof(*funcs);
 	attr.core_relos = (__u64)relos;
-	attr.core_relo_cnt = sizeof(relos) / sizeof(*relos);
+	attr.core_relo_cnt = ARRAY_SIZE(relos);
 	attr.core_relo_rec_size = sizeof(*relos);
 	prog_fd = sys_bpf_prog_load(&attr, sizeof(attr), 1);
 	saved_errno = errno;
-- 
2.32.0.3.g01195cf9f


