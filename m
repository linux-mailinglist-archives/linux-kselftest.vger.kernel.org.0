Return-Path: <linux-kselftest+bounces-46880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8E8C9BC13
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 15:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23593A7262
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8B2206B1;
	Tue,  2 Dec 2025 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnhlbduH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22854212550
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685244; cv=none; b=ILZcPr6p0is7BTLOiHnGrYOcmgBPUByCgSds1M9ZWUwQMxJWvJsghDUWVrcfvUfuajNVHH0pi4qpOKrKGe57Ux6Bj1Ow9vLoQJYv3qPBxMBR4l5eli6rtaC9zwvMla4yL/dYnitmwA+H/Ab3Pbwk/uJk1sH5CYic2Tt+5yVf/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685244; c=relaxed/simple;
	bh=7rNRVsnWPfFx3+IF5zUAQsCTaovZHytc40juokjkxX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJUhVNQKe0ezrsCiuwdPswMHwKRv/wKjNByiZ+Mu3eHxtVWY2bGVdDNFGS2hTzoRZ05EDJY7Tc5d+A/2rJv67lMpWo+PkmJ1KT58cajy+9m8o/IvdPzAxbKf0HCHGShzb7aB+ozyd3kIsq3DZm4O75u+apmH6QS3cE5DOF5On2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnhlbduH; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-640c9c85255so7085245d50.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 06:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764685242; x=1765290042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVNmyf0pWuOFm8GFUHmjQWORKGxH+2nm5rY1pk1lD/A=;
        b=lnhlbduH/A/gc+80XkbCZnmkBtilJ/XmqhxxW3buysRmJn0OhWi530sHlBek7ap/iX
         pfkdPzCBmhr3rG9We0u2dQRC5I8TOg9IJeVG5yDaxxUeaIuzp9x4BzQ603k6ZV+Kk2ix
         mrW8ytd91D//lYWAF+uM9Yzb+po1olqShKaAEvYiWdj2OQE3gDJOuSa1VxagrOcsWPTk
         EUdReZUNHlac96HrmIXDmoYtwkzL7YF1YF0CAN7inAiTyxeyTRwc8mCkgC60aCBW0Fcj
         Ru+ESTTEIW9e9CCzk13Uo2vK6/kClWe+LW3C1nHddZewmyKuj6yZ8oZO+HMtApLcjFKi
         Crsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685242; x=1765290042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OVNmyf0pWuOFm8GFUHmjQWORKGxH+2nm5rY1pk1lD/A=;
        b=Y9LE273O6rdIZ793ZFDTz6KEX6Ed2WkgZBgXKnzYpfusDOqqV8oOwoX6gCVC49pVi+
         lIkblFxJM7OH49zR1jkJJ0KV4jVBQF6khPnd6Yg8vnv5DqPdoLO//GGQZkntnwPs3/i4
         6U5pmxrJ5yvdWxquFGGA8L9f7iyIs3yLmjihkdCKdtRO+7vDYmJFF0CuamDdAt9As6JT
         COFVn0yDZ4pC219xt2Fs4wASClUc29gryNPjHF7an37tpEGS/J/jcdIfvUX7/S12uIny
         FqKTXnlFMX/9d/zIW13W8d4FxcRU+lC/rewzX1gy+PBKL+g3xSrAQQbAw71/ZmnxKT41
         rcIA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Zo5tvx4UcPHLObiEcz2VZln/4cafC5NXI03DbL2Jolz5wy+pIR7DOtNMVFDV96H8hF803vbiDBRwX8t2CFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk4EseIgTyA2NUlyGqKX16LLsjaUwJ08phVEsgzl4gLlOlK06J
	cRbKHbwz6eUnC8nTzJfIocoY9dI2U/4wygjNyHaXn+HrNMwYqgBaIIqz
X-Gm-Gg: ASbGncsHCR7J3F/aEe+hxSFUpexlHjY0b86ku+OE4rxg5HSGIl7nYLyUdPEZaBKGkL8
	54bbaYekfQv7knFYjPzhesH4gIwvfO8jaUg571x9OnUnTgIGi1dXR+ti6oIRdKWonn997g6lH2Z
	LoGiYCaM9gXdxEgi6Rmf1eYXhXRH3BtOCT0n7lcF3AlO9+8gciuu4vZbw+LQ742QWir/UnCWvPg
	8EtxEIo4J1+RHjah0SfjG29lXoWVVQVJ8aj/7u+mOK9xf3IGihGVpvgpJM6JI7v1hN4jPIhDVEy
	T9692GmZjRcpbxWXRYONCBjKEicuvQOUk0GAcIC2G9oWgiIxxt4Lr8nKUkvijXYy2AEU5XqdJEf
	ziNSKcfDZ+/SaEkqq3T5Qcm3+scTLSQ00QNdCGsAk+93NWFTfeTc28K0k/rcxH37eRgD8pGIEv6
	EJy+Eeu0wT8jFh5+Z1t/Nh9lkWfN9Brshrorn4KZyywiUpaXE2t2g=
