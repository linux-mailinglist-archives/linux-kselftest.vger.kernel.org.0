Return-Path: <linux-kselftest+bounces-42710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18010BB643C
	for <lists+linux-kselftest@lfdr.de>; Fri, 03 Oct 2025 10:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 228D04EAAED
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Oct 2025 08:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56927B33E;
	Fri,  3 Oct 2025 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uUksfYjQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16B6275AF2
	for <linux-kselftest@vger.kernel.org>; Fri,  3 Oct 2025 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759481238; cv=none; b=BEJROxxXNVNd+h/ymzC3n+eKh8ikdaAph/AE7KqyK3+AipVHDJnHFUpOChgYfmdCebtVIFTdgq02ASMReod77sK/3n4lfwY05v5U8i6kIjN6P5r4cOezRmUZrjGKXMXFGA9D1UnSIyAHFwz/TcUU5OGSjF2BZlRXGBgWNvwCqsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759481238; c=relaxed/simple;
	bh=XLodWl1Mnqi6n+xmZaM4r4KxwmmAoji2W6kZJLMVLA8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qy96/zeVsQWPcv544LAR07azUGtfTPH+p6k260257N/mDuXEoF6+1bxEd1mIyz22Z7qaNIqfShGhSYDSVBHdLtsg1mR4hybZeMCiVf+f/P7nvaKomG3ajJ7cOTBjdthhMu9TYSxehQwuhRbZJTXPanRqWpkKTmjHGTdTaamkkeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uUksfYjQ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759481235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZM6bExjDs8jz6TVsKvY1N151Suvl2rvzQSjV8ALYIE=;
	b=uUksfYjQzFzSy+jIUVRgc1r4bn38I5hd+45qOv9/mdFxrvxzk9fcv6zH0laC2n+GqUwYYK
	LkUwLZKnFojni7xbzvB9JkN87RKhExIzunDQfsiFzpCqzTXr8rFazFgRGqVbh9NlKL6jqy
	GuCU2BX8K3WYSi4giFgDNlfM4rFjHUA=
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
Subject: [PATCH bpf 2/2] selftests/bpf: Add test for unpinning htab with internal timer struct
Date: Fri,  3 Oct 2025 16:45:28 +0800
Message-ID: <20251003084528.502518-3-kafai.wan@linux.dev>
In-Reply-To: <20251003084528.502518-1-kafai.wan@linux.dev>
References: <20251003084528.502518-1-kafai.wan@linux.dev>
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
---
 .../selftests/bpf/prog_tests/pinning_htab.c   | 37 +++++++++++++++++++
 .../selftests/bpf/progs/test_pinning_htab.c   | 25 +++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_htab.c

diff --git a/tools/testing/selftests/bpf/prog_tests/pinning_htab.c b/tools/testing/selftests/bpf/prog_tests/pinning_htab.c
new file mode 100644
index 000000000000..fc804bb87b26
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/pinning_htab.c
@@ -0,0 +1,37 @@
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
+	if (!ASSERT_OK(err, "bpf_map__unpin"))
+		goto out;
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


