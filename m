Return-Path: <linux-kselftest+bounces-5652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EF186CE48
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 17:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557861F22209
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 16:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D199159DEA;
	Thu, 29 Feb 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIDVxzl4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5097F159DE4;
	Thu, 29 Feb 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221877; cv=none; b=K1D2KmF0fuWi81vKjUz4ppDCVZ+sJfPmA8Rlg9pcvvAOrOk40hJpN326OEMvKQybJ14DBzT5ZXJ7/o5ZwUhmRbVsE7TzSz0lBiiCMm7STazRQ//BZ/2PxtA+Akr7SQ2NCum9RUevp9ovIJ3HKwH8uMckOJ8FeHaql/xUNAuVxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221877; c=relaxed/simple;
	bh=Yo+IjX1HMF7yDU/yvovsGvcfnMLDjmAxJteTj1nN9MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+2cNYkYCo7K4d6/h3zsvr0pt6HRlmN2wQkr/SuzUfI4Kh6ir6K6RbwkuQmEOBBYsNzq2mjimiQwLMNoaOQZwZnAo0eaFoRwVGDTt9W+uv/sV7gFi2qRz5fPsf3mL3xwWki4kzqLS8kWeZcSH4dgN6ngV4NNCH9jD/n2BAp+bvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIDVxzl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7302C43390;
	Thu, 29 Feb 2024 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221877;
	bh=Yo+IjX1HMF7yDU/yvovsGvcfnMLDjmAxJteTj1nN9MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIDVxzl4ZwaUxKL1dxSj47TuR7uWQnZ7KELoiFMSZ2FVtVY4j8HwSrmINdlIPN9LH
	 l6qBf3HfW4io4xpYXuJZL389u9k2+99Kx1SOjBDgO8NsJRADW634mzEohs7lXYP0vZ
	 RVngztUzCq7SiHLQNM5DnfwepC4D5CwpiMlWW2U2CRCpACyVU3gyb2oLxAxzyVsHul
	 ZXrxBzdM8aeWIrlEf1oNkhMf2ki1EvjWC249koiIgvkcQQ4EEy0YC0z7BHwK63nMDW
	 IDMhm0plKuLwPAjKHhNNvgjgD3MAUy5XD5xqIoRvlhVcy7Xu9rAbCXfmzMSRbimmoL
	 BKinU6AW9HeVA==
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
Subject: [PATCH AUTOSEL 5.10 2/7] selftests: tls: use exact comparison in recv_partial
Date: Thu, 29 Feb 2024 10:51:06 -0500
Message-ID: <20240229155112.2851155-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155112.2851155-1-sashal@kernel.org>
References: <20240229155112.2851155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.210
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
index 44a25a9f1f722..956ee3c01dd1a 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -653,12 +653,12 @@ TEST_F(tls, recv_partial)
 
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


