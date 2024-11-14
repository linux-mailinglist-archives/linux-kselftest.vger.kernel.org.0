Return-Path: <linux-kselftest+bounces-22056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75DA9C94CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 22:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0F22829B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 21:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440101B81B8;
	Thu, 14 Nov 2024 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QFggHK4I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21CB1B4F29;
	Thu, 14 Nov 2024 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731621085; cv=none; b=NOACLGVQFThC9XL8ckXTP/1owhvZZiznFYDTMhBMzEaf3DvHS7214wTYzcKAaTmYL7lmazBKvwD6Fd1uqGJE3x81qxd87I4FTO+KaUB+68hgATm25MEiCheArnG7pXURXeqq/v0+b6u7z56+Qui1CNm9O7otlXR6UfpQgCmbIUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731621085; c=relaxed/simple;
	bh=51nvnjVPxDSXDBQAeNN34XFBtzMCQIbeqi2JVCKIA8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cnhSTepzEcaPzV2iHvN/Jy4rIoSugeHURDRaRpmwhZKTboLtOiBu5Mvf7pkpcyXJPe1E+wxNBP+3Msp8BAY6MLkjDSgFvdi7yKhOFzFBkLojqiWkKDYTpg977aDUK0UdKGB1ROa8FWmXTOcYuvBTH+o52MRiYxb+LUGYUSWO6+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QFggHK4I; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CAEE520003;
	Thu, 14 Nov 2024 21:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731621081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLLincnJJLkflf02a0IpqSZIrox9LZN4PcWhtp0mLAc=;
	b=QFggHK4I8IXeBAhcB+Td/kWHWRJEGIPouOq20IjFKvK4MjQcuRyzuOHF/Wfw9PdHymj47s
	tiE+EHlkonc5QxScvcaTE4ceUECoPZmtg9j+lYisU4iigFrjPPp4wd2DEZP4aljnmZppih
	vtU1BjULoHeUnvHHwG1hIGjBlmn8Tf52JP+iI4tzN7SfyGHxWW/x1AZ10HAL+Dx4Zwe1KG
	P+oRg+SHIV3CodIlS6ao3B8SiNpg77tgrkd2Db/6KkiTgZQsN89RPrXyMQleYhDm4LooIn
	x9Fnp94p0SXSqq24rp0BeQ59e+633qzsUGWapvbibJMTLeFYSX36jSNegF5xZw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 14 Nov 2024 22:50:38 +0100
Subject: [PATCH bpf-next v2 07/13] selftests/bpf: migrate flow_dissector
 namespace exclusivity test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241114-flow_dissector-v2-7-ee4a3be3de65@bootlin.com>
References: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
In-Reply-To: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
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
index 1e17254376ec440816670a564f128a7c0275c618..8e6e483fead3f71f21e2223c707c6d4fb548a61e 100644
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


