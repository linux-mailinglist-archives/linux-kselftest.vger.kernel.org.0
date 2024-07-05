Return-Path: <linux-kselftest+bounces-13211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D89928080
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 04:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CD11F22B33
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 02:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380CE1B806;
	Fri,  5 Jul 2024 02:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9ciZBWS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102953B1A1;
	Fri,  5 Jul 2024 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147124; cv=none; b=WhVlcn9EoxhbNB/+P373bQPsOS+cprX/69Jul4hokIZTM3f5nHell2FWdYlByqMH4vGkn/pJnE4MtkZ9bowAoAXfZ867Uf+bkB73ZzEnFbnAcq3rn4YsWysb4lDEQ5ZdcsIna2y157sr6tSwRErBe6dfQ3eB6dq1tz8qOGGqPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147124; c=relaxed/simple;
	bh=BSu0sthLEzqVrgWAVpw1r7LFUemnpAfQLRLMaHz4GtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJtuioNZxQpyAwDnwfmljweAkmxZuAKGO2aCjnjQlLjtDe4WOrJg7Rgsco1jNOA9bXVzCmEe2WSA3ssNxK0bJ7EVayhZjko9pMvVNLgxjowg3KC4da8DC3QveRauM02eEz9kKYkq5z9Vnym8KfUrqKccQSatLSfa3aWS+7pBK10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9ciZBWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883A6C32781;
	Fri,  5 Jul 2024 02:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720147123;
	bh=BSu0sthLEzqVrgWAVpw1r7LFUemnpAfQLRLMaHz4GtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g9ciZBWSTX0ex2kb34IZOt2Ue2hgxARjhNALcdXVQ2bdyPJ+TZer/iJbHpj902W0b
	 ts4xjMh+M1GQUsC30Bt9r9+16w8/d+KU3OE8TiluUwIOOHnNjYNCJIWehu+TnizrXm
	 w+wVIKoK8gYJ+b1G0P/KB/ELVdTLeRxPFeE1mRJUBnaHDS2Pqw5AI4wFgLM1S4Lc7K
	 jGIYUv0+S8vK25bme583OQ/e3P3VZH8qjTuaF1uq0di2vjQI1cWdhIe/yP9p/GNecE
	 9c3UzJ9Kp5UxamiWE3xJr+sWI59VzRCxmwt128BcTvYTpB/V2vIncBLP3G9DlefsK1
	 WWn/vsoLeP9OA==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 2/6] selftests/bpf: Skip ENOTSUPP in ASSERT_OK
Date: Fri,  5 Jul 2024 10:38:20 +0800
Message-ID: <f6773559686a553269d84870eb23142e2dc1dc8c.1720146231.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720146231.git.tanggeliang@kylinos.cn>
References: <cover.1720146231.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Just like handling ENOTSUPP in test_lsm_cgroup_functional(), this patch
adds a new helper test_progs_get_error() to check whether the input error
is ENOTSUPP (524) or ENOTSUP (95). If it is, invoke test__skip() to skip
the test instead of using test__fail().

Use this helper in ASSERT_OK() before invoking CHECK() macro.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/lsm_cgroup.c     |  6 +----
 tools/testing/selftests/bpf/test_progs.h      | 23 +++++++++++++++++--
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
index 6df25de8f080..6511f5f4a00f 100644
--- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
@@ -102,12 +102,8 @@ static void test_lsm_cgroup_functional(void)
 	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 0, "prog count");
 	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 0, "total prog count");
 	err = bpf_prog_attach(alloc_prog_fd, cgroup_fd, BPF_LSM_CGROUP, 0);
-	if (err == -ENOTSUPP) {
-		test__skip();
-		goto close_cgroup;
-	}
 	if (!ASSERT_OK(err, "attach alloc_prog_fd"))
-		goto detach_cgroup;
+		goto close_cgroup;
 	ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 1, "prog count");
 	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 1, "total prog count");
 
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 930a4181dbd9..d1d77785b165 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -176,6 +176,23 @@ void test__skip(void);
 void test__fail(void);
 int test__join_cgroup(const char *path);
 
+static inline bool test_progs_check_errno(int error, int check)
+{
+	return error == -check ||
+	       (error && errno == check);
+}
+
+static inline int test_progs_get_error(int error)
+{
+	if (test_progs_check_errno(error, ENOTSUP) ||
+	    test_progs_check_errno(error, ENOTSUPP)) {
+		test__skip();
+		return 0;
+	} else {
+		return error;
+	}
+}
+
 #define PRINT_FAIL(format...)                                                  \
 	({                                                                     \
 		test__fail();                                                  \
@@ -338,8 +355,10 @@ int test__join_cgroup(const char *path);
 	static int duration = 0;					\
 	long long ___res = (res);					\
 	bool ___ok = ___res == 0;					\
-	CHECK(!___ok, (name), "unexpected error: %lld (errno %d)\n",	\
-	      ___res, errno);						\
+	if (test_progs_get_error(___res))				\
+		CHECK(!___ok, (name),					\
+		      "unexpected error: %lld (errno %d)\n",		\
+		      ___res, errno);					\
 	___ok;								\
 })
 
-- 
2.43.0


