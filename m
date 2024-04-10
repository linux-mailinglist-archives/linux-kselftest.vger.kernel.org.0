Return-Path: <linux-kselftest+bounces-7535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7DF89EBF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F29F1F21739
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF3613CFBB;
	Wed, 10 Apr 2024 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oacjKIGo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B1213C9D7;
	Wed, 10 Apr 2024 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734217; cv=none; b=rCbREDOHhGweoGM0eJwWCrItydIvCrlcEnBW4RoQ+RIn6S58YaY6Dr0TmzN2n1uqToY+cwJgj3g0oQ0zbjZbkBVIhJkz4S6f3GjCwi0IZpXCuFgTqjCK1dAI9W96OmXdBbhB04AztnE1xHyBJrRTHCsmlh04NZeom1AcHIfk3i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734217; c=relaxed/simple;
	bh=UoddJk6fHo9GNGgLLytEAkLLAyBEiqpzG4m+11ozUEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V7hwpPLBq9v/Rw4bNx9W5ejZR6IpUH4hgpmb+wmUB7KfNZAhiJQi5X5wbCvkTc3zxbI+jhlBSnr9wUtooy9F1emUfPDk6xjhih254G0vS9nl8Zdls8LR8gUuDWuhYHd5dppDIHWqDM/eAldhis1qa2Qz8L7v41xcOs/L4m4Z5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oacjKIGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77351C43142;
	Wed, 10 Apr 2024 07:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734217;
	bh=UoddJk6fHo9GNGgLLytEAkLLAyBEiqpzG4m+11ozUEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oacjKIGo50myhLg/QpZQg5KR/GCgSte4+gWBSswH/sFzYS5n7OCYZdvQh/lphZXE3
	 KYtQCzZfUM5ydf15OIlONASEJ7PULWcW/oXv4lKeFrg9u2KzRGJN361Ex077XYclC4
	 Y0OarUMJyY72JzSMDkvbtVFQVKvpt74uTkPqXiWhxySHa3wH/UP92pwutzub0CYctt
	 vzjDLzwXKGGFX6aI0JBO5ZHa/VOnqCHjt7VdpbZ88dzdtZXPOA07VjLutt7KWvt6ab
	 Rf72BePk5aD3ehqVzPQ53jlzmKBV5e9F5KG5fdno+FCOFimF5pfZ7K2l4bnon8M5PE
	 pNsLIxsiqIOzQ==
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
Subject: [PATCH bpf-next 03/14] selftests/bpf: Use connect_to_addr in cls_redirect
Date: Wed, 10 Apr 2024 15:29:36 +0800
Message-Id: <0f97d46b5495544b0f9f9059378fddd42ad827f6.1712733999.git.tanggeliang@kylinos.cn>
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

This patch uses public helper connect_to_addr() exported in
network_helpers.h instead of the local defined function connect_to_server()
in prog_tests/cls_redirect.c. This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/cls_redirect.c    | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
index 013051555ce6..4b185b608fae 100644
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
+	*conn = connect_to_addr((struct sockaddr_storage *)sa, slen, type);
 	if (*conn < 0)
 		goto close_server;
 
-- 
2.40.1


