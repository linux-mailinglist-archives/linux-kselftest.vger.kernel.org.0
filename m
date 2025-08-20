Return-Path: <linux-kselftest+bounces-39359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAA2B2D65C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 10:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB14188D81C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 08:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE102D839C;
	Wed, 20 Aug 2025 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHp/af4T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B401C2C11CF;
	Wed, 20 Aug 2025 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678401; cv=none; b=rFEy2tWolEYsq60EnjhM2xpw+4JQ6gtohUzqkiW8Ov+ax2gKu2E2cGRm7yrtEwtH3Il5rCzCNriGMMkkhLxhAzKdgwTN85+FKc2YVZgbucdFDCpU5dnaomWcCGp4BldPjnpW7fjaKvVnWE3TKIMIRUkOAvBGIkQbEY4w1/805nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678401; c=relaxed/simple;
	bh=je5AHg/youKOa+xhCXnHlhnCi4E0rhPm8H3bXUt+7zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FHtgl89P0XZpLyo9ytK2iSFJ7eb20GVUkGDT214yEw2uAkscsICSBhcAkMsFkahixL5y1c6P27bB2iy4lBi2VWgAET4DEuJqStsKxw+XN/1gungGLD49GO3d5/R0wzFAgDEv3xZwylGkZHU3FxYGFGJPuh+OM0PcRpwfYzPb0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHp/af4T; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so536818b3a.0;
        Wed, 20 Aug 2025 01:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755678398; x=1756283198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=moqMZqhapfuLQfkSPWKxhFFyVYs5GkMX6FHp/4+cuAI=;
        b=lHp/af4TDJDx7hgsCrsG/qCU5D9TFODj31mJkVIGJ3GkHmJ6F1nzhMvQulblXBy0f6
         4msr6qKEW2a3FmPRpy6aWH/7bVOq/Ehv5w0NER5lfdjuw97JKJsgck1ytBm0nHgYrQlK
         mFMMRYrBXYwLwuzp1hINgcgTRBlq3Hson+m2DDx1hloYPBrBaVG8CJi9d5LhJ72hZ9vY
         /4MmCm1oykbsXE7u4lcL2fiPO2WUMOQg4i3UdUsa82dkKDinzG2jJWknVK+apOxIyb8e
         0rPpyUSmS6KX1tJ4HkWsEAhF4ld/pHUJbDyeYUQhcZtnvLR3Cw9BAfyFZ50dAN2t5cPd
         TgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678398; x=1756283198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moqMZqhapfuLQfkSPWKxhFFyVYs5GkMX6FHp/4+cuAI=;
        b=cBvWtaseOmSUni1M+qJ0WyjcrbbiK7o6Nct1CXEho0GJ/DgjqgVinS2JY44K26VbLA
         ZzECoNLO3Rv+OhucxKSknm9jx9+5dYbEzfk+s58kN7hAvEapTZiaqbOodpqcY58s8vxH
         N4cFnso0KHbopIBGmc7qqI53eMNfR2LLYXdVsPmDuIHNR1cDf8GPd2EXAA0SD0jkMxlv
         3hBNFP5XS/5mI41jyX+SbqjnVVmSKIjw3kwLNYzOIj0Dvg4gVguhu9c3z9DxYTHTCqFl
         pcIkptZfE5qnB3pv5ADd8dca8pe7iYlIItxkNO3g1y0cN6BulB4TOD1oCPJErRjXYYlo
         Y3kg==
X-Forwarded-Encrypted: i=1; AJvYcCVqaNjESvDpDK3S0VgMml8/hTF+iAs+lmgKnW2wZCHYY9DoyGT3AZ4twISdhDi3XjFtK8VMWl4LXIwUNWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrfI1mqg0MAcAtwi8iY8332sNvpxksxwiACRqP5xyWHaXYF4A/
	6bZCxHGY7U989ey3Zst9gOkTEIgtc1Sal2AeCofDyCRQiyLmFag9PYr3
X-Gm-Gg: ASbGncvwwsJTIm2OO2tuNSpTtkW0o+pJa342+sGAd1mYRW7U81RpsEKS408BV9ZxOLQ
	2X7HY9Gbjic0xEzKAieFSHa2imhFxsw7J0d3sXC1Z3V/29wny3+nnzprks/Ow6d3gxTPOfraORc
	rTqDdOeMvRygHa6xaZWPd/vz9aAvqnQrQGe7SguSNhs4xm41j2oC8P10WGsZrxs5lW06OQ152EB
	ilYlpVfQbO6i+Mpf7KmqSyLM71h8UHUBDAf+YnRqdhc0YxP7Nq7nvyMwRuSp5X1yYxoyjbEgTIY
	vo8l9lU7NV6ib9+8idHcbajTwQY2AQHtGt5MmM8anErIDmIeLB/p225Ql+pLe79w9EksZGzpWml
	VAns4/KnnKlYPf7fMJ2iwEOi38/6vlFXIKHABxdJ8v2mp
X-Google-Smtp-Source: AGHT+IE18FvJ7No6QPK7ovxobzfmMas2xC//+TYO0cz2t0SD0MgX11pvHmxuexiStSi2EWnCQjQg0Q==
X-Received: by 2002:a05:6a20:3ca2:b0:240:7ed:4018 with SMTP id adf61e73a8af0-2431b8f31femr3366912637.15.1755678397819;
        Wed, 20 Aug 2025 01:26:37 -0700 (PDT)
Received: from OSC.. ([106.222.231.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e250eb93sm1567217a91.4.2025.08.20.01.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:26:37 -0700 (PDT)
From: Pavan Bobba <opensource206@gmail.com>
To: shuah@kernel.org,
	cvam0000@gmail.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH] grammer correction
Date: Wed, 20 Aug 2025 13:56:32 +0530
Message-ID: <20250820082632.10259-1-opensource206@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

corrected a minor grammer mistake

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 tools/testing/selftests/acct/acct_syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
index 87c044fb9293..ee2894e4f7bc 100644
--- a/tools/testing/selftests/acct/acct_syscall.c
+++ b/tools/testing/selftests/acct/acct_syscall.c
@@ -22,7 +22,7 @@ int main(void)
 	ksft_print_header();
 	ksft_set_plan(1);
 
-	// Check if test is run a root
+	// Check if test is run as root
 	if (geteuid()) {
 		ksft_exit_skip("This test needs root to run!\n");
 		return 1;
-- 
2.43.0


