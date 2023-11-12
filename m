Return-Path: <linux-kselftest+bounces-32-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B727E8DFE
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 03:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60ADD1C203B9
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 02:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7B080E;
	Sun, 12 Nov 2023 02:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81118184
	for <linux-kselftest@vger.kernel.org>; Sun, 12 Nov 2023 02:36:13 +0000 (UTC)
X-Greylist: delayed 310 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Nov 2023 18:36:12 PST
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFC130CB
	for <linux-kselftest@vger.kernel.org>; Sat, 11 Nov 2023 18:36:12 -0800 (PST)
Received: from localhost ([173.252.127.8]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LmJfA-1rbtEF3naU-00Zu3U; Sun, 12 Nov
 2023 03:30:46 +0100
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: add assert for user stacks in test_task_stack
Date: Sat, 11 Nov 2023 18:30:10 -0800
Message-Id: <20231112023010.144675-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PN7RG/90Yun44E0zzqkcOvPWLKrXq93inSWNwhsV9D4nSM4gWW7
 IjKZHNvEJ/BG2p6CiZCrF9RghPoRSOAdRuuHoRmyrWDEZqbq6hBWKeIVw8BZcOOa+a5ZfTM
 hxSvnDOxKrfB0rOiQqfZWZtE94kcN4DNJo0HG0NzwgSwYoGfEh4EIov2dai7HU4u6zJ6/B+
 YcGqcDOytfYDFiDQTXu5g==
UI-OutboundReport: notjunk:1;M01:P0:Ye/Dkl8kmoc=;D4UfSGUwJ+JL7FN9y8iOpcyqi+1
 +GG64O4LmTA/uznRJS3Sk6PsDq5iTh4us8sq8zBFfjPSJ/VDxlnhd+SpkEmGe6Tt4qgkYTkPe
 4zgaZbmGnBpH6eKWMqIfJ8TVGHMkSqHMH4F1yKe2FZUPTXWsR9UQFCmVl0G7t/oT/NqRTl42s
 bJJx9gHuz5P/VY4ufDkZPafa4Z6IKsJMBKuAmHxOeBOmJueXjfxhEoK4vJBA5LC6A8oNKfc//
 1aeDSmMap7/d3iCPezuHq+foKsqmskmCL60X5cpfxtPuP08aFN4yyqD+vyXpbj27KM7JmM0ua
 yfx2pGmYY57vz5KASXAboPAY3GwTjbcTiArclAEjoTu+LwwiGKMG6ADz9oZjV/UUBn9X+x1oy
 QfDmSMFzP0ECVP1PUYKlmviT2+Qd8OQ/WwVDBfWaYF118cQiQmXYi/N1nXWVJzxrtNZfKcGAr
 RqFBz7ggn1KCDV6Cd4EQ1EE4v2gH8lLxUyISRjH/NZpbXJcKmKKD9yHVd833dI6SV3XfjFnW7
 UpphGfQi3noV2PciCioULvjj5fM0ddP65ykr0Gn2JFyd/lzMcW7BIlqt/9y5i4mZ5bUQ7wytg
 8qtFW3Vcl4HdwNIEKrDE/ZGmElb8sRZiTN42L2Vu+r774G0DcOAElo4kbmL+XRjogRf9Ps9RC
 cdGFVj0r8xACQln0X/CUACVxGdNBpQ/avbMWHkNe7nkW4djLZgcBcNoDqjcHIP/xNkETZlHFG
 yifhEFJpG5D/WkMwRBml3IIR67AipWeiHqbKtZ7Zm8s0zq3qZDSEpd0YX7WK+bdhsbi+WfScP
 s0mXO7OgcgQQb4ozpmIJ02Y10gm7BIj2qZvA3EJGOfMhGJTUXJ6wCSmnCqaFLtwOMdGdTNXuL
 KNLpYZqJFCKiIsA==

This is a follow up to:
commit b8e3a87a627b ("bpf: Add crosstask check to __bpf_get_stack").

This test ensures that the task iterator only gets a single
user stack (for the current task).

Signed-off-by: Jordan Rome <linux@jordanrome.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c       | 2 ++
 tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 4e02093c2cbe..618af9dfae9b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -332,6 +332,8 @@ static void test_task_stack(void)
 	do_dummy_read(skel->progs.dump_task_stack);
 	do_dummy_read(skel->progs.get_task_user_stacks);
 
+	ASSERT_EQ(skel->bss->num_user_stacks, 1, "num_user_stacks");
+
 	bpf_iter_task_stack__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
index f2b8167b72a8..442f4ca39fd7 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
@@ -35,6 +35,8 @@ int dump_task_stack(struct bpf_iter__task *ctx)
 	return 0;
 }
 
+int num_user_stacks = 0;
+
 SEC("iter/task")
 int get_task_user_stacks(struct bpf_iter__task *ctx)
 {
@@ -51,6 +53,9 @@ int get_task_user_stacks(struct bpf_iter__task *ctx)
 	if (res <= 0)
 		return 0;
 
+	/* Only one task, the current one, should succeed */
+	++num_user_stacks;
+
 	buf_sz += res;
 
 	/* If the verifier doesn't refine bpf_get_task_stack res, and instead
-- 
2.39.3


