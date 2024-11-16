Return-Path: <linux-kselftest+bounces-22140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E23629CFF72
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 16:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D1E1F223EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F52616426;
	Sat, 16 Nov 2024 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCxsw2l0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14175D529;
	Sat, 16 Nov 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731770542; cv=none; b=jTesPeyTvvPfusOGb19CPF+m7euyHbnoJfjM0sPPgmYqDJrFOUKZFO4GRaLjoV9qiCo4NCQ0zo9IMjMJwMl8Ev3TKRNb9+aGgotPNJFnamg6S2a6hqBJ7orj0zWyhU8Dr+6UqLp60083bF0ga+a8kF1ioVrQ4fT4PqM2vO9VBu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731770542; c=relaxed/simple;
	bh=MpL+upqOZd7d4d40IzJdOiFOgQEz9KfLXIEqxaBfR40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X3vUVnf/KvRmUj7mN/eWj4MB5EKdxcCHhbAZ4a4QdUHkszcDdOuLIm1s/fy9vriwvm/KecKLuxWVGBcOFdKyStmAlE5aSlyPozX3P96ETZYrelIDpokwCcddI88cUK229x9fkbhkMbMAoYM2SUKBKPla9Jvg0grvk76luEARXuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCxsw2l0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so403942b3a.1;
        Sat, 16 Nov 2024 07:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731770540; x=1732375340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Go+eSgpe+tKrY2K+LjSpwcwjHDXzUmcGaX6/+7p/Ws=;
        b=jCxsw2l0pLzSJxepix73F7x9wYphhHbLvcRUOJEcQBypUXK0fVtoice7WanKlt/oOy
         jho5pHnx9B899QEW7/CxNqemZq6fIyzzhkk07Ftg4SlplCFH69On/m34ZCZ43CBaaGvx
         BACkPVmTurvnjeFlC3kWfGuVNdGc6UCSJ232diKy/+I5TmwISv8VnYQqw+GJQ9ce/F2V
         aW65MCYlmd9uyWqdOQIZhfliXUOTvKK85MJFTL79P74wBKSJWW4EA21ustLNmF6NfaYj
         LnCL9DBCGkcORafF+qMKOwEuVazLGwyMokPmPAOLn6gx6Ttkl9+ZpUOyWr2lmHh1cuxo
         Tdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731770540; x=1732375340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Go+eSgpe+tKrY2K+LjSpwcwjHDXzUmcGaX6/+7p/Ws=;
        b=ZQ7tX+g/fExP+rvinFWsTI1pVRBaBIgyniVRIdQeiM2vbuuAUGUFFjZkn4pQHwsfPs
         sk530wOUyNP8cVfmXOcot2j5YMlpwSfOYVqjnxF6CqeBTSA4XsLwFKTUQCsoG3HSb8hy
         4fKOegG0zxV99jRgzWShVgun9xVXKuwu7hrtePQ8V3HbONbob3fh0veZpGNowpQ0gV8R
         v2zdrTmNvv7nY+oKfjiC66QOOD3ygKnWLTwvdw3Xtx3fqG1sf+1TIc0tv4GyocluT6lK
         0Z1tkXveEUuOvC362TgjMRZutnLYuirOtMIzuR2smnP8mt26dX2HvTDYIJ7wI2DjzYU6
         zjGA==
X-Forwarded-Encrypted: i=1; AJvYcCU5FAtrRstU9cf1n0uF/bEY9avFG5BAOom9bDA4Q2nFBKYHTh6GVypM7+cHUyXaVPvGadwiK/QEZRLcgidmV/xjapUbYhTF@vger.kernel.org, AJvYcCXK8a4RB7Q65V8gT1QiwHla+RQ7bFQRzjHmaV2eXdkdkbu5MvXakKNBUQzvgoEtsyAzec/+Pj/YeQ5QXpo=@vger.kernel.org, AJvYcCXvwwWsUwax5Z0SNMxe8Ri4phHTQJR9lOY1mpsn4G/eiaYTz8sl43lSuWLwmT5DybqW/bQ6/hTTnkXX7l6dnnHU@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQAev8ypNIq9dAwvF0yjSxB0iumkF88mz7cFmK3j7K1FlY9Np
	9GW174B3AFEvd0+yuct6anA7V5yByXmqJAUpdLqQNlsr35NpTzi6
X-Google-Smtp-Source: AGHT+IHBJfleNb8oAXjhQhiaYK2sul1C07n7oMEfBnTVPCi+Oq28Y4mAwGcoJinQBhTp5QRf545+tg==
X-Received: by 2002:a05:6a00:1307:b0:71e:a3:935b with SMTP id d2e1a72fcca58-72476cf6e21mr9046572b3a.25.1731770540364;
        Sat, 16 Nov 2024 07:22:20 -0800 (PST)
Received: from localhost.localdomain ([2409:40c1:0:e383:932c:79f0:2381:e2d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711c227sm3191353b3a.59.2024.11.16.07.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 07:22:19 -0800 (PST)
From: Amit Vadhavana <av2082000@gmail.com>
To: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	casey@schaufler-ca.com,
	shuah@kernel.org
Cc: ricardo@marliere.net,
	av2082000@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] selftests: lsm: Refactor `flags_overset_lsm_set_self_attr` test
Date: Sat, 16 Nov 2024 20:51:36 +0530
Message-Id: <20241116152136.10635-1-av2082000@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the temporary context variable `tctx` to simplify the code. use
the original context `ctx` directly in calls to `lsm_get_self_attr`,
eliminating redundancy without any functional changes.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
---
V1:- https://lore.kernel.org/all/20241112182810.24761-1-av2082000@gmail.com/
V1 -> V2 :
write complete sentences instead of bullet points in the change log.
---
 tools/testing/selftests/lsm/lsm_set_self_attr_test.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
index 66dec47e3ca3..732e89fe99c0 100644
--- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
@@ -56,16 +56,15 @@ TEST(flags_zero_lsm_set_self_attr)
 TEST(flags_overset_lsm_set_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
-	char *ctx = calloc(page_size, 1);
+	struct lsm_ctx *ctx = calloc(page_size, 1);
 	__u32 size = page_size;
-	struct lsm_ctx *tctx = (struct lsm_ctx *)ctx;
 
 	ASSERT_NE(NULL, ctx);
 	if (attr_lsm_count()) {
-		ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, tctx, &size,
+		ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size,
 					       0));
 	}
-	ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV, tctx,
+	ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV, ctx,
 					size, 0));
 
 	free(ctx);
-- 
2.25.1


