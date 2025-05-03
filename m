Return-Path: <linux-kselftest+bounces-32269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4087AA7DEB
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 03:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757495A3A26
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 01:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E4D41C7F;
	Sat,  3 May 2025 01:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL76fujM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E980F1C683;
	Sat,  3 May 2025 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746236135; cv=none; b=tXJw6LKUJFUwEvdZ/asos0SKl7+cxY6KHUjWvZOiRYHFkao0oZAbHj/JXZKgvSpcAC+Gg7Vu6u4GYKlgjb0BomXDITvIYCwcuc7IuOUCuweOHYik7efqewkNHIdHOs9drVIhXE8XHm3Rqk2nmQxMXXgFpQysjJ9N3sWpE4le1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746236135; c=relaxed/simple;
	bh=689p89hkifBdXT5/HRvEs1RhAbPOhsimh3SRv03bogc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INUrZVkJJNsMBwLgyPtbdXXEmzTqoChI1ULkMzK+WMRZk90KNXre6qIYv9qUj7fsbnVvA3cLZEeJZBqsFI4dJvx5UOZBBCm+1icGDVeN7IBQHtRsXdAp98OPnEoacDB2ZS8AUKC2tBamn9Tkrw1up4z4hLoCaPgiVILSd2KBBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AL76fujM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3995ff6b066so1129482f8f.3;
        Fri, 02 May 2025 18:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746236132; x=1746840932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7neZkL2UO8XEHQLiWbF2I+tgjzSskPqpXB+Dz5WdWM=;
        b=AL76fujM51QGEk0Lq49WOLk+aOWir8GxTjOUj4d3SC2MHxZ2zgigMHRta98FdAgCPx
         vH+VXWOI/ANraL/nwKq3nxV05YjxkyAbSyAFiM1i03pph4qOB989W/pLDCwqSBlZm1PP
         x3ZKDN2HQk+7XNuYQ8kVF19pZIoGeJzmvPAgWhx95/FYlldN5v3EFMrGVBxwErz9gpBO
         EI10mNba33bEZCFkXZA3siRet9/hnqL9WkTsdzcXXopji6qwDOD/Kz+3RVDwBv7Sym6/
         SZ7yDL81iJsNpuy+UKJRAfw6brmrMkVwBBTObFupKMgMg44efvWkMrxYBqnS8R+MBZ10
         vxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746236132; x=1746840932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7neZkL2UO8XEHQLiWbF2I+tgjzSskPqpXB+Dz5WdWM=;
        b=jjq0PZlGoKitNHDh0PydLYtjpgkhFaK3uArJMj67pBc3hvecR07D8t3Xlprl9JpQNe
         ucdOwSZuuTWc6kVVpK0+YSz3dvyqjI/Rrju0d1Pt2L9VUMWBMhDlPIFHH06Cqv6fYwGL
         NHSE/Ag8j9pYNeeQqFaz6D56OsPyk8Xwb6cVrM1azQOhHK+CumrKSNeQG/uXi0JnWmoN
         e8O4U0UpCXd4FJVbbShU5wB1DwVKWFk6kMWi2FFp6yU6/zwbmWJNQWbGArkQCukWzoET
         liEd5Yc7sqBuRLaEiZMlM9pLNQ6Xtkx7vgg6w7h9EemK8iunKvqoYMO/J2yaLwHSA/yI
         J4Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUk+0lv2nNtmlrH7f73xNOzsl+TcMX1vD1xsVIAUsRCDJXPp25387gvRWmN7F9we95qkVPytz3Rb1nUYDHDKWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl/A+1WgYwMoIID1cMOKnRcO0SFp6Xgj6iP32Y9CNF0KhGe4eR
	COdnhyNpSdREBBDXsqYwiw+UFHy1JgDOq0EW+G2HLSEGGAn5qY0W+PL9zRNd
