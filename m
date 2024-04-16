Return-Path: <linux-kselftest+bounces-8112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD318A67F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AC628263B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA11F126F1D;
	Tue, 16 Apr 2024 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngomNeS9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201186250;
	Tue, 16 Apr 2024 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262479; cv=none; b=R+xBo1uJO43vttMCOPhw81jcXFSdB6tJd5eyPxuxISmT2k0SUUOkRFlRlF9yDAUStaOrc0XGJgcAcecvqLJizTsNTd8xDJIl2c4NBB/qYzzLLArjU1FaM1DwNdgXhpRmKy1WMmM2ZzV94Q2GeBRoIRaAiyjmrtRQrpXXKm7WiUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262479; c=relaxed/simple;
	bh=iu9Nt/eRnvrJD5oDNxZeMq9GCmOe6kMmAtqO73M1w5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vA2Lm7tVyCf/xnsM+g6qUzWm7S8QDYqrKyhCX769X8jzqq2JmaRlddATdlgxgGYJTOW+uBeog7b1torU9e5lv3UCDug09kRgF+WwPSfTMA5nEHpNfjpcybcadBqp+Ke2+uYsydwoYTZvzjV/UEFSaFcka5ujfkBtHAQYdJCDrck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngomNeS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38CFC4AF07;
	Tue, 16 Apr 2024 10:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262479;
	bh=iu9Nt/eRnvrJD5oDNxZeMq9GCmOe6kMmAtqO73M1w5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ngomNeS9sFkSJiFY2SftQLNfyvWnn/yBGFzfn3ZwTfgosCadFL/f3QKx/hEz8BENJ
	 CTHFU4uT3KzPaiNthxndndnpmR7dxxbFVIPKFog1Mi/JSla25d1eMBeFOMzJOL6c3r
	 Ns3m5SAvcY05brDzBgcXO5L3dFH84vZ3MLrChXfgO/T+NLQe5HhJsSGrlmg/hf1/H1
	 jZiKlKw0bkdcFKlO3VbUzsMOQz+o63RKzSoeqDHeK+Wgx/n8nSK5jtqQxxQWc/1s/A
	 QcnoTCiWMHvQ+0Ew9kTw284rx0wRbyNoicwOKLi9sC3dCByHUgwSCEgXvS/n5BArvR
	 24xTL4x+x22jw==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next v4 04/14] selftests/bpf: Use connect_to_addr in cls_redirect
Date: Tue, 16 Apr 2024 18:13:50 +0800
Message-Id: <50f65e54ec143b2800fbe308204e10f78be98559.1713262052.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713262052.git.tanggeliang@kylinos.cn>
References: <cover.1713262052.git.tanggeliang@kylinos.cn>
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


