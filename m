Return-Path: <linux-kselftest+bounces-22083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18829CD68A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 06:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53EB9B23F32
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 05:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FE913FD99;
	Fri, 15 Nov 2024 05:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh3/MtFI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D94653
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 05:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731647896; cv=none; b=RwcU5HI/3MlIBO5/CsPXm0+qKpo/KUykTgwNPbvOyo3/kmZlFtxt1Q2p5171+T7SSNoTz72YEYYk7GlYfG4/PAV60xHMqfZJ4l4iUVa1EgTkfzXWzIg4SHMhNp1bygTouukGlP5RO0ijX21DTnA2ieaoglEmnk1ndzDoyqAsGsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731647896; c=relaxed/simple;
	bh=fe4AbTh08+f+QMvX8dteNLGb5/2oj8HLiWRCL5RzffQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=evYzFIp1QCMmQ6DpoipzkeGuws0PrROuDa3EXdusiCF4n8OndB/C/CDWDeZpoQy0pTqIacN2z+oDNPEOXlRghEK+SYm/HuKwhORxuhismIksEFVZdMnwYAGCiW0q2auvzUlbZ2rxp39Juo7bN4OuXEPH8VekkibHLZ/9on4+BLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh3/MtFI; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-460da5a39fdso8647651cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 21:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731647894; x=1732252694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ie2FW/VJDvZkChPXP7C7pMU2h/b4R2lnjAWDNP8G7Xk=;
        b=fh3/MtFIegrtQTiCCNKcuUQAIQbQp1bouB6t9puzG0WwyeyBlXIT9B+5/w+Zy7oVeh
         bYfi5+TPPDmTjg+wpnrI4ueAm6/mfBS9JywYtf5l1op/6+lNB/zAsAwAyisTzlufHB37
         pvhoh2Fk4gCNCnSQ2LB1LdyS5dflngnxiQCD+ZXhyKE4cY4KnKRk5cYTSC7tCOzYXNuN
         jptZqrfzrIYiLOZn8jiE1D5+fwBiCQjNY1i/PQGhISnwoAhGfYoUtanmWuyx4JQYGBag
         bFRd4cLBWneAF76pB+Cm1aB21lpwkOOH8TxN/frdJOLNqatyzlaGcja+qnBMb1lbXNtP
         OygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731647894; x=1732252694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ie2FW/VJDvZkChPXP7C7pMU2h/b4R2lnjAWDNP8G7Xk=;
        b=ZdT5W69np6YcfoPm4bV96JjnftIZSVgEkGNeMh0mtEgjxy5krQRwMmMLrhT4Go827x
         +kJ9CeghYSTOr3wvBej67t9ro+LL9aFJwXkJuZos/C7rZNuDRB/RN2dBuIZ/Kh8ET4hE
         aWGBVaFvPi9/itWJkqCDl5dyPFz6/iMbx70Gfv5E2j1BHc1+dDI71y3epW5hT1ib/2LT
         oDzzPz3md0/flbS02gGMQ+f5PUv4lmsvpeQpMaSXNr5LCOwtAmF5SRQas+fqb07SVQZv
         NtYZl21AUa4k8OxqlaSkEg6Kl4sV4oPlyTaXuZbUWT/22Eitq6qGKZR7CDbs4UGbcdlA
         wCVA==
X-Gm-Message-State: AOJu0Yw6Ezi79YDHO5qTkxgM5DBomcx2y91JUy1P5wsctPYTWjIuh++H
	mM2WMCaNqO1DPyMx07y2alvJunzZ05Ajk3ngGCKUvtch+IPR4tEF
X-Google-Smtp-Source: AGHT+IGqMosEokKofG4uiYMgmJnYojLwPFCsYroszdMPo0mZGEcZpkhl2K/Ck76YngnXcbXhIB3CPw==
X-Received: by 2002:a05:622a:1b1f:b0:461:17e6:27af with SMTP id d75a77b69052e-46363e2f7ddmr17551681cf.28.1731647893799;
        Thu, 14 Nov 2024 21:18:13 -0800 (PST)
Received: from localhost.localdomain (host-36-26.ilcul54.champaign.il.us.clients.pavlovmedia.net. [68.180.36.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635a9e97b8sm14886981cf.25.2024.11.14.21.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 21:18:13 -0800 (PST)
From: Gax-c <zichenxie0106@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com,
	mripard@kernel.org,
	skhan@linuxfoundation.org,
	mazziesaccount@gmail.com,
	gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	chenyuan0y@gmail.com,
	zzjas98@gmail.com,
	Zichen Xie <zichenxie0106@gmail.com>
Subject: [PATCH] kunit: Fix potential null dereference in kunit_device_driver_test()
Date: Thu, 14 Nov 2024 23:17:46 -0600
Message-Id: <20241115051745.14404-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

kunit_kzalloc() may return a NULL pointer, dereferencing it without
NULL check may lead to NULL dereference.
Add a NULL check for test_state.

Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
---
 lib/kunit/kunit-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 37e02be1e710..d9c781c859fd 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -805,6 +805,8 @@ static void kunit_device_driver_test(struct kunit *test)
 	struct device *test_device;
 	struct driver_test_state *test_state = kunit_kzalloc(test, sizeof(*test_state), GFP_KERNEL);
 
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_state);
+
 	test->priv = test_state;
 	test_driver = kunit_driver_create(test, "my_driver");
 
-- 
2.34.1


