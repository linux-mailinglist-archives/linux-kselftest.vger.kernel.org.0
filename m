Return-Path: <linux-kselftest+bounces-39056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C76B278CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6E0725A73
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 06:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6E425522B;
	Fri, 15 Aug 2025 06:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Roj1kmnn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32DC233722;
	Fri, 15 Aug 2025 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755237998; cv=none; b=W58nqP9w6d3ttiCY8Q6KhTnasVvZqWvv3VwwBNohmQBIs48Qsf5rknu9QwzJjLxBC5ct0xcSqUGF3jrb5tqATaTnRyQAN3M7RC9JUQfAn8ygN+r24O0moS2mN0E13ds1rYtzvXKL42Z0EJIXVkRg0JupnhOkWsCU8wYu16kYAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755237998; c=relaxed/simple;
	bh=+t21P5Dq36ra1NNcZNgf00aFq1elCkbJ4E18iY6rPTY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZtxEZR2xDL4YMWvUKYTJ2GuqRnUwIp+30fAsHsp00VSDnui6sfBv3LBj8ogXUqvH/jBmu3flRddEFJQG7sefEVJdgGBcb2n5FOr/GcyhIcxsnT+P6KACLLUMsovCzVHEJ4Oa9/O3auDjyjnLX18hIJu8kIwPmCfqixZKgFxsLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Roj1kmnn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-244581cc971so22806125ad.2;
        Thu, 14 Aug 2025 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755237996; x=1755842796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7wnFX4dVpGg23eTIugNUAHrzZAdGhjIxcbXbnMC1Z4s=;
        b=Roj1kmnnadIL5dcKTLRPHgSPjcsOVXuHeoynigikKSoCJlFK5mzA5ZBN8/rB7ChUy2
         BYDH8PwFqvA96ESVNQR8PgetSdJrn/4RSxyoD5ahiUXAZC75Sw2aQHV60uhPb+OhYXDA
         +KLZvGEYw1iCa7p1p/ZLYFWTGoqaoUTXxPWzf61tR46jM15ogU2w97H8lzwJSA4BXOJU
         7YMgRO5GmDhWSAZgNxi+TsudHZA3hVBfpGNs7Om/xzFxbCpHHhw0VzPm8zcC6sEjtVRT
         8qnZiozPsjV56XYItXiiaSJhzZkC+LYP7bFrmCFjCSVRM5nYlP9qAYe6AbDyUR3b2P6O
         NF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755237996; x=1755842796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wnFX4dVpGg23eTIugNUAHrzZAdGhjIxcbXbnMC1Z4s=;
        b=cI2OxPzdO8eUgYi5EYefdYLYeoHHkQJQhSq9sYwpWeHxDelDvrGwbsmZQTO7gw7T6t
         Y5iimpAKS3vlCmOs3vzQzUxDuP/d43NjFdhv8sWaipMV5jDROKaAORoBMtM6Vb6o9C9p
         tiXANqnI6jMjU/yxcS+BdXSnLv/rKo7E1M3ATDU2mR6m/7zT1RjAki5l1QXJA7BvPXR8
         jHPjp8yeapZsHLJgbBfOdCAakOj4xTX9VKKN5kJJzoj6WTDtNvXXf8yeLr7URHBQBUoe
         nYL1fd2YK2O4AleQCi6JQoOV/Hm7Wb+9BKsfdHAl7kf1Xi4M9dIwcgt3NcZYIXWMsxM6
         chdw==
X-Forwarded-Encrypted: i=1; AJvYcCUHvjuX3OZpfpjPiMst/GFS7fnI7Wqh0evE0Pxu/YOxmvD6bLt0npOvEbt7llGl10y7rXBH7gcNsXznxT4=@vger.kernel.org, AJvYcCVexkTAAPWnqUTrAxH/Ie4mDc/g2PTIy7zxHPnOLxA8xJIh6tfKar9pH/qx0tz/qi4E06ITz/tU@vger.kernel.org, AJvYcCVprdibnGKBcRBALj7oxaQkhfnUKArbpOUJZ1tSKUy/euBZkxsBmmvjgs9a457DVNhbDpIG2hfcZ7fTcOXyYY7p@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJvbq/hp8TdudtGjBkRPq/5+7No4WEDHSmU60O5kw39AQguJF
	PaMkF3ysG2QOYPhsRHbWuxxoDbwiaEHI4w3hn12E3DQbzt+VVbOP16l/
