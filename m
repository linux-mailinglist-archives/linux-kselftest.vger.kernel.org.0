Return-Path: <linux-kselftest+bounces-47226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F95CAA85F
	for <lists+linux-kselftest@lfdr.de>; Sat, 06 Dec 2025 15:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 009FD3184028
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Dec 2025 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07B73B8D67;
	Sat,  6 Dec 2025 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SROky8ix"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E122566D3
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Dec 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765030367; cv=none; b=nABzP3AW0cIq12/mBQcFvnp1pjZkpMOw0s5XJfDPl0EtFf1qddW1lprQ353A4gwh0W7pf9RHTris00bpw/rw2r4BRsRewyLMt7VLQhEjh9/lYcaWdrzfW8HUlyvAR87SioENVpzgFceoFkx9BHDG5VTSzH5KmQ55lzQlrEK4IlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765030367; c=relaxed/simple;
	bh=RyLNc6tGR9TNg64jOPUj6Yspxw5JjeAQPkK81wia8Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BK29yPO2TL7tP97QeAjoGFLson7UcLRyW7eKS/UvbNgUAuXAiwUzFTfzIQd1MD6Pq/RbMU28GqJr9hbGznG1QL0t0NaiWvKkt0zY5skAJdUXec8eJUlPnuzzLSctou0vPUQKbPSBGCyH8rnAlMVo7Bk73qY2OsQ8M/obST1Ai7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SROky8ix; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7866bca6765so26522457b3.1
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Dec 2025 06:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765030365; x=1765635165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQZxjdZr1JFznsMXvmLRudCv2FwHA4P8i6Bo9rkQABI=;
        b=SROky8ixQmsBP6UyEbIMRkrKLJAZnHUgL+m8L6zePEYFs80Nuu8zweBXh8wKmOHXDf
         Nnt9nl06b6PCQxyrMQeMN7W+9g0nCw/vc9w32H4DgC8A0f7pD2HsnQb2SKbgY0qya/57
         LlMH+FMNRmll/XzfECV+uwtKHm9+yKSB11+70K0EKX7VdxhZRz87C2aR1l2cdvT88I4g
         g6VyRwowMoIScb7z0INkpongiXXGn7NowLna4cWHWpaFOZnngbsccJQRXnnJggRDf2GX
         OrJ+veVJcfBWG9slXmftQesbYTZLSTKt3O045my3O4JoRNH6mO83vm+DP7lGMmoX28s+
         A8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765030365; x=1765635165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jQZxjdZr1JFznsMXvmLRudCv2FwHA4P8i6Bo9rkQABI=;
        b=H9BJCeL0nmiYg2F/xlaSoBgy3zEWKW5wAYAEOovwRmt3UXk6sT9wz80pd9xFBZBnHv
         4oROXBf9tNVPFdnd0ISsaQ4HNNBDbMHPezgWX6qUaUSQV3S707J5camcqG26VZ33GuDc
         1JTLM0CCGPl9P40f2mT8SupTwI946PZabkyRSZ9ThUQnjKJv1K46sP1kkBZhDQvi07x8
         2wQWl8JbJQpq4Ezuhp9cGGfc7cHE5BO//c34bmRY+q8lF1KC31SMshuL7ATP2uCqxPld
         eqK5W7v6/t9oaep/AcPIYjIFofQrazqZ29YOu0K8Sb1+aGN40pBJ8V9pU/bM30Rp16/D
         BF3w==
X-Forwarded-Encrypted: i=1; AJvYcCW/bH6Wsdbh/hsXucvLufK87djORFsFOMljUCWu9eBXQ1WPlI+GLokiDUvhCBqOchKUBDFHkzK4Dzj8P0L862c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy10aPYpqDy0GwcF9plrokEUnUmGEN01yDSbpeWyXPhrihV1+R4
	y5kn+n86tSecOLZ711kq3o87L/Plza+e61LQ8Xa0cbXTTrSTxU/N9bom