X-Google-Smtp-Source: AGHT+IGXgMLsdqo31zDPO/L8sdWBlgV3+pT1zAXzGDGQV1LdsmvYxvbZjvz0x8ZTJqwbsZUGxS6wuA==
X-Received: by 2002:a05:690e:2445:b0:63e:1e08:daa8 with SMTP id 956f58d0204a3-643293b93ccmr17101392d50.62.1764685241823;
        Tue, 02 Dec 2025 06:20:41 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c497768sm6257715d50.25.2025.12.02.06.20.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Dec 2025 06:20:41 -0800 (PST)
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
Subject: [PATCH bpf v3 2/2] selftests/bpf: fix and consolidate d_path LSM regression test
Date: Tue,  2 Dec 2025 22:19:44 +0800
Message-ID: <20251202141944.2209-3-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251202141944.2209-1-electronlsr@gmail.com>
References: <20251202141944.2209-1-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test for bpf_d_path() when invoked from an LSM program.
The test attaches to the bprm_check_security hook, calls bpf_d_path() on
the binary being executed, and verifies that a simple prefix comparison on
the returned pathname behaves correctly after the fix in patch 1.

To avoid nondeterminism, the LSM program now filters based on the
expected PID, which is populated from userspace before the test binary is
executed. This prevents unrelated processes that also trigger the
bprm_check_security LSM hook from overwriting test results. Parent and
child processes are synchronized through a pipe to ensure the PID is set
before the child execs the test binary.

Per review feedback, the new LSM coverage is merged into the existing
d_path selftest rather than adding new prog_tests/ or progs/ files. The
loop that checks the pathname prefix now uses bpf_for(), which is a
verifier-friendly way to express a small, fixed-iteration loop, and the
temporary /tmp/bpf_d_path_test binary is removed in the test cleanup
path.

Co-developed-by: Zesen Liu <ftyg@live.com>
Signed-off-by: Zesen Liu <ftyg@live.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../testing/selftests/bpf/prog_tests/d_path.c | 65 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_d_path.c | 33 ++++++++++
 2 files changed, 98 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index ccc768592e66..202b44e6f482 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -195,6 +195,68 @@ static void test_d_path_check_types(void)
 	test_d_path_check_types__destroy(skel);
 }
 
+static void test_d_path_lsm(void)
+{
+	struct test_d_path *skel;
+	int err;
+	int pipefd[2];
+	pid_t pid;
+
+	skel = test_d_path__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "d_path skeleton failed"))
+		return;
+
+	err = test_d_path__attach(skel);
+	if (!ASSERT_OK(err, "attach failed"))
+		goto cleanup;
+
+	/* Prepare the test binary */
+	system("cp /bin/true /tmp/bpf_d_path_test 2>/dev/null || :");
+
+	if (!ASSERT_OK(pipe(pipefd), "pipe failed"))
+		goto cleanup;
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork failed")) {
+		close(pipefd[0]);
+		close(pipefd[1]);
+		goto cleanup;
+	}
+
+	if (pid == 0) {
+		/* Child */
+		char buf;
+
+		close(pipefd[1]);
+		/* Wait for parent to set PID in BPF map */
+		if (read(pipefd[0], &buf, 1) != 1)
+			exit(1);
+		close(pipefd[0]);
+		execl("/tmp/bpf_d_path_test", "/tmp/bpf_d_path_test", NULL);
+		exit(1);
+	}
+
+	/* Parent */
+	close(pipefd[0]);
+
+	/* Update BPF map with child PID */
+	skel->bss->my_pid = pid;
+
+	/* Signal child to proceed */
+	write(pipefd[1], "G", 1);
+	close(pipefd[1]);
+
+	/* Wait for child */
+	waitpid(pid, NULL, 0);
+
+	ASSERT_EQ(skel->bss->called_lsm, 1, "lsm hook called");
+	ASSERT_EQ(skel->bss->lsm_match, 1, "lsm match");
+
+cleanup:
+	unlink("/tmp/bpf_d_path_test");
+	test_d_path__destroy(skel);
+}
+
 void test_d_path(void)
 {
 	if (test__start_subtest("basic"))
@@ -205,4 +267,7 @@ void test_d_path(void)
 
 	if (test__start_subtest("check_alloc_mem"))
 		test_d_path_check_types();
+
+	if (test__start_subtest("lsm"))
+		test_d_path_lsm();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
index 84e1f883f97b..9ae36eabcd07 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path.c
@@ -17,6 +17,8 @@ int rets_close[MAX_FILES] = {};
 
 int called_stat = 0;
 int called_close = 0;
+int called_lsm = 0;
+int lsm_match = 0;
 
 SEC("fentry/security_inode_getattr")
 int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
@@ -62,4 +64,35 @@ int BPF_PROG(prog_close, struct file *file, void *id)
 	return 0;
 }
 
+SEC("lsm/bprm_check_security")
+int BPF_PROG(prog_lsm, struct linux_binprm *bprm)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+	char path[MAX_PATH_LEN] = {};
+	int ret;
+
+	if (pid != my_pid)
+		return 0;
+
+	called_lsm = 1;
+	ret = bpf_d_path(&bprm->file->f_path, path, MAX_PATH_LEN);
+	if (ret < 0)
+		return 0;
+
+	{
+		static const char target_dir[] = "/tmp/";
+		int i;
+
+		bpf_for(i, 0, sizeof(target_dir) - 1) {
+			if (path[i] != target_dir[i]) {
+				lsm_match = -1; /* mismatch */
+				return 0;
+			}
+		}
+	}
+
+	lsm_match = 1; /* prefix match */
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.52.0


