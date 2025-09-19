Return-Path: <linux-kselftest+bounces-41964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE507B8A539
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 17:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06148162A8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7794F31B111;
	Fri, 19 Sep 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vEKPqzV9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2A3164DA;
	Fri, 19 Sep 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296169; cv=none; b=XL/7puwxvai0UZs4JBI3dzKuvZlGfC64ePWTt0ISXJ8N4lYqLRUYryUeLst2hkDT9i/tfbsae+1iwAAMcxhTtTMAWbX2Yc7aQsnwlHi/pg0ADQEY+sI+3OpUnkuruN43YXrkCmmYJZ6gXPwooQ1rkFbtv4eZ5Iy6xKX16LMIU9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296169; c=relaxed/simple;
	bh=eVum/sAfgEkdwMaGYS2cz+5Pqq4ePIkKr0CqsDt5Ldk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXB+H+Omb73ACALKf1krpAdwGq8LUz4K9/QB3uExMEsPb6GNRhm0zTL5NRrriuK4FIzR/qQMf0RB0tmGoqMVzYnuqNboD5e8+0DDGgXPNeOlCULUSpQGiAgitRY5d4wGVFZhVRflL+WtbNd/d8DWumhaGDd5TrU4jnc/Elsh+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vEKPqzV9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Wzmf8ozQSXaIG/+ku6O06QBDiFnQHnI35uzHRTGApx4=;
	t=1758296166; x=1759505766; b=vEKPqzV9jcJv443XEU2ZNh+F25yWnO+lfeg0GEtdkeFThxf
	sLwKTMyuZcRcTYo9wYGQNeWl62NhmxrJk6CfbdOgnG9Eh6gTXFbACKVXT3BGOHH6mPtW7w+kpLCAW
	zdLa88oy2u0QJwh3/S5JT3alslb+8ghVCBlSNUpojbaJSMt/Ms1rzqh7qUsB8FzTCBt/B1DEUOdPr
	oqfK8HSOB0uasRzdGl0kr217Pe/uESbJiw43rTIqVHNcO0oZAwA0+fUM7SXmXOlQ9f1eiToYUMDAP
	+Yva8F9ifgmkbhO6Y0pkthmKT8sUBm+jat5MAxviKCmOQJed+0HLFJ9V/onXRdPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9V-0000000G6O6-1ALo;
	Fri, 19 Sep 2025 17:36:01 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if NOLIBC_IGNORE_ERRNO is set
Date: Fri, 19 Sep 2025 17:34:12 +0200
Message-ID: <20250919153420.727385-4-benjamin@sipsolutions.net>
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

There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As such,
the perror function does not make any sense then and cannot compile.

Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Acked-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stdio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 7630234408c5..c512159b8374 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -597,11 +597,13 @@ int sscanf(const char *str, const char *format, ...)
 	return ret;
 }
 
+#ifndef NOLIBC_IGNORE_ERRNO
 static __attribute__((unused))
 void perror(const char *msg)
 {
 	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
 }
+#endif
 
 static __attribute__((unused))
 int setvbuf(FILE *stream __attribute__((unused)),
-- 
2.51.0


