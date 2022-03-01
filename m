Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173014C9581
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Mar 2022 21:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbiCAUOg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Mar 2022 15:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiCAUOg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Mar 2022 15:14:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8660A38D81;
        Tue,  1 Mar 2022 12:13:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1809E61710;
        Tue,  1 Mar 2022 20:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE34DC340EE;
        Tue,  1 Mar 2022 20:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646165633;
        bh=IKX32sWHzfqA+GXof/lcAj87x4fva3TL+Bqv6/XCzIk=;
        h=From:To:Cc:Subject:Date:From;
        b=Ipq1GxBvzrSE7AMt2MVerjK5I3IeOm9cS0DMV7Ig3LO4wjDCwadF0tQQII+gHAd6n
         osWK0xpw/7tC7Bl07pNlQuJrFmrRxiXPFNeZQHnGbHxU/5QIxL7G4OjLUo1vA9eM4v
         arJmny6djYgEufmftB1D7oKnoOJdPY6wYSKrx7ccqBCM1V+kRo+F2LszzHGgkLgloF
         4Si42GuNwwYqK/4MTtReQ2bcrlchcv/22GZoxQPyOzwCmQOCiyib6YAca1dc6X2Xd1
         gVe8Gvo9QD3zAwRrWvr5twCQ01NBr8SwJnKCl9z9NHrPNoy6zGrKKg3MN3de09liz9
         6p1BTfS8kG8wA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 01/28] selftests/bpf: Add test for bpf_timer overwriting crash
Date:   Tue,  1 Mar 2022 15:13:06 -0500
Message-Id: <20220301201344.18191-1-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit a7e75016a0753c24d6c995bc02501ae35368e333 ]

Add a test that validates that timer value is not overwritten when doing
a copy_map_value call in the kernel. Without the prior fix, this test
triggers a crash.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20220209070324.1093182-3-memxor@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/prog_tests/timer_crash.c    | 32 +++++++++++
 .../testing/selftests/bpf/progs/timer_crash.c | 54 +++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_crash.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_crash.c

diff --git a/tools/testing/selftests/bpf/prog_tests/timer_crash.c b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
new file mode 100644
index 0000000000000..f74b82305da8c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "timer_crash.skel.h"
+
+enum {
+	MODE_ARRAY,
+	MODE_HASH,
+};
+
+static void test_timer_crash_mode(int mode)
+{
+	struct timer_crash *skel;
+
+	skel = timer_crash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "timer_crash__open_and_load"))
+		return;
+	skel->bss->pid = getpid();
+	skel->bss->crash_map = mode;
+	if (!ASSERT_OK(timer_crash__attach(skel), "timer_crash__attach"))
+		goto end;
+	usleep(1);
+end:
+	timer_crash__destroy(skel);
+}
+
+void test_timer_crash(void)
+{
+	if (test__start_subtest("array"))
+		test_timer_crash_mode(MODE_ARRAY);
+	if (test__start_subtest("hash"))
+		test_timer_crash_mode(MODE_HASH);
+}
diff --git a/tools/testing/selftests/bpf/progs/timer_crash.c b/tools/testing/selftests/bpf/progs/timer_crash.c
new file mode 100644
index 0000000000000..f8f7944e70dae
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timer_crash.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+struct map_elem {
+	struct bpf_timer timer;
+	struct bpf_spin_lock lock;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct map_elem);
+} amap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct map_elem);
+} hmap SEC(".maps");
+
+int pid = 0;
+int crash_map = 0; /* 0 for amap, 1 for hmap */
+
+SEC("fentry/do_nanosleep")
+int sys_enter(void *ctx)
+{
+	struct map_elem *e, value = {};
+	void *map = crash_map ? (void *)&hmap : (void *)&amap;
+
+	if (bpf_get_current_task_btf()->tgid != pid)
+		return 0;
+
+	*(void **)&value = (void *)0xdeadcaf3;
+
+	bpf_map_update_elem(map, &(int){0}, &value, 0);
+	/* For array map, doing bpf_map_update_elem will do a
+	 * check_and_free_timer_in_array, which will trigger the crash if timer
+	 * pointer was overwritten, for hmap we need to use bpf_timer_cancel.
+	 */
+	if (crash_map == 1) {
+		e = bpf_map_lookup_elem(map, &(int){0});
+		if (!e)
+			return 0;
+		bpf_timer_cancel(&e->timer);
+	}
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