X-Gm-Gg: ASbGncsUQia0ZWct4O8wubjHk/h2ANMEctObqdWkdBY6cT7PpYxxHvRBEjFNUPRlwmS
	Y8M32WjJbKBOz4X3UjQehT6BaHOk3MQJqhEtIuvfB0tOGw3Oj/sikrWoS2ucgatSf61GnkiR8Rg
	4yVhkOaqqQZ3WTQEAsnFo6dJwzdpTAL0RmxG31SwVgj6mYuWBoJDrK17Ss3/xFztPDlSMIkJ/GL
	bTmFjE7z0hfR8vurK2x4jYUhJPJWDP2bs+ZTePOH5C/sTpO6zr46go+C6NdL2xlzbH3WIaYKyL0
	frko10ZM/Lt7j25eLR8oIUaeyUJEFaJ8CjFFIUR0yrgalmJnJZMo+ZeN2e1JdjRtxv1t9/qsaMu
	yg2ZLw5Y80md/zlUK+Ig4Lk2aBM5Uvomx3Q==
X-Google-Smtp-Source: AGHT+IEQrWYVQ2Dv3PkzxZHgpGvIYrinZ3s8vwr6SVMAI7nuhx64Dihzv2UE4V/596RhIWR4wvlIJA==
X-Received: by 2002:a17:903:41c8:b0:23c:7c59:c74e with SMTP id d9443c01a7336-2446cccc62amr15511485ad.0.1755237995903;
        Thu, 14 Aug 2025 23:06:35 -0700 (PDT)
Received: from pop-os.. ([172.59.160.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9d037sm6546555ad.14.2025.08.14.23.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:06:35 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH] selftests net/socket.c: removed warnings from unused returns
Date: Thu, 14 Aug 2025 23:06:31 -0700
Message-Id: <20250815060631.144471-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

socket.c: In function ‘run_tests’:
socket.c:59:25: warning: ignoring return value of ‘strerror_r’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
59 | strerror_r(-s->expect, err_string1, ERR_STRING_SZ);
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
socket.c:60:25: warning: ignoring return value of ‘strerror_r’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
60 | strerror_r(errno, err_string2, ERR_STRING_SZ);
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
socket.c:73:33: warning: ignoring return value of ‘strerror_r’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
73 | strerror_r(errno, err_string1, ERR_STRING_SZ);
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 tools/testing/selftests/net/socket.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/socket.c b/tools/testing/selftests/net/socket.c
index db1aeb8c5d1e..7c597c583df3 100644
--- a/tools/testing/selftests/net/socket.c
+++ b/tools/testing/selftests/net/socket.c
@@ -39,6 +39,8 @@ static int run_tests(void)
 {
 	char err_string1[ERR_STRING_SZ];
 	char err_string2[ERR_STRING_SZ];
+	char *err_message1;
+	char *err_message2;
 	int i, err;
 
 	err = 0;
@@ -56,13 +58,13 @@ static int run_tests(void)
 			    errno == -s->expect)
 				continue;
 
-			strerror_r(-s->expect, err_string1, ERR_STRING_SZ);
-			strerror_r(errno, err_string2, ERR_STRING_SZ);
+			err_message1 = strerror_r(-s->expect, err_string1, ERR_STRING_SZ);
+			err_message2 = strerror_r(errno, err_string2, ERR_STRING_SZ);
 
 			fprintf(stderr, "socket(%d, %d, %d) expected "
 				"err (%s) got (%s)\n",
 				s->domain, s->type, s->protocol,
-				err_string1, err_string2);
+				err_message1, err_message2);
 
 			err = -1;
 			break;
@@ -70,12 +72,12 @@ static int run_tests(void)
 			close(fd);
 
 			if (s->expect < 0) {
-				strerror_r(errno, err_string1, ERR_STRING_SZ);
+				err_message1 = strerror_r(errno, err_string1, ERR_STRING_SZ);
 
 				fprintf(stderr, "socket(%d, %d, %d) expected "
 					"success got err (%s)\n",
 					s->domain, s->type, s->protocol,
-					err_string1);
+					err_message1);
 
 				err = -1;
 				break;
-- 
2.34.1


