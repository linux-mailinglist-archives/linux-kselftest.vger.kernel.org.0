Return-Path: <linux-kselftest+bounces-13741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8A2931967
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 19:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5FF1F22ADC
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 17:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04E9482F6;
	Mon, 15 Jul 2024 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QakOI8zf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D91B7E9;
	Mon, 15 Jul 2024 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064823; cv=none; b=FTCLzim2Sx1ULkEnF01NpCk6DUcZqn5XoMsnU+p+aD3vzaLtLvvSKee6JveepkhJKnuuua/T1WdgQDsMMDwFcCISWPnRBVxOXC5NwxZS0pCyDMkGeQzVdcGtsk4fHquE+Jrc7YpRAYITlXTfIOzqeiFy6TPhFebAS6sK6Rp/Tr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064823; c=relaxed/simple;
	bh=H1Z+U4NzD8V5y3jhPonZ2ny9+fMUdenCqzkw1TQoFiM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=X9p2z/9cKbPJBKCiaIGWRe9Xpqv5hxv6VnLNzabBRXII9dtBNSn9EAoNezvgyNHW8CMbLk5ssiRx7sgYKKro+RAQqCq0hxRqc6qFmokz+UX6sU9HFTwpJjZc0MU9MfcBHLUu/Xa/rLvhfVMLiyx+PdZUBaBLJtrZqgItd01n9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QakOI8zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11B1C4AF0A;
	Mon, 15 Jul 2024 17:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064823;
	bh=H1Z+U4NzD8V5y3jhPonZ2ny9+fMUdenCqzkw1TQoFiM=;
	h=From:To:Subject:Date:From;
	b=QakOI8zfWtMkVmM5isjuFMuunQ6IdquRQqlyYVj51uRZ3kjfn6unV0km1DpRi+0tE
	 0qEQ6PcAS46FAo8leGiKnq9QBcGqBsBy/rYWlWJr9rVk9fAAZPcDtP5/au30VNK/Rz
	 1mEf1sHD0cwn/JMd13VPlFJFsTDLd3ltXgfBIMw/GAYNEGnJnlEJCKCKqOQFXnq5i2
	 oJg/owztkfJgLhojWPVEkkgCmCyzF7HKEnJhvOY0qbnkwaMb/0plxV0wcKiAPsic4m
	 ExDyO4l3VO7XuS7E3xIEQnLRCwRdMvwgAUrleFQnZ4JEGZwoBx+KNBdjy6aqx3R3Xa
	 h/kx0hpp4Ailg==
From: Puranjay Mohan <puranjay@kernel.org>
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
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: fexit_sleep: fix stack allocation for arm64
Date: Mon, 15 Jul 2024 17:33:27 +0000
Message-Id: <20240715173327.8657-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On ARM64 the stack pointer should be aligned at a 16 byte boundary or
the SPAlignmentFault can occur. The fexit_sleep selftest allocates the
stack for the child process as a character array, this is not guaranteed
to be aligned at 16 bytes.

Because of the SPAlignmentFault, the child process is killed before it
can do the nanosleep call and hence fentry_cnt remains as 0. This causes
the main thread to hang on the following line:

while (READ_ONCE(fexit_skel->bss->fentry_cnt) != 2);

Fix this by allocating the stack using mmap() as described in the
example in the man page of clone().

Remove the fexit_sleep test from the DENYLIST of arm64.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64         | 1 -
 tools/testing/selftests/bpf/prog_tests/fexit_sleep.c | 8 +++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 3c7c3e79aa931..901349da680fa 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -1,6 +1,5 @@
 bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
 bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
-fexit_sleep                                      # The test never returns. The remaining tests cannot start.
 kprobe_multi_bench_attach                        # needs CONFIG_FPROBE
 kprobe_multi_test                                # needs CONFIG_FPROBE
 module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c b/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c
index f949647dbbc21..552a0875ca6db 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c
@@ -21,13 +21,13 @@ static int do_sleep(void *skel)
 }
 
 #define STACK_SIZE (1024 * 1024)
-static char child_stack[STACK_SIZE];
 
 void test_fexit_sleep(void)
 {
 	struct fexit_sleep_lskel *fexit_skel = NULL;
 	int wstatus, duration = 0;
 	pid_t cpid;
+	char *child_stack = NULL;
 	int err, fexit_cnt;
 
 	fexit_skel = fexit_sleep_lskel__open_and_load();
@@ -38,6 +38,11 @@ void test_fexit_sleep(void)
 	if (CHECK(err, "fexit_attach", "fexit attach failed: %d\n", err))
 		goto cleanup;
 
+	child_stack = mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE |
+			   MAP_ANONYMOUS | MAP_STACK, -1, 0);
+	if (!ASSERT_NEQ(child_stack, MAP_FAILED, "mmap"))
+		goto cleanup;
+
 	cpid = clone(do_sleep, child_stack + STACK_SIZE, CLONE_FILES | SIGCHLD, fexit_skel);
 	if (CHECK(cpid == -1, "clone", "%s\n", strerror(errno)))
 		goto cleanup;
@@ -78,5 +83,6 @@ void test_fexit_sleep(void)
 		goto cleanup;
 
 cleanup:
+	munmap(child_stack, STACK_SIZE);
 	fexit_sleep_lskel__destroy(fexit_skel);
 }
-- 
2.40.1


