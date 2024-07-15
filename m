Return-Path: <linux-kselftest+bounces-13715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3552A930CE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 05:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26ABF1C20777
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 03:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7B48F47;
	Mon, 15 Jul 2024 03:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRY07tJf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68122F41;
	Mon, 15 Jul 2024 03:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721012861; cv=none; b=jI07W0QvK1/TGuu1VdkcL5U1tVuecF5Fv6K+30qQxGZ85hbwnlmfT+SO0QpMSDpA3ZrQ+gjthBmJEiJdPYAIWw5pj1rY1hVS1PCKStuEO8eiSCvg2J6916knL0mORtpQK4zO7pgpZ5sCMWZ7IEIjMFyD5jPHbkvfJ2oUpWeMpJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721012861; c=relaxed/simple;
	bh=nvkTLskiSjR1wEWCGet8hWznszuqHulbDw6SUh1768k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwJtP4TtomDmy+ICv1YEWhxcstsszJ3OtFJZMQ27f7lzLg9r+p+h4lXWu4+/UGoryYIdWqxd8jjHEbdIVL4dRO0AwtjsEIExIcKPdhU4tyoPBiAaoL475n48l70B1ayaiBbalM2fwURBILnZx1ZoXwp1h+RMUDwVspFuuWaO+ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRY07tJf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-426717a2d12so21976805e9.0;
        Sun, 14 Jul 2024 20:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721012858; x=1721617658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bPOGNQoOVZHDwCKu6mfQ/96DtFXkwzO8aleJ5SEVjrg=;
        b=GRY07tJfkDbz1eOfab4icOLaSIlQ7Uznx9KCvPHYM6OdaGWkBBvt37VAtqp/vDV/dr
         FxPJjy4A/IKmULtLOVbTxOPXOMCgtnfigOO9TGlif37cjyZFDeh53bS1lkeg6gBQ3Qhw
         /ZDcbOj1pibPW9CuJI2P3WN4a/CutKhtF7oQSeAlxKOU/jg56/sRAxxRAQy8Yva/Ve4F
         lCrHE0kH7jxINHjCZFmTENJO3PQmkROz9XFB4p3TEKiMjo9bAaGiWuLvZGciuBPvICUQ
         8KIqHn2ec6t03UHWsiTG8TzpA75i9srGIgx3EwIyg4rX8WwBXDrQCCHvCcfIzhH6FMPO
         chdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721012858; x=1721617658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPOGNQoOVZHDwCKu6mfQ/96DtFXkwzO8aleJ5SEVjrg=;
        b=a06ieK3sgvAU0q0afeY396tXORTaXpkPBHEL5fMs0vub/jgxlY9cBVnXrE4gBLgPcE
         QEUzdMNLaMfCqvh1mFAraTDb9AxY69zhU6v6mLFJ0Pq1TWOZf2Lg2ktcnmNreauY0JHP
         gsAl+yu9f0OrhHPsisV1J25Kg5N9Y/dHz5+hMJOt9QccAcl7cnStulRvJdw2AGSYn82w
         077SdJosZuUNsPLQzdfr148vk+P3bLGpCpVTJimHIAbQueV/7OiyU6M2zIepQNt34ESm
         HXAtHxqDJPFEHl4hFx5wP7/pUqIWvGwy4We7N9/1kCbg0bZ0LGUKg5jhSnKRo6HkyZG+
         sV0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuSshlogGzVgvCWbonGmttxCAlkgzSPJdXVDTpmrw8Hu8q1//EGu+jGltDgVStEEKYUk751KEeEx7871HciN8IH5TycH2MhGqUjmRmsA7+
X-Gm-Message-State: AOJu0YwpGBMEL+7N5Ursq9xW8drMJnDCz9dyQwtA/Rhu18k4cIq9ZHHD
	scjq8efExy4EtEbCMwCY08UcxDUoGsq/AixwiVAGZU8OxHSrYoUBZ4snery0
X-Google-Smtp-Source: AGHT+IFwhBEgWJHb2mzcvstXAEuLa5ItlvPmIFzGZG7TBwdVd/xBshToNvarAlausdQ5IyN1qU39qQ==
X-Received: by 2002:a05:600c:714:b0:426:67fa:f7 with SMTP id 5b1f17b1804b1-4279da067dfmr80624865e9.9.1721012857685;
        Sun, 14 Jul 2024 20:07:37 -0700 (PDT)
Received: from localhost (fwdproxy-cln-018.fbsv.net. [2a03:2880:31ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a630b218sm66150915e9.14.2024.07.14.20.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 20:07:37 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next] selftests: net: py: support verbose printing, display executed commands
Date: Sun, 14 Jul 2024 20:07:23 -0700
Message-ID: <20240715030723.1768360-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.0
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
 tools/testing/selftests/drivers/net/lib/py/env.py | 14 +++++++++++++-
 tools/testing/selftests/net/lib/py/__init__.py    |  7 +++++++
 tools/testing/selftests/net/lib/py/utils.py       | 14 ++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index a5e800b8f103..ec53cf59e104 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -4,7 +4,7 @@ import os
 import time
 from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
-from lib.py import cmd, ethtool, ip
+from lib.py import cmd, ethtool, ip, verbosity_ctl
 from lib.py import NetNS, NetdevSimDev
 from .remote import Remote
 
@@ -42,6 +42,12 @@ class NetDrvEnv:
 
         self.env = _load_env_file(src_path)
 
+        try:
+            verbosity_ctl(level=int(self.env.get('VERBOSE', 0)))
+        except ValueError as e:
+            print(f'Ignoring \'VERBOSE\'. Unknown value \'{self.env.get("VERBOSE")}\'')
+            verbosity_ctl(level=0)
+
         if 'NETIF' in self.env:
             self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
         else:
@@ -92,6 +98,12 @@ class NetDrvEpEnv:
         self._ns = None
         self._ns_peer = None
 
+        try:
+            verbosity_ctl(level=int(self.env.get('VERBOSE', 0)))
+        except ValueError as e:
+            print(f'Ignoring \'VERBOSE\'. Unknown value \'{self.env.get("VERBOSE")}\'')
+            verbosity_ctl(level=0)
+
         if "NETIF" in self.env:
             if nsim_test is True:
                 raise KsftXfailEx("Test only works on netdevsim")
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index b6d498d125fe..1541079fadce 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -1,8 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import os
 from .consts import KSRC
 from .ksft import *
 from .netns import NetNS
 from .nsim import *
 from .utils import *
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily
+
+try:
+    verbosity_ctl(level=int(os.environ.get('VERBOSE', 0)))
+except ValueError as e:
+    print(f'Ignoring \'VERBOSE\'. Unknown value \'{os.environ.get("VERBOSE")}\'')
+    verbosity_ctl(level=0)
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 72590c3f90f1..4a59958649be 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -9,6 +9,18 @@ import subprocess
 import time
 
 
+def verbosity_ctl(level=None):
+    global VERBOSITY_LEVEL
+    if level is not None:
+        VERBOSITY_LEVEL = level
+    return VERBOSITY_LEVEL
+
+
+def verbose(*objs, **kwargs):
+    if verbosity_ctl() >= 1:
+        print(*objs, **kwargs)
+
+
 class CmdExitFailure(Exception):
     pass
 
@@ -22,6 +34,8 @@ class cmd:
         self.stderr = None
         self.ret = None
 
+        verbose("#cmd|", comm)
+
         self.comm = comm
         if host:
             self.proc = host.cmd(comm)
-- 
2.43.0


