Return-Path: <linux-kselftest+bounces-14395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B52093FFE7
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 22:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84231F22602
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 20:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC33E1891C4;
	Mon, 29 Jul 2024 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fMLemItr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A67F484;
	Mon, 29 Jul 2024 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286626; cv=none; b=mN/e6yd0AdZpSchIrhiAEQFqeEi7XDrqctnme8iW0IElC/xkiSu0icnwmF0dNiLuAnTPJ+MQr+M4GUaF30e1Q3hQTHQyvCGJhqeB8xuzNsz2NzRBTE08btUGcA53XwdSDEWVdfEn5+m+Af2Txm3nNgj3y7VuDLvCYBjQZEhYrz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286626; c=relaxed/simple;
	bh=POH5VC0jKmddjNyYhRWP+pv1+J5+ngtBmyhj7YazHn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zqft7jMsMy91BVDF/KXuv/bv9pyU4J46wHxmY8b9Z7VzQBL2ghNX/T3G/TzAe4S34ktQ0IBgcKmCcK4P9aUcSZ1X0wuVRICQfuyKrQDJDO/u9WiEBL0T3p9fVdepi9pVWRc+MzVQXNT3TqSFVm5mJwJ2D6l7SuBMGTjkcNEj3U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fMLemItr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722286623;
	bh=POH5VC0jKmddjNyYhRWP+pv1+J5+ngtBmyhj7YazHn0=;
	h=From:Date:Subject:To:Cc:From;
	b=fMLemItr3lCb+kVYFqvz2xVvZL5GaTX6+F5Mw59mijXVgkxTcD++HrKQGgEjRgg6Y
	 Ib5Jw8hO/uo83OU5OSUJ+cjjKicEbWtaT8RYEZFGdby6olbKQODzegCR9Un3/37/ey
	 woMGj47t796UtZbx4bt30VGfWf4PXQPAC2PBqqenYJC2DHY0tCMRkmyiNNOORWqt7v
	 yz4J4RqHg/1tUuTkG7watOIxtx2S2cWs+mhlhEXRN8glQrJGx3XukKX2+Vc9JYw5bA
	 /50FPgQ4bP7yBLMNv7xcpRD81pOkdEjee7N0vxyCwJIU4FSL+k0jySY3JZTuyk4nQ9
	 4LtYTYeelYEkg==
Received: from [192.168.1.32] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5DB783780530;
	Mon, 29 Jul 2024 20:57:01 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 29 Jul 2024 16:56:02 -0400
Subject: [PATCH v2] kselftest: dt: Ignore nodes that have ancestors
 disabled
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240729-dt-kselftest-parent-disabled-v2-1-d7a001c4930d@collabora.com>
X-B4-Tracking: v=1; b=H4sIAOEBqGYC/43NQQ6CMBCF4auYrh1DR0OLK+9hWBQ6yMRKSachG
 sLdrZzA5fcW/1uVUGISdT2sKtHCwnEqwONB9aObHgTsixVWeKlq3YDP8BQKQybJMLtEUwbP4rp
 AHhAtOoN49lirkpgTDfze8/e2eGTJMX32t0X/1j/DiwYNnR2Ms8bYpqpvfQzBdTG5Ux9fqt227
 QsppLRFzAAAAA==
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>, 
 devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.0

Filter out nodes that have one of its ancestors disabled as they aren't
expected to probe.

This removes the following false-positive failures on the
sc7180-trogdor-lazor-limozeen-nots-r5 platform:

/soc@0/geniqup@8c0000/i2c@894000/proximity@28
/soc@0/geniqup@ac0000/spi@a90000/ec@0
/soc@0/remoteproc@62400000/glink-edge/apr
/soc@0/remoteproc@62400000/glink-edge/apr/service@3
/soc@0/remoteproc@62400000/glink-edge/apr/service@4
/soc@0/remoteproc@62400000/glink-edge/apr/service@4/clock-controller
/soc@0/remoteproc@62400000/glink-edge/apr/service@4/dais
/soc@0/remoteproc@62400000/glink-edge/apr/service@7
/soc@0/remoteproc@62400000/glink-edge/apr/service@7/dais
/soc@0/remoteproc@62400000/glink-edge/apr/service@8
/soc@0/remoteproc@62400000/glink-edge/apr/service@8/routing
/soc@0/remoteproc@62400000/glink-edge/fastrpc
/soc@0/remoteproc@62400000/glink-edge/fastrpc/compute-cb@3
/soc@0/remoteproc@62400000/glink-edge/fastrpc/compute-cb@4
/soc@0/remoteproc@62400000/glink-edge/fastrpc/compute-cb@5
/soc@0/spmi@c440000/pmic@0/pon@800/pwrkey

Fixes: 14571ab1ad21 ("kselftest: Add new test for detecting unprobed Devicetree devices")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Rebased on v6.11-rc1
- Link to v1: https://lore.kernel.org/r/20240619-dt-kselftest-parent-disabled-v1-1-b8f7a8778906@collabora.com
---
 tools/testing/selftests/dt/test_unprobed_devices.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dt/test_unprobed_devices.sh b/tools/testing/selftests/dt/test_unprobed_devices.sh
index 2d7e70c5ad2d..5e3f42ef249e 100755
--- a/tools/testing/selftests/dt/test_unprobed_devices.sh
+++ b/tools/testing/selftests/dt/test_unprobed_devices.sh
@@ -34,8 +34,21 @@ nodes_compatible=$(
 		# Check if node is available
 		if [[ -e "${node}"/status ]]; then
 			status=$(tr -d '\000' < "${node}"/status)
-			[[ "${status}" != "okay" && "${status}" != "ok" ]] && continue
+			if [[ "${status}" != "okay" && "${status}" != "ok" ]]; then
+				if [ -n "${disabled_nodes_regex}" ]; then
+					disabled_nodes_regex="${disabled_nodes_regex}|${node}"
+				else
+					disabled_nodes_regex="${node}"
+				fi
+				continue
+			fi
 		fi
+
+		# Ignore this node if one of its ancestors was disabled
+		if [ -n "${disabled_nodes_regex}" ]; then
+			echo "${node}" | grep -q -E "${disabled_nodes_regex}" && continue
+		fi
+
 		echo "${node}" | sed -e 's|\/proc\/device-tree||'
 	done | sort
 	)

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240619-dt-kselftest-parent-disabled-2282a7223d26

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


