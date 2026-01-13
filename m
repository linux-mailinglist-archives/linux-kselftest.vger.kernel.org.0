Return-Path: <linux-kselftest+bounces-48801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 479FCD15EE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79E1D300F6AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3836014B977;
	Tue, 13 Jan 2026 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ont3oInv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1EA3B1BD;
	Tue, 13 Jan 2026 00:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768262869; cv=none; b=CU8MhCdJ9FdexaZ+Fzo4l3axmv2asB7CnD5aNWnsL7XG++3XtHNblTWtU01OojROQMQOJUht6iEApLPAjN/yyoU6FCZnh08OhATpO/QwPpS4Wr5ttwD1Cf+YP7oxCiiBoEgaoqnkKWA10QJI6OsRGdY8U+9URocVCAZncaiL2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768262869; c=relaxed/simple;
	bh=ZWljSR+mSpCIJT+Osbk6hlYEZGtK5JiLKgJeMKBM5Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROffKRsGlFU6sGqQ084h4Iwn0pmRHlxg6kUH45iKFkI50/bPF3uN5u0kglQ/tHlcqQSwR0kBYWyWRiR/EMDDm2k1kGO0RbszWEY1r2zvBdNz8qNhCVErCDf0RrgBBDpAI78Xk7/Yv+cWImcqUvKzYrddupDLXUzxVInW5kso/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ont3oInv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8FFC19424;
	Tue, 13 Jan 2026 00:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768262868;
	bh=ZWljSR+mSpCIJT+Osbk6hlYEZGtK5JiLKgJeMKBM5Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ont3oInvxUCl6yolpUNTf1nThcjlTy+IO8r5wXjF1lcCNAUhgedP4brrCWiVDSHdy
	 PDW0ksCeq4OjAw9V2zeXSKh6+wKdMV2v9pgTUglT0hH86xM5F25/tC4LGlfe6NkTuz
	 G6poSVD0X6Cg6FteVO5MqmZbPrK/hT7oirZxM9Ll7RVXdS6rdIAMpXFvBrjrf9ht/F
	 JdlAIek+4AvxTE/uLBf+JhE+qydO40g2+wxtH3tH3GUzYJ6k/PaZYBsa6AX+EedWJn
	 qjZ7rGqcqP2zyunUY+2DLtPi/M+lnwrkmAaIt9Xp5KpRMk0ytF2/e7JSesEd8otQL9
	 8hKfoentvnHiw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 2/6] selftests: net: py: teach cmd() how to print itself
Date: Mon, 12 Jan 2026 16:07:36 -0800
Message-ID: <20260113000740.255360-3-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113000740.255360-1-kuba@kernel.org>
References: <20260113000740.255360-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach cmd() how to print itself, to make debug prints easier.
Example output (leading # due to ksft_pr()):

  # CMD: /root/ksft-net-drv/drivers/net/gro
  #   EXIT: 1
  #   STDOUT: ipv6 with ext header does coalesce:
  #   STDERR: Expected {200 }, Total 1 packets
  #           Received {100 [!=200]100 [!=0]}, Total 2 packets.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 824f039d384c..37243103aee3 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -41,7 +41,9 @@ import time
         self.ret = None
         self.ksft_term_fd = None
 
+        self.host = host
         self.comm = comm
+
         if host:
             self.proc = host.cmd(comm)
         else:
@@ -99,6 +101,27 @@ import time
             raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
                                  (self.proc.args, stdout, stderr), self)
 
+    def __repr__(self):
+        def str_fmt(name, s):
+            name += ': '
+            return (name + s.strip().replace('\n', '\n' + ' ' * len(name)))
+
+        ret = "CMD"
+        if self.host:
+            ret += "[remote]"
+        if self.ret is None:
+            ret += f" (unterminated): {self.comm}\n"
+        elif self.ret == 0:
+            ret += f" (success): {self.comm}\n"
+        else:
+            ret += f": {self.comm}\n"
+            ret += f"  EXIT: {self.ret}\n"
+        if self.stdout:
+            ret += str_fmt("  STDOUT", self.stdout) + "\n"
+        if self.stderr:
+            ret += str_fmt("  STDERR", self.stderr) + "\n"
+        return ret.strip()
+
 
 class bkg(cmd):
     """
-- 
2.52.0


