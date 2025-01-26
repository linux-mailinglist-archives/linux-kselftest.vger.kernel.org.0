Return-Path: <linux-kselftest+bounces-25192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 676A2A1C772
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 12:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2983A7CF3
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 11:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADED72E401;
	Sun, 26 Jan 2025 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCThu98I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328E31362;
	Sun, 26 Jan 2025 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737889215; cv=none; b=nnB7zP4IPgs8om3AuO7OvFKcs9FYZdyzqVlXGTgJCactK8LwsA6OrnMhwgBghsjiPghCUPaifsA3skZBPQG4R5+/tRPB7V7ovMztWhAfSyyG+PAOjC+7oJ0RKBZ/2H/myT90hR/N5ji6nzc8YGzxOhUHeQsBgs3FqbJJmUi3Q1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737889215; c=relaxed/simple;
	bh=IDxca/bUBhgaqmDl9PBsDz8HFjcVqPAP8CrT78j0EEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nAN8wYODrqnHbY2ymPTcnxNBeEzQkNAvCsZ9ZBv6GJzk6OPzLEEQPB05TFDiJRfTobCmZeOciUOiD7KtUpCfWTp9Bdev24hsHlFqFcNZR4O0KagAt0GQiDU+KTfATZU1l3PPb2eS6UxtWzZ5rMpf0t9PWEBHZx/PK1MCylW9Mj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCThu98I; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-215770613dbso43288945ad.2;
        Sun, 26 Jan 2025 03:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737889213; x=1738494013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/wmgBS8Ps2fWSOf8qPrnGQmls+9v2wvSGxcZes41VA=;
        b=nCThu98I92X01VPz8GFdVAqCjggWNtu/gBux4JCwSOHbDJQryfsCSKB/HuznDX0kP1
         eqLe5Aw29NbLbQF23HNu4KI6+ccjx7ykYbnwR8kC4SPtS5rNgKCyFiv8J60eCRejjNpG
         uo9jtYEOwx23lFSWC4UZhgHoou/W8V924ejx57GcyQx1D2F7FlGgbt5S1Sh7njufO+UO
         8pBA1ilGmSZTUZP/eghECvYMEidOHrLFAvu1sgqEWa1gP6OzVSspPtWgPuUfDxBqSZse
         6qLJ84k3q3N0NSVUdRB3E0wl51tglSryMi4eYyzuzyx9oIUWlr+5HpDw9pMMzFM0SMrs
         2Ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737889213; x=1738494013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/wmgBS8Ps2fWSOf8qPrnGQmls+9v2wvSGxcZes41VA=;
        b=TEsw0ocn4nI97BgiiFTFiVm4jvjpJtQx1paAoQHz0Dy2J/qLgHJ4qXRCJUVdkmF24G
         H9Lck1G6Xw0ibuYEXvgIskCrBZsDPCp0p2ayBh5PsrIvSyhDjhVFQlP+JJs6kLUuhISt
         HAZfx3PkP60NqUeEAYSLsBl3q/4sSPxV1FR7j+uSoN62T1HAPtD+s+Vg+cwtPe326GSG
         RiZcu+YXVrToHBh2OA0qiFTiV065HNDWYMhp0U6e0lADtB/4oaNWd9Sj1M/gC9IbT03o
         iubZZMn2pp6KERD5KlIYbI24x671v47S3k/q3HRGN23yY8MdNpHz9de/r6eF25N/jLQI
         6eZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXNFPcHTCf8P9EzKKE3TV3aThQ4Iui15BRNAx6TpceGY7jX28JEBopHLqmfhFSmrt+hQ9U2vdRfWIYGG0eCIy4@vger.kernel.org, AJvYcCWSjpqZhvAlbC9xyXSsuGkbph349/nnDvtrjYEVbyvpisvf+shFDu4mE/WBX26kqmVdsOB1kyVu+2U8HCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIycaVveL+RGORdtyBSj96qY8Gx8FX0XNjhGiHyxiuiC7CJadq
	a+aa8btrqVyqyRpYVTC590xYWRxrHVAIISmEOtaf4jUgCfPUJSCw
X-Gm-Gg: ASbGncucQjPuASiG4DupcSIAhHP3B4pOPcuGcRV8X65Re4FiHrG8PbjKODMkXpibAIX
	R0fPFB2XUmhvqHTALa9mhMyQJvA89s539ep3a0ivW2PZPMVc8oAPTI92BcqTWpITrVT9BX2uJFQ
	bqjOv1vdKGMsLYiKxeljjCJAa50NytyZmHHnDqRAW8P4iwt763QnlwlUp05HHxJvVLFU8j5orsp
	eGWk3M7dLSpui0I9hTOrOeTKXgQUIZMiBpMxd1JVb3KvdbnkaKsfBxfCg5w3E5u7uinTzEL/+lg
	j3tlQvaBtjP0xGgeBAs3rQdCMYC5W9qHfXWk
X-Google-Smtp-Source: AGHT+IEa7XTvu5I+KZMKkWQq1RVApzZEh/Ero6eSGgYteTSNjIVw2It+lZ5PwMa4Ub+O9QqaOV8vqw==
X-Received: by 2002:a17:902:ecc5:b0:215:44fe:163e with SMTP id d9443c01a7336-21c352d60e5mr605835945ad.1.1737889213430;
        Sun, 26 Jan 2025 03:00:13 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:40c0:2d:e96f:31a2:50e1:b7f5:21fc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424d642sm44185085ad.216.2025.01.26.03.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 03:00:13 -0800 (PST)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: skhan@linuxfoundation.org
Cc: shuah@kernel.org,
	Jason@zx2c4.com,
	christophe.leroy@csgroup.eu,
	liaoyu15@huawei.com,
	broonie@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] selftests/vDSO: Fix undefined CLONE_NEWTIME by including 
Date: Sun, 26 Jan 2025 16:29:32 +0530
Message-Id: <20250126105932.63762-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the build failure caused by the undefined `CLONE_NEWTIME`.  
Include the `linux/sched.h` header file where the function is defined to 
ensure successful compilation of the selftests.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 95057f7567db..b2c9cf15878b 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -29,6 +29,8 @@
 #include "vdso_config.h"
 #include "vdso_call.h"
 
+#include <linux/sched.h>
+
 #ifndef timespecsub
 #define	timespecsub(tsp, usp, vsp)					\
 	do {								\
-- 
2.34.1


