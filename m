Return-Path: <linux-kselftest+bounces-40362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA84B3CEB2
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 20:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC83418941A0
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 18:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5BD25B30E;
	Sat, 30 Aug 2025 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWf9he+2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6498199237;
	Sat, 30 Aug 2025 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579126; cv=none; b=C6hpqQ5DeHbKZOXnqEkgaoCTWC7nS3yd5QBm1HqsXiJcG/Yf7nSvxiXyBPWM9Q24UqLWck3VV0/txmb391ugRbEbBqsoAuoN04b21UW8KsX6Q/T7lo6tSWJwHXQAHKELnZv/shQcujkKPaK6mNOr9rRURZYCLSe0BCPT+ZwHRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579126; c=relaxed/simple;
	bh=EswMiDxf5/gFdhos6ot+1GK0hWPxVoBsESqG4LOQCqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rT7cgPoTSuCvxksTNN7qJ8HOBedH77D/bEUyPiTW9c0jeKj6xVhjjxwHqRulnLBnr8gzhcDKzQA75rZbQwhPVdD75HYM6T1D3NOd5tUtNlgQwEbccj+qTXjk+LjDVGPCk0jpCBLkDT/DYlNTvbtWW8WgCHVgpMB5L9/cm84qhoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWf9he+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B7AC4CEEB;
	Sat, 30 Aug 2025 18:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756579126;
	bh=EswMiDxf5/gFdhos6ot+1GK0hWPxVoBsESqG4LOQCqc=;
	h=From:To:Cc:Subject:Date:From;
	b=LWf9he+29sdggbyIxgzs42V5T38ynY93FKiaO1YK6140LonW5p45Iprxgy85ZYoSd
	 4nRm2u/YHjtePGhTQ3g9FEgBGbPcPSMeSKUNYA4AdiVMuPfJmiw+DsojVUUx9NS8lc
	 EfTq9hI5BoGTStkMrkCFYrxgNFFQntAo81IYiSnMmJ4xDfyo6Z/9Ot2vCR4/iRJnnl
	 r76msqoOBW/uiOc4mpUEc7o2rrl0KKU1rLZQREDUD3qZs7QalqnEOb0n6Bw6pH0uDp
	 yrCw/EL5JMqQ6WBMaKIh3Z69ZaXdBLz2xNF0PCqiGmqboUiv+ZwUsIXYp7man7tigZ
	 CcLqgyxoTW4ZQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	petrm@nvidia.com
Subject: [PATCH net] selftests: drv-net: csum: fix interface name for remote host
Date: Sat, 30 Aug 2025 11:38:42 -0700
Message-ID: <20250830183842.688935-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use cfg.remote_ifname for arguments of remote command.
Without this UDP tests fail in NIPA where local interface
is called enp1s0 and remote enp0s4.

Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: petrm@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/hw/csum.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/csum.py b/tools/testing/selftests/drivers/net/hw/csum.py
index cd23af875317..3e3a89a34afe 100755
--- a/tools/testing/selftests/drivers/net/hw/csum.py
+++ b/tools/testing/selftests/drivers/net/hw/csum.py
@@ -17,7 +17,7 @@ from lib.py import bkg, cmd, wait_port_listen
     ip_args = f"-{ipver} -S {cfg.remote_addr_v[ipver]} -D {cfg.addr_v[ipver]}"
 
     rx_cmd = f"{cfg.bin_local} -i {cfg.ifname} -n 100 {ip_args} -r 1 -R {extra_args}"
-    tx_cmd = f"{cfg.bin_remote} -i {cfg.ifname} -n 100 {ip_args} -r 1 -T {extra_args}"
+    tx_cmd = f"{cfg.bin_remote} -i {cfg.remote_ifname} -n 100 {ip_args} -r 1 -T {extra_args}"
 
     with bkg(rx_cmd, exit_wait=True):
         wait_port_listen(34000, proto="udp")
@@ -37,7 +37,7 @@ from lib.py import bkg, cmd, wait_port_listen
     if extra_args != "-U -Z":
         extra_args += " -r 1"
 
-    rx_cmd = f"{cfg.bin_remote} -i {cfg.ifname} -L 1 -n 100 {ip_args} -R {extra_args}"
+    rx_cmd = f"{cfg.bin_remote} -i {cfg.remote_ifname} -L 1 -n 100 {ip_args} -R {extra_args}"
     tx_cmd = f"{cfg.bin_local} -i {cfg.ifname} -L 1 -n 100 {ip_args} -T {extra_args}"
 
     with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
-- 
2.51.0


