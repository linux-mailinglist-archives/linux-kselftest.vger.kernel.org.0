Return-Path: <linux-kselftest+bounces-4186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA22F84B1AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 10:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AB11F2400C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290C212DD86;
	Tue,  6 Feb 2024 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f34EUJS7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728212D74A
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Feb 2024 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213417; cv=none; b=je4Ca5aKwlMmtJe0VjdVfUugMTb0++GAFOT+ap+yeZbgH0VDlCm1Cpve6yaxSPn+xPR53DMgvp1VRpRsX+O5h8Z+eLUT7F/t8AxBsWypts58QUMv4zuGh3FYkR74w4ePkM16U/q+U/09GQa8XejV3w1/OZmVbEIPtzCgX5rbVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213417; c=relaxed/simple;
	bh=gFwQT9q2MQDOLZo3TSNZibKCNFI0OYg5lS2v/Yij/5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NYDv0cvOu9z7iFOjXBOJgDBT6YOesVxz65vKrzYnBOyuhMHpTDAU3JE9UR87dZCBXZEXn4KfmFIjnES2l4yH4u+0Oo1ZThrbo3T4Mx7Px4Y0QN2Q1/GEpRmM4TMegj1VnEoBLDrolKlYa8+aGVo1xCF6hIL1+AuhSBRb4E1Z73c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f34EUJS7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d9bd8fa49eso13359765ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Feb 2024 01:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707213413; x=1707818213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvtejigsA6lvJftTJlUnU81wJFgRlPFcDxMvj4jJa74=;
        b=f34EUJS7pq9JB9Iq765rxANwGO2iY+6kBVrCtx5b+JeiCZJI2tS4++CcyEJRrjm9pJ
         Zukik37Sc6QeteFfd9fdViXQjXdIcguZkN0p6UbaQgQ0Vfm7aBUrhoc3HyX3EzyruySH
         vDMqKuVeBMQSwI8hac4pK7CMJcfljIZPWLhaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707213413; x=1707818213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvtejigsA6lvJftTJlUnU81wJFgRlPFcDxMvj4jJa74=;
        b=TsfTjeAGa3zP1VEnfBqn+Cy+DZ82HLSyS2SYKswmGJ3BbuSKWZgDB7wCOjS6hYhv3W
         DHxo1tM2RjoUYaEJm42bN45n6YTDlNRx7uOY9FhdpoYgNtwfI/NvsAhO/L4PdGHnCMv5
         x7kG3nuJpjXNz72NXB7oCfY6lxotFjfTMXydKLA3EeykN7mH0eP8Upe5ZZ2+dUobp1Ut
         duJ3JdwdP3hAli60hw28fXTvU3IZZ/93d+SP6B3cD4cCpO8g0knB7qJkFWlJ/OppJWtc
         QDosZ+V/pXBeFZdm7AYNRfwmcL89FVTNIPjNR+ibXiID2ki2au/JNrJiPZKINEsYGqiv
         lhCA==
X-Gm-Message-State: AOJu0YxHLHGfc+aopg9XbkdSFRMvAl13kKM/Ryw+0CXOFAo/n0ENE1Qa
	la7KKblIrX/Cz8xh3q7NPEMwRxta9rLYxl8P8dzLH2RlSuyVAtlOAwqvm1D8yg==
X-Google-Smtp-Source: AGHT+IEoS/Kl4hf4JsN5prm6mSrUJ2HBa0Fmc9/TJ19QJ5pdSUTD1wSZuuqJ9x9OlMDqrSJRoUYDeg==
X-Received: by 2002:a17:903:2304:b0:1d8:f394:da39 with SMTP id d4-20020a170903230400b001d8f394da39mr1326364plh.65.1707213413601;
        Tue, 06 Feb 2024 01:56:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW4XJapeWoVq693/JjVCP6x9T70VxgvoAa9DEw2WL3YUgGW4WylfVi6E9yCu/nZNSoV8n43/+0umk95KhnOt/x3SF1igjAd/G1ohmsrXg287GxUeFSUugHodmJNjmQjtCelCvT+SwNKnAj5DX82/i78b1orLqkyP3dJCq1XPf08nSCspRRCe1fG9nVRcnzcUCt7gLD7nY45bAP8OYcLPS731zpVcdW9njc8SUc5Q3THJUHoEfAWbo6jLbrCg8XZOPeqDU2e63BMRaVG8g3I/p3Lurfv0TjvBccwKmDzuvE=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b001c407fac227sm1456525plb.41.2024.02.06.01.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:56:53 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Pin benchmark to single CPU
