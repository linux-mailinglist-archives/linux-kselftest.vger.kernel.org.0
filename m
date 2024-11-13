Return-Path: <linux-kselftest+bounces-21939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B649C7184
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 14:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5651F222E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DDD204031;
	Wed, 13 Nov 2024 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o/+rx23Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291462038B1;
	Wed, 13 Nov 2024 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506052; cv=none; b=diArKrJetKBFMJ6GdjOV7efrevRIKX3Dtg7v+CXKlACyRGokZhu2IHcoFHeCiC92p3rxURNkx6/Im38+jb45b9sYarecHko4G9jKfjXpRM4anIPWy17JGiwf1iZ9kZq9AKv6ME2HnVoF17Kvsw7nc79HChW+WVxI9afcNM4Dv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506052; c=relaxed/simple;
	bh=zC0BkYMv5dWS9NNUKOzI1WQT9YI5CaMfNg47aVjXiWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pk1z8sqsW8QO5b/Jv/Bb1UioHCpY4WPxEXkD405m3zR7yQy/Ea/0CRHbMwHsGaEqVxmvEZB9hh5G7cVNiuTMSLi6LYIcdUxjgYI1arRezDNKy6R5qTL+DVrDcywlAjvMfJFzjAmAJbbjrUBRUiSJF9MeBN5r7IYvlLPNrVM/HJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o/+rx23Z; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D351E2000B;
	Wed, 13 Nov 2024 13:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731506048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gh3KgQeocVU3LhWpCb9FrWrxjJcX8AjuQG6H8QqII3Y=;
	b=o/+rx23Z9tEaa5SaD27Yy5GuP/AQIhobfdiGr/GQnklXSv5XLxVAXANFHLfTzq8Hp9JHak
	WpHwR7bADNLzC+x/YMzu6C3cnSh9ZEfzBVswlXko4iAibCKNICWWC51uBvnhSm8sUpKMGH
	F1y+lkzkJ9099qoa49crfXp4hn6TUPG6CzofAXGXYMmyHPBSyDBcrEzE+/zQJL6WlMsZ+h
	LfrpeCuFc/yqYgq3QRBeXMlvzMtKmS2cuK3Vvp8ryiTTdib5LGTOFSyUUFMkYkUIpXuBbK
	loqhxbnjFA7nTeKJoqBHqWImLztxVW6bFpAv+F2DJ4GpAgkOFmJWWoMGaR3vkg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 13 Nov 2024 14:53:30 +0100
Subject: [PATCH bpf-next 07/10] selftests/bpf: migrate flow_dissector
 namespace exclusivity test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241113-flow_dissector-v1-7-27c4df0592dc@bootlin.com>
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
In-Reply-To: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

Commit a11c397c43d5 ("bpf/flow_dissector: add mode to enforce global BPF
flow dissector") is currently tested in test_flow_dissector.sh, which is
not part of test_progs. Add the corresponding test to flow_dissector.c,
which is part of test_progs. The new test reproduces the behavior
implemented in its shell script counterpart:
- attach a  flow dissector program to the root net namespace, ensure
  that we can not attach another flow dissector in any non-root net
  namespace
- attach a flow dissector program to a non-root net namespace, ensure
  that we can not attach another flow dissector in root namespace

Since the new test is performing operations in the root net namespace,
make sure to set it as a "serial" test to make sure not to conflict with
any other test.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../selftests/bpf/prog_tests/flow_dissector.c      | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 05f3953c6266efdedeb74a81969ccfdabf009ccd..216f89070144f5fd19d602d0691f0aa6eed10a8e 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -7,6 +7,7 @@
 
 #include "bpf_flow.skel.h"
 
+#define TEST_NS	"flow_dissector_ns"
 #define FLOW_CONTINUE_SADDR 0x7f00007f /* 127.0.0.127 */
 #define TEST_NAME_MAX_LEN	64
 
@@ -495,6 +496,67 @@ struct test tests[] = {
 	},
 };
 
+void serial_test_flow_dissector_namespace(void)
+{
+	struct bpf_flow *skel;
+	struct nstoken *ns;
+	int err, prog_fd;
+
+	skel = bpf_flow__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open/load skeleton"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs._dissect);
+	if (!ASSERT_OK_FD(prog_fd, "get dissector fd"))
+		goto out_destroy_skel;
+
+	/* We must be able to attach a flow dissector to root namespace */
+	err = bpf_prog_attach(prog_fd, 0, BPF_FLOW_DISSECTOR, 0);
+	if (!ASSERT_OK(err, "attach on root namespace ok"))
+		goto out_destroy_skel;
+
+	err = make_netns(TEST_NS);
+	if (!ASSERT_OK(err, "create non-root net namespace"))
+		goto out_destroy_skel;
+
+	/* We must not be able to additionally attach a flow dissector to a
+	 * non-root net namespace
+	 */
+	ns = open_netns(TEST_NS);
+	if (!ASSERT_OK_PTR(ns, "enter non-root net namespace"))
+		goto out_clean_ns;
+
+	err = bpf_prog_attach(prog_fd, 0, BPF_FLOW_DISSECTOR, 0);
+	close_netns(ns);
+	ASSERT_ERR(err, "refuse new flow dissector in non-root net namespace");
+	ASSERT_EQ(errno, EEXIST, "refused because of already attached prog");
+
+	/* If no flow dissector is attached to the root namespace, we must
+	 * be able to attach one to a non-root net namespace
+	 */
+	bpf_prog_detach2(prog_fd, 0, BPF_FLOW_DISSECTOR);
+	ns = open_netns(TEST_NS);
+	ASSERT_OK_PTR(ns, "enter non-root net namespace");
+	err = bpf_prog_attach(prog_fd, 0, BPF_FLOW_DISSECTOR, 0);
+	close_netns(ns);
+	ASSERT_OK(err, "accept new flow dissector in non-root net namespace");
+
+	/* If a flow dissector is attached to non-root net namespace, attaching
+	 * a flow dissector to root namespace must fail
+	 */
+	err = bpf_prog_attach(prog_fd, 0, BPF_FLOW_DISSECTOR, 0);
+	ASSERT_ERR(err, "refuse new flow dissector on root namespace");
+	ASSERT_EQ(errno, EEXIST, "refused because of already attached prog");
+
+	ns = open_netns(TEST_NS);
+	bpf_prog_detach2(prog_fd, 0, BPF_FLOW_DISSECTOR);
+	close_netns(ns);
+out_clean_ns:
+	remove_netns(TEST_NS);
+out_destroy_skel:
+	bpf_flow__destroy(skel);
+}
+
 static int create_tap(const char *ifname)
 {
 	struct ifreq ifr = {

-- 
2.47.0


