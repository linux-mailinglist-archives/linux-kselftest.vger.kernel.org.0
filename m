Return-Path: <linux-kselftest+bounces-7660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD6B8A0548
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E60E9B22041
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0964B60882;
	Thu, 11 Apr 2024 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMKX3Rji"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D01604DD;
	Thu, 11 Apr 2024 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797504; cv=none; b=uVv7FDUXUYE0S390iTv65HJcv+dIzew5PYFQd3zqI9c11LQRzNUyxb5gRB+HU5FXLmVb+3aRMcZKwrbINrO71KPLoqY9hJddBhPHaeRX/2Rj3+D0ZjjzdA9N7sJQNEenWOH87OA/xXK+XpHNiUDzDyXR4tLALR8YSatnE5b69E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797504; c=relaxed/simple;
	bh=UMsJz02F0Aq81sLV0Yh1Banv8hIJKOdtNjKb5msmB68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rKsqKvfnRsDYaQP8i8OEULV8vVeYbthT2aqA9PQn64mv5pIur9xtLLghn2KlvibBn13ypfbUm0EWI6OHTCTnwpvcockg/tgOmTr5xWAHBV8LDCwUhQvQJ+ZtRJoUW4Nv7yMgdV9YiS4EBWL8Tj0+xciPz9TgpEFVdzXCt5C/Xfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMKX3Rji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B88EC433F1;
	Thu, 11 Apr 2024 01:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712797504;
	bh=UMsJz02F0Aq81sLV0Yh1Banv8hIJKOdtNjKb5msmB68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oMKX3RjiFi4+cQn01BrDMW7yFXz7N01+aT5CGFBx1dLnW57PQ7q4ZsiAUIfPW+Fvy
	 7bY5wecrKQ/Cwc2naMDb+x7RP1eNnTyxmHYrjao6sn3X2hhuPlW+QjjqiLPDyvm3Y3
	 LDRNvYa9bfbZyhpGgm1HMSReCDi1nQOIDnsVePHba+6KeCt7cUQ4i1XeEhuUp2R893
	 U2ov8jAmVYzjpZ6BumUbEjuq6L2xc5388krnYI8JYlnCDrTnPjX/b2tl4bgr8ZOe4E
	 fprYQE3mhoqdGfK5mqOjLjhabjDZAZCsVlZpNy7udUa7xTELK5CX7oG/7fGEthUAvQ
	 hXVjX2CxWEB1A==
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
Subject: [PATCH bpf-next v2 14/14] selftests/bpf: Use connect_to_addr in test_tcp_check_syncookie
Date: Thu, 11 Apr 2024 09:03:22 +0800
Message-Id: <993fe5771221a5307d566ff88fcbf3f41ecad48f.1712796967.git.tanggeliang@kylinos.cn>
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

This patch uses public helper connect_to_addr() exported in
network_helpers.h instead of the local defined function connect_to_server()
in test_tcp_check_syncookie_user.c. This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../bpf/test_tcp_check_syncookie_user.c       | 26 +------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
index e6ad4895d2b3..e678228b915f 100644
--- a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
+++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
@@ -25,30 +25,6 @@ static int setsockopt_mode(int fd, int dual)
 	return setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, (char *)&mode, sizeof(mode));
 }
 
-static int connect_to_server(const struct sockaddr *addr, socklen_t len)
-{
-	int fd = -1;
-
-	fd = socket(addr->sa_family, SOCK_STREAM, 0);
-	if (fd == -1) {
-		log_err("Failed to create client socket");
-		goto out;
-	}
-
-	if (connect(fd, (const struct sockaddr *)addr, len) == -1) {
-		log_err("Fail to connect to server");
-		goto close_out;
-	}
-
-	goto out;
-
-close_out:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
-
 static int get_map_fd_by_prog_id(int prog_id, bool *xdp)
 {
 	struct bpf_prog_info info = {};
@@ -114,7 +90,7 @@ static int run_test(int server_fd, int results_fd, bool xdp,
 		goto err;
 	}
 
-	client = connect_to_server(addr, len);
+	client = connect_to_addr((struct sockaddr_storage *)addr, len, SOCK_STREAM);
 	if (client == -1)
 		goto err;
 
-- 
2.40.1


