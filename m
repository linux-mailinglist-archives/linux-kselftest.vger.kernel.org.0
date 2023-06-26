Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD51D73EEE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 01:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjFZXC1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 19:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFZXCZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 19:02:25 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EBE10EC;
        Mon, 26 Jun 2023 16:02:24 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1354E5C0164;
        Mon, 26 Jun 2023 19:02:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 26 Jun 2023 19:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1687820544; x=
        1687906944; bh=zvVh1fx8mJsJ0llz/fWqNzEDpjhcK5ZKaZSEnotm8Qs=; b=E
        1LWtVo45Hh+d3qwE5X1bscpQFeb/tW56uDPpDf0QptYqJDs82siTLhgUUW6qFKJK
        LmpoEhPHhJ2HQZvbv83S+LItjnWoBMPyfqbhrsiDNl9HS413XSr/TGQClEJhwlPc
        O0xxaQFwNoakv1VnWlVjTulrOdTI/JpVt8lIKMEsk0kh4SK+512yFcyGykvVZdqR
        PJknvlrm5mGMM3dW1V1ETTYyPTnX4zjKXzjwTCOtfAMhMKZsoPmfdr1+RQRvNME/
        40ZpF1IXYQ+QICdVC2Qs67mEKUM+h8M8e/26IeWpTDam9FVSEkSTF2HE1Uj0/N98
        UgXegVEkKVLgClHl0pP0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687820544; x=
        1687906944; bh=zvVh1fx8mJsJ0llz/fWqNzEDpjhcK5ZKaZSEnotm8Qs=; b=c
        C6W5nK61tARnvjVDjbqtQivkIarPHJPPcEuw0ev9T/d4YzDkHHVlp1aX4iLaCEq0
        3/3VZuqEOoUGMqceSewGMaWhm9AESiNxfImxO+QHvwXuozEmYV83vJG8PRgP+hVG
        y8gwHCgZwWxSaW9Acp1nEw+clFcsvokPkW5O6OupiCXRJb+5Kd0So0r3Xcq7OJdM
        1DW/tAO/LEMCMm/c+jnMWQh4eI+AK06cW/q1WB4p4UPoHAwB6HaDthkjj072JUP4
        6CZxnlMAWH2H2E6LPdZmJ5kf7mtkkj3k98XvXg5RVE3mieAxOwCk26TXLyrKNOlS
        ihrADuo7eZCtEbuUYrlDA==
X-ME-Sender: <xms:_xiaZFa_WgeqhtFgVM8pVZLi6K2pnDAnizzWqeppfDDOXhlZRzHWcA>
    <xme:_xiaZMbXyOgDRJ-zOuVHAgCX3Ag6zrh4g_E3K7BCO8i7ais7cdRLkj_7Z0xa0rBxG
    WrGpMjybW5wseL5oQ>
X-ME-Received: <xmr:_xiaZH8bSCVum9UYEgCqvCjTShLlEE7_oXBtoATHS5CHzsE1siay9uwTCfhIbIejgAN18H0Rix9XjDCwaOw3QQgrp1KxlC6o_Hyy4E1NDnY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehgedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:_xiaZDo7X2ihV3f1sbbgx3Bt0SK5OhE5qYAzhUXhDmpAor-quo2zKw>
    <xmx:_xiaZAoYfiGeiQLqPAVpA34yxnCiVWsHRt1xq07b3_YcGMJScGs2rQ>
    <xmx:_xiaZJTUZ-IbsK6eSCpQIl2TLtiKXCRkOzSQxDK6KWTy8itDX4tXlw>
    <xmx:ABmaZL9syNqXIqztlqx1Y8R4ME4ewkPoUDI50xXtvnR20VwlGcxqLA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 19:02:21 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, fw@strlen.de
