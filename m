Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341D1727083
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 23:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjFGVWt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 17:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjFGVWr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 17:22:47 -0400
X-Greylist: delayed 1086 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Jun 2023 14:22:44 PDT
Received: from antelope.pear.relay.mailchannels.net (antelope.pear.relay.mailchannels.net [23.83.216.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8831BD5
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Jun 2023 14:22:43 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E843D8817D0
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Jun 2023 21:04:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7AE7C881647
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Jun 2023 21:04:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686171865; a=rsa-sha256;
        cv=none;
        b=jm5nW62orikAhRPLMFIaQESiyzokygJg2iatBVtfJhWR24fzMVo+5lQoJHxWq32fp+tGcU
        zF8E+Z8RlIetEWd4QN//Q7WKnRLJ6vPL8IxpBnZCXGE2d9zBGd76ptPBPjLNzt/o7GgsxM
        yL5z6KPVj5IHalRrxlbP+vyQUQo8UK8nUp4MqUTdlzld8j7iVzVXw3CYkNUimNdc+p/XrH
        Cd/Ks5sq2pGqO3Ye/IWaLLcCh3PlrCiFSgsMVZmrwO40HOB+cPKQnVo7blWlW4nmsZ9ObJ
        b+0xY6SQiD2u3hdkOFzeoAy/rBfk0atHmlcQpKMzJB+f5cMQAqC9ozaEwIkH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686171865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=eifjIpcveeYQIutCiintfEZJ5k80v2oThAAUP+q2Fx0=;
        b=gnmHS2b4cH3Jp80/2uHozRugyiLxmwP17dA/LK0hoJ6AZug0N+Ib1oz/uXnfZaoOyaWTTf
        GLV+AUtMdH6bdr/nOCey9/johtM6Vtn4m81o0W8x2XLbx9NAfBHF9u/+afR1k+BE7917ev
        8G8jdtZpYm7O7SoMXFoUvqmEjKY9g8rhjXY8iK5T+QzdLbnGaH6z1Na11AHYdCv5VPutlS
        ePsswk/KIuVVkWOsZHdYNZjwIB6/g3B80aN0oBiL2BRtwenlZNYLG8zOX/1QkSkNEzvVs+
        DQDkotCR5w0D1fzMtOOnAIHskDIdZSIh/NDJvIOM7l3FJjOpasRtIlz3tC2/OA==
ARC-Authentication-Results: i=1;
        rspamd-6f5cfd578c-jwvbw;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Language-Whimsical: 7e4a6cfb3297032a_1686171865748_2971824342
X-MC-Loop-Signature: 1686171865748:3565379666
X-MC-Ingress-Time: 1686171865748
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.22 (trex/6.8.1);
        Wed, 07 Jun 2023 21:04:25 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4Qc0G06BBRzmL
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Jun 2023 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686171864;
        bh=eifjIpcveeYQIutCiintfEZJ5k80v2oThAAUP+q2Fx0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=DAjseFSUVCokHmOC9QZYobC49oJKsrIGdkoZ2oNfxmMzAXnUUq0PYhJwBiVRUIAXI
         5FqEGDJBx1TwtNC/BDZZrFCdQro2J2sTT1PzkgB+u5Ae+Evm5rh6U6pJodVgCIi8ao
         u+eli7vX3520aR1d1So/WJWuiB4dVpyjmIYCxM3o=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e005f
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 07 Jun 2023 14:04:23 -0700
Date:   Wed, 7 Jun 2023 14:04:23 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH bpf v2 1/2] selftests/bpf: add a test for subprogram extables
Message-ID: <c3d55cfd8ce7ed989c997d1e3ea2678879227300.1686166633.git.kjlx@templeofstupid.com>
References: <cover.1686166633.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686166633.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In certain situations a program with subprograms may have a NULL
extable entry.  This should not happen, and when it does, it turns a
single trap into multiple.  Add a test case for further debugging and to
prevent regressions.  N.b: without any other patches this can panic or
oops a kernel.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 .../bpf/prog_tests/subprogs_extable.c         | 35 +++++++++
 .../bpf/progs/test_subprogs_extable.c         | 71 +++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
new file mode 100644
index 000000000000..18169b7eedf8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+
+#include <test_progs.h>
+#include <stdbool.h>
+#include "test_subprogs_extable.skel.h"
+
+static int duration;
+
+void test_subprogs_extable(void)
+{
+	const int READ_SZ = 456;
+	struct test_subprogs_extable *skel;
+	int err;
+
+	skel = test_subprogs_extable__open();
+	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+		return;
+
+	err = test_subprogs_extable__load(skel);
+	if (CHECK(err, "skel_load", "failed to load skeleton\n"))
+		return;
+
+	err = test_subprogs_extable__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+		goto cleanup;
+
+	/* trigger tracepoint */
+	ASSERT_OK(trigger_module_test_read(READ_SZ), "trigger_read");
+
+	test_subprogs_extable__detach(skel);
+
+cleanup:
+	test_subprogs_extable__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_subprogs_extable.c b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
new file mode 100644
index 000000000000..408137eaaa07
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 8);
+	__type(key, __u32);
+	__type(value, __u64);
+} test_array SEC(".maps");
+
+static __u64 test_cb(struct bpf_map *map, __u32 *key, __u64 *val, void *data)
+{
+	return 1;
+}
+
+static __u64 test_cb2(struct bpf_map *map, __u32 *key, __u64 *val, void *data)
+{
+	return 1;
+}
+
+static __u64 test_cb3(struct bpf_map *map, __u32 *key, __u64 *val, void *data)
+{
+	return 1;
+}
+
+SEC("fexit/bpf_testmod_return_ptr")
+int BPF_PROG(handle_fexit_ret_subprogs, int arg, struct file *ret)
+{
+	long buf = 0;
+
+	bpf_probe_read_kernel(&buf, 8, ret);
+	bpf_probe_read_kernel(&buf, 8, (char *)ret + 256);
+	*(volatile long long *)ret;
+	*(volatile int *)&ret->f_mode;
+	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_return_ptr")
+int BPF_PROG(handle_fexit_ret_subprogs2, int arg, struct file *ret)
+{
+	long buf = 0;
+
+	bpf_probe_read_kernel(&buf, 8, ret);
+	bpf_probe_read_kernel(&buf, 8, (char *)ret + 256);
+	*(volatile long long *)ret;
+	*(volatile int *)&ret->f_mode;
+	bpf_for_each_map_elem(&test_array, test_cb2, NULL, 0);
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_return_ptr")
+int BPF_PROG(handle_fexit_ret_subprogs3, int arg, struct file *ret)
+{
+	long buf = 0;
+
+	bpf_probe_read_kernel(&buf, 8, ret);
+	bpf_probe_read_kernel(&buf, 8, (char *)ret + 256);
+	*(volatile long long *)ret;
+	*(volatile int *)&ret->f_mode;
+	bpf_for_each_map_elem(&test_array, test_cb3, NULL, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.25.1

