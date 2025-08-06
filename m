Return-Path: <linux-kselftest+bounces-38405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85778B1CB9F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 20:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424E5627A48
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 18:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCE1290D85;
	Wed,  6 Aug 2025 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtghpN2c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559EB1D47B4;
	Wed,  6 Aug 2025 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503522; cv=none; b=utXX/0VvmdChaQufx/n3Hj5sf9IgNZNwKPub3NTJtvumqMiTh3UM3ONDL6T29Emf3C7L1HC6SjNSPam7KawB1MDzi1b2/3BQ08+qsPmySrcgdhCfVVhYa0WCLp3MeX0AZsH7VXPCQQ2YiV22qtRcTW8ileg3bpRPDuzh3nC3ugg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503522; c=relaxed/simple;
	bh=SwfmDGDbFbfWMtCEiabspD+RCuPytk+hWkDJu2Ixei8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtdOaYnWEbfTWQEVoEXIVrAQASRr0Dw/zFtGYT3LLXXOTByojKudvSfctIjtgg5I4dXZBSfMVyovWMn49OjIvWhMpfcnxqsBAwVVrWO4b6YI+PgIUCOaa049Vo9nA0wtq/5H4u09QOgVW/So6O2OY6pW6cA5TVvoUap0VGd40vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtghpN2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B15C4CEED;
	Wed,  6 Aug 2025 18:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754503522;
	bh=SwfmDGDbFbfWMtCEiabspD+RCuPytk+hWkDJu2Ixei8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtghpN2c2wrUxbYk2RMBM2fujRGO0DNxCKC8m0W8GxcqV8Rwsx3ZJ2mCyOjwqGYlZ
	 +QL4yJcK/QQunoF6J3S1EdLtj+940j0ZTZLKqE/FZI7JSCH6ZsW1T+dzrkFFx8qDYw
	 ZqiuNYMdgDR9nSCeAaKtDtiJ5cmmnkCryYQqXaJXUcJink0WC4lroy4RvtP+TExBYA
	 2dM98VilOQB9gBWik6hZyJsYVjmAmfhdA27KynxuVQ5KW0vM37h0xGgsxJ+ZSQn1fw
	 1xcxBQnmFcYtsXgHWrNgn6PFr6xTJkJHxI6EXmTkBSlOYZn+UogL8qEsahfP60CRbf
	 dbBlp5ZIZaOUQ==
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
Subject: [PATCH net 2/2] selftests: tls: test TCP stealing data from under the TLS socket
Date: Wed,  6 Aug 2025 11:05:10 -0700
Message-ID: <20250806180510.3656677-2-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806180510.3656677-1-kuba@kernel.org>
References: <20250806180510.3656677-1-kuba@kernel.org>
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


