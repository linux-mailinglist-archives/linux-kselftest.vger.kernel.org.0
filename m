Return-Path: <linux-kselftest+bounces-27340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005CCA41C47
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 12:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550F118914D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACE325A349;
	Mon, 24 Feb 2025 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uf7Ryz2s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3825A343;
	Mon, 24 Feb 2025 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395808; cv=none; b=sQhFi+EPwk0kjZlrQXfMBHoB2uumn6iXoiN6OLQVylq+cMEJYPscCu8maQVC4hcnRB02Kcoc/o4W9wQe7qyS4ICwxIgOLLnuVHaAt2KIO6y+GHxUkYitOywVCRbkuRJNYzQ6iGSD1Jyw24/x7uadRUlZxFoBakshlsFrayHbQo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395808; c=relaxed/simple;
	bh=Ar31Nhdd8QiAcZ8oddropVSOAvgf2XLEL+VolHuvbBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=phjls0Gd+JBHAglmcl5Vdylhh7dl4dB7wGnQm4qJni7lwNjuJ/jffaTnhbb+1Kul5ciF/amSuoF86D6ePvJIXXqpgO15071v4XweYAgaE6+zr4fUQUkExAGm4Cqru8koF1vyK5JPJQpuucvG4kifEgTyu/c3/nN2XaZeX286BfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uf7Ryz2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6429EC4CED6;
	Mon, 24 Feb 2025 11:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395807;
	bh=Ar31Nhdd8QiAcZ8oddropVSOAvgf2XLEL+VolHuvbBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uf7Ryz2spbi3D3TnKQtVvXjacNJt063MjpHqJE2JObjm6kpFAKBtPhRvikHMM03WO
	 IhDLXJygwXRDt9hRNsgSIcs5idqoSxuCxCWqdmUgOlxc3ouVlFNzyI3IUXtdy7vbkD
	 KLgRgp6Mhh6+2NaXcq4Qs0129PVN6+9ICxO3IXY9fRn/Q5+6g9/MBYtNjxsvIdlGRv
	 PG9HohzgLstbFdTCQ7G4YKDjpFqUMZEVy4hRA+F4ysQxNcQQ0zWw8anDJcZycc1Gax
	 +p1fd/MMfJHjhPLXm9cgEZUvveoo+6h0OtKQjmMlEqKMhPKsfKN4cFr3t3W8x5lHF8
	 nGOgfDTdTWZWw==
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
Subject: [PATCH AUTOSEL 6.13 03/32] selftests/bpf: Fix invalid flag of recv()
Date: Mon, 24 Feb 2025 06:16:09 -0500
Message-Id: <20250224111638.2212832-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
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
index 884ad87783d59..0c51b7288978e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -522,8 +522,8 @@ static void test_sockmap_skb_verdict_shutdown(void)
 	if (!ASSERT_EQ(err, 1, "epoll_wait(fd)"))
 		goto out_close;
 
-	n = recv(c1, &b, 1, SOCK_NONBLOCK);
-	ASSERT_EQ(n, 0, "recv_timeout(fin)");
+	n = recv(c1, &b, 1, MSG_DONTWAIT);
+	ASSERT_EQ(n, 0, "recv(fin)");
 out_close:
 	close(c1);
 	close(p1);
@@ -628,7 +628,7 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 	ASSERT_EQ(avail, expected, "ioctl(FIONREAD)");
 	/* On DROP test there will be no data to read */
 	if (pass_prog) {
-		recvd = recv_timeout(c1, &buf, sizeof(buf), SOCK_NONBLOCK, IO_TIMEOUT_SEC);
+		recvd = recv_timeout(c1, &buf, sizeof(buf), MSG_DONTWAIT, IO_TIMEOUT_SEC);
 		ASSERT_EQ(recvd, sizeof(buf), "recv_timeout(c0)");
 	}
 
-- 
2.39.5


