Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1783A728C42
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 02:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbjFIALh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 20:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbjFIALg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 20:11:36 -0400
X-Greylist: delayed 97629 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Jun 2023 17:11:35 PDT
Received: from grey.apple.relay.mailchannels.net (grey.apple.relay.mailchannels.net [23.83.208.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBCF2733
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 17:11:35 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8607A761DAC
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 00:11:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2716E761E5A
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 00:11:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686269494; a=rsa-sha256;
        cv=none;
        b=xb62SB+Z6itwq5yqKRc8ZZCGrcz4QkYRFRVU27vH3SGrGgd45NIV80y4HRXsZp7hjYUgqj
        Qu/S9BXemPH71mW/qPhmvbHHSF7UzybbKjU05usBXx+IRjSwYZbwirJDQzmdvs+/7ehqAE
        xBgSfDnXcNNdng76EjybRyIwSViLhFrmWP7OBUfnZAkCK0hYgbNIYhOLlDor2CYBxiS8VP
        NI82jB2IX2c8+edfrNgzqpa35iXD/p9FZ3ApDLTPflNUPQvm1uOu+EJH2hR9iqIT6Qa8SY
        wEUOhIehIGpFvCzxrHvSnxb0LJKG7e8Rg0P/2u+HNKfk4YKVYRc6OEoYDsAqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686269494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=F8KPdDJs/fafqK8befrWeYqM6/tlnupScz2H0Ba6c8I=;
        b=002Celn2SQNn+gaExPaMbicv+D07wNk4E2TlpzoFNdC3CIN4pWD2haBE6e+spyFgzIss7j
        ChwPEDFJ9xkeHtMxTh3NoQpIVI8Md2uR0UkGeP9CwHwmvzzcA0PvJND5UGKDrAgFSrrA88
        MerLjCIWo9q6zpaTb33eOWeZgvlZsiada3ZwdsW0VYzmG5FmJbJ+Ww4rm2sFo9OkrsmKTc
        5es88CsguDBeA0Sg0T2dHZAtKOnRt3Ghgq5sPqtqeoou+wG2JUZYK21F846GZEj5kWtxv0
        TfUE6YsNdirNVpaYmkvdiROK8Bm7MLwqdCxbEwzn7IX0vXOu/h7TKrcmTBQqjw==
ARC-Authentication-Results: i=1;
        rspamd-6f5cfd578c-lcvt2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Average-Shelf: 0439237d02c690e5_1686269494372_2842711401
X-MC-Loop-Signature: 1686269494372:2304675126
X-MC-Ingress-Time: 1686269494372
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.217.228 (trex/6.8.1);
        Fri, 09 Jun 2023 00:11:34 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4QchMS6nRBz1qT
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 17:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686269493;
        bh=F8KPdDJs/fafqK8befrWeYqM6/tlnupScz2H0Ba6c8I=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=TXEaB1btLsjRXcmw0020YGDMNtCdMGH1/YMEqiFvR2URzu4xCtonXa+J5TayPvZjc
         rYoI7NRg9IqKSiDx3fcqjyBaKesd54Bvzb8ZhIylBY7DD1dXsO2uvEBovuS7nTDnjI
         7SxmsQjiKVX3p45ilpYXsbrINRR5tLj8NMGF4BLs=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0042
        by kmjvbox (DragonFly Mail Agent v0.12);
        Thu, 08 Jun 2023 17:11:31 -0700
Date:   Thu, 8 Jun 2023 17:11:31 -0700
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3 2/2] selftests/bpf: add a test for subprogram extables
Message-ID: <9e3041e182a75f558f1132f915ddf2ee7e859c6e.1686268304.git.kjlx@templeofstupid.com>
References: <cover.1686268304.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686268304.git.kjlx@templeofstupid.com>
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
 .../bpf/prog_tests/subprogs_extable.c         | 31 +++++++++++++
 .../bpf/progs/test_subprogs_extable.c         | 46 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
new file mode 100644
index 000000000000..2201988274a4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "test_subprogs_extable.skel.h"
+
+void test_subprogs_extable(void)
+{
+	const int READ_SZ = 456;
+	struct test_subprogs_extable *skel;
+	int err;
+
+	skel = test_subprogs_extable__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	err = test_subprogs_extable__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	err = test_subprogs_extable__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
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
index 000000000000..c3ff66bf4cbe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
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
+SEC("fexit/bpf_testmod_return_ptr")
+int BPF_PROG(handle_fexit_ret_subprogs, int arg, struct file *ret)
+{
+	*(volatile long *)ret;
+	*(volatile int *)&ret->f_mode;
+	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_return_ptr")
+int BPF_PROG(handle_fexit_ret_subprogs2, int arg, struct file *ret)
+{
+	*(volatile long *)ret;
+	*(volatile int *)&ret->f_mode;
+	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_return_ptr")
+int BPF_PROG(handle_fexit_ret_subprogs3, int arg, struct file *ret)
+{
+	*(volatile long *)ret;
+	*(volatile int *)&ret->f_mode;
+	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.25.1

