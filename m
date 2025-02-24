Return-Path: <linux-kselftest+bounces-27341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BAAA41CA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 12:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF634179148
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27C1264F94;
	Mon, 24 Feb 2025 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmUCD7Dz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88371264F86;
	Mon, 24 Feb 2025 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395885; cv=none; b=Q/0WpDtqiTjCsK0DUqe7GnaMHDP+NhLSmKoNXn3/vgzkLz5eDqJZoVapJmgP4EWI6CO/Y/Hx3Tt92trUcTW9pZ4/ULoAehWjqbdH9JSOVyb1lwOlIKLyM5C3HA8RggsedXGtVbGW89OBqqtC25+qCCeOuo6G5DMmawoNCWDJaa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395885; c=relaxed/simple;
	bh=JUUcY/okrRUSb+ExrNOofazcc3tHz6adZShiyT4+ukg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5H/uPC6FwlcCBgz0pmv7JGTReRWBM2r923n1XHlhGlVNu2Dttv2hWzoTIBgov8WMD6+yac1w0jdZFZWnEr9gWOCGJ7b6aCWjjHdS7NLBaeYn5hz8Z5q8qoTxsxYMw/h8EJrosx5wQ/aSJsj/PBDab0tIgQv59mCZaaKRsRbJ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmUCD7Dz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C95C4CED6;
	Mon, 24 Feb 2025 11:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395885;
	bh=JUUcY/okrRUSb+ExrNOofazcc3tHz6adZShiyT4+ukg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmUCD7Dzs8mUsQGm1I+IVj5stfqlepYKalxGsJZTtbeVf9ZD/s//8N8X14x/1bl/s
	 /aAJikksiYxxJiuWWHskMOyjyvbrlflOQeKFnOEl30IMom+aFk435ENXW9PY+jd3Cc
	 ZP6Kr66me5O884xlarJ8FcXUe7dwa5JH1U2CCxopI3ttFKB+MTDAGq+j6jdHMtiwz0
	 sGlhWoyCEMiud3fspxO3OJ/AFiHM5kvlGytgtGsRSNUZiV4hgijxQL5HSGXmAhSEJF
	 eL9Hq+dkLfsf1ZctQ0ABVhPjdPQ/Yc9MSqCDCnIXiUip7oPj7pOXT5PgJ8nGp6j93g
	 mX7ZZtyUs5Bzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiayuan Chen <mrpre@163.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	mhal@rbox.co,
	sgarzare@redhat.com,
	yonghong.song@linux.dev,
	cong.wang@bytedance.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 02/28] selftests/bpf: Fix invalid flag of recv()
Date: Mon, 24 Feb 2025 06:17:33 -0500
Message-Id: <20250224111759.2213772-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <mrpre@163.com>

[ Upstream commit a0c11149509aa905aeec10cf9998091443472b0b ]

SOCK_NONBLOCK flag is only effective during socket creation, not during
recv. Use MSG_DONTWAIT instead.

Signed-off-by: Jiayuan Chen <mrpre@163.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://patch.msgid.link/20250122100917.49845-5-mrpre@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 82bfb266741cf..fb08c565d6aad 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -492,8 +492,8 @@ static void test_sockmap_skb_verdict_shutdown(void)
 	if (!ASSERT_EQ(err, 1, "epoll_wait(fd)"))
 		goto out_close;
 
-	n = recv(c1, &b, 1, SOCK_NONBLOCK);
-	ASSERT_EQ(n, 0, "recv_timeout(fin)");
+	n = recv(c1, &b, 1, MSG_DONTWAIT);
+	ASSERT_EQ(n, 0, "recv(fin)");
 out_close:
 	close(c1);
 	close(p1);
@@ -546,7 +546,7 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 	ASSERT_EQ(avail, expected, "ioctl(FIONREAD)");
 	/* On DROP test there will be no data to read */
 	if (pass_prog) {
-		recvd = recv_timeout(c1, &buf, sizeof(buf), SOCK_NONBLOCK, IO_TIMEOUT_SEC);
+		recvd = recv_timeout(c1, &buf, sizeof(buf), MSG_DONTWAIT, IO_TIMEOUT_SEC);
 		ASSERT_EQ(recvd, sizeof(buf), "recv_timeout(c0)");
 	}
 
-- 
2.39.5