X-Gm-Gg: ASbGnctAx2hCacu9dWFRzFNRuaZy6S0/jFXLXn+ejBIYohz92lMJ9koc1vqEeZyQyB3
	hQX7Pk1G2DlRXWx1E6KGhosX67UmXcHkkCd+xzOKqDMM7Qh4PiT3g3zFggCJJnwCqMJ/IDAFHyE
	adP2w647THXzcDR+NV5Afql93BjaqNh/W9SVXYeQFxckE9MkMxBICm5BDbYL4N8jNnnD4e/dZGq
	yUUtzeajfYXszmYN6YvQkJzyOjtD0E8LQAJEdN2RHfI8sFj66nzjNmpd6lDJpWKY7M+8WYciVv7
	8XARD1uLQJTBszx2B6rPoErELP2Hl3akcSTo217yHa9s03qrQjZ4eNZisQUQIgBo1HLCjKE6Q9n
	GWPK+VfKohlT5xyORjxmMGSPeeKR0dfeX+ZPm/d8mpRKCS268vKk3WZzFeFOuLpV6n7eYN/1nbS
	CSAhta2cSCrTNqAFBqzlPLb/IvzSmlsDN8PbhZ3yX7USSCpLIxu1s=
X-Google-Smtp-Source: AGHT+IHR9Zx/p3K68sJ975Kv+S2nxQ3ATWRfBJAUvnr4+LZUE0dZ7nv8fk2XnB0qEp03jLan5S47PA==
X-Received: by 2002:a05:690c:4512:b0:78c:2edf:5860 with SMTP id 00721157ae682-78c33afd090mr19846137b3.13.1765030364909;
        Sat, 06 Dec 2025 06:12:44 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4ae534sm28038027b3.3.2025.12.06.06.12.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Dec 2025 06:12:44 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dxu@dxuuu.xyz,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	electronlsr@gmail.com,
	Zesen Liu <ftyg@live.com>,
	Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: [PATCH bpf v5 2/2] selftests/bpf: add regression test for bpf_d_path()
Date: Sat,  6 Dec 2025 22:12:10 +0800
Message-ID: <20251206141210.3148-3-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251206141210.3148-1-electronlsr@gmail.com>
References: <20251206141210.3148-1-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test for bpf_d_path() to cover incorrect verifier
assumptions caused by an incorrect function prototype. The test
attaches to the fallocate hook, calls bpf_d_path() and verifies that
a simple prefix comparison on the returned pathname behaves correctly
after the fix in patch 1. It ensures the verifier does not assume
the buffer remains unwritten.

Co-developed-by: Zesen Liu <ftyg@live.com>
Signed-off-by: Zesen Liu <ftyg@live.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/d_path.c | 91 +++++++++++++++----
 .../testing/selftests/bpf/progs/test_d_path.c | 23 +++++
 2 files changed, 96 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index ccc768592e66..1a2a2f1abf03 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -38,6 +38,14 @@ static int set_pathname(int fd, pid_t pid)
 	return readlink(buf, src.paths[src.cnt++], MAX_PATH_LEN);
 }
 
+static inline long syscall_close(int fd)
+{
+	return syscall(__NR_close_range,
+			(unsigned int)fd,
+			(unsigned int)fd,
+			0u);
+}
+
 static int trigger_fstat_events(pid_t pid)
 {
 	int sockfd = -1, procfd = -1, devfd = -1;
@@ -104,36 +112,47 @@ static int trigger_fstat_events(pid_t pid)
 	/* sys_close no longer triggers filp_close, but we can
 	 * call sys_close_range instead which still does
 	 */
-#define close(fd) syscall(__NR_close_range, fd, fd, 0)
-
-	close(pipefd[0]);
-	close(pipefd[1]);
-	close(sockfd);
-	close(procfd);
-	close(devfd);
-	close(localfd);
-	close(indicatorfd);
-
-#undef close
+	syscall_close(pipefd[0]);
+	syscall_close(pipefd[1]);
+	syscall_close(sockfd);
+	syscall_close(procfd);
+	syscall_close(devfd);
+	syscall_close(localfd);
+	syscall_close(indicatorfd);
 	return ret;
 }
 
