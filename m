Return-Path: <linux-kselftest+bounces-32916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838D1AB5E8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 23:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C466C3B3D3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 21:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1EF20766E;
	Tue, 13 May 2025 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqYTXV7+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97025205AD0;
	Tue, 13 May 2025 21:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747172686; cv=none; b=M16/jZJF7UAqNSFtIcuJxHsL/fKRh4uwUx2msf0e9+iTaN3ntyRKIzr/we+9l3DnBq3aacr7et0ipj1Nm3Gv+IIGAo98oxMy0JopC2cj9g0FsBLJOqw/QlMSimTLAZr3K6KKnKPpFIaqoBsfvUbYlgMLcxRENAvG4h2WBz8nBWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747172686; c=relaxed/simple;
	bh=wG/Wp1GjJWoFt+2qnjj6hA+4W+5qF2qQBrY0vwHfkDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TJwbj61WYc+Mn+ySYn+lt15RgGpuSEcF5wrAtOsduRZXHOrMwT6rgRX8aNTX/gp4G8OL5b86zsYJLcgTNZq0QdTp1xMtXjPLlWHVcNqZswDStqITX8GDBvaibEGsSpN65D84CV7m19JhwaLoXuA5wJTKVTBq1lfSvsBzvAjcNdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqYTXV7+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a0b28d9251so896217f8f.0;
        Tue, 13 May 2025 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747172683; x=1747777483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stc73lGvEUEFWN8GCfFvarZDGFQnQhaMztIejiIT7GA=;
        b=fqYTXV7+2yWshoP6FTkcC2ggeny5F1TF0iSKsKESFg7zp1JsLWbVxp7+6XcGRgn4/p
         IPz5cRIAsm+rXxHDBSKrVoorP3iO2xkzeZ1xQ6yZFrQ/nfzxA7rg15aHUZRXCJlMU5Ry
         jlFpA7S6rKQzF13FWR5yZwkda05H5VI4Qx6rRG7B0VY0KLiwx8cM+l8QNSVgpmN3G2a6
         Qt1yVRrtUAV2pyMPrwNf35A3P3HAoWdS5ntCJ7G6EK6lITE1VeFvk6nLu4e/d7fCho1/
         7ajIEL15d6k4T4vXc3tmh8Djq1aO8dZD7KRmxET5DYUV6lusdyon4KV4QFUX5aYW/TMI
         QshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747172683; x=1747777483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stc73lGvEUEFWN8GCfFvarZDGFQnQhaMztIejiIT7GA=;
        b=NAaZk6iIGJPjciItZvdN3HdfKhldEry6dgywrhspqLSnZi9aPGJSPA+JKtT4h+QNTt
         5HkkabNEdfXLfTPrQVjj5vaP92tFLeWONxHG5ZcYNEZK/G/b9vfj2V5xz03vwV8XUbuA
         PEunlIW2XP3pSNgzCd3tN775geJS0djUee3PBPNbmugOh91U2W/1SB5wxvq5m++GYvO7
         5kvMjF8lcm/XQKi+HcFYoZzauYoFQUhBq1Hkb4KbUNqQqJflVd/yleT5ftWrnME62NXH
         friSbKbeQj7ivZhVOHp02O185+kncVnlBx9t9KJno2lg18DcTr+4FANQ34JQFESQ8vkm
         Du/A==
X-Forwarded-Encrypted: i=1; AJvYcCVlf/NejK4bcRRY6I+x0fZ4I6Rycg7uIz0t998mI7hIzCeCDYnfjI77C17sAdPxkhvA9GFeEqzDR5NPwW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrCBPqmOqFVCet5/YCK2FWKn/mUmO0E76zEswsKeTMhHiY8RWX
	/RWiZuxJiSM5dO8klPZ1IA6HLaRPLrl7HDPb6JVYmduWqmHYg3El
X-Gm-Gg: ASbGncs9VZT05XjAeD0KNrRZWewjahrT188/Z/tEM5U14ShON1TPqZVIn6XQ3eP5L2d
	6rVqVEYDRc92/JKpq1oeHYEmlrvb3ZfiH4u5Hl7dSEKISwHSgEEGMCjwrkZUp1EdKT218rqiUWE
	73vFm4yikWT10pxboZXEzuJUsgni8xGVbtI4MipzYy3lKwSTrNydje4jnQk8syvvAq697WWhomm
	kP+yvrysiK9DjhYcAszcQfTq/aVK/s6PLCgdm8+O4LeHeQll0FbkH6Xfd6W35+jCRnL7g8RFIDw
	Psz4mBIB9OXD13nP2T6drgth56aOlqHqRqq8t04hFy/Hf21HpweiQUHQ5IGQ/0+Wpby6DgO1CgM
	eg3xpw0vVhDaj
X-Google-Smtp-Source: AGHT+IGXzF5SWGhOVx2TJPz9L7bLLfgkV4fFuGpa+h/kDahVnCWf39qyoJG8ICFLqHS6nS1618YzdA==
X-Received: by 2002:a5d:5f4a:0:b0:3a1:f535:e9bb with SMTP id ffacd0b85a97d-3a3496a6553mr260806f8f.5.1747172682778;
        Tue, 13 May 2025 14:44:42 -0700 (PDT)
Received: from localhost.localdomain ([102.44.114.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2a12sm17334787f8f.44.2025.05.13.14.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 14:44:42 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
X-Google-Original-From: Abdelrahman Fekry <Abdelrahmanfekry375@gmail.com>
To: shauh@Kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Abdelrahman Fekry <Abdelrahmanfekry375@gmail.com>,
	Abdelrahman Fekry <AbdelrahmanFekry375@gmail.com>
Subject: [PATCH] selftests: size: fix grammar and align output formatting
Date: Wed, 14 May 2025 00:44:38 +0300
Message-Id: <20250513214438.300430-1-Abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the grammar in the test name by changing "get runtime memory use"
to "get runtime memory usage". Also adjust spacing in output lines
("Total:", "Free:", etc.) to ensure consistent alignment and readability.

Signed-off-by: Abdelrahman Fekry <AbdelrahmanFekry375@gmail.com>
---
 tools/testing/selftests/size/get_size.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/size/get_size.c b/tools/testing/selftests/size/get_size.c
index 2980b1a63366..d5b67c073d8e 100644
--- a/tools/testing/selftests/size/get_size.c
+++ b/tools/testing/selftests/size/get_size.c
@@ -86,7 +86,7 @@ void _start(void)
 	int ccode;
 	struct sysinfo info;
 	unsigned long used;
-	static const char *test_name = " get runtime memory use\n";
+	static const char *test_name = " get runtime memory usage\n";
 
 	print("TAP version 13\n");
 	print("# Testing system size.\n");
@@ -105,8 +105,8 @@ void _start(void)
 	used = info.totalram - info.freeram - info.bufferram;
 	print("# System runtime memory report (units in Kilobytes):\n");
 	print(" ---\n");
-	print_k_value(" Total:  ", info.totalram, info.mem_unit);
-	print_k_value(" Free:   ", info.freeram, info.mem_unit);
+	print_k_value(" Total : ", info.totalram, info.mem_unit);
+	print_k_value(" Free  : ", info.freeram, info.mem_unit);
 	print_k_value(" Buffer: ", info.bufferram, info.mem_unit);
 	print_k_value(" In use: ", used, info.mem_unit);
 	print(" ...\n");
-- 
2.25.1


