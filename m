Return-Path: <linux-kselftest+bounces-18910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D14398DF31
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 17:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD847285B68
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E321D0E1B;
	Wed,  2 Oct 2024 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSaUd6ho"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C1D1D0B88;
	Wed,  2 Oct 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882979; cv=none; b=DIYe+RlYsmTHYtelAhlDHt7MeBFgMZFHxSEDctJkTTyjvlmIctkjyVPjU7m7J1w30K8ERcrwcvFP8+VEr8EK3w1DE+mQHLJvRUlo+LNPv3hNpRCZov4NJAuQ6Q8N2YEzgii9ks85ykTMbJmcfVwlKTBMLzPz2vOraBIngToKeTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882979; c=relaxed/simple;
	bh=KcWe2p4//ReZ22XPDI1sSHKXLXNrSm/uqNaJ3zBqUb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sBSqicNgzt48+slbrx5v5GhvvakfevrhirR12FdkYIL9S3QyQEQEkpp/io0/or5Zwu/gh5Va3d62LpiF+tDpHF19CCVB6xjNMoVB32c01snOd8uKAABETpY4xw1ysixRuhResZNQMPCEijFUKbT+lysHSsu9O18opoDDdm2KptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSaUd6ho; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71b8d10e990so3428469b3a.3;
        Wed, 02 Oct 2024 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727882977; x=1728487777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nge7JqBO8y1Nt32fqYmbMoUQ5ZDhat8l9e47yakT2j0=;
        b=hSaUd6hoeKb/iKjdod/KZ21ZwjTwRfPWemuFs+qJsKxhsa2zGhXFvGlvyd1EOZSj4S
         BnTj1S4Ns76mN6S/LlxN7wR7PgMPnmAJW0NTalPuqcY/rlWLK4qu3sl7z5FC/oAlGDTD
         Gq8qifhce+RMCZ0QCw+N6imOhayvQEp8T1K6rhAc4rwdOM50hzt2wXuZn++8F0Hxi8BJ
         RgT51K2fLjghgFSbM8TkM2c2XNGBpRy1rFGKWDnig6QbO42CqfBC2+a0nZTTj63ros6H
         LieSUDK7ipqQ1r3pdx62UKx+WvgInJZn2IHVKfIp4zjFGQDQmTjM97Bv738SezWj9d/y
         KPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727882977; x=1728487777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nge7JqBO8y1Nt32fqYmbMoUQ5ZDhat8l9e47yakT2j0=;
        b=mbK2gtLtklTJIz14MWdmPQcW3Pwunb3PDV3QEjls6G64IMSE7RGGQ5Zc2nqryUAsh/
         zNt/LDVqXA6OeFK/+ibGkzCgQm/hIYiCpmGkIQNpL/um7Q1XCpekiZn2qyS+pPEMeDxg
         t7F7svu89Ro9RWux3kh8DEZf16rEBSO8ZQZnNgOvRmZCVN7d7WUVzVcBQE9zv51VOiCO
         F3ikitFCfWlKhJYO7KRdMZXXKOYCh4fvUSGhjKhwnx9gqzZFHls0cnFV6sG5cY3SSvZq
         qiGXQnlR0/ZNZ54iUy8lkggikfKgWcDUsZ4knPsc/0DA8hiYSQx8t/e/nI2Suiej6IA0
         UnJw==
X-Forwarded-Encrypted: i=1; AJvYcCVSOJDgEUIzHh5YwbX/mONeILiJMoEM3RWVLsE29wZeChz3iN1wZ/c/I3h72CIY5a2AyjeGHALhOSs8i08=@vger.kernel.org, AJvYcCXebdquRlbteI6Ehe9U1hm5Qab+fQP0bfO2M9g28U8yXKzGyXgoFcxxqVw8Z2rXyZ7MuqoB+z37/iYw47j/3b4G@vger.kernel.org
X-Gm-Message-State: AOJu0YwcV4qmZjIj6Gi3395LMKekZFiE9dPClDYpqQnD73Pm3ZCz7ikt
	aSUKC5oM3TeYonZxAUBkqv9wgH1yoKtpxlPorsumkAkvfG9ctCCZ
X-Google-Smtp-Source: AGHT+IGajUHlPqJ18foTX/9BkGVtb9utfYvyvBixhhmmnEWfIo9T2x2Yw+FWPf1rfVrxvjY3E73qog==
X-Received: by 2002:a05:6a00:13a1:b0:717:88eb:824d with SMTP id d2e1a72fcca58-71dc5c78135mr6106100b3a.7.1727882977213;
        Wed, 02 Oct 2024 08:29:37 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.lan ([2409:40c0:23f:2448:4ee3:a2dd:4021:3733])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265166e2sm9872830b3a.131.2024.10.02.08.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:29:36 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: SurajSonawane2415 <surajsonawane0215@gmail.com>
Subject: [PATCH] selftests/vdso: Add linux/sched.h to fix CLONE_NEWTIME build error
Date: Wed,  2 Oct 2024 20:58:49 +0530
Message-Id: <20241002152849.111841-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix build error in vdso_test_getrandom.c due to missing CLONE_NEWTIME.
Include linux/sched.h to define CLONE_NEWTIME.
Ensure successful compilation by resolving the missing header issue.

Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
---
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 72a1d9b43..3f2a4dbf8 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -22,6 +22,7 @@
 #include <linux/random.h>
 #include <linux/compiler.h>
 #include <linux/ptrace.h>
+#include <linux/sched.h>
 
 #include "../kselftest.h"
 #include "parse_vdso.h"
-- 
2.34.1


