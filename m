Return-Path: <linux-kselftest+bounces-41455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5C4B57135
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 09:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46500189D579
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 07:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31C52D662D;
	Mon, 15 Sep 2025 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vV5pBU8+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370362D5957;
	Mon, 15 Sep 2025 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920928; cv=none; b=QdQDAJX3jN5R7iMDOO4suw8F3FQrq3/7qbQPhvFeANFRumQNYAyG+Bo+2QdIdxaE2whKk9s93PldbfgsJ3V/VPFCRCReCeNf26dB4vN+Iyh7MIk7+I9tF00WQl7siuDy+CwHKLvijP/Y00PSjQQZv9/TxUWvgKkMXFAVuo6ehnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920928; c=relaxed/simple;
	bh=E8hQb4X+XkJci0FWYLgNCRcpJ1v+QGRZfKaHzIWPvJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uznHR3iLjs7W9T5iyijNaEVURDo7b+6ARe4EmQWY2opH3sJ2E9y/WjjwEJGfbNLLYJhCAbGfer8Q9pmlhMm8Mk5E4i+pFsbyPHGDu4166erttzo2T+vFpAarkiAodAK6ou25louSNssiU+m20lZtdRsjtMpjGTT16+kAxBt7TL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vV5pBU8+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ELAWiFcBCxLD83jcc9mACALAjBu4TVZ8afWkcSqdi7Q=;
	t=1757920927; x=1759130527; b=vV5pBU8+r2qjuQbu8/1HZhnJdMf7WAWNMh9fvx+rkijPybD
	gor5v+3FYQOoClkh2nabcdsPB/WL7mvvZajEhayi9v6tMUp4qwQnR3jPmaKVr0LVQEfNEAjS5zSHM
	7FnpTTXDMOT8NxPP7R/ZqkC4cHmBEOtG+H0ONB5ToJEmgl7j8D4GgN9K4020s9FY9YdrABApC9p5N
	mWD+9oAsgW71OdTgjvoWVPZPxHMaSKHO0yiKiQVoctjFev1aloOOvdUr6sqreflrUv7FrwIAMuVrq
	cMFhzrYIlrbpu0sfNCUUqyK5BUEcpQr0b52fAVcCHwzT46cDG2MyZajrkQzcINJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XG-00000005w6o-2zYm;
	Mon, 15 Sep 2025 09:22:03 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 3/9] tools/nolibc/stdio: remove perror if NOLIBC_IGNORE_ERRNO is set
Date: Mon, 15 Sep 2025 09:11:09 +0200
Message-ID: <20250915071115.1429196-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915071115.1429196-1-benjamin@sipsolutions.net>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As such,
the perror function does not make any sense then and cannot compile.

Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
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


