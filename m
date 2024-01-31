Return-Path: <linux-kselftest+bounces-3897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7069B844AB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 23:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D151C216E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB2139FDD;
	Wed, 31 Jan 2024 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1Yd2X8KM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E91639FDA;
	Wed, 31 Jan 2024 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738688; cv=none; b=GmNzCFyNM7RLXD0crhmLQC0MaOLOvKzII4QmDI/DTYwRo4xo2Gt2YZSxteT4me+jUI4tEddGRVF5lMGHTvqzOXZ//Djm2Ddt8s7qP4XTvdEA2H9xUeVnA83QfvuVIcALDOHREx4uRX4fh4+NVpUXAOTeSyTqUqB8q2tBHaW6kac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738688; c=relaxed/simple;
	bh=HbsXRGtiyi3ELSqaY6WtU/YJy+Gt0wI2oltVvs97Qqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s8mkDK4/vAD3SBUj2rtYgH8n/MGdGh90Pc94r/N/XiT+SZVSvIqUbCE++g3Pd0v2ENDmKW7+owGccgLfx1zDwqHUX9roJTzrq3pwcnjVZ1pl7eaiBiOoLWYr0w12IBYiCx+H2xEwc0bzLv5o/pFBIue2sZOEMgrMnpHyp1tmM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1Yd2X8KM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706738685;
	bh=HbsXRGtiyi3ELSqaY6WtU/YJy+Gt0wI2oltVvs97Qqo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=1Yd2X8KMheYZZSLs3DvbOYoyRERViAlV050nb0292K+2NBfP1VkoX6cxCz7ZfAPHG
	 h3612R3SVAmQNm9Eun7sY4vWlD7ssLWWYt4BmuGWsBap7p91RDoZsVQxyzc7zB0mMn
	 0TrZmND1+B4IZqppCM8WA1JBnvzt5xjwaYqCqHMVQi16NXDmppyb4ATCfYa5xxAHks
	 UM5AbPWafILt4NSiEKT7NM9Q3PB2JknDFx/qs4mEtioi0ZCx4AXDJvlVCU+WI96yw8
	 Hhp0YheQ6IxFOyYOWC/ZkXXfwypMvMgwSkYp92sJAcozoeiqMELREWkvulnpyEUzKv
	 w99qTwnM+rkCA==
Received: from [192.168.1.211] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 77272378206C;
	Wed, 31 Jan 2024 22:04:44 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 31 Jan 2024 17:02:40 -0500
Subject: [PATCH 1/4] selftests: ktap_helpers: Add helper to print
 diagnostic messages
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-ktap-sh-helpers-extend-v1-1-98ffb468712c@collabora.com>
References: <20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com>
In-Reply-To: <20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com>
To: Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Laura Nao <laura.nao@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

Similar to the C counterpart, add a helper to print a diagnostic
message.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 tools/testing/selftests/kselftest/ktap_helpers.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
index dd79d96f3b5a..ecc1413c22cd 100644
--- a/tools/testing/selftests/kselftest/ktap_helpers.sh
+++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
@@ -19,6 +19,11 @@ ktap_print_header() {
 	echo "TAP version 13"
 }
 
+ktap_print_msg()
+{
+	echo "#" $@
+}
+
 ktap_set_plan() {
 	num_tests="$1"
 

-- 
2.43.0


