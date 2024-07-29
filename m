Return-Path: <linux-kselftest+bounces-14403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB5C9400ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 00:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020FC1C22235
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A3118EFDF;
	Mon, 29 Jul 2024 22:10:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D6918E75C;
	Mon, 29 Jul 2024 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722291048; cv=none; b=V7wQpQuUbQWPUkg/DgxJLiI6xcEpkJMrkx8kyq4+JYyAdDx8AebjsfgKuCrMccf7HqAqYcowX3SpWc9C5RNSZp8LftiXIlI5qZv2A2jb5Zr8lCerDmmnV/Y2QeoOfXZ9sJhzoJ4PQ8XTVloo306Pt2CJ1CaidG6z87OqL7ObIHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722291048; c=relaxed/simple;
	bh=Dk214mxztzvWyeIrTyzDucKVtnvYCgeVAsvCu+M+ruY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYZ+vG6DFLE3hng69rGCHb1y7FGtrzv97zZohrlu04qpu5xgdQRD8k+XESHmg5vXaAAjIc+sIzB12K8jhdo3YZs2w4BJCwfUFWW/n3/VFu4VRcex+ecUE+qMY9h9Z36TiNmZ2fJ2SRRwhTEjPjCsoRYbNBvbS9Zhzk7yOB4oxLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso2247887a91.3;
        Mon, 29 Jul 2024 15:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722291045; x=1722895845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOiPyoNdl7TPztzL8etHRqD2fbBoXV6bGhf/vraszoA=;
        b=f2rVWuSuSSfumCCLoWexB0Hk7x3jJc1VncYx5FzavRnasDoK3HUqeOJo6RyGwSni54
         HnbEpl5dbkJR2OXkpa4sAbXQkfUtBpCCbzvFcszQa2alRtk6UjaAzwzXBB/DSWEHIQNq
         lpK41srJd+WPRV85Pwcaig/QcOb8hZtOc6njSX1xtwPXHQCtxvyRr6pN1T13pXM1jhOc
         X5X0fPLG9kb6+wUsC0dCodLWYP4obaojMVofu+4p0cf25E9ChSrsOqNyB2XKfP+2pMIw
         VjpLcKCvFIXyUEDNVRHZwzmFvdnVtY8OQYlURB90D71saIklhD2Pxeu0cs/LDi+rCsex
         uP1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8I8TbSyFoLUwMY86ydZkCLga7x3bJM/YO1alXou7cCeenjVl/7tA5t5JLb0Esth942UH2ULOj1VvfBIo/KYggrxbl9kqSsq39V8RmgmWv
X-Gm-Message-State: AOJu0YxTf+g37VL+A64l5eYB8UEyC1oHJHpT1FWlk2zwuY1GCm3xbUoe
	kNBVm0+qBgxQlCOQE9kF1E31/xqB1tV6oclF5/Sf7Juony6h1LJKpvCKJOU=
X-Google-Smtp-Source: AGHT+IF77MQGSfHl7ZRZR+Kak1oX9tNEjGEbERLvWXD/szso1fslZwK0vS+pGsdF0hoUyb5Se6h7Pg==
X-Received: by 2002:a17:90a:6581:b0:2ca:8684:401a with SMTP id 98e67ed59e1d1-2cf7e5f27a9mr7164747a91.32.1722291045284;
        Mon, 29 Jul 2024 15:10:45 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdba3e527esm10931103a91.16.2024.07.29.15.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 15:10:44 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] selftests: net: ksft: support marking tests as disruptive
Date: Mon, 29 Jul 2024 15:10:42 -0700
Message-ID: <20240729221042.2700882-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729221042.2700882-1-sdf@fomichev.me>
References: <20240729221042.2700882-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(not sure we want this, but just throwing it out there..)

Add new @ksft_disruptive decorator to mark the tests that might
be disruptive to the system. Depending on how well the previous
test works in the CI we might want to disable disruptive tests
by default and only let the developers run them manually.

In the future we can add similar decorators to, for example, avoid
running slow tests all the time. And/or have some option to run
only 'fast' tests for some sort of smoke test scenario.

$ ./stats.py --skip-disruptive
KTAP version 1
1..5
ok 1 stats.check_pause
ok 2 stats.check_fec
ok 3 stats.pkt_byte_sum
ok 4 stats.qstat_by_ifindex
ok 5 stats.check_down # SKIP marked as disruptive
\# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:1 error:0

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
--
Cc: Shuah Khan <shuah@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/stats.py |  2 ++
 tools/testing/selftests/net/lib/py/ksft.py   | 22 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index 6f8bef379565..04508894ef9c 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -3,6 +3,7 @@
 
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_ge, ksft_eq, ksft_in, ksft_true, ksft_raises, KsftSkipEx, KsftXfailEx
+from lib.py import ksft_disruptive
 from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
 from lib.py import NetDrvEnv
 from lib.py import ip
@@ -134,6 +135,7 @@ rtnl = RtnlFamily()
     ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')
 
 
+@ksft_disruptive
 def check_down(cfg) -> None:
     try:
         qstat = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index f26c20df9db4..f6545a45942a 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import argparse
 import builtins
+import functools
 import inspect
 import sys
 import time
@@ -10,6 +12,7 @@ from .utils import global_defer_queue
 
 KSFT_RESULT = None
 KSFT_RESULT_ALL = True
+KSFT_ARGS = None
 
 
 class KsftFailEx(Exception):
@@ -127,7 +130,26 @@ KSFT_RESULT_ALL = True
             KSFT_RESULT = False
 
 
+def ksft_disruptive(func):
+    """
+    Decorator that marks the test as disruptive. Disruptive tests
+    can be skipped by adding --skip-disruptive argument.
+    """
+
+    @functools.wraps(func)
+    def wrapper(*args, **kwargs):
+        if KSFT_ARGS.skip_disruptive:
+            raise KsftSkipEx(f"marked as disruptive")
+        return func(*args, **kwargs)
+    return wrapper
+
+
 def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
+    parser = argparse.ArgumentParser()
+    parser.add_argument('--skip-disruptive', default=False, action='store_true', help='skip tests that might be disruptive (e.g. restart the interface)')
+    global KSFT_ARGS
+    KSFT_ARGS = parser.parse_args()
+
     cases = cases or []
 
     if globs and case_pfx:
-- 
2.45.2


