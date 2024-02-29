Return-Path: <linux-kselftest+bounces-5649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E27F86CDEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 16:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7F8287B32
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF78213F430;
	Thu, 29 Feb 2024 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuMuH/bR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9660D13F427;
	Thu, 29 Feb 2024 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221808; cv=none; b=F+VjII1o4G+qmqy4j4QJCOzSUawxkQ2C6ROjCiY23fWlfxKCmg2pdyW7G6/3BZYmES2Ajn49kQ3mmvwvmHMdyCUNZx/GeSvxOJopcWgjooixYc0KzwNH8fjTtUlwxeCzEap6/gcmLT9B1JKpWd6bWtklatAjI3ysDQQ6EhyDp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221808; c=relaxed/simple;
	bh=8dD5To5M8RyoSt5fx2k/nign80MLUb757pypdZrbxBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saTC+EqdZsoNqvz2feFybjhb1CJSGuIVBUxCXOeW50+dd55OI8NNIX7jTWHuAm0dgd7TJKG0ya5D2e7cnG6NWYw94cXBa/loxrdvUFVwre/nsg6ZtJXF7Lv4d1lBfVbx97EwS9odB9SnKLoWgFtJqMQfgksIy2yzcG6yUSGC6uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuMuH/bR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4DEC43390;
	Thu, 29 Feb 2024 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221808;
	bh=8dD5To5M8RyoSt5fx2k/nign80MLUb757pypdZrbxBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QuMuH/bRVAgjWF68YwABLs/0hy+UdID4u7f48DVdYieRzyeB24z6klEGlRXevaCyl
	 6CeFf6cLPNraEFmBE7+ckQU2MEYiERebtOMCIXs3HtyBbWD6DAQxuQvPLkFY1+lRZc
	 j17v5j3dz5o7mpUdq+5m3F2rlaA8YIWXCUL+QFgo6hGuBJBr3ynVpe/cYQVhCMqVLM
	 LgvUqdifXbL0sPP8lvjCr2M8rIbemX79luYfTaZ7SwbDvW6voy+FBHLQls/un6y4kp
	 i1A1+0sukxiSz2lwUA6sHMoNIiRFcqzGOuO4BQx6dWjEteIJrpCxFXir7wNRm6XOrd
	 eroa5X6WJgM7w==
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
Subject: [PATCH AUTOSEL 6.6 11/21] selftests: tls: use exact comparison in recv_partial
Date: Thu, 29 Feb 2024 10:49:31 -0500
Message-ID: <20240229154946.2850012-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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


