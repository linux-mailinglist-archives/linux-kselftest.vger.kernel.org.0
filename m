Return-Path: <linux-kselftest+bounces-42182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA2B9A36E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C45C07ACB0C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C095A307AF6;
	Wed, 24 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PR9yPJiu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFBB3064A1;
	Wed, 24 Sep 2025 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723716; cv=none; b=Z4Z74M2/Aphmozc6uPyPhUjHLQ8d8+0Fua404uAKXUdfUH/8bsi+oU30tMEjtTMpgTZPLMupJrBaB4+MTn8s35GhLbE1xLxKHLdx5ZIhd9z8JkAkYZHnE2JLgpukERnc7JbwZCIlz8j+hpfsIo0w+TJT76nY+13yivuTQLgqMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723716; c=relaxed/simple;
	bh=1IvQbjw8+XR1qV62teqrY+kea2Kmn19VdAe6m4o0g1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHGOt9GSn9iNwAps9kK/zeyWxtMkiNAYBP0RzsC7UFvO7x5tGENNODa12EG7qQbk8RcZ1dXssD7A9QAQJV9wo5+XgehzI0oe6v8nNml9M1160pd9yG25a9fYmtAG/d1QSkqPVp2eMYiSTUDLA2bA2RygPfA39FAKNBQTgtoKZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PR9yPJiu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6yjSl7NQvkiVEY35fXfoYnNnDHpwXZHvAt2SFrR0I98=;
	t=1758723715; x=1759933315; b=PR9yPJiuL8RtmcvSTwKmVDkrQEM1RT6Qj8q6X5pIv2deXK4
	ZJ3+ydsx+4dZ3JGwnv4DJQj4uaIfDgBgme1AYXQ+94cijTlM2u2dREzpbpNW+49ZRX2eApRM8GWvQ
	u0dcASSf7g8SSfpmmJ0dtAC/tPl+ZmgY8dzi/uqZtyNANgQbQvyiMilAphvSbj84vgLPUGiZrCUKZ
	rDuAlTB980tT/JbzLbM20OCIDoOTgcvMRXRIClKw/3p4AtaupPeqAKKBzqNZ41x5gZ4Tj6C6DN2ev
	hGbhRHUbdvmsWKFwKFF42l0qYiHURHiJuVHh5ivAXvIXID6xWqswwafugS4SpToQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNT-000000090Bz-1Esg;
	Wed, 24 Sep 2025 16:21:51 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 03/12] tools/nolibc/stdio: let perror work when NOLIBC_IGNORE_ERRNO is set
Date: Wed, 24 Sep 2025 16:20:50 +0200
Message-ID: <20250924142059.527768-4-benjamin@sipsolutions.net>
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

There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As such,
simply print the message with "unknown error" rather than the integer
value of errno.

Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---
v3:
- Change the message instead of removing perror entirely
---
 tools/include/nolibc/stdio.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 7630234408c5..724d05ce6962 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -600,7 +600,11 @@ int sscanf(const char *str, const char *format, ...)
 static __attribute__((unused))
 void perror(const char *msg)
 {
+#ifdef NOLIBC_IGNORE_ERRNO
+	fprintf(stderr, "%s%sunknown error\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "");
+#else
 	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
+#endif
 }
 
 static __attribute__((unused))
-- 
2.51.0


