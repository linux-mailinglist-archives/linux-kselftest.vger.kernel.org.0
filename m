Return-Path: <linux-kselftest+bounces-22075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1AF9CCD32
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 01:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2717C1F22377
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 00:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC91E517;
	Fri, 15 Nov 2024 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lH7oFdhu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BDD1362;
	Fri, 15 Nov 2024 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731630770; cv=none; b=RAAl8fs6+FyS9UbtGUZVPM0NCL5nYBoFPzXtRpYSchWe61R6SU0rVklKYrIdvxwtZ1lJ5+YhePSTNglR4sX8cdfIZ5E/0LIeb3gWDXHWez1VqEp9B3AUcOXoOWsLJNZU8bSpmEt1MMJTsNWjCzF+mJciyvxViVhHmi7ryx+D9ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731630770; c=relaxed/simple;
	bh=GYRM5gNSiHO7NkDBe9fQ+HFXk1V7NpIIOWlG2DkikDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yf9KZmIkDW4c6j8UjBpDEMgFX8ifsRUaVVBgdOE/wOCEoHxf7FJTAZjZztVrkCr+l2xkNAWvHibWip70vIECycm6H/Y0Glb//cWWOLFX1NrLwkOHA7n497uqzvvlFHKQmKo7Fxv2LezsfnCA9gZk1MdWhiI1KlAUTq9R3x7cVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lH7oFdhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D595C4CECD;
	Fri, 15 Nov 2024 00:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731630769;
	bh=GYRM5gNSiHO7NkDBe9fQ+HFXk1V7NpIIOWlG2DkikDA=;
	h=From:To:Cc:Subject:Date:From;
	b=lH7oFdhucuUIq6YhlJ7+wHD44bZjazoBAnvSBic4OGpY2pn+DsMBCkDlnaJEm8Uiz
	 IPMnFoba7pT8B3M1jnueQo38cviniLVebmqcQR8MxQQPRLRQVL+UXFx7iN2QhuLLvV
	 SG1dhS4Bj/I5zx4sGchJoSQAsTLvngS1L0eJhb4nijWYPe4QjPzqJlcg3Qt/M+6Dnc
	 Ot5jhcxr4mPjrqc7QXikU54SVGyVUuKiuVoFSjzLDENuUeeTLqiXCXPywmsXWzs/qd
	 CTz9s9o946nqhbc1zU2ck/YcTtQume2RUULGQ1UbSu9kEBDbdoACAJekqAEw5DdJVE
	 U9g2BSY+l9/vQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: netlink-dumps: validation checks
Date: Thu, 14 Nov 2024 16:32:48 -0800
Message-ID: <20241115003248.733862-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sanity checks are going to get silently cast to unsigned
and always pass. Cast the sizeof to signed size.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/netlink-dumps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 195febbf6a61..07423f256f96 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -185,10 +185,10 @@ TEST(test_sanity)
 	ASSERT_EQ(n, sizeof(dump_policies));
 
 	n = recv(netlink_sock, buf, sizeof(buf), MSG_DONTWAIT);
-	ASSERT_GE(n, sizeof(struct nlmsghdr));
+	ASSERT_GE(n, (ssize_t)sizeof(struct nlmsghdr));
 
 	n = recv(netlink_sock, buf, sizeof(buf), MSG_DONTWAIT);
-	ASSERT_GE(n, sizeof(struct nlmsghdr));
+	ASSERT_GE(n, (ssize_t)sizeof(struct nlmsghdr));
 
 	close(netlink_sock);
 }
-- 
2.47.0


