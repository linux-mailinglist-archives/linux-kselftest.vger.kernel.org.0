Return-Path: <linux-kselftest+bounces-7648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9098A052E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F120DB22B0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E421B5FDC8;
	Thu, 11 Apr 2024 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8qP0ZxG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D96EEDA;
	Thu, 11 Apr 2024 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797425; cv=none; b=JD3v++RAzumgOB6gglMRDW6Z6KKqwcbfxz9XiBFZHl5dqZZVvxCDkwp4UvjPFsjcFt8Jivfpdg5Bdj9bDcgD+qAXnyxJkb6UT4md6draoj4Vu7eWhj33bXFk68QDW6pHlFBB+Dw/s751goOEFVB+0KBREl6yXKMqhu3X3lMpfdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797425; c=relaxed/simple;
	bh=XWeh00IOXYJlftJnTBXDAKK+X/bhZEtWsLxktauMllw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P/iAMMEDbfG9IW+jAWjUs4CAZ9wl2ypd1ptPhZagpF80aXLB0tnM7GjAvtleJi+DhFtzl50XZcIRC+uDIuCiZ7jjhyO7lI7r9WORujk//+V1YHB4sqDgPfFbWZAayxoXLgECE9AdU2MqEnyxQN8lIZ8VZtsz6jf5nkwuV9HN20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8qP0ZxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4EEC43394;
	Thu, 11 Apr 2024 01:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712797425;
	bh=XWeh00IOXYJlftJnTBXDAKK+X/bhZEtWsLxktauMllw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8qP0ZxG8bQCGCNgE0Nt1ezsPDmE0k9gphhviYpt6vwSRJFDcDBVD8ORori4jX19D
	 t1vmGG3ZuQWYPl7u7aWsP5n6JuS3xDVIAP2AEETlZGJrv+K11PFjsgcwwFFFsucn9X
	 LFSWzJ7LvMzPKVkVT1y5s4f1NNVNel0YFvOxLH+FZ6EPFm75vX2SdnkgvcU5c+xr7D
	 irnDR/Ywnk+/NaNNgguQSI3TlI3SsUv4DioJtWnZnELy/0cHxFsoS+4pa7/G/WtI40
	 uZbE/Gz5tRwq1cMHAvX0klumHNEDuwzy+HoFC3EIQ9Tpi+0XpCsLlrUE76USZcWSIW
	 8OXOOcFVcXptg==
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
Subject: [PATCH bpf-next v2 02/14] selftests/bpf: Use start_server_addr in cls_redirect
Date: Thu, 11 Apr 2024 09:03:10 +0800
Message-Id: <2634fdf2fd6b799be8e97091f8984b22dbaacd96.1712796967.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712796967.git.tanggeliang@kylinos.cn>
References: <cover.1712796967.git.tanggeliang@kylinos.cn>
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
index 2a55f717fc07..013051555ce6 100644
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
+	*server = start_server_addr(addr, len, type);
 	if (*server < 0)
 		return false;
 
-- 
2.40.1