X-Gm-Gg: ASbGncvXHhfPsah4LRqf23D6ejVgUr4tmltDF75eOTiw++RAOl6ZtQ9egCFfGaRGF+R
	oTSmXVSrRbUufBtRbwdNO1bLyhdM8Hu4RvTSegeOBTMi42LPBKqNoxkj7M/XsEuwDCqoFum7F90
	yenfoIbGQTeyxM6g/7VqDzBLs9KADh1YouEHqWUmFOBAQ7+Df/7kDrnaA1K4eUzW9WqfjFZ6/8D
	IsJo3RTUHSmk7bmVLyFGLFGGMvuWpMyhS52Nt3BpyLCgzWgyCX9XSxix/YlkiPysYDUkpWCmoW3
	1opjhwvWrnoCMi/7LPiM7cXoWYrzfs2baHdYNw==
X-Google-Smtp-Source: AGHT+IGG3g5Rd9anKox58E0EBMa5CBiVsV7soUfu026rF4rUbeP9X18XTynPMpnUzhy7qInEpxKrsA==
X-Received: by 2002:a5d:47c5:0:b0:390:e5c6:920 with SMTP id ffacd0b85a97d-3a099ad2a2cmr3967376f8f.3.1746236131809;
        Fri, 02 May 2025 18:35:31 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0fe92sm3557503f8f.68.2025.05.02.18.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 18:35:30 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	ap420073@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 2/3] selftests: drv: net: avoid skipping tests
Date: Fri,  2 May 2025 18:35:17 -0700
Message-ID: <20250503013518.1722913-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a system with either of the ipv4 or ipv6 information missing, tests
are currently skipped. Ideally, the test should run as long as at least
one address family is present. This patch make test run whenever
possible.

Before:
./drivers/net/ping.py
TAP version 13
1..6
ok 1 ping.test_default # SKIP Test requires IPv4 connectivity
ok 2 ping.test_xdp_generic_sb # SKIP Test requires IPv4 connectivity
ok 3 ping.test_xdp_generic_mb # SKIP Test requires IPv4 connectivity
ok 4 ping.test_xdp_native_sb # SKIP Test requires IPv4 connectivity
ok 5 ping.test_xdp_native_mb # SKIP Test requires IPv4 connectivity
ok 6 ping.test_xdp_offload # SKIP device does not support offloaded XDP
Totals: pass:0 fail:0 xfail:0 xpass:0 skip:6 error:0

After:
./drivers/net/ping.py
TAP version 13
1..6
ok 1 ping.test_default
ok 2 ping.test_xdp_generic_sb
ok 3 ping.test_xdp_generic_mb
ok 4 ping.test_xdp_native_sb
ok 5 ping.test_xdp_native_mb
ok 6 ping.test_xdp_offload # SKIP device does not support offloaded XDP
Totals: pass:5 fail:0 xfail:0 xpass:0 skip:1 error:0

Fixes: 75cc19c8ff89 ("selftests: drv-net: add xdp cases for ping.py")
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/ping.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index 5272e8b3536d..16b7d3ab0fc8 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -12,7 +12,8 @@ from lib.py import defer, ethtool, ip
 no_sleep=False
 
 def _test_v4(cfg) -> None:
-    cfg.require_ipver("4")
+    if not cfg.addr_v["4"]:
+        return
 
     cmd("ping -c 1 -W0.5 " + cfg.remote_addr_v["4"])
     cmd("ping -c 1 -W0.5 " + cfg.addr_v["4"], host=cfg.remote)
@@ -20,7 +21,8 @@ def _test_v4(cfg) -> None:
     cmd("ping -s 65000 -c 1 -W0.5 " + cfg.addr_v["4"], host=cfg.remote)
 
 def _test_v6(cfg) -> None:
-    cfg.require_ipver("6")
+    if not cfg.addr_v["6"]:
+        return
 
     cmd("ping -c 1 -W5 " + cfg.remote_addr_v["6"])
     cmd("ping -c 1 -W5 " + cfg.addr_v["6"], host=cfg.remote)
-- 
2.47.1


