Return-Path: <linux-kselftest+bounces-40899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458B2B477BF
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 23:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30750A03181
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 21:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE8127E1DC;
	Sat,  6 Sep 2025 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX3aa8kE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C741B87E8;
	Sat,  6 Sep 2025 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757195149; cv=none; b=VzKG1SeaMMfFOS4It6wkU8eBAWpnIy/kKPC56PWADQ6Zsr7y5DIWxnWJSXazvaXrcFHa/2wBEr4Mia5pyxqs75keIugp76rt5tTszq1lJg0oPFL2WtrZ1H/xwmLGWjaRRydbQJv4CG49j0lY6Chp12CzMpCsm17VxHSLWklaa+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757195149; c=relaxed/simple;
	bh=BVNpbp5KfoDhZRxBFhsFgRoVxTJxGW0DL8rhvVv1mjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZfdHq36Bt9+8I0/hpCRvz/a1+nvbT141dHw8HiBhdSYNzj6yKzlIAU0tWSxQGUn+zZLeemlx21vUJqEWvwFLAm46qArqqGtGSOgPtIkBJu57gF9nC+VSExdvcJbAuyEeHzA6+QdSjK+9er7JNNAMrJs8YzXSAd78N75u27XniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX3aa8kE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD0FC4CEE7;
	Sat,  6 Sep 2025 21:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757195147;
	bh=BVNpbp5KfoDhZRxBFhsFgRoVxTJxGW0DL8rhvVv1mjs=;
	h=From:To:Cc:Subject:Date:From;
	b=OX3aa8kEAZAY/PqZyCRk3deutW6n9DzzFRq0TJyrFqn8WlZwgEMqtdORVSgSNX3Vh
	 t1fGi7DHkFm68FgmWnEd2ZjqPbLCSrXOPM8TlRmFtsVcWvS78jRBLQU1mJu46cq3ie
	 k7JzcQc6/Sd+JCFbMSatnz2fKVyqovwp8qLm76lVl6vK8028JO4hpyupuflyTHJZ1E
	 FuDc1uzD80gMJBlfjfZDD9QyCaixX92YloLd+l/jVNZug4LEe/flV7zidZh9CKHyzo
	 4i+DPwGfRDXqfoR3Yt881dqn3EGLuMFDvHOpkcXVKCD0PFJuqIKU0GvA6MalF32E36
	 mtZ6PrQc4BHJA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] selftests: net: speed up pmtu.sh by avoiding unnecessary cleanup
Date: Sat,  6 Sep 2025 14:45:35 -0700
Message-ID: <20250906214535.3204785-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pmtu test takes nearly an hour when run on a debug kernel
(10min on a normal kernel, so the debug slow down is quite significant).
NIPA tries to ensure all results are delivered by a certain deadline
so this prevents it from retrying the test in case of a flake.

Looks like one of the slowest operations in the test is calling out
to ./openvswitch/ovs-dpctl.py to remove potential leftover OvS interfaces.
Check whether the interfaces exist in the first place in sysfs,
since it can be done directly in bash it is very fast.

This should save us around 20-30% of the test runtime.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/pmtu.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 88e914c4eef9..a3323c21f001 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1089,10 +1089,11 @@ cleanup() {
 
 	cleanup_all_ns
 
-	ip link del veth_A-C		2>/dev/null
-	ip link del veth_A-R1		2>/dev/null
-	cleanup_del_ovs_internal
-	cleanup_del_ovs_vswitchd
+	[ -e "/sys/class/net/veth_A-C"  ] && ip link del veth_A-C
+	[ -e "/sys/class/net/veth_A-R1" ] && ip link del veth_A-R1
+	[ -e "/sys/class/net/ovs_br0"   ] && cleanup_del_ovs_internal
+	[ -e "/sys/class/net/ovs_br0"   ] && cleanup_del_ovs_vswitchd
+
 	rm -f "$tmpoutfile"
 }
 
-- 
2.51.0


