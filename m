Return-Path: <linux-kselftest+bounces-7538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF4789EC02
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDEC1F21E37
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FE313D269;
	Wed, 10 Apr 2024 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2Q5WbWZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AB313D250;
	Wed, 10 Apr 2024 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734237; cv=none; b=B9ngtIkMaXgdNPOFzboojNw1SJiaNqJKM0ouQrUkxMNDOW40Jts8WWfl9t24ruke+jZD1QclUQ7+sCy8SioM/hykzx8dg5eGfuEM2XhEdMWiUYGHQ8GaVwlsE/IZWtG0344G0VYtItPbBTCEolRePpNLnCpOEDtp1eupuBJUHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734237; c=relaxed/simple;
	bh=YgGRSRvqNQn9bdPBBGWomNv06kRDRT22onFlm2KCtuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AVLXgq06YAy7G+uIUnbR6TkNZX0LwOigvoyN8ERSDYDZ4amgt+E2gC3fNLXcwmdM83Z1fp0F1xpdpQsUpCCZWiAO4jz7pWe5lS5rsNgOuVhy0vMtMWiMlQcCvV7Fl2mpy6dsUkwFKrUn8WpG2Svi30JyWsDv440x2Q4L69zlMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2Q5WbWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E690BC43390;
	Wed, 10 Apr 2024 07:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734236;
	bh=YgGRSRvqNQn9bdPBBGWomNv06kRDRT22onFlm2KCtuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2Q5WbWZ/0q2Y0ZwpuTY/u+GQOYywkRx3SZJsJSff8TfayM4TqHXHLZ1dklXQVUVd
	 ke0C6IRIrgffUmbTk+vh+XfPxIMSa/q+VvJZddRL8Mmqh+CFDiY1dk7G0DPSIONw8J
	 2FLnoyiww/vRVUANUIgsD/+aUsaLAwUyfLly7Uj+jpiQWFimUYXaADb7qH63xUYFiT
	 M8SMhQ5IiRRLX0ia858Zt4IGEC4nlxHvXuS9erQ1qX664kkPuv8lCaZoZ2U9FuZNRh
	 e2Y9RsQUUxOUGA/STdo23MgzRm4Pm+Pt20IGVtDW6TAhteEQnAj4KiW5kqFMpApg6Z
	 YaY/BUPAzaGBA==
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
Subject: [PATCH bpf-next 06/14] selftests/bpf: Use log_err in network_helpers
Date: Wed, 10 Apr 2024 15:29:39 +0800
Message-Id: <77e0288d4757b2fcc2c491a2ed535ef223268071.1712733999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712733999.git.tanggeliang@kylinos.cn>
References: <cover.1712733999.git.tanggeliang@kylinos.cn>
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
index 7ddeb6698ec7..9fd271d5d571 100644
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
@@ -447,22 +448,30 @@ struct nstoken *open_netns(const char *name)
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
@@ -475,7 +484,8 @@ void close_netns(struct nstoken *token)
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


