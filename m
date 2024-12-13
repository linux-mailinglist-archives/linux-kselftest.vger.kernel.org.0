Return-Path: <linux-kselftest+bounces-23330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E49049F10D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 16:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A485F283ED3
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A866C1E3DE6;
	Fri, 13 Dec 2024 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWffvQ0I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1F1E3DD6;
	Fri, 13 Dec 2024 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103376; cv=none; b=G3YbBIC0mVP9E2EVwB+GbHX5W67VDE9exjNDQIKJHCeeLa7FmcNBkRaSJGBq7W15HqSxRy6w+60M1y9tfeWzaQVOtcdbCfK7LqUfAVLaD5fBe5u4Sj8YXwxryDaRQKlw2QmLjtQ9xWNKvhfWxyTT+j5yaukx8g1DQqb3p1KaEo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103376; c=relaxed/simple;
	bh=dTfzUm/+AiwIm2LTil+sjEdPMycULavutVM5qKOl4BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IF0GcaSE7/EgHcah8U11cttzholSFrjbioqq2I0EmqlwWdlN/jQsErTQoimUtM27Bcv0QbgPkWJ79NzA0RtpKP7Vxxm2KjGsfeA33FBrgFOpCRwFbKbwVYniJJsAou5UYWDBs3JCBRmIffoGIq5CEANXkFAGvh3xHAyKP/hKjv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWffvQ0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0335C4CEDE;
	Fri, 13 Dec 2024 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734103376;
	bh=dTfzUm/+AiwIm2LTil+sjEdPMycULavutVM5qKOl4BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pWffvQ0IhVCQANAZQD9Jt7/Xj+LoRRlRhuY13jB20lNQujMo0Rk+yOpccpyc4tFRS
	 dHfBcRNT5Eg2wSkgw9YItpXXGcd+C4SNcLUbKgrOYpVnasCO6pwAAti9Nt4shgv9fY
	 XhHXBudsq6SSBmAasfBHt79BnZUPqwLGc1NlA5Vnts5akvxTX1cprMzHCk8f6C2WwW
	 TcfYhC74jOv40RrDD7hTTOysheMqEWwG9c+2wX26zQr+PNRQZ/LRz+y8Y4sTaUBat8
	 QjGfKY7TfDrpI/5iTqpmNX6cW8Nnn/0Aw+1rmlj9Xjqb+ytBYY4mvKTU2rH7SBXDbh
	 CNmcOkreSV4Lg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 5/5] selftests: net-drv: stats: sanity check netlink dumps
Date: Fri, 13 Dec 2024 07:22:44 -0800
Message-ID: <20241213152244.3080955-6-kuba@kernel.org>
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

Sanity check netlink dumps, to make sure dumps don't have
repeated entries or gaps in IDs.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/stats.py | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index 63e3c045a3b2..031ac9def6c0 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -110,6 +110,23 @@ rtnl = RtnlFamily()
             ksft_ge(triple[1][key], triple[0][key], comment="bad key: " + key)
             ksft_ge(triple[2][key], triple[1][key], comment="bad key: " + key)
 
+    # Sanity check the dumps
+    queues = NetdevFamily(recv_size=4096).qstats_get({"scope": "queue"}, dump=True)
+    # Reformat the output into {ifindex: {rx: [id, id, ...], tx: [id, id, ...]}}
+    parsed = {}
+    for entry in queues:
+        ifindex = entry["ifindex"]
+        if ifindex not in parsed:
+            parsed[ifindex] = {"rx":[], "tx": []}
+        parsed[ifindex][entry["queue-type"]].append(entry['queue-id'])
+    # Now, validate
+    for ifindex, queues in parsed.items():
+        for qtype in ['rx', 'tx']:
+            ksft_eq(len(queues[qtype]), len(set(queues[qtype])),
+                    comment="repeated queue keys")
+            ksft_eq(len(queues[qtype]), max(queues[qtype]) + 1,
+                    comment="missing queue keys")
+
     # Test invalid dumps
     # 0 is invalid
     with ksft_raises(NlError) as cm:
@@ -158,7 +175,7 @@ rtnl = RtnlFamily()
 
 
 def main() -> None:
-    with NetDrvEnv(__file__) as cfg:
+    with NetDrvEnv(__file__, queue_count=100) as cfg:
         ksft_run([check_pause, check_fec, pkt_byte_sum, qstat_by_ifindex,
                   check_down],
                  args=(cfg, ))
-- 
2.47.1


