Return-Path: <linux-kselftest+bounces-35983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1665DAEBE19
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9507B188639B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9552EB5C5;
	Fri, 27 Jun 2025 17:03:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC1E2D3EFC;
	Fri, 27 Jun 2025 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043814; cv=none; b=Dc8w0VpD58u8YxVw1nKffwDg5edIJNMIV1I2Z2kOQ+F5kS/ubtL3NXpeIPH3nygggRhBgSpdNxvZpdoNMdMnokukZZQoI2EinNt7V+OeJ3rAp1II1WSQBNposz3H9QCvZh0b/FKMPimdyB5q+s2l4T5h+lwkxWDWQ388pkJRgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043814; c=relaxed/simple;
	bh=/aNBC0XBfGvwuRnaC4+TsJVqjIgdi1gtra/gd2Kk8+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jkjEDdkAARtDZoZSV5280KZX1sEO9FvxiFRL676yD69vUw9P12ZOFlF0T37HyAhXC31xIBP+0EOMJwB4j4zEoJktHNtgO9AUsofzJKy1CUdz/mw6o//dzzP7CDRhIJz5QxzwPYCFr/QBkQxKuDLvpZ6RDw1+vF6RqlsgNYq8G4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ade76b8356cso4073466b.2;
        Fri, 27 Jun 2025 10:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751043811; x=1751648611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3HuCBWhl7sYzAryoc8j2NnrheIMmb5LJG1G+EC5ub8=;
        b=q6nu0oQE8ma2mXFUk5+GSVYP+meFbDT46TKNYPdD/NhZ/4FEMCqPl6mJ2fy8kcqyMk
         8JCH/24wz3wl8v21wrkcipr7gVvfF0xjwePBA1LjMYEzjnqxlTYwSNCkZKCtGwUW/Tgx
         8OUreqiaf0Tgw38Argbrn/3yFxdydAeMNH5YmJSV3KpWbzjLYnw5M0pBzZMkuEuIxfRU
         DRrwFKeIhlTWcXiys/0c5+5s8zPW/JReRKAaKPK1XGBO4sdAzgOdC3qWl7ubkzb7O8rO
         3+2joWrP7fz5fXdPaWF0M5CumgVOZSfNwnXDngZ0CEIExQmv6p1G9O1zdymUAQwjTP2f
         qI4A==
X-Forwarded-Encrypted: i=1; AJvYcCWZtqejyB9RfTfnFXUFyVzTu979Nh3/S5PagVyME4nYXHsD1/8wwKlUQVaeW53x5eJScmU=@vger.kernel.org, AJvYcCX3E6HjeaGOIfBEW8tcbhDS4MQQfXW2BCUuoF6KrDjNjCsi5fC/4qMW5gavGSFAHGUjeq1Oul8p@vger.kernel.org, AJvYcCXeHCanNGssaYAWxV2mLj7THye6BTixV+aq18BykCfRqlMB1vTn1+oC5LTR7T6xsZg2V3y+t9f8FQejhSsjXC4H@vger.kernel.org
X-Gm-Message-State: AOJu0YyCTgCVj3ULc1paQwUO/u7BG611rjEQSug2T2Kipn4iDgL7qwJZ
	JxAdK7nZ6QRIq+bM8RRNRzBEDDAeGUKjHV99o6sc2CXE8HjTsyijz6oxOhskjg==
X-Gm-Gg: ASbGncsdZKgZMisWUTATqqmdWfdk8yteOwo4KLKpvhFa003US/Q3uza1elJKcMoaljv
	C2HzDNBL8DMXxHRsoi6Zdd/+8gUSIoGx6/we/k4ut/B/0M+lV5tJA6Ex0dSvplnCVlGBW3gEgVs
	8x0XsnsvaG3ygrcQ42fcFB+TWp0cQ0yG6V/R0arttWRXE4N75fXx80CgXRAqH+VvwIDXNtuThvd
	EV/10BnIQu83bKEvhBNjS0j8sQzvqGu5yse2vLWemKTt7TZK/IDPu9crI3Zj1y7dSs6+Qhm7mPt
	3kwyGMmJac4awlDD/fcnnXqrkaUdSpgX9FdD34fRWvXYboBRVnNB
X-Google-Smtp-Source: AGHT+IENsGlGcMgnMWYwPxvWkQX4RMe6V4a7dkEgE/WtU7Ma5WEOnkwSn70xiLohRqrgGr0MAS3UhQ==
X-Received: by 2002:a17:907:ea6:b0:ae0:a463:f4da with SMTP id a640c23a62f3a-ae35015c01amr403406266b.42.1751043810567;
        Fri, 27 Jun 2025 10:03:30 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae36327ce4asm82044066b.163.2025.06.27.10.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:03:30 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 27 Jun 2025 10:03:09 -0700
