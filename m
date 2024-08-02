Return-Path: <linux-kselftest+bounces-14691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CAF945516
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 02:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BA21F23348
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 00:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6705BE4F;
	Fri,  2 Aug 2024 00:03:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC53D6A;
	Fri,  2 Aug 2024 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722556995; cv=none; b=iPhAvQgaC/g3AJ58Nqon+7YB1pIch1lZ94B5tRG2TkrlmyiIKiNmycTpUTMANuBF2YNl0cqg+m5c3Mr5hMabS9IBFmaDJsakNGvHyYazB+q68OrSw3spKpkcohHlX9P3D4+Kn9mtU5jPZ9+9BPbWC5T+/SYrVxVeMqg0bdGM8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722556995; c=relaxed/simple;
	bh=RcywlS9M/hFj5VJKUlMqVbugewDyUm46O05Cv0Xushs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbFEwu4D02fFiGEfdmnl0MxUMW7YgDW+4gBx7dh20og0aX3duGmiJCgBjLt2OK/mPpukD3UYz+i/UoD6gLTF/xl+T6PZTZ2t+cNVjwd4dk7eb1jLMfp3Xm+9bvleYjSyj3MDZ9AAeBvyvJK0697Fav6GcHUslO2siDkxCXSdWEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-75a6c290528so5214774a12.1;
        Thu, 01 Aug 2024 17:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722556993; x=1723161793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuRWDwhsI9vl4snYs8u4lKbNw41VC2AyoXgyodw+BFY=;
        b=UINUmK6gwT0q2radiZtFh/p3uNauTPJyPvfI8rsLCRMQ63eYR+0QrekcfENRN9Mpq2
         AcjUptYJRb8sVoesLMHIdbL0EDFCxTIlJ6D9+cb3UkcNv2a9V2wkGnqrOslwzlBQbrQa
         jANrlKeWb9QJIOVpc4ik3DDIE8PT1BN5rzg0/5I46Y5BGbg/BmHfHECwcMpHFnsAKNVJ
         IPK1DRsLSAEdhYQksb4SLmz1qdEE9zGt12VooAyZ2aeQjiW0tKKK4PzwA7c9wFVSXSDN
         O4Eo03KzDRaJB3PAXgEHKGivbV3ds8szqP6ZA8xu4/KSRVgJiaLs+kQvZhruDPGB32cF
         mA7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEmP3qrmwVzMkxYY23cPUHdwPMmerh28+jfSQ9kinmil1QrrxSFEqotwfCrihQ1FPWd2kcPWiLFyLJsZAQ/hmp6YrCiaAWWUXzo0pTO5tG
X-Gm-Message-State: AOJu0YyaBpVOPPJE+MKAuidb+mnt8KdtbSWz3hJRVqfN56rEVFt1UyU0
	XPJmlTa3hmAFWkaZ/YA+9ks6+wuQL4ZpUy6WZe6dI0cmC6NRJVboVoo9Fog=
X-Google-Smtp-Source: AGHT+IFNdb4BfLqhkqH4b+ahMmBcRCVgkV/Jf74fmn3jdwcOhV+XQWHN5l4Gf5C4hAd8HF9ktpbmOw==
X-Received: by 2002:a17:902:d505:b0:1fd:7c8a:be24 with SMTP id d9443c01a7336-1ff57281ad4mr26568905ad.16.1722556992938;
        Thu, 01 Aug 2024 17:03:12 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59058c44sm4733245ad.139.2024.08.01.17.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 17:03:12 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Shuah Khan <shuah@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 3/3] selftests: net: ksft: replace 95 with errno.EOPNOTSUPP
Date: Thu,  1 Aug 2024 17:03:09 -0700
Message-ID: <20240802000309.2368-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802000309.2368-1-sdf@fomichev.me>
References: <20240802000309.2368-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Petr suggested to use errno.EOPNOTSUPP instead of hard-coded 95
in the new test case. Adjust existing ones to match this style.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
--
Cc: Shuah Khan <shuah@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py | 3 ++-
 tools/testing/selftests/drivers/net/stats.py            | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
index 026d98976c35..05b6fbb3fcdd 100755
--- a/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
+++ b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
@@ -1,6 +1,7 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import errno
 import time
 import os
 from lib.py import ksft_run, ksft_exit, ksft_pr
@@ -61,7 +62,7 @@ from lib.py import cmd, tool, GenerateTraffic
     try:
         stats = get_stats()
     except NlError as e:
-        if e.nl_msg.error == -95:
+        if e.nl_msg.error == -errno.EOPNOTSUPP:
             stats = {}
         else:
             raise
diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index d17dfed2788f..63e3c045a3b2 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -20,7 +20,7 @@ rtnl = RtnlFamily()
     try:
         ethnl.pause_get({"header": {"dev-index": cfg.ifindex}})
     except NlError as e:
-        if e.error == 95:
+        if e.error == errno.EOPNOTSUPP:
             raise KsftXfailEx("pause not supported by the device")
         raise
 
@@ -35,7 +35,7 @@ rtnl = RtnlFamily()
     try:
         ethnl.fec_get({"header": {"dev-index": cfg.ifindex}})
     except NlError as e:
-        if e.error == 95:
+        if e.error == errno.EOPNOTSUPP:
             raise KsftXfailEx("FEC not supported by the device")
         raise
 
@@ -120,7 +120,7 @@ rtnl = RtnlFamily()
     # loopback has no stats
     with ksft_raises(NlError) as cm:
         netfam.qstats_get({"ifindex": 1}, dump=True)
-    ksft_eq(cm.exception.nl_msg.error, -95)
+    ksft_eq(cm.exception.nl_msg.error, -errno.EOPNOTSUPP)
     ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')
 
     # Try to get stats for lowest unused ifindex but not 0
-- 
2.45.2


