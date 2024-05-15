Return-Path: <linux-kselftest+bounces-10240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06D08C6087
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 08:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492421F23A1F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EDB3D388;
	Wed, 15 May 2024 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSiHs2Jw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B405540C03;
	Wed, 15 May 2024 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752866; cv=none; b=ALFeLOOyf/ddHzOLtJOdCy6Sqr8omGzDGLR8+Cj4rR/ekUj+DRL7hcW+Lhk6mCZBMmNeYBjseGsa6aTKjs51QTvqNK0cO8pVoLhNApi3F72lngyhjbw+e42oPtjU8IJPMCMwBB2HKaZtVO+PXpHP1SmBNFaJJr5S6PwLKtelX78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752866; c=relaxed/simple;
	bh=G2WA+IiJuJCE45LBBIyhxmHVn1AFRba13pD3Hykej9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqAIL8LjN2zGmJdFh2Q90MebxWZq+VlguIgDBxwsWpBoktE8BLkJuw6rnQBAdqgQIUXvOhnHn6DSPATop/vwCeFYs89YQsZqvc1jIXLivKpScp6Y3hCIdYheXaMGM0jKlgETXSr8ghsDDP0erliBB0EuCzOSJuAKq8ZzoFQTgaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSiHs2Jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F81C116B1;
	Wed, 15 May 2024 06:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715752866;
	bh=G2WA+IiJuJCE45LBBIyhxmHVn1AFRba13pD3Hykej9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fSiHs2JwVX4TODhgplxbC+vHukL9aEg7wYIQDH5tgAvJ554+lAesZK3sTZmiGCZZ2
	 DUnQR0uB3HPX5IA4RBZWlILMoLHVYiGKCoxUdbr9IidHh2BNv5s8Vjf6VNJ1DFBcCt
	 3CvKA1ptqWqvIflHLYzBHPKZDng5I74D6FRUGGNQ9bKwGM1dvqpL0D3JyQzozF24F/
	 WAoDrBaveO74yFAB0wDoPapSkoqZuobYZilW5P3GUufYe2vm1y6PhEIIJqVfV1yon0
	 eMVPWkceOncJbIds+ULg6vBZ2tkJzFxsJhM4xncMPE2yoTzkvEwkUnBHxjJuzq6wDM
	 fEtPtgvI3/L9Q==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next 8/9] selftests/bpf: Use netns helpers in lwt tests
Date: Wed, 15 May 2024 13:59:35 +0800
Message-ID: <92f1fe99018b50a92fedd7ce68abcb744f49d1cf.1715751995.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715751995.git.tanggeliang@kylinos.cn>
References: <cover.1715751995.git.tanggeliang@kylinos.cn>
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


