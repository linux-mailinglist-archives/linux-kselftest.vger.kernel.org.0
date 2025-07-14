Return-Path: <linux-kselftest+bounces-37229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19260B03B7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 11:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557931693B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 09:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9662F244684;
	Mon, 14 Jul 2025 09:57:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A6242D80;
	Mon, 14 Jul 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752487042; cv=none; b=WbbTy8SjBhKG1jASYAlBmvEAWO7eXxIaAAxa7Aspcf1Gt1qosOrutHCGsS9Z8iWKYnuMogFKG1llti45XsPrdjy4gX3QtqXmOxiFBxZLsC4fNs63Il+JwSslVoP22w142mFLpcy0Vme/qtq9Xu8qc1Bg/8G0gF1vUyNVxxF3NwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752487042; c=relaxed/simple;
	bh=ChshbD/9rJO9uQPsbip0xh1KbC5quEnVK0Zi0ND3pyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7WYxo3PtC4DsoQAXLMjOgRtK0ZF+GybXQw8mfJKbUkGouy1MmuY3xVdmk1wchEU1eV1frpuCVoXKDEdLN2riuL9SkI52Msskz8CFQ6Z6EkqLqFzO6sNV3eJFN4NLL8ijWOTvi+Xxe1d6TQElIWspRsWcxLHmWWPrOEUF7c+RkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae3b37207easo852943666b.2;
        Mon, 14 Jul 2025 02:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752487038; x=1753091838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmyjkGpa6kzgAyMB5Phrmt7+/790pSNzzlVYNcZMnAg=;
        b=n5mBXEntCENDgRfDCc/2PyxEOlS08pkW1GPd07ErR3APvZVx2VmCl265QuFwrLkW12
         aSipi/Iv/1BYCXGFrtYcqYQj0xZO3SvjQPl1oBKw9EhZrqMlPkaawu2YZ51fEnSTLPYA
         KBC4Y9ookw9/RO+P7jT61ukRtRKh1U2VWfTHvrrL8dbz8C41FwTvc626xb3K6zsNhknQ
         c3XK1qR5+wxOFosjfb63EzKxcrOv1usyaIjLDtW5o20AFxDoQ2ejhwTI7WIXA137cvm7
         fYxlAsuBVBDUy4qcvDvbf6aOYTJVPFSLdixKBWWsikMRyZ9+A4tA6HaD40nraNngYTA3
         PSHg==
X-Forwarded-Encrypted: i=1; AJvYcCUB7zM9Nf3M9p+clLFxk4CQNltYXu0UVa9Jr0itkz0vOivuaxso0UZNACNnnA9ZtLZvay4/kn6l@vger.kernel.org, AJvYcCWM5NTsng1sYx4xLn2fiieyooa5vKdMLPDbYY+VjtJnVQq/w/fHkEZFVTLKVMWsaWG08ao=@vger.kernel.org, AJvYcCXKUOfis8fK+9vct0T3gt3ohNcRdCe9v02c+8ZQ5VLIn4dbJ5J+Jtp0AmjhZhcIc5MOzOrmERN1cCwBloJBeWW8@vger.kernel.org
X-Gm-Message-State: AOJu0YxG5ZUU78gk7+TYoHqrsXXmN77PNc1MseYZMVo75jU5L7oj342m
	EXZ6xILMxth9pvDBoqFbBbP8R+NnF+PMqkvJ9lUs0byVDdUfEECe868yh9KMvQ==
X-Gm-Gg: ASbGncuTclKqeyiS10FbYYijOMwuWkk0h2woKvJK3F2vueJA6SzDo5zVS4GY94a7RTF
	syV545GsaSyyZ5LLSu9uySEF60+NUPrqNtsQA9SBsW23SuH91I/X9aX7uLYzTK61m4qjbdqm1ao
	V84pWghD9dhQ+9e5fSMySL4iWnsxVuTUleX9uutVJFxNqdE0ji0tOiRIPTzk7hWnBFfFzlDiEZ8
	pg/b34guvPbhGJfPSk1HUyFVi7ZzxgLbAhfsiwE12ZyVIHQsp8Y9KCpulEKKbuZIu0yiTd8SUyA
	NHFaNYrGHsWKKTvl/TN7IvQEw7+x8VesvzxaIPCmPOm3D6eBwxDo9Q/GIFjISAb21LqJt3m/szu
	b+0+V6XaelHdH5xTIDkkezMQ=
