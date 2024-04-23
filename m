Return-Path: <linux-kselftest+bounces-8682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E398AE21D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 12:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6F9CB228E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E30B61691;
	Tue, 23 Apr 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToceAe+y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611A605CE;
	Tue, 23 Apr 2024 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867994; cv=none; b=ChBXz6zZU8MLa2tdQZjVNKeSiP07vL38MF2c1TneWWAACv6aA1M+jSPheUzBQVLAoK/kRTDtz+ziuo1qdg9tblYFyPZqDABcVPqunNhSjtKasLCj6UN0sGg1+RweGlbyLTZ5NgH5HrshNzipuuc4/xlMgcXiZSKUZ8sCBkIIfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867994; c=relaxed/simple;
	bh=4J1adAuX9oXH34Y3qG9TeINgYulPL2SQPOywb4uFuKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CDoSHq/p7dlEp91RMx4ZmmKNYZuop7x9oziMln2oTwqrv2BvIuyPzfvYh5HogtvhZEtswhaUgCIs89aEBKBYHY4n42UI8C1+zc79YCsyMZYAyLRLni54IhPNilftdLlfx1lCdkRWyZNobU+sBmBis4RpOBDo4TBxkLHRDiexoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToceAe+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71102C3277B;
	Tue, 23 Apr 2024 10:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713867993;
	bh=4J1adAuX9oXH34Y3qG9TeINgYulPL2SQPOywb4uFuKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ToceAe+yRZnryawNFUR2E+7Lf3E/QEvSzaomX8NALTrgRqPjm3Q1FER6Q7ytpt5A4
	 w/SmW/RmwWtba8c050o5zh8zge1VRqcP/4E7ieM4F9IhHsf2z7rEq7JGqW00VlIaIH
	 yNQtMuNXe+KULd2pLIC99OqU1IkHhzi4vKY/0qiVmerQ2iU/jpZ8np4lNz+c//u1Fi
	 xuCYT3duIb+SBGsQhihOJ2rDChv+OgL/AA5DrDJhrV472qz1A2KK8qudu6O49IRoOD
	 /hlrg6ZVs8mZbEesZ75SGewui1ctxvurcdwleNaNswdwr+9SEi4K1IKDvKmn5EjFHt
	 /SMuH7y5B7OFw==
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
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next v5 1/2] selftests/bpf: Check recv lengths in test_sockmap
Date: Tue, 23 Apr 2024 18:26:14 +0800
Message-Id: <0de8cc53c7b797fbb8d8a12748b30353ca99d98d.1713867615.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713867615.git.tanggeliang@kylinos.cn>
References: <cover.1713867615.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The values of recv and recvp in msg_loop may be negative, so it's necessary
to check if they are positive before using them.

Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
Fixes: 753fb2ee0934 ("bpf: sockmap, add msg_peek tests to test_sockmap")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/test_sockmap.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 43612de44fbf..24b55da9d4af 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -680,7 +680,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 				}
 			}
 
-			s->bytes_recvd += recv;
+			if (recv > 0)
+				s->bytes_recvd += recv;
 
 			if (opt->check_recved_len && s->bytes_recvd > total_bytes) {
 				errno = EMSGSIZE;
@@ -694,12 +695,14 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 						iov_length * cnt :
 						iov_length * iov_count;
 
-				errno = msg_verify_data(&msg, recv, chunk_sz);
-				if (errno) {
-					perror("data verify msg failed");
-					goto out_errno;
+				if (recv > 0) {
+					errno = msg_verify_data(&msg, recv, chunk_sz);
+					if (errno) {
+						perror("data verify msg failed");
+						goto out_errno;
+					}
 				}
-				if (recvp) {
+				if (recvp > 0) {
 					errno = msg_verify_data(&msg_peek,
 								recvp,
 								chunk_sz);
-- 
2.40.1


