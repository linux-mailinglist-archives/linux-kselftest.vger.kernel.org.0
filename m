Return-Path: <linux-kselftest+bounces-7475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1AC89D75D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 12:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2D31F24E56
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DE683A09;
	Tue,  9 Apr 2024 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMiUMSQQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C927555E55;
	Tue,  9 Apr 2024 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660261; cv=none; b=fKaNVqdnnz0jrXmPulO4jg3PCnA9nM0R36NtVZVLa65XZJ2MRGbjApe3Ahg5N4Cq6goDEeEB+1xTY+PPaBO5Yp7w+tXJxnJHQ2lp1l9uCdBs+gXJB5ScdlLsygbqNSgKHY7dwJBIPm3IjrL/m7wgMWnKdARMrotzF8RYuwMNtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660261; c=relaxed/simple;
	bh=a8jv71HbqomzCxr4sGj0MWsOMuupqs13ikX8wU6f5l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GvoiDtK+Kl44SurWlRuilKYGv8W82FE1h05k3ZzXQbNZeeHaAyh4AvLPUbGhreyrKS5r9WcUb2wdJmk7NXNoQOxPP6eZQAbOWlSr1IHJBK3krUZel1Gd0TnglOZYcgL/I5Ai9flo1hpdkBPtl4ZV8hc36YzZQJGNJgqM3PNVVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMiUMSQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835AEC43390;
	Tue,  9 Apr 2024 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712660261;
	bh=a8jv71HbqomzCxr4sGj0MWsOMuupqs13ikX8wU6f5l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMiUMSQQzTWZzkPOB778jnxEP3aWsuDSS0tzBukVr4ns/9YX9IWbE+dyYsHcam/Yb
	 aC0QghLJMsNqwGrg1HoXS1KNOGesksZBwU5NN5NrlKEe7tIwOi3BJUUg4jEeiyUMsK
	 qPzbFCu6G5eIydT4W4sZJgfSG7U7+5Ey3OQCAoOehgkLU98Q3mF1i2zneOkLXzSKSb
	 wJBxnDmWBlVt15GPj5myFjA72gXYkkwuoa6VyoGuSOiBEhT30TG9Ked42PpVw5PJDq
	 LNKhxRrnOko5ascBTYBAlLL/wZoCGnGPN4iH+hCs373tYadFj1OxCODNi0WxFnlZu9
	 sEK/uS33avf/w==
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
Subject: [PATCH bpf-next v3 1/4] selftests/bpf: Use log_err in network_helpers
Date: Tue,  9 Apr 2024 18:57:22 +0800
Message-Id: <987ca86e6f9a07d755b923d22bb393e98574d16b.1712659575.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712659575.git.tanggeliang@kylinos.cn>
References: <cover.1712659575.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helpers ASSERT_OK/GE/OK_PTR should avoid using in public functions.
This patch uses log_err() to replace them in network_helpers.c.

And drop '#include "test_progs.h"' in it, include <pthread.h> and
<sys/param.h> instead.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 04175e16195a..dbcbe2ac51ba 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -7,11 +7,13 @@
 #include <string.h>
 #include <unistd.h>
 #include <sched.h>
+#include <pthread.h>
 
 #include <arpa/inet.h>
 #include <sys/mount.h>
 #include <sys/stat.h>
 #include <sys/un.h>
+#include <sys/param.h>
 
 #include <linux/err.h>
 #include <linux/in.h>
@@ -20,7 +22,6 @@
 
 #include "bpf_util.h"
 #include "network_helpers.h"
-#include "test_progs.h"
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -442,22 +443,30 @@ struct nstoken *open_netns(const char *name)
 	struct nstoken *token;
 
 	token = calloc(1, sizeof(struct nstoken));
-	if (!ASSERT_OK_PTR(token, "malloc token"))
+	if (!token) {
+		log_err("malloc token");
 		return NULL;
+	}
 
 	token->orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
-	if (!ASSERT_GE(token->orig_netns_fd, 0, "open /proc/self/ns/net"))
+	if (token->orig_netns_fd <= 0) {
+		log_err("open /proc/self/ns/net");
 		goto fail;
+	}
 
 	snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
 	nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
-	if (!ASSERT_GE(nsfd, 0, "open netns fd"))
+	if (nsfd <= 0) {
+		log_err("open netns fd");
 		goto fail;
+	}
 
 	err = setns(nsfd, CLONE_NEWNET);
 	close(nsfd);
-	if (!ASSERT_OK(err, "setns"))
+	if (err) {
+		log_err("setns");
 		goto fail;
+	}
 
 	return token;
 fail:
@@ -470,7 +479,8 @@ void close_netns(struct nstoken *token)
 	if (!token)
 		return;
 
-	ASSERT_OK(setns(token->orig_netns_fd, CLONE_NEWNET), "setns");
+	if (setns(token->orig_netns_fd, CLONE_NEWNET))
+		log_err("setns");
 	close(token->orig_netns_fd);
 	free(token);
 }
-- 
2.40.1


