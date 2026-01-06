Return-Path: <linux-kselftest+bounces-48344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 556ACCFADF1
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 21:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EB1E30515B4
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 20:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FDB34E747;
	Tue,  6 Jan 2026 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M10Zzc6+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C0534DCE4;
	Tue,  6 Jan 2026 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767729730; cv=none; b=I24ghjfw82mhuv6RNHxxpVgrIt0tFY4vunIJxBq2ZRjgELgms5Lz/rYIgIM7aZgpzyYxbXWgDynIwcFRs5eyK9w3DbO03sbz8MpDwswEKIBkWMvs7/L7tJuBDacSQETJF0kITG9uHzYheJwDbbwfq7a5wo4i3euTXuuerjYcAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767729730; c=relaxed/simple;
	bh=jGhiLGxy4zzvBPe6LwhhiAf2P5iVXJGqVObOsAp19AI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwZly9PBRG8VpDeI0hrJxBAezPWQmBkmOznkDKtYzqsySe4oBN7SHqlP4xq2RXoCqBPVv3ECuKq3wxgP8DyoLr66BbWS7hfvFfLq84ESbj2g5pq+EE6rzmYz3n+ZzeZptFT20nbpwTNojcvWt5BH1pxUlvIM4Sdz8jcEXBj3E68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M10Zzc6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCB1C116C6;
	Tue,  6 Jan 2026 20:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767729729;
	bh=jGhiLGxy4zzvBPe6LwhhiAf2P5iVXJGqVObOsAp19AI=;
	h=From:To:Cc:Subject:Date:From;
	b=M10Zzc6+oRi4gGT6hBtUc0DgDs6hKLrMw3DlOMne7QpSy3MiXQuRaS8rP2d9RfZu9
	 nc9B83J8YrSYpvHeY5GHdsvIEHfEC51KxgjX0O1w1og8k9OfAd5evSk3PlSGsIlViu
	 XjPkc244FkDxceXwV8N+AK+f1DS5fY/iCZ7uhFxwPTGnUI/6pmRScqcD+gPHBLtfpU
	 xh5Y7qs5Idz9xJnZx/SBq2KxpuDcsBp2v0AbgQovVsGQ2nri71Zi+xyqmXq+6IUFRi
	 h8jAe5Xgus2oZJfHDcFdrua4LE7jxdEtuhBJy5ocpz3J57VIliSYRufZyplVPg8/0s
	 UY28VNTewC+Zw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	sd@queasysnail.net,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: tls: avoid flakiness in data_steal
Date: Tue,  6 Jan 2026 12:02:05 -0800
Message-ID: <20260106200205.1593915-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We see the following failure a few times a week:

  #  RUN           global.data_steal ...
  # tls.c:3280:data_steal:Expected recv(cfd, buf2, sizeof(buf2), MSG_DONTWAIT) (10000) == -1 (-1)
  # data_steal: Test failed
  #          FAIL  global.data_steal
  not ok 8 global.data_steal

The 10000 bytes read suggests that the child process did a recv()
of half of the data using the TLS ULP and we're now getting the
remaining half. The intent of the test is to get the child to
enter _TCP_ recvmsg handler, so it needs to enter the syscall before
parent installed the TLS recvmsg with setsockopt(SOL_TLS).

Instead of the 10msec sleep send 1 byte of data and wait for the
child to consume it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: sd@queasysnail.net
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/tls.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index a4d16a460fbe..9e2ccea13d70 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -3260,17 +3260,25 @@ TEST(data_steal) {
 	ASSERT_EQ(setsockopt(cfd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls")), 0);
 
 	/* Spawn a child and get it into the read wait path of the underlying
-	 * TCP socket.
+	 * TCP socket (before kernel .recvmsg is replaced with the TLS one).
 	 */
 	pid = fork();
 	ASSERT_GE(pid, 0);
 	if (!pid) {
-		EXPECT_EQ(recv(cfd, buf, sizeof(buf) / 2, MSG_WAITALL),
-			  sizeof(buf) / 2);
+		EXPECT_EQ(recv(cfd, buf, sizeof(buf) / 2 + 1, MSG_WAITALL),
+			  sizeof(buf) / 2 + 1);
 		exit(!__test_passed(_metadata));
 	}
 
-	usleep(10000);
+	/* Send a sync byte and poll until it's consumed to ensure
+	 * the child is in recv() before we proceed to install TLS.
+	 */
+	ASSERT_EQ(send(fd, buf, 1, 0), 1);
+	do {
+		usleep(500);
+	} while (recv(cfd, buf, 1, MSG_PEEK | MSG_DONTWAIT) == 1);
+	EXPECT_EQ(errno, EAGAIN);
+
 	ASSERT_EQ(setsockopt(fd, SOL_TLS, TLS_TX, &tls, tls.len), 0);
 	ASSERT_EQ(setsockopt(cfd, SOL_TLS, TLS_RX, &tls, tls.len), 0);
 
-- 
2.52.0


