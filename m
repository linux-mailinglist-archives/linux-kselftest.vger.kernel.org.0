Return-Path: <linux-kselftest+bounces-35717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB22BAE7152
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 23:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47C85A1747
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 21:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ECB259C9A;
	Tue, 24 Jun 2025 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSlRJNgj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED829258CF8;
	Tue, 24 Jun 2025 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799409; cv=none; b=MgB27IawFtR83jFl1vmAEjLFfnAMRsJxVdJ4VwHmxyuWmDA5AK6RWXLIhYv4pcobPhikwSZrnyluDnAGuPkMuQl87yb3Og6L/Yol6vGdgvqajWGAgLDwOounBvIUkhesAJwJNdqOlN8JIeeBjjUQ91Rmcxj+b48OMqfUDu9yzic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799409; c=relaxed/simple;
	bh=QyZfiZRSllHYVZHbwm1VNcqDEhd+QP01NOE78v4Yrvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jo1qDw/dWsi7EhTGPwqD0W/j1vmmPLTU7R2HKeqB1QDXAuIEIpgb6EiP2kGLgraiksAm4uv2hx1GUbQ/0bAtDsxosimcYAcitvuMeOKyW+eiEdo32NiUmmgAQWTES7xvTnPDRdQSNWgUL4FTVphZVloZm0hV3IbZyR4aUOKZv94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSlRJNgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE15EC4CEF0;
	Tue, 24 Jun 2025 21:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750799408;
	bh=QyZfiZRSllHYVZHbwm1VNcqDEhd+QP01NOE78v4Yrvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSlRJNgj4uEvm5zgDauPFLTx1hPcEwSbsAFtDB2oFSKtWlon4kLBzATcOm+zmtziW
	 FsZnf+QitoPM0aM3sifQymTlERQXg3sZygwvWRawNj1GAbBtwkjMerWFbRgz7MDg5e
	 6S++GdFLCZJQxgtoiRPi2N5dZxw3eVoS8q3Kfi98TZQ/D0+Lv7zQEoCCTFgndhIRVj
	 6GTbxESQz4QqJPCJRar4v7FU5cuWw1bSwCvDKuoQbKTCcPG94hFnrDMWOON/qRkajQ
	 zeQJU+H0oq8eG5srq+JNJX+McbIOA21Am3dUY1hCJxPkYBtwNi4pRvosG2b6NxbY50
	 59UiZ7KhhV5ag==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	gal@nvidia.com,
	noren@nvidia.com,
	ahmed.zaki@intel.com,
	wojciech.drewek@intel.com,
	petrm@nvidia.com,
	danieller@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 03/10] netlink: specs: ethtool: replace underscores with dashes in names
Date: Tue, 24 Jun 2025 14:09:55 -0700
Message-ID: <20250624211002.3475021-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624211002.3475021-1-kuba@kernel.org>
References: <20250624211002.3475021-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're trying to add a strict regexp for the name format in the spec.
Underscores will not be allowed, dashes should be used instead.
This makes no difference to C (codegen replaces special chars in names)
but gives more uniform naming in Python.

Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
Fixes: 46fb3ba95b93 ("ethtool: Add an interface for flashing transceiver modules' firmware")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: donald.hunter@gmail.com
CC: shuah@kernel.org
CC: kory.maincent@bootlin.com
CC: sdf@fomichev.me
CC: gal@nvidia.com
CC: noren@nvidia.com
CC: ahmed.zaki@intel.com
CC: wojciech.drewek@intel.com
CC: petrm@nvidia.com
CC: danieller@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 Documentation/netlink/specs/ethtool.yaml                 | 6 +++---
 tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 72a076b0e1b5..348c6ad548f5 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -48,7 +48,7 @@ c-version-name: ethtool-genl-version
         name: started
         doc: The firmware flashing process has started.
       -
-        name: in_progress
+        name: in-progress
         doc: The firmware flashing process is in progress.
       -
         name: completed
@@ -1422,7 +1422,7 @@ c-version-name: ethtool-genl-version
         name: hkey
         type: binary
       -
-        name: input_xfrm
+        name: input-xfrm
         type: u32
       -
         name: start-context
@@ -2238,7 +2238,7 @@ c-version-name: ethtool-genl-version
             - hfunc
             - indir
             - hkey
-            - input_xfrm
+            - input-xfrm
       dump:
         request:
           attributes:
diff --git a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
index f439c434ba36..648ff50bc1c3 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
@@ -38,7 +38,7 @@ from lib.py import rand_port
         raise KsftSkipEx("socket.SO_INCOMING_CPU was added in Python 3.11")
 
     input_xfrm = cfg.ethnl.rss_get(
-        {'header': {'dev-name': cfg.ifname}}).get('input_xfrm')
+        {'header': {'dev-name': cfg.ifname}}).get('input-xfrm')
 
     # Check for symmetric xor/or-xor
     if not input_xfrm or (input_xfrm != 1 and input_xfrm != 2):
-- 
2.49.0


