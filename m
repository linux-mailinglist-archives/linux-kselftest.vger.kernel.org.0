Return-Path: <linux-kselftest+bounces-5429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB57866B95
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 09:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1EE1C214E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 08:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B70C1C2B3;
	Mon, 26 Feb 2024 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RVtvuk3t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC81C6B0;
	Mon, 26 Feb 2024 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934389; cv=none; b=kaDzmqZuZ7QqId3y9R8S+md9SD5u/btFel9LybecxhtvtoRHVRbojcdLRmHDzhWI23xvPNx4CWPrQg9J96R7GwEkbAvndZHklrW+jELKfISyN93hnJmZY6qlNsqZMX8R2fwhWPxlmtpL671t1u5MV1tez/fUw0hYCyOAQF9tMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934389; c=relaxed/simple;
	bh=CYj6oRTbX/7f7/78HGFFBZcT48SMQd7rHs0/Qiqed3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcxPIiXFtbWgu/oKVruPUC37nuVBfOZHlkfld7Du+gI1xMtaLl1QQNeidVLoUdMVOAyR2XrENX2PUzlVJpQ999yHz1c3tbQqWX06U5CDRHFHV/4ND2Ji2ZIBhfrTiKhiFgWKgInd2x+ZFcaaNmXgzExy3VHmaswKKh8nkt2vogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RVtvuk3t; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708934386;
	bh=CYj6oRTbX/7f7/78HGFFBZcT48SMQd7rHs0/Qiqed3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RVtvuk3tyGOQzYJqSPtbRxnKJQIB2/vYAyDsNloBvOiX3WsWv1FERhmwvECSDEqeH
	 bm3WeYGx4dz6cpL/jUoVZJONV/oPOWHoffaEdrokuvrxvW6KtdUwhPPZs+7RKHMu7l
	 c3B87OedPmvhoO8cJhy9ml4DPtdqYCvyWTenwgMHufkGEEmko35RLWCYrpvzqp7/PN
	 YmgFZY2CfYVk/yTKXylgicfJwTVP47xP9Eumv8UrkqE2Hgfwy1y9leAPKcmcuBHK/i
	 wxvyYG0lFd4oF/lhxPa61dXh8HnHXwhUtwKnaNIbUDfaNLbWEx20FnhnzqUq5sbeiB
	 zjOTkazHJDwyg==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BECAB3780B5F;
	Mon, 26 Feb 2024 07:59:44 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests: dmabuf-heap: add config file for the test
Date: Mon, 26 Feb 2024 12:59:55 +0500
Message-ID: <20240226080003.4094089-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240226080003.4094089-1-usama.anjum@collabora.com>
References: <20240226080003.4094089-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config fragment enlists all the config options needed for the test.
This config is merged into the kernel's config on which this test is
run.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/dmabuf-heaps/config | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 tools/testing/selftests/dmabuf-heaps/config

diff --git a/tools/testing/selftests/dmabuf-heaps/config b/tools/testing/selftests/dmabuf-heaps/config
new file mode 100644
index 0000000000000..34bd294836df0
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/config
@@ -0,0 +1,4 @@
+CONFIG_DMABUF_HEAPS=y
+CONFIG_DMABUF_HEAPS_SYSTEM=y
+CONFIG_DRM_VGEM=y
+
-- 
2.42.0


