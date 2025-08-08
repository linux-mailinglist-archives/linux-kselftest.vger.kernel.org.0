Return-Path: <linux-kselftest+bounces-38536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8F5B1E04D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 03:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E76C87A4A2F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 01:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF9156236;
	Fri,  8 Aug 2025 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6NadPh/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8753F14883F;
	Fri,  8 Aug 2025 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754617807; cv=none; b=fxXOy9VUkhZ3BM9gUkfVMV7XZdqIpJVE7+dtvJIekoRzRf26ZRsDzCS9DQzSeU7XAr1YZ2wAbQkv/2AvQF0zXB35UCXNrHDqCgzsV1KM2M/LOOqncZjH1uSqHQmsCbT1DDtJA9HqvmTdxO14RVWCUA0c3mZ7oFrotOW9ZTk5T3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754617807; c=relaxed/simple;
	bh=UNfhEqaaCJtg7I21H75wxCpafiHNzjMBx7/3JgE37bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCjE+/P1ExFfpNYNdRqdT/T1FLzT3JyCmb4dy+T8PeVmVoptvXhszrXbppqVrce57lxNgoFegCWI9Iz0w/hJF8lQNuD6GcVGJCZtPtjouDKINAejF+SxIfTajP4QdLUBvXwC5YRmC8ceL108P78G5CUXzxDbZKvUZbVKEa2WxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6NadPh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AB2C4CEF8;
	Fri,  8 Aug 2025 01:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754617807;
	bh=UNfhEqaaCJtg7I21H75wxCpafiHNzjMBx7/3JgE37bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6NadPh/woLkC9QQZedkIiGbnu+DrWeHutmXguu4des1JBTvMJu5Qx68O+Nc9zaaW
	 e+Mfe4yBLUk3TWZodkBHrjPaMJWmOj2R3pDLt6PUnw67RX/oaoz+F6wcVZmB/nJGop
	 2+hWfuVEztPR347sSeNZZBzvL5DgjngA9pD9WKpdmrbrX+/H51tFYhWh/oGN1YUloR
	 lmeA9DJWLNXoFB6YxxNOD7NEE2eDuHZgiVJozNM4XKZ/N6p/OTfWn0TuHwjM9v0LwT
	 /BjoyC4TNcshmSRq8UMSxL4ma777uC3AZDSUVQyTkxbOu7k6jGCY+9ETKly3awzQy2
	 eokxxnTFORO0w==
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
Subject: [PATCH net 1/3] selftests: drv-net: don't assume device has only 2 queues
Date: Thu,  7 Aug 2025 18:49:50 -0700
Message-ID: <20250808014952.724762-2-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808014952.724762-1-kuba@kernel.org>
References: <20250808014952.724762-1-kuba@kernel.org>
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


