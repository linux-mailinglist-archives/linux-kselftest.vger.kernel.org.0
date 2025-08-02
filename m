Return-Path: <linux-kselftest+bounces-38208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F11FB18BDA
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 11:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6317B5B92
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627FF23E347;
	Sat,  2 Aug 2025 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLuK08i+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A71623D2BA;
	Sat,  2 Aug 2025 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754126695; cv=none; b=r58GfPvI0uRKqMv6gP+7zkIwo8iyvCWz78KqvYx6+i/O7/lfrctdDNB26pB1AzaZbF7uNcJEdquy7RCPh41/lTgQL9WgRZs0qr/oMuVmgHJUwVlrr+hYz40ptC0VTeLb811Q5VK6R8dXJkEzXGpMsXBJP/huScgULldi7hq1xQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754126695; c=relaxed/simple;
	bh=aBYekBr5DaBwXFDMz1i8qJlNL8mbGSz7kS+2wTTB4Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S22Z+XUiY8ji2sW9U6Bh3Tz7ejYB2d4GP3PLXQubgG+xn3siQQjEtqCSKTqu/RHkf84ZFC9A6qo/8J/gHN//1SLZlQK4lrcQkBjoPA6G42q3Cha5U72RqrWN3KxnjAJmd2w4f/WkbBReQ4kTEoUS9nb0dMBuINDSxPHHG6xLUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLuK08i+; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso1562886b3a.3;
        Sat, 02 Aug 2025 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754126693; x=1754731493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTD9xpJdl4CvrsFUHVGNuaknAMGABpE3qqQKQMDhcQQ=;
        b=KLuK08i+MX8gyJWy5NFswtSl4aU5FHriZQwl9+yymVWbQcnkYhX/YvIBTHX+DZMRSK
         Pf47EnmHvd/w9o/h81Sl1fkWu8vzSIz66aSS1AQK9fBahT+569E8RMfkNdvweDDlY5rr
         NyoUaUUdosdd+2MOi/Ujv3fBNxVpbGB7CdkI8LwMzuYJjBkDBogXo9PZWBxKn0xLTSlp
         mhFry7yThL+vZlLuAJEf5qPrqICDQOiNmGYxn3HblZK38XGfkH8qEZ3LZYlpYCNNXf4c
         LCTUp9PaVsn4OSrM53VL9XeKACyWQFfOLdMfd9PduODRubkk2kpUAXF0plEPHzU6rT4+
         ZDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754126693; x=1754731493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTD9xpJdl4CvrsFUHVGNuaknAMGABpE3qqQKQMDhcQQ=;
        b=FVmMxRH3bw9PYHV/uUPH9YJ21dqcRPPEaC0ZLcqHdZz2Qs4f7l4MAQiA5IDmQJqgAm
         /xApysbsCLJGF1Q7C2BXHNg3yhv4bpvcUkSoiMuAqEG/P0sIbnq6/94U6oRBjHC8MVIB
         80bIC39psU+V7xx7h+PqIBO7AdnLrcEqazlB5JUUn/rftlMXUaDgReGK3JwhNT9wBGDn
         SqEAd87uk8S3TVDElSsdI847kiWRC96kgWRw35pigLX1OAhQAtjqC+jriCf4DEUbtH7/
         TQrSBeWMxBvM0fa6mNa4OW/tXHK07SZjNohBhkxYLPZ4LPMObbbCbBibYaJUVsWbvE2H
         eGeg==
X-Forwarded-Encrypted: i=1; AJvYcCUd6tgd0ALVYxebaYoDSYeve5j/Xcx8gVocWFkwgoFjz3Pd9Df+spop5fLQm7p52/ntd/1dD/F3Iz/7tX/NISMh@vger.kernel.org, AJvYcCUlXrvNYj19CV6rPDdyQkYoD/MFvA1NWPvNMlzw/Mb8oxl8ei2FDq6sLIL5zbTJzIumFDGapN7/JLWIghE=@vger.kernel.org, AJvYcCW0a9PUO0NqIU+tnh9yLt2BHSMbDvH69VhH1gIifcnYD/hGEqrEYDvilS3IndB2t9VkI/h2DQ3Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7EQEzn5qKcFshBjNUnZQsciyyLLo+djtw8a3OfiR3kh7CPCjq
	AbNfzy3fHAXMPTU6oanQNUVepvE11WfcoU7wqKYdK39nbk1HFTTz4Thj
