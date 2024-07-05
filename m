Return-Path: <linux-kselftest+bounces-13220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E573D9280C2
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 05:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907DB1F25032
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 03:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FDB76033;
	Fri,  5 Jul 2024 02:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ipgo53tQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC8F1643D;
	Fri,  5 Jul 2024 02:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720148335; cv=none; b=IABOEQDrIYgoKErNwWBJFhuIYCXzzLmJdZNMkorc/6qKXSuZdWXB+TsMC2EduYn6LhBjNdGgs2SVnmZqTJTBgT2s7/6sKIRsbS7nlRYiMLILkuJ+boP0jOBYCq04cJ6rjKT9h6+z7kNm2yhuAqhDtZf33lYxWxOTDHJyfT5c/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720148335; c=relaxed/simple;
	bh=00pdNC+8+bJCChvMSP7B2ks/Ry/OoNnOXIemGC5RruM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcuiHI9H7yxS3FEIj6V2wieWqch77VY6wd/mqct87QwF42QflAVl08OWWeMA+l8WbMifYgH1FKs+JEZNKwE6cPLAISQUPU3B8PziKbSy03q3DraOOge6VILeE+LxhkAdCgGQHjGapdqFwn3zD9m8f5FH1Qf179MGoYRcNi3HzEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ipgo53tQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4581BC3277B;
	Fri,  5 Jul 2024 02:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720148335;
	bh=00pdNC+8+bJCChvMSP7B2ks/Ry/OoNnOXIemGC5RruM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ipgo53tQlW4NqqT9JKFtucStZVJhFykS0i3lubCnGuNUjNTjtfZOjNsDI/e6VDQdG
	 TmAun2WWVObAeDWA53PR4RsDnePyz8ADYS/WfwjXH9FZ5v7RyY4D09tr4BJ+5Bqybx
	 wm+UX4wKB+3Jyr/J3TinPcBU8d1joV/qaZN+CP9q8wTEYnRm1tWSjHrYMlE8zUIeBN
	 bKfJ0B5/Z+b12vH/PTiRdqZFkvqwsW1D4+UbH8sbrpfZHfhECr+bnrvBN/JjwuI04U
	 +k+hcHFDfikBEhpqiJzjXNY4fAZ1l6NqtIKwRHDeV63AG/ihtFhr5BVmKqUU26kMF8
	 6G0TKB+xbiyuw==
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v8 2/9] selftests/bpf: Use start_server_str in sockmap_ktls
Date: Fri,  5 Jul 2024 10:58:24 +0800
Message-ID: <65e49479affc051c12a45b37be219af293095fe7.1720147953.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720147952.git.tanggeliang@kylinos.cn>
References: <cover.1720147952.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Include network_helpers.h in prog_tests/sockmap_ktls.c, use public network
helper start_server_str() instead of local defined function tcp_server().
This can avoid duplicate code.

Technically, this is not a one-for-one replacement, as start_server_str()
also does bind(). But the difference does not seem to matter.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 23 +++++--------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 2d0796314862..32be112967a5 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -6,25 +6,11 @@
 
 #include <netinet/tcp.h>
 #include "test_progs.h"
+#include "network_helpers.h"
 
 #define MAX_TEST_NAME 80
 #define TCP_ULP 31
 
-static int tcp_server(int family)
-{
-	int err, s;
-
-	s = socket(family, SOCK_STREAM, 0);
-	if (!ASSERT_GE(s, 0, "socket"))
-		return -1;
-
-	err = listen(s, SOMAXCONN);
-	if (!ASSERT_OK(err, "listen"))
-		return -1;
-
-	return s;
-}
-
 static int disconnect(int fd)
 {
 	struct sockaddr unspec = { AF_UNSPEC };
@@ -35,12 +21,15 @@ static int disconnect(int fd)
 /* Disconnect (unhash) a kTLS socket after removing it from sockmap. */
 static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
 {
+	struct network_helper_opts opts = {
+		.backlog = SOMAXCONN,
+	};
 	struct sockaddr_storage addr = {0};
 	socklen_t len = sizeof(addr);
 	int err, cli, srv, zero = 0;
 
-	srv = tcp_server(family);
-	if (srv == -1)
+	srv = start_server_str(family, SOCK_STREAM, NULL, 0, &opts);
+	if (!ASSERT_GE(srv, 0, "start_server_str"))
 		return;
 
 	err = getsockname(srv, (struct sockaddr *)&addr, &len);
-- 
2.43.0


