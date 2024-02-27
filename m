Return-Path: <linux-kselftest+bounces-5480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFF4869042
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 13:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A5D1C2622A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 12:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A46145B16;
	Tue, 27 Feb 2024 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lRDJMcDJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AB9145B03;
	Tue, 27 Feb 2024 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036357; cv=none; b=CCMOpYiJ0XjL/CX5yyJQoM/7IIUbTZCwjH4VO5HYPDrvP33zczHC5+nDUing/RkM/W/0fIg+CjgctXnKRMVStoWMNmK9fYAD3DLvjtzN2lWomf8zwomi1FxkPqFHPOEXYHaBLnaaK5chlPwZv1vQNSKmKLCtBRFAG8+OfqdAOZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036357; c=relaxed/simple;
	bh=5hVYIvl2U98+Gtuqia6aWSk69bA22de9SfFiODa1H1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrZVurW63CI3oAcA4ImdYHkai4H5SkwGaJOhtKqHI4ejoGeThRvVgStbpULNijCOvWqyUAOUgv44LQ+aHbLQmc2gh6JfIaiqYg89RUzYRLVKS1Cgg1eJeXNkUUFlS4V7YCCZHdZWJdYIaWECwYUqUs5/jTGzAOdVGKrX5ydW5Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lRDJMcDJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709036354;
	bh=5hVYIvl2U98+Gtuqia6aWSk69bA22de9SfFiODa1H1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lRDJMcDJBTOChJ/PzT6Acs/ODfHKQqUwGpOT6LdyfUcQIT+nXZ2+w/5SOhp1tRT8g
	 wYfCahM7BgKcDjXfPlQ5agSMCFF73E4Ic73DlqVeQzGGngTCO/TRXvi22Jf+Zr/lN7
	 ThysIkSBWuuGuNB4L0RV4/VkdhAbJOrRB8czBwzUNKWrTVY5FMpWpu1vmR3tZfr8rt
	 VYq6yHOxzVlO4C72aDUjqmR31JQR1l34bMA6VnTFWPveah6fOrCHp3KYvjsU59pu/M
	 KNHCeMNm12hxqnBLJSw/0pdpLWKMhD3rMJRQhh16pcp1wPFORmIs/eJWz0Dhqe74Qz
	 r+xihctBEFnkA==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0B71A37820F0;
	Tue, 27 Feb 2024 12:19:12 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	"T.J. Mercier" <tjmercier@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/2] selftests: dmabuf-heap: add config file for the test
Date: Tue, 27 Feb 2024 17:19:10 +0500
Message-ID: <20240227121920.1905095-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240227121920.1905095-1-usama.anjum@collabora.com>
References: <20240227121920.1905095-1-usama.anjum@collabora.com>
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
2.42.0