X-Gm-Gg: ASbGncsX7zsB1rVnY/pigr0+5aLFMG/tHFGTnZhCBGFQErby1c0ZLcAoGQ5nEhXr/ed
	W59uHFVhXsn47YPvHZONA5/2v2SPohDlV9zeBSg5UAtHi3kP5VINYMobWOuol6V7XJG7IrkzyPs
	BGCBwSWoNqwpO+4E3xGpHOQ7IhhKSmSNIpSs1WyiLEBoWrOtQUgGpkokcRXh5T7ApOpZCKfmPQ6
	kv8j5b6LeeXFaI6WcpMiwG6ml8+EgTtKmHwyu/MrJ/C6KRC+3SNQ0lcR42EpsATTQRnu8OxnfZ2
	2Xmqi+FWgckyou3eDafSfEREauzxmiYQy3rnko7914LX5U79DdECCGHqexFyxxkRcc3b3BmppXu
	jaHoF3ycoPH6TckkWi1E=
X-Google-Smtp-Source: AGHT+IEvwN516QxbLEFvRKIlIJl7ZUCvjn+yT/uIwUEDcS9ce/63liMn8SrJ97IqlciRzsHW20j4Wg==
X-Received: by 2002:a05:6a00:2ea4:b0:76b:e561:9e1b with SMTP id d2e1a72fcca58-76bec2f0324mr3148482b3a.1.1754126692597;
        Sat, 02 Aug 2025 02:24:52 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd7887522sm4799161b3a.20.2025.08.02.02.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 02:24:52 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com,
	kuniyu@google.com
Cc: ncardwell@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	kraig@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 2/2] selftests/net: test TCP reuseport socket selection
Date: Sat,  2 Aug 2025 17:24:35 +0800
Message-ID: <20250802092435.288714-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802092435.288714-1-dongml2@chinatelecom.cn>
References: <20250802092435.288714-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test script is provided by Kuniyuki in [1], which is used to test the
selection of the TCP reuseport socket problem.

Link: https://lore.kernel.org/netdev/20250801040757.1599996-1-kuniyu@google.com/ [1]
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/testing/selftests/net/Makefile         |  1 +
 tools/testing/selftests/net/tcp_reuseport.py | 36 ++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100755 tools/testing/selftests/net/tcp_reuseport.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b31a71f2b372..0f4c3eea9709 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -117,6 +117,7 @@ TEST_GEN_FILES += tfo
 TEST_PROGS += tfo_passive.sh
 TEST_PROGS += broadcast_pmtu.sh
 TEST_PROGS += ipv6_force_forwarding.sh
+TEST_PROGS += tcp_reuseport.py
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller netlink-dumps
diff --git a/tools/testing/selftests/net/tcp_reuseport.py b/tools/testing/selftests/net/tcp_reuseport.py
new file mode 100755
index 000000000000..eaeb7096382e
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_reuseport.py
@@ -0,0 +1,36 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+
+from lib.py import ksft_run, ksft_exit
+from socket import *
+
+def test_reuseport_select() -> None:
+    s1 = socket()
+    s1.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
+    s1.setsockopt(SOL_SOCKET, SO_BINDTODEVICE, b'lo')
+    s1.listen()
+    s1.setblocking(False)
+
+    s2 = socket()
+    s2.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
+    s2.bind(s1.getsockname())
+    s2.listen()
+    s2.setblocking(False)
+
+    for i in range(3):
+        c = socket()
+        c.connect(s1.getsockname())
+        try:
+            print("SUCCESS: assigned properly:", s1.accept())
+        except:
+            print("FAIL: wrong assignment")
+            os.sys.exit(1)
+
+def main() -> None:
+    ksft_run([test_reuseport_select])
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
-- 
2.50.1


