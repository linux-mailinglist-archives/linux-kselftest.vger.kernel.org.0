Return-Path: <linux-kselftest+bounces-5653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD59C86CE5C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 17:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28041C21CEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC1915C78B;
	Thu, 29 Feb 2024 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UI0pXjMu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A27154C04;
	Thu, 29 Feb 2024 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221889; cv=none; b=Mr7QLvSuL/k1nqtfsbyLEdz2AVJm3jbXkNzVasWpa2ZjYGZWXPPXq2dB+0/sa1P2HIVvXj9RN9pvABaWDcHIlKd8IHa8V0qgjXPWyjVfHlpj3XTXZ4qk0ELr6CG30QjkXcezDmT+xpq9ldYnvcoBY4/QefkmI/9nasIzgLxEIUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221889; c=relaxed/simple;
	bh=GFFbQlzh6HC4SDDh95NsXiORtcwm6elGZF0AA+G9MdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9/tddTZ82eppyrDeeMhoK4idbxCqwe2YDtrK2LA1FyBjWJ979D7L86pComo3lKFIzXz9/aoW0qtB9g9PYGjb6p3le+4ZJH/Gok0d1W3DP4WXIgon89wTEGAwWqUgTplIv1z9c7uBxxyKjdp1TBRBbB9481lUGGHhvSJo45JxgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UI0pXjMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1432C43394;
	Thu, 29 Feb 2024 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221889;
	bh=GFFbQlzh6HC4SDDh95NsXiORtcwm6elGZF0AA+G9MdQ=;
	h=From:To:Cc:Subject:Date:From;
	b=UI0pXjMuYJrggUHoJQ6a81sleIwYavVgZwF/5W1mIYQUrQErNNl29edWcfoJweFam
	 PeHnzQis+cTmplxB3xc4qWYdrviu5GeESWOfVB+XQI5DrGRtiVmDKR5VkWtdpFSjYI
	 dcBuOtIDNbHDO5fQ45T94lzKHWTk+t0Q+flCQS9jA458UjK40MDzrCYLdJek8QCd7n
	 6tEhSRAz+zym4FVX7zbiQet3cVzcVQEdJqsmGqlDoqCR2xxaskOA/WtRt4crt7wuHE
	 IqacyrFhyVj+GxMcmh9JPZjKhneVvLe74OnsO3CMb62eI+AH7D/qeg1pRV39kc9Dzl
	 IEvgNPmZ0Jt+w==
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
Subject: [PATCH AUTOSEL 5.4 1/5] selftests: tls: use exact comparison in recv_partial
Date: Thu, 29 Feb 2024 10:51:23 -0500
Message-ID: <20240229155127.2851327-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.269
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
index 837206dbe5d6e..81bb3cc6704f8 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -580,12 +580,12 @@ TEST_F(tls, recv_partial)
 
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


