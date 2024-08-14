Return-Path: <linux-kselftest+bounces-15300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA961951629
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 10:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19E91F23E95
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 08:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CE813D53B;
	Wed, 14 Aug 2024 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMmoE7Uc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404BF13CF9C;
	Wed, 14 Aug 2024 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622874; cv=none; b=jHEm+frmxaeAURwGIYHiQJiuMK9fkCE+mmCRTGShZaNWkxnI02MowyCo6SC1hGtCbdSF+gCmtGtS0P/wqN8bbEyl1IMrnOgpy+lo7Ywx/8eT0VjLy6t9X2EGCnU0F6df9ujIKZqNFH3TuQBeEn9G4HmV3Q6GtTF/YNuheUW8d8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622874; c=relaxed/simple;
	bh=fSmGcfk+8uGm4zMBeULqYqMo++xe0eaoUvNfKc3OcNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Y6HS8Sy4zGNlB7Az4JV2IicWiPi8lJ+9IUp88Fx0bp1L0+++VAjvZtpjfsF3ZxgqDIcBp05iL/oVrNzeNpM3IdFJTnxcL/pWYOsE3NVcqe7eJpSlDWryI7qXIa3Wi+OodJrqoNxU27Xso9Wq4r0kSUgfmqdw5Jtl5y9m5A/qE2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMmoE7Uc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70eaf5874ddso4906155b3a.3;
        Wed, 14 Aug 2024 01:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723622872; x=1724227672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fef42UR6It/UaqpEHIGzkJSR1hTEAUAeandZLB73NeI=;
        b=BMmoE7UcB6yCTLagZ5qPOpZl7DF/5RasTnnlQ76rI1FrvrDv6JhjADaMK1IdoQmMFl
         8OUxk4r0Maq6H61iQd6Ei0v3trtQ93Wjw8BEUvc/opWyZtVZ5mQWPpHSJZpwRK++7dLN
         XMuMfOVQsMeJGZVyJaLGtX28O8ElXO/oe62QMy5AoYbpfbnVmW3YAwxHzJ/xTyOVIMaS
         T3/IO7Sqig76N/WKpmLf4cQxcCcxMF38z0zFr9p/8n8+XZQg89Uy1BWF4YWuOIey+Gtn
         iBCESzV600khDg+qNnuNw0qwu7FkTCITy40+kzxKNueSMqp4RGaiQ7HvpPQQXKr6sFmD
         lLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622872; x=1724227672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fef42UR6It/UaqpEHIGzkJSR1hTEAUAeandZLB73NeI=;
        b=XgdvLXWfbaLJ6inohzitwPk1S3W/ZXUdJVjJE0FECoQ+YSplJz8dKkgiyM5Z0cy200
         m4KTH1IchLqoXVHZFiIszT/ee5CCSH/29JHwolJnUPW5obr4mPqG0pojx5O4Qhdp/BLO
         AAD9diB80jd8jI2Zb3+DBlcD/CIaVcoPM5Aufgm563VEGQ7G0GykAk2K8Hx/G/DGl3tQ
         aGah8Cl94cjlFXAbLYv9sa6jScRCK4CALzJ0u7fvaQeHBmjemhUagCxyQaOhzErFvpCQ
         K9LyDI9UWlLE2X0bgO0m4PehVTHpFsMQ+vyFi+eMmT0GxqX70pc/yzuREFObKymz52iE
         G5kg==
X-Forwarded-Encrypted: i=1; AJvYcCVL1AP+pgXjPHbgaYkvB/bCwBUOHLvIebVuZ6bRFD9PMH4xx3Bat5IDcVi7cTN53euVCAQJ5jYMksHaYUngpvIwjXyAsn/kgcDClOuxnGtOS50vx1xi/aXi6NPmnIEvnqeWGDQC35zHr6CqhYKBeO3IZhHF8zaslij9gEYHKT2EQnzfjy5O
X-Gm-Message-State: AOJu0YxVXe7iflXh7+6CbKuFKfc3vAaVFIEyz58OjzKyeiFi3vXsp6et
	OXY7PUK4dyJFtYQUQoHForbTvNYZLCTEL/CZ5+1Qb3n7Pi2qz1HKDdlTCy2g
X-Google-Smtp-Source: AGHT+IGdOMKJaIdJ+cga48K9Zc9nrmH3vOFZU6r/8wEyCIQ2STlod+CckhrV4Ps4TpXaEVfywvdB9A==
X-Received: by 2002:a05:6a21:e8a:b0:1c6:b0cc:c448 with SMTP id adf61e73a8af0-1c8eaf6965emr2684901637.43.1723622872455;
        Wed, 14 Aug 2024 01:07:52 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:1250:5301:54db:4816])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a9394sm24540955ad.147.2024.08.14.01.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:07:52 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Abhinav Jain <jain.abhinav177@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net v3] selftest: af_unix: Fix kselftest compilation warnings
Date: Wed, 14 Aug 2024 13:37:43 +0530
Message-Id: <20240814080743.1156166-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Change expected_buf from (const void *) to (const char *)
in function __recvpair().
This change fixes the below warnings during test compilation:

```
In file included from msg_oob.c:14:
msg_oob.c: In function ‘__recvpair’:

../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument
of type ‘char *’,but argument 6 has type ‘const void *’ [-Wformat=]

../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
msg_oob.c:235:17: note: in expansion of macro ‘TH_LOG’

../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument
of type ‘char *’,but argument 6 has type ‘const void *’ [-Wformat=]

../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
msg_oob.c:259:25: note: in expansion of macro ‘TH_LOG’
```

Fixes: d098d77232c3 ("selftest: af_unix: Add msg_oob.c.")
Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---

v2:
https://lore.kernel.org/all/20240812191122.1092806-1-jain.abhinav177@gmail.com/

- Change the parameter expected_buf from (const void *) to (const char *)
  in the function __recvpair() as per the feedback in v1.
- Add Fixes tag as per feedback in v1.

v1:
https://lore.kernel.org/netdev/20240810134037.669765-1-jain.abhinav177@gmail.com
---
 tools/testing/selftests/net/af_unix/msg_oob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 16d0c172eaeb..535eb2c3d7d1 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -209,7 +209,7 @@ static void __sendpair(struct __test_metadata *_metadata,
 
 static void __recvpair(struct __test_metadata *_metadata,
 		       FIXTURE_DATA(msg_oob) *self,
-		       const void *expected_buf, int expected_len,
+		       const char *expected_buf, int expected_len,
 		       int buf_len, int flags)
 {
 	int i, ret[2], recv_errno[2], expected_errno = 0;
-- 
2.34.1


