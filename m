Return-Path: <linux-kselftest+bounces-4781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3155F85695F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 17:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE3D1C2425C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5526134721;
	Thu, 15 Feb 2024 16:18:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDCB133417;
	Thu, 15 Feb 2024 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013884; cv=none; b=TUFJQIkH79TXyyxBefO8rwI9BnwolLOGjZufB8BJAzWzX+qhfn1v813gZ9Hx6bPFzj+IybvYZfcU9eWFbCrf0fAtYEPV9B0hV1Sv+zcIuLO+N/Bdon4sdpE19SjbPVVVjbvT50Fc042wYVo+ojZUcDtyeGSXgYXTQH5wTRSTQng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013884; c=relaxed/simple;
	bh=smhUgw1ALC0iK9KWj0jcvmYnMy3R/2N1TdKCGR+G4GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1e3SEe6cWNnTQ9yPBUmqqnZHDfHs+t6YX8BeJdfjtgUPQmS5C0hvuaIKvQJEAC7TKurwUW36nn1XSpXb6ZWt4+BgQudjRYeD21+Io1IAIcMhxd10h8nBq2hacUTZYRc+GNNbN7zWfSt3A7+PT4Z7/CQdFo5u8R527niVu6KEXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56B5C1C0006;
	Thu, 15 Feb 2024 16:17:58 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Vakul Garg <vakul.garg@nxp.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 5/5] selftests: tls: add test for peeking past a record of a different type
Date: Thu, 15 Feb 2024 17:17:33 +0100
Message-ID: <4623550f8617c239581030c13402d3262f2bd14f.1708007371.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708007371.git.sd@queasysnail.net>
References: <cover.1708007371.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net

If we queue 3 records:
 - record 1, type DATA
 - record 2, some other type
 - record 3, type DATA
the current code can look past the 2nd record and merge the 2 data
records.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/tls.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 2714c230a0f9..b95c249f81c2 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1511,6 +1511,25 @@ TEST_F(tls, control_msg_nomerge)
 	EXPECT_EQ(memcmp(buf, rec2, send_len), 0);
 }
 
+TEST_F(tls, data_control_data)
+{
+	char *rec1 = "1111";
+	char *rec2 = "2222";
+	char *rec3 = "3333";
+	int send_len = 5;
+	char buf[15];
+
+	if (self->notls)
+		SKIP(return, "no TLS support");
+
+	EXPECT_EQ(send(self->fd, rec1, send_len, 0), send_len);
+	EXPECT_EQ(tls_send_cmsg(self->fd, 100, rec2, send_len, 0), send_len);
+	EXPECT_EQ(send(self->fd, rec3, send_len, 0), send_len);
+
+	EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), MSG_PEEK), send_len);
+	EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), MSG_PEEK), send_len);
+}
+
 TEST_F(tls, shutdown)
 {
 	char const *test_str = "test_read";
-- 
2.43.0


