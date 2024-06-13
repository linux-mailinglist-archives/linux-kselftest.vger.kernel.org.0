Return-Path: <linux-kselftest+bounces-11833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 441DE90653E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 09:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445DC1C22BCA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5256113C681;
	Thu, 13 Jun 2024 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4cBLzcg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A495B13C660;
	Thu, 13 Jun 2024 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264074; cv=none; b=pkEWiDIsI3Ud0/2YwFcQitl/EgNoTf0HWGKa4c8YPkGPQFE/9ZqA+1iGmaDvrbu7yPnXFU4ZSY/nEG0Ftr0UEKOHXGvyLyjkluXeXWnmU8FA7hbOTGRwxt02oRanAo5IMThjaiVDyTHIq7GxiysnMp+PsCszBKCQnOd3PW3PwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264074; c=relaxed/simple;
	bh=BgGPUA4CJHBAi6sstPxqPZGkojFNDXKzqwrZiGnPZHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ao2Du3jDFCmeUd6tx0QMLcAjZezzimeCa+GX7MxVeT5ockW0Ad2Df8aPeYzUybeLDLkLnn/YA2vhW2MEfgPlfrIfBtrch/kQzxtLrOz1knFmGRvlmJdl1U53P8k3aHX1chQ9DmqFskvYHGf3uP26vw6bMQTzPoalbd3Ut8rpDUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4cBLzcg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso8516715e9.2;
        Thu, 13 Jun 2024 00:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718264071; x=1718868871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MSHRYQpgTDWbDhn+hhtstnXRqbhO24DfQNz+E/HyPBU=;
        b=Z4cBLzcgRHjbW21WaW2xRi64ZiXmV/Gwhzs/xo/g1Q8frvnEcfQ6+kh6Um0Qh0YJ24
         p8e6whW27/S7k2zKjHI8hJtMQSI/BQkRSKpB1XRIpc78BpSc/EdtHT8onVk3QlpZPphV
         /panKcM6Lg1xkm2gyADwa/wCMakSdK7ANOoMsUrzguTwcuZLm4gFfDUGdy6QAoDLVOL5
         SIbGvWLs4j1M7THeP30HBcrAR1rfWKLbdQkZEdeQyGV3a40RmULs/Hzt4HgYGTKM4tVh
         RJ/ez12Am7sUeZgqGAg66SOgMi64E7Ikd+niF9RlYpHHA+ExqWalDnjJMCynzzO0KNNR
         kPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718264071; x=1718868871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSHRYQpgTDWbDhn+hhtstnXRqbhO24DfQNz+E/HyPBU=;
        b=RmewW2eMOG9wBzY/FC4f1RnMGfaJ4nlJCw5MIEkx21rkp76zmrSDcGv6OJ/O7ncxas
         zaj08UED+T/eA/IJFax9ZkeH/sLWWljivsOceqacraepP3PQlHa95DnEDLmM2soVEA2Q
         n7zWPW9qCAZUPW1M1l3/N/1RRP4LDMbh0KFWZOQTXtniwsJtkD1SUL8rLpRKgkVRjcv+
         o3qDlohXzcpl2OQ4/OlnBCtq54aHHyI7DETXeRTiq+TsvP42PRRQByE+c1bVmbCtTcvp
         xuOV7shHfp0vaNv0SFlO1yqRSMzhDLT6oK+ogSpeRLnLCMgwoUSnwfGzAISFfW+X317O
         12yg==
X-Forwarded-Encrypted: i=1; AJvYcCUteEbYt+n0Zgmb6EZ0gC9VoJr+yFQIR2kRv/I8GWQL+LImhAdGPxk4GvPUzEkDAxYQcfxlMaLcnn7+S8pFRCaDF8xdKxtVjHfSdkIWy6LNXC0DDZUlUj8c3LRStZLjnu0/IsUHUzAT663DD8PU
X-Gm-Message-State: AOJu0YxlWkXxVcqdfV3XajNLdvkxgymXuBIHXFGw7ZRs3T/rRKCRE7BW
	Y8EI5WX/Z2Ckj/f5tga0YmhI2OzDfe6/6LUjz6KHaBWvgyZFpxA0ywmUDg==
X-Google-Smtp-Source: AGHT+IE5HZjrLoCnNxLVajnotnkeImtDf2cI0u88h47cCjcg16Llc86SnlptsYF62rR065Ce2k3SMw==
X-Received: by 2002:a05:600c:314d:b0:421:7c1e:5d5d with SMTP id 5b1f17b1804b1-422867bf846mr47056455e9.35.1718264070779;
        Thu, 13 Jun 2024 00:34:30 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef70csm51236815e9.3.2024.06.13.00.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:34:30 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] kselftest/arm64: Fix a couple of spelling mistakes
Date: Thu, 13 Jun 2024 08:34:29 +0100
Message-Id: <20240613073429.1797451-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are two spelling mistakes in some error messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/arm64/fp/kernel-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/kernel-test.c b/tools/testing/selftests/arm64/fp/kernel-test.c
index 50db26a3ed79..e8da3b4cbd23 100644
--- a/tools/testing/selftests/arm64/fp/kernel-test.c
+++ b/tools/testing/selftests/arm64/fp/kernel-test.c
@@ -233,7 +233,7 @@ static bool compute_digest(void *buf)
 reread:
 	ret = recv(sock, buf, digest_len, 0);
 	if (ret == 0) {
-		printf("No disgest returned\n");
+		printf("No digest returned\n");
 		return false;
 	}
 	if (ret != digest_len) {
@@ -308,7 +308,7 @@ int main(void)
 
 	while (true) {
 		if (!compute_digest(digest)) {
-			printf("Failed to coempute digest, iter=%d\n", iter);
+			printf("Failed to compute digest, iter=%d\n", iter);
 			return EXIT_FAILURE;
 		}
 
-- 
2.39.2


