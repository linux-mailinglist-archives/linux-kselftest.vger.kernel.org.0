Return-Path: <linux-kselftest+bounces-14895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A17949CC3
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 02:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CA41C2170B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 00:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45383321D;
	Wed,  7 Aug 2024 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic00qvMO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768B85811A;
	Wed,  7 Aug 2024 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722990294; cv=none; b=roDL/98TOI+rADP48rdsgnKjOe50ijZpwW7IcSqrMMmDnDT+ZHtIUYRfbwgHFBscR/5yUAhOPvaeSWQ6JHeUVYe5zob/YXW4pMmDZN6eWz03LEvsUsDyuniqpjO8X1KWLbKNP5OEwSSW+/GozmnD0UhfrqdR605HQvTNzwHPai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722990294; c=relaxed/simple;
	bh=B4s8mM7+iW7R/mJdPqaO3BtAqINuxt72Z3f+NHC+gLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZjcX97vj8ZzDkO/Mm7YNcIqFsiR1cKulzPPnkvpMAZsPT5t7W/gXiN2Q2+WeW8QGGW+WB7B9aDsCQqV/hAmTifhlgTa/ywYAzU0Y3D6G9blVvoqa29vrwQtmykdt3bvTZvPBwR2XlDOS/2TnYLYY84f9B8CNLvmRFc56L9vuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic00qvMO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428243f928cso8240225e9.3;
        Tue, 06 Aug 2024 17:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722990290; x=1723595090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rlJ8Qxx96uqoC0wa/4DCn4PPHCu0sUK/relMLFXVHZk=;
        b=Ic00qvMOhKHQDSUBrWqCctrZQrtLd2fgot86Hz9ChLDkGkE7QjCzNIvplyn8TUO4CM
         9pC9h7zSRFnPqy5dz6EVoWrFENis4SbzMXVvu0TkrVuYKihRLdOn0niqNXVIU5zkxCYg
         kwW5yUxEW8HcNS1YB8+4JvC4tZ9McF3GSEkcf1uc1zgpllPjhwf8YzoAcfAKzigtIvPr
         i84o2yLbDhqdEMJ6lVQi18490rl5wlVoetQGaWHJJ3gPy2c6cE92CB48aQR4MoDSyPvE
         ZYaovk7a/hCQFJ3E1Fjnrx3xU6kBKKmQM1ixOQMvx0tpRsm+KTz+Clx5onThSlpSJW6C
         OwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722990290; x=1723595090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlJ8Qxx96uqoC0wa/4DCn4PPHCu0sUK/relMLFXVHZk=;
        b=S4qmj+h22AACCxstvrmxrSfHGPykALL70cRP/IEaRivx/0v6nK0NOqN7TcZiih6Xuh
         CW5be7/xdfJTQid8i54Eqh/GYBJkVO/Mt0IqdBgAwhHhoDwiuHP+MIQctt1kZZSyfRPQ
         CNfeVUyqSJ1AyZX1uU7pn1mu3XDapNxai2K6iLbLZB2Nzc3hRxdvX7eTZvsllNty1yso
         UiBoNEHiZEtweRvMLJWpp4L0A1LtPDloFQfKvNaSDJnjRVcRYRrp0TPhpdgnenn346MD
         ylO0zpfCCKDFtSegoEkJmnFPboo1Fe0y9TydyfiLVbUZn5neJZYbjBq87WWNleLtRpS/
         DIdw==
X-Forwarded-Encrypted: i=1; AJvYcCWuqonZ+A+AZyZO/YtJVg1NazfFemyy2MHQ5lB5/kWt7KOduUclRNk9r5AOZukBhDnFW55cnyY8J/iZ/7nywaTJWrqhIGhNf32KihAwuVqE
X-Gm-Message-State: AOJu0Yzojzb+/lVw2+SQr1TQZXUBB/1ZWoOO0ZcSZyO4FeO7iMesMGZy
	Pi2v4rE68PQZ6nKA+We/Ay0207TJBoWyz2pzlEFV6hKZqVWEh42wYhKAZATu
