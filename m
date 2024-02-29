Return-Path: <linux-kselftest+bounces-5650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ABB86CE1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 17:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A80282E6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 16:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C157914EA4B;
	Thu, 29 Feb 2024 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8Bf+Tiw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9660214EA46;
	Thu, 29 Feb 2024 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221841; cv=none; b=BfiHtHOQcf3YEe24BiMg0aemGTJ93GswPTwYQkwdTlJKNn7UcXDZ0mG82/Rt1r1CSA9ePpE06HtcFMfDaFGxQnKqcSu+sI7joqmMloQrS39IuhDxdSBtXsFXS8lIdSvgOtByPI/4Au7FQwAUm8pJZhC7vaQqDBFHIE/VtD6ec4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221841; c=relaxed/simple;
	bh=k7GFb6/TvOGC/i81ZOJPpaXASgmoQdLymtrJI639qzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ki4qlbunZLNrg5YLcmEjLtnFsf0CHfE+VqY4YAoUHSNUm4p0eqbwJHhjlSvjDeoEi/UjmYoINt0rdRbYfjBlWX3Y1pwqNVmab0rCkz9SCFC2BdKKaejFhXwgHOBgMn0t16GnkYcjvLybx4XZqzV42L9ouBwoZqQ6oBJdlON3uDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8Bf+Tiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11830C433B1;
	Thu, 29 Feb 2024 15:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221841;
	bh=k7GFb6/TvOGC/i81ZOJPpaXASgmoQdLymtrJI639qzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X8Bf+Tiw4unjU3Y7b4ixlt1ExbBMelhmW6/VpVox71oEcF4canL7Heng+7C9gKsN8
	 LRd9WtVXAuHP0YS/LdUukgn1BQHnzNBk7uCCG3v2u6T6+yNgYk/G9ty4kmMVkTd7sa
	 A815HmGYXuLrXgAyoOLeGiXugPorC5ucPxGTcO9Zt/j/IB38N/ltyAbiWwO4j+lsrv
	 xxYhiwBHBMtvbTUxVr0sPtdu9N4zyKDQ5RE86AqUjoTjqunP2eHtmLPWWJA452sQ2y
	 tTmNIY+2vBdcxJ+0MDIUs45d5+V5U/0reCMUXfTW3hHOKo4tfBz4enZSGjjLiEULq3
	 aWdKMbdqUoP/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/12] selftests: tls: use exact comparison in recv_partial
Date: Thu, 29 Feb 2024 10:50:22 -0500
Message-ID: <20240229155032.2850566-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155032.2850566-1-sashal@kernel.org>
References: <20240229155032.2850566-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.79
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 49d821064c44cb5ffdf272905236012ea9ce50e3 ]

This exact case was fail for async crypto and we weren't
catching it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/tls.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 5b80fb155d549..d89ee6e1926c7 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -926,12 +926,12 @@ TEST_F(tls, recv_partial)
 
 	memset(recv_mem, 0, sizeof(recv_mem));
 	EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
-	EXPECT_NE(recv(self->cfd, recv_mem, strlen(test_str_first),
-		       MSG_WAITALL), -1);
+	EXPECT_EQ(recv(self->cfd, recv_mem, strlen(test_str_first),
+		       MSG_WAITALL), strlen(test_str_first));
 	EXPECT_EQ(memcmp(test_str_first, recv_mem, strlen(test_str_first)), 0);
 	memset(recv_mem, 0, sizeof(recv_mem));
-	EXPECT_NE(recv(self->cfd, recv_mem, strlen(test_str_second),
-		       MSG_WAITALL), -1);
+	EXPECT_EQ(recv(self->cfd, recv_mem, strlen(test_str_second),
+		       MSG_WAITALL), strlen(test_str_second));
 	EXPECT_EQ(memcmp(test_str_second, recv_mem, strlen(test_str_second)),
 		  0);
 }
-- 
2.43.0