Cc:     mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netfilter-devel@vger.kernel.org, dsahern@kernel.org
Subject: [PATCH bpf-next 2/7] selftests/bpf: Add bpf_program__attach_netfilter helper test
Date:   Mon, 26 Jun 2023 17:02:09 -0600
Message-Id: <96bb65cbdf760b6a593ab85104a95b373d1d822b.1687819413.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687819413.git.dxu@dxuuu.xyz>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=ANY_BOUNCE_MESSAGE,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,VBOUNCE_MESSAGE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Call bpf_program__attach_netfilter() with different
protocol/hook/priority combinations.

Test fails if supposedly-illegal attachments work
(e.g., bogus protocol family, illegal priority and so on)
or if a should-work attachment fails.

Co-developed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../bpf/prog_tests/netfilter_basic.c          | 78 +++++++++++++++++++
 .../bpf/progs/test_netfilter_link_attach.c    | 14 ++++
 2 files changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/netfilter_basic.c b/tools/testing/selftests/bpf/prog_tests/netfilter_basic.c
new file mode 100644
index 000000000000..357353fee19d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/netfilter_basic.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <netinet/in.h>
+#include <linux/netfilter.h>
+
+#include "test_progs.h"
+#include "test_netfilter_link_attach.skel.h"
+
+struct nf_hook_options {
+	__u32 pf;
+	__u32 hooknum;
+	__s32 priority;
+	__u32 flags;
+
+	bool expect_success;
+};
+
+struct nf_hook_options nf_hook_attach_tests[] = {
+	{  },
+	{ .pf = NFPROTO_NUMPROTO, },
+	{ .pf = NFPROTO_IPV4, .hooknum = 42, },
+	{ .pf = NFPROTO_IPV4, .priority = INT_MIN },
+	{ .pf = NFPROTO_IPV4, .priority = INT_MAX },
+	{ .pf = NFPROTO_IPV4, .flags = UINT_MAX },
+
+	{ .pf = NFPROTO_INET, .priority = 1, },
+
+	{ .pf = NFPROTO_IPV4, .priority = -10000, .expect_success = true },
+	{ .pf = NFPROTO_IPV6, .priority = 10001, .expect_success = true },
+};
+
+void test_netfilter_basic(void)
+{
+	struct test_netfilter_link_attach *skel;
+	LIBBPF_OPTS(bpf_netfilter_opts, opts);
+	struct bpf_program *prog;
+	int i;
+
+	skel = test_netfilter_link_attach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_netfilter_link_attach__open_and_load"))
+		goto out;
+
+	prog = skel->progs.nf_link_attach_test;
+
+	for (i = 0; i < ARRAY_SIZE(nf_hook_attach_tests); i++) {
+		struct bpf_link *link;
+
+#define X(opts, m, i)	opts.m = nf_hook_attach_tests[(i)].m
+		X(opts, pf, i);
+		X(opts, hooknum, i);
+		X(opts, priority, i);
+		X(opts, flags, i);
+#undef X
+		link = bpf_program__attach_netfilter(prog, &opts);
+		if (nf_hook_attach_tests[i].expect_success) {
+			struct bpf_link *link2;
+
+			if (!ASSERT_OK_PTR(link, "program attach successful"))
+				continue;
+
+			link2 = bpf_program__attach_netfilter(prog, &opts);
+			ASSERT_ERR_PTR(link2, "attach program with same pf/hook/priority");
+
+			if (!ASSERT_OK(bpf_link__destroy(link), "link destroy"))
+				break;
+
+			link2 = bpf_program__attach_netfilter(prog, &opts);
+			if (!ASSERT_OK_PTR(link2, "program reattach successful"))
+				continue;
+			if (!ASSERT_OK(bpf_link__destroy(link2), "link destroy"))
+				break;
+		} else {
+			ASSERT_ERR_PTR(link, "program load failure");
+		}
+	}
+out:
+	test_netfilter_link_attach__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c b/tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c
new file mode 100644
index 000000000000..03a475160abe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+#define NF_ACCEPT 1
+
+SEC("netfilter")
+int nf_link_attach_test(struct bpf_nf_ctx *ctx)
+{
+	return NF_ACCEPT;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.40.1

