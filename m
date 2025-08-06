Return-Path: <linux-kselftest+bounces-38368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EC3B1C40E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 12:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1676318A5AB8
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 10:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2DF28A1D2;
	Wed,  6 Aug 2025 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laYDgQ4F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430EDEAF9;
	Wed,  6 Aug 2025 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754475094; cv=none; b=D2Hq+fZDpLFZP8Vir6PQRB7LOFzHCMxN5082pY8bGAQv91t1yxaRz92Yo7h1siwleTkXTLw8QVzDjK2ZSQUyfZU57eWVMIC4n8FheT28Z11Cyj1qDhm8ORXBcEdAQQBOx7V75uTXTUYVdL37Xaq+//+br2cvjyLDpb6si04gy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754475094; c=relaxed/simple;
	bh=rz3+HU7JKv8jhc5UzbJs46L/Ju8Ag6gLiK8FfBcLLSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYqtLDLXsFgcwlk69dA/W6LBNGBKjA2TzeCaYmPHL8pw85B1ZJql76vqLnh3FWgwAdArbrVfud/9jdkLuQpxd0RQFAqhZNklWrBiS4NRtson+oHKTpXASoqescr7E/4XNdxG3KxUWlNG3D1kilE1/SgLkjzJ8wSq6CYPzWYjkN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laYDgQ4F; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b1fd59851baso4080860a12.0;
        Wed, 06 Aug 2025 03:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754475092; x=1755079892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sO3HfLOCJJZChZ/lYTRgYCSocOP1p3nJGczefdhSTxE=;
        b=laYDgQ4FhnDKo+OqJlFhI1KmCp0fB4fMR2etDqgQbQltsZTP9PsmOIwXSVoF7SqH/M
         ZzNbsFLRFyKEDVowIp12FDK+zhNNbHjOdkB01SN14KS9SmqaFdhzpD5Z9n2iSByaZV7Q
         +p2wVzwAx+AFrQP6LrLHV0WkCfEMts5V898wILjzew7DZF4sZD+8ztbptJL5Xdl8YJS0
         47WB0/C+/9ZivmR6G/DKTQH+ro0JxFCs8Idcmb0k9OZmImNsCMPB+Kde27Na9IuREFhE
         Y0CMJd1fGuRN/c7d6C9CaH9hFi7vjxRK3y2xitqAMzkU3wSfeZtCo7xdduHe85D02nst
         fLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754475092; x=1755079892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sO3HfLOCJJZChZ/lYTRgYCSocOP1p3nJGczefdhSTxE=;
        b=ZKqs24eq7oIZD3gTAMbOKVmtcT/uSfp6B/DbhjoqYXKzrsUcGZJQVKEZO3zRMhizWR
         1AABR8PTUxpaCjEaIYxOTQFqV7t+SiWv7TvWB9qyxMMLXEanXZSdnUw/FMhDTOhULAcA
         SrmaHMp5Ycyjv5E0louMJdYypKndBlH4q1AfWwBa2J5ZB1WdNCQ/Bu3WvB9GX/dT4/rE
         XjQh7F1OFwolxnyVOpNYPp2msVhY0I3gAcIXl8R7hvOiqLyUxf1pIte0f7E/wWp5QeDG
         TBeqAXAC6HwdgKgq+KPKb4ggbPhUh4GsirQXie5BzA565lsyc6AIuao+b9TMY/Gi4Cr8
         bUQA==
X-Forwarded-Encrypted: i=1; AJvYcCU21heP1d6TIJiwN4XGtPA3ON+HN9PQX8g1WQSRMeHnT8LYt71rE+clYA2Nt1NQ0bNwHboIA1V9mcUJW1Q=@vger.kernel.org, AJvYcCVg2abw2PciG4+jfc1uGCUxq+barR1c7lVKPatu8FVXfs3fnqQXCMllxssejPRQMzczL8kz+UCwSWYcczOj/Dtm@vger.kernel.org
X-Gm-Message-State: AOJu0YyyFZF8hh+vUixC7omk0OVe4vjh13lR+kRhjmO2DF7KSQYKJlOr
	3YY6myeqEfGfitQbUPP7NVQ9+NLzIk3AvO35pRdwtjhfAs90cB8YNlpL
X-Gm-Gg: ASbGncuNx0nY/7lgEPG3jOfmRGsuub5Xd3vnhhGER10hGJtWvfMB9qMS0m1QedsGstc
	t95nBUE9hkQDp26ikD1FSsU/eMVIfhQNeo0N2sqq5pqQUypvevGTwL13Qz2B/jiKBwJQ/uaKk3q
	1jogK2igy4hP9BgWTnERzgmvreM1Z+A/CytWMinhajKGcp7Mz8yHo6XaOHEpJmjPVHxdJPMzabk
	cLtJJke0tLbrX0GJOGjYr12QwEO1vs8HS3wL0oxA+AS71s0MOxksbaGk2xSfWc4SKbkYl/uTQnO
	8vOh80XZHe6Frzb4Hyngz64Y/bMO0meOi/IOypPMvjOSw8JcrYjm6fh/LNBVdOsTd+63B6QWtUL
	R3R/om3GykbVIT111tAfYzhPrBr91V/aZOfGe1y7QgFI=
X-Google-Smtp-Source: AGHT+IEmLanIPxjWKqJkZkvNGPC1Tz6Y2s/W700XeFEAe/gxXlOLDOI9aFoVES62QDsNB9Bbbmo5WA==
X-Received: by 2002:a17:903:3c45:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-2429f6541b3mr31886055ad.38.1754475092273;
        Wed, 06 Aug 2025 03:11:32 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c30:7b0d:6527:282d:9edd:5f40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976cfdsm153199745ad.101.2025.08.06.03.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 03:11:31 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: shuah@kernel.org
Cc: brauner@kernel.org,
	amir73il@gmail.com,
	jhubbard@nvidia.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] selftests/filesystems: replace typeof() with __auto_type
Date: Wed,  6 Aug 2025 15:41:23 +0530
Message-ID: <20250806101123.20478-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace typeof() with __auto_type in utils.c.
__auto_type was introduced in GCC 4.9 and reduces the compile time for
all compilers. No functional changes intended.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 tools/testing/selftests/filesystems/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
index c43a69dffd83..95f202e2bfb7 100644
--- a/tools/testing/selftests/filesystems/utils.c
+++ b/tools/testing/selftests/filesystems/utils.c
@@ -34,7 +34,7 @@
 
 #define syserror_set(__ret__, format, ...)                    \
 	({                                                    \
-		typeof(__ret__) __internal_ret__ = (__ret__); \
+		__auto_type __internal_ret__ = (__ret__);       \
 		errno = labs(__ret__);                        \
 		fprintf(stderr, "%m - " format "\n", ##__VA_ARGS__);       \
 		__internal_ret__;                             \
-- 
2.49.0


