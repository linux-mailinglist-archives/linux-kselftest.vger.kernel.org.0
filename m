Return-Path: <linux-kselftest+bounces-41966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D198B8A548
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 17:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658641CC0648
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8746631BC97;
	Fri, 19 Sep 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JTZCO6jA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C4031A817;
	Fri, 19 Sep 2025 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296170; cv=none; b=j+NRvOnyQgRfjWLthXlWNadLZI5oBJcCsAeaJsuTjMWWS/SG8r8FhMu/AIyQYwmydu/WDa3HpTZeGhAg18J4GaSkKz3PtIAHbcrb6C0Y05O8EOJHo/X1f5Wz0KACepYwSBFOu9iuo9oaQxwxIuo1LoQjk9Z/tbK8qgwhiKMJqmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296170; c=relaxed/simple;
	bh=8uFM5QahYXW7uNN8id5O/6sxqvaTOGEeRZfPDBxEGMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAzQWlwIDEuMO8CI9UPxOp54MzQpNiUIa2bjSCpNDavP+QQOX6y4UI8E0O3LlPikth1u8OlurCfk0dSaC4vq0WmUxdygJXEldNMp8hsH9HRXcWqu3BsOAZnDeOwZtjS2Jol+wOLz5jFf/T5HAI49yvxYgkK4oks2s2mIJMhIwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JTZCO6jA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=I1cm2is+Xgw+x+T3m8uuoGo4E722CtwyukEZGpVjsa4=;
	t=1758296169; x=1759505769; b=JTZCO6jAUIrT1ob39rSXMBeY5WBaWCgty1eNBA/x23pLYxL
	PqdzJevfR888VTVSrNpledquiW7auI+cmfxvyTZcyVoKMJ+VwPq3FewYGBr+YOgQavH8iQTn9mMbH
	B/TtY4gcOPnw+dfC+tcfzseMinqh8HdEqyqwN3VT53J5eWGmHxuJoc5tSjQUbgmeSx1X9WOagTzQR
	1kn44ZFM7jlWuWcYyHzgWwaszo+4AiKik4zxiqlqZ7UbeByGWqkJ3WXeBtysMYBuvkw7lHQ7e1mu1
	KG2sXSZxOSwGBhy6tkNfhvSQMzu8XtaFEMz8lhsafrMUNFYO3h3WtbLVgFpcN4FQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9Z-0000000G6O6-2S7E;
	Fri, 19 Sep 2025 17:36:05 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 05/11] tools/nolibc: use __fallthrough__ rather than fallthrough
Date: Fri, 19 Sep 2025 17:34:14 +0200
Message-ID: <20250919153420.727385-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

From: Benjamin Berg <benjamin.berg@intel.com>

Use the version of the attribute with underscores to avoid issues if
fallthrough has been defined by another header file already.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Acked-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/compiler.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index 369cfb5a0e78..87090bbc53e0 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -41,8 +41,8 @@
 #  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
 #endif /* __nolibc_has_attribute(no_stack_protector) */
 
-#if __nolibc_has_attribute(fallthrough)
-#  define __nolibc_fallthrough do { } while (0); __attribute__((fallthrough))
+#if __nolibc_has_attribute(__fallthrough__)
+#  define __nolibc_fallthrough do { } while (0); __attribute__((__fallthrough__))
 #else
 #  define __nolibc_fallthrough do { } while (0)
 #endif /* __nolibc_has_attribute(fallthrough) */
-- 
2.51.0


