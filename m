Return-Path: <linux-kselftest+bounces-22085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A409CD69E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 06:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94821F21FDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 05:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5D117C7B6;
	Fri, 15 Nov 2024 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4BTtfDo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A88661FEB;
	Fri, 15 Nov 2024 05:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731649428; cv=none; b=ed9Tl8FhtTlyuHfRINkdbcG6mz/v2Bvyqv+PF3i8DCIBxwsocaH0TZHUoyniqwnPftUBjSytyiHFIXWXoXPIoIOi312ljJ+QTuPm8uJYbs8hMsKy9fVy3GNnDbp+J5WO08m7eZPwEU5+dygSVSn2+b7g4F/WXMs0BFPQCJtIXro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731649428; c=relaxed/simple;
	bh=3ByWw0uZzeWU6sQuLd7KUVUeRoLijI8eX6T8FD/VPLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J1+hpFwzYwBNuRGj+7+RQQkkTNt5PhQIKlHYURV1/Lu9hJeUfQyUWHZ9qWAoWAB3+90WPXzox3xOfDu8WbgoZGvHTa57s5ianvjyse8mieVK6WVjdBv51aKZCmXGvmQs3vWvZ3vZMBHY3xfeIquNbjTt5i+p/M1nv98hMjYO8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4BTtfDo; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-460af1a1154so2530981cf.0;
        Thu, 14 Nov 2024 21:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731649426; x=1732254226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5OyuY9iIrcaxMF1N8H4QFXUlmBkIEkyE1LHwMV8vrE=;
        b=i4BTtfDoA3jA+RiUusqieHrAoUPZrqpaW0PxlMuPNAZdti/6XQ7rPEgv8F8067y7SY
         ByW0hAjpLQupoccLHaA+MaHNRL5B1rwQNwm1BXVgvIN+5ncj2WmiSnUSFmVl+bEgEEMN
         a8ohAixb0qvWKeXY84n3xPZLGN76EMp5smrfIDAMlCv9G7tLuTrsphSwNHEOrl+qymSG
         YNBj7PaBw3Bb66ItthUhmxtgq1+Y+CoOdiRNDnsuFLQcgdbIvmE6+mfa2PzbrfHZtCDk
         a2LNYq2fHtpt0ko6lgKf2ep+yALlBZMunUdHWCgva6X/uqZ6v+K7F18Wbhg0B41PEr4V
         jtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731649426; x=1732254226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5OyuY9iIrcaxMF1N8H4QFXUlmBkIEkyE1LHwMV8vrE=;
        b=MECylehTsgcgnnfalKmtZDaFkemueg3ciQfXv17xo4u3svNIIwwgJN0Jk5ztfYOZFo
         wCaKmi3pg4jTrW/uCLdpmN9QC4IikUO18xWVz+bbNkPNOwiyCS2KWqZrasiie92r65uc
         sHFJFtf6I8eFqwrWmkWFQwKppkQwUZdRsiqKP2RqR7l1gx6l8oCF4qxMqjTVVsfu0L6F
         nZ7WHr9u20Sg9hzxGMAN5MXlTQnkjCF5ZYc/rkIDmCIhta+XFLZxAws5FUnSS3qypxVg
         QDUmGyuV0rUDliexAcJcxprqpxKqdgj5f59wJ6uVuQXPZmEZT9FViGIWPdRntWpOEoGO
         yx4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDvtX0J0YpyayG1uqvaA13hOImcfL8l3EcdzUFN8ZSiDcmkJCy32rQiuNlZN1micu3AH6DO/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2uvWWpbuuc96mwmKg1XrZFFBeqMcS6Dp2Ncba6F9FuUN0d0RP
	nVlvm2vTOVmOsQO+XHotwMhBSQ5SRaqwQfokPg9TF6LtkOvJqimT
X-Google-Smtp-Source: AGHT+IFAKLPkZQIiegJHxrs865nk7E/YbQ+RWexoKdKdk+xlx7iWEH5fr4i3vshDgns1OwWzk3LndQ==
X-Received: by 2002:a05:622a:a0e:b0:462:ac16:e72f with SMTP id d75a77b69052e-46363de90e1mr18699631cf.8.1731649426010;
        Thu, 14 Nov 2024 21:43:46 -0800 (PST)
Received: from localhost.localdomain (host-36-26.ilcul54.champaign.il.us.clients.pavlovmedia.net. [68.180.36.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635ab24e2dsm15092001cf.60.2024.11.14.21.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 21:43:44 -0800 (PST)
From: Gax-c <zichenxie0106@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com,
	mripard@kernel.org,
	mazziesaccount@gmail.com,
	gregkh@linuxfoundation.org,
	skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	chenyuan0y@gmail.com,
	zzjas98@gmail.com,
	Zichen Xie <zichenxie0106@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] kunit: Fix potential null dereference in kunit_device_driver_test()
Date: Thu, 14 Nov 2024 23:43:36 -0600
Message-Id: <20241115054335.21673-1-zichenxie0106@gmail.com>
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
Cc: stable@vger.kernel.org
---
v2: Add Cc tag.
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


