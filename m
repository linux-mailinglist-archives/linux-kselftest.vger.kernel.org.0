Return-Path: <linux-kselftest+bounces-45583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3D1C59E78
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 21:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A563B04DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 20:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403C1218AD4;
	Thu, 13 Nov 2025 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIw38i/c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF22848B2
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064592; cv=none; b=u+vE4Z412yR/L9tzUwyt6QerLIZbPZk49MwELy4XNJ2xyEY7YVolKogb6NlNxiOhviXFDJ4po2Fh9MaJ6NYZ3MHLGVH41uqgp8jhnJffON6xBYkJJYy4TwMYyVBcfM8/CXul+A4l4Mu2rNsZNojyTdsPUpGKu8Qjhn5aAbqTASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064592; c=relaxed/simple;
	bh=QKdBCUlNwtR+F2VgsVfMTt/KnsuIIdUNrx84lK3lLbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbVJN53YAdpoW7k5YL+SZRtcG6CrTd/HXV21pG7YFiAovMF8dhy9InMhZrG+49HU/5vAlzormCoX5OD8WUo6E/D7dYm+QScIatYMrE8xvliomXVzS2PnRDXkyU0O9dc74fuaimMKN7konN8MhcRm+6ZgMQt9J3l9rGwlROjCfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIw38i/c; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29516a36affso12646685ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 12:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763064590; x=1763669390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gpG9MFDfcOAig9lTA5rz8MkmRR9OX2bi+Q5guu7HZEs=;
        b=PIw38i/cp1ajQzijgMf5CenDbSYGp8WurLAo+k3XrKJiY18L80L4tYo6PtMmLFaWEB
         aPZcPF+PFFKUNW+Zpm5w0r6S/JVIDOTLVb3kKemfJ+mmxHhNNcGeLdeE0sWm0A1zpf5q
         vP/ookydzCurFiKhB/YZaRvyvrLbFPyDssiT/gT4sxan+bt3a2phfLLM9ntzk/bL/znm
         gIhkMVlVrQ1YMHwGd7hx9I/ATuUQWIjlSnfIOehdPL+lQEgIarfeIskHyr/OYss+pHzA
         oQP1PB4iKxE9QZ0qfO5zHx5NWcCccMnl3YvgUvYGwMxxt43Jmz3LiOnhtPxU6La9QHHo
         tCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064590; x=1763669390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpG9MFDfcOAig9lTA5rz8MkmRR9OX2bi+Q5guu7HZEs=;
        b=eNKwNf/2Tot1wWnufpyW3Lh03FQZs3Trjs7m1VCPwMkHA2Y06l3HKAzZvbskf99puu
         t7USg4rIR9i9BP+FV7Y9kQUTEUXp56k4g85P5EniAW+UV2wslyl3h16z4ueDL6uJxIXr
         gIxnipeU3mslNKlBaf5Q9AWLAtn3eq4YUCFtL/SrpgWTg5Ol0HqDagHUPZRu2TgEvEW9
         dv32ZlaHxbbr/1Jd3lQYv+uvXYDB/v2H6yTPsCasqFJGct/DF2duE1Ga6jJy7CVQpI7a
         49EL7sU+dqADkHvOx9e51tl5ka2gMjsAyLkYK4G3geDOfy53H/B9XiAxSW7NRxcmZUbl
         RX+A==
X-Forwarded-Encrypted: i=1; AJvYcCWVwe/MgtGqC73cXbbQbLwQ4WC7+QoF0KF/ICUso+P2p6WVxghhCBVwbHvq4uyruqUgjNHTtO9/oqbHAmOXa5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJsoyRafbTgNzz94HzSZvVunbFpmHy/taPe3QngKDC2YUa83wy
	XQ+na1DIURysAQlSj6/QjDdIUZrTe6OV4XM2x+JGPd9LYEqhfP7ZBMbU
