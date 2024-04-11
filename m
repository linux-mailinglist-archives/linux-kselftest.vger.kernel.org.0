Return-Path: <linux-kselftest+bounces-7666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC94C8A058B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8589E1F2334E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1D0763EC;
	Thu, 11 Apr 2024 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHMSyPci"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B7762CD;
	Thu, 11 Apr 2024 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798923; cv=none; b=RiY2scWKiZ+vZ76D1nwbHeDcWRd0KnDTJ2OP3d73f+3zuztZmUV1mb2HYPy2IrkNvjdamsw57rVIM4L07diTLpfy3CRTUwGAP2ToJ5/tVLZfdM4C5HAIp09tSL5y5OIPekLxAFABBvBY97iRV6P7uRgfWK3ZgHZnyf2X5Z962tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798923; c=relaxed/simple;
	bh=JaunFt0T0EWCKUbeAop3W25lSE226TwTe55Aql+rUIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukw+mKoyvyXnRZ+4Jc/+oT2sLuCN3fTLsItUBMdN59WW4L+Gqr0suVV6gYwZSA5RU5Ndi62CoJQWFbLE5GMYn0XdAHypskGYc/smz4vVj/3nfHprNxndh5Xg3x+g4Xyu6EeJ6EP8EwxGt8tkSXJejP4Bb6GkFuMhZjcR4Riulok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHMSyPci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF98DC433C7;
	Thu, 11 Apr 2024 01:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712798923;
	bh=JaunFt0T0EWCKUbeAop3W25lSE226TwTe55Aql+rUIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHMSyPciwY1kaKuqLFb8Ze54R0VnWohQUjALfWp5g1PAsRWn/HShprw4PK2ZIlQIj
	 a2dzZstQZX0YDqdv04CTzvRKxnMR1ipugO/YXQ2yF9Cxwq/EGDoTHEFY/1GMA+DTz5
	 PEBwKy3feaqUYf892uWt0LgBZ3MgNOXmPzziSA2TlQeNNagBXjHOwX0EmNRFrLcN+H
	 d3y/+GsgNB5VY2iL6peFfPc3kLQaNJY9k/1TNtvFpxpZNDa4FouITmPvjx1hD/Ha/j
	 bpLTq6Acr4jc7b03Uu5P+14w3Z/dJN5STZJfZuzUFEFSbbXfojN1XUpjuzKt15/Auw
	 jYesWwr/WpR1w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/6] selftests: net: support use of NetdevSimDev under "with" in python
Date: Wed, 10 Apr 2024 18:28:14 -0700
Message-ID: <20240411012815.174400-6-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411012815.174400-1-kuba@kernel.org>
References: <20240411012815.174400-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using "with" on an entire driver test env is supported already,
but it's also useful to use "with" on an individual nsim.

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


