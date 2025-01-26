Return-Path: <linux-kselftest+bounces-25199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951CA1C863
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 15:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D8E1886092
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0F913F434;
	Sun, 26 Jan 2025 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgoQqaam"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5D2AF0E;
	Sun, 26 Jan 2025 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737901387; cv=none; b=BUqaJ94MOxU4+uj+HokQ9wj6KS15PLpP0y2kf1qMdcvFGZGX6wH6IuleoNmfs1gjJDj0ldz3hdrg7+Apn0RvAaux3P03iWvJYeHSOkh5zbG2QgR6Fuj6rev+2VVjyAVpOMrjQNlMkchwcwbOox6uUXAI2Kaj7nl+X8Amf5xFbY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737901387; c=relaxed/simple;
	bh=mCzL/dBwEy9WDpyveWJgH0ElaDOtGcBU5X27UvQgGE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+QQxldLkQzSoKS+aQEglCJrpAyFYJahvCEMaBVuCC2W2sHAgTpwE6AQgZkvSaZAv7etL7Aa7YRTjmy3jlzK4lij4ebNhc51D6bvded16NtJsijr1mCAjm5nceQirydtxj8baMpBbsJ3lRqqmyqiTJ7fH1fCGlTQEUFIgmERtfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgoQqaam; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38a88ba968aso3580083f8f.3;
        Sun, 26 Jan 2025 06:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737901384; x=1738506184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JsO0Sv7NIyDcMlDbuS3LUoMnSAC3pEGbqVvq6TmE3M=;
        b=YgoQqaamcbFFNB3HeW64Jy+fRFjcK314Yx8GZ709y+IYqXSL6fXbCGx00S7iMhX2PY
         HxaB7aN9foC3t5ZcJ5JDB05i9KWkKBj1Z58vwUzX1GdDRi4V93BTHS8q/47K3jtYtu3H
         PPjIvXqxA6Rl72CuUw9TiuwbTqSyAfmkdNqWmi3rOx9v4Ey46elZU7NKI5JfAFJEJ+UG
         1qvg4tJvUFWEhQApLVWqyV3nT9KJYkZHRI3Co5hgHT+ODccqEa/MgnFL1a4HOW3sMDJn
         AE/5pOoqKb8i3RYbS/MHzm5ITCFgCsn5GIPCnt9z17D+nmMb4ntguUtbg+HD0rYUMmkZ
         di/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737901384; x=1738506184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JsO0Sv7NIyDcMlDbuS3LUoMnSAC3pEGbqVvq6TmE3M=;
        b=i5FDRJqusrglqtan2kRQIGr0W74bOObH3+DlGxQ9U9DfAhFtKWMyQ+IzhwIbjp5Qbo
         feMPAH8SxBLlTFt9G1OANYfwM0S4vatYyIwJCrD2ZDL+FtweOY37EaIsFCClG+cuyFET
         pAkZW8Tp/xTsyCL0bp2RKoZLkmVJDa1DDMvM4OXUjWomWAE4NgJERnz1q/jh0orgK/1X
         AUQjHMpZup51ZTXDm5sSJvtIFRyykaIrIoirV333DZh6cAeth6cnirQ25HjGFnseuAoi
         t9ODV/kdWvlFEKgzh+GwDMcBC8+oWZ/PApTnsn7ERKZ4u+7WSiGpyrfMWVZCn5c3cDxS
         EziQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDkU/ah9js35vPVpYH+rPEi1++Ea5N7ulatEjkDSqHG7Oo7ywqvAh5ODkNEeSR4j573PLLMQ+LE4VhW7TU@vger.kernel.org, AJvYcCWIeX0BZgMUAfRLL8+UVV+jLVrWCZ8HudtY2g71mucJQe2AOICg0UM0kbBLq2zDbKm/JTaiOK4wewM6pipN2EY=@vger.kernel.org, AJvYcCXLV4/7MZrrdudxf5Bv0mT1d5lKs6A+mYkAlQHMfkW0APi6TBGCtXWgjtEI9br7aE/65i+hckjrWek3W/kcKMpn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy10U9+XscJUSphOKzTU7ydedDj5bnddE+d2b2S+/t/IvAK01y+
	wt5pdHtiRSL1IJDiRhanB0BJoxWeAZFlWUsOBkLoVMVzzmlgu732
