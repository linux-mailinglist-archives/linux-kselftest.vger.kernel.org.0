Return-Path: <linux-kselftest+bounces-46976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64533CA2AE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 08:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2E1E3006E11
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 07:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2118B30146A;
	Thu,  4 Dec 2025 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7dSRs1t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3AD2FFF95
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764834439; cv=none; b=CuqAe/ft1sV5SaOO7DU/R+Z1W15NkQnYwprOmBMAVYm3JcQqT0b0gsxPpPgUYwb1Thpd6vkBMXZMaVuiAL2Vqzd0/lDbXfZK39TFi7rb13khsldHaUZUXbUZzqi3FgcaeXeYdjUa9dXUPIfif46y43qCKP6pmse/mcKTT9gFOos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764834439; c=relaxed/simple;
	bh=qdhWcqd9hT93rtUBAlBAvb3lgGVFKACqYB4PFwedTe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUu4ZjmbogneQy679BaCjfB+edtfIUD5q5tqnILHID8y2c7UKfNDP+nYFPCrUtKGtarLqW0jADzFWxa+84oVXSMXkrOTb1RWDlNYcyZkoWf4CY3RagBy9OmC4tU2Eet882Q8IBEyEtQzuhPJu3rfTcbywzM0+cydzzIs7nshjW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7dSRs1t; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-640c9c85255so1010692d50.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 23:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764834435; x=1765439235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIKIbTcJdT1eJhgdOyO7DT2bXa3Lo/jwod4ftd3kt6E=;
        b=W7dSRs1teUFKL6dJVz8GhSZuMsoI1xlV46siXhpcARXWRoubEmIEXdyhg5ggSbje+b
         lzSdTrYNkFOcxDJlEGNWjyZrRaQtsM4KmdyRpOW2pheoJcCKG/A2E59biy46CULBL/tW
         tN+0+h9KuFATru5N2suLpJQsyAYeGuzRjUPoFLrvCVry0E3kMRUk4cT6AS7DpyL5CvMA
         9RtTAUXFNHJ/8/WKZeicwAVd9+I9D2PCxmqTKj1+/s2HZt8p+r+qvCySkdrH39MiCCZN
         5T0i5ybKV73D32dA0Scb3W+49EaEOW6WM43675FJR/spdtz4drDsXJPVOKK7+dFIckIK
         ktsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764834435; x=1765439235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gIKIbTcJdT1eJhgdOyO7DT2bXa3Lo/jwod4ftd3kt6E=;
        b=R5hGY/lqP8bBjuJ9yDwToV0GZg9eSJ15iu0U7uMZI8n9v/OHLANqRZ6xFDrGbSgVYF
         GXGzGYGWVSZToxj//nSZ3PZim8BcsJhBcc1qEboTRTcODXZCb95PmntSxriPou2B/k/i
         M4k+F2lTYGfykhYFXBZryx2xwtVty8QVXqd9RlU8V4xp/VoP/dVGkuJghron2H6Dcshd
         b7CaQxJs5SLvJvIgfvRi2YYwzYPGYs093h+0KEDYamjzHjVXGF56AhskNvhc+sLmM/hS
         5/rJ9Y642/D3O6tb0i+/LBTOoFiF4Rw0OU5fKT8dBU/AyZO7ek1fMMNPhtbRTSaOs610
         J3pA==
X-Forwarded-Encrypted: i=1; AJvYcCXr8Am17asuEkazClmua57MGYjN/sPsvp+nT4kuZD6L208UFJHY5kPoI77UGmSki5Nn7YoBU/2+7vcUfHjD/Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzByop8AG6ag8QHLbxICnQipdCRUTvOR8vFdU0OsYc7yUgf+nEL
	8lfwFnTUr3wd11l2xgiuripDCsy3cqAmzjcpXW86hYUHemasVeqsAmB1
