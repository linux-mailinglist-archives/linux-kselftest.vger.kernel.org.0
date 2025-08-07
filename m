Return-Path: <linux-kselftest+bounces-38532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FC2B1DFCD
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 01:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E81723346
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 23:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE5262FD0;
	Thu,  7 Aug 2025 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV4nXWie"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D49256C87;
	Thu,  7 Aug 2025 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754609354; cv=none; b=VREiY6eDns5C0BuFkQdCZVtjdhiqcS0JElGZVQoWvz+DdPpOyHU+828us5CtBQKSwzSpRuQgDukH5vRkre+zC+tuokc1S4O4FjvVNHeqFqe1tkX3anGS3p/BPNJUVU074zLzfkwZvI/1O6mCcpyt/gTm9Nu1E5mYepzoLICmLTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754609354; c=relaxed/simple;
	bh=SwfmDGDbFbfWMtCEiabspD+RCuPytk+hWkDJu2Ixei8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sg5XuBcAUmZ1OeyMy0Jh/fVlbI1f+IwTpO+VmoRLTPxxlxyX0eoX88u+mIhJKp6ntc9u7XyasflAs9drEeAoJHxXS1GHN7fLtzpDLxyAMXOsSu4bh0AhCkOQDkyFcGuPk7HyU7ENve5u72we9BsWTnBc3xYQFRt7unRUOkLFLcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV4nXWie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4A2C4CEF6;
	Thu,  7 Aug 2025 23:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754609354;
	bh=SwfmDGDbFbfWMtCEiabspD+RCuPytk+hWkDJu2Ixei8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IV4nXWie4LabI3e7R6USg7GJHd2I6ornkz6NhJnQRVmBN4voNlnQiLXfb4MQtj9te
	 ippmWPJ8AqZHeJp2P1h/pneWftP1j12FdHy0rOcRqqH4PYF3CqK2GU3LMgp5+O2leB
	 zXMQkb1AYXqMosQNxg5B+hFNt3B2JgHdQ0UcjSRu9BW43PypTck930YYNq8QlKgiKm
	 QlXT3TYclVSTasy6yL7GFt2QBFR/n4sY5IS0HSYDXb9IyiGDbhipfq6gkluXfC9d54
	 JQ7eL4uh4t0XiPsjd/rNb2IeQ2Xpx+5s3YFtF2KaNIG1swwD04w2e8sr44ryy3+rtM
	 cZqLBw2dpnKhw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	sd@queasysnail.net,
	will@willsroot.io,
	savy@syst3mfailure.io,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 2/2] selftests: tls: test TCP stealing data from under the TLS socket
Date: Thu,  7 Aug 2025 16:29:07 -0700
Message-ID: <20250807232907.600366-2-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807232907.600366-1-kuba@kernel.org>
References: <20250807232907.600366-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check a race where data disappears from the TCP socket after
TLS signaled that its ready to receive.

  ok 6 global.data_steal
  #  RUN           tls_basic.base_base ...
  #            OK  tls_basic.base_base

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/tls.c | 63 +++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 5ded3b3a7538..d8cfcf9bb825 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -2708,6 +2708,69 @@ TEST(prequeue) {
 	close(cfd);
 }
 
+TEST(data_steal) {
+	struct tls_crypto_info_keys tls;
+	char buf[20000], buf2[20000];
+	struct sockaddr_in addr;
+	int sfd, cfd, ret, fd;
+	int pid, status;
+	socklen_t len;
+
+	len = sizeof(addr);
+	memrnd(buf, sizeof(buf));
+
+	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_GCM_256, &tls, 0);
+
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = htonl(INADDR_ANY);
+	addr.sin_port = 0;
+
+	fd = socket(AF_INET, SOCK_STREAM, 0);
+	sfd = socket(AF_INET, SOCK_STREAM, 0);
+
+	ASSERT_EQ(bind(sfd, &addr, sizeof(addr)), 0);
+	ASSERT_EQ(listen(sfd, 10), 0);
+	ASSERT_EQ(getsockname(sfd, &addr, &len), 0);
+	ASSERT_EQ(connect(fd, &addr, sizeof(addr)), 0);
+	ASSERT_GE(cfd = accept(sfd, &addr, &len), 0);
+	close(sfd);
+
+	ret = setsockopt(fd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
+	if (ret) {
+		ASSERT_EQ(errno, ENOENT);
+		SKIP(return, "no TLS support");
+	}
+	ASSERT_EQ(setsockopt(cfd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls")), 0);
+
+	/* Spawn a child and get it into the read wait path of the underlying
+	 * TCP socket.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		EXPECT_EQ(recv(cfd, buf, sizeof(buf), MSG_WAITALL),
+			  sizeof(buf));
+		exit(!__test_passed(_metadata));
+	}
+
+	usleep(2000);
+	ASSERT_EQ(setsockopt(fd, SOL_TLS, TLS_TX, &tls, tls.len), 0);
+	ASSERT_EQ(setsockopt(cfd, SOL_TLS, TLS_RX, &tls, tls.len), 0);
+
+	EXPECT_EQ(send(fd, buf, sizeof(buf), 0), sizeof(buf));
+	usleep(2000);
+	EXPECT_EQ(recv(cfd, buf2, sizeof(buf2), MSG_DONTWAIT), -1);
+	/* Don't check errno, the error will be different depending
+	 * on what random bytes TLS interpreted as the record length.
+	 */
+
+	close(fd);
+	close(cfd);
+
+	EXPECT_EQ(wait(&status), pid);
+	EXPECT_EQ(status, 0);
+}
+
 static void __attribute__((constructor)) fips_check(void) {
 	int res;
 	FILE *f;
-- 
2.50.1


