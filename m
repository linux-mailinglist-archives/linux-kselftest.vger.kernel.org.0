Return-Path: <linux-kselftest+bounces-42227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B51B9AFF2
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 19:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A13322A47
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F52315D2C;
	Wed, 24 Sep 2025 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRIlPEc7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E91314B78
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734200; cv=none; b=BqwOPfBvKi1Fx9qT8fXe/aSF5M66/JzWb/GECaZkrHkvyn1FLWhJVJeUOEsnNLD0ZJZgg3b6gZL0tnd0WX5Vd1Rin20IolzigFy/SB6BZ1MUNwt+TdKddYqaiiU9v5rJQKzXO3ZZVw5J3lqdwsU0n8oCsaC34x9fGK+b36sk0tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734200; c=relaxed/simple;
	bh=hsA5j6mN1Ho29wv3TqcaUo95fVf6ZgIDjmYFb88klhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nZIXBvvAo6Ia6XrBqqGtsAGCQLAL18KQFRC/q8smKV+NgmsMgvnGr9q7pliXbeFNMQvCMnhQ2UkKPxgF//vJ9xb33J1LUf0WDhhg++VdPZL3hNgai8jhY+aT9OUqCEgCjQHqFKi/vxh7aQeP1vZk+XQUsUJHIpaHf+u5GxZE4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRIlPEc7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62fa99bcfcdso40234a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758734196; x=1759338996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNxQWNsaNzm07NK0oI4QfKW+i7h07TGqHOD9HRkHR7U=;
        b=WRIlPEc7bya2iEY7a0uEEWrpqlt4AHc97i+PMV94TrFREKzT10x1y1q6Cd3kz9JOF3
         +mJKubZddUAREsEI31FQJQjBm5IinpXXOwsyEszQMiQESSaHVo9YDpcSCZXNdP0dSCug
         MjXgScHrdMX7F/HTLxqutGdp55YzR6zWnHATYXyvo1AZbNk0sHlyilqgvlrvbLf8/COv
         ZnDahaL8Yffw2CksNPluQO24ZsrrmLP2/npcrjjFxXNblcbJjGx0IvJlXWyphb/aUcIc
         G+hPNOlPs7s8drZyLqNRyIOEejjQmQss0Wogi88zO/fPfV6GTeCuGnBbH5kvxU9aMaZl
         daPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758734196; x=1759338996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNxQWNsaNzm07NK0oI4QfKW+i7h07TGqHOD9HRkHR7U=;
        b=VWIwagTybSMPWszjk0KPhyRoepGKF5MOEFmzdtbPbEvlEt0VU6BpBiUsR8R3xcXOEu
         eGDzbp7s0H1m56VOnFn+C9Z0jfMG312ieD1kmrkdPvd1k8uHnaC53vm/ntNG0sdT5kSC
         Z3vkcPrhBdjthGNyLiPqHuCTkj+iDQPgepwcxLFCn40dPS3n/XvgX6s/SDAlT1Wb4lo3
         ShKDqhhQdjHAKzTKm6eq4e1hiN5KuL6mw1bpLNIcGwN+fn1yiUhpUuT3xcKH13uZWum+
         uFHdMZuV9tzSWYClrp3pxn5G11/041aWhtTI1sDDHp4vQLTu4RHBKRa6YP1KsZOgiSjb
         8evQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3IsjsFZw3twADCqiPSlt9VbLQswsBsYKpPb2nSsC2+t3BeNnOStBqfK4frM23QV1voEFtpz40uvIn8zJQqqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgo0zTaA9+sVhFcGhem0MAwzFyN00oLEpLLdmm5/TPDOuwmFnr
	jKcDYpbn+pQq3Conaf/nOfoDPlNfoyuVerWOI5Gy9/gWIEJweIWc0yTh
X-Gm-Gg: ASbGncuGc4glPEBYVlUkdnMMMP26Y5Xi6n6PQSXshRzKkMC3UdnQfeFvKv0+qrEhatS
	aEjX0RUGr4+wDszGHHUL1+CdKKV1bYTRdxREdXUaeXLKdQzqP9PJlhpALPFvfO681HrFtpGadeo
	+ZvUK42vPVDwsczoJaG+XgIJoBlTOY2myyVDjLlhaZPbPzbX8cH9U2GfYfztk9rWbyoaPysWAi0
	hC8uICt1XKt5f/X+3VJFWq/YIGTNu4pDnciCZX1KaZRFfvNegNIkB8rgDeseUTsaBnja8CkesaL
	DWzdKDLa0/TcZJTxWwpN5QwP/s3b9A+/VHu8IVkyKbrTHdfModMlfXoQcTzDd03+mklleGGC76V
	DHqe+9qpOFbi/7Ap+GBDVDj4dL98zxjrtCvJEUzVatskNw7O5+TakWbt2LGdga+u7VWzge4ewxz
	8N/xBDIA==
X-Google-Smtp-Source: AGHT+IGTRCVL+Vy3tfNF1MUEnXBCXWeb5Jrz0wQXqG7fNQTDEE2vWKNUIlbHrYap21jasTSQYR4WgQ==
X-Received: by 2002:a05:6402:160c:b0:62f:41d3:ece7 with SMTP id 4fb4d7f45d1cf-6349fa1b9a4mr208376a12.14.1758734196429;
        Wed, 24 Sep 2025 10:16:36 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d4357esm13318691a12.23.2025.09.24.10.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 10:16:36 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/iommu: prevent use of uninitialized variable
Date: Wed, 24 Sep 2025 19:16:28 +0200
Message-ID: <20250924171629.50266-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix to avoid the usage of the `res` variable uninitialized in the
following macro expansions.

It solves the following warning:
In function ‘iommufd_viommu_vdevice_alloc’,
  inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
iommufd.c:2889:1:
../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
[-Wmaybe-uninitialized]
  760 |   if (!(__exp _t __seen)) { \
      |      ^
../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
  513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
      |   ^~~~~~~~
iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
 1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
nvevents))
      |   ^~~~~~~~~
iommufd.c:2924:17: note: in expansion of macro
‘test_cmd_trigger_vevents’
 2924 |   test_cmd_trigger_vevents(dev_id, 3);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~

The issue can be reproduced, building the tests, with the command:
make -C tools/testing/selftests TARGETS=iommu

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 3c3e08b8c90e..772ca1db6e59 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -1042,15 +1042,13 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
 			.dev_id = dev_id,
 		},
 	};
-	int ret;
 
 	while (nvevents--) {
-		ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
-			    &trigger_vevent_cmd);
-		if (ret < 0)
+		if (!ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
+			    &trigger_vevent_cmd))
 			return -1;
 	}
-	return ret;
+	return 0;
 }
 
 #define test_cmd_trigger_vevents(dev_id, nvevents) \
-- 
2.43.0


