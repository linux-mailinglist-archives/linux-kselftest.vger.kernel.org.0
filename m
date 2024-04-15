Return-Path: <linux-kselftest+bounces-7934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD498A480E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 08:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48912282FCA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 06:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C926139;
	Mon, 15 Apr 2024 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue7TP1Y0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064B31BF53;
	Mon, 15 Apr 2024 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162709; cv=none; b=kKS22033kpe3b4aVEUGajXJCovzipf4iFFxmqatNnmkqd8VWBsp/IpvA1HzXD7m1qdxmyHDuf7x3BUE/NZkKNDd3rE+/jENYWmKeNJEgWTleW3uc9e/LazZiSu1OBAdQ6QpSs9ZfgfyVDc7YIhlGTHmQ6R4mLri9477L4Eq/zXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162709; c=relaxed/simple;
	bh=NHEB9TokBCk2Zcvs5aYjfmxZ3CANdUFDFp4WT/vneAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=smrVZCsvGFSYvWL8invLTfnvZyQt5V9tCX1msk0n01mPYM5gAI62UDIJT6awxaiCjTHbDhqvbu3iobMyPKVTcgiRvtercNY9X3Iv3Qje2AwyTmA8swjEYtMnjrakPx/I9OpeMR3KgWl4oyT7j9p9JecArMwJPfWV6SQD6hbbWQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue7TP1Y0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8104C2BD11;
	Mon, 15 Apr 2024 06:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713162708;
	bh=NHEB9TokBCk2Zcvs5aYjfmxZ3CANdUFDFp4WT/vneAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ue7TP1Y09SRvxEyZiCBdv56CTK/mFPrQ14Ufv+fqzFHmmCWrXkip07+x7NE+d5gh0
	 vJER4KfS+hqyuQQv7aNvWpj78AWdCXccFhT4Jg9VCjPbxoka9dKqiQL7YV9Z8OOuJY
	 8UGavu2cG2qL6TnCe+Y5gIlOE/NLbQjSlQVBOFL1vv8OgqZ4a4ThKWB43/3pRhmtsk
	 +kFZscxxV9IBLJSdqqqB6e43Wp06PMDng7WlNwgrsXSPzl9Nx998cwvwHf1wDWHvFJ
	 LH2dj2/1JY5VNS9GDiL+s8/lFiEqHCxswRKo2Mp+IVLS1UF7n6vQ+M2D1CXKkIGsDB
	 VzKZgVm19omsw==
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
Subject: [PATCH bpf-next v3 3/9] selftests/bpf: Use start_server_addr in cls_redirect
Date: Mon, 15 Apr 2024 14:31:12 +0800
Message-Id: <6b14b2c38ebfd1221555d3de3d413a0460282712.1713161975.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713161974.git.tanggeliang@kylinos.cn>
References: <cover.1713161974.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Include network_helpers.h in prog_tests/cls_redirect.c, use the newly
added public helper start_server_addr() instead of the local defined
function start_server(). This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/cls_redirect.c   | 20 ++-----------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
index 2a55f717fc07..4050d470d2a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
@@ -10,6 +10,7 @@
 #include <netinet/tcp.h>
 
 #include <test_progs.h>
+#include "network_helpers.h"
 
 #include "progs/test_cls_redirect.h"
 #include "test_cls_redirect.skel.h"
@@ -35,23 +36,6 @@ struct tuple {
 	struct addr_port dst;
 };
 
-static int start_server(const struct sockaddr *addr, socklen_t len, int type)
-{
-	int fd = socket(addr->sa_family, type, 0);
-	if (CHECK_FAIL(fd == -1))
-		return -1;
-	if (CHECK_FAIL(bind(fd, addr, len) == -1))
-		goto err;
-	if (type == SOCK_STREAM && CHECK_FAIL(listen(fd, 128) == -1))
-		goto err;
-
-	return fd;
-
-err:
-	close(fd);
-	return -1;
-}
-
 static int connect_to_server(const struct sockaddr *addr, socklen_t len,
 			     int type)
 {
@@ -98,7 +82,7 @@ static bool set_up_conn(const struct sockaddr *addr, socklen_t len, int type,
 	socklen_t slen = sizeof(ss);
 	struct sockaddr *sa = (struct sockaddr *)&ss;
 
-	*server = start_server(addr, len, type);
+	*server = start_server_addr(type, (struct sockaddr_storage *)addr, len);
 	if (*server < 0)
 		return false;
 
-- 
2.40.1


