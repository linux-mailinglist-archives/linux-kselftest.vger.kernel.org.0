Return-Path: <linux-kselftest+bounces-34270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 760ACACD50E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 03:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64ED91BA120E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 01:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39ED57C9F;
	Wed,  4 Jun 2025 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdq7p8AJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8F281E;
	Wed,  4 Jun 2025 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749000058; cv=none; b=OhxO3XsMbb4eEGemu9hNc3Eh31kvwqRlgOSupWtxiiRAUumWVd5j+nY743j6rGcwpg66F4M0z2FbLEfEh5DasIMhm5RVBdTYurlG/Igon69LGGB1IqpSLdi2B1Nles1fEs8NP19ok0InWQIBKVUv0X8tGMFrbWq1yOYk41EJIB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749000058; c=relaxed/simple;
	bh=tRxRYOc304BHcbTVNhtgq3XUyFbH3ovYk50SGARdzoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSVMx+3TkCd/YbILuqdC2Z8qDK9ucMRuopzdrLUQfkSL7ZUcc4e2o1z6aLeNoH35gsoxaAkLAL9VPLNlfDEQCvdXocFlltlT/4oQTCysUbRgezXmOdojB2ij3xtapaRTkhoOfN4UiF6XLbNQXPJSdZFDBYHUotTdxJIuEsSHke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdq7p8AJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABC2C4CEED;
	Wed,  4 Jun 2025 01:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749000058;
	bh=tRxRYOc304BHcbTVNhtgq3XUyFbH3ovYk50SGARdzoU=;
	h=From:To:Cc:Subject:Date:From;
	b=tdq7p8AJWdl8SPaupaQ0oIavA63MecoXFEYIFGnoV5J+uANII/Iq8piHKPu3t4ZtS
	 3G07nHViqSCWz3KVIqEyTB4SqhZi+n0O9i+G/FydnPCU5sscgAND7Z1cCLsl3e/mUt
	 ASf8CqihLrUFl2xpKWXqenFU68voakBaWmoCjYorKUZOLbocuBl5EBiTXH9yIFBkQA
	 4gkUeZSQ2XTK9PShNR1hY5R0iWfttub1XC7qlHZZKTP+VaRhrW7Ne2F0JLLwdzWh21
	 lULREPOz6G+txbAFwShulmUQF1nHedYUMSk5IHRGjFHFihqlVWn4HOw0jcJ2s0i/qF
	 SbrKxgXjeFE6w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: drv-net: tso: make bkg() wait for socat to quit
Date: Tue,  3 Jun 2025 18:20:55 -0700
Message-ID: <20250604012055.891431-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 846742f7e32f ("selftests: drv-net: add a warning for
bkg + shell + terminate") added a warning for bkg() used
with terminate=True. The tso test was missed as we didn't
have it running anywhere in NIPA. Add exit_wait=True, to avoid:

  # Warning: combining shell and terminate is risky!
  #          SIGTERM may not reach the child on zsh/ksh!

getting printed twice for every variant.

Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/hw/tso.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/tso.py b/tools/testing/selftests/drivers/net/hw/tso.py
index e1ecb92f79d9..150d6db241a0 100755
--- a/tools/testing/selftests/drivers/net/hw/tso.py
+++ b/tools/testing/selftests/drivers/net/hw/tso.py
@@ -39,7 +39,7 @@ from lib.py import bkg, cmd, defer, ethtool, ip, rand_port, wait_port_listen
     port = rand_port()
     listen_cmd = f"socat -{ipver} -t 2 -u TCP-LISTEN:{port},reuseport /dev/null,ignoreeof"
 
-    with bkg(listen_cmd, host=cfg.remote) as nc:
+    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as nc:
         wait_port_listen(port, host=cfg.remote)
 
         if ipver == "4":
-- 
2.49.0


