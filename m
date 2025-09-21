Return-Path: <linux-kselftest+bounces-42025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9624BB8E151
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 19:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE0C178599
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A5D23BCED;
	Sun, 21 Sep 2025 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idLMGeGM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7EB2BB1D
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758474528; cv=none; b=kCUtrmZ3pebWHAXTARVksqQbRFtgqYl8MfFYC1SX27uyLaOzW4E9ieiTHY1f7bw7o97YWqUNSszm/XDn5KYRKlIhnYaIhVsNdfju+5chbZ2Jw98zCrkLBjYCT738mi14CVSha2z89eCxfOesPrMPjNJO0Ri0ZHgbhVX+syXUGQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758474528; c=relaxed/simple;
	bh=ESfysI5irpo6VI6OY3A7TqZpje6xY/bTUCQuouqbaKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iOZbrpF5xVz2ERqealbgJZCOD1DT486kAEZIzu1pw5F+Aw787t4VifhHkwL4+2664qlmBuMXSEV3vqg/WbL28o8x2wW0vM9GFnLwcewvTjhOUHBvyTXaWLUbgDXAISGUD7aURaF43Vybgss44kCjobCAcegvlm3anXS2Z9vfT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idLMGeGM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso2752734b3a.2
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758474526; x=1759079326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AosUgctyk0Qt1mPt3eaELkb0eU1eJkHfAr6DxGd6drg=;
        b=idLMGeGMFWaFiWIy4D4ZwFH5YK5bWmYXpb6GVzOSe9+l79+s3pU6wICDp+Qfka9KZ9
         uljIyca2I+9Ksnl37QXpxk7NDCyCQ59HmDWQrYq1QgkPITHCW9A2GK58h0mpimiWvoMH
         BJWqr+CpIyka4QvDW85hpGaYYssOfvEosM6nFLFCJikOBvRMxry1H6AuhOo7ltc0mj9o
         6UI2gCqCXVWrP6Jqb14LvNVX0oyuzMrmULsMFGWrqaDpuwZXoG7qJGMZJHh4kTufHOPe
         o/Pdz8UPjoQC4mLbH534zXc+4REJjq58A5qbn4MBpFIMito4tgUOdvaa7Yc3Miq5pIAy
         rqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758474526; x=1759079326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AosUgctyk0Qt1mPt3eaELkb0eU1eJkHfAr6DxGd6drg=;
        b=TF09JrzJ5IPQDwWwXj46SFB30F3UhGPnIh4LrbdXfOn2hChL7+p+9wnKZ44r1od5OT
         wH9ZTqsOXswYOaILH1O5q8wlKnRi+ZZfqGomuh+IOzsQjug4mixkAvjZirzYGsez1RB5
         03yQiq+4r+fSQcyolZnC4UdvokhyzUWxsl2DHHPrM6qxD/5pWTdX0/8MgpIlkOIwG4NX
         PlF1Ntgj7SaDIRNrgteYqTAhBqI4EE5i3qbtqnxWsHeuWnNHK6N5AH4C19p7oyCYcXlV
         8VKKfF68F7Z1mZL7pgDoeg/4PEEyKdMYVRgWBk+BZUpHHlNzHbtIp+FE0H4ovj8gPNvX
         Ey1g==
X-Gm-Message-State: AOJu0YyEnNXJlkEqS00o7G/XUg3SwHjeUwY3DQDigZQUVwhnaMaolwQa
	1lCCWb9k0nsK1ODpxqcCqdTZMFrVm3XaAXtQAqDre85VxpOHIS9yGciF
X-Gm-Gg: ASbGncvcOBdyjzyxMwZo5KSGSFJqALn85YWM+gBH2ZcupccnCDCeKiFdbYtJzQdz/An
	xvq+ACz9C3bqT1wvXGrxcU0D8WUq91TQDz7HnwHIZdizXtTGTc+qB3K4RnpA6ttAuhF4UwLbDXt
	VnyOFE6w+C7wgRlGScDW1fVITsXx4Q/+q2CAh/QAbHaNSqa5QGabYS+3Q9sA+KZTu/1tZno2f1P
	Isfof2M2RnFclnM29ZCLg1p1+DYSDPqaDMGoHdFGqq7wUV40WQ0uPN+AWQUhUGCFg0aDuc8J7Ln
	HBkb0Qtwkck/zGH37cf8nG4zt1pQma8aIicK+iXo0MBqGCR384A16A7q70EjVBxkBO/tTC88Nae
	ODGaPEmBq9i9zH1uqJ5j8DAb4
X-Google-Smtp-Source: AGHT+IEQ034Dvlapqua1Ol0l76xVGanSAHuXZKyAmv1ht8l8P4mc9lf/Zvupo6s8uK1lRZkuCiFDlQ==
X-Received: by 2002:a05:6a00:4502:b0:77e:f03b:d49a with SMTP id d2e1a72fcca58-77ef03bd586mr10241915b3a.19.1758474525898;
        Sun, 21 Sep 2025 10:08:45 -0700 (PDT)
Received: from archlinux ([36.255.84.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77d7b79bd7fsm9701096b3a.77.2025.09.21.10.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 10:08:45 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH] selftests/cachestat: Add file tmpshmcstat to .gitignore
Date: Sun, 21 Sep 2025 22:38:31 +0530
Message-ID: <20250921170831.71609-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tmpshmcstat file is generated with kselftest run but was not
ignored, leading to it appearing as untracked in git status.
Add it to .gitignore to silence the warning.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 tools/testing/selftests/cachestat/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/cachestat/.gitignore b/tools/testing/selftests/cachestat/.gitignore
index d6c30b43a4bb..abbb13b6e96b 100644
--- a/tools/testing/selftests/cachestat/.gitignore
+++ b/tools/testing/selftests/cachestat/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test_cachestat
+tmpshmcstat
-- 
2.51.0


