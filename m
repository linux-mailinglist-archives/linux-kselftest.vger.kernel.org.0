Return-Path: <linux-kselftest+bounces-4785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7303C856969
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 17:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC3129124F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D51350D8;
	Thu, 15 Feb 2024 16:18:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643491350C0;
	Thu, 15 Feb 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013888; cv=none; b=Z45ydEgJIYmTludGpFO0R4qgvbd/0l1ZGUxFF2ZzmQjXzo1hEIyqopKCp7f4Q9uZry+AXxUaQ5EI6/68mKlHRV2fGt/eJkSPZUZvYeQIDuK5B87KXt6MuQLjGRezyxYvJyrKcO0Li1Gb5tkdmuXnLk/5dwyqvHbxVoAeo6WU/ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013888; c=relaxed/simple;
	bh=QI1W/06Au9iXzBzVmIiOLJIKfWmaBVU90t9aZ3IoNf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJC/OM46w6kBqdubTmpZIW5TpxE1BxXIhwUIXhivBPujNexdI4Ixv4czfbPGg7qCaugyqk68TrtxKj3KDmkzXFakDob3fFTVd4BZdBefeqn/OI/lA2K0Z6lgIdjbikJJuHRjD8N/gXaG1HrKicemt6Kr/AP5HUsEMN1pHlQw+eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3657E1C0016;
	Thu, 15 Feb 2024 16:17:57 +0000 (UTC)
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
Subject: [PATCH net 4/5] selftests: tls: add test for merging of same-type control messages
Date: Thu, 15 Feb 2024 17:17:32 +0100
Message-ID: <018f1633d5471684c65def5fe390de3b15c3d683.1708007371.git.sd@queasysnail.net>
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

Two consecutive control messages of the same type should never be
merged into one large received blob of data.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/tls.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 49c84602707f..2714c230a0f9 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1485,6 +1485,32 @@ TEST_F(tls, control_msg)
 	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
 }
 
+TEST_F(tls, control_msg_nomerge)
+{
+	char *rec1 = "1111";
+	char *rec2 = "2222";
+	int send_len = 5;
+	char buf[15];
+
+	if (self->notls)
+		SKIP(return, "no TLS support");
+
+	EXPECT_EQ(tls_send_cmsg(self->fd, 100, rec1, send_len, 0), send_len);
+	EXPECT_EQ(tls_send_cmsg(self->fd, 100, rec2, send_len, 0), send_len);
+
+	EXPECT_EQ(tls_recv_cmsg(_metadata, self->cfd, 100, buf, sizeof(buf), MSG_PEEK), send_len);
+	EXPECT_EQ(memcmp(buf, rec1, send_len), 0);
+
+	EXPECT_EQ(tls_recv_cmsg(_metadata, self->cfd, 100, buf, sizeof(buf), MSG_PEEK), send_len);
+	EXPECT_EQ(memcmp(buf, rec1, send_len), 0);
+
+	EXPECT_EQ(tls_recv_cmsg(_metadata, self->cfd, 100, buf, sizeof(buf), 0), send_len);
+	EXPECT_EQ(memcmp(buf, rec1, send_len), 0);
+
+	EXPECT_EQ(tls_recv_cmsg(_metadata, self->cfd, 100, buf, sizeof(buf), 0), send_len);
+	EXPECT_EQ(memcmp(buf, rec2, send_len), 0);
+}
+
 TEST_F(tls, shutdown)
 {
 	char const *test_str = "test_read";
-- 
2.43.0


