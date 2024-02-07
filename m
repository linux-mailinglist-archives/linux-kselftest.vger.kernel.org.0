Return-Path: <linux-kselftest+bounces-4204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C1E84C1CE
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 02:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E010288081
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 01:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB45EED9;
	Wed,  7 Feb 2024 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrXY3kvO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F65EAE5;
	Wed,  7 Feb 2024 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268748; cv=none; b=bud5KMOocDzSusdXEKaHsiEffm3bpyZX7KM8lannzu0fsQAXdwUckWSyeaBClwT7wdKRH6WHZraQCT3HGDcAH6CSCt83srOYeAXX9dCY3XFuNXCKFQhy5p55qrC/2xaTtUsKjXRtTDYz/pmjmyZ7kW5XA3kYFiYsiuLlsQ0QYg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268748; c=relaxed/simple;
	bh=4zHvcNLO8nhN2HhFBDnOjS+sNUCpLa5Ivz+U4ynv3gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sF9FjjeHs7pTdYGoNwEte4fbd9xbW6NM0dSe26AOWWw4ZZ2cVz54wCEdroGQpk/R1kbPWIK3FYX9EhCuQaUM1hjrplXOZCWly8JdZYeBTGYTPqJyuxEMKOGQptBnH7TSeP6Etv1yRKIzIma2n9NSrSDy+ax2rp1UhWrOQVXYKCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrXY3kvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92025C433C7;
	Wed,  7 Feb 2024 01:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707268747;
	bh=4zHvcNLO8nhN2HhFBDnOjS+sNUCpLa5Ivz+U4ynv3gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VrXY3kvOu5K/fiQ7s8upDC1Mt0fB+2wmxFNFLU8VJ+pWcItW8ta46wCavuCEETC81
	 RHza5cCOx9NK5whftsTr0NvcxDw+xjFeIOlif/un9cFTKlq/3FAtQkNRSY/fUxJoq4
	 TD3Rl9OSRdxzYd+iFgekKMwyFdA9oYOgJi2RdGPBE5ad7QJ+GnmaQRSVy/4dbquj0B
	 Ux40A2lFs7moogMRm0ZWEPIy/KY1ScelQaWWGHie7vuO+yNxtt2Jj+ZCejjqwXaFmk
	 FFUTuHU+4YXrQ783P/rNWSmLpEt1FAR/ErCxLGlhjQsGGjelP+Ed6VbfEkh+vgTs+l
	 UECEQ6VJk104A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sd@queasysnail.net,
	vadim.fedorenko@linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 6/7] selftests: tls: use exact comparison in recv_partial
Date: Tue,  6 Feb 2024 17:18:23 -0800
Message-ID: <20240207011824.2609030-7-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207011824.2609030-1-kuba@kernel.org>
References: <20240207011824.2609030-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This exact case was fail for async crypto and we weren't
catching it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/tls.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 7799e042a971..bc36c91c4480 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1002,12 +1002,12 @@ TEST_F(tls, recv_partial)
 
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


