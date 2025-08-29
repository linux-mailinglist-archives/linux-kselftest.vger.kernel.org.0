Return-Path: <linux-kselftest+bounces-40282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593E2B3BB49
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 14:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CCB3AD838
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 12:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB79314B7E;
	Fri, 29 Aug 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBPX8C15"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800291FCFEF;
	Fri, 29 Aug 2025 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470599; cv=none; b=dFZQJUGnFsLDbl2vGuu9ShCWATJ/23RN88QvkrnnriRyKO5hBhyjujx30099mqXshoCkhdC7vQlj+v4YR+zdPR81oiSPDT5RdjX9FXI5ynHO78HI17VElqUjyMnX27l9ycMwL/wyNEHsry6XSmr4GS/NLq5i2WtHTDJXP1T/kcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470599; c=relaxed/simple;
	bh=7WkwrUEY+6BIbqKIw4+GT3HhxIaHHpAXuksiM1pzQNg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=qNCFQAdwFJINAP/XBAr3anwKtkMK0uxqOZsrcf7zeZxHCebJXcTbf1Cgn3yuHuVAHpvAp8QXuU9w2mAV/KQYfK9kXl4Px/9fAStVTEzIIgfiHkGyFTUnTHUZdeh9NeL3GwhdGCOyCI2BLiuS+Q0TMq7ZRWxKndoNFKZZu4JvYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBPX8C15; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2487104b9c6so18365195ad.0;
        Fri, 29 Aug 2025 05:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756470598; x=1757075398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4rM3RyXh88VhqP0EnkxZqWAvRFKr6uyDjCBhLREGSJw=;
        b=eBPX8C15V+uKIuGoa88jQXluMlKV15cj/bv6fO0hRSFO+0zEEjr+nL5rwEyexS1dIa
         cddugoMMuLoOMQJhjwnMAInN6xj3qPXhrmhtFkYusvpDsIgy6uphrYsed9ykN7A1wvzT
         OmaWt2AUwYfa0GDTBPNVCuX12k8wO7bS/VAJXllx7ocTWF/x4bNDtpuC3smHGJ8xaDhK
         U5gTa+YS5TTXlOJD5FV6Je6Fv4rQaiAmX6Gt6dwMqoOPRbeOE0nQndUJKUT9S66t0j9Q
         AK8XcAiqi86mSRYMI+Bfdydu3l/+gPvujGzgt3Q5X/0vDntiwzasPkUGBxmzH8OKJap9
         fxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470598; x=1757075398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rM3RyXh88VhqP0EnkxZqWAvRFKr6uyDjCBhLREGSJw=;
        b=qzL7hQ0aEoX/KqbS6rzZGDJFVS7LWQN/zVA6W1CO2pwbuMekav/69iwQN3qeXCOMe9
         NADYISM3NhvmMCq33/0EqTtB9hQRo3FVgXHJ2IXK0zpEWp6QJl0qQBEf1x0+QUce0SaC
         pQnP8R9KFU2b1q79+mdKzusO5YdiRb2IEjoca/itf5LdudUdQBphTaqDxlEurbG3uER5
         q0VbtmCi11fue1I/UNPr8cx6LrKxeelqCnOT0u3GMv2LALzBK6YS81/TWH2kIhGZoBSZ
         B10w5mzwQhjVRd1ebwZJ9HHC4PGTU8NG8IdkZg2Tu5+Op6l13m0Bnm3eloUVk13AI8r5
         +fyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgmDJUSDptO6utfWX4zqPhTC/XYutUoSh/FTO69y2i08s+SU5fLDRu1NJDpIhco3qD40z91hWP0QzYKxU=@vger.kernel.org, AJvYcCUoZrxfMp92Yg7fBOkWDtV74RpZgMnh/hlh5p0hW44Q90TTKj9yPogJWVKieXwUA/h34BgQdQp52uwyiBqtjPxB@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd9DHyFdjhYN6yGdiYD2k6cRFq4ehYH92W9TBODZLiazbWIHH5
	TKP8wrNpuWPbMIRG1zytS0OL0cwgFg4XEjfGc2JsMzr6qEtZtZ4BtDPs
