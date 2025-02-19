Return-Path: <linux-kselftest+bounces-26980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A75A3C2CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B4A17A3C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AF51F5837;
	Wed, 19 Feb 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ggDp1br9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3EB1F4176;
	Wed, 19 Feb 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976790; cv=none; b=kb+9cPmuOCdcG94fPGKFM0orS/0AAeOyriMg8fLyoBpYgGWisRMUpN3bPfuFlG3ci9jg2hvFxe9M1l2MDbJDWNnfHEBZfwlSMsavHp/8DGnK0a3xskV79DHEpR2PsCJ5n/X20u8V9W1LxDjfXjDKUjx/Zhm1n6HAYpGzNI9zuhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976790; c=relaxed/simple;
	bh=IUWt6BlA3nz5q9tU9OtyNMXBpp7uAHSvmV5zMkpo09I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aJFl/uxEAgRkiG3AiNjAVB4Kr5dQtkBAbnoJ+J0/lV7q0hBZWojKQEfMljzifzz75NZ+8O7tdMyBC+w55LXsTKv8RmT6mB6XV5mrl7IkOA6fP6gfhANzvYdeEOaHNr6bYPepvfIvOQ3eYJsoG8qYQ/6NTfiXbbZyNMT5EsH7Sh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ggDp1br9; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E5B8204DC;
	Wed, 19 Feb 2025 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739976786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpHw9c/eOKMcAGX5xz4agnqcyuJa9chaURQCdlZsdw4=;
	b=ggDp1br9WwoQsozcj8MZeeryE4xUynvBkWWEAgUc84U57/cD143m0fgSlTNwJEkOH277oc
	uEbbg5aERc4McYgYv1g7SLA2rPTpEp8vHau5dsxm6OkUdwhD8bfNyp8D+Qu6Z13lnBUG/n
	l5nhhJDPN++ItSXf35iU1fE9f+qmcFfUZriqXD8vRnIQSU0I7k7W7RwyKFB9VbHqfBlVr1
	vSRBfDNGHRLR3pksmCz3Tw4yCYyO8hVnY04bjU/NpAb89UVVJrgyDfaBwdOPWhriRu3Zm8
	monLbzndzDesEgIKsLLqU59B23Y42xtASd5wdffOHJLlnR/0nHzWJ3J14TU4QA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 19 Feb 2025 15:53:03 +0100
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: ns_current_pid_tgid: Use
 test_progs's ns_ feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-b4-tc_links-v2-4-14504db136b7@bootlin.com>
References: <20250219-b4-tc_links-v2-0-14504db136b7@bootlin.com>
In-Reply-To: <20250219-b4-tc_links-v2-0-14504db136b7@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrohhluhhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhon
 hhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhholhhsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

Two subtests use the test_in_netns() function to run the test in a
dedicated network namespace. This can now be done directly through the
test_progs framework with a test name starting with 'ns_'.

Replace the use of test_in_netns() by test_ns_* calls.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/ns_current_pid_tgid.c | 45 ++++++++--------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index 78020ece6a29c3bec4600f4fd6fe88fdbd2a768b..99c953f2be21581f8362f6c9217d395c06e7b5b4 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -200,25 +200,6 @@ static void test_ns_current_pid_tgid_new_ns(int (*fn)(void *), void *arg)
 		return;
 }
 
-static void test_in_netns(int (*fn)(void *), void *arg)
-{
-	struct nstoken *nstoken = NULL;
-
-	SYS(cleanup, "ip netns add ns_current_pid_tgid");
-	SYS(cleanup, "ip -net ns_current_pid_tgid link set dev lo up");
-
-	nstoken = open_netns("ns_current_pid_tgid");
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
-		goto cleanup;
-
-	test_ns_current_pid_tgid_new_ns(fn, arg);
-
-cleanup:
-	if (nstoken)
-		close_netns(nstoken);
-	SYS_NOFAIL("ip netns del ns_current_pid_tgid");
-}
-
 /* TODO: use a different tracepoint */
 void serial_test_current_pid_tgid(void)
 {
@@ -226,15 +207,21 @@ void serial_test_current_pid_tgid(void)
 		test_current_pid_tgid_tp(NULL);
 	if (test__start_subtest("new_ns_tp"))
 		test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_tp, NULL);
-	if (test__start_subtest("new_ns_cgrp")) {
-		int cgroup_fd = -1;
-
-		cgroup_fd = test__join_cgroup("/sock_addr");
-		if (ASSERT_GE(cgroup_fd, 0, "join_cgroup")) {
-			test_in_netns(test_current_pid_tgid_cgrp, &cgroup_fd);
-			close(cgroup_fd);
-		}
+}
+
+void test_ns_current_pid_tgid_cgrp(void)
+{
+	int cgroup_fd = test__join_cgroup("/sock_addr");
+
+	if (ASSERT_OK_FD(cgroup_fd, "join_cgroup")) {
+		test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_cgrp, &cgroup_fd);
+		close(cgroup_fd);
 	}
-	if (test__start_subtest("new_ns_sk_msg"))
-		test_in_netns(test_current_pid_tgid_sk_msg, NULL);
 }
+
+void test_ns_current_pid_tgid_sk_msg(void)
+{
+	test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_sk_msg, NULL);
+}
+
+

-- 
2.48.1


