Return-Path: <linux-kselftest+bounces-23329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ADC9F10D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 16:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3F8283A98
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD311E378C;
	Fri, 13 Dec 2024 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf333qTd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8C1E32A3;
	Fri, 13 Dec 2024 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103375; cv=none; b=cooHKqbWaoC46wEag6Nw96kfux3VWoxm7Grp4RFiLUfwifbXGlJ4gKjXUY9kSmG6m3mbmiZcX/fV9rlLY5NSslD4cW8v1ZEFzj1f8ehQlUQ94g1K2rHHrNyVHYlDEn7UBhN0H0M2p1SXRckhWhsNFJqeNOI9ffdEXCLRymA1G2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103375; c=relaxed/simple;
	bh=0EXUEtGEaoDtvcqeqIHHP8K5Jdr1sqmtrJ3VAn8ZP/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uq2qtQZB1vEFtEa3Wv/ESC7NzxWr8DhQSjN41YBdpVzs/N3h+67BYyxrJvUFXiEoD7+oHXvibNkUL9BQtPbQ/v1InPtMBLjixN11w7jnZzhKVQZrknwxB4gKOzT+xXhm2Gb/J3cCzzpdh3BuYfTPEKGdIht+/Grfi3NMKafWpmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf333qTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C12C4CED0;
	Fri, 13 Dec 2024 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734103375;
	bh=0EXUEtGEaoDtvcqeqIHHP8K5Jdr1sqmtrJ3VAn8ZP/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hf333qTdazWLNqea3WVi7kf6Zl7ZNP1VNDsNJLZZxUXm9KHeqwc9zTmcap7kJqnOJ
	 OQWP6NnjEsjrXdjBSE9wtNP/nsw5Ilh9kwVagI1krcdVP3Kd0JqhWDlnsd2nC43JlH
	 yT5JRQjOz6Wi/I/idsioRFRXAqofV4vufC33Fp406PfkaGNoo9IeOFJUTFAk9flzdv
	 Mmzp93Zdz1SaIrwWKXOvlusW0daFKPycB5FF5yadYdquQUPjNta/JblLRDTtHxztb1
	 Aj8VrN75YANKMFagDy62CeYww+ppKDqpHQX27mnGciOt8S+CH3q3LWPrN61BiMcg39
	 05rMFUHURzZDg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 4/5] selftests: net-drv: queues: sanity check netlink dumps
Date: Fri, 13 Dec 2024 07:22:43 -0800
Message-ID: <20241213152244.3080955-5-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213152244.3080955-1-kuba@kernel.org>
References: <20241213152244.3080955-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test already catches a netlink bug fixed by this series,
but only when running on HW with many queues. Make sure the
netdevsim instance created has a lot of queues, and constrain
the size of the recv_buffer used by netlink.

While at it test both rx and tx queues.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/queues.py | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 30f29096e27c..9c5473abbd78 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -8,25 +8,28 @@ from lib.py import cmd
 import glob
 
 
-def sys_get_queues(ifname) -> int:
-    folders = glob.glob(f'/sys/class/net/{ifname}/queues/rx-*')
+def sys_get_queues(ifname, qtype='rx') -> int:
+    folders = glob.glob(f'/sys/class/net/{ifname}/queues/{qtype}-*')
     return len(folders)
 
 
-def nl_get_queues(cfg, nl):
+def nl_get_queues(cfg, nl, qtype='rx'):
     queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
     if queues:
-        return len([q for q in queues if q['type'] == 'rx'])
+        return len([q for q in queues if q['type'] == qtype])
     return None
 
 
 def get_queues(cfg, nl) -> None:
-    queues = nl_get_queues(cfg, nl)
-    if not queues:
-        raise KsftSkipEx('queue-get not supported by device')
+    snl = NetdevFamily(recv_size=4096)
 
-    expected = sys_get_queues(cfg.dev['ifname'])
-    ksft_eq(queues, expected)
+    for qtype in ['rx', 'tx']:
+        queues = nl_get_queues(cfg, snl, qtype)
+        if not queues:
+            raise KsftSkipEx('queue-get not supported by device')
+
+        expected = sys_get_queues(cfg.dev['ifname'], qtype)
+        ksft_eq(queues, expected)
 
 
 def addremove_queues(cfg, nl) -> None:
@@ -57,7 +60,7 @@ import glob
 
 
 def main() -> None:
-    with NetDrvEnv(__file__, queue_count=3) as cfg:
+    with NetDrvEnv(__file__, queue_count=100) as cfg:
         ksft_run([get_queues, addremove_queues], args=(cfg, NetdevFamily()))
     ksft_exit()
 
-- 
2.47.1


