Return-Path: <linux-kselftest+bounces-5700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9331186DD60
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 09:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A201C20A53
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 08:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259C76A323;
	Fri,  1 Mar 2024 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GZLR13eH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F56F6A031;
	Fri,  1 Mar 2024 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282758; cv=none; b=rx/M3mNM1B2Jm2Pa+AlKqCDmUwhjKfFK+0Z8ObLG25P3rVaL4lgwpZJwzozEY76N5Od5RYmW8bld26T0QtHw/VUbYDC3CCvP2SH76UWyBU04QDv6sMJneQXqTk4ZvSqb+lgwhgbTNaBADs4fceTO6POO6TyHOakzFjxVjkUg3HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282758; c=relaxed/simple;
	bh=9lc4pDkvuUw9UpBozHPb1wF+lwtvZHvSgcQf4nX95ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qV+C50TyOpp0s0WAiHD+3CnbRe5zGR+ZQXPx/eK3L2lgucBlH6t3E9eFcR0VmB9HV30Q95WoXgzaoMedMrXmhezLkLs4+RfDBu9LesMPmuu1g085rYqMmiZkxTardtAVtTsiq69bLig0bEI9pdj+KBxBxRXtkMrSlHzNTolMeJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GZLR13eH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709282755;
	bh=9lc4pDkvuUw9UpBozHPb1wF+lwtvZHvSgcQf4nX95ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZLR13eH1oJ2jYIZJm3bc+U6+86n5RBs5cqiARMOMHHHJx3duMqG714V8Xfu3WjJ3
	 D62gtELsSOkVIc0Be+yzpckr+h4TJTOV8uJ+w2wOLWnYWn6DAJcKeSgKYZ8uRTKWmd
	 AEhU3VWDU3UxHwQ3YwyNCnrkDgqdPqQF8FVBMVZpD8d7tttG2KZFQnNraUdQomLPec
	 Wp+tSLvqqKWhueVWTIIXyw+QkYcHaH/NoVmQZVY2TFeLxFEpgvb5hAAMHDHob/4OPq
	 U73gq50p8nZHtRuSnyxgie68PThbjaKQaP0ztx1M9UwZE6KHZBFWusjS5z99ncYvqY
	 DttO7uInA+nRA==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C0EFE37820D8;
	Fri,  1 Mar 2024 08:45:52 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	"T.J. Mercier" <tjmercier@google.com>
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 2/2] selftests: dmabuf-heap: add config file for the test
Date: Fri,  1 Mar 2024 13:46:07 +0500
Message-Id: <20240301084609.2133900-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240301084609.2133900-1-usama.anjum@collabora.com>
References: <20240301084609.2133900-1-usama.anjum@collabora.com>
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


