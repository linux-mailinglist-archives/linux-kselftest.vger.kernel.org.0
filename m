Return-Path: <linux-kselftest+bounces-22046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 572F59C904A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 17:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015781F2175A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E3518756A;
	Thu, 14 Nov 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei+SQWwi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF0126C03;
	Thu, 14 Nov 2024 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603366; cv=none; b=cHdTr7Mv4ahlv/QAC9WKEp6bLptstV1vLDdju/7FDAu8OFbdW/vhWdeRyw/b5DLtW/+rG/g2D7POeEyHfqguQJvycFNvzIpH7iyj/KKmF+8iH6c1ZTKC2sRH/YDNpuzSzcyAIAeHblFK3udbgSjnJJZVOGerAgdpofL5gRWt4Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603366; c=relaxed/simple;
	bh=bW24Y2zDBss5OiBEfJp2RH9+LgpRreFMxa7QcBNtfEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X1vnkkTvAy1i8q8hDIfZpwf97bXuNZV679tBUKeRmu+RF5NbjMLqFupw1vLDikaTVZem6ZMlpdPFMrQB1poRK8jnDzhIgI8flfcWqkol0MUIHyaNnBWQoXH9s+fQbgcAIem3eu/zIPXeMi7dtZcxnAGyuliRHv635IiK/lD9Pms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ei+SQWwi; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720c2db824eso803050b3a.0;
        Thu, 14 Nov 2024 08:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731603364; x=1732208164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dN6nOwa9jinNjS2kCCmOR1Y32+iqmTVvvvUdfcXy0mo=;
        b=ei+SQWwi7MqhYteep8nZfs3FmnmarZdBkuSQK0idHZ5l7r1Z5Dh1H66DzaqhhT1bC9
         X4gA7pm33GX2RIolQYYk2QTjx8/ULTdepM1lwsF2lWIFNbZebCU4QvSukYsSQdHV5UH3
         HPPUlC5SwNOFcgAFRk7+wsLFrvyicT5Wc9IPggXrl36uEUnDDZjmuQpPKmvYpTzvee/Q
         kSFiDzjRvbAHSwqmBn/esq8zLRpgptsvZ5QehIBvUkhagUgqdVM5zf3ThS0G7wQLSrH6
         VrE2I0WaSwrbwNHxUrd6/wszwBnJhi1u5f6cVdkoBV/rXYO9rEhl23OCqNNDguQl4JxL
         WTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731603364; x=1732208164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dN6nOwa9jinNjS2kCCmOR1Y32+iqmTVvvvUdfcXy0mo=;
        b=ct5hcvjlT4bAS6UUvV/CpP1ly8Alpgzf1TArh3xJu8qqt/Shsniu1Ag4Mmkw05MPt6
         X/Y8A4Dr/N4zHuPHjJYnc12ilxHD1VvhJETd0zjmT2uMMGj7AU9T0wBUIMiUDIN6Ba1V
         xy2zaloJ6EIhTwZkzsdjpNvTUO+9tPAj5Sq8oVsR0DZtlukeCkE/VTPl4CJUlMDrFJlT
         mZ1FZfpMPKy7VaTNoIa+oOGZ0STSQCuSRXGFf1VKiMZq7Uax23M0B9SzaQ2IvQjFc9sd
         GXDt08cAFfgsMQOWpPgzgIxFBhef2eDIwlaUS1rwdc1ufDFUgusUhG63CuDxsURD5zZb
         aCsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhUXaEr8OR4L48/UoQny2JzyIs20Ynm4JzZ2XXPGRM1A5NQOClfnREuoXqOf0r5w19uo6OUCPGMQfH6sqrSNnx@vger.kernel.org, AJvYcCWGVOtLwiw/UV4UjouInajOVnRypREICN9J1iQeJ8XP5eJnG2g6sGz71LhhMqFah/cHo6UGkOIu34yxgkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfT901uvBsfIe6yCwea6/Fc9q+/XDwc6yIFzBccQLABwMhocrc
	QMNKBOp+8IjOjp+xQoZ8DIwTbt9RqUcKJ7O1aDq6OYMvOgvKSfAac73Zug==
X-Google-Smtp-Source: AGHT+IErdRALs2OdOjsTFhmubjjx7yNbQ/ModPzFAI5VavhfJZjOxy4H/qdb3hT8L+66zJBeHcKpaw==
X-Received: by 2002:a17:90a:d444:b0:2e2:c40c:6e8e with SMTP id 98e67ed59e1d1-2e9b178eff2mr30608288a91.34.1731603364460;
        Thu, 14 Nov 2024 08:56:04 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f207d65csm2166102a91.1.2024.11.14.08.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:56:03 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: brendanhiggins@google.com,
	davidgow@google.com
Cc: rmoar@google.com,
	ruanjinjie@huawei.com,
	jserv@ccns.ncku.edu.tw,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] kunit: debugfs: Use IS_ERR() for alloc_string_stream() error check
Date: Fri, 15 Nov 2024 00:55:58 +0800
Message-Id: <20241114165558.49043-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The alloc_string_stream() function only returns ERR_PTR(-ENOMEM) on
failure and never returns NULL. Therefore, switching the error check in
the caller from IS_ERR_OR_NULL to IS_ERR improves clarity, indicating
that this function will return an error pointer (not NULL) when an
error occurs. This change avoids any ambiguity regarding the function's
return behavior.

Link: https://lore.kernel.org/lkml/Zy9deU5VK3YR+r9N@visitorckw-System-Product-Name
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/kunit/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index d548750a325a..6273fa9652df 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -181,7 +181,7 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
 	 * successfully.
 	 */
 	stream = alloc_string_stream(GFP_KERNEL);
-	if (IS_ERR_OR_NULL(stream))
+	if (IS_ERR(stream))
 		return;
 
 	string_stream_set_append_newlines(stream, true);
@@ -189,7 +189,7 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
 
 	kunit_suite_for_each_test_case(suite, test_case) {
 		stream = alloc_string_stream(GFP_KERNEL);
-		if (IS_ERR_OR_NULL(stream))
+		if (IS_ERR(stream))
 			goto err;
 
 		string_stream_set_append_newlines(stream, true);
-- 
2.34.1


