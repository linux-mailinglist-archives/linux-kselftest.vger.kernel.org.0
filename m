Return-Path: <linux-kselftest+bounces-27255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26940A40643
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 09:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB3819C6592
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFFE1FBEB0;
	Sat, 22 Feb 2025 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWxuUUdw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD437E765;
	Sat, 22 Feb 2025 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740212238; cv=none; b=BAxmKNvYxBiWM7cESWGjtqFIt1FHuuE5e8wHU1ICpx5QrgmX90LB3IKGAx7XloxAWZsOV+kwpo9npNSuNpoMwp1XnasYiw7o/zsqLFyO0OpWV6v1GZC2ei8GgSxcyu/pV9lCY4FmQlrrVT/vlol+C+5W5//8/nLRUPFpPDVceEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740212238; c=relaxed/simple;
	bh=pNM8UNel5Vn9UCBJulNNt+Eg/9WHplt800krUS+hNac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2C9SyD/sdLM5bp0UmphamPS1zT5DRhPxdzVQHDK2BKbLxivMbg6XQrcPLWuSnZoJpddmrw8cM+0J57EtVenjzPEAcyrNMalCPMyrBmFr8bsDPL6AukjKtmugdw4tK1Hliz+dZkOXSrvcaj5DTidU9KsP/GZzGroRFI0gN6/khI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWxuUUdw; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so4645487a91.3;
        Sat, 22 Feb 2025 00:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740212236; x=1740817036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wHDPjKSqfpIB5A/E1OLuBbwlI4E1DEs0RtP9GIz4GaY=;
        b=gWxuUUdwGR0gY5zUoe53J9uvi542kawd3gZGGGjFUCeInfKwY0kDLgXUvbs3icDNLF
         BZZLn5ric+ocqfcDEqaircxt2+MYPLZtt5QRDxn8k7quowhWZBKOCFEam4ZxqihXWm7I
         zt1bEr2t0Lv8tQW6YRmkXWrUSDlnY1a5kGUWAXwnEpe8swClcBVIoN+kZEwv4RlKobLE
         zpbyjN9lyeP/ZjW3SeJdRnRkeiB5GO79xlp1yhRRHHspSmwlbuuqf0SZjjLYlT5g02Sz
         km9MlVogP301AyLal9wdJE4vtzJ/hmoTBtGgr0XBRXs1wb1C4Or1b4PhUgtujNyFDFht
         G3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740212236; x=1740817036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHDPjKSqfpIB5A/E1OLuBbwlI4E1DEs0RtP9GIz4GaY=;
        b=vuhzvZIyPuhDoAccN3J16ENUrMvoZKF0xNhwyOWEruQj4d5S3PCLzU8pZGRihZ+4jO
         IqxqTyPzdWWWhzfiPRGkdLmf7q7cpqM8TtBTJruXwrVUQXsRzXk731nklTvUOvkrIb8z
         aCKDp2ZGtcrdstp4uB7CivaqOoyJCmJI6+ELeFxOHxAVXzev0kijrepnAzI7ZBY9xodf
         +3toP8PZhs2XUs2gjAVw6/XGftE5pHt5O1IqHnarrOl7PSaHCQLCta5EKuCImK9Y1pkl
         e1Xd3WVZmrzpMDi6/qS+GwpRkuOZUo23BcRXV646juGeMBudFKHQ7h3nqFqUIpMigcAn
         4Ucw==
X-Forwarded-Encrypted: i=1; AJvYcCWRFPXSkkr01FjYlkESVeDEtx2Sid6WEy/1W8ONcQbsXZtmupbBLMjP6HBLeJjV73YGibOz0FtGDzou0Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqxUIVzQv8DIMjXploNJLLKo6UF/7jdlSIzQ01HAqx5utYIRo6
	2sffTWd89WFW9Z8Q/YLiomqm0lk2cKLWL2VmFo9qeYMfcdfPIzvv
X-Gm-Gg: ASbGncsyXh2B8c22n0XTSxch6drluh1qwLi55EFNUKrAAXUOSj7DWdlv0XjgQFmLEQm
	Ueq9mStoyRSGuYX6NcTGjtgulz/0fuKzg3Ij1ErjYg1RHKhwzADbl1p1IrLleRU5MsVWaOnfKfa
	px8bteYM557XHFvfSHgm+TDxiAU9yAN049BF308OtS8kgwNHyea3I9wtFIhO4q+PVJa+YbT9BF8
	Pc3klFaYCrHkwtAD80pAhtaMOlN9y1BB+L01tKq8YQUeweh6TxNanQRhhJGK1FY8v9VqkMnwZJs
	W+S6keT7nsELKj2JiCpx3f73oFXmTPWYvkdQd7BaEwMRAd8dlzo=
X-Google-Smtp-Source: AGHT+IHYiUlExnHbrZ2Gy+mUwl+ooGggZVNKuviRBaebOAxCDdU96sIy9/wL2kGhI8PsWgn7mKlxCQ==
X-Received: by 2002:a17:90b:164a:b0:2ee:9b09:7d3d with SMTP id 98e67ed59e1d1-2fce78debf4mr9740356a91.19.1740212235818;
        Sat, 22 Feb 2025 00:17:15 -0800 (PST)
Received: from ritvikos.localdomain ([49.36.192.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb10fb5bsm2603189a91.33.2025.02.22.00.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 00:17:15 -0800 (PST)
Received: by ritvikos.localdomain (Postfix, from userid 1000)
	id 1697DED9143; Sat, 22 Feb 2025 13:47:12 +0530 (IST)
From: ritvikfoss@gmail.com
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests/mount: Explicitly define buffer size
Date: Sat, 22 Feb 2025 13:47:11 +0530
Message-ID: <20250222081711.48208-1-ritvikfoss@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ritvik Gupta <ritvikfoss@gmail.com>

Define macro ('MAX_BUF_SIZE') for buffer size
instead of hardcoded value '4096', to improve
readability.

Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>
---
 tools/testing/selftests/mount/unprivileged-remount-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
index d2917054fe3a..67a550b7c69b 100644
--- a/tools/testing/selftests/mount/unprivileged-remount-test.c
+++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
@@ -45,6 +45,8 @@
 # define MS_STRICTATIME (1 << 24)
 #endif
 
+#define MAX_BUF_SIZE 4096
+
 static void die(char *fmt, ...)
 {
 	va_list ap;
@@ -56,7 +58,7 @@ static void die(char *fmt, ...)
 
 static void vmaybe_write_file(bool enoent_ok, char *filename, char *fmt, va_list ap)
 {
-	char buf[4096];
+	char buf[MAX_BUF_SIZE];
 	int fd;
 	ssize_t written;
 	int buf_len;
-- 
2.48.1