X-Gm-Gg: ASbGnctp3bhGc94OSlZGh1x9ogfnlOEmN9jAU+bH4oDiIylY07qNKxYHCftvtYpnAtK
	5Cchcpv/rOdNpnqN9IcgTrIZbXilft4w+RUw/6aYRx6DJf5bVLt8I4+QPZAFRLKissCps33Cv3X
	8R/S0CXGai++cfj/y8wlG+sBQT1qSR2Ttb2X3MWqkqTNTX5AxYqylFbpLA+Z7B6VKHbWm3KrGv8
	zlNaJOJqkzK6fReJgce4s3hF5CiCnm9kS5s23cXB6oUzECdgYpJ5beZt+gqobvJzaQWIBLjXpbU
	tIOYxC/6/y055gE/hYjtI9dPFy2bZUooT506n7qGQA==
X-Google-Smtp-Source: AGHT+IEoz/6JfgKFyFLkMMqKBzicgoh41VaBIR/K9A5qblDl4yTIVM10sMUgg+FhZ1BGg0izqJskyA==
X-Received: by 2002:a05:6000:1786:b0:385:d7f9:f16c with SMTP id ffacd0b85a97d-38bf57be11bmr38468682f8f.46.1737901384163;
        Sun, 26 Jan 2025 06:23:04 -0800 (PST)
Received: from localhost.localdomain ([197.63.236.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a176434sm8341491f8f.13.2025.01.26.06.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 06:23:03 -0800 (PST)
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
To: shuah@kernel.org,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca
Cc: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3] selftests: tpm2: create a dedicated .gitignore
Date: Sun, 26 Jan 2025 16:22:48 +0200
Message-ID: <20250126142250.839019-1-khaledelnaggarlinux@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250122065021.91814-1-khaledelnaggarlinux@gmail.com>
References: <20250122065021.91814-1-khaledelnaggarlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tpm2 selftests produce two logs: SpaceTest.log and
AsyncTest.log. Only SpaceTest.log was listed in selftests/.gitignore,
while AsyncTest.log remained untracked.

This change creates a dedicated .gitignore in the tpm2/ directory to
manage these entries, keeping tpm2-specific patterns isolated from
parent .gitignore.

Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
---
Hello, please let me if you have comments on anything.

Thanks,
Khaled

Changes:
v3: Improve commit message
v2: Created a dedicated .gitignore
v1: https://lore.kernel.org/linux-kselftest/20250116085929.313677-1-eng.khaled.elnaggar@gmail.com
---
 tools/testing/selftests/.gitignore      | 1 -
 tools/testing/selftests/tpm2/.gitignore | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/tpm2/.gitignore

diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests/.gitignore
index cb24124ac5b9..674aaa02e396 100644
--- a/tools/testing/selftests/.gitignore
+++ b/tools/testing/selftests/.gitignore
@@ -4,7 +4,6 @@ gpiogpio-hammer
 gpioinclude/
 gpiolsgpio
 kselftest_install/
-tpm2/SpaceTest.log

 # Python bytecode and cache
 __pycache__/
diff --git a/tools/testing/selftests/tpm2/.gitignore b/tools/testing/selftests/tpm2/.gitignore
new file mode 100644
index 000000000000..917fe0065467
--- /dev/null
+++ b/tools/testing/selftests/tpm2/.gitignore
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+tpm2/AsyncTest.log
+tpm2/SpaceTest.log
+
--
2.45.2


