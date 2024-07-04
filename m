Return-Path: <linux-kselftest+bounces-13166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A906926FEF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 08:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01140B21778
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 06:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC001A08C5;
	Thu,  4 Jul 2024 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAl46Mx/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645EE1A072F;
	Thu,  4 Jul 2024 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075713; cv=none; b=Y7OJkCW9yabEvsydy8wbQ+uL/BCrnqfKRbwv6IDbDwdIB177XcL5I9rfhO6sniNaTzCc0Dp7MBl6HDo9LXDvF8qHReTTVXc8r2qAe5ntqNXpIrp1N3FKcdN+aAmZzssThelzc0+yY8TI82tlXfwwEmIGW7ntlUn9jvbq2qQ/20s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075713; c=relaxed/simple;
	bh=uOaIVfz5RfQqH0iY+EtTeoqdXo5UjZY01UReZZmwiy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehcchF8si7rvYWcilqS3QY0iwnfcSMySq2iyiVYb4sZQCEOBT0bBSJVssF6GP057yxfryNQcwLbqNjgSjZhssWWUu5xT/ZQ9fUUvTIEdZZJBbp6Zuyub9JsukKYqek96ShztoGeiEoCmCSFu5Dgg1B7ujNS65BK9Mo0Z4H++pXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAl46Mx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4FEC4AF0F;
	Thu,  4 Jul 2024 06:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720075713;
	bh=uOaIVfz5RfQqH0iY+EtTeoqdXo5UjZY01UReZZmwiy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAl46Mx/YbPy+OwsnwY+RW/7XWgAHsRfz4VZvsLf1Bow6ahTL07KYRgCa0WvrgoVS
	 EJlenqAT9b+DckNUEGLbVjvk/rQaHlCaUw0pH0vHDGChifQI8MT0pTuEgXpf2FEwW2
	 cRNvwnXKiwib+Lq8AUNPH0lhT/hRSgDkXEqM+khcx2/QMWCgw9S4AznYJFWeQPc6FU
	 rFTUvI6g5RWumMXlpPFnLIeHFexGrCaeDjKY3D1MtOeEKGIjwfBGCq07Yu1dnhXxn4
	 mJNO17rznkMqwQddhbtIOg7/kx8mS/Ivq/RtEhIXS+ujvIrAJMkl235POZ/C4Whh3C
	 9mA4piY5j8Obg==
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
Subject: [PATCH 2/6] selftests/bpf: Skip ENOTSUPP in ASSERT_OK
Date: Thu,  4 Jul 2024 14:48:02 +0800
Message-ID: <9e037774bb1fe1e374900f32d2ceab47e6986e07.1720075006.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720075006.git.tanggeliang@kylinos.cn>
References: <cover.1720075006.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Just like handling ENOTSUPP in test_lsm_cgroup_functional(), this patch
checks ENOTSUPP (524) and ENOTSUP (95) in ASSERT_OK(), invoke test__skip()
in this case instead of test__fail().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c | 6 +-----
 tools/testing/selftests/bpf/test_progs.h            | 9 +++++++--
 2 files changed, 8 insertions(+), 7 deletions(-)

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
index 0ba5a20b19ba..25f6976c08b5 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -338,8 +338,13 @@ int test__join_cgroup(const char *path);
 	static int duration = 0;					\
 	long long ___res = (res);					\
 	bool ___ok = ___res == 0;					\
-	CHECK(!___ok, (name), "unexpected error: %lld (errno %d)\n",	\
-	      ___res, errno);						\
+	if (___res == -ENOTSUPP || ___res == -ENOTSUP ||		\
+	    errno == ENOTSUPP || errno == ENOTSUP)			\
+		test__skip();						\
+	else								\
+		CHECK(!___ok, (name),					\
+		      "unexpected error: %lld (errno %d)\n",		\
+		      ___res, errno);					\
 	___ok;								\
 })
 
-- 
2.43.0