X-Gm-Gg: ASbGncvySwvkCFiVAOk2c+GWIAF9aJSeDMVg8efAXV38IqTKSBf/22mwl0KE+CBBP+D
	mPHgFRHe0S31iwXAhBFtNnVu/GEApmbRMw7lw0EgVj5TW5YU90ak+7WexYFd6V2U3e51kh4a5/7
	nV/jjUc37mhgmsZlrVu9PuKJUjA3ckJaejY2sIrwlZRLMjLiuWVeWrrCygtG3t3iIYdDRGHjYuc
	3Tcxtjb8qKTt1MgdElK5UIJCPHLAWFSZlG/XXNyXNFCECqsqCp8mKhmQhzfuhXyQTN7p8Iq6Nh0
	Qu1nXpMFTQ/WzFnHe49sIqZflWm29NcYJHgdJG6D0cJSMIpqH3e0HnRR0pJ3tY653D3x4dEP6Gz
	HrcCc4dHbVVrp4UzUfex9meBcMakbLhqxqmoiT5PZfDfszgR1kV4S91lULYBtYPrmYxK+M61gtA
	LmbSwc4BBr17jb0vo0uswTHvPJr+CcgtaTTwDwIFZS60Rr4EU5L1ARva4/oUGhw2yIrKk=
X-Google-Smtp-Source: AGHT+IGnIECyfQJM/jiO8OpiO9eZlCpUV84jR+OlF7wJ5ML+j1n2T6SX8JRXDDJVlSHap6E3W4C4uA==
X-Received: by 2002:a17:903:38cf:b0:248:aa0d:bb25 with SMTP id d9443c01a7336-248aa0dc43amr128843915ad.14.1756470597715;
        Fri, 29 Aug 2025 05:29:57 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.116.239.37])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24906596416sm23699315ad.118.2025.08.29.05.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:29:57 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Miaoqian Lin <linmq006@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/move_mount_set_group: fix inconsistent return type in move_mount_set_group_supported()
Date: Fri, 29 Aug 2025 20:29:47 +0800
Message-Id: <20250829122949.2020530-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function is declared to return bool
but returns -1 on multiple error paths, which is inconsistent and
misleading. Fix this by returning false on all error paths.

Fixes: 8374f43123a5 ("tests: add move_mount(MOVE_MOUNT_SET_GROUP) selftest")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 .../move_mount_set_group_test.c                    | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
index bcf51d785a37..3f2c94acb29a 100644
--- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
+++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
@@ -197,26 +197,26 @@ static bool move_mount_set_group_supported(void)
 
 	if (mount("testing", "/tmp", "tmpfs", MS_NOATIME | MS_NODEV,
 		  "size=100000,mode=700"))
-		return -1;
+		return false;
 
 	if (mount(NULL, "/tmp", NULL, MS_PRIVATE, 0))
-		return -1;
+		return false;
 
 	if (mkdir(SET_GROUP_FROM, 0777))
-		return -1;
+		return false;
 
 	if (mkdir(SET_GROUP_TO, 0777))
-		return -1;
+		return false;
 
 	if (mount("testing", SET_GROUP_FROM, "tmpfs", MS_NOATIME | MS_NODEV,
 		  "size=100000,mode=700"))
-		return -1;
+		return false;
 
 	if (mount(SET_GROUP_FROM, SET_GROUP_TO, NULL, MS_BIND, NULL))
-		return -1;
+		return false;
 
 	if (mount(NULL, SET_GROUP_FROM, NULL, MS_SHARED, 0))
-		return -1;
+		return false;
 
 	ret = syscall(__NR_move_mount, AT_FDCWD, SET_GROUP_FROM,
 		      AT_FDCWD, SET_GROUP_TO, MOVE_MOUNT_SET_GROUP);
-- 
2.35.1


