Return-Path: <linux-kselftest+bounces-21495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71699BD6FE
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F3F1C2278A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE07214410;
	Tue,  5 Nov 2024 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD5u6vjV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FE41FF7C5;
	Tue,  5 Nov 2024 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838409; cv=none; b=Uxn2+BGapZAQ9FQD82PoTp22UakKEbThZEK1V8Tqumnlwc1ImHPKxiRTelrPUKF0TQ/OiSNIIpWpX+6y/Qfud8sJzOxNYwBnpkae5/O6qAlNa6o5YKkYnWX2O01Pg3WYlHmvORnYIB29uK6QZCxr2j0nc9t9AzHU2N65QxAGCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838409; c=relaxed/simple;
	bh=emYiuEMLp4EGibNIiqHbQ0bdx9MrlZslCGHXmisEUAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ST5+qdLWhROuQbLRoVE5jd0Zhs0Me5WDARslSqXoneb3u9a8kDTZsN8eNL+jcpgIE7AasbfMQsr1skx4kLtQeGnRjFQRe5viHuMpP4JgMyBH0bPubsJUyiUWIzIulRk6kHDkhLqYwwecICnY5C+ALw1yMTkROyX4SlnR9SeqMOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UD5u6vjV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20caea61132so50762355ad.2;
        Tue, 05 Nov 2024 12:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730838407; x=1731443207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B1/x8lYAep/Z1k5LWzvxdewnb+BomgMKhQ5rhxqqpZk=;
        b=UD5u6vjVf69dRjp0FuNFMw4GzSSX6oFbQV1c8xnvfOljNyO3AVL8e4cqQtv83WvoKW
         vbCYA5T1YhdxgUNRLFpQHMrm9tWnepDcZ7TVGXqOKkbRG4VTDk81HFlLiPsvrOLMbosR
         QQBLXeoM3Au6s3m9D0uV0WJV53grHf4EnZKu9OfRj3EkkvyaYAQkCsEP1dZ0Fvd614T5
         VSxn0pcBu4cbsy+ja2JpFJZl8sbU7PNHuCk4RvnaqpSXxPHC+lvdwKmy6YK/orWAJvs4
         k++/TLcIOTjIIxuqNJATRkwyuEFQunBouvCEgC6WSufylCcburCCggNYRx6yX5Vxp0HE
         qpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730838407; x=1731443207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1/x8lYAep/Z1k5LWzvxdewnb+BomgMKhQ5rhxqqpZk=;
        b=ovFETYKwFLlsKvhgKaGCUUVOcZTxztYxae8s9NFrgwkzliWHDKHdjP0sSKWr25MeWe
         ESy65RpoCpsVM4ykpQdSbIj0nXpOd8IdAxRDGiI/9wv/KyKbggGpJofNbqZdAG+nEbZW
         Fj57znPpSIUebTbkAHDelf+gd/SnPd3tw8qyJKC0SC2B6Y5zYumSHoaMtG2F7QJoPJ/n
         EiNtwXCOooCej453gIv7fZRehWX8DTBdvEtAKeA6huPnlcK78HCPGLGwh/GvoD6eFxvb
         d/cOf7fgu3yAByRWT+p2XcQCy+H7iIRHUyXW70bOmR4KR94zyvU+7wKzmNalQyfj4N6D
         MhcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg3yBRht6bX/BormF4MsAjGwCsStHC3haTlfcet86rCHrqfXjtCqrUMxOIacigdmqbjNiueL9QYnstTQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyimo6af31C341mGz9ttbE8hsPAhF9yIi+Zhe1CTmw42IcEBREy
	es3Nfd7vUYuipb68C/g7Gpes1zqp07dei7t48wck9KeUnXn7FhiD
X-Google-Smtp-Source: AGHT+IEwhLEc2lg9Qi8QAqAg30Ribx3dHJHGjg4UR8Cz82RQUTYDXjudtz/yjoCJCwEuiusu/RUzzQ==
X-Received: by 2002:a17:902:e552:b0:20c:5c37:e2c6 with SMTP id d9443c01a7336-2111aec87d9mr219422645ad.11.1730838407282;
        Tue, 05 Nov 2024 12:26:47 -0800 (PST)
Received: from localhost.localdomain ([27.7.141.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edc65sm82640665ad.10.2024.11.05.12.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 12:26:47 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v4 0/2] kselftest: tmpfs: Add ksft macros and skip if no root
Date: Wed,  6 Nov 2024 01:56:37 +0530
Message-ID: <20241105202639.1977356-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This version 4 patch series replace direct error handling methods with ksft
macros, which provide better reporting.Currently, when the tmpfs test runs,
it does not display any output if it passes,and if it fails
(particularly when not run as root),it simply exits without any warning or message.

This series of patch adds:

1. Add 'ksft_print_header()' and 'ksft_set_plan()'
   to structure test outputs more effectively.

2. Skip if not run as root.

3. Replace direct error handling with 'ksft_test_result_*',
   'ksft_print_msg' and KSFT_SKIP  macros for better reporting.

v3->v4:
         - Start a patchset
         - Split patch into smaller pathes to make it easy to review.
  Patch1 Replace  'ksft_test_result_skip' with 'KSFT_SKIP' during root run check.
  Patch2 Replace  'ksft_test_result_fail' with 'KSFT_SKIP' where fail does not make sense,
         or failure could be due to not unsupported APIs with appropriate warnings.
  

v3: https://lore.kernel.org/all/20241028185756.111832-1-cvam0000@gmail.com/

v2->v3:
        - Remove extra ksft_set_plan()
        - Remove function for unshare()
        - Fix the comment style
v2: https://lore.kernel.org/all/20241026191621.2860376-1-cvam0000@gmail.com/

v1->v2:
        - Make the commit message more clear.
v1: https://lore.kernel.org/all/20241024200228.1075840-1-cvam0000@gmail.com/T/#u


thanks 
Shivam

Shivam Chaudhary (2):
  selftests:tmpfs: Add Skip test if not run as root
  selftests:tmpfs: Add kselftest support to tmpfs

 .../selftests/tmpfs/bug-link-o-tmpfile.c      | 79 +++++++++++++++----
 1 file changed, 62 insertions(+), 17 deletions(-)

-- 
2.45.2

