Return-Path: <linux-kselftest+bounces-40896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD70B47751
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 23:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6695C16C4D1
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 21:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE2728C84D;
	Sat,  6 Sep 2025 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqraBmk3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E511F0E29;
	Sat,  6 Sep 2025 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757193237; cv=none; b=R8n0mEoye52miu8UK5E8XJmbRlMyP2yMyC+SQVQdbV3XmEay/Uqy8BH1bmztSdqpyctV7sujJOrUOdPHvCy1x6sSBv3plB1DTlJqzvR46FDBQ8jduyOarLEcRz5k6qqOswnqs5XGPWCQRpHlAepQecRKWH0iSNuibMjDt5nOqM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757193237; c=relaxed/simple;
	bh=TqK/LnT6GIzlmT2eW9vnHLMtTddVu0+FeYIwMO/XBJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CWlH66qU2vPHkNsO8w/Aqzi8o9hmf7NZ5fUIwYJ5H7hsjYXLbbxA4haGHuULkjNHZDx2V3Yqz8dwr4VzKjF1TbFnmQP66Ku/mS4s0PJCa2X73jsFlrBmbAnWRYIzO19ThNt50C97GbwK6vLd5HwE7aT08pgdhAdXS+rQ5yXVPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqraBmk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D464C4CEE7;
	Sat,  6 Sep 2025 21:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757193236;
	bh=TqK/LnT6GIzlmT2eW9vnHLMtTddVu0+FeYIwMO/XBJM=;
	h=From:To:Cc:Subject:Date:From;
	b=IqraBmk3+zg9ijEs71rA0kcWWWqnLTuOCB/xt65+otGshO1N8NG2ZMQp+5Cp/142J
	 aWqtbPLf1DrAj8aRXLMHLRp8mtjO6EcsMGtZE66b7xek2KaMo+2SvTzE+cLyDEYAzy
	 g0+0a6PdzP1NWPHxDqwKhO0nxNayC24UeZ2mr+rN6lW+sKSk9d/h76/nzDI9HslaQW
	 JT1d9j3pmJC5t7bQFYwmQUzT2KEanHPZ8M+MkUnqAzI1P+/R0d83WNq0Db+Nf12Dk2
	 18bkTIH6JTUzV9sKt3kVJ78VlkHqtlOTJbKpWA6qY3F8tR32FY3dsNDr5VsSU0keJx
	 ZN9JL1z8hz+pA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] selftests: net: make the dump test less sensitive to mem accounting
Date: Sat,  6 Sep 2025 14:13:50 -0700
Message-ID: <20250906211351.3192412-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent changes to make netlink socket memory accounting must
have broken the implicit assumption of the netlink-dump test
that we can fit exactly 64 dumps into the socket. Handle the
failure mode properly, and increase the dump count to 80
to make sure we still run into the error condition if
the default buffer size increases in the future.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/netlink-dumps.c | 43 ++++++++++++++++-----
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 07423f256f96..7618ebe528a4 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -31,9 +31,18 @@ struct ext_ack {
 	const char *str;
 };
 
-/* 0: no done, 1: done found, 2: extack found, -1: error */
-static int nl_get_extack(char *buf, size_t n, struct ext_ack *ea)
+enum get_ea_ret {
+	ERROR = -1,
+	NO_CTRL = 0,
+	FOUND_DONE,
+	FOUND_ERR,
+	FOUND_EXTACK,
+};
+
+static enum get_ea_ret
+nl_get_extack(char *buf, size_t n, struct ext_ack *ea)
 {
+	enum get_ea_ret ret = NO_CTRL;
 	const struct nlmsghdr *nlh;
 	const struct nlattr *attr;
 	ssize_t rem;
@@ -41,15 +50,19 @@ static int nl_get_extack(char *buf, size_t n, struct ext_ack *ea)
 	for (rem = n; rem > 0; NLMSG_NEXT(nlh, rem)) {
 		nlh = (struct nlmsghdr *)&buf[n - rem];
 		if (!NLMSG_OK(nlh, rem))
-			return -1;
+			return ERROR;
 
-		if (nlh->nlmsg_type != NLMSG_DONE)
+		if (nlh->nlmsg_type == NLMSG_ERROR)
+			ret = FOUND_ERR;
+		else if (nlh->nlmsg_type == NLMSG_DONE)
+			ret = FOUND_DONE;
+		else
 			continue;
 
 		ea->err = -*(int *)NLMSG_DATA(nlh);
 
 		if (!(nlh->nlmsg_flags & NLM_F_ACK_TLVS))
-			return 1;
+			return ret;
 
 		ynl_attr_for_each(attr, nlh, sizeof(int)) {
 			switch (ynl_attr_type(attr)) {
@@ -68,10 +81,10 @@ static int nl_get_extack(char *buf, size_t n, struct ext_ack *ea)
 			}
 		}
 
-		return 2;
+		return FOUND_EXTACK;
 	}
 
-	return 0;
+	return ret;
 }
 
 static const struct {
@@ -99,9 +112,9 @@ static const struct {
 TEST(dump_extack)
 {
 	int netlink_sock;
+	int i, cnt, ret;
 	char buf[8192];
 	int one = 1;
-	int i, cnt;
 	ssize_t n;
 
 	netlink_sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
@@ -118,7 +131,7 @@ TEST(dump_extack)
 	ASSERT_EQ(n, 0);
 
 	/* Dump so many times we fill up the buffer */
-	cnt = 64;
+	cnt = 80;
 	for (i = 0; i < cnt; i++) {
 		n = send(netlink_sock, &dump_neigh_bad,
 			 sizeof(dump_neigh_bad), 0);
@@ -140,10 +153,20 @@ TEST(dump_extack)
 		}
 		ASSERT_GE(n, (ssize_t)sizeof(struct nlmsghdr));
 
-		EXPECT_EQ(nl_get_extack(buf, n, &ea), 2);
+		ret = nl_get_extack(buf, n, &ea);
+		/* Once we fill the buffer we'll see one ENOBUFS followed
+		 * by a number of EBUSYs. Then the last recv() will finally
+		 * trigger and complete the dump.
+		 */
+		if (ret == FOUND_ERR && (ea.err == ENOBUFS || ea.err == EBUSY))
+			continue;
+		EXPECT_EQ(ret, FOUND_EXTACK);
+		EXPECT_EQ(ea.err, EINVAL);
 		EXPECT_EQ(ea.attr_offs,
 			  sizeof(struct nlmsghdr) + sizeof(struct ndmsg));
 	}
+	/* Make sure last message was a full DONE+extack */
+	EXPECT_EQ(ret, FOUND_EXTACK);
 }
 
 static const struct {
-- 
2.51.0


