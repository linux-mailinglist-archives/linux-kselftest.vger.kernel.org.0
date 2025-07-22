Return-Path: <linux-kselftest+bounces-37846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63220B0E0A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 17:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA69AA7167
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F49127877F;
	Tue, 22 Jul 2025 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bqJBRSpm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B50279788
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Jul 2025 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198546; cv=none; b=I3BltKUAw1lLWAvn+AVdqSPcL2tznmHkYH4Q026gjp/uDM1/9TyKmJNfHhGahmrfF3gzX1Py0Mj7DcpBnQN+NeMNe5SVfQ+45n1QWe7NhS9j4s5nUpv/+oDqhaIeHMjwA8k10hYwnhuq0PQaWtbGc6SCGmnjvD6eZTL9/o7fsBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198546; c=relaxed/simple;
	bh=9e+XKFTuYCdgCVl3Q/4BvVejCNYn6MdSnw4Hrx+qNv8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1fXO57jJC3SZEDT7Sli27m64aeNLPUOJ+KfAGwbM3HFtgFtZZoXpeT0ZOfR5FA8M31sGY/LK2oCjM0Vi3YNSOSfPmI0wr/K+I4nVO9FQEon3LgtJxOwLSoyWdXiSou+kYnl48rghh6KAKpggVWL2axutCd3CZYOaKH2M5Pvvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bqJBRSpm; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753198542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKvCoJGwfEdOcx6kKVh6JIG3YvhFXp1tkarpnDQix0E=;
	b=bqJBRSpmZYEXLm8VW24lyyvd4RansGm7NCdEVx+EW6qIO1BFoSjJit0HKXpDMn9CsuWLdz
	aT7muHovUxe6StfTxt2TStSKJpKoWfnxtuXPHz2c4OXfkb/+ncIor0Mj4To5gOHeS53gGI
	61sBQFQ0PhXufvi1J7W1GGLpPsfYRg4=
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
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: Add selftest for attaching tracing programs to functions in deny list
Date: Tue, 22 Jul 2025 23:34:33 +0800
Message-ID: <20250722153434.20571-4-kafai.wan@linux.dev>
In-Reply-To: <20250722153434.20571-1-kafai.wan@linux.dev>
References: <20250722153434.20571-1-kafai.wan@linux.dev>
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
---
 .../bpf/prog_tests/tracing_failure.c          | 33 +++++++++++++++++++
 .../selftests/bpf/progs/tracing_failure.c     |  6 ++++
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
index a222df765bc3..140fb0d175cf 100644
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
+	/* migrate_disable depends on CONFIG_SMP */
+	btf_id = libbpf_find_vmlinux_btf_id("migrate_disable", BPF_TRACE_FENTRY);
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
+			  "Attaching tracing programs to function 'migrate_disable' is rejected.",
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
index d41665d2ec8c..dfa152e8194e 100644
--- a/tools/testing/selftests/bpf/progs/tracing_failure.c
+++ b/tools/testing/selftests/bpf/progs/tracing_failure.c
@@ -18,3 +18,9 @@ int BPF_PROG(test_spin_unlock, struct bpf_spin_lock *lock)
 {
 	return 0;
 }
+
+SEC("?fentry/migrate_disable")
+int BPF_PROG(tracing_deny)
+{
+	return 0;
+}
-- 
2.43.0


