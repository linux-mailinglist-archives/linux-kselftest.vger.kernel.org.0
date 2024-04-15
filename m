Return-Path: <linux-kselftest+bounces-7935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4688A4810
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 08:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2996E281BA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 06:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C0A29B0;
	Mon, 15 Apr 2024 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7CLJp/K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0996914F62;
	Mon, 15 Apr 2024 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162716; cv=none; b=qHhDnCHuz+xS/EIJ1sMFs1gQiipQbh5/YpZaPfPcv/8D4VVDg3iymi9IxNU+Jhc5xRXL3MlNp8DSpAa65+qkJ9d6KBoWLj2eUnH4/VyxqJVXMne5Tzq3PmmiozI+bvG7zXSFh2/8Xaj/hqguTad1XnecOdmFf1Cv9q6pdIcQgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162716; c=relaxed/simple;
	bh=iu9Nt/eRnvrJD5oDNxZeMq9GCmOe6kMmAtqO73M1w5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dR4N+JO3jVg5pseNDtFb2WWyoiRhgKWz4KcD+xC1ZJvd2oda0rLE45naYa04vs6zYDXu65nyPz5xmQXsVEGwPuebyoimF7UPm3mtccpvE6u/aBpO0rcDTl9C7OrNa/IrXSkPld/+Go3a4nOKqkYTDtystLQfT9YH7Wef5adA8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7CLJp/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D88C113CC;
	Mon, 15 Apr 2024 06:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713162715;
	bh=iu9Nt/eRnvrJD5oDNxZeMq9GCmOe6kMmAtqO73M1w5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7CLJp/KAmPqKnc/bv22fqFzIaQyZ6lJe/HeWuRGHHvZxjzLW6JuQWqH16cy1VamM
	 wrkX82X7chPiMr3ww6xIKH0jME5RkWuQFsPAfBK/xbsE0tDcH00e+U2I9gqvB7Rhnv
	 zIr9rlH1YoQCCxVw+ymplSLHgbR9aUgpOCpbL8vGmcYprj/xKuDIM8lj06BsVVNBKe
	 PJl6CIRJiij61A1IS+DXNa/3WGu3rYHM9PBCFNVlG+jo34MEee8+31TyBxSKvPkiMY
	 ENiXGIHCsT4a3AO26ZzW8wnbDGGFoUyChet430WHArxtqj9Eu0CvTcDtcoI+XSGoEr
	 NHPF3i9vOYvhw==
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
Subject: [PATCH bpf-next v3 4/9] selftests/bpf: Use connect_to_addr in cls_redirect
Date: Mon, 15 Apr 2024 14:31:13 +0800
Message-Id: <7fbfb8bcdeb1f0bec699f351a715b869857591c3.1713161975.git.tanggeliang@kylinos.cn>
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

This patch uses public helper connect_to_addr() exported in
network_helpers.h instead of the local defined function connect_to_server()
in prog_tests/cls_redirect.c. This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/cls_redirect.c    | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
index 4050d470d2a2..9aa2f3b12884 100644
--- a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
@@ -36,22 +36,6 @@ struct tuple {
 	struct addr_port dst;
 };
 
-static int connect_to_server(const struct sockaddr *addr, socklen_t len,
-			     int type)
-{
-	int fd = socket(addr->sa_family, type, 0);
-	if (CHECK_FAIL(fd == -1))
-		return -1;
-	if (CHECK_FAIL(connect(fd, addr, len)))
-		goto err;
-
-	return fd;
-
-err:
-	close(fd);
-	return -1;
-}
-
 static bool fill_addr_port(const struct sockaddr *sa, struct addr_port *ap)
 {
 	const struct sockaddr_in6 *in6;
@@ -89,7 +73,7 @@ static bool set_up_conn(const struct sockaddr *addr, socklen_t len, int type,
 	if (CHECK_FAIL(getsockname(*server, sa, &slen)))
 		goto close_server;
 
-	*conn = connect_to_server(sa, slen, type);
+	*conn = connect_to_addr(type, (struct sockaddr_storage *)sa, slen);
 	if (*conn < 0)
 		goto close_server;
 
-- 
2.40.1


