Return-Path: <linux-kselftest+bounces-42871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7FDBC4508
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 12:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D9019E1817
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C62F6560;
	Wed,  8 Oct 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sy1AyRzU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B5B2F5A2C
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Oct 2025 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919218; cv=none; b=tXYt8UDbWvylB94TBcy27jhZS1/OW8f+7F6Dfz8cp0ZqIfoBN4Mq32d5KolTQIDGyZjomvqU1SKRnmPsVX9m4YPRifLpvMGjxC1aQx9IDSAzWdTPaLfkxb3LIaVy8TCRog1wzrErUm41bXa2vBk5YSblybjzfeOB9K1yW5NkjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919218; c=relaxed/simple;
	bh=8uQeL4E477nom03PLC006W88FoYSSTjNO0YClm3+fj8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQBN3AziyX44sZEz0bzVyvL1SzMXYPVxBeYlCmz2MpYOGHg5CYbBcunUb9RgUx7kZI5XQVfH7UnHTa2RoD0OHZe5y44leiZqllsSayI5g2o7Q7Aec6uasb8J++TFziTImDTwd6viHha2DPVZXJXNRLi1TejeS/7pBwK35ShyMyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sy1AyRzU; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759919215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEa07dvEPCZz8jmImHhIJpaCW6KALRSdrL+C0O70/q4=;
	b=Sy1AyRzUUz2Xfm32LPcOuKzUNlkZ+JXkK0iNkuxCfw9vOX75tM/4k6Bq/b0WuAds0dDEPY
	D072HfO3K1h8Ks2ZUY/0xlqXSZERK8/sk4vNxh7QQmKG9pwOPh3Fd57NQIH3tsG2T8mzP1
	LJHuf/WoXC2Pk4MaCybxSX8KrBIahEE=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	toke@redhat.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3 2/2] selftests/bpf: Add test for unpinning htab with internal timer struct
Date: Wed,  8 Oct 2025 18:26:27 +0800
Message-ID: <20251008102628.808045-3-kafai.wan@linux.dev>
In-Reply-To: <20251008102628.808045-1-kafai.wan@linux.dev>
References: <20251008102628.808045-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add test to verify that unpinning hash tables containing internal timer
structures does not trigger context warnings.

Each subtest (timer_prealloc and timer_no_prealloc) can trigger the
context warning when unpinning, but the warning cannot be triggered
twice within a short time interval (a HZ), which is expected behavior.

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/pinning_htab.c   | 36 +++++++++++++++++++
 .../selftests/bpf/progs/test_pinning_htab.c   | 25 +++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_htab.c

diff --git a/tools/testing/selftests/bpf/prog_tests/pinning_htab.c b/tools/testing/selftests/bpf/prog_tests/pinning_htab.c
new file mode 100644
index 000000000000..16bd74be3dbe
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/pinning_htab.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "test_pinning_htab.skel.h"
+
+static void unpin_map(const char *map_name, const char *pin_path)
+{
+	struct test_pinning_htab *skel;
+	struct bpf_map *map;
+	int err;
+
+	skel = test_pinning_htab__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		return;
+
+	map = bpf_object__find_map_by_name(skel->obj, map_name);
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name"))
+		goto out;
+
+	err = bpf_map__pin(map, pin_path);
+	if (!ASSERT_OK(err, "bpf_map__pin"))
+		goto out;
+
+	err = bpf_map__unpin(map, pin_path);
+	ASSERT_OK(err, "bpf_map__unpin");
+out:
+	test_pinning_htab__destroy(skel);
+}
+
+void test_pinning_htab(void)
+{
+	if (test__start_subtest("timer_prealloc"))
+		unpin_map("timer_prealloc", "/sys/fs/bpf/timer_prealloc");
+	if (test__start_subtest("timer_no_prealloc"))
+		unpin_map("timer_no_prealloc", "/sys/fs/bpf/timer_no_prealloc");
+}
diff --git a/tools/testing/selftests/bpf/progs/test_pinning_htab.c b/tools/testing/selftests/bpf/progs/test_pinning_htab.c
new file mode 100644
index 000000000000..ae227930c73c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_pinning_htab.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct timer_val {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u32);
+	__type(value, struct timer_val);
+	__uint(max_entries, 1);
+} timer_prealloc SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u32);
+	__type(value, struct timer_val);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} timer_no_prealloc SEC(".maps");
-- 
2.43.0