X-Gm-Gg: ASbGncubKJqNNOyW8abkS1XkLpMC1a4+yoOdXyv8rkXiczV6+t3+WdESq0aA6WLmI3i
	ceb3fp+lblHNUwrEw5EX9CCmCIA5D1PQco7cRbz2yzzg171hQlWR0RXbqpcKyGWA7QfOIt/6CMX
	X6XatAaA8s2vaF201NI0CN1vdbnRGhjYE1bi51/4xdGbdx9loWq/vKd+tl0TKNQm1q6Wozo9vtj
	WukmeJKLt9xa/iDQCCl/HpdKgmWi32ZyFNzsB/H84IP4ZCVKeO2gMctzeWS5FA5XQoBJT//hc0R
	PjQ0QjSaWit5ROrgwt7zv8WtemS4IAXXfCxBjNVJIvxIrI9Jz2eYBVfvnCYpsKP/CocLcEigViS
	kc3FU91Z1D50BRIfOmNtLCytBqHdhW7vniNQrwYlTGUU/SxmhXFfq7XNQc92kH4/1NlJR3ChR33
	9D8r5TDE9x4npSwJvVnBkfq587ue33nLvGx6UV88YdQqxkEmkl5pdHi82ykayxP2SXPpA=
X-Google-Smtp-Source: AGHT+IFVs3N/0Nluydf2W8ohAwTgqQqd1hktqndT0y1P5e+0Z+Tsef7VZeDU5gPIi03W+2qZKgyt9Q==
X-Received: by 2002:a17:903:234a:b0:295:5dbe:f629 with SMTP id d9443c01a7336-2986a6abf18mr2384305ad.8.1763064589974;
        Thu, 13 Nov 2025 12:09:49 -0800 (PST)
Received: from prakrititz-UB.. ([119.161.98.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bf0f8sm33985925ad.89.2025.11.13.12.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:09:49 -0800 (PST)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH] selftests/iommu: Fix array-bounds warning in get_hw_info
Date: Fri, 14 Nov 2025 01:38:55 +0530
Message-ID: <20251113200854.429515-2-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC warns about potential out-of-bounds access when the test provides
a buffer smaller than struct iommu_test_hw_info:

iommufd_utils.h:817:37: warning: array subscript 'struct
iommu_test_hw_info[0]' is partly outside array bounds of 'struct
iommu_test_hw_info_buffer_smaller[1]'
[-Warray-bounds=]
  817 |                         assert(!info->flags);
      |                                 ~~~~^~~~~~~

The warning occurs because 'info' is cast to a pointer to the full
8-byte struct at the top of the function, but the buffer_smaller test
case passes only a 4-byte buffer. While the code correctly checks
data_len before accessing each field, GCC's flow analysis with inlining
doesn't recognize that the size check protects the access.

Fix this by accessing fields through appropriately-typed pointers that
match the actual field sizes (__u32), declared only after the bounds
check. This makes the relationship between the size check and memory
access explicit to the compiler.

Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 9f472c20c190..37c1b994008c 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -770,7 +770,6 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, __u32 data_type,
 				 void *data, size_t data_len,
 				 uint32_t *capabilities, uint8_t *max_pasid)
 {
-	struct iommu_test_hw_info *info = (struct iommu_test_hw_info *)data;
 	struct iommu_hw_info cmd = {
 		.size = sizeof(cmd),
 		.dev_id = device_id,
@@ -810,11 +809,19 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, __u32 data_type,
 		}
 	}
 
-	if (info) {
-		if (data_len >= offsetofend(struct iommu_test_hw_info, test_reg))
-			assert(info->test_reg == IOMMU_HW_INFO_SELFTEST_REGVAL);
-		if (data_len >= offsetofend(struct iommu_test_hw_info, flags))
-			assert(!info->flags);
+	if (data) {
+		if (data_len >= offsetofend(struct iommu_test_hw_info,
+					    test_reg)) {
+			__u32 *test_reg = (__u32 *)data + 1;
+
+			assert(*test_reg == IOMMU_HW_INFO_SELFTEST_REGVAL);
+		}
+		if (data_len >= offsetofend(struct iommu_test_hw_info,
+					    flags)) {
+			__u32 *flags = data;
+
+			assert(!*flags);
+		}
 	}
 
 	if (max_pasid)
-- 
2.48.1


