Return-Path: <linux-kselftest+bounces-21892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994C89C636C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 22:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3889B87AEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 18:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89AD216454;
	Tue, 12 Nov 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZBUXlNi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977E215C62;
	Tue, 12 Nov 2024 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436110; cv=none; b=rMWI3ui2pEZHLrRgyevF+iJPgBuf/hoELVgi+tvdiNPsJReH6dP8t91uY/xs4M5KW9pKMJbHdLWW9wg3bB/LXAe2JoVqSC7Rj+o9r2nQJzhzoX08BdPaWaZMeciumEu0m0FcM0PvYeBI8xO2ZNNFmbzjhR8mFDkW1mM1/Ded0L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436110; c=relaxed/simple;
	bh=dZbDMAUdLbxNNQpgzzFwvZxHCF4K+0N0LYW0Z3+EY0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V29F/a8cQZxEv2mgwYlh7fxMVniid6AupbbcBbx2dp8ZoaUDX8Ypb7U4DKBVSVmyyfPWRsPfXzf87vvUze9uIclmt1iTuV1XlmSp2t8OUEu+bhnyxNUCQk5O2mfnOD3LobWQ5WbLBxJVBkoF6YCEFz8yuXVVvFgJJQrGWO3yY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZBUXlNi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cbcd71012so70323285ad.3;
        Tue, 12 Nov 2024 10:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731436109; x=1732040909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xG9BoyCsOgxLRKpKuSPK8dWttGY6kTRBEqiurMHDglI=;
        b=mZBUXlNiXG9VAyShu8T4KJKSDJ0GbgNl2Cgn7lXugS4vOTh5/DwHgQLSsf0v7qDKVg
         zlRroOVun1522qoRgt3vRhAaJkhc86vFeXGBzsQARH8NLNDjPupbrN8Y1ng73gGIMyDM
         attsVvbaoEP0l+CX/apuGKsSaQL0cR5JaCZD7JvbqHppYxMBYAV2vjRZ4Zo6YmHqcWKv
         6WTpcEwALHJ9lmsFH7w61NQlUX8L8Io2cfuHRrXAzN1MsfRO0DJ1WD0zggD6FxmYsrlT
         QUScJWC5pRgQf8+/+7EQc2dhx+NQToUW4woncKargqSfWVR8vwWgLfgK2TdLYzYtgDod
         T7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731436109; x=1732040909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xG9BoyCsOgxLRKpKuSPK8dWttGY6kTRBEqiurMHDglI=;
        b=WhGkYch9PujtkycaC1l5XvCJ39NoSNjRHrQ2bP+Gmf9gISphG39whs/eTMXjgXIsaq
         oK5cUHh6LqaIdToAQYJJo7KDegitxrphpbQCjVhbk4htphdQ2xpkzYwXUwY6S9mxd4ol
         aULsw3IQswmBJJ7j6WG3JpuC00WcnUNJRz6hyyPHd2F2DdQRyr8EZqArSFrIBrO0Zozt
         wltZZ87RJBu1OFkqcHq289v6rPDxMhuDiSF1lFy4Q40YwOmjsjhL9vtlgwI96FxnSq7c
         BtEIdnz8Ptwx/y9TDz6DB4ipdW0HZn1jk10T4PCYXUZL7+gxT0bKsJaIDRW7Wyw726aQ
         /JHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnkmEWRzX1WXAm5F5QA/rSc9x070YYp7hkaWGOxs2VieiIdhCWJO3o+70e9co6m4eCb2bCrHehKaYN1pAgRn2KlxoIYhT7@vger.kernel.org, AJvYcCVGqpirpiFpaEvDr/q8N/GEqEo/4g/L54znbNLOqfaohjssRzSj0iCX2wzGOIm2WMIknPhP0ZRf5tzWjTI=@vger.kernel.org, AJvYcCXeHHpe0X9sDm47tVTGKyAOGe3E5QzisR2AqngNB4XwgHIq7Yj99uMOhk5odfqlaIqLaC1fgHJXxrs1/B27MSUr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa/IVPszVRnPBbMv4xImT2nUbuUy74+foV6QgAY11GR48sbr3a
	vuxlGsEru8Yx4OVeVMz5grFRTYvVHdMd8sV4PCLodqI+bW+6N8lQx6fMtj5F
X-Google-Smtp-Source: AGHT+IFuSJadtnFgM9MFW1vjwXlMMm8dIwqjw4ui+YdL0RTBFsiyLLHYGSeNc9iQfcZUC+POAvX7qA==
X-Received: by 2002:a17:902:f686:b0:206:c486:4c4c with SMTP id d9443c01a7336-211835c16b1mr192400855ad.57.1731436108568;
        Tue, 12 Nov 2024 10:28:28 -0800 (PST)
Received: from localhost.localdomain ([2409:40c1:5f:8acf:74ef:bde5:4fe9:96c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddf7e1sm97092525ad.106.2024.11.12.10.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 10:28:28 -0800 (PST)
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
Subject: [PATCH] selftests: lsm: Refactor `flags_overset_lsm_set_self_attr` test
Date: Tue, 12 Nov 2024 23:58:10 +0530
Message-Id: <20241112182810.24761-1-av2082000@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Remove unnecessary `tctx` variable, use `ctx` directly.
- Simplified code with no functional changes.

Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
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


