Return-Path: <linux-kselftest+bounces-42744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A8463BB8676
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 01:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 562F734801E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Oct 2025 23:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9EC284687;
	Fri,  3 Oct 2025 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFe6Nsuh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E561A283C8E;
	Fri,  3 Oct 2025 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534259; cv=none; b=T3Wrvc1BavlLvvrfBzZD4IelfEw7wP3CdCZhyruFhaj1wK1AJkB2U7CeAtKvhkEYKYpCp9Xdh9CfX5yrOLQxpEORm3z22qcafBFHFbBWn5Kgzsg7mDa+GEnrwWfZWgYSpyhGYuvL+32TyeryygXBVD4zTb+Imbq7tziSqrySipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534259; c=relaxed/simple;
	bh=L1mUzLusoMDxffJqnpkrDMfMPVeTJBw6X0pbWOpu9F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkErT0FnV9LqJUdKen+A4HB1sgUpVDKKB2LTHsK68jQElcZlzjWYfO+d5LqdprLFNk6P9bJfj2o7wWSub70jOlAnfK28zemU/LWpi9I7feTdJ0tXbU5o+qE/ku8PhfZTOLPiRzCDtzR6eIFcIXpZCk6FXX9FY0NceRaGDvluG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFe6Nsuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073A0C4CEF7;
	Fri,  3 Oct 2025 23:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759534258;
	bh=L1mUzLusoMDxffJqnpkrDMfMPVeTJBw6X0pbWOpu9F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFe6Nsuhi1fl1jZXxZgot7k0uPn76KjIKUIErYrl1jeYYUPUWZplptsfXULcOnIuR
	 v+6x85lhvun7l/7a0DrqxjAEsKsK4bV9V6b2MdTF5VSjnTRmiyBq0VPfTmzz0awsQW
	 yTJMpKmeL+iapSpdVI53+cstwY0XMTBN3q2s5Vlyp9QsdAiD3wUoblTJG9TlbPDjNo
	 DdaM1rXAGMmEu5o/iMKL98d9Jxz3tcqpg7TqZO7AWVYoj49n36wE8tPbFKZAh24bh7
	 WWwVeDZuRDM6IRP5c4KbD6rvdjvSSKG5mny7oWdd9l1y3/mtWtLDULaouajbPJdlIe
	 WwITeDFRrysRA==
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
Subject: [PATCH net 4/9] selftests: drv-net: xdp: rename netnl to ethnl
Date: Fri,  3 Oct 2025 16:30:20 -0700
Message-ID: <20251003233025.1157158-5-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003233025.1157158-1-kuba@kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
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