Date: Tue,  6 Feb 2024 01:56:47 -0800
Message-Id: <20240206095642.work.502-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2238; i=keescook@chromium.org;
 h=from:subject:message-id; bh=gFwQT9q2MQDOLZo3TSNZibKCNFI0OYg5lS2v/Yij/5o=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwgJfCsxNqlw4QkCwa0uTjz9m+WERqUM1QnArU
 Nk8peGOJtCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcICXwAKCRCJcvTf3G3A
 JqyTD/9FjpTBzQ/U/pDNYWZkbNEqKOmTGswAI5nhxPwJETkBv2PFztRglzljETLPB6slHXo50Xq
 aaLyg3Tx0jUQWvCNGmus+ZcUaZeUc9ERbP7FajXNyUdvtd4FvpLqXrb7YLGBIyJRTt0pUvwsp08
 dCXkfBVP0NEg+OM1SXDxtM43MKV8KNktVyLCjDueRmNXPGfukDqLPleO02h/dRCuc6UsznNrz7W
 eJN8zn12je2bB+26ikjlbccbihquSHNFLUnCJShgg3EvXM9ywmZsFLlMzb4Fl5COijs0xPYrBNm
 FWh1ZbJ1xA0G9GAvwpDF+lUEOvluGYMWudXBwiY48XSPsLcLS1ZluT5L/+SPsljItEjPo6hqk0n
 CrBxjLamMqteQUQX9pIft8jHROCFAcOg0qF0sgPUzePBdn9BDi+gYjb4r6w18iT24tp090XbdnL
 zD5pCjM7IO/PmNZsEsgYHqW5lww/o7nBOiGje91P116WFA9RvghnOY+qJ3tBxnmm6stuujMgFa9
 wBFLrpkHt8ll0GUr0Wqlh6zkFIAB2+1Y36Vby3hcpVshfevj+rPFBwAbc/4VmkOGaKchlnUZCoe
 fiRUeabcdhzM4JXK4d0mJYyjz8qcKzKZG5vWpDOW9gHHQNh2rYZitp7MV2ksHepXPw8qRdCK0Wz
 HJa76r6 9E8DwurA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The seccomp benchmark test (for validating the benefit of bitmaps) can
be sensitive to scheduling speed, so pin the process to a single CPU,
which appears to significantly improve reliability.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202402061002.3a8722fd-oliver.sang@intel.com
Cc: Mark Brown <broonie@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../selftests/seccomp/seccomp_benchmark.c     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index 5b5c9d558dee..d0b733e708cc 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -4,7 +4,9 @@
  */
 #define _GNU_SOURCE
 #include <assert.h>
+#include <err.h>
 #include <limits.h>
+#include <sched.h>
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdio.h>
@@ -119,6 +121,29 @@ long compare(const char *name_one, const char *name_eval, const char *name_two,
 	return good ? 0 : 1;
 }
 
+/* Pin to a single CPU so the benchmark won't bounce around the system. */
+void affinity(void)
+{
+	long cpu;
+	ulong ncores = sysconf(_SC_NPROCESSORS_CONF);
+	cpu_set_t *setp = CPU_ALLOC(ncores);
+	ulong setsz = CPU_ALLOC_SIZE(ncores);
+
+	/* Set from highest CPU down. */
+	for (cpu = ncores - 1; cpu >= 0; cpu--) {
+		CPU_ZERO_S(setsz, setp);
+		CPU_SET_S(cpu, setsz, setp);
+		if (sched_setaffinity(getpid(), setsz, setp) == -1)
+			continue;
+		printf("Pinned to CPU %lu of %lu\n", cpu + 1, ncores);
+		goto out;
+	}
+	fprintf(stderr, "Could not set CPU affinity -- calibration may not work well");
+
+out:
+	CPU_FREE(setp);
+}
+
 int main(int argc, char *argv[])
 {
 	struct sock_filter bitmap_filter[] = {
@@ -153,6 +178,8 @@ int main(int argc, char *argv[])
 	system("grep -H . /proc/sys/net/core/bpf_jit_enable");
 	system("grep -H . /proc/sys/net/core/bpf_jit_harden");
 
+	affinity();
+
 	if (argc > 1)
 		samples = strtoull(argv[1], NULL, 0);
 	else
-- 
2.34.1


