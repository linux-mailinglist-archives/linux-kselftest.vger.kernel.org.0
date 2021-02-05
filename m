Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C193104FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Feb 2021 07:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhBEGeu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 01:34:50 -0500
Received: from mail.loongson.cn ([114.242.206.163]:38320 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229492AbhBEGer (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 01:34:47 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxGdTY5hxgfCAFAA--.6423S2;
        Fri, 05 Feb 2021 14:34:00 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: breakpoints: Use correct error messages in breakpoint_test_arm64.c
Date:   Fri,  5 Feb 2021 14:33:59 +0800
Message-Id: <1612506839-27225-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxGdTY5hxgfCAFAA--.6423S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr47Cry8Kr4xAryfJF18Xwb_yoWkZFgEka
        43tw4DCFWDJryDA3W3WwnxAFykGa13uF42qrW3tF9xCr47Ka45tFWkCF1kZF1Sg3yYg39F
        y3WqkrWavr1rJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r47MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsjg4DUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When call ptrace(PTRACE_CONT, ...) failed, use correct error messages.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/breakpoints/breakpoint_test_arm64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
index ad41ea6..e704181 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
@@ -145,7 +145,7 @@ static bool run_test(int wr_size, int wp_size, int wr, int wp)
 
 	if (ptrace(PTRACE_CONT, pid, NULL, NULL) < 0) {
 		ksft_print_msg(
-			"ptrace(PTRACE_SINGLESTEP) failed: %s\n",
+			"ptrace(PTRACE_CONT) failed: %s\n",
 			strerror(errno));
 		return false;
 	}
@@ -159,7 +159,7 @@ static bool run_test(int wr_size, int wp_size, int wr, int wp)
 	}
 	alarm(0);
 	if (WIFEXITED(status)) {
-		ksft_print_msg("child did not single-step\n");
+		ksft_print_msg("child exited prematurely\n");
 		return false;
 	}
 	if (!WIFSTOPPED(status)) {
-- 
2.1.0

