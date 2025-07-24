Return-Path: <linux-kselftest+bounces-37952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3507DB10E70
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFB4AC13A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97DC2EA17F;
	Thu, 24 Jul 2025 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gTh4jrgI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8732E9EA7
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370139; cv=none; b=pAqSMFLCFILwJWYa9+grur6j3PCnHM6Pes911qrqsSu+pkwzHwECxCkwYHdh2jYxGT3qSaSRfBnumfqqR/y2o9h8kSsykNXtHs5TVgcxJy9jMBfAKZVJR0hSoUnwGd/rIEHrl0Z/NztL3mt6s75jT33lC/gQjky/Li7iUJSFGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370139; c=relaxed/simple;
	bh=7EsDP/Fm9RStnbVDQxKJFKXsDu1UwZfNu5wEoQXfbNk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GowUjcBa6zR8ZMUm3TV6ACk9WA27pdYBBWMFC6Xm7wq3f6Lx1FnoRORMdOljya4CEn25W+f2h24M01tSe43thx1XmZQRUA8SNy1jKEi3F8Riz9XXHMJtoTHOW93ejbgUUZkMegFf6Cjmq6oKLIA/daN2QsTytRpWRchVKPM3oWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gTh4jrgI; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753370135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gB/b4dExKC5RzJhSjSIUjOlVRtfW8Hfg6IyEFR+9/TA=;
	b=gTh4jrgIYcgHC2Sj0/xMTM5uelqaEmG24T3lDSDU5/oqyGEHxQWBezCqljCKYUfJE9oTn+
	EO6GIHtz+hwIay6h3Mkt1jvd2u/i/Uk9frmd3X0l8CSOG7jy7DpoLiclzZ+r4omXWi6rLp
	T5oMR7QTWmBx/te9PaTwm2bcfckDkk0=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next v4 3/4] selftests/bpf: Add selftest for attaching tracing programs to functions in deny list
Date: Thu, 24 Jul 2025 23:14:53 +0800
Message-ID: <20250724151454.499040-4-kafai.wan@linux.dev>
In-Reply-To: <20250724151454.499040-1-kafai.wan@linux.dev>
References: <20250724151454.499040-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The result:

 $ tools/testing/selftests/bpf/test_progs -t tracing_failure/tracing_deny
 #468/3   tracing_failure/tracing_deny:OK
 #468     tracing_failure:OK
 Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/tracing_failure.c          | 33 +++++++++++++++++++
 .../selftests/bpf/progs/tracing_failure.c     |  6 ++++
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
index a222df765bc3..39b59276884a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
@@ -28,10 +28,43 @@ static void test_bpf_spin_lock(bool is_spin_lock)
 	tracing_failure__destroy(skel);
 }
 
+static void test_tracing_deny(void)
+{
+	struct tracing_failure *skel;
+	char log_buf[256];
+	int btf_id, err;
+
+	/* __rcu_read_lock depends on CONFIG_PREEMPT_RCU */
+	btf_id = libbpf_find_vmlinux_btf_id("__rcu_read_lock", BPF_TRACE_FENTRY);
+	if (btf_id <= 0) {
+		test__skip();
+		return;
+	}
+
+	skel = tracing_failure__open();
+	if (!ASSERT_OK_PTR(skel, "tracing_failure__open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.tracing_deny, true);
+	bpf_program__set_log_buf(skel->progs.tracing_deny, log_buf, sizeof(log_buf));
+
+	err = tracing_failure__load(skel);
+	if (!ASSERT_ERR(err, "tracing_failure__load"))
+		goto out;
+
+	ASSERT_HAS_SUBSTR(log_buf,
+			  "Attaching tracing programs to function '__rcu_read_lock' is rejected.",
+			  "log_buf");
+out:
+	tracing_failure__destroy(skel);
+}
+
 void test_tracing_failure(void)
 {
 	if (test__start_subtest("bpf_spin_lock"))
 		test_bpf_spin_lock(true);
 	if (test__start_subtest("bpf_spin_unlock"))
 		test_bpf_spin_lock(false);
+	if (test__start_subtest("tracing_deny"))
+		test_tracing_deny();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_failure.c b/tools/testing/selftests/bpf/progs/tracing_failure.c
index d41665d2ec8c..58d2777014e1 100644
--- a/tools/testing/selftests/bpf/progs/tracing_failure.c
+++ b/tools/testing/selftests/bpf/progs/tracing_failure.c
@@ -18,3 +18,9 @@ int BPF_PROG(test_spin_unlock, struct bpf_spin_lock *lock)
 {
 	return 0;
 }
+
+SEC("?fentry/__rcu_read_lock")
+int BPF_PROG(tracing_deny)
+{
+	return 0;
+}
-- 
2.43.0


