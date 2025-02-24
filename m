Return-Path: <linux-kselftest+bounces-27342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C5A41CED
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 12:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4A3179BAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 11:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D602268C52;
	Mon, 24 Feb 2025 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH4kNSzu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109E268C5C;
	Mon, 24 Feb 2025 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395960; cv=none; b=rq8y7+HLrUHAha1pK2JK/vnxHl1QZG9zXtgyHBNO87xuU/ckEBGRIq8fmEc45RgJ5vafJZlRJA+gjIlQ3Y5kfjf4tb1uJLBq8yabzIKOLhIElTpYzOuuO2uvVUU2/+8goyPWUWZKBXqg2k2n3ZJfTnxnykmiHqvam4xFdhkdlUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395960; c=relaxed/simple;
	bh=qxxf968N+YHWwiFWN2ZPiACTLdep0AVpOc00263JmUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PxO2sR/OFIxhGKjNyfy4zcdEqif3HYn3gIqGSLRHrqccDnc2kk00TVYK/jtJJ2H2NtmKS3fU+Sw5SLDZduy21hRYl+CUvxYgB3A9hx4Wf8/ZfqWfpztF+VCMMtuCDNm+5P4/JnuSmn0Y7GZdcm2SW2gc3x1rfN9Sl+dcqNeCY4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH4kNSzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17133C4CEE6;
	Mon, 24 Feb 2025 11:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395959;
	bh=qxxf968N+YHWwiFWN2ZPiACTLdep0AVpOc00263JmUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TH4kNSzuuHLwzXhL4QodPHOCTaxgWToHe1WcTrKKUF71MbPvNat2KqZXtDhsO5L9x
	 peyz6E9/jExJclsffn12KxrU9+KDmWs5LbC4IsPmzT2tzKWfoptovzcmKu0EEJgl9W
	 MZ/KmXtbkccxWsnnH3eMpXCIR3H3/ylvAQxwhJzG21AMhTOszVbaQRPuRpWcQ/eS0i
	 F2jrfM39v08XbweJPL4Db9DiYRehe3E2FMHL53HF5xvxC+ihL3GuKlg+x7I0gkzSPb
	 wdq3nIOYNpK2UqgXyk8l8HvHdAWKibgmdhybLO7G7tC96zpi2Q5TLZ75G0hxtLNfhS
	 aVLiGE68kcVsg==
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
Subject: [PATCH AUTOSEL 6.6 02/20] selftests/bpf: Fix invalid flag of recv()
Date: Mon, 24 Feb 2025 06:18:55 -0500
Message-Id: <20250224111914.2214326-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111914.2214326-1-sashal@kernel.org>
References: <20250224111914.2214326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.79
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
index dda7060e86a09..b16d765a153a9 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -402,8 +402,8 @@ static void test_sockmap_skb_verdict_shutdown(void)
 	if (!ASSERT_EQ(err, 1, "epoll_wait(fd)"))
 		goto out_close;
 
-	n = recv(c1, &b, 1, SOCK_NONBLOCK);
-	ASSERT_EQ(n, 0, "recv_timeout(fin)");
+	n = recv(c1, &b, 1, MSG_DONTWAIT);
+	ASSERT_EQ(n, 0, "recv(fin)");
 out_close:
 	close(c1);
 	close(p1);
@@ -459,7 +459,7 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 	ASSERT_EQ(avail, expected, "ioctl(FIONREAD)");
 	/* On DROP test there will be no data to read */
 	if (pass_prog) {
-		recvd = recv_timeout(c1, &buf, sizeof(buf), SOCK_NONBLOCK, IO_TIMEOUT_SEC);
+		recvd = recv_timeout(c1, &buf, sizeof(buf), MSG_DONTWAIT, IO_TIMEOUT_SEC);
 		ASSERT_EQ(recvd, sizeof(buf), "recv_timeout(c0)");
 	}
 
-- 
2.39.5