Subject: [PATCH net-next v3 1/3] selftests: drv-net: add helper/wrapper for
 bpftrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-netpoll_test-v3-1-575bd200c8a9@debian.org>
References: <20250627-netpoll_test-v3-0-575bd200c8a9@debian.org>
In-Reply-To: <20250627-netpoll_test-v3-0-575bd200c8a9@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 ast@kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3109; i=leitao@debian.org;
 h=from:subject:message-id; bh=2B3HspaUtkLq/87GHVo3MgVog4C2o2TFROWRoUVy5GY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoXs7f/8E6BG65o3jhrLh4koQgcCH/Whdkftybo
 aoE86vMT7KJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaF7O3wAKCRA1o5Of/Hh3
 bbC2D/oCPCBueLOi1qmmxeWym8rqsVryET+A2t5F3oX11d9j0Uusbp/FVrrHL2PDfWPDuM5VMk6
 +quzanGXbRkKTldTqAZTTsd92rhhwnSsZ3zxFn67MAZ5XZKaN5D189V40hYCN4AAogqAIabgQB3
 /rjykwZdMYZO43yMRX8FVOzTR8PRQfgdT7euHwUaw189Bvoj6c0HdCg2+GLD5SjG5QVe36NvRnu
 CON7yBLfjIXnpk5tGB6xEF0Mpm9HMG+VJRh1GnSd8XJhCAJomUUJ0tDfaDXbOpH2AiOlGsoIOOF
 LPtiszx4Qw75KfoaVYA/BJ1Y7SW+Q4IGIsvMUNLmXSSC4wNatV3iwNkPxvklJgQXklZmut2Tz2K
 qC/40tBfIyZX35+9cbf5ywHGWCTCO5DVt4Lc2oOkizNL0VFhJRGgu/oAmwGOqMt6qBopXnKgG7i
 IWG7SpQIih/2Yf1WcC0qDUalyDR0eU4RUxKurxEMqUD0ZSn0NxE2CWknuhA58+6157+QDG+vA9N
 SPImwTTxtFFhxnVYbwbUJm5YhabA6g0ahTTLOubrSWGSRcJCbUkfZ7LnGvnrnHXyMAFyVs0RGSe
 ad7nKggbQVcDzdiL4W8+ewIl4P+M/+YLMxig8VGHtDvRdGJIqo/BAZ11yskcg9/RusylpMrGnCf
 IEFCbY24flbcflw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

From: Jakub Kicinski <kuba@kernel.org>

bpftrace is very useful for low level driver testing. perf or trace-cmd
would also do for collecting data from tracepoints, but they require
much more post-processing.

Add a wrapper for running bpftrace and sanitizing its output.
bpftrace has JSON output, which is great, but it prints loose objects
and in a slightly inconvenient format. We have to read the objects
line by line, and while at it return them indexed by the map name.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../selftests/drivers/net/lib/py/__init__.py       |  3 +-
 tools/testing/selftests/net/lib/py/utils.py        | 33 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 9ed1d8f70524a..98829a0f7a02c 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -14,7 +14,8 @@ try:
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
         NlError, RtnlFamily
     from net.lib.py import CmdExitFailure
-    from net.lib.py import bkg, cmd, defer, ethtool, fd_read_timeout, ip, \
+    from net.lib.py import bkg, cmd, bpftrace, defer, ethtool, \
+        fd_read_timeout, ip, \
         rand_port, tool, wait_port_listen
     from net.lib.py import fd_read_timeout
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 34470d65d871a..760ccf6fccccc 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -185,6 +185,39 @@ def ethtool(args, json=None, ns=None, host=None):
     return tool('ethtool', args, json=json, ns=ns, host=host)
 
 
+def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
+    """
+    Run bpftrace and return map data (if json=True).
+    The output of bpftrace is inconvenient, so the helper converts
+    to a dict indexed by map name, e.g.:
+     {
+       "@":     { ... },
+       "@map2": { ... },
+     }
+    """
+    cmd_arr = ['bpftrace']
+    # Throw in --quiet if json, otherwise the output has two objects
+    if json:
+        cmd_arr += ['-f', 'json', '-q']
+    if timeout:
+        expr += ' interval:s:' + str(timeout) + ' { exit(); }'
+    cmd_arr += ['-e', expr]
+    cmd_obj = cmd(cmd_arr, ns=ns, host=host, shell=False)
+    if json:
+        # bpftrace prints objects as lines
+        ret = {}
+        for l in cmd_obj.stdout.split('\n'):
+            if not l.strip():
+                continue
+            one = _json.loads(l)
+            if one.get('type') != 'map':
+                continue
+            for k, v in one["data"].items():
+                ret[k] = v
+        return ret
+    return cmd_obj
+
+
 def rand_port(type=socket.SOCK_STREAM):
     """
     Get a random unprivileged port.

-- 
2.47.1


