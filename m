Return-Path: <linux-kselftest+bounces-41947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B96DCB89973
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF197ACDEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22842ECD1D;
	Fri, 19 Sep 2025 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ctzHx0J8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFCF23C4F4
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287195; cv=none; b=FGmfB6EhrPkgnn49BNRoO0Xe6ixGKy3OxJ6fHAt+DkmJGbJqgHxUN8//GVP+E1qva7syUA+ieUiiKGdvxqfgYKw6U8pSIb+N03dCbNQMSfRWliV8bA38VsRR2dzMHJbDFddpUzI6LiegS4Wr8fiqyqkMpBWdOqNkwMPKEQzktXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287195; c=relaxed/simple;
	bh=rWHkrjGiK/PkSG/Wl+on4XzMkxSKB3j5hi6+81rUdHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/QGL+tM2WDTWC86q7/umJ03oZNtuRP2bl5NE3axtWDN+nJp+W0s6T2cE35hzCZLEP2JquGSI8wPXOWgYyDswNuNSHg1i9WWkYP9QkOINvJQuYNLjeHtPfqAHNBcO/NmgkEMGeV3Sd2GJVkSBBsOmRz1MSoR5VuOEdxSJNvO3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ctzHx0J8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2570bf605b1so27955575ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 06:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758287193; x=1758891993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QM3z2LyJW+bazyfIUJsU26vcVsKZ5Gd2BUVcAs3sFgA=;
        b=ctzHx0J8gOWsZQ4MHuCVK1x5UsAdhEq5mG1tJEA8WLxptXDIQaDjuYIZ7Ko72+QQ/5
         9PDov+zNx81WqGtnq25F7MBnEDmJXtDzyFXdI5nETO5/AGq31RGS0CT0mAOBalWlBOpV
         g+C1TZ5OTZNE4jemWavXbU4KFEn11hXQb+hesdlvYwV9YVsz+B8dcn0+j0gPo4gpL5T+
         GBTsM42pI0zgQj/iAuCzHPhaK0lvyawKML1pzCdC5smRk1S+uvdpc8UI1hoN1a6kOoxF
         R4nax/bK81utCq4C20Y011sg34rEC9iQQvsFX46ffCB3OpqnYR5/P/JiJ95/2AB0SnML
         GwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287193; x=1758891993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QM3z2LyJW+bazyfIUJsU26vcVsKZ5Gd2BUVcAs3sFgA=;
        b=PFn+ZSymKBKv8iaI0ZIAp37XkNRnbVaxA9bx2/EmkRwOcQEeeWXqpy8s6UDH8StvIp
         rSEpxEXR4AIDIDXEXB0Xet7SzVr7p83Xh3rGXfgkPmCtA6Y62TTQ6XqAdyHSF8QInlPS
         9yMLa+m7LEFxBB/N1ikV4ekE85NuekyVVuFcYesyWNh3PT+fLwINo3lmn1nOaNYV32+D
         xNBNoM+08k9n+x2rJhseEZHBX3L/keGEeM01HC7d3DSDvacL0wWgsVn3kLHsPdVMIwHA
         NnoF8QdqO872JJ/bArHtKEhzgdfywF9i1PM+uYuOagrB09GjPcdED0luYSzhomqNz6Xf
         /NfA==
X-Forwarded-Encrypted: i=1; AJvYcCWEGlG/0v4h541GRymVxReCodTLaFb0NhPfYELJWP3V3YWYrQFEj1T5Rvess7A5LzGgm6g5Z6X4bwYOVoVCcIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfGeRz1YyG89mZ1eglFYMq4xP4uU99e/w7sE7SgSR6PhXnlETK
	v2wX/FFVHH/TDHUrqf8T4KCB/pXde1cRrT2W7AEzNgzUj8bMjsTNyVWqv7tco8TFuAY=
X-Gm-Gg: ASbGnctsFLPhLXX+2J1zaUc+PxQC46QZF0bCz0NwKUOeJUaqom7fHC/4gZ8xRJpfcqL
	8hfkzggxAjR7s8z1AwkrC827Hx/y3c7a5rXbyZNwfrRB3yo66ATp4iSzi0UTdrR93+V5wqjilje
	kR5szSd4bVZjbuVZlB4gTmpZx1XMEUHFJVZ0/BFGWUzYyTDpW7IxXWBzWeMgNP08rVJ0Hf3ZMV0
	m+VyfAQFrRAFnZoNPAvaqdSUI30cD+8vA0xuh2iWNsxGiGQKXJHE44p079D3EJUvNpiuqLvzAM9
	Oz3G6EjWzra3Ju7g6R83gTPkTWt7upt0SqzQ/zLPulPPIYHlqbUzOhfCa/huFIHFosNZR4370fg
	n3muB36n7G9/W2LvKrTAUCil1AOKXkNHC3x1/8goOYU4TvRY=
X-Google-Smtp-Source: AGHT+IGbrf3KBw1E9vOkt5rEaC3g4HQJ3sGafywJShI64TnAWeeXbrI8TdW5u7TwWDUuix9UTIPH4w==
X-Received: by 2002:a17:903:3c2f:b0:235:e8da:8d1 with SMTP id d9443c01a7336-269ba40e0ebmr37928995ad.8.1758287193223;
        Fri, 19 Sep 2025 06:06:33 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([2001:c10:ff04:0:1000::d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm54732065ad.90.2025.09.19.06.06.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 06:06:32 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	libo.gcs85@bytedance.com,
	Yongting Lin <linyongting@bytedance.com>
Subject: [PATCH V2 1/8] mshare: Add selftests
Date: Fri, 19 Sep 2025 21:06:14 +0800
Message-Id: <20250919130620.56518-2-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250919130620.56518-1-linyongting@bytedance.com>
References: <20250919130620.56518-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch setup the selftests project for mshare and add a
'hello world' to project.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/.gitignore |  3 +++
 tools/testing/selftests/mshare/Makefile   |  7 +++++++
 tools/testing/selftests/mshare/basic.c    | 10 ++++++++++
 3 files changed, 20 insertions(+)
 create mode 100644 tools/testing/selftests/mshare/.gitignore
 create mode 100644 tools/testing/selftests/mshare/Makefile
 create mode 100644 tools/testing/selftests/mshare/basic.c

diff --git a/tools/testing/selftests/mshare/.gitignore b/tools/testing/selftests/mshare/.gitignore
new file mode 100644
index 000000000000..406f31bd432c
--- /dev/null
+++ b/tools/testing/selftests/mshare/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+basic
diff --git a/tools/testing/selftests/mshare/Makefile b/tools/testing/selftests/mshare/Makefile
new file mode 100644
index 000000000000..651658d091c5
--- /dev/null
+++ b/tools/testing/selftests/mshare/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS = $(KHDR_INCLUDES) -Wall -g -O2
+
+TEST_GEN_PROGS := basic
+
+include ../lib.mk
diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/selftests/mshare/basic.c
new file mode 100644
index 000000000000..482af948878d
--- /dev/null
+++ b/tools/testing/selftests/mshare/basic.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "../kselftest_harness.h"
+
+TEST(basic)
+{
+	printf("Hello mshare\n");
+}
+
+TEST_HARNESS_MAIN
-- 
2.20.1


