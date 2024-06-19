Return-Path: <linux-kselftest+bounces-12273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CAB90F88D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 23:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B11D1F23675
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 21:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D91E15A87F;
	Wed, 19 Jun 2024 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DI9iAekS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC455884;
	Wed, 19 Jun 2024 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718832848; cv=none; b=STXWrAMo9M2gG1/WgO+1PfwD4KKtHjb4kde+LBfFwzJyc8NccfhKwp+bdeWGsfpqBgoneddA7yjyVDasN7L10FvcFs4OC2K3aYaMRKOMq7H+2DY4Im9s42e4VcrusEs1ZxvcKMes/IlvFE3LnZL9I9iD/NV/6EbYpp7GWmoz+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718832848; c=relaxed/simple;
	bh=QpgxUO+NC9kg5vQa3E+qKEIvQmHTdiyzV696YvEtACY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OOWCg5l2Avfs1Dh1ew6W1sO36V9vwVpLuXlgIvBUTfw6fX9GCFXhy7OoZOxp0QPBPfs4bfH32ZRZ3KiqGfdTsI8vk9fKQuGmfsq8UoCOJaYoTO4cHKuFm7HmQmBdh61g9N9zWj0vby3vKN+UhxVhGqeWswFr4MLYH9PuSFw75Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DI9iAekS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718832843;
	bh=QpgxUO+NC9kg5vQa3E+qKEIvQmHTdiyzV696YvEtACY=;
	h=From:Date:Subject:To:Cc:From;
	b=DI9iAekSyUuT8+cYn3x7HFcCzMJsQ3WsgUwIqKK8yAEFbbFDvgUEEeESGrKIEbgaH
	 cyo/+kj7D2mf2PltwQhN1NE/cJe3buTgdupOdyM9Gn0eEsbyZCizJAq9fOGudVCE1H
	 hmm8IeutpXvs6CFh57DaZUlDZ9DOihDtS3i1v0vQBsbSjyAYesU6rck1iHgXA3f3eI
	 doq6Omx4TIuJDKqKdP90OVZ4N+Wz/70aTXlcgJoa3KcQzdoVpAs3omcde9luHLy4xc
	 RtZCEz4rWX0X/Ocj5n63+Ea69mW79rZRPmfpqwV/csePU7DZz+ZgXOz6bfN5zq6YF5
	 AREQIIy67GqOA==
Received: from [192.168.1.167] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 30C603782198;
	Wed, 19 Jun 2024 21:34:00 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 19 Jun 2024 17:33:58 -0400
Subject: [PATCH] kselftest: dt: Ignore nodes that have ancestors disabled
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240619-dt-kselftest-parent-disabled-v1-1-b8f7a8778906@collabora.com>
X-B4-Tracking: v=1; b=H4sIAMZOc2YC/x3MQQqDQAwF0KtI1g1oKtb2KsXF1HxrqExlMkhBv
 HsHl2/zdnIkg9Oj2ilhM7dvLGguFY1ziG+waTFJLW3dNXfWzB/HMmV45jUkxMxqHl4LlEV6CTe
 Rq0pHpVgTJvud/XM4jj9xwYItbgAAAA==
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>, 
 devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

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
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240619-dt-kselftest-parent-disabled-2282a7223d26

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


