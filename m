Return-Path: <linux-kselftest+bounces-30604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F1BA85FBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 15:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFA11B8565D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094611DE3AD;
	Fri, 11 Apr 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9CeYtAJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA31917F0;
	Fri, 11 Apr 2025 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379759; cv=none; b=R73kP2Vxc+w43aSOxC3rer+wvYLPOJvD+JZG2qTsYoIWCyeVLcZHSWT6cJSUSpPvzELgRkFeVMuErDj7GrN1CI0M3XSfSf7JQ+AXX7zTMRgz5/TZ2YdtGXLCIYQy/zViTs45u22QYoZDOS/z8wUN3UgpSkamp6dKYv+qj1DQy14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379759; c=relaxed/simple;
	bh=Hksio+SBng2Ph0jL+AW8Cf2YcpKo99uTiSN2rqmAQVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gNv7ohczrIhpkDs0XRoUHHV5Kf6dN+waZV6i+WaGP6yElxmI+EbuBzQHO15tfNrY6+PYjJ1InNwJIu/QW8eQJ04w61U5ad5q8NZMJY0Jvi5VxuQnXQwDFOOg1ElDGuONtT+0Izhv63UzXL/5pYI4tSliRV3Yv+313lv2RxUQNIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9CeYtAJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736bfa487c3so1787839b3a.1;
        Fri, 11 Apr 2025 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744379758; x=1744984558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fgT+aB/ObOAloX5DH3cQKl+POiKYMAsP7NDiSj4mfE=;
        b=E9CeYtAJ0F0gllu6JtrNqgSzGZFGFoGPVvZBzrn6hCkDyLWvvLDRDcEpy68z8atTox
         0cuDtLNxE5foj+flOnskYmns+I7R953AMBRppciRSyVAYLcCDkBpJDMP1hQpOwIdjKgS
         ijHcpy/H7DwIUdlK4qEiSgxnnRbIJ/wmMA1/xW02DVjGOn9D9CH0xxlbca3I6ugMZ1Tt
         GuWBhBfWg0hNAsyxlAJ8LWXPIsfw5o1uI/jl/i+jH2W30PrgEUPO3BMP4Mvue8OMkulb
         7e7WCZs7RltEJg3jtTvy282eyo9vfW2dhu2dwujMOk1Hh1tGKqooSrECh2ShLaz2HR2A
         OcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744379758; x=1744984558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fgT+aB/ObOAloX5DH3cQKl+POiKYMAsP7NDiSj4mfE=;
        b=pRz+5HKmkEBgXrghOwQrAzHYVrT+CgyhweSBy8s/2nbWEa/cISlTzYq53QgUZe1p0I
         iH9PKjrGpCG2Q2mhrbfJNT7ZBmDiPXl792/kil5+Bzcnehb6zc2Sa5TLatpDwH1Sa6n6
         HOhtAWH2NQwjmKSGNkGzCC+EutE5BKSP8hRWEXa/GbeQAQT8SADzdo0HD5avOvz4QI6c
         fKEm9JTsqdkHNh4W2U6raM5nvKpONquHA6gWYIlfXFKfmjmqGgkRyQxabCYbE5qb4wVb
         priZ+jec82pQYywU3Qyr0u6RHA663+B9+tQ4sDfoKRFkF5xsc1PdQZx5qYCdyzjoYFeR
         yq1w==
X-Forwarded-Encrypted: i=1; AJvYcCU3ZQxkEJrqH6GoN81AyJroxN+V7gDqEgiarei+vrnaRNsGFcJaOpE3oxmyoBNyisNF0ksKT8sOtg+0j0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVz24fV8rjTvGF1LuNgkZA2AT2HXNSDc2tMQJlRvEz3uCKovU
	gd6fSNzgGminsEfGrg9M+7LRf97h5BlnEEWvgTRIVrXCh32EQPoq
X-Gm-Gg: ASbGncuuLUmlMadp18tl6mu/uREYk2smufNPInnujrXR7AVYBLdB0cgjQE95Nq1bEYY
	xkCRZRz23Zd899Lv+mxLXhb81Z9yfVP68Rpbq7d6a6EUIiMvsV2/W+8j8hVSogXNhpER/C663Jp
	TtbKRmHeweJBlQfYw471awSp3Trd7pfgNnLmmwDA2gkD5PJ2tkZpc4sMDJuM1TkF7gmXhyQl9yq
	Fw0qLwKGHeJ7uSC7VbU21PmQvhYf+lnW4lXajHI49EBmYVLxV0Tqqx+qHT9tL4EI1LlJ/Mqiobs
	3JYZ0gNoO05gzIjxvG1tj3sqS/MPGxp2D+JlKjnmwj6pq+npVSeP/or2rQ0=
X-Google-Smtp-Source: AGHT+IF57uOoN1+g2NXZ4dw98X52Co0XdPWGzDqnOvXOt7h2udRQqPwsNmdyGbrkTlaIXPVHPNA03w==
X-Received: by 2002:a05:6a00:843:b0:730:d5ca:aee with SMTP id d2e1a72fcca58-73bd12cdb7emr3902525b3a.23.1744379757687;
        Fri, 11 Apr 2025 06:55:57 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c408:a0b5:6154:df3d:5cdc:6ad])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2333859sm1485740b3a.158.2025.04.11.06.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:55:56 -0700 (PDT)
From: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kevinpaul468@gmail.com
Subject: [PATCH] selftests: Removing deprecated strncpy()
Date: Fri, 11 Apr 2025 19:25:35 +0530
Message-Id: <20250411135535.41423-1-kevinpaul468@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch suggests the replacement of strncpy with strscpy
as per Documentation/process/deprecated.
The strncpy() fails to guarantee NULL termination,
The function adds zero pads which isn't really convenient for short strings
as it may cause performance issues.

strscpy() is a preferred replacement because
it overcomes the limitations of strncpy mentioned above.

Compile Tested

Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
---
 tools/testing/selftests/sync/sync.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sync/sync.c b/tools/testing/selftests/sync/sync.c
index 7741c0518d18..4b284f517433 100644
--- a/tools/testing/selftests/sync/sync.c
+++ b/tools/testing/selftests/sync/sync.c
@@ -29,8 +29,8 @@
 #include <malloc.h>
 #include <poll.h>
 #include <stdint.h>
-#include <string.h>
 #include <unistd.h>
+#include <linux/string.h>
 
 #include <sys/ioctl.h>
 #include <sys/stat.h>
@@ -71,7 +71,7 @@ int sync_merge(const char *name, int fd1, int fd2)
 	int err;
 
 	data.fd2 = fd2;
-	strncpy(data.name, name, sizeof(data.name) - 1);
+	strscpy(data.name, name, sizeof(data.name) - 1);
 	data.name[sizeof(data.name) - 1] = '\0';
 
 	err = ioctl(fd1, SYNC_IOC_MERGE, &data);
@@ -198,7 +198,7 @@ int sw_sync_fence_create(int fd, const char *name, unsigned int value)
 	int err;
 
 	data.value = value;
-	strncpy(data.name, name, sizeof(data.name) - 1);
+	strscpy(data.name, name, sizeof(data.name) - 1);
 	data.name[sizeof(data.name) - 1] = '\0';
 
 	err = ioctl(fd, SW_SYNC_IOC_CREATE_FENCE, &data);
-- 
2.39.5


