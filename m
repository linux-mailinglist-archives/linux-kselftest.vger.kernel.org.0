Return-Path: <linux-kselftest+bounces-5888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0F58715A7
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 07:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA701F21AD4
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 06:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2897B3CA;
	Tue,  5 Mar 2024 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WP1SwgFe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FB3FC1C;
	Tue,  5 Mar 2024 06:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709618917; cv=none; b=gCc/dHZgmdQqfnYpFEdHhrn3TgJStqcCJZ2mtCF/7m90UcmRi/HwINB8Rk5yDlKO99p8NXm2rW9qKTOzyii37nGv6eqYV+G1z6QLHzbMNCFwOkZv54tiriAiBT8+S/GbUQpXvrP/CmhQ+Ka7O0V23WtACFvQ48zBJhteM/ZVjjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709618917; c=relaxed/simple;
	bh=9lc4pDkvuUw9UpBozHPb1wF+lwtvZHvSgcQf4nX95ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bqh+52qLSd2hmKUzIL5NIZ46ysqh2EzAZ8xUAMGtNQ9B4e7voEMFMsgiwHt7OXQkJucTBMlfh248bC1DauTHqBSAf+FlmFVzcDbk1mKuJMarc29B6QJnTyf/W7ibUtHcar7Tmf960d4XdGVKxp+T+D/S5rnPi1LkC5GTmKmtuEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WP1SwgFe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709618914;
	bh=9lc4pDkvuUw9UpBozHPb1wF+lwtvZHvSgcQf4nX95ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WP1SwgFeImouN8ijdoAEsneRavtZHLpHQB9/a+KqZXeOHnlc10HKC0M9PMcHDtfgK
	 DJYzXEKW9j4H4MSeXn1SRxhDEd8Y6/4yfLdHO8NAJRyWh6cB9k0E6OJwVh1yR5ucdy
	 uG+2JV9xVs/yjQ4jb2xU9lV76u4NgVHmqfCFFMA+jbDITJJt/PHSHKLpKDvUqHt+68
	 8P+9GjtU+b8w7vIUgDVAnJYOBtd9XZDBUiejLz5eeu8kn5f8d+4Hpgv7Xq6mqA83EH
	 jMUDEW8nlNMrc/Y47fSW/SR2BSzU3XSv2ZnT6Rj1nB/7+E0VEAArv/RYJQM+qf950t
	 HXiMPlEvRLNrg==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6A8AA37820C6;
	Tue,  5 Mar 2024 06:08:30 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	"T.J. Mercier" <tjmercier@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 2/2] selftests: dmabuf-heap: add config file for the test
Date: Tue,  5 Mar 2024 11:08:47 +0500
Message-Id: <20240305060848.2478806-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305060848.2478806-1-usama.anjum@collabora.com>
References: <20240305060848.2478806-1-usama.anjum@collabora.com>
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


