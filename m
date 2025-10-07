Return-Path: <linux-kselftest+bounces-42855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADBEBC2EFD
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 01:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DFFD4E9B49
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 23:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF1B262FCD;
	Tue,  7 Oct 2025 23:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTGQlyro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB225B1D2;
	Tue,  7 Oct 2025 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879629; cv=none; b=dRFKd4flYSqhuRE95D2Oj8m4cl2TwCemFMWeyDfsPuoCDkbmNI3x26R2myUzH3KsCKwDCu0Ns7YScuYk+K0JCHMlDzY2RSWfKBPzqqOf0MuL1vB0bENBe31O23mw1iklmInqE8ocGqDX2xas8TBsV+b1iMcD69wmAn7ENwAJLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879629; c=relaxed/simple;
	bh=46Ig921NesgEPgJC9fbuNGV6NsV6HAEaVWzqIOIyckI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+oeZUsGjOBNOFZXYkLr/8O4TiUa/ogdjassPQ04ftdZAsGaGVUubfozW/UdjBFBJ4UPRxt/OSEsBAvxF0cbM8dhJbbsnsLAAk3nNgEQraKBeK9Hjls3SiVavylUn9hEr31qnbykvG241hR8uUsfpNSf197BcXrZOYAZxjyKIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTGQlyro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFF2C4CEFE;
	Tue,  7 Oct 2025 23:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759879628;
	bh=46Ig921NesgEPgJC9fbuNGV6NsV6HAEaVWzqIOIyckI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WTGQlyrokbd0XrZcp+ms8/AkmrAUMgzJ4I28m8AEhZeqX0kH036BzVMgzkTwD2cmy
	 9nRVrVimjvSyDIz9Qh8zvEhk2yInmrn+njji2K8+PASJVrRo6KndPffZjIh4xXT1mj
	 QyOhWU3lSJN2Tw38TfMW1SZwhwQADTv3pCkhbB+qrh2hSgnu+KpD3VdOQQjFDaPbPZ
	 kHT91xICOq6GK5vSoezaIsew/Ga7z2thOr08LFz55mMk3RZswy8Pyk7qzqjmrPveJc
	 tyIiKbFq1UWG7qB1dqAp8VsIHJBiuS9H7qb97RKAf/rjymy+SCgFmgvXsYH/uQB+Ir
	 v62OSGFZYTASQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 4/9] selftests: drv-net: xdp: rename netnl to ethnl
Date: Tue,  7 Oct 2025 16:26:48 -0700
Message-ID: <20251007232653.2099376-5-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007232653.2099376-1-kuba@kernel.org>
References: <20251007232653.2099376-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test uses "netnl" for the ethtool family which is quite confusing
(one would expect netdev family would use this name).

No functional changes.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: sdf@fomichev.me
CC: linux-kselftest@vger.kernel.org
CC: bpf@vger.kernel.org
---
 tools/testing/selftests/drivers/net/xdp.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index 08fea4230759..a7a4d97aa228 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -541,11 +541,11 @@ from lib.py import ip, bpftool, defer
         The HDS threshold value. If the threshold is not supported or an error occurs,
         a default value of 1500 is returned.
     """
-    netnl = cfg.netnl
+    ethnl = cfg.ethnl
     hds_thresh = 1500
 
     try:
-        rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+        rings = ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
         if 'hds-thresh' not in rings:
             ksft_pr(f'hds-thresh not supported. Using default: {hds_thresh}')
             return hds_thresh
@@ -562,7 +562,7 @@ from lib.py import ip, bpftool, defer
 
     Args:
         cfg: Configuration object containing network settings.
-        netnl: Network namespace or link object (not used in this function).
+        ethnl: Network namespace or link object (not used in this function).
 
     This function sets up the packet size and offset lists, then performs
     the head adjustment test by sending and receiving UDP packets.
@@ -681,7 +681,7 @@ from lib.py import ip, bpftool, defer
     function to execute the tests.
     """
     with NetDrvEpEnv(__file__) as cfg:
-        cfg.netnl = EthtoolFamily()
+        cfg.ethnl = EthtoolFamily()
         ksft_run(
             [
                 test_xdp_native_pass_sb,
-- 
2.51.0


