Return-Path: <linux-kselftest+bounces-6544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D56A88AB30
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62FF3699EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 17:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD771534E4;
	Mon, 25 Mar 2024 15:56:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4C515250B;
	Mon, 25 Mar 2024 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382219; cv=none; b=krxNVP3tzRF98mwhWatbd/oayyLbRkmPIqRGbC9wYygbb/HqX9b8VMC5gwEvzgbf8cSQhoEYOYfIr+3/3ZNmTisNyt6qWHutvThXGyZ6IU5UTr0uNP224AC4p9ZjDFEpNyc56k65k/2UXs6B74qnIg65JFi45MeCQZCv1sz4UXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382219; c=relaxed/simple;
	bh=qWAN2IdFrTeqQ3BZOuiogrDcY3pUVy9hIeMRXJbxHWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NklBNcPMzI7QxlQ0IClXoS1i/Wy0a1wPrQNGY8Ma1yrwen5y5+R6sMDS27vdHreXlQZUcxVsnBLyB8jDblZhWQM2hbQvef6U8OrfYJBr22hbc2O++TNptWg4/SFBHiPujTLA7lFMQOJ57pDUHKSoBzIuUBpMT7hu1H3TylSwisA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D77EC20011;
	Mon, 25 Mar 2024 15:56:54 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 3/4] selftests: tls: add test with a partially invalid iov
Date: Mon, 25 Mar 2024 16:56:47 +0100
Message-ID: <720e61b3d3eab40af198a58ce2cd1ee019f0ceb1.1711120964.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711120964.git.sd@queasysnail.net>
References: <cover.1711120964.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net

Make sure that we don't return more bytes than we actually received if
the userspace buffer was bogus. We expect to receive at least the rest
of rec1, and possibly some of rec2 (currently, we don't, but that
would be ok).

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/tls.c | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index c6eda21cefb6..f27a12d2a2c9 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1615,6 +1615,40 @@ TEST_F(tls, getsockopt)
 	EXPECT_EQ(errno, EINVAL);
 }
 
+TEST_F(tls, recv_efault)
+{
+	char *rec1 = "1111111111";
+	char *rec2 = "2222222222";
+	struct msghdr hdr = {};
+	struct iovec iov[2];
+	char recv_mem[12];
+	int ret;
+
+	if (self->notls)
+		SKIP(return, "no TLS support");
+
+	EXPECT_EQ(send(self->fd, rec1, 10, 0), 10);
+	EXPECT_EQ(send(self->fd, rec2, 10, 0), 10);
+
+	iov[0].iov_base = recv_mem;
+	iov[0].iov_len = sizeof(recv_mem);
+	iov[1].iov_base = NULL; /* broken iov to make process_rx_list fail */
+	iov[1].iov_len = 1;
+
+	hdr.msg_iovlen = 2;
+	hdr.msg_iov = iov;
+
+	EXPECT_EQ(recv(self->cfd, recv_mem, 1, 0), 1);
+	EXPECT_EQ(recv_mem[0], rec1[0]);
+
+	ret = recvmsg(self->cfd, &hdr, 0);
+	EXPECT_LE(ret, sizeof(recv_mem));
+	EXPECT_GE(ret, 9);
+	EXPECT_EQ(memcmp(rec1, recv_mem, 9), 0);
+	if (ret > 9)
+		EXPECT_EQ(memcmp(rec2, recv_mem + 9, ret - 9), 0);
+}
+
 FIXTURE(tls_err)
 {
 	int fd, cfd;
-- 
2.43.0