X-Google-Smtp-Source: AGHT+IGdlDA4sF2ZIa1sRjJI8B+Jb9yPHf2rt5XTiWkN+N6bF1x+qfzaVHADSWOLC8KlnIZSBp2/ag==
X-Received: by 2002:a05:600c:3585:b0:426:6945:75b8 with SMTP id 5b1f17b1804b1-428e6b93fcbmr111346975e9.31.1722990289951;
        Tue, 06 Aug 2024 17:24:49 -0700 (PDT)
Received: from localhost (fwdproxy-cln-013.fbsv.net. [2a03:2880:31ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290598e970sm2844925e9.24.2024.08.06.17.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 17:24:49 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: shuah@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	petrm@nvidia.com,
	dw@davidwei.uk,
	przemyslaw.kitszel@intel.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2] selftests: net: py: support verbose printing, display executed commands
Date: Tue,  6 Aug 2024 17:24:45 -0700
Message-ID: <20240807002445.3833895-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add verbosity support to show the commands executed while
running tests. Enable verbosity if either an environment
variable 'VERBOSE' is set to a non-zero number or it is defined
in a config file under driver tests as discussed here:
https://github.com/linux-netdev/nipa/wiki/Running-driver-tests.

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
Changes in v2:
- change verbosity_ctl to set_verbosity
- remove redundency in the code

v1: https://lore.kernel.org/netdev/20240715030723.1768360-1-mohsin.bashr@gmail.com

 .../selftests/drivers/net/lib/py/env.py       |  6 ++++-
 .../testing/selftests/net/lib/py/__init__.py  |  4 +++
 tools/testing/selftests/net/lib/py/utils.py   | 26 +++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 1ea9bb695e94..c7cf52d9b988 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -5,7 +5,7 @@ import time
 from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import ksft_setup
-from lib.py import cmd, ethtool, ip
+from lib.py import cmd, ethtool, ip, set_verbosity
 from lib.py import NetNS, NetdevSimDev
 from .remote import Remote
 
@@ -31,6 +31,10 @@ def _load_env_file(src_path):
             if len(pair) != 2:
                 raise Exception("Can't parse configuration line:", full_file)
             env[pair[0]] = pair[1]
+
+    env_level = env.get('VERBOSE')
+    set_verbosity(env_level)
+
     return ksft_setup(env)
 
 
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index b6d498d125fe..eb4860dea26a 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -1,8 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import os
 from .consts import KSRC
 from .ksft import *
 from .netns import NetNS
 from .nsim import *
 from .utils import *
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily
+
+env_level = os.environ.get('VERBOSE')
+set_verbosity(env_level)
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 72590c3f90f1..d475f131a598 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -8,11 +8,35 @@ import socket
 import subprocess
 import time
 
+VERBOSITY_LEVEL = 0
+
 
 class CmdExitFailure(Exception):
     pass
 
 
+def set_verbosity(level=None):
+    global VERBOSITY_LEVEL
+
+    if level is not None:
+        try:
+            level = int(level)
+        except ValueError as e:
+            print(f'Ignoring \'VERBOSE\'. Unknown value \'{level}\'')
+            level = 0
+
+        VERBOSITY_LEVEL = level
+
+    return VERBOSITY_LEVEL
+
+
+def verbose(*objs, **kwargs):
+    global VERBOSITY_LEVEL
+
+    if VERBOSITY_LEVEL >= 1:
+        print(*objs, **kwargs)
+
+
 class cmd:
     def __init__(self, comm, shell=True, fail=True, ns=None, background=False, host=None, timeout=5):
         if ns:
@@ -22,6 +46,8 @@ class cmd:
         self.stderr = None
         self.ret = None
 
+        verbose("#cmd|", comm)
+
         self.comm = comm
         if host:
             self.proc = host.cmd(comm)
-- 
2.43.5


