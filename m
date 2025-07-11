Return-Path: <linux-kselftest+bounces-37131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9736B0212B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 18:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193BA5A27B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBDE2EF664;
	Fri, 11 Jul 2025 16:05:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4FF2EF2BA;
	Fri, 11 Jul 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249926; cv=none; b=WT5lRU7OhOiXoX8HWhh5e9sslngblyJprc+sHM328zs4Im99aV7YoJl6nVqelq2uYaO0wfjVa9ZK8KVZc8UEAsjiTpdPG7aecJxSEMh3YCpgvC8TYqJWy38FPNdW+fe0xRnPZdPySIEr4Tng4i+X26hze8PjzLgqBOshOwmO36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249926; c=relaxed/simple;
	bh=coIuyt+97yKL1i0Yaf+t+cLYvf7z/aHGft61ucHTU7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HhrS4xFeKzsWVV7l+NZo2ePEGFbJu8Prjdl6Z+TtcPyzy8sqEiYAS6wkowfPImRhwtm+eYNCYaXcPqxjArEXrTZoJrVnugVSeXxx38uQ+NpxjZGACnXxjgJqFZSeFctzC2heEQ7/TO1MBwf5A+tjBXrIjh4Q0amJ0hqTrxiNgyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso396482466b.1;
        Fri, 11 Jul 2025 09:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752249923; x=1752854723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IhsES15K+/vF99i1FysT8pf+kVRIfbOBsOi518P2bw=;
        b=Oc/itH8oOPexJaDFZworf2RpmU/cg/0HfT+MUI5LEhOyP8vtRILnN+miTCdhjmKTx7
         vz2l76Dlac/QcgHLcNh0b4HoxBjk/BSQ/4ABRydemsCqQlEPPLX1E51waaWCCm9Vry4k
         0LfKcabtWa/w6F+1HCcDX88fo1O1T/1bXquu4/Dba49V/TygX84hGxlr7HZWnUcAEl0R
         Y5uUn2pZK9h4FO7ZwmgM/H01IqbuVTUgGAy4OXdCD8HbCpq/PJCkX1eLw2GTggPKmVq0
         pC3QsRO/GLsv1Bv4qx/DUyoNCe5w0QjdTP+YjJvDtqbHIWTuBwNunTsOgaNUczz6Kh/n
         JkiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKrTcwOx3e2TXviwVSGSXjzcUn3GEXu8EAiZpwja/4sSeDLZnbhw1N0WAriKaST9P925I=@vger.kernel.org, AJvYcCW1j4MAzpYq7990JPTf+jHSBYgByb9AJOMwKKQLGZKCOSvidGk/AuKlcVQiS8C6h+rc/n6i+tWA@vger.kernel.org, AJvYcCWG2vr18kjJUDqtn/+8tUYN72F7PMa5bUxlOhxZvwDUn7HqJljXiFO+zyAgyuuPWvZ8BD1oF8Toh/6qNBk220N8@vger.kernel.org
X-Gm-Message-State: AOJu0YwgWg9vLfMbgi296yGSJ/isaQcsAw8PMEajybeEXheNvTmTIKLz
	UCIUgu51Dpd5si+Krf0jJlO1YD8xB7JcD8yssY2IRRUO0mTwpBvcuW8r
X-Gm-Gg: ASbGncuZui0UJ57jLPQMrJhEpTwnu+Zm+9UkfoBrQ3li5h6ItyuH3/8Vet6Ji8wEGCd
	QxD4IGdUGRSg+XBbF8VS0T8es+jA2aJ12X6RrAdfOA/zNaXnLSkBgbaXoXkWXNlWr6qcM17QHfq
	7SPezD7LaNw28peF0JFmacqX0on3LrFNI794YzvyWrWCHEmTmAEf22trWEsz1n6pJMx/muymayg
	PpVPGoIi6YgFAy2Fsp7tV56rWLYTjdWFIKafWg8fSeQrOkPSk1mogHkUUujvnTKzI0oJOPkmY2y
	PayFItkpo3bpy/Y20Mka2+WtGzmlbc7gH85BqXp7XM3WwDxMwdsCpfUYUS+CJ0DJSumjCoY26kI
	QvOQiJmDkPhZD
X-Google-Smtp-Source: AGHT+IFBlDtEH0RCsrlU3uTsnOYvjFtmKwYrM0BxvXNhln2S03J5tV3SGlXcZtDrbZrrQl6iD/1PmQ==
X-Received: by 2002:a17:907:96a9:b0:ae0:bdc2:994d with SMTP id a640c23a62f3a-ae6fc3da7dcmr442875766b.55.1752249922076;
        Fri, 11 Jul 2025 09:05:22 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7eec2a0sm318979866b.67.2025.07.11.09.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:05:21 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Jul 2025 09:05:09 -0700
Subject: [PATCH net-next v6 1/3] selftests: drv-net: add helper/wrapper for
 bpftrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-netpoll_test-v6-1-130465f286a8@debian.org>
References: <20250711-netpoll_test-v6-0-130465f286a8@debian.org>
In-Reply-To: <20250711-netpoll_test-v6-0-130465f286a8@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBocTY+MxxHHPhqusTTtwGG709Jf5ErgCSIW/EBC
 ID69C6apXuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHE2PgAKCRA1o5Of/Hh3
 bZ74EACRnIHXnpQrxCSOMAN/hal63q8013QLqCV3ZmTk2CHElinGUUsWcz7FWcT1iI97BHrUIi9
 w93Jwr5OKix87yYxAgRnDe7+aVpAKjG65czEpHYA3/Hag6NOcgLz1w1wTQm+weg2+HnfjaEru+w
 cGejE1EnwXNJhsT2xxraQYMalotIjP/OqxojkZ134SXEScgVaMV9ECCI1lm0s9lfbgQN7V1mFiT
 K4h9q4dvW5uJCDVAgnIL+dvbOj8Vj5BSw1hkkxjBhGWa9RyXK17INi7UYVymn9HQTusv5W9ionn
 nSZ4cWap0dRFgSCfTQeRgc1AlvzpaMMGMOlxjY0VFhFBNfGuPF4Dd/7da3ae57uRcWYPBKwjhmB
 NhopaMjGJFE5BqBAbMdpdwfRcKIQ/HnSSAdE8BWOkqRhxQhyx3wRVsHvxllbujJD33KJOcNlXpL
 /2uVD1mwMRFufPJcyGdGLe44uWns39RS/B3r+YYMGQm42scYrRrQ0Z/0J4ajTjxjnmdbRWh7THP
 W+X81UMRmfsktzVkIYJuMaeu/h21J7q5AkXO9InxoOYRrIKbXMQ0Qz0eiWmeo43ezaSG+giobcE
 9h3Ciw6l33sHfOVpnJ2GfBq6uY+9poxwUF3zJ5BJJEGkEa9w3g33bh9AmStiLAZfj30gkhWzNUA
 Gcsh/Hbo4tPf6Vw==
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


