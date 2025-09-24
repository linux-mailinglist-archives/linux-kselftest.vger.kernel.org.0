Return-Path: <linux-kselftest+bounces-42184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E15B9A37D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD194C79AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BAA30AACD;
	Wed, 24 Sep 2025 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DoD/7jQd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766683090DD;
	Wed, 24 Sep 2025 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723719; cv=none; b=SG6rcDKV6TJZc4qrlNyNGpHNsxslJeDdzuSZhybMP18186dsIs3cWAyF/T4vDzbpBnBu2/ybkf0ugV/JCTqngPrbz/6U6FHtxZ5cWzMn93RSBv+JjvU4sPye6v3B2rPVIxbnP6JIV3Ba+G3IxkC4vS5vZs45+8oXG8TBUaeRFH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723719; c=relaxed/simple;
	bh=Xiw19+7GfrtOjXlL4v7+tqa0Ibj+6W6IJ0mJnnK0hic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeRGlE7X93yHqFQ01Pjcty636xb5z+GdPAXdx3aTyBGiXiVYEdBL2va6DNznyIFIUpYKCiRmU2+QiwhH28a43XKj+Ipf2mAvHclGqlGdiG+AH0qJ5/FkW7NNcEqRHDbkRCzKmeNWW1TftHSU6GPrWf5/7Wt1ps3+0efQuWUk584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DoD/7jQd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SesBRyEDdeL4b2WR08hExbhuW4gCAOOUoslrVli4iZo=;
	t=1758723717; x=1759933317; b=DoD/7jQdUrtp1JJD1HN+IKrkbW1Xdt42UOQpILwSwL2NyVl
	Ax1uMf1gv8xWc102VVvcXCFu3jphupIe7eREsY1VLz+ehW1KxL8ChVkLKU00rCY2FnO6VUwQ4nA+8
	sK8r2+SycI5SvCjIwFcoD5UDCySfH6Siyu74hbNa3fjPSsOM+4fHj3DAkqTTVyev2MW6AlGeR5I0y
	eiFkRYkgc/9p4RHj+go7GU2Fj04iwntKuHrOFI8Rkdl+Z84/EhHdfF9DgQMWqCP/VINDErxc/XnfT
	bRQT2oKYFMKYoGkEdLXuWaj2OPt56kxIwTI8ofc5rrc7hwtMpJOkGKmFQOMygWeA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNV-000000090Bz-1qiK;
	Wed, 24 Sep 2025 16:21:53 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 05/12] tools/nolibc: implement %m if errno is not defined
Date: Wed, 24 Sep 2025 16:20:52 +0200
Message-ID: <20250924142059.527768-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142059.527768-1-benjamin@sipsolutions.net>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

For improved compatibility, print %m as "unknown error" when nolibc is
compiled using NOLIBC_IGNORE_ERRNO.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 tools/include/nolibc/stdio.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 724d05ce6962..1f16dab2ac88 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -321,11 +321,13 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
 				if (!outstr)
 					outstr="(null)";
 			}
-#ifndef NOLIBC_IGNORE_ERRNO
 			else if (c == 'm') {
+#ifdef NOLIBC_IGNORE_ERRNO
+				outstr = "unknown error";
+#else
 				outstr = strerror(errno);
-			}
 #endif /* NOLIBC_IGNORE_ERRNO */
+			}
 			else if (c == '%') {
 				/* queue it verbatim */
 				continue;
-- 
2.51.0


