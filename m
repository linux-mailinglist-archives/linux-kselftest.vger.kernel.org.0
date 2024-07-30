Return-Path: <linux-kselftest+bounces-14496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B94942305
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 00:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156561F23AD0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68801917C0;
	Tue, 30 Jul 2024 22:39:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40CE18DF9D;
	Tue, 30 Jul 2024 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379176; cv=none; b=EVXLogLzIfTEvQtZHi3EoOqiRh/LfMe2nUGwoFrnI8MOMdFo+IbSOUlwo+qIzptvvLJs7P6AuB3mv9fj+0+iL3zkls/FIsQj/1wHZJUDJImgYxr/L2n/UtUf3pVJWdlS5cXb0XHu5xQlHMZtcci+c2ox+Sp17qKiK00g1ufPPmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379176; c=relaxed/simple;
	bh=vOIVhjatM4IfJSq1e4V0IbA96qyphn0Bgq0/WUrKY2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=psTyc8oojDDDG0Lr14klaAgeto9NIK/ekGFehBboFERcVm6G/klxMtlEm00tgSJTNAvGZ/guLsTWNyljy661SKBbBD0PjvSf+1ANiHD8k2YEuVKa8efJOzsIzExxKpLQx/QEj52i6Ne8Fy+RS5m39i+HjOFtInJeDY87nLRkGuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-397052a7b63so22429335ab.1;
        Tue, 30 Jul 2024 15:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722379173; x=1722983973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T20/potiJ817xYau9AKmhVJz5e/mlBDHwVmIwp++kkY=;
        b=hJZ7vkR3VxSVMcP/Dc8NUkpzK9Zbl1yWKhOonIUCxfEsjvHJt5YkcnR5ar6FaxkKrd
         Z+LmL0LKYvE3cewxxKH4emy0HqxVlxqWqvpd3ywdWrt1ZbLKxjE7v1jBJkFyiUr3BgSw
         9xBfJd7bsrG8JVySiQ3dIoqhcxLQ5nSrNQv1k6aXSkz/nFv4E+LRGC2obKzuNAIKZlZM
         oiG/LVrvOrJ7hVwma6qUK01KiRGCiwYPZJuwk22s9kARpAni3NmhyCo0T7hILWdvkcIR
         jsG5uFd+W9tgKmEcDQ3C+aRZ80xNmwYyeELKYIPkLPwaeMEqVDZ/YRnow0V6IsStrX9Q
         /XPw==
X-Forwarded-Encrypted: i=1; AJvYcCXAGIJBvyf80B92C/OR1dFuO3A8ITxqL4dL9PCULKYuTi7OO+8jmlI2H9wUVJV6kAUY7dz6fD52FJ21OulxuVueVRd1JQ+DLm0OgOgOeXso
X-Gm-Message-State: AOJu0YydlHy7KrTpEVam2wFKqkszuqBSho2VXaYxy0xVe0e/VQx/zZJQ
	VYmeCg/TlS0pwyPhcZ7LNdEZhOWSjAgotRJZKJNqTfs7YBFo89mav5niUl8=
X-Google-Smtp-Source: AGHT+IG6uQ9oZ2I4ac8OfiMVTLbvyYWCFEV0JTQoOJsdmmdCtVZCR98yp1JFa7/BujIdZoHEES1+8g==
X-Received: by 2002:a05:6e02:178d:b0:384:32f4:9e92 with SMTP id e9e14a558f8ab-39aec41a2cfmr167897945ab.26.1722379173419;
        Tue, 30 Jul 2024 15:39:33 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f9fbd4b0sm8081299a12.72.2024.07.30.15.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:39:33 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] selftests: net-drv: exercise queue stats when the device is down
Date: Tue, 30 Jul 2024 15:39:31 -0700
Message-ID: <20240730223932.3432862-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that total device stats don't decrease after it has been turned down.
Also make sure the device doesn't crash when we access per-queue stats
when it's down (in case it tries to access some pointers that are NULL).

  KTAP version 1
  1..5
  ok 1 stats.check_pause
  ok 2 stats.check_fec
  ok 3 stats.pkt_byte_sum
  ok 4 stats.qstat_by_ifindex
  ok 5 stats.check_down
  # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0

v2:
- KTAP output formatting (Jakub)
- defer instead of try/finally (Jakub)
- disappearing stats is an error (Jakub)
- ksft_ge instead of open coding (Jakub)

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
--
Cc: Shuah Khan <shuah@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/stats.py | 25 +++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index 820b8e0a22c6..93f9204f51c4 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -5,6 +5,7 @@ from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_ge, ksft_eq, ksft_in, ksft_true, ksft_raises, KsftSkipEx, KsftXfailEx
 from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
 from lib.py import NetDrvEnv
+from lib.py import ip, defer
 
 ethnl = EthtoolFamily()
 netfam = NetdevFamily()
@@ -133,9 +134,31 @@ rtnl = RtnlFamily()
     ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')
 
 
+def check_down(cfg) -> None:
+    try:
+        qstat = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)
+    except NlError as e:
+        if e.error == 95:
+            raise KsftSkipEx("qstats not supported by the device")
+        raise
+
+    ip(f"link set dev {cfg.dev['ifname']} down")
+    defer(ip, f"link set dev {cfg.dev['ifname']} up")
+
+    qstat = qstat[0]
+    qstat2 = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
+    for k, v in qstat.items():
+        ksft_ge(qstat2[k], qstat[k], comment=f"{k} went backwards on device down")
+
+    # exercise per-queue API to make sure that "device down" state
+    # is handled correctly and doesn't crash
+    netfam.qstats_get({"ifindex": cfg.ifindex, "scope": "queue"}, dump=True)
+
+
 def main() -> None:
     with NetDrvEnv(__file__) as cfg:
-        ksft_run([check_pause, check_fec, pkt_byte_sum, qstat_by_ifindex],
+        ksft_run([check_pause, check_fec, pkt_byte_sum, qstat_by_ifindex,
+                  check_down],
                  args=(cfg, ))
     ksft_exit()
 
-- 
2.45.2


