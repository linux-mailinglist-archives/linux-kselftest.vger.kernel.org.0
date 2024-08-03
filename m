Return-Path: <linux-kselftest+bounces-14757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E88C99466F4
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 04:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 572E6B2148F
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 02:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D550AD4B;
	Sat,  3 Aug 2024 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUhp/iXr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B02D53B;
	Sat,  3 Aug 2024 02:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722653911; cv=none; b=hT9GPifI6ZBoI8If/z2JN7w/6iW6+pKZVBfMsB0/M54uRubYChy0M2ENBDnSXJ/E2u7CDwrunpbA4q9T3RzD9RTU6aryUgCXL+DNgLvEKV7IjigEeikMyUaZopJOYAr0IvxhYw2O3D1KKYI8BDaZyJpBbUQdqvoyuZjzxD5q+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722653911; c=relaxed/simple;
	bh=nvkTLskiSjR1wEWCGet8hWznszuqHulbDw6SUh1768k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3g2oVhhjaXNOcUTwcZvuLT5K1H9MyeVqwKYhBapGLZURRJvwPjx97tYgEBNoBZeZ+kl63DcJ5qpVmm8gidwhTzTuiO11ojoiUMjqZcN3bZosmf2EaQiaaXq8jzZP+UgZVAlAUo498WD6rHsIX8aQwsk/355PZKSKcH6XeuJVmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUhp/iXr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428243f928fso51725075e9.0;
        Fri, 02 Aug 2024 19:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722653907; x=1723258707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPOGNQoOVZHDwCKu6mfQ/96DtFXkwzO8aleJ5SEVjrg=;
        b=cUhp/iXr7jBo0EhKQhL/xhg53JXsOX/l0lY3HTDw9Ap3A15Tuc6lICxoogmqAgdSY6
         3q0MC9V2M7X3MYoMDqElTOd5aeXyg8UqhG/vRwOZgjp2uaNBCrIaf8rCZXk5GCqsLobF
         78VQDeXjEuEa49aW3/kPeSHWFWQ1F48YGqZncknEcT7QtutPAK7Sdd9HRgHTZWgyMBRW
         2uyJN8mBod6OrYS3R2rbqSqzEgkAeTY/Gi1QvDKLHcKBkqac7IMqXWdupCsaKtsC+vqh
         HDhtUHrLapVd65vHSTWEYmft3lg/F3t9DB8qDhwHd93DHYwhidl/GYZZhEEgTVIiW7iX
         RXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722653907; x=1723258707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPOGNQoOVZHDwCKu6mfQ/96DtFXkwzO8aleJ5SEVjrg=;
        b=FKt8uE2MFTtr2kpm2VGfjbMqHsayx05nJKiR/MZhneigOfp68IDQlMiJxv1YGTfKby
         251+CiNX3OpJXSR0MFrmPqEY4HvJW/g0mI8aM8zohsAs9p0M0kI9XUnIobfrC+GAGs2a
         zJsMRPdmAhcLDdtTuxWfBWGBGGhkCK7vvpSETsoYmvqilg57TgHdyMpaaKo0dsJ24pMO
         Cvwe5lcV7U23h0p9ykJ+3QWbGSpJemQWyrSsCazO7Qf4fRbKi/XMQYajZkmVrGVeOD0C
         bOx23a6iO1cZDWMEzQLp/CihixAvvbgWpXbC+MqRJ+s411XDFPQm38s7SlXRJaRmqBVz
         D31A==
X-Forwarded-Encrypted: i=1; AJvYcCV7yF79Hab555vOa3sw+fvR+ec/IItrDHFxIFGVEkHvcnR5jcZnfEjqnM4AvhE17g/aUeT2UsMnos0yg/ytKI2RfnCDit+c+74Ilph8IhyI
X-Gm-Message-State: AOJu0YzUQzSQubTVZhmfpyaEGF6LOnJSY4zJ7I8y4Z3deLT1W+umdFxa
	DmQ73MEcrDlcQ0PNOzvB30CtaRNOolXV713UxljwbyuxtRaACj2zhoDgSfST
X-Google-Smtp-Source: AGHT+IH5yFQp8sN2zNZuyARDBFzkp8I+/2l99N/SK+7YiO0hHq6HcBK/a6EsVdx8TIlxFBtVAin1SQ==
X-Received: by 2002:a05:600c:5102:b0:428:29e:8c42 with SMTP id 5b1f17b1804b1-428e6b0239dmr40835555e9.9.1722653906845;
        Fri, 02 Aug 2024 19:58:26 -0700 (PDT)
Received: from localhost (fwdproxy-cln-021.fbsv.net. [2a03:2880:31ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e9d1edsm50887775e9.40.2024.08.02.19.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 19:58:26 -0700 (PDT)
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
Subject: [PATCH net-next] selftests: net: py: support verbose printing, display executed commands
Date: Fri,  2 Aug 2024 19:58:09 -0700
Message-ID: <20240803025809.674347-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87bk2yrkcs.fsf@nvidia.com>
References: <87bk2yrkcs.fsf@nvidia.com>
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


