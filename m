Return-Path: <linux-kselftest+bounces-38618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782C7B1F16C
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 02:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E173B4C9A
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 00:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2BF1482F5;
	Sat,  9 Aug 2025 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p23XrgMs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66175145FE8;
	Sat,  9 Aug 2025 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754698329; cv=none; b=bUyeYoZeRxLkLiDIorIjppJ6tjMy6IihVxcwwLNITffsuYrI48xNW/AT/H4W80rZgglIl6sU/cggzLdvVmaF5tGJkXSN3TamZcc+/h7ZOlJbMgaY9Jj8WO48aRN13Lrg94z/FdCu8JbnFA1D0xrEwxQ6iAYJk4zueOlp3sIy3QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754698329; c=relaxed/simple;
	bh=UNfhEqaaCJtg7I21H75wxCpafiHNzjMBx7/3JgE37bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st2G/gRg52KQH+qDjR6mJOtMZtpEoS+HqHcw8f8xuMEio/cUBEjCWICCW10joGj371hb+05cdWeMTH/0P+hPi6/SCkFvhCEsBaM7C8o28LpGJmWcrLY05o8audIaOKkofjdNJ8J2rM1cAzUnusl7Ql3jUs/2Ok0O7mJPoS1+i80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p23XrgMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E2DC4CEF8;
	Sat,  9 Aug 2025 00:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754698329;
	bh=UNfhEqaaCJtg7I21H75wxCpafiHNzjMBx7/3JgE37bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p23XrgMsZo1Qb1vJfC3+AqR4jKr3KZa8GzniETq+72+1P2QA3mWMJk/fe9G8s456H
	 jbEwn2H69L8PGqWkL5uEH9PGIrvIfVkh27eImGc6lG+hKhbn1cthxvQ3UGTDCWApn0
	 7boSfPUvnWxCsil8CrBcJ7qsoxWmr5LJgqBGLG6/IjF7IWh0niZXR2XoyImzdToIOC
	 3DKPI4Sgug9vRYvt6OR94uHNZEqlbU/voAORmwBwaTgugHsrrQAHI8GAtglXAA3M1q
	 silzc3m+huaDMT22fTWvw7sZeritpzyXdOtPcdPar0Ole10+VlLLB7FQy9UF/WC2+G
	 6sgG3ylR0MLMg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	joe@dama.to,
	sdf@fomichev.me,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 1/3] selftests: drv-net: don't assume device has only 2 queues
Date: Fri,  8 Aug 2025 17:12:03 -0700
Message-ID: <20250809001205.1147153-2-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250809001205.1147153-1-kuba@kernel.org>
References: <20250809001205.1147153-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test is implicitly assuming the device only has 2 queues.
A real device will likely have more. The exact problem is that
because NAPIs get added to the list from the head, the netlink
dump reports them in reverse order. So the naive napis[0] will
actually likely give us the _last_ NAPI, not the first one.
Re-enable all the NAPIs instead of hard-coding 2 in the test.
This way the NAPIs we operated on will always reappear,
doesn't matter where they were in the registration order.

Fixes: e6d76268813d ("net: Update threaded state in napi config in netif_set_threaded")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/napi_threaded.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/napi_threaded.py b/tools/testing/selftests/drivers/net/napi_threaded.py
index b2698db39817..9699a100a87d 100755
--- a/tools/testing/selftests/drivers/net/napi_threaded.py
+++ b/tools/testing/selftests/drivers/net/napi_threaded.py
@@ -35,6 +35,8 @@ from lib.py import cmd, defer, ethtool
     threaded = cmd(f"cat /sys/class/net/{cfg.ifname}/threaded").stdout
     defer(_set_threaded_state, cfg, threaded)
 
+    return combined
+
 
 def enable_dev_threaded_disable_napi_threaded(cfg, nl) -> None:
     """
@@ -49,7 +51,7 @@ from lib.py import cmd, defer, ethtool
     napi0_id = napis[0]['id']
     napi1_id = napis[1]['id']
 
-    _setup_deferred_cleanup(cfg)
+    qcnt = _setup_deferred_cleanup(cfg)
 
     # set threaded
     _set_threaded_state(cfg, 1)
@@ -62,7 +64,7 @@ from lib.py import cmd, defer, ethtool
     nl.napi_set({'id': napi1_id, 'threaded': 'disabled'})
 
     cmd(f"ethtool -L {cfg.ifname} combined 1")
-    cmd(f"ethtool -L {cfg.ifname} combined 2")
+    cmd(f"ethtool -L {cfg.ifname} combined {qcnt}")
     _assert_napi_threaded_enabled(nl, napi0_id)
     _assert_napi_threaded_disabled(nl, napi1_id)
 
@@ -80,7 +82,7 @@ from lib.py import cmd, defer, ethtool
     napi0_id = napis[0]['id']
     napi1_id = napis[1]['id']
 
-    _setup_deferred_cleanup(cfg)
+    qcnt = _setup_deferred_cleanup(cfg)
 
     # set threaded
     _set_threaded_state(cfg, 1)
@@ -90,7 +92,7 @@ from lib.py import cmd, defer, ethtool
     _assert_napi_threaded_enabled(nl, napi1_id)
 
     cmd(f"ethtool -L {cfg.ifname} combined 1")
-    cmd(f"ethtool -L {cfg.ifname} combined 2")
+    cmd(f"ethtool -L {cfg.ifname} combined {qcnt}")
 
     # check napi threaded is set for both napis
     _assert_napi_threaded_enabled(nl, napi0_id)
-- 
2.50.1


