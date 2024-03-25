Return-Path: <linux-kselftest+bounces-6533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B806A88A1CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 14:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A03F2C7DA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 13:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF0E156969;
	Mon, 25 Mar 2024 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vWoq9zoU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2141C16ABD7;
	Mon, 25 Mar 2024 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357224; cv=none; b=VO7qQpDrkWyjdB3bjD9yhIEsK4dmThvk3u1hzbfmRghv7vs2OmY1LC+7t1q/y8BpQxNnawZOgXyM74MqZfzHXS6PzFMdSstbUjId8Xtufcn5GYEBLRzW7AVSnsoN5wSWTJg7phZLzGy7pnb2VJo2janwJNCTunxHAnENZqrq1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357224; c=relaxed/simple;
	bh=26sBVyPr2mvxrvqKu15s8Y422gv6bcuJX3lZRL2zqII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FJdx2CKjcXc3AU1ztXbhd9G4REVkTRu9OUP35EKF5BBL+5WoV8Ot80jQNW0TQ1NOY+pv1sEzxScXgLlHcT7q8A2qg9Y8NKzgcHk1s5ydhZ6MJq+QIV81gATDsb2wT9d76XRnX3n/NKccUT36GChLCEiWmBD4KAwBQAIs12gJ1J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vWoq9zoU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711357221;
	bh=26sBVyPr2mvxrvqKu15s8Y422gv6bcuJX3lZRL2zqII=;
	h=From:To:Cc:Subject:Date:From;
	b=vWoq9zoUw81jAjaaZzchyc/yxBqqYNtvW9aYykHPYHWJyT9OHJHe7kxfWt46RiwOV
	 wjhHdpH4vqW0Xm0ea2iisr/j1TBZQ2qUMT8DSr9f8CyNHiZ7ML6D5OBZjUnE1huAlW
	 RXAiRyTI8cFtlwE7CpQ+nZ3LsVpaDUC6ONCSRM6BucJ1y4LU2mDuzVRAjbsh43goS8
	 D1EwNVGiCHWZwmk813P63uEOu78G6mwmHpX1rlnu3GfqNI5Of4q/jLAptdENSYNBf8
	 WCivw8s07+j7iOnq5evhntJXUkF/tYV8hBZSXY+hfWOGyW+WKO7R5B+JwAW/JWWBll
	 OdxjJ0pPpRyMQ==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DBF4037813B7;
	Mon, 25 Mar 2024 09:00:18 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
Date: Mon, 25 Mar 2024 14:00:48 +0500
Message-Id: <20240325090048.1423908-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add FAULT_INJECTION_DEBUG_FS and FAILSLAB configurations which are
needed by iommufd_fail_nth test.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
While building and running these tests on x86, defconfig had these
configs enabled. But ARM64's defconfig doesn't enable these configs.
Hence the config options are being added explicitly in this patch.
---
 tools/testing/selftests/iommu/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/iommu/config b/tools/testing/selftests/iommu/config
index 110d73917615d..02a2a1b267c1e 100644
--- a/tools/testing/selftests/iommu/config
+++ b/tools/testing/selftests/iommu/config
@@ -1,3 +1,5 @@
 CONFIG_IOMMUFD=y
+CONFIG_FAULT_INJECTION_DEBUG_FS=y
 CONFIG_FAULT_INJECTION=y
 CONFIG_IOMMUFD_TEST=y
+CONFIG_FAILSLAB=y
-- 
2.39.2


