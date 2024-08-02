Return-Path: <linux-kselftest+bounces-14689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E950945512
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 02:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B08E1C21CE4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 00:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BFF23A9;
	Fri,  2 Aug 2024 00:03:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961FC17FE;
	Fri,  2 Aug 2024 00:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722556993; cv=none; b=rvGtXzGbhsMBz4oBmAGC4KCSexpg7Hxs4epOfCHGl5X9VgZLrsNhK4Bzz+jTVyVQVt/4KWxrmLCHyAJfbuRX6Fi0AP3CqgqQl3qvRisKkvFJWHmPDa51WipaQv3GuynPoORfGLxY8cyvhK7km2ROWY0Cv8OrnaTNrL0TTBjCMUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722556993; c=relaxed/simple;
	bh=3qQU1VgjbNk7XLc0TFKS0yeKm8lp0WuhwZgPjg6zWdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBXv+f+nbJ795/+J9sGqJTT0h7bSJ/NcT+A2C2/d5qrKrwZvLOW8jY0sp493aked7gmb406pGQGUE60HGtN/Vb4oNkwstnmzYI+ROR2owxSJdS9eNd0RHH2cdp/KNFWQ+flwPi8z3jgVZ/9uo14BvcVEmInjnPwyMPGCYOpRv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-710439ad77dso2796554b3a.2;
        Thu, 01 Aug 2024 17:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722556990; x=1723161790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmKA0jXkGsl8kspNfQ7BmOezp0qmpOf0Ot67lZV8ipU=;
        b=dN9CWzEOYoYIXinvkefzmaiminQ1yUol2R8twFhuSZGHx0LJx9I6XKHtxLh77eF9da
         1Vw2cdZgLL2JfSV7QnfsAV9bkLCdD4BjXbRhvANyqaz1XKuz4xd4d7mqiG1GTE2BYEJu
         6QhXV5L9lpXBu6BBhBum7LBMYYNV0HiFYOYhISprUuomup7COz718P7zZ75Bo5kLuKD7
         UNmtGD8UeP/UFRQDUv5K26qHfFCXF+GkKd0cTJaCDbaDfpRgSWe4Bw8HhcL+3ehearzO
         fmD7a+lzEy1rYymF6XesF8kvDlSskgCGWhFUKaFIH78H4CfDsKqEawN0jUusxZ4G5C3N
         QW3g==
X-Forwarded-Encrypted: i=1; AJvYcCVxhSmeu5oTwtd070PDcMbX06BMs8KKppn2OS3vqmSV42wx0HZoUX4xWOUkB7hm3ej3LirAwed+97yGKGbZs4ZijFe5csFTlWx3cWpFcHwy
X-Gm-Message-State: AOJu0YxvyyrRCziFQsx6XUZ1411ctA+LE6YGhfRHflgjv33IORGpj9Lb
	FjpppnUbLBk9F7XOEsFa93E7ZbL0jFRLCJKez4KzFxp5yXty+5eyuikv5Qc=
X-Google-Smtp-Source: AGHT+IGVgXT/hjWZy2PwLKF61YM2KQZlF8k8gY5DTXE8q3zUsdMARtlg1KfLz2NL1J6jp2VaEcqGcg==
X-Received: by 2002:a05:6a00:13aa:b0:70d:2b1b:a37f with SMTP id d2e1a72fcca58-7106d02f8c6mr2206305b3a.24.1722556990440;
        Thu, 01 Aug 2024 17:03:10 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec00e66sm372073b3a.37.2024.08.01.17.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 17:03:10 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/3] selftests: net-drv: exercise queue stats when the device is down
Date: Thu,  1 Aug 2024 17:03:07 -0700
Message-ID: <20240802000309.2368-1-sdf@fomichev.me>
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

v3:
- use errno.EOPNOTSUPP (Petr)
- move qstat[0] under try (Petr)

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
index 820b8e0a22c6..2fdde8cf0307 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -1,10 +1,12 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import errno
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_ge, ksft_eq, ksft_in, ksft_true, ksft_raises, KsftSkipEx, KsftXfailEx
 from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
 from lib.py import NetDrvEnv
+from lib.py import ip, defer
 
 ethnl = EthtoolFamily()
 netfam = NetdevFamily()
@@ -133,9 +135,30 @@ rtnl = RtnlFamily()
     ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')
 
 
+def check_down(cfg) -> None:
+    try:
+        qstat = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("qstats not supported by the device")
+        raise
+
+    ip(f"link set dev {cfg.dev['ifname']} down")
+    defer(ip, f"link set dev {cfg.dev['ifname']} up")
+
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


