Return-Path: <linux-kselftest+bounces-32978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D769FAB78FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 00:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A4E7B084C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 22:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C81F0E20;
	Wed, 14 May 2025 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYinFPHV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED13A19CC39;
	Wed, 14 May 2025 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747261306; cv=none; b=TnPMFOD2axlnsBR/NqNiVHoBAGqYoOdmoM9kuqMrskrZtR+XtKe23UqKbhht0NDlGUqPrB0qEqPF7u3gJ9tzBaBoU2L47OFtIm8IiQ6wxv4IUylA3g9pUKw3trRH/zWAF6AjRIFaIxs4K4WP+EA91I1Tu08GGmo7xCnqOjZVrQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747261306; c=relaxed/simple;
	bh=3j2GE9l3wGOmBQOG6S4c822rAlthmoDqPjq3LP9n+Os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGDq5C0rBYvN8O/nzatVcV1CkefhPapSxFtDbRaStkzSaEkAHFTeOyKEYIOnPpYilks3nexyPIR9rDJK0KGn1Lf7OM664HEeGdS/LgCLxmamimt9y59uAH59hHozynh6rJMeV8A8FwQYDoopdScg/bboRVhja3lgQRjGqxSqI98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYinFPHV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22fa48f7cb2so3331655ad.1;
        Wed, 14 May 2025 15:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747261304; x=1747866104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oHfsdh270VAzzwWx6ys6xW+UP8Uvsw1TOQddVAOSGTA=;
        b=LYinFPHVyv7vO4TG02vFyWVg2AF1mdrhvILYi98AM/FXOAxCh61NwCd32MQPOr0N3Y
         nAVA17iYWdC1J/D1IJ722NcNKWzmqJ+vEp2Vk3A+v9iV7nkNtphntCxdFPUmejqDpkG8
         aOjjSgLsoI+aLbq86wsEGMbBJwzMDmgZkclKF+93EwoSx47xQrLu1RxgLQMciaSu8gO3
         9Y0gIGhiX4aNSBDP7SkdTtlh5UYU7XnZPWMrdyu1NjxaiZ0o+qC0ORIODN70BVIrwHdr
         p6MYLPv28HFck/eLPhHRT/VqKc4fdmEjEfLoT8JyEqvaHUivIDjbl2aBUs1UuoCxFLmN
         qqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747261304; x=1747866104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHfsdh270VAzzwWx6ys6xW+UP8Uvsw1TOQddVAOSGTA=;
        b=CDlLIII81kvWzuwKR5scGU5JxHgQxhwrmehctERbol4j6PttDpxHTEA7OB/j9fL4PF
         NoqHExs99tNLsBWPYZiwYpVTAODERSu3uFLNNy4eIgwXtb3FXF0LJxa1UYjpkNavzA/T
         uQvXsPt4i8dwCcCkv2RHeq0TEHuwVsWxJk1Xj9TDJ5TcOkhSE/S4QwZ6mMpyqLnVzFMu
         g3H+lJfktHlgzWzKUVzJywN/ybb9GLT/6aB5ODn+S6ik7rRPhhsYbl61zb3rWfQb0+nm
         sbm9eEE2KdwSQA+Rgn1eCj6JsI2DpcfW6IAPVYnbZXfbctqxWziBMzer6aPSu0nC4kjV
         YySA==
X-Forwarded-Encrypted: i=1; AJvYcCXdjCilhpOPSSgYKNEXPAL1tcmWGSXOlzOfg63JmRixZVf84jk+2dmuq7EAs2THBZe9/g+k71oiJ4DNRIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxBCmg3/TSCAt22udIZazu1oA1XOQvUPwakq55YWTm9LWS0Acd
	o0xVyPbziP3qEPt8I87eY1H2pkauzf9MdTRTPRmFcPUqowyUY15xCy6eZpLcwfOTyg==
X-Gm-Gg: ASbGncvBzv2cfx9VGMdV7tNCSygsm2mE1bq8WEwspBWFL6UAE9hqc9UvP138BwFN/P3
	r3FoNgmsGyntqq8G3/5dsajqS/yaFHRgpAfnZjW50d6KaqR6uqUSTqqBNrsRI2tMW6z0tIuWjE4
	qdbAg7YDV0/aChHUM5ifiEiMpm33B/r0900xxMeKiESJePVRLN09Pj0UpDRqHPGgFREjArucyUL
	ADxgtsILiOtqqIZJZa786dQuwBaOFcRTbqbk/Qb8T4Xj+ejkBSqiW61Jd3xNum+32QFLVo+v03Q
	bFncDJ1ZPS+OcsBeUA6PXp7M7xX428zeDoPAh6Z24IStGZDYYUq7HUwgzYJyRryVKMy7dqTN3KN
	x
X-Google-Smtp-Source: AGHT+IFttTpWsrfV8CTbyFUfOClZsN4VaZgrm7diOQZyUoMIOzoXxLxvFc2uEuwrls7nKlhcN5t+2w==
X-Received: by 2002:a17:903:b0e:b0:224:76f:9e4a with SMTP id d9443c01a7336-23198119c40mr70961585ad.14.1747261304097;
        Wed, 14 May 2025 15:21:44 -0700 (PDT)
Received: from rahul-mintos.ban-spse ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828ffbdsm103836525ad.196.2025.05.14.15.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 15:21:43 -0700 (PDT)
From: Rahul Kumar <rk0006818@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	rk0006818@gmail.com
Subject: [PATCH] selftests: timers: Fix grammar and clarify comments in nanosleep.c
Date: Thu, 15 May 2025 03:51:12 +0530
Message-ID: <20250514222112.396705-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improved the clarity and grammar in the header comment of nanosleep.c
for better readability and consistency with kernel documentation style.

Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
 tools/testing/selftests/timers/nanosleep.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 252c6308c569..84adf8a4ab5d 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -1,12 +1,12 @@
-/* Make sure timers don't return early
- *              by: john stultz (johnstul@us.ibm.com)
- *		    John Stultz (john.stultz@linaro.org)
- *              (C) Copyright IBM 2012
- *              (C) Copyright Linaro 2013 2015
- *              Licensed under the GPLv2
+ /*
+ * Ensure timers do not return early.
+ * Author: John Stultz (john.stultz@linaro.org)
+ * Copyright (C) IBM 2012
+ * Copyright (C) Linaro 2013, 2015
+ * Licensed under the GPLv2
  *
- *  To build:
- *	$ gcc nanosleep.c -o nanosleep -lrt
+ * To build:
+ *     $ gcc nanosleep.c -o nanosleep -lrt
  *
  *   This program is free software: you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -61,7 +61,7 @@ char *clockstring(int clockid)
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
 	};
-	return "UNKNOWN_CLOCKID";
+	return "UNKNOWN_CLOCKID"; // Could not identify clockid
 }
 
 /* returns 1 if a <= b, 0 otherwise */
@@ -90,7 +90,7 @@ int nanosleep_test(int clockid, long long ns)
 {
 	struct timespec now, target, rel;
 
-	/* First check abs time */
+	/* First, check absolute time using clock_nanosleep with TIMER_ABSTIME */
 	if (clock_gettime(clockid, &now))
 		return UNSUPPORTED;
 	target = timespec_add(now, ns);
@@ -102,7 +102,7 @@ int nanosleep_test(int clockid, long long ns)
 	if (!in_order(target, now))
 		return -1;
 
-	/* Second check reltime */
+	/* Then, test relative time sleep */
 	clock_gettime(clockid, &now);
 	rel.tv_sec = 0;
 	rel.tv_nsec = 0;
-- 
2.43.0


