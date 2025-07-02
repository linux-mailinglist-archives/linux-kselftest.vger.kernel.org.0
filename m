Return-Path: <linux-kselftest+bounces-36311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 189B6AF13A9
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 13:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDCD3B056F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37140267B68;
	Wed,  2 Jul 2025 11:21:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE6326656D;
	Wed,  2 Jul 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455273; cv=none; b=si6Zq76ONo4K07DA+qc1kPSqCGb9m5D3jPyMnvBhsO8Mu5U6/u5sRk7gxpzvikW0eW5XXT5vY+Wd70K5F+tTsI6KXP2gESd69KZ8oZfOYdEtHkDcF7Hd92p4zaqa1LyfEXAU6F5Aepl2nvBQvwEjGfLCrZsN+EID2ecckGW6jn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455273; c=relaxed/simple;
	bh=kmhreOsqeuqBCdj6XPPUE3ZSy4x+7B5KtJ0GKNZmy+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S99t5vHupaQSFcPoWvDVsmHrAHTW0LY0+ljAe90gxip3CE9Y4NSXebe0bPwZPC47fSTb8o6QgFULMrTs9c9pRncpcMeZE2hCssT7B4ugbxHPCKd5T4LxGfKHC7oCxq53DUgP6rBW6YH3QG6mQJdL/jcq0YrIxRa9b2tRvilpVSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so11102875a12.3;
        Wed, 02 Jul 2025 04:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751455269; x=1752060069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snLCftmRv45xZk+dYhFYTETXXx2kQ2Ytw2HV/igRrFU=;
        b=gmKDxtx232WL07A2xSu4AXrJf+PeYpcVT5h7wGOf8wTSgCJrdj61CsuS+ysdhJGuO2
         vZMoQ1xFQSMZASDu2SondAEPn4TCDH3p1S7fKcTq1BNre/hAv90O3L/fy3pyb2DjoQ6w
         T6j+Q157AnfR4RCsgrgko+FVyqZmbfB77SQvWre6Qey0MlCHNY6oHv7b7qpL9/a8n3bd
         7twAvUHtsUw1xAORiFyTJfm2jcZHNxL0YDJjo8TbuDoAKgh7n11WOWkreS4ln/bK9V/5
         4ID0zAlT2SMk+LoWbOPlUcmhCAzTDk5YIxJmqq8xVTR9wheUid6mCvAx+X4y/pHcVexb
         k2xw==
X-Forwarded-Encrypted: i=1; AJvYcCV5w4y+ElkdJ4KhPqViqG2ExrQEbBMLHpYmy09B/lB9gyf87takuoZ/uwJgEgp15fW6XU5Glyg21SRIHtuDtEh3@vger.kernel.org, AJvYcCVxlm5Ur0ADr6OYAvCYxh7dHl+BssHSOVYVmExInfFUzi6PSqLNeIt9Y3NE1eX6QPiZnbz6UQGc@vger.kernel.org, AJvYcCWDiw4knyQ2sxqTLPSDpKP6rOvGP4G9YZwu9rqn3yhEdWc6vWmXyYezu2fUaeAKFFYxsKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdD4Tg7Mq29cfXQu1MfIK0AQ6RkUFX6Ry/gdLAqpz28RturSX3
	xQVe57jp+gbyeqBTWmlDYkowcO4LHoNHJML/0h9njO0yqqOUN1058Ccu
X-Gm-Gg: ASbGncto1kQEytjq2R648dMgiYDwKV9gqUhUm/yRg7o0/78xX3rbcB7+vsPitmLl30c
	fJWE6vT9ZvlL2L70faoMKC88lzVMm5icaCvITDQ0V1uoFe6aiMf6aVWLy+Gr7Df4eus34uGbwsl
	MhcD/YCKKqqLtckAKg0gwyNm+wzZXmYxDLh6rxU7uwU7F+mM1EQC6Z9M4mHeNJcx6DTaVbmmlnl
	gqrMyxdW/zlC+mIfB8q2lPN4l2SP+Hh2cU3WFm0LlK9cIDz9ZkRSaNlw1AmapSdXjlGJXkbnUau
	qMv9R1U/nQ51mp5RwFI8zwhttlBk63aR60RsvI1kKtaHTbDzM1SDhA==
X-Google-Smtp-Source: AGHT+IHSXVJ+zv8OK3ZIb6xoLC+yCdDOg+t6pGtX89QkSDHD9cmdKEk7CjPhmivk4Ehy2d+SJpCUaw==
X-Received: by 2002:a05:6402:2755:b0:606:c48c:fb8e with SMTP id 4fb4d7f45d1cf-60e52cd2cf9mr2278833a12.11.1751455269238;
        Wed, 02 Jul 2025 04:21:09 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c831ad416sm8825448a12.39.2025.07.02.04.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:21:08 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 02 Jul 2025 04:21:00 -0700
Subject: [PATCH net-next v4 1/3] selftests: drv-net: add helper/wrapper for
 bpftrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-netpoll_test-v4-1-cec227e85639@debian.org>
References: <20250702-netpoll_test-v4-0-cec227e85639@debian.org>
In-Reply-To: <20250702-netpoll_test-v4-0-cec227e85639@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3156; i=leitao@debian.org;
 h=from:subject:message-id; bh=WGfCbot+9pyl//CXCduVntkS6/EWBvdoFOZZ//nP+P8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZRYiV8zzTzkaKwX1zLm2LU8xus3S4e/Plrqpp
 VW1o9oHcH6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGUWIgAKCRA1o5Of/Hh3
 bbSYD/4oo99IbSaIg8X8K7EkchnmepT5VL9YdQKqL6vHq3TWkkPLW9Ber2TH659Oj9Sj44kGWxa
 GAYlE5U7Pe+lEaDbo5Iw1uYFpCYv03dzPQ+fB6oR3bpbyv1hau3+mNNBrrP2jknOxfnxbI5odwu
 czHJV83HLOnz2iRUPt4Y9gk4pOYxo34QxV7uPc07aVyXQmTf3KbTUlfjaFyPlecpVrxDvSVHBoO
 Mx8Ier9eNxyCOQ6ZGVsRHO0t2fwRUXjdvh3XmEy28jRa1hN7GqFJmDzimBcfIFl6JVj5Jb+rC/B
 nO4lJbdX6KtXCZIGIIAxXnRCwPk0aDFCrFr/3vVLT96Pf8mwFTbDf+g1mLhcoJKxua3HOV2RJp5
 L7iq+uc+O0L0o5NWdlNGTq9jvdUREBH7jDGtswOBiY+XcjHVbNyWvicAEHCQKzd1C6AxtiD5wdD
 pDhq+mZhIJhWbutVOB7T3nbP8Qhq7y6pfWhy8e4TI9NdcB3O0ZVuV58mVJcAwDufMgIKA1K5JDP
 Tgf3hS9pmlZNfrF3atfEh/j3vqHasKgSI03tYIe1DFkK+tjaACW36sf9P7cxNxk85oF675x4YRx
 fTK7Qj26nlPdFciZR4Z5Lhyavds6w8i2cElOq8+YhHTC6OSB2gk849slvnFTtaWC0T3BRA1cNAF
 XxcuvSfeaDzkIZA==
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
Reviewed-by: Breno Leitao <leitao@debian.org>
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


