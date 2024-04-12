Return-Path: <linux-kselftest+bounces-7806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2488A3041
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45769285D05
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C799A127E09;
	Fri, 12 Apr 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsvBjlft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06FF127E05;
	Fri, 12 Apr 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931283; cv=none; b=ihozPAVwbjOkh7s6K7CrvvLNYMHQpMp4n8ntS8iR5qpE7oq18qJ4/9vDkYG4R/Q+if/KzVP5j5aOQDvROE9ETfE86N9IMLQh4zSMY3O8wiplBPDPE2iaNrCo/xVNDyuMvVm6bQTm8RAU90P7hF2jMnjxw7zIrKixMJz5+kIb0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931283; c=relaxed/simple;
	bh=dP5QqOirl1uC9rGfoUuyH11xukDtaHTNOtiy2HvsIFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riJ4j0uMbblvJg6nTEhRkCHmIAwvJDDiaIcDW0BoAfBJ8w4GAMeaT/3hn7j4NbyaqD5yol7msUXfT2UZP+5ZJNRGquLTC0ficHDrj3OjEEJrfoiukq26u0kR94gXcILmw/cIXYdm15RQYh5BsBAncjn4gDu4tS9yJPbatmidTXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsvBjlft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA00C32786;
	Fri, 12 Apr 2024 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712931283;
	bh=dP5QqOirl1uC9rGfoUuyH11xukDtaHTNOtiy2HvsIFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hsvBjlftrazRQk2k+Gk5mzgpU/MJOkUgUnPILJTO/yLiXWGYVjbM+zjyWfZdWjXcs
	 rNNybKPuOaaA9oPkYnzV3OvcklhQVs8C4xZSzFc2C+InKg1VokElhNphxtpKa+yaqp
	 PJnimrIoZVZDJ856eUCdftF1oc4O0A1AbfwZwlM5MeZQQWPy5HIpYRiUzhwU4FG0xp
	 EheWMhs8RFzrUoES3tEyCh9/uX/PZNaLU0XhieQE1VrhsZEkdeKvYXETuY5EDlamHd
	 GJVw/uSgjuU41QuGWK615DkIn+5W6mpc9agfMZEo476ACvzYTwCN+IGRCIkq5FqwEL
	 +4zcAVaBVLTWA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 5/6] selftests: net: support use of NetdevSimDev under "with" in python
Date: Fri, 12 Apr 2024 07:14:35 -0700
Message-ID: <20240412141436.828666-6-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412141436.828666-1-kuba@kernel.org>
References: <20240412141436.828666-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using "with" on an entire driver test env is supported already,
but it's also useful to use "with" on an individual nsim.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/nsim.py | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/nsim.py b/tools/testing/selftests/net/lib/py/nsim.py
index 97457aca7e08..94aa32f59fdb 100644
--- a/tools/testing/selftests/net/lib/py/nsim.py
+++ b/tools/testing/selftests/net/lib/py/nsim.py
@@ -84,6 +84,17 @@ from .utils import cmd, ip
         for port_index in range(port_count):
             self.nsims.append(self._make_port(port_index, ifnames[port_index]))
 
+        self.removed = False
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, ex_type, ex_value, ex_tb):
+        """
+        __exit__ gets called at the end of a "with" block.
+        """
+        self.remove()
+
     def _make_port(self, port_index, ifname):
         return NetdevSim(self, port_index, ifname, self.ns)
 
@@ -112,7 +123,9 @@ from .utils import cmd, ip
             raise Exception("netdevices did not appear within timeout")
 
     def remove(self):
-        self.ctrl_write("del_device", "%u" % (self.addr, ))
+        if not self.removed:
+            self.ctrl_write("del_device", "%u" % (self.addr, ))
+            self.removed = True
 
     def remove_nsim(self, nsim):
         self.nsims.remove(nsim)
-- 
2.44.0


