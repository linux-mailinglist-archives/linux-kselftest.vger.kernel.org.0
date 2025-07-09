Return-Path: <linux-kselftest+bounces-36805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEED7AFE396
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 11:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D817540C0A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 09:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B648284686;
	Wed,  9 Jul 2025 09:08:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801B22DA0B;
	Wed,  9 Jul 2025 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052115; cv=none; b=ems1x4UyybA0y/ym7BhULmkjJ6OLBKqeNMV6VXiB1fwBuRDNA7TZ1rrmR1gpT5M7aPpZ7zThnTVTe56nOfQ3W7lfEJSIzmdlxKvhIOz+oGs9mLnUkQVs11ism74Z1XuT8qCCFPR20S4k4QZVj+iuGWqwJwqbMz5nO+iJKsi/oUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052115; c=relaxed/simple;
	bh=coIuyt+97yKL1i0Yaf+t+cLYvf7z/aHGft61ucHTU7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9o3NFgxxxcf2k3gVecEYUeWFJmumpdc21ig368ghiqVwdcSYfUVtwJyFgOWBXzbTGCMqYfiW5TKAfVeOKroVhfpi9mN/g50K8rzn/fekhEEzfKcVVf7Y75p6h4VRh4MQb84LB05bWH33uXUsjFwQUk+Gqj3lgv7sPJV8JHLfJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0b6532345so138756966b.1;
        Wed, 09 Jul 2025 02:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752052111; x=1752656911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IhsES15K+/vF99i1FysT8pf+kVRIfbOBsOi518P2bw=;
        b=fH8DkuHV8yMDHc7He0kflcM3Hg7yfRn8GHLwufvSrY9wyVCgREZ2dzhUxn7HtyOlu7
         TjL8+/Snmo8j3o9WS0YUojkk90tXlXrmB6xX4zMvOXYdNZwVc4tK7YYl9t8v7Sgv5hXm
         6Nwp5Dl0Qy1eWwbrXE2tpnAgNjtXyDLLi12nmDRnt5aV9T6CA/3kEHQIiOOHKsKgI/Un
         4dELZ8LiqOeQqo18kh2hsUxq4jegU8ZJUsr1hPuZT9LuZnSOqbQymLd5CmH/sy6ntz05
         /XAwMddqohPYSrgv54hMVRaKM1qCeCFz+3G3vA4WDvQKUHF3NuR7C6E3DiY28bonnfSo
         KheA==
X-Forwarded-Encrypted: i=1; AJvYcCXFGi80QbqTkqBHIfdg0chxmCxtyvyxDoSa9dQSUhDi1dKupMs4x+w31nkb3y5vugM4M4CrJfOQPWfm2qRt6nNK@vger.kernel.org, AJvYcCXdrO24LktG/Sh6Vq/KJvRABLb5MsR5bLph7GSz0zgwEuRxx3sD9kQ+RMIbjntHO7ZtVoY=@vger.kernel.org, AJvYcCXdwNvs2xjnfbTl5fnrh3zWzI9wfupmgibUm/QBIrijB3HDCV/i7xyj2z9AySp1tcvuPRlGnt3g@vger.kernel.org
X-Gm-Message-State: AOJu0YwtyJ0SE3Kly3KtKb0Mr14GtrJWNBmsytsvrz+aCpVe0A5iy30e
	ME9J/qt2MO9ncD8WXQNno5BLAMxbZPXeIMJLdfpb5ytS8Ivxog2Q/gAY
X-Gm-Gg: ASbGncsdvt1aw27/U5/dqKUvGOZLy7YkYNc9EEEnscC2nV3HhutuZ+oupw/yNWOfFpg
	NC4zlHelzUNfNkFaBlUwuz7p34IfByk1S+pu+9JY9mxdUCIdaUp5u6xT5q3mPISd+ZQrVKjfOLG
	VB+mE2doyZwDN2BMcWNwtS+ueAAL4M5TP/fFvbyuEuhWlCVrQGJ7UlyJBGMzV7qozSDABavcz17
	aFRxSIltZdknaWfvQsxxoVPP7a4s7nQoKsXC4gKOJoeU0M/b12oJoj4pkXBP67H903VYTulOugf
	1F3KbK0LpSGwE51LcniDpWXslo03mfVUAIpxBSfmhaVl2CmLON/nxQ==
X-Google-Smtp-Source: AGHT+IFm6izYbxWfDI5W78fP968wsUlWmaAR2DToUnTqsRqC4PtBDYkHebHKTcg2xVmMMzPz7AW10Q==
X-Received: by 2002:a17:907:3f0a:b0:ad8:91e4:a931 with SMTP id a640c23a62f3a-ae6d149a87bmr148528766b.26.1752052110962;
        Wed, 09 Jul 2025 02:08:30 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f692d101sm1079608666b.54.2025.07.09.02.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:08:30 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 09 Jul 2025 02:08:15 -0700
Subject: [PATCH net-next v5 1/3] selftests: drv-net: add helper/wrapper for
 bpftrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-netpoll_test-v5-1-b3737895affe@debian.org>
References: <20250709-netpoll_test-v5-0-b3737895affe@debian.org>
In-Reply-To: <20250709-netpoll_test-v5-0-b3737895affe@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3171; i=leitao@debian.org;
 h=from:subject:message-id; bh=Hh2QFmCQNBJJwPZAOp0hdcYrJqy0Em3ByaIHm5C9iTs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBobjGLglh3KfoXOLMo2JTVl00yUfLkWC+F9P++t
 69u+PupwxWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaG4xiwAKCRA1o5Of/Hh3
 bWqBD/9gqxOd6U8IcejxZEaNCpBpbXURKl1763CTR/kjLDNIbkBay++NKgyk5YWlonvyIcjrJdS
 dyBKxE1SnW7czCk6St2r3jqbbqpefcttGgLUONroAL2De8fDmBz/3YYkChxA9tr1+g6w0STMAIv
 EZ/iX8mkLLQ+Ah4fnddatHMnGzWJQlip11SvSAv/Gcd5j1xjEj959MUKs/5UyUQXu22iy2yCuCk
 /w5O2o/CxPCY+aArKOAJmK8bJ1KuSEneCfVhZo9cvnKfgrUg/sG9ZVA/yr7uFORZ92NPCuINS1s
 UP21F4ZdHZOEUsfd1GbLXSaICjwY+vJ8j/1i5PG/i+vwsNcHhNuUtFkjENFnLpG3DYqCPd6Cxkj
 itIFsO66BnWN0b+l/1Q82v22CdDLzh2yHx1V2vS/BimpaEIr/IMakTG+/nSJqfKV0zuezZ3ZzLr
 auk872EN3HgTloaJ1ck8E4v6zpEeE8kJgPSYxYIcY9eJeyu5c7tbtBlHOJngjrQUvdD+PuqzOgx
 ykCtGAuFYlvByIVZDOW/p2PwzNH1Bf99sel1L4D9Xj/wGKv7eh2haKOwtAGcA4cxAzqUqOeb1iq
 OoCO0tEDCReZ+RiHZg3F0f73sJ6HmSR7L11pdnuPtHh0oTEEfAxr4ePX3mwq3JfLIPcTU1CjDtI
 Axn2YilHRD3KqAw==
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
index fce5d9218f1d6..4e76fbb76b659 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -14,7 +14,8 @@ try:
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
         NlError, RtnlFamily, DevlinkFamily
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


