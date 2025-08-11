Return-Path: <linux-kselftest+bounces-38728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A9FB21905
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 01:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A20461F14
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 23:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5462D77E1;
	Mon, 11 Aug 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYC8Qx6f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FC529ACF1;
	Mon, 11 Aug 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954028; cv=none; b=AB98rju0EWG6vZphz1/qr9twvOzfWHnp40fcFPy/TahKrA4AHuwrNYaTYxIxl2h2jD0K1kz0aDFpMgD/9c4g+kUHTpU/T32qms0qXRLwCtB+6/vBL2lOFo4jbb/mH7soCu3GVhMEBfZBPwJk24UYvoqc0No1VrXb2I8RwOgrNjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954028; c=relaxed/simple;
	bh=REgp+SgNKXX5+VGkxhNzKfxK2mGgk0h+2KbopKQgBNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ac8ERzWEIHGvrgb3MdsnWMc0ZeN8Lav5Kc4x0QaghyyHkrs0A985V/EdQuHoblvxaSvaXYS4BqPW5RocZiCgQnKkcAvjSghhhB+2eGg2JcSq22AnonYdXe9VbBcwRJQXygwx7wYSNJL3NLzV3QDX5lq/rRjqmAg6ZmIPub6xQXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYC8Qx6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EC8C4CEFE;
	Mon, 11 Aug 2025 23:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754954027;
	bh=REgp+SgNKXX5+VGkxhNzKfxK2mGgk0h+2KbopKQgBNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYC8Qx6fUnQlnVaLB+s16FTMrEIBJwbcBafrpLTB6UnNpOk+VatZzWP1ttjohYRqW
	 kAHmAATHRE4G4Av7baPU3BVfiJgk22e8RehC/haZWNTA1BcZ+mUq34PRNCQ+ICi4Gp
	 eRuwSsk7CubqO949sb/Z1kyiKMvZmfvzvNY/1qUuCh2c+IL5m4YpOu4UD1oKuWevQl
	 fI/AoSBe88yXYoJcVhMehT4R/uOeIRwtZwLS2yyHx2HSQWS+a1WZduMFqdAyrozhh2
	 Pf6DuJCCmzmqFj8LmNi//HdglNLdRQXGF4taKz/HwK/aQymKKIoMrDwCcnk4Rj0ZWC
	 YusGJlqCcs2sQ==
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
Subject: [PATCH net-next 3/5] selftests: drv-net: devmem: add / correct the IPv6 support
Date: Mon, 11 Aug 2025 16:13:32 -0700
Message-ID: <20250811231334.561137-4-kuba@kernel.org>
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

We need to use bracketed IPv6 addresses for socat.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/devmem.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index baa2f24240ba..0a2533a3d6d6 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -24,7 +24,7 @@ from lib.py import ksft_disruptive
     require_devmem(cfg)
 
     port = rand_port()
-    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.addr}:{port},bind={cfg.remote_addr}:{port}"
+    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
     listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr} -v 7"
 
     with bkg(listen_cmd, exit_wait=True) as ncdevmem:
-- 
2.50.1


