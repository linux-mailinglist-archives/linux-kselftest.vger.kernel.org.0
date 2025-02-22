Return-Path: <linux-kselftest+bounces-27262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB0BA40808
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 12:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815344234F6
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 11:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9460C2063DA;
	Sat, 22 Feb 2025 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRpy9tXh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569013BC0E;
	Sat, 22 Feb 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224836; cv=none; b=ZjO8/lS2VuiYMLLfjMZVLNSguokqiZ0DOsxSazBs6JeQuTek9kfr/QJdlMBEfpkMTh/aONFpYnbDsMi3IgN+xxomwrP6ZTSae9AwWKjZag9Z9dcX5jtdtcjdxfWESdkkRju68mGYjZuJBZRhFDnC+kZwuupNyrugPfdGBOv/zDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224836; c=relaxed/simple;
	bh=oAdQ4PaWiqE7P/UfEF3Qb7V7wE4e3LKK55/2Ij5cPLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=srnA+1iZyjXyFeWmDPUaRfp29gpYa6/ImDK167rp4OoCC930r9oydXmN1MfoB3RDiR+3q4U2zE0FoTPbJm+PLk4sySOfMlseMHwMQU78R7oy+Rs3P9N3ia7t+2GwPt8iqV1LbinXOONbqFoKQPxzpCI1dt01ZAZ9Bm2bbabUkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRpy9tXh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220ecbdb4c2so82461175ad.3;
        Sat, 22 Feb 2025 03:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740224833; x=1740829633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8EhjXwW3cQDbxz191xEcftyc/2qMfllgMiMAgqUe0Eo=;
        b=QRpy9tXh0ENsX3Gz+CjVo/BO/pUPnXJAQ1R5MoKHL5TgEg04OpkqfrZg8m3pY69Cli
         t5h4pOQgtVhfN2vOjblKT9aHzn/ixi+BOjpUAiFvHB+++Wllc60IwVZwJQI/XSqOWS2c
         +YaofcWtQe1kG/G9RMBBrwZ+CyU01a9DSfHSSfWo2ApZN5K+zC6RWdQMAU+Ohwc+YmVt
         gXtXAK98stcfPAGOHFU/W7WIOyXcsdAcDe/LpiswSHcs1cKaV51HMpmdigw7vPEUuAVU
         NhcnggumtXp8kU4PbNXL0xjQxOJAtxPWERk2wb3c/hipVgWQYyizD12BpvhpVJ6yaJFa
         ps1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224833; x=1740829633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EhjXwW3cQDbxz191xEcftyc/2qMfllgMiMAgqUe0Eo=;
        b=Lv2sqrIPrVtOeZJR5SDTv6j/riLbcWgrYh2lfjlG9ct+U3I853WpfduAfEjPIBFwS4
         O0DuWDyL0MUNRSlgkOqiu+gKMx9juJIc9RykCe4hWUvhtN5+EV6f3suTlbufJCnXfgE6
         LHJLIf1gyBuy/elQxjt0jWe/qYCqMFCF/qDIvADnhzQoCxQLWjXRaJgjf0/KGg3ze+3W
         om9//HMHl8lVmqPMDtCGjuWQKKP+7gTaKruYHtwdtgh2YZ8F81EA7jRqVOR+bbIOZkZJ
         1Tj3ZKef9xFk8+txmPFAx44PiO+eeDTGPK1VF8SZqHDa6ascuTgqZjFjXHQx7oAgTLPq
         rUbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5DGpTJT5hyzCgzeKucNfueI04sQH7k2OQ+u1kVr9LSLkr57uOvpKtbQu9CRlquxWKRSEn0qJi+Gpsq5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOwx2NBedwJxHidmQH9NdXnm7XSH9ApXxbYSt2hgs0t9zMi+SB
	2GXA51EON3rwPpa3UpDnXc0vpjw5JCDb/s6TpYD/myx0SgJn7UXg
X-Gm-Gg: ASbGncsML4e6pK7UKL88FlF6CX+acMwWBzVOcsxPxCPiBHTN6kgXmlnbXm9nD8zyhiO
	e9TZ8fA26TUjDly52ALTaxMEBPQ1i0/Pq0C/37WnAvOTN8iVI7panARUKN11hLcrskx6VQ1AgjV
	x3N77pA4YmHCGkbIhesgSsCBTTsZUNkR2xtyeq44ftE0FyP7T1zqzTnCtaxqW+/T30ehIHWT5Cs
	iBUtksoBRpRcwIoCEjxNI654J2zgTmV9J75x2oNw/lt2Sx4XP8VQ22q79jTraFrhj/8JZNAtlAD
	5KaSUkmbPwEdrXw8ObbDf5yMAvM4OZhQNjpCfUE+7NGcPAE3q1k=
X-Google-Smtp-Source: AGHT+IFe2oYcDmWj3WWHE6JRwA1QVbVHKisGIBXbUQEdyBCmtYk0rGGSQXdgj5aGz3vfKCnxs6ku2g==
X-Received: by 2002:a05:6a20:9f86:b0:1ee:dded:e5b with SMTP id adf61e73a8af0-1eef5300760mr12744680637.24.1740224833305;
        Sat, 22 Feb 2025 03:47:13 -0800 (PST)
Received: from ritvikos.localdomain ([49.36.192.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325953a4a9sm15175579b3a.82.2025.02.22.03.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:47:12 -0800 (PST)
Received: by ritvikos.localdomain (Postfix, from userid 1000)
	id 55376ED9143; Sat, 22 Feb 2025 17:17:09 +0530 (IST)
From: ritvikfoss@gmail.com
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests/mount: Close 'fd' when write fails
Date: Sat, 22 Feb 2025 17:17:09 +0530
Message-ID: <20250222114709.50011-1-ritvikfoss@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ritvik Gupta <ritvikfoss@gmail.com>

1. Close the file descriptor when write fails.
2. Introduce 'close_or_die' helper function to
reduce repetition.

Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>
---
 .../selftests/mount/unprivileged-remount-test.c     | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
index d2917054fe3a..3dd9df58725b 100644
--- a/tools/testing/selftests/mount/unprivileged-remount-test.c
+++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
@@ -54,6 +54,13 @@ static void die(char *fmt, ...)
 	exit(EXIT_FAILURE);
 }
 
+static void close_or_die(char *filename, int fd) {
+	if (close(fd) != 0) {
+		die("close of %s failed: %s\n",
+		filename, strerror(errno));
+	}
+}
+
 static void vmaybe_write_file(bool enoent_ok, char *filename, char *fmt, va_list ap)
 {
 	char buf[4096];
@@ -79,6 +86,7 @@ static void vmaybe_write_file(bool enoent_ok, char *filename, char *fmt, va_list
 	}
 	written = write(fd, buf, buf_len);
 	if (written != buf_len) {
+		close_or_die(filename, fd);
 		if (written >= 0) {
 			die("short write to %s\n", filename);
 		} else {
@@ -86,10 +94,7 @@ static void vmaybe_write_file(bool enoent_ok, char *filename, char *fmt, va_list
 				filename, strerror(errno));
 		}
 	}
-	if (close(fd) != 0) {
-		die("close of %s failed: %s\n",
-			filename, strerror(errno));
-	}
+	close_or_die(filename, fd);
 }
 
 static void maybe_write_file(char *filename, char *fmt, ...)
-- 
2.48.1


