Return-Path: <linux-kselftest+bounces-38085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEF3B1664D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 20:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A061AA7E49
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 18:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392521EF09B;
	Wed, 30 Jul 2025 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUASvIYt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02311DF97C;
	Wed, 30 Jul 2025 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900401; cv=none; b=RXmC0dD5KfMtOT4/HD6UsuqGjZDB0MSEBCL+zXitQlh5NcRcnWISQaq2VVmqRyw7L8a25+Vo8QQGOuFj6eaVvnR+HpFwp/YSQngv2gJMv51z6x2LfJyJHu0v7A1ql9r4HnEAPP9k3wjZL+StsfslK4gOt+CHrBhAMq1psPxJDWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900401; c=relaxed/simple;
	bh=1z35DOrDo0K5qnRG3rh/MpzSfxVUIsME4OuSWDoH1WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BD2lWxYY95z0ZXG5iBlnvNmopCCSCUAmdlmScQTpEBY3Exm7u5u0XrBZ1pSzupce0kFjMzAiI6cxUq4+7ZMAQ4iMM6gVZYEzDveygX7XAlilUgfzyGruGIrgqhM5GNvIdAfi6dkppRat7cjj/fwyElXMTHmckw2SiNNZpY/kAZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUASvIYt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24049d1643aso1350265ad.3;
        Wed, 30 Jul 2025 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753900399; x=1754505199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pfr5Mj0mOFchlFGCNfQ/8BknjNq/tL5+q+1cQf2WpPw=;
        b=QUASvIYtSs07JB2e2h5X9EpFgF7alDYWNjIHC4Y9l9bh04mGhoe8Jo17duqHNEWEj9
         2TPCu7U93fW/f8KeOgwN795k05NrxY5O30oL1HIKEar7kW8u+EDMniyaOMptLBTk05lp
         M20RcKMZsEzwuNN2a3efFytv0GApAVZ+O+qpRQ+hNlUka6o/EZfAdPog+W9zeK30mLQf
         zDzmwDwMAyJMetjMEuanJkjS5p/m7j4ZUdFu/qi2fG04K71IRTrQV1a+yfRwbLbuQLpo
         j0byUV4fc2itn/u88HfYlorPMp8kwS15EFS+Zqv64PAJayj+zj9DTIyeJzIRmRByo2Mw
         3/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753900399; x=1754505199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfr5Mj0mOFchlFGCNfQ/8BknjNq/tL5+q+1cQf2WpPw=;
        b=NWSh7Yh6IoMjhshCapFsGBGHUQhrjcdlyxwXuJJkMd2qhu8Y+thxP34zoQV4bYDDpw
         77A6wR6RAp4Wj5RYeQNldtg/DY/+W1Yo8tvsFyKnFOPby8QOzxKqUsbsLq3+e4Bv+cRY
         qYyqfw39ULNUX0r96i1CtGEKnrTcho52pKXsk1UG8CNQl0lVroMeZ2rvSKiTeAsmvg/0
         3FTOdcMPkBX4J72f8moMj+tfeBG1pWQJ6v7VV2KO+1vdHHUSgs3kl9Apu5ZJ3k+nXFdW
         X4Gwfc75g9fa4L/5cQtVrHQec2nxwS3xmBJ+N7hsBK2S6ck64bonFXwabAQCHlutiumL
         PCyw==
X-Forwarded-Encrypted: i=1; AJvYcCVKG/1zP8OH/vEUgaW7P4lHa8w6XO5I0ovBZJ48DmuowGu5X9ZWGU47eesh3EDrLS/NBuNBIhxfDrMLAJA=@vger.kernel.org, AJvYcCVa+FMcz4iFITRbLkFdwX9ZWIuvu3F+WizpumWWfgVpvaPdHivnWhA3RqOfIicmi95Y4v40gyrhSshNwKSTgqVB@vger.kernel.org
X-Gm-Message-State: AOJu0Yww7t4F4aPaxMi7y7afz0WMOBqbQkIpH5bdWnHlswundoVqG5oW
	fovLnIYHMBO5B3/4wO8sgNaWSPoMmH4fXjIsr1L/GKLMPWqjCVU8NFWJ
X-Gm-Gg: ASbGncuqemeLVngQ8aZS+S0G/97M5rYUFa9Mvm8VOtLDRijLW46M79nMrjKhIVFlH73
	dhZcEhFeuwhxQlm+LPtUCQ2eN5S6r61ezQe2Um8CHblbxwO0+/cyRmfPxwGLIOO3v3LuOUjC0/m
	mxI1me4Tnpaxcd2N8FuDSLpTlOuLy6CfYz/T+Ef4ecmXsf7kEpid7qTv7bijdyLsH7ZxbyNwR9t
	HWBeaX82fWHF/VUsUoipaKDyGnG9+vDtecfpPOXJrwYsLS091d7kIewCnqVvDO6GxEPNPK315Oe
	1Y7yjn1IKlgx+GQ+xMWDFDSnUBzf4V87nj3Y3PD/sDjfGYRWhdmWmx1GM3qPxMFS7SkSoV2Nybx
	ufP+9x+ZSMscymst2xxZQBBTLnVAz
X-Google-Smtp-Source: AGHT+IFk72ahEPEvl4D33vR6IcdQMO68lWrfY/canlFV5/QzGCtlFRDGLGn12c9w9tg2tlrldBG2bg==
X-Received: by 2002:a17:903:18b:b0:23f:f96d:7579 with SMTP id d9443c01a7336-24096b3fc61mr53132105ad.37.1753900398941;
        Wed, 30 Jul 2025 11:33:18 -0700 (PDT)
Received: from LilGuy ([157.32.139.86])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2402efa3500sm73585585ad.31.2025.07.30.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:33:18 -0700 (PDT)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Swaraj-1925 <swarajgaikwad1925@gmail.com>
Subject: [PATCH] selftests/mm: Fix typos and improve output messages
Date: Thu, 31 Jul 2025 00:02:51 +0000
Message-ID: <20250731000251.5412-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Swaraj-1925 <swarajgaikwad1925@gmail.com>

Fixed spelling and grammar issues in test output messages
to improve readability.

Signed-off-by: swarajgaikwad1925@gmail.com
---
 tools/testing/selftests/mm/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index ae6f994d3add..96985c545d16 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -48,10 +48,10 @@ ifneq (,$(wildcard $(KDIR)/Module.symvers))
 ifneq (,$(wildcard $(KDIR)/include/linux/page_frag_cache.h))
 TEST_GEN_MODS_DIR := page_frag
 else
-PAGE_FRAG_WARNING = "missing page_frag_cache.h, please use a newer kernel"
+PAGE_FRAG_WARNING = "Missing page_frag_cache.h, Please use a newer kernel"
 endif
 else
-PAGE_FRAG_WARNING = "missing Module.symvers, please have the kernel built first"
+PAGE_FRAG_WARNING = "Missing Module.symvers, Please build the kernel first"
 endif
 
 TEST_GEN_FILES = cow
@@ -202,8 +202,8 @@ ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),01)
 all: warn_32bit_failure
 
 warn_32bit_failure:
-	@echo "Warning: you seem to have a broken 32-bit build" 2>&1;		\
-	echo  "environment. This will reduce test coverage of 64-bit" 2>&1;	\
+	@echo "Warning: you seem to have a broken 32-bit build environment." 2>&1;		\
+	echo  "This will reduce test coverage of 64-bit" 2>&1;	\
 	echo  "kernels. If you are using a Debian-like distribution," 2>&1;	\
 	echo  "try:"; 2>&1;							\
 	echo  "";								\
-- 
2.50.1


