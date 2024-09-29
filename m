Return-Path: <linux-kselftest+bounces-18545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B39989480
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 11:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8211C21015
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 09:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353E8143C49;
	Sun, 29 Sep 2024 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fkeTi36x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19A13BC26;
	Sun, 29 Sep 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727602113; cv=none; b=QQKog/f7FQJV4e9+AC2YLEgaPoM8ZsK4W4iqt2yUYoocxzMXV6YpDltHt+zsD8xsMR9BmYrJF1az9rBK5BRQBEjcO1SpJAJfMW0sAAL30IcQYDlN+v6JGNSbfaiZkBUQBykZruIX7LGEHBzOn/NWIHxYKcvZeJAeO4O6twg0sVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727602113; c=relaxed/simple;
	bh=shYnk4kqGmMvF/NqXoEJOLpSnB+WSuGNZUoNvgMwbFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IbPT1F4/44OuCwXwvbbdrGB8ai8AmSRjNZaUcZiLu+lNl1WEnNQZtMopheXqZ8XBsIZWDLHd3gnqpw5C6+TQuu3XzWu7vIdN+0FeyLFF8r3C9yeEg62aB+por4hUJrxylizlgn2jEd1ZCst9QefpeG6oI+c28I7FeWPLKkVwFg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fkeTi36x; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727602101; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mAd0zirb1myQnOuOjwMOeSKLRW5o75/Z/hsajzeRu7Y=;
	b=fkeTi36xBCGLiUFKrDuBFgXbx8bBTktBq+rBg1hvUfAkh1TsHIJwUNboBcJHgb80vNIfbVsk+pEFUXzxbOkNa0XoQJR4DFoxVxUFvEhTVrRMU+aq4ihf9EviRHVTBXYAObGoJrsFY28VvttgAUx6/WTnR7w5qXYIQANY/eikJJM=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WFvyhnA_1727602091)
          by smtp.aliyun-inc.com;
          Sun, 29 Sep 2024 17:28:21 +0800
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
Subject: [PATCH v2 -next] selftests/bpf: Use ARRAY_SIZE for array length
Date: Sun, 29 Sep 2024 17:28:11 +0800
Message-Id: <20240929092811.7103-1-jiapeng.chong@linux.alibaba.com>
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
Changes in v2:
  -Modify the header file "kselftest.h" to "linux/kernel.h".

 tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
index a18d3680fb16..7534014279ca 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
@@ -7,6 +7,7 @@
 #include <sys/syscall.h>
 #include <bpf/libbpf.h>
 #include <bpf/btf.h>
+#include <linux/kernel.h>
 
 #include "test_progs.h"
 #include "test_btf.h"
@@ -90,15 +91,15 @@ static void test_bad_local_id(void)
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


