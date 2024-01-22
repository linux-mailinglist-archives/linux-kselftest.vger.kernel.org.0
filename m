Return-Path: <linux-kselftest+bounces-3320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5109D836574
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 15:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB75288123
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 14:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9693C3D3B6;
	Mon, 22 Jan 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uJ9xhqvT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EBB3D3B9;
	Mon, 22 Jan 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933965; cv=none; b=IP8vwbw3Pp4rpGDFsKEzdKiK2tnORgGFdHZ3f54zfjQGS+kRZSZLzCkoPhOss58WmTxJAtGfrNE+zlZQfRdC5xvo5xp3j6aqcNr8B43zBUMQEzNHcBJC6oLH5TxL5u+/oh/ccKsiZAJpynRLDJv4mWHnpv4OXimTCtlFpyv7K+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933965; c=relaxed/simple;
	bh=ox9ARHAWa5hbH1NGqyR8MHwCiVjffoCVe3hbDOh/RVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HPIL5s9IBt4YQRTUYOEXaJj0EPsVGmqp0rggqq875pB6W30+RvOrQoTOda+yNf5Z/NzKfAy2zs9wLr78QqeN/EykKD/utPGHTU2FnzO95FCtVGAiAKZpgr5ytxT5T92ZLvCRDvF7t4ZIKTdgOLuuDtuCZ3HC3gsIyWxmUM5jjzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uJ9xhqvT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705933961;
	bh=ox9ARHAWa5hbH1NGqyR8MHwCiVjffoCVe3hbDOh/RVo=;
	h=From:Date:Subject:To:Cc:From;
	b=uJ9xhqvTww+cYoh9HhMp9tDM9PN+9baaqNJbjFcoDAT5KdbFEGQ7EtZ734huHcDm0
	 YrSDUqcMtwfCWOV7MfjF3yKcs6UO/oSlOc9jC8jqHuSBdOaH4ROu7wgf0LK68WzFL1
	 GyXGUvxlwrgmC56uXza3ilSvAD0dEnnsKKKsnbVQ64AP3T1APnzolX/dEtffwnHAXZ
	 OkmZ66ztc/1a7S/Tta7TacpaqwFi1FcZmvsEFVCzUT5v5MgEhfuxgfo9T2G0DIRqrJ
	 uFNSrAJ7bCiyiS54z1tUYctF2rURNhzHEYd+j0TKtdoxR06LJNx2cGWwT5TkM6V/DG
	 i+1ahFYFQuy/Q==
Received: from [192.168.0.47] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BC7D03781477;
	Mon, 22 Jan 2024 14:32:38 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 22 Jan 2024 11:29:18 -0300
Subject: [PATCH v2] kselftest: dt: Stop relying on dirname to improve
 performance
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240122-dt-kselftest-dirname-perf-fix-v2-1-f1630532fd38@collabora.com>
X-B4-Tracking: v=1; b=H4sIAL17rmUC/zXMTQrCMBBA4auUWTslP63WrryHuEiTiQ22SZkEE
 UrvbhBcfm/xdsjEgTKMzQ5M75BDihXq1ICdTXwSBlcNSqhOSKXQFXxlWnyhXNAFjmYl3Ig9+vD
 Bi7OdknR2fhJQHxtTzb///VHtOa1YZibzv2qpxCC1vvZ92w166CVKjJ7Nxsalm03LYqbEprVph
 eP4AvQCsDaxAAAA
To: Rob Herring <robh+dt@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

When walking directory trees, instead of looking for specific files and
running dirname to get the parent folder, traverse all folders and
ignore the ones not containing the desired files. This avoids the need
to call dirname inside the loop, which drastically decreases run time:
Running locally on a mt8192-asurada-spherion, which reports 160 test
cases, has gone from 5.5s to 2.9s, while running remotely with an
nfsroot has gone from 13.5s to 5.5s.

This change has a side-effect, which is that the root DT node now
also shows in the output, even though it isn't expected to bind to a
driver. However there shouldn't be a matching driver for the board
compatible, so the end result will be just an extra skipped test:

ok 1 / # SKIP

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/310391e8-fdf2-4c2f-a680-7744eb685177@sirena.org.uk
Fixes: 14571ab1ad21 ("kselftest: Add new test for detecting unprobed Devicetree devices")
Tested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Tweaked commit message
- Added trailer tags
- Rebased on 6.8-rc1
---
 tools/testing/selftests/dt/test_unprobed_devices.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/dt/test_unprobed_devices.sh b/tools/testing/selftests/dt/test_unprobed_devices.sh
index b07af2a4c4de..7fae90293a9d 100755
--- a/tools/testing/selftests/dt/test_unprobed_devices.sh
+++ b/tools/testing/selftests/dt/test_unprobed_devices.sh
@@ -33,8 +33,8 @@ if [[ ! -d "${PDT}" ]]; then
 fi
 
 nodes_compatible=$(
-	for node_compat in $(find ${PDT} -name compatible); do
-		node=$(dirname "${node_compat}")
+	for node in $(find ${PDT} -type d); do
+		[ ! -f "${node}"/compatible ] && continue
 		# Check if node is available
 		if [[ -e "${node}"/status ]]; then
 			status=$(tr -d '\000' < "${node}"/status)
@@ -46,10 +46,11 @@ nodes_compatible=$(
 
 nodes_dev_bound=$(
 	IFS=$'\n'
-	for uevent in $(find /sys/devices -name uevent); do
-		if [[ -d "$(dirname "${uevent}")"/driver ]]; then
-			grep '^OF_FULLNAME=' "${uevent}" | sed -e 's|OF_FULLNAME=||'
-		fi
+	for dev_dir in $(find /sys/devices -type d); do
+		[ ! -f "${dev_dir}"/uevent ] && continue
+		[ ! -d "${dev_dir}"/driver ] && continue
+
+		grep '^OF_FULLNAME=' "${dev_dir}"/uevent | sed -e 's|OF_FULLNAME=||'
 	done
 	)
 

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240122-dt-kselftest-dirname-perf-fix-7dc421e6dfb0

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