+static void attach_and_load(struct test_d_path **skel)
+{
+	int err;
+
+	*skel = test_d_path__open_and_load();
+	if (CHECK(!*skel, "setup", "d_path skeleton failed\n"))
+		goto cleanup;
+
+	err = test_d_path__attach(*skel);
+	if (CHECK(err, "setup", "attach failed: %d\n", err))
+		goto cleanup;
+
+	(*skel)->bss->my_pid = getpid();
+	return;
+
+cleanup:
+	test_d_path__destroy(*skel);
+	*skel = NULL;
+}
+
 static void test_d_path_basic(void)
 {
 	struct test_d_path__bss *bss;
 	struct test_d_path *skel;
 	int err;
 
-	skel = test_d_path__open_and_load();
-	if (CHECK(!skel, "setup", "d_path skeleton failed\n"))
-		goto cleanup;
-
-	err = test_d_path__attach(skel);
-	if (CHECK(err, "setup", "attach failed: %d\n", err))
+	attach_and_load(&skel);
+	if (!skel)
 		goto cleanup;
 
 	bss = skel->bss;
-	bss->my_pid = getpid();
 
 	err = trigger_fstat_events(bss->my_pid);
 	if (err < 0)
@@ -195,6 +214,39 @@ static void test_d_path_check_types(void)
 	test_d_path_check_types__destroy(skel);
 }
 
+/* Check if the verifier correctly generates code for
+ * accessing the memory modified by d_path helper.
+ */
+static void test_d_path_mem_access(void)
+{
+	int localfd = -1;
+	char path_template[] = "/dev/shm/d_path_loadgen.XXXXXX";
+	struct test_d_path__bss *bss;
+	struct test_d_path *skel;
+
+	attach_and_load(&skel);
+	if (!skel)
+		goto cleanup;
+
+	bss = skel->bss;
+
+	localfd = mkstemp(path_template);
+	if (CHECK(localfd < 0, "trigger", "mkstemp failed\n"))
+		goto cleanup;
+
+	if (CHECK(fallocate(localfd, 0, 0, 1024) < 0, "trigger", "fallocate failed\n"))
+		goto cleanup;
+	remove(path_template);
+
+	if (CHECK(!bss->path_match_fallocate, "check",
+		  "failed to read fallocate path"))
+		goto cleanup;
+
+cleanup:
+	syscall_close(localfd);
+	test_d_path__destroy(skel);
+}
+
 void test_d_path(void)
 {
 	if (test__start_subtest("basic"))
@@ -205,4 +257,7 @@ void test_d_path(void)
 
 	if (test__start_subtest("check_alloc_mem"))
 		test_d_path_check_types();
+
+	if (test__start_subtest("check_mem_access"))
+		test_d_path_mem_access();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
index 84e1f883f97b..561b2f861808 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path.c
@@ -17,6 +17,7 @@ int rets_close[MAX_FILES] = {};
 
 int called_stat = 0;
 int called_close = 0;
+int path_match_fallocate = 0;
 
 SEC("fentry/security_inode_getattr")
 int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
@@ -62,4 +63,26 @@ int BPF_PROG(prog_close, struct file *file, void *id)
 	return 0;
 }
 
+SEC("fentry/vfs_fallocate")
+int BPF_PROG(prog_fallocate, struct file *file, int mode, loff_t offset, loff_t len)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+	int ret = 0;
+	char path_fallocate[MAX_PATH_LEN] = {};
+
+	if (pid != my_pid)
+		return 0;
+
+	ret = bpf_d_path(&file->f_path,
+			 path_fallocate, MAX_PATH_LEN);
+	if (ret < 0)
+		return 0;
+
+	if (!path_fallocate[0])
+		return 0;
+
+	path_match_fallocate = 1;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.52.0


