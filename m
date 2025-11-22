Return-Path: <linux-kselftest+bounces-46324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 180B8C7D455
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 18:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2AF23A9B3A
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBA92FA0C6;
	Sat, 22 Nov 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uBdyzfw/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C92D94BA;
	Sat, 22 Nov 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830797; cv=none; b=hu9LToAbdvZnFYv3PRqfJhiQqU5OQjfEdmTfsvFrzuM9On+eblHLiV2k2xclCbJnvOfqnZn/QejPXYCwuJFqnq35trcCU5p3dY/fa93bsqr/+9fWqiULhkoYPU+fvBa0Hg28bLe4RKZlC5rp4fgvOOXqBNPTR14WjT77N0KQx9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830797; c=relaxed/simple;
	bh=QKw3UT6TASNbtH8Q1/NguvYLGcJ0Y+8XijBIm9WC2YQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lhpFgHmZnhYom/LjYNXzx2BtSzLq0UUfbNyUOtXDH4+F6To6SDFtYdrIigeMTexPB1Oq2Iv7H2faVpy0ZU3ariINUrC/7AJIzk2k+5lXUXo0/DuN/MkOL2W0C02pRrJcMlfsOyuRl3TpT/FHZKfkym1FIM5YLpWG2y+4vlIlSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uBdyzfw/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763830790;
	bh=QKw3UT6TASNbtH8Q1/NguvYLGcJ0Y+8XijBIm9WC2YQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uBdyzfw/IChOS3NQ1pguLv1q0JmuwwQfroIXyPTfLqaoX7BeTHGePm2YHiLdsHdag
	 SlJK+e6gHF4fQ9sqNQScAiWNJUZ+H37C3CIkjZI+VIviOfVnLWyJwWwmU+7U10MF4a
	 fjOYtlAT8njdb5N3uihZb1ViF69gAF9W45Q/3WAc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 22 Nov 2025 17:59:10 +0100
Subject: [PATCH v2 04/13] tools/nolibc/time: drop invocation of
 gettimeofday system call
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-nolibc-uapi-types-v2-4-b814a43654f5@weissschuh.net>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
In-Reply-To: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763830790; l=1125;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QKw3UT6TASNbtH8Q1/NguvYLGcJ0Y+8XijBIm9WC2YQ=;
 b=pXysmdDiKxP+ca/CQvQpJzyLzcJxfUeAVeUJE6jhYC7ujBWCFSFfElbz8WPEizwIPMT7U2+t+
 UVlUfP389M1DrhattPIBygd+o9KCaWLw1t5Ne8bGs+YuFTxS3ja12Ug
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This invocation uses libc types with a system call. While this works
now, upcoming changes to 'struct timeval' would require type
conversions. If types are converted anyways, the clock_gettime() based
fallback can be used everywhere, simplifying the code.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys/time.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/include/nolibc/sys/time.h b/tools/include/nolibc/sys/time.h
index 33782a19aae9..171187836e6d 100644
--- a/tools/include/nolibc/sys/time.h
+++ b/tools/include/nolibc/sys/time.h
@@ -22,9 +22,6 @@ static int sys_clock_gettime(clockid_t clockid, struct timespec *tp);
 static __attribute__((unused))
 int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
-#ifdef __NR_gettimeofday
-	return my_syscall2(__NR_gettimeofday, tv, tz);
-#else
 	(void) tz; /* Non-NULL tz is undefined behaviour */
 
 	struct timespec tp;
@@ -37,7 +34,6 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 	}
 
 	return ret;
-#endif
 }
 
 static __attribute__((unused))

-- 
2.52.0


