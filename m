Return-Path: <linux-kselftest+bounces-8300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407708A94A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 10:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C7628294D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 08:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531EB7D08A;
	Thu, 18 Apr 2024 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbxpWqzG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295477D07F;
	Thu, 18 Apr 2024 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427792; cv=none; b=ip08pFl1QXCtidboZOKhtezRfkyMk9i0AD75QDsw392aVJhP+gDsZNyOwkYTXyhnSv2HM0d0bLvndnxmtODVKxttPVZVv/YAI3Hwyv+3mRwt7zXQGZzhLsqcpHvKwRBvrFxJZpD9T5eQQ+hwBwZPR9WP0S1LkV3XrJpJ+Y7jeu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427792; c=relaxed/simple;
	bh=CN54nD8S3wwbYRJJVvu0yi6JN/nK8LQvss7nkguVvaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u5ypYPDi0nywHoE/bZTwDMKcAgxr/tnnrK6n8cQypZwLYSPfvS/nf2k7YV+3kKOw6UNce2zRSXjY8QHGEw6WBSHpfsSP3i0DSNmNJbj9OEp8/3ugHGYqgrrkOIQxc7xGbY57bcqzjTSivpSXukbMPOZp9FC3sc+s7OiqIRmSizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbxpWqzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50591C113CE;
	Thu, 18 Apr 2024 08:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713427791;
	bh=CN54nD8S3wwbYRJJVvu0yi6JN/nK8LQvss7nkguVvaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbxpWqzGZTs5u38EA9avd/RNoGceqLlF13MfxNGVdAkVGuAnjtQkNY1+IS8zF+qp1
	 LFA6rxto4BjFhtv0xIYK5e1k8AeMIDiSa86tM29Tzd4dZtaTHhb+Xj3MXGw2a6EEq7
	 /muh4E5LwSG331TvP2kSAy72eDqwh6snYY45un+y2SYfywHfbYdnTRgdcT//FY8tt9
	 j763Lw4PXbgun+BWLQ8HKioeoWV3eyTicok57fFdWKH0TEuA3N+0t6MI8a1p9cYzGw
	 +HjEas6CMyMvyd075yjzMUMX96Pc/UrBFM3RgeloBC/1nmcIOLGeTE8FunMeDbDvgz
	 rODNkdHD3u3fQ==
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
Subject: [PATCH bpf-next v5 5/6] selftests/bpf: Use connect_to_addr in cls_redirect
Date: Thu, 18 Apr 2024 16:09:11 +0800
Message-Id: <4a03ac92d2d392f8721f398fa449a83ac75577bc.1713427236.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713427236.git.tanggeliang@kylinos.cn>
References: <cover.1713427236.git.tanggeliang@kylinos.cn>
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
index 68cb93106658..34b59f6baca1 100644
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
+	*conn = connect_to_addr(type, (struct sockaddr_storage *)sa, slen, NULL);
 	if (*conn < 0)
 		goto close_server;
 
-- 
2.40.1