X-Google-Smtp-Source: AGHT+IHcl88k0CW/VbwwiMxugbd2UFi7hdYDKpU7l8lSt8dSo0lLgQ7HQEUJ436X21XoY75HnRDOAA==
X-Received: by 2002:a17:907:3c90:b0:ae0:1fdf:ea65 with SMTP id a640c23a62f3a-ae6fbc8859emr1316842466b.17.1752487037526;
        Mon, 14 Jul 2025 02:57:17 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7eeae48sm805749966b.65.2025.07.14.02.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:57:17 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Jul 2025 02:56:48 -0700
Subject: [PATCH net-next v7 1/3] selftests: drv-net: add helper/wrapper for
 bpftrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-netpoll_test-v7-1-c0220cfaa63e@debian.org>
References: <20250714-netpoll_test-v7-0-c0220cfaa63e@debian.org>
In-Reply-To: <20250714-netpoll_test-v7-0-c0220cfaa63e@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3301; i=leitao@debian.org;
 h=from:subject:message-id; bh=QHETBsAdJnyzm0pnaXYvDCa1NIF7Be7QLtou7j9sAGg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBodNR6KspuX74klBS5R2CyxZPqisdNrQVrdMiA4
 v7+kaunIHGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHTUegAKCRA1o5Of/Hh3
 bT5aD/97xKIgSGRyTGqKhSaWHpMXm6OcLabL/bMR+WRhjFDP5wk0ii0csTVPJsA/OCTfePzE1bB
 6SNUw9YP7+JcrY8C6WbN/UE2+zJjuWD0FtYRWkVYSCs4bZwE8Tgzsz0ISr2LdzP5IpppqluHchf
 A3DO5QfYmaNPnbqjGj8BVeevMeh1BnMhlKbfQU580GjBDJTPP3+Derut+63cPu6Xw7g7w28Zixr
 P6JNa/igiHVrARtXODIC3/Q8G7pNh+QhCvSi+XNiK7In/M5JRD5dwzcFlIJXfGLNgS8xsmXWFr9
 598v4lGuVlkGmaFQff+sJg0W2ODD1HrPkIMMz4BHcFZPA4O3M4C+nbwXYQivZkGvaEfAJbNbWmE
 og4MGCRPOxaVpuWwsq/sqxYU5lq2zBQ364evTj25AcHs/7L+GRVouE1zGqdOZ6HuLpOOv6VI+FZ
 tg0nlCakq2m1+hPGDpraF0rk7Gom1jA57Voxt4pBMxzZTTn5r+BwCa10f4QRj8qwzcgpnqkFlRn
 uP3KnVcsubBUEszNgLdjm+kvbX9bBUsG8ax8dCcY+XIsSaOZrSMlGE6qIKXN4vmh3R7tCzjxWKG
 Q6F/NEKvb8aq/qsI5RF4WYMcn5GkXL0BS7w+HwIVABGP5r23Qflf0h4YXQGlHWpzUxi3hC+C8f+
 AdoatGjtPkU6KaA==
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
 .../selftests/drivers/net/lib/py/__init__.py       |  4 +--
 tools/testing/selftests/net/lib/py/utils.py        | 33 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 39968bc3df43e..8711c67ad658a 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -14,8 +14,8 @@ try:
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
         NlError, RtnlFamily, DevlinkFamily
     from net.lib.py import CmdExitFailure
-    from net.lib.py import bkg, cmd, defer, ethtool, fd_read_timeout, ip, \
-        rand_port, tool, wait_port_listen, bpftool
+    from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
+        fd_read_timeout, ip, rand_port, tool, wait_port_listen
     from net.lib.py import fd_read_timeout
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index acf0e2c386144..5950a643a5336 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -189,6 +189,39 @@ def ethtool(args, json=None, ns=None, host=None):
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


