Return-Path: <linux-kselftest+bounces-42225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF07B9AF11
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 18:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F831711EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEDA3148C4;
	Wed, 24 Sep 2025 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikslOSKX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11E3148CE
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733113; cv=none; b=cE4bWnnikOKygJzcRXAZzrBuew7L/pW18E/i3ALGJoSwd7X2/E5ic6dSWr3AyIbxWrWelHRuPD9tO36g8i1OftM4iZ2LrujswUQle9hdI2ugB15f/sETXJEBwTn78MhGLc0lPNwyPfvlUdx/qnJ3wscNOi30tfnl5H4N0oaNyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733113; c=relaxed/simple;
	bh=2HMOyoB1zdsMaOjuaw59c8qho+a5Jwog7IztYjSvDgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rdTDWezdtn8PRcNAOWH846zz+szLaKUh2gwFxWK1G16XDmwkz6XrXAREhfBa+vzXCY1piSRJttjl4Hu2pi2MemlUJ8tYBBSwz00LVAkfcQ+1iPUbqn/Ygd3vKBc492BEwcRLoYJvTxu5ZNvdLFQTlmQ9ODbZE4QHB8xSKnM+6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikslOSKX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so5505a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 09:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758733110; x=1759337910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fhxhXtqktHcioL92cLF4a3/2LgXkVdX5qcYz1AChCIQ=;
        b=ikslOSKXWb7T2Lx9U0kBdiD5WdPlvJMsy23Aknp+NSveACZjMQ5r/tlO9jjgKF+SWv
         6EbSMTrZ2oiNW1do6wp40ydKiaTvHCTsm+NBMG3RJkr8szJETY0OvFpUx/Gi6JthJ7FM
         3jOXGK3QrFEg+KsApYrY5gSTvBRumO1r9u0rzQ/yvJTcQgirxqGemWq9hTR0qOsCnlRK
         WmxCUlH0bvFtp1csGyFhgtDGwX/GguRDTbLt5KDPOgKVjrFoQMQ2d4BKOkrRFYJ0dK1C
         qiRz+RrKoLaGgOWR/WNgr1kz3fPo4liK0yDUFuMLDUyFQu879GXkZ9wl0yiu6RG8TTqN
         OJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733110; x=1759337910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhxhXtqktHcioL92cLF4a3/2LgXkVdX5qcYz1AChCIQ=;
        b=NayTqNbP09SZk6tCTEVGiamdOxHY5LrB2ExHKCPJVS/iLfaUTGIWrrDpwZ3ZE4ZYZZ
         MdBPydwNvX52VWGPm4+DYLPyL7weO6EBVOzDI2QSe4UXX/K8NPm5r082y/yrH3aZXMni
         SwZBYoxgiPqZUYEThb8XQuCgMT8ZOtixkhBLC4VJ0UODcBXpCLR0cYdfmZ4WwaKczUmL
         akArHcldbJWxfSBUCf7mTIgpGhnlnWDcpZa+XXkv3HnXI/uP+vhCjfx2/LiP35woiE2X
         CYW7FH0sFb+BzWy9MGRbqDpF0YIMv40VS0QWRsjdAnnaTuq8DdzrbTz7QFe5tWr9Q6rG
         OzIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrCsmH7S3dR/Gf+V2menaDnbgZIPEXOMqZ+1ZQ+x/g5m49A7G9ao7Vhvn+scb324pdkIi2kPOCwAms9HCLsSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoBXs3N4WbB0YxWOdnXB+oZNXZy4mCTPJR3pA3ExUuoqbsmy0w
	1bEfF9DiHUbuAXB2e5FSrQZXNfhx89ei7WuU+i2Qf/VtNTjXxd53nsxyuM8d/gRD/jQ=
X-Gm-Gg: ASbGncu2SOFdOJxPD59AgWtvXt/GWgqfQsHXamAqkAmp12y5RssILTgMYyALGaR98Ca
	oFfIUcmiSJq25fIOwdx6wK79O6ALGWmUa1ccq/pVsiNiK7X0ddNU9HjrMuF3jAb9c8xnIZwsJqn
	sC5N1VgAh0mfXf756LSNYQlwB5nB2gMOZFDaolBh3iWjU482/C+RegtHeOXliW/g/pExZP0J7iJ
	vOWPrbXq9dHvuUACYeEIEplBPefa75I7RJpN9ebuCam1YguAWoQgLzxmLrZuNXgg6EeKNiyK9RW
	03Qx5RHC6ZYMsotPtOirdBZ80G8/CS+TYgs3sRcwwwr4QTRpU15QPXQOCmNocHgqhmWUc5jXVUE
	YlsNN5C9500cEJKSFRp8Ax5Um8INFbG6lrPbrOG7lrYnrBwuook4qGQXRFlYs98BWa1ZUCMu/VF
	zUn9Piig==
X-Google-Smtp-Source: AGHT+IHc0IHg50HF9lykmrkaQ/1sP3tnQTdw05PnGmQL20/LTTIZFvq6gMv2fB5YlFPC46sPAXgG8A==
X-Received: by 2002:a05:6402:4412:b0:631:6713:3ac2 with SMTP id 4fb4d7f45d1cf-6349fabb58bmr111654a12.38.1758733109399;
        Wed, 24 Sep 2025 09:58:29 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5cfa60dsm13172236a12.4.2025.09.24.09.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 09:58:29 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Fix to avoid the usage of the `res` variable uninitialized in the following macro expansions.
Date: Wed, 24 Sep 2025 18:57:59 +0200
Message-ID: <20250924165801.49523-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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