X-Gm-Gg: ASbGncuvLzQQdqHL7dnnxmkH+ZOGgJFSjgCeZl0jKDwC47E+5FpQq/aazyTOZMp97Wp
	NnaVIVmhhsv2FhFn+jhGfpdqpOPsI2vpRLYyeOuxa3fEORMwJZVlgiE2ZT3OMiQnjA6eHUZ44Rb
	GtDC2nG5M3tE3wWMQ66k84euKaYjibrCg+viHOLimduwdo5DNNWRKe7gcGALiC3QgXWpwvFA7Ny
	0SiVyrHuPwtATcKUfuiBXKtJL5rUo4cs+G4tE0FPpVsNMEaiXNLLifwqRUcH00+XkHxeQozuUyk
	iSrCbiO7jEbF0BKK7ppjbu7XpmpzeXuNel9POYBE9AP+hNT3oZUj8SLeIkQR0KJ3TCp6tSKsYcq
	5FTiVI6NGK4+EsfsuQTFjg3AzSRgoQyAohzPjNsr9W3zL7YQJLMRo6+fFiK+T12I7f8gNjDISwU
	3IsH8FaXUGkeVvsRhdfgyRLj2LXK1drGD/lGpcYRnPmEjF/a2xcLk=
X-Google-Smtp-Source: AGHT+IFirMTbIE/Mz7SxmZusKuVHpn4JgrMCYE3NcUS/x+ulC6+n3iKo4YojdR5CaekHTbK8K19xlQ==
X-Received: by 2002:a05:690e:16a0:b0:641:f5bc:68d5 with SMTP id 956f58d0204a3-6443d961614mr1540601d50.82.1764834435301;
        Wed, 03 Dec 2025 23:47:15 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f5bcbbesm364495d50.23.2025.12.03.23.47.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 23:47:15 -0800 (PST)
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
Subject: [PATCH bpf v4 2/2] selftests/bpf: add regression test for bpf_d_path()
Date: Thu,  4 Dec 2025 15:46:32 +0800
Message-ID: <20251204074632.8562-3-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251204074632.8562-1-electronlsr@gmail.com>
References: <20251204074632.8562-1-electronlsr@gmail.com>
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
 .../testing/selftests/bpf/prog_tests/d_path.c | 90 +++++++++++++++----
 .../testing/selftests/bpf/progs/test_d_path.c | 23 +++++
 2 files changed, 95 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index ccc768592e66..c725d5258e65 100644
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
@@ -195,6 +214,38 @@ static void test_d_path_check_types(void)
 	test_d_path_check_types__destroy(skel);
 }
 
+/* Check if the verifier correctly generates code for
+ * accessing the memory modified by d_path helper.
+ */
+static void test_d_path_mem_access(void)
+{
+	int localfd = -1;
+	struct test_d_path__bss *bss;
+	struct test_d_path *skel;
+
+	attach_and_load(&skel);
+	if (!skel)
+		goto cleanup;
+
+	bss = skel->bss;
+
+	localfd = open("/tmp/d_path_loadgen.txt", O_CREAT | O_RDWR, 0644);
+	if (CHECK(localfd < 0, "trigger", "open /tmp/d_path_loadgen.txt failed\n"))
+		goto cleanup;
+
+	if (CHECK(fallocate(localfd, 0, 0, 1024) < 0, "trigger", "fallocate failed\n"))
+		goto cleanup;
+	remove("/tmp/d_path_loadgen.txt");
+
+	if (CHECK(!bss->path_match_fallocate, "check",
+		  "failed to match actual opened path"))
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
@@ -205,4 +256,7 @@ void test_d_path(void)
 
 	if (test__start_subtest("check_alloc_mem"))
 		test_d_path_check_types();
+
+	if (test__start_subtest("check_mem_access"))
+		test_d_path_mem_access();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
index 84e1f883f97b..2f9b4cb67931 100644
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
+	if (path_fallocate[0] != '/')
+		return 0;
+
+	path_match_fallocate = 1;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.52.0


