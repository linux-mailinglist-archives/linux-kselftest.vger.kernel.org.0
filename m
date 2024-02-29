Return-Path: <linux-kselftest+bounces-5616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3858386C4DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 10:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D5F28A9F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C4D5A0E3;
	Thu, 29 Feb 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="txk2jHHz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A235E59B66;
	Thu, 29 Feb 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198447; cv=none; b=aGGCk0qgaCdjEtMaEmynRY8xUsBgeej53b5uNMgy9pk8++fI3mJGptpO4JhD7nS22YgHxhYRp3jmEJ2gYarcX99o5MIM2oKea8MzrH910YVFcISo2BHZeL/0IzKQBidrySvIeBE+agkVFLMEM5jX26zGmX0xnXq7MAC8qRgq30w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198447; c=relaxed/simple;
	bh=9lc4pDkvuUw9UpBozHPb1wF+lwtvZHvSgcQf4nX95ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lNcl20SM5J78WeUZvwiSsZ1I8uONs1U02qhd0xJMBADVFL4Z26mZrEM7s7FC4Z2z3DSpK3SJZG/6ylgQ4SlAn0LTY2G7gezCF50VGdjPOmTQtO+Xpa26PUbvPIRPEox2nVWXn7DcaWC2+dsPolo74oCPjrgHaLvndaJ3UXVJShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=txk2jHHz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709198444;
	bh=9lc4pDkvuUw9UpBozHPb1wF+lwtvZHvSgcQf4nX95ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=txk2jHHzC+cL/pIYAmoipbe53Uveyvc9OecYDv4IC7qeQZEXOvSrWGaFeB2RGJDEB
	 7eK4pv/nYYDjKPE7lOy5kpD6iEe9HGf1+isSQ6VZvlYb1oJmDgioBI0vpq04P59Sla
	 RR1v795ZhmaOcXL5320Pdx3/OM1h+yrCLD0zvA5+TqydxQUHBH7IVDvzA/83UtuMLj
	 ivIb0roC/fybm1uCOslBos1wNV1EiRbaplYpxk+DPCFMPtEOx5EHtsMTdSIibfT9It
	 CstNCmC6/ZzEVJwKfGTXWm4fWDYIt3OrFrRDSIWb053eGMVN4Xhs47vMIXIMwDI5zq
	 lhmeJo+mmhrtw==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C4F7C3781FE3;
	Thu, 29 Feb 2024 09:20:41 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	"T.J. Mercier" <tjmercier@google.com>
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 2/2] selftests: dmabuf-heap: add config file for the test
Date: Thu, 29 Feb 2024 14:20:33 +0500
Message-Id: <20240229092035.1325113-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229092035.1325113-1-usama.anjum@collabora.com>
References: <20240229092035.1325113-1-usama.anjum@collabora.com>
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

Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Add reviewed-by tag
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
2.39.2


