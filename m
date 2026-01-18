Return-Path: <linux-kselftest+bounces-49304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D98D3975F
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 16:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D539B3007955
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9BC3382D2;
	Sun, 18 Jan 2026 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxYhoSao"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2ACA4E
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768749328; cv=none; b=qhoGTb/IKWuKE+K5Lv/qP20cJRu/wAYBr5aSUdHVxkOwr+iQdXyjafThu9AJjN0xMIF6xqAt+qDHqC2CUUAg28vApnIbdR9CtrM/mbR/ZoICArFl9SkVR/jt6Fzrmsne97P/Jq2VlfEHip22JeaqSi95aaO1fYoIrQTmH5q67nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768749328; c=relaxed/simple;
	bh=Vh+GAtBl7HAnqugz8MWAJsOzLN95UAPEEh8yzwvGASY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtK1WLX9FdI/aPmklCURqTMs0pt6B6OFpv6r95Uk39bhlq1W5FX5II9a1sKmX3guwQnh8sZ5tVhzKampwNP7V3nen4Do6a55FVDxIR3Au/7Q7Er5E5ZAwCC8OM1n7xQOkAr3+uSFS4vrGdWZFxAmfmSxH+3GJZK1VPHndHDOXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxYhoSao; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81f3d6990d6so2010721b3a.3
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 07:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768749326; x=1769354126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VDuxeJ3zGZzz2StfINBnfIwS/QxkpqVo4B4BfFpkzgA=;
        b=MxYhoSaos57pxyBailkHIkmrgBjTXBVShu6HmS1+d3ifKrm1WLcU++Ka6oj3WetQLB
         RGWMdiu8lH0C8y/77vOqQ3G8A10GA/XbbRs6Af/PpAnPfezpmojkVuj/TPtqlMQMRsrC
         xsP2peRrudMGKsXvdC0leqSzcUNG6X7K/1F+d2GVEm2qHY+bGYd/F2NFai24PhU4jO8z
         sjx5If8GVWKBPdg2eMGYnpbis4tRuqk96maS3V/A+7qK0n5p0ykKUlW+4yC8ZooyoOqu
         tgIvQSmBTZShWVEN89yFQ6xdAo69lnTcaAMxvB1nIz8iLBwkNItBYtE/4G7N4rSorJ0p
         2KyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768749326; x=1769354126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDuxeJ3zGZzz2StfINBnfIwS/QxkpqVo4B4BfFpkzgA=;
        b=omfoJWYM+gsf9UiAvTCfV73wUn1dyMSJGMG1UjvE2hLP276cEDxTSkMRGfiSQnlETh
         EBnqSNuqcp81iJBLZyd3Jam70j1IRwUgo2KS7ZVx0yAkyyd+E5lxv/cMMP3AAo4x6nmZ
         MrAYLXLDkj4EsPffKiYj9rDV5QvaAWIu9+TRhrtly7wQ1L6aDgumeIebYCWtYoCl4pRn
         /bqB8LQD2GXsOjFtRe7iUmnkN5cv7crlTqxP4AJbW7iAQsfVkQhpv3H7hWYBZ+JApiuS
         ZEa8kWZZZSaICCNAGyZif8VE5tYhiD+bYl9jPQXcbwYMLHLxVlVJcYyeE2p0FOoJbNVF
         gjxg==
X-Forwarded-Encrypted: i=1; AJvYcCUO30V9thU9p2u+RDvBdkTp0DRgZdLwjwzfh6XRzK178ZxvTWRROu0OO86Z1qzcihedXYvQF0EUl7VBbDiulac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5DtAqaWXuh1YAym7OiYeyO85dYtnewXUBtKjaPdD8BM6YcsdO
	Hluesz86Eyk+jWTrx+ePGWkmc4LkQQczpD4Q55+z+pBXSc3qMtc+HWnA
X-Gm-Gg: AY/fxX4ximFC6dNEVmCey+YP0HLECNueGgvmBBAAw+G4bP78fwTsNl74JqMKmy4xJYV
	WDiM4hRIMPjZ1pPb1M3D9E7N+4RUbIxJGu9vkct14XOeJdUvELm5U0bj4XjnGRnPJzEbyx+Bk3p
	ImGgxAFN1oYB+RaRPT84cv5XaZ/uFGdZOwpaKanZhEofxZDO5xgv10IguOcFbFI1f+14TE2hLdq
	fTuAeVRxhv72l1eBn6H7xbHIVsP5FYdDCBbkjzegjj6mu04wKrvBEYlSM2TmZqJVHUXyWtgUW8/
	TLE6NGgpts0OW35c55xtxzb4TBy6HjQjRnaXWM6dKgqVZxsBdQGmZJ62aXtdWXczSFdjnNVWmgB
	NfJLgjn/nOmIDNkdVwWhvR8K2LnB3hg4cWyis3VwsA+SBjrLsss1QdUlcmzYpGf19rylRYvr+Ee
	8=
X-Received: by 2002:a05:6a00:22c8:b0:81c:446d:6bd0 with SMTP id d2e1a72fcca58-81f9fbf102fmr7761652b3a.23.1768749326272;
        Sun, 18 Jan 2026 07:15:26 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10bcf66sm6835603b3a.18.2026.01.18.07.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 07:15:25 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com
Subject: [PATCH net] selftests: net: amt: wait longer for connection before sending packets
Date: Sun, 18 Jan 2026 15:14:50 +0000
Message-ID: <20260118151450.776858-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a sleep 2 in send_mcast4() to wait for the connection to be
established between the gateway and the relay.

However, some tests fail because packets are sometimes sent before the
connection is fully established.

So, increase the waiting time to make the tests more reliable.

Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 tools/testing/selftests/net/amt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
index 3ef209cacb8e..fe2497d9caff 100755
--- a/tools/testing/selftests/net/amt.sh
+++ b/tools/testing/selftests/net/amt.sh
@@ -246,7 +246,7 @@ test_ipv6_forward()
 
 send_mcast4()
 {
-	sleep 2
+	sleep 5
 	ip netns exec "${SOURCE}" bash -c \
 		'printf "%s %128s" 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000' &
 }
-- 
2.43.0


