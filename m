Return-Path: <linux-kselftest+bounces-14402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0882D9400EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 00:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B891C221F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 22:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011C218E771;
	Mon, 29 Jul 2024 22:10:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B1318757E;
	Mon, 29 Jul 2024 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722291046; cv=none; b=OsL8k6jaHv1ervRpp6+dfPUp+npZBvwYGTBXv3B8bz6zWtpN44VvHP1ECZRgq6awN7ZOEIgywcerZ3t3/2euG/dUspTZeCMHQ+uUYzOfy81+VjpDgTNCsSLS4s1pMfnAUYtmsvRBDE6Dk0jRk8xGEdbFDzNU4Ugh38JDwW/RVdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722291046; c=relaxed/simple;
	bh=6YNsQUMmPU179nCKPnqAzIhOWJRb8yPnMuiRFNI2E5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IThZYI0pDM2IuEMNvp1LBmCdNHxjGXNLofcY8lmBdB9nRSAQrfrO0MnP7wArWmcuMDo6qd7znJozXPYi3k8GyZFhAorqIUIUjJQP7tHZpy/ga1l/KY5CXbkj2kdjv1ozut0dlkT85RmgaPCKPUdVzvrglm2/iUuaw3vaHFWgD0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc658b6b2eso27750185ad.0;
        Mon, 29 Jul 2024 15:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722291044; x=1722895844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLdLgsZNnbXZLDfh9as321ac5PoX6veTzjkDDPiycaI=;
        b=UwxrN+1dutfU5qvucQLycYCLj0r3TPX6wHAxFKA9PJM2nGBGyK4dP5XBM7zM1mbNAi
         tDFKfao9gwLZAUdrLS8x8FpfArsPwV8w1KRQgKRXJyE1Q4PqCBLZ458f2xM6lZhSdlgg
         HpnevEGJ4hxNCzBYwX6WMcH74fgildavh1o8fePtQ1ebzgwIE5eYUxGuqdyvgh6iGggL
         KrnCzlh2Eci8cPfThzG5btRAQ/wmKWkUjqLXLomiyqwWQWaPPLrqZfr5yfOaxQkPky/4
         OhOcI1SmgnPckzl9TqZ5mgn1s5X1CAMVby19f8U+6zBHLMBtMDh/BlROQZRZMmkW3DpT
         fn7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqlSI4E+A4bwMUWVdAap2tguXpYkJVNAmcbvDsrvDJHkCD5sV7D1ZbOMySMmUhb5bXoycyoPh19eudbFkZ2aOjiFHOr2A0R+S6ZgBfBgyf
X-Gm-Message-State: AOJu0YyUYVUPiGxOfyWV18pKzBUUFQZAmo0y7GBf4QkQXHBu43SOZciY
	/4hp8BRp/43j4qTQGXZB57b8AyEhD09XXIg2tGZO6aphdoNxmIayQ+CnopU=
X-Google-Smtp-Source: AGHT+IE2R0RjergZ/Zh5Yo4aquL9u0tsjBrrMGgEJRoEbR3OZ408IYfFR5mG34jjdbcTk7jw7aXFXQ==
X-Received: by 2002:a17:902:e846:b0:1fb:44e1:b5d6 with SMTP id d9443c01a7336-1ff04827042mr106986965ad.23.1722291044051;
        Mon, 29 Jul 2024 15:10:44 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f2fc46sm87867505ad.207.2024.07.29.15.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 15:10:43 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] selftests: net-drv: exercise queue stats when the device is down
Date: Mon, 29 Jul 2024 15:10:41 -0700
Message-ID: <20240729221042.2700882-1-sdf@fomichev.me>
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
\# Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
--
Cc: Shuah Khan <shuah@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/stats.py | 31 +++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index 820b8e0a22c6..6f8bef379565 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -5,6 +5,7 @@ from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_ge, ksft_eq, ksft_in, ksft_true, ksft_raises, KsftSkipEx, KsftXfailEx
 from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
 from lib.py import NetDrvEnv
+from lib.py import ip
 
 ethnl = EthtoolFamily()
 netfam = NetdevFamily()
@@ -133,9 +134,37 @@ rtnl = RtnlFamily()
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
+
+    try:
+        qstat = qstat[0]
+        qstat2 = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
+        for k, v in qstat.items():
+            if k not in qstat2:
+                # skip the stats that are not globally preserved
+                continue
+            if qstat2[k] < qstat[k]:
+                raise Exception(f"{k} ({qstat2[k]}) should be preserved but has lower value ({qstat[k]}) when the device is down")
+
+        # exercise per-queue API to make sure that "device down" state
+        # is handled correctly and doesn't crash
+        netfam.qstats_get({"ifindex": cfg.ifindex, "scope": "queue"}, dump=True)
+    finally:
+        ip(f"link set dev {cfg.dev['ifname']} up")
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


