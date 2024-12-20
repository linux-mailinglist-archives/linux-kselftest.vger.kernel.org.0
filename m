Return-Path: <linux-kselftest+bounces-23630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B429F88FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 01:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F3216A9D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 00:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FDE17C2;
	Fri, 20 Dec 2024 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir9YPT2r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8514A05;
	Fri, 20 Dec 2024 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734654679; cv=none; b=pRht1s3bFNRg5p58r0yYMS0C22DgFl+ydoLCdx6eQfSHwGft/bGM/kIOQnG4OxbPqFW743iJt2r4m3GTdN3KXK0YbWOHHFNNv94Y0MoAevKY3DJp1KQN9A5gM3LUZJN7d7gE5fzuwRci0QRojJfu5yoonhliVmgUjd7nV4TbOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734654679; c=relaxed/simple;
	bh=J3ra6O/cGccT8BIJRsSBWIBWz5AIinU3xkRonMJQhXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AXg7ElhV3IWTzMTPKSwpmbJ8S0MhUoJ8Q39T0y9WJGRgtAaRL471C1XWjM3OOogy4x8uJ+uuIfXu0HuG2wvuJ3ObfWkPWLLjS9Ph92hBJozmfuUWjSDf7o4IKMxyhCXzgBuVjdpGCQWrk8eiewsuOHylKp5yGcRa/3P25HsJlO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir9YPT2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9FCC4CECE;
	Fri, 20 Dec 2024 00:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734654678;
	bh=J3ra6O/cGccT8BIJRsSBWIBWz5AIinU3xkRonMJQhXY=;
	h=From:To:Cc:Subject:Date:From;
	b=ir9YPT2rn89Rw595mm1FLlOnssEmkQswF8NI4ZtOBhLGK6A2WRA+TER7Uat2FUI5d
	 sPdwoJpgjOYBJt2ww9lBBYBQ2zYEPKw56QySYoXAo26xd7fIDIxTQuWu8Gd8CLo60V
	 SUI+DhaS1spFLx5ccWgCF9zEjpbqhjZ4mqF1ak6JMPEtK4JSdKb+nMAJRKV9H8ld9P
	 eN9ua1l4Wy9/PFdYFrGXJisS3g+sSG8eJbn4KO05tAt6OD0M/+i9fPXEmh1zEpiRms
	 SQpHWCV823OJ01RbwV7T2t4s5Cdk1Bd96gWg4AXiwLvYO87dzyMVqGw+6Pb+T5g7M1
	 cW6h/BNiQLEXg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: assume stats refresh is 0 if no ethtool -c support
Date: Thu, 19 Dec 2024 16:31:16 -0800
Message-ID: <20241220003116.1458863-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests using HW stats wait for them to stabilize, using data from
ethtool -c as the delay. Not all drivers implement ethtool -c
so handle the errors gracefully.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: petrm@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/lib/py/env.py | 9 +++++++--
 tools/testing/selftests/net/lib/py/utils.py       | 6 ++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 1ea9bb695e94..fea343f209ea 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -5,7 +5,7 @@ import time
 from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import ksft_setup
-from lib.py import cmd, ethtool, ip
+from lib.py import cmd, ethtool, ip, CmdExitFailure
 from lib.py import NetNS, NetdevSimDev
 from .remote import Remote
 
@@ -234,7 +234,12 @@ from .remote import Remote
         Good drivers will tell us via ethtool what their sync period is.
         """
         if self._stats_settle_time is None:
-            data = ethtool("-c " + self.ifname, json=True)[0]
+            data = {}
+            try:
+                data = ethtool("-c " + self.ifname, json=True)[0]
+            except CmdExitFailure as e:
+                if "Operation not supported" not in e.cmd.stderr:
+                    raise
 
             self._stats_settle_time = 0.025 + \
                 data.get('stats-block-usecs', 0) / 1000 / 1000
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 72590c3f90f1..9e3bcddcf3e8 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -10,7 +10,9 @@ import time
 
 
 class CmdExitFailure(Exception):
-    pass
+    def __init__(self, msg, cmd_obj):
+        super().__init__(msg)
+        self.cmd = cmd_obj
 
 
 class cmd:
@@ -48,7 +50,7 @@ import time
             if len(stderr) > 0 and stderr[-1] == "\n":
                 stderr = stderr[:-1]
             raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
-                                 (self.proc.args, stdout, stderr))
+                                 (self.proc.args, stdout, stderr), self)
 
 
 class bkg(cmd):
-- 
2.47.1


