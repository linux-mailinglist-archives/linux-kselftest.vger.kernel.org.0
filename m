Return-Path: <linux-kselftest+bounces-5647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1486CD96
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 16:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799651C21C4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7A7158D70;
	Thu, 29 Feb 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rk59Y5In"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69614C58A;
	Thu, 29 Feb 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221755; cv=none; b=DsY33zl/FfZUCUjvhiz3vFSyxPRJFIV7kfZobJ5FWK4NbQ8OQjhps8uRtpJNc+1r3k3cdmCLMipnypRQqLrC0hf2sn2XpNVirosmUDXUYRO2U3zHeztdt4yDu6P6LnN6/sT4xa6CfbURgOGD04PLCw8uOUIYKQ9kyGrfeC+AJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221755; c=relaxed/simple;
	bh=8dD5To5M8RyoSt5fx2k/nign80MLUb757pypdZrbxBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmMWCsoWMpKro/QbjoL4UGleFxjOtQ9y0EHZXeYzBOs/kBQe9CKCc3xA3ej4zb0cwACSKQuH2f2qppiGRDeRSr2+CqUaIcxCRMOko8zx6VPAke9C6zG4uZ+563DrBXLfpO9UGvqArtDiV4eYPSJ2osguprGckQ5zlNiyKZFJ5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rk59Y5In; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E050AC433A6;
	Thu, 29 Feb 2024 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221755;
	bh=8dD5To5M8RyoSt5fx2k/nign80MLUb757pypdZrbxBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rk59Y5In5W8/9C0yIDoyH0JbDlN2dwGeJKqlXacbXd8ExNoWFVJQ2l8/69uAz3lwm
	 qM+HfBZzGQjdBwhr6cd/NAqrCWGLMbuQ06mtUPGHf5KeZ0htDD0AOJ/7CNWIK3nUOp
	 kHocjCb77QtjLtZ8Z2MIoSY4OKUAvxAS1kp+Lz8QdttrPDuGbeo5qNoWCfmdvT1oiC
	 HuCBvPCmoxVjKtNU9OeIp+XqzYKz6e96nGgeNYwtCv5v1vaxQV7jl0gtzb9xI43f1z
	 +PyB+ARO/9HQfHwVCV2gRDsiEWNcylfLrAJMzQWhlcAyQREcXPDmwV6vQbxzibu+do
	 d5wOSzzZAXOpg==
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
Subject: [PATCH AUTOSEL 6.7 12/26] selftests: tls: use exact comparison in recv_partial
Date: Thu, 29 Feb 2024 10:48:31 -0500
Message-ID: <20240229154851.2849367-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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
index 464853a7f9829..ad993ab3ac181 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -988,12 +988,12 @@ TEST_F(tls, recv_partial)
 
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


