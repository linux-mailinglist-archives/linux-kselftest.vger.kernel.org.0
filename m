Return-Path: <linux-kselftest+bounces-5651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BD886CE35
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 17:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C891F221B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 16:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C625B151739;
	Thu, 29 Feb 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvzbmDaX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FDA14BF59;
	Thu, 29 Feb 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221860; cv=none; b=pcVp/z/0X199HOF/pPtne4cGkxyZPsY2MP42lMsHNRxgcZt4VorDKRRU9FfPf/h96xN5Uc0oOw/nS27LnNisSri7zfgXywH2nMRlHHRftDKPomqNqR4K5p3T1m2QNT8IxSm59sHCCjGXZG2k7LsbfR/xDe3IpV5uqWKiSY6ZobA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221860; c=relaxed/simple;
	bh=quRhELaf4gAf9OEbPPzuRkgP1qmvcJtfgwZ/JQhXv8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHSlfRk6jQQe/cQ0K5vRNDWrsFzkv4L/JzQqPSTjXKNN2HoGSEMWUf3JN7kMMpipYqk9VhNpe5hF73FglzCGITvy4qQgqcVtBWAaAK4SBiD6eJNRELloIaJe/djwiXFWHa3xI/m3gFT97eWHWsBSxu+TmsXJXRxueVL6/hxIkds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvzbmDaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE18C43390;
	Thu, 29 Feb 2024 15:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221860;
	bh=quRhELaf4gAf9OEbPPzuRkgP1qmvcJtfgwZ/JQhXv8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvzbmDaX0pkZpcAxlnkCRDn7RnT1NLwvoGgCaSWNYPSKblO1ESg1s9tNC9euRiB/3
	 yF2xOhk80b4qdIUN/spnnGYvSpwmDjZDVx2yIn0cesXh+eCunZ4ySHhIAJRqYaNHdN
	 vDjtLYJ1wIBRi2Zd1IJgPfdNy+U+CnNyt5370bSZ7bIRwc4BswIFyGLFDwrHzuD2MM
	 yCsDPgP1BA5XyRZ/+wBAsGytd7AlVr4CvBVKh5UO0f7/Xl2X0h5/uGdFKXnVvINaJo
	 opV10pIVXaFVhv8odu+GqaKuFQ6Wp3ynbzysnqgRsURlNjyUq+0nSpR017rg9wT6PG
	 3tD4vYVpb+ggA==
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
Subject: [PATCH AUTOSEL 5.15 2/7] selftests: tls: use exact comparison in recv_partial
Date: Thu, 29 Feb 2024 10:50:51 -0500
Message-ID: <20240229155057.2850873-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155057.2850873-1-sashal@kernel.org>
References: <20240229155057.2850873-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.149
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
index 3bdb093731358..637f1b8ec13b4 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -716,12 +716,12 @@ TEST_F(tls, recv_partial)
 
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


