Return-Path: <linux-kselftest+bounces-47766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC49CD3031
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 14:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34ECC3017EEE
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D499A30CDBB;
	Sat, 20 Dec 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="LBW9jm44"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D43093DF;
	Sat, 20 Dec 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766238970; cv=none; b=XSbGWyis2QsaRVAJ2q9ObIEU0iUHJzIqGu48FcwhLbIjQYefb+J1kv9dirREt4HO1E4khNVcRF/XiELWREONq8tFFRg02K3Ie6ndKDFMH03bAtvVhgBwQ3QLbivrPRsGM5WhZQ2o8VSDtQQf8juCWRYCXgGDgEKdkycw+lYuq6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766238970; c=relaxed/simple;
	bh=4uTrm4AF2R5U5BVS6YaJyByfQ2N8y4ad1rnEAkn6Ruo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HqIcfqpL3KINErbk59KJLWJtqlumjXMbl6UKEloqrVufN7+8UDVNCNCInT28zR4yDeBLiHUMoOsAun3qbT/8n3bcP+8TvOduR2NO92iEeuNYQ6uJr5SJHqVDAM6K+YtvPsate/Ij+MJKomLn1mMPtF7M3vFAqHYuIsrAXvkRuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=LBW9jm44; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766238957;
	bh=4uTrm4AF2R5U5BVS6YaJyByfQ2N8y4ad1rnEAkn6Ruo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LBW9jm447mdYsJA19VUkiOVpk4bTo8WYpxO5Pnl3VKuw65G+wGv27RFYART9y1U/Y
	 hvvUiBLL6TMrV/Iw/H/Yog1T06Ft5FyRefkFMH8rLkxiR8rfWpRE5r697bItWw7gJR
	 FhFymXqoDVDxM3xcBlwn7SKH2w0R8BMl3hpOJaHE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 20 Dec 2025 14:55:51 +0100
Subject: [PATCH v3 07/14] tools/nolibc/select: avoid libgcc 64-bit
 multiplications
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-nolibc-uapi-types-v3-7-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
In-Reply-To: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766238956; l=1480;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4uTrm4AF2R5U5BVS6YaJyByfQ2N8y4ad1rnEAkn6Ruo=;
 b=pRlIbQNbkjzVYTOrDPdAvnTkRPYWIOHcVoaTdLYSLOjmpwaYR8slKcyyJemYTV/YaUIzgOMbL
 FfzlNB58TF4Dgf5yGhVWnBSUV9WQmOm0qOXE58SI7/8KBAC3eM5puqp
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

timeval::tv_usec is going to be 64-bit wide even on 32-bit
architectures. As not all architectures support 64-bit multiplications
instructions, calls to libgcc (__multi3()) may be emitted by the
compiler which are not provided by nolibc.

As tv_usec and tv_nsec are guaranteed to always fit into an uint32_t,
perform a 32-bit multiplication instead.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys/select.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/sys/select.h b/tools/include/nolibc/sys/select.h
index f8870ad49687..80cb3755ba18 100644
--- a/tools/include/nolibc/sys/select.h
+++ b/tools/include/nolibc/sys/select.h
@@ -68,7 +68,7 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 
 	if (timeout) {
 		t.tv_sec  = timeout->tv_sec;
-		t.tv_nsec = timeout->tv_usec * 1000;
+		t.tv_nsec = (uint32_t)timeout->tv_usec * 1000;
 	}
 	return my_syscall6(__NR_pselect6_time64, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
 #else
@@ -76,7 +76,7 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 
 	if (timeout) {
 		t.tv_sec  = timeout->tv_sec;
-		t.tv_nsec = timeout->tv_usec * 1000;
+		t.tv_nsec = (uint32_t)timeout->tv_usec * 1000;
 	}
 	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
 #endif

-- 
2.52.0


