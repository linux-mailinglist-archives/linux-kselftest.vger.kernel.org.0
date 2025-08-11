Return-Path: <linux-kselftest+bounces-38730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BBBB21909
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 01:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AE107AAB83
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 23:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC502E2F09;
	Mon, 11 Aug 2025 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfNI5z3L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B6A2E2DCD;
	Mon, 11 Aug 2025 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954029; cv=none; b=LoVSbAeQ8DszWmT/J1lbQZ/jCunhr1z8dRDdjKm1BhcMf6qfIVmmMyzbMGxr6kS1pKuebBd5LFs+Pr62o3gzcNDbWZpaNa1wMhEnEFyBupChuyTC60KigBwZoOgVAHxuaZGwBr214v0/Jzii6vg9bmjnTsmgW/TA4nvjrOCjdgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954029; c=relaxed/simple;
	bh=PD6pzHT84t4QNld+cuTFDSQXYlnjcWFNMgZBHR5BK9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pa6Bwet06dD+5TCuZL4wSlOcIo4TbZbFaWEFyQlSqsPQru+UhfblBlyfY/pPfwdUfcPWlvRDoSpwcfpDnymgiYb3+cuElqEbh6a+SOpNYysP9b3AvcP+sjhYjfNv48S4k8CfLueXxaDNjnujVUJ9LOAy8VmQzlgbaBmToVbpF28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfNI5z3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AABCC4CEF8;
	Mon, 11 Aug 2025 23:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754954028;
	bh=PD6pzHT84t4QNld+cuTFDSQXYlnjcWFNMgZBHR5BK9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KfNI5z3L6elQoO65lsdVW2YcIGESqbRJR3vS7qJCqryM3lwY6z4Zy//2Vi1HH31Dy
	 704WydacXBjBs7+EbRJTloMsewsm9lsRqLGlR3qPFQvl/MtRHHkMQqa7QKzwpgfzi4
	 ifGHiGSN7bq1JzvMa+TQYy4cDMB7q82fyHiykU3y4lpRnNH4OVUzCukVKrMwGDPXDC
	 lTmAU3vUZAhx/4d2289/XdpU9aPkj3fnohQamqZrFPBo1k1J46RNFPd3bLcriIOC/K
	 4ojFxfZOUYkTDOmImeFIY9HHboNRz0RCLVk4yBM+EPq/ZP2pFUzJz+SjGus2k1zoDe
	 hJPnDHlTJBkQA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	almasrymina@google.com,
	noren@nvidia.com,
	linux-kselftest@vger.kernel.org,
	ap420073@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/5] selftests: drv-net: devmem: flip the direction of Tx tests
Date: Mon, 11 Aug 2025 16:13:34 -0700
Message-ID: <20250811231334.561137-6-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811231334.561137-1-kuba@kernel.org>
References: <20250811231334.561137-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Device Under Test should always be the local system.
While the Rx test gets this right the Tx test is sending
from remote to local. So Tx of DMABUF memory happens on remote.

These tests never run in NIPA since we don't have a compatible
device so we haven't caught this.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/devmem.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 0a2533a3d6d6..45c2d49d55b6 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -42,9 +42,9 @@ from lib.py import ksft_disruptive
     port = rand_port()
     listen_cmd = f"socat -U - TCP{cfg.addr_ipver}-LISTEN:{port}"
 
-    with bkg(listen_cmd) as socat:
-        wait_port_listen(port)
-        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr} -p {port}", host=cfg.remote, shell=True)
+    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as socat:
+        wait_port_listen(port, host=cfg.remote)
+        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_local} -f {cfg.ifname} -s {cfg.remote_addr} -p {port}", shell=True)
 
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
@@ -56,9 +56,9 @@ from lib.py import ksft_disruptive
     port = rand_port()
     listen_cmd = f"socat -U - TCP{cfg.addr_ipver}-LISTEN:{port}"
 
-    with bkg(listen_cmd, exit_wait=True) as socat:
-        wait_port_listen(port)
-        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr} -p {port} -z 3", host=cfg.remote, shell=True)
+    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as socat:
+        wait_port_listen(port, host=cfg.remote)
+        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_local} -f {cfg.ifname} -s {cfg.remote_addr} -p {port} -z 3", shell=True)
 
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
-- 
2.50.1


