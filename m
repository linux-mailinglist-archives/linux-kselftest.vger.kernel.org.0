Return-Path: <linux-kselftest+bounces-10279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1968C6FF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 03:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C52DB212C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 01:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAFEA47;
	Thu, 16 May 2024 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhbMaN9G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F091366;
	Thu, 16 May 2024 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715822065; cv=none; b=H3JZ8Lfsjan/K1V4kBzPQqqIMSHxpEAp5oah2V8cGxL7waayVntND0u+5XrIGzPuNA/G2c+7d7sf5bsV2lZh83nkrJBT7CsiQ0FGkBDp/RBA8dLenf8SEIs4zECdKgezxqVRgd4WU9St5YexU6MLlhfpLCl3TR6KbVgzK8PVFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715822065; c=relaxed/simple;
	bh=G2WA+IiJuJCE45LBBIyhxmHVn1AFRba13pD3Hykej9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7oaD0xTqn09xtP6Ta48ltSwlmU7aDO+dE0dRK7t6GOVTlEcIicGLXxYJ3WnSEmPwjaAYB2QC8lSUk59SEp/vxE79DaE+JeP5bo9c5Y1vOr7veDPhV5kFLIu5NNhfszwJykTvoai2kUQwzEuM51N5qT2oBTiz5rTC6eBjtgH9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhbMaN9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEC6C32786;
	Thu, 16 May 2024 01:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715822065;
	bh=G2WA+IiJuJCE45LBBIyhxmHVn1AFRba13pD3Hykej9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DhbMaN9GFU9HZdxClw+ajXv7vVpBARXL6b0zCtdEMK4NDAGIrP1pOhU+tpX/MfG3A
	 7fXRSqt/ccgZzlyHbaS9MbAKlVv7z8z+Ml9D3VpYqWWgg3j2Ebzvu03qji12JJyslI
	 mPNTgmC9tOamv6fVJ/gzcjCl9Ck5dvGUjiVW1wLfr5vxzhTX++//4htY5h3KATUC3p
	 kw8+x5W+E/BHudNIt5v4YOkzWY7dYOdfWfH+nH1QwN+bHV/K/Ql7rwNo6CqVRsziYM
	 gXiAEC/gSzW/DFq9YgnXkRZeJmE3aa9PaoxfZgWpYA2OOZwfFwA79oiSpYPOKCkoTC
	 Z31GHs+SEGOuA==
From: Geliang Tang <geliang@kernel.org>
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 8/8] selftests/bpf: Use netns helpers in lwt tests
Date: Thu, 16 May 2024 09:13:14 +0800
Message-ID: <cd9a14a9367afa1731986a2816f2a6836c965603.1715821541.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715821541.git.tanggeliang@kylinos.cn>
References: <cover.1715821541.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses netns helpers create_netns() and cleanup_netns() in
lwt_helpers.h instead of using the local function netns_create() and
netns_delete().

For using these helpers. network_helpers.h needs to be included in
lwt_helpers.h. Then '#include "network_helpers.h"' in lwt_redirect.c
and lwt_reroute.c can be dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/lwt_helpers.h    | 26 +++++--------------
 .../selftests/bpf/prog_tests/lwt_redirect.c   |  2 --
 .../selftests/bpf/prog_tests/lwt_reroute.c    |  2 --
 3 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
index fb1eb8c67361..602a268502e2 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
@@ -9,6 +9,7 @@
 #include <linux/icmp.h>
 
 #include "test_progs.h"
+#include "network_helpers.h"
 
 #define log_err(MSG, ...) \
 	fprintf(stderr, "(%s:%d: errno: %s) " MSG "\n", \
@@ -16,27 +17,14 @@
 
 #define RUN_TEST(name)                                                        \
 	({                                                                    \
-		if (test__start_subtest(#name))                               \
-			if (ASSERT_OK(netns_create(), "netns_create")) {      \
-				struct nstoken *token = open_netns(NETNS);    \
-				if (ASSERT_OK_PTR(token, "setns")) {          \
-					test_ ## name();                      \
-					close_netns(token);                   \
-				}                                             \
-				netns_delete();                               \
-			}                                                     \
+		if (test__start_subtest(#name)) {                             \
+			struct nstoken *token = create_netns(NETNS);          \
+			if (ASSERT_OK_PTR(token, "setns"))                    \
+				test_ ## name();                              \
+			cleanup_netns(token);                                 \
+		}                                                             \
 	})
 
-static inline int netns_create(void)
-{
-	return system("ip netns add " NETNS);
-}
-
-static inline int netns_delete(void)
-{
-	return system("ip netns del " NETNS ">/dev/null 2>&1");
-}
-
 static int open_tuntap(const char *dev_name, bool need_mac)
 {
 	int err = 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
index 835a1d756c16..70b80171f7f4 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
@@ -57,7 +57,6 @@
 #define NETNS "ns_lwt_redirect"
 #include "lwt_helpers.h"
 #include "test_progs.h"
-#include "network_helpers.h"
 
 #define BPF_OBJECT            "test_lwt_redirect.bpf.o"
 #define INGRESS_SEC(need_mac) ((need_mac) ? "redir_ingress" : "redir_ingress_nomac")
@@ -308,7 +307,6 @@ static void test_lwt_redirect_dev_carrier_down(void)
 
 static void *test_lwt_redirect_run(void *arg)
 {
-	netns_delete();
 	RUN_TEST(lwt_redirect_normal);
 	RUN_TEST(lwt_redirect_normal_nomac);
 	RUN_TEST(lwt_redirect_dev_down);
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c b/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
index 03825d2b45a8..f51cbde7d8b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
@@ -50,7 +50,6 @@
  */
 #define NETNS "ns_lwt_reroute"
 #include "lwt_helpers.h"
-#include "network_helpers.h"
 #include <linux/net_tstamp.h>
 
 #define BPF_OBJECT            "test_lwt_reroute.bpf.o"
@@ -242,7 +241,6 @@ static void test_lwt_reroute_qdisc_dropped(void)
 
 static void *test_lwt_reroute_run(void *arg)
 {
-	netns_delete();
 	RUN_TEST(lwt_reroute_normal_xmit);
 	RUN_TEST(lwt_reroute_qdisc_dropped);
 	return NULL;
-- 
2.43.0


