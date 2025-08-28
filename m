Return-Path: <linux-kselftest+bounces-40164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1734CB399FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 12:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061A2205A3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 10:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40A930BF4B;
	Thu, 28 Aug 2025 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cdngxen0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC830BB91
	for <linux-kselftest@vger.kernel.org>; Thu, 28 Aug 2025 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377049; cv=none; b=OZUBCo/6pLk8nbDbGL2QLHNY6ItJ8iX21J4CHMeHzCWCvSn1fsYNJSZkYsi5sS/zaeCTB0h1ATlFRPWbqnMfCG6wrJxw27D2Fag5klDQ3nq6ciUS5cqeG4gXokHtxEAocsD+oc9d2MY5vTvZqnrVV+ZIRaKfRFEZTuk5EwSX/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377049; c=relaxed/simple;
	bh=nFrvEIERFAvwyT9kdcHXUPvc32k5PlGxOwgN8YIcKAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DdtIG2hI5vfjdq/8M6uTY0Ktcm3aFpiUJpTze4+b4fn64PpzZCbMDh9lkOyedHAhvWos25ddYxlpmR+QhupZz4hLO7IZ94Z8hi+gnjq/u0ZS2t5yhKn+Vqk1uYTUa+g35qMSphTVD2xL4ZVkfZ9eplmMHAqSZQnuW/UbVci65y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cdngxen0; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f3b4c9fb5so59115e87.3
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Aug 2025 03:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756377046; x=1756981846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t4Kw4U85mgfg3dN5KJcd7BuidBkgxZ4ucMLd7EmPUzg=;
        b=Cdngxen0DlNBpeTbqnj71ypJwaCLfj2Ugw35eFyzET6Zr2qCpNbrattqEPjdmyAkIT
         fEhWl61HCluyLeWmDgjDSd12n35iVuUGPPut8MnNVfZkZdvBhn6hNPKdAE6elisdnMFH
         jRK8mosYqPsdNRPtOun07TINfWQrQZCKS3Iq73Wq5yLn2YFgYG55zLjZYNUfbMUGR1/O
         Vik8BagHntQvvl41m1aEchBKOqztCx0iVTH8gfAKrX68wH0Ju2pfFWkZN0IrfJpiFx8T
         KbCcYcoApWfBQfa47GIZ+QKLnS1jMkmvqesWg43j1CW+7PfoVy2QKVeuBvZn5b7BOfS1
         n3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756377046; x=1756981846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4Kw4U85mgfg3dN5KJcd7BuidBkgxZ4ucMLd7EmPUzg=;
        b=ttJTesnCKXV67hO71J4+S/vFVsg6uF3QpklRGgKUkKuE6GjCySHxCy5M5Opfq4e7q9
         9WAueg7CA6JmEaGc4lD1juI8sO3cB6IdXMt6Ddrd0ofShNWH1RyRNYYE1dnc3rT/ZqFR
         ITjCaKJDA3TV95G0WvzNYeAInsnZ0dbC7pXu/Y/CJ9elV1/NUnUzWkzDWzXD5e1bqCCh
         MR+/KHIV43toPtoRlKl/XjadPUeBswVsMwoMQAIte1zyGSVWIVh1gRp+xLGlRwcUtOna
         QPLapghJq/63pgGpomKvbpxQFmt/Q6FYM7Y6aB+3/yAca4TLwRFNfVSHAASOGFRKSrHZ
         sbuw==
X-Gm-Message-State: AOJu0YxV80ojZbQqlFEOpcd1D8kKuSG1SvBVTy+/pZkvi8+dV/vRF3tO
	4hxHtQrBN4CDPi2aEnFFJAI8iDSa9sqinFhwW1uUA5SjiI/zUyrqzGfS8rveTlCMxnHoMivHXML
	HETBt+zE=
X-Gm-Gg: ASbGncsIGaPJHSNesBrJBD77OTNFuz0ohWVSNXZTfSzVvEtSX/2Z7dALRoOEZ53vLZu
	Vnc+vgubrB8x699Dl3alXq0i1bJGrWVFKUDODx8wHB/OyaLR0XgpqnJot+kzSpqKq9P9G2ndNE1
	hrUNv/15k6WpMfbJh2PKuyn05Y17JVqOewyK7f6oU2wL2CJg6jKEdPwk0qr//8o/z24XPcqKsQi
	Cv2ylHk99mbMbxWmMz9kmtQRbvFktA//153Ve74PMqhHCZqEBDZaszjEh9Dju8fSyC5+Sg0/d93
	6p6AtUevbg1v6iS9wC2oRidXAF1iSORdYztVZ7CEGOkOCAWXq5OLSVzWDU2GK28CL5DV8P4SxCr
	F/Clgs5UMJ1WaCSbtyyNEZ0GfrABNtBcgOi6RWelM3iuDyn0jEyrg2SrDapNDWRq+CZ4IK/dIZL
	NBJz4=
X-Google-Smtp-Source: AGHT+IEtZ/FN1eZE/NpbPi7cNF8sNnh7uAwwZYEG2CH9o5wOOOAXUfYTY775jJvav0K0prTgFk9doA==
X-Received: by 2002:a05:6512:108d:b0:55f:63c8:7e32 with SMTP id 2adb3069b0e04-55f63c887camr104573e87.5.1756377045890;
        Thu, 28 Aug 2025 03:30:45 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55f35c998b7sm3215305e87.107.2025.08.28.03.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:30:45 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org,
	brauner@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	benjamin.copeland@linaro.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/filesystems: Skip file_stressor test on NFS root
Date: Thu, 28 Aug 2025 12:30:42 +0200
Message-ID: <20250828103042.1412850-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file_stressor test creates directories in the root filesystem and
performs mount namespace operations that can fail on NFS root filesystems
due to network filesystem restrictions and permission limitations.

Add NFS root filesystem detection using statfs() to check for
NFS_SUPER_MAGIC and skip the test gracefully when running on NFS root,
providing a clear message about why the test was skipped.

This prevents spurious test failures in CI environments that use NFS
root while preserving the test's ability to catch SLAB_TYPESAFE_BY_RCU
related bugs on local filesystems where it can run properly.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/filesystems/file_stressor.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/filesystems/file_stressor.c b/tools/testing/selftests/filesystems/file_stressor.c
index 01dd89f8e52f..b9dfe0b6b125 100644
--- a/tools/testing/selftests/filesystems/file_stressor.c
+++ b/tools/testing/selftests/filesystems/file_stressor.c
@@ -10,12 +10,14 @@
 #include <string.h>
 #include <sys/stat.h>
 #include <sys/mount.h>
+#include <sys/vfs.h>
 #include <unistd.h>
 
 #include "../kselftest_harness.h"
 
 #include <linux/types.h>
 #include <linux/mount.h>
+#include <linux/magic.h>
 #include <sys/syscall.h>
 
 static inline int sys_fsopen(const char *fsname, unsigned int flags)
@@ -58,8 +60,13 @@ FIXTURE(file_stressor) {
 
 FIXTURE_SETUP(file_stressor)
 {
+	struct statfs sfs;
 	int fd_context;
 
+	/* Skip test if root filesystem is NFS */
+	if (statfs("/", &sfs) == 0 && sfs.f_type == NFS_SUPER_MAGIC)
+		SKIP(return, "Test requires local root filesystem, NFS root detected");
+
 	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
 	ASSERT_EQ(mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL), 0);
 	ASSERT_EQ(mkdir("/slab_typesafe_by_rcu", 0755), 0);
-- 
2.50.1


