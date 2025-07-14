Return-Path: <linux-kselftest+bounces-37290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8730FB0497D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F1B166117
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 21:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0F423D2AC;
	Mon, 14 Jul 2025 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO3t7FhB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901A4367;
	Mon, 14 Jul 2025 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752528464; cv=none; b=f1WcOaP5gzZ/77aTd0FfIWEaf6CuQByD5fv8tLFGCK7SWintFbF2haL0EhQ4HfKaXCbGeBY8xSOfFt5JIBREmr6Rs19DE91jrgeTCsBgZ+RqQiBVGvqK5OvzTXNbeMyXiJKbQR9+VClQB+2DZz2/LQ/sXkyPEashrGMisuY3hEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752528464; c=relaxed/simple;
	bh=FOK5j+uVyR7TtI7zT5b5fSGjmufipL1q/dGm5umXsLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NzlRstiILUb17DKoI8GTzlkvUJKUEERTnZBeTkvI/1Kl5Wc1+ZPnmVUN7akXO6pD+aX35Umh5u/Ap6LRXQu40Tn9RSy/0VNPG/M+1Jh4p7jlNnw/OiwCLVzWa3/7xICJ2B/zEcUjz/wLTe67CnRjPQ5P3SdboV8SwID7UidSJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nO3t7FhB; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3df2ccbb895so37335495ab.3;
        Mon, 14 Jul 2025 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752528461; x=1753133261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSkgDKwz32MYWgc6FO09kXUoCRTbEUbbOhsd/ocI2S8=;
        b=nO3t7FhBATNM88DjMWxSDis9gVKBgQaXtwLm7N9Zmb2rOYHzPPS7xprUqqd1HxLyhl
         6twsX66EIHLsXHXnz+K/NiTTurzoJry4iksCs3GUqSl5SGaAWKWd+kRo72RHxGgS4CaC
         04gpI+1szK0gliDOTknDAwbFLTCXe7SAG7+g0HQZPxZkAaaucipqAW7scmqC5Q9J6Zrf
         9orHW1gyOyLola2pGzNbCUAv2ZiLWp3VT/jCpyxAZLdFE6+srjbV4yD0IINXe5epH0aQ
         bZcBB+yOJtM624NrqXnzm4ps23OtwBRRKGYnwbtHSS/Rf/d4Mkrq6HJAtHWV75MESEvc
         1CPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752528461; x=1753133261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSkgDKwz32MYWgc6FO09kXUoCRTbEUbbOhsd/ocI2S8=;
        b=PttuAxwWeO1O2VLkjM1p5OwGYVD39nVOyJOSXntfOBY6NsZgirXC/F4GhqjRWMbBRa
         +zZuGOm9g+3EiBrUN9SGMmKQD4ZxXzc0Nj3u8oAo2A1py70FQ6U+F+r50gfCj7R8OIdV
         2q0of/wsnyvh8cKUUgN9abNLTpScRE0wWTEfVZ1GaE3LNu728jNwQhotHE+kokUuPoMO
         WUJwUlXpjk9uzB849nWpWPC2AE1aTK97K0hMfvvu6JGvAwYMgizAoIDlziGxeVDYvFML
         i2gQ8rAKj+lThvXec7QaPFcJGmVi97pRM3ldvDTGPCypX9nXQ9a33iW6X/p+FBDHRASW
         2jbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpkCtWKJTNA/HXADFHgSrpiIzDYHEt2S4/2mdpv04lqd9kWCe3gr07pMSueQVrFW7oeLZkjFeKEwiaqOLZLW3u@vger.kernel.org, AJvYcCXXWaUAf3xb0q9wL7S9LNptfi+FZ+0Tyu4NkbytV6biss0lDDFB2Kegp+uAoa/wBnDiIDMOdsz5tp1mF+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC12Z1YPvFoWM6Yv87+FoTLP+CaG1JsXLMBEUG69U/0ivDPS8q
	r0YsF5ryoBrHyxviTs9wvH3RyTahfClOCjXMuwTrz9p7yB7cxfl9GwdcJG05bSgg
X-Gm-Gg: ASbGnctpu1BRansqGctrcCT3D7id1O/Lv1m5XoBgbyuJB16w6lTQURPbtrOCTD6qi2R
	e63Puy7LS1w76S16r2YfENJsC6ihJhdu6T2AodTbTt+ciTB0fzBHivP0nOre05YfSAFFcQa28zS
	Ime41l8n1AqKp531G50lVhAoe2u4FG2Y1CA7CBhncTxt7zS3VjxH2gvWj5yxUZbhUV/AOASu1Z9
	+t9moWNx+QqYjJW0e23dAFV8QXO+bAujByipnOYBksAVUjOUZTZ2FCbR0PA32mbe6MrI3V5x/kh
	HGHvtZxT573dBUg4cEmg0K/KjLIbTT5cpJFFpE4DLNac6Tg+BEdxuyZ1fNLaa9VbX5lhG+4rTkn
	qWZoSG0P/dJyXxGLMqykrqCSDDQ==
X-Google-Smtp-Source: AGHT+IGZdMde86VTK2ZhONUmyViQMhJGdPIri7yEZRE5XiUTpPN4mKMT3MXNWVD5omueRhJmF8mQug==
X-Received: by 2002:a05:6e02:b4a:b0:3dd:b523:7abe with SMTP id e9e14a558f8ab-3e2543d4824mr161964955ab.18.1752528461508;
        Mon, 14 Jul 2025 14:27:41 -0700 (PDT)
Received: from harshPC.. ([2601:280:4780:fce0:8f94:b3e2:28a9:de6c])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5055697324esm2267454173.85.2025.07.14.14.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 14:27:40 -0700 (PDT)
From: Harshal <embedkari167@gmail.com>
To: shuah@kernel.org,
	skhan@linuxfoundation.org
Cc: Harshal <embedkari167@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: firmware: Add details in error logging
Date: Tue, 15 Jul 2025 02:56:33 +0530
Message-ID: <20250714212650.17935-1-embedkari167@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specify details in logs of failed cases

Signed-off-by: Harshal <embedkari167@gmail.com>
---
v2:
- revert back to exit() instead of die() to avoid modifying system behaviour

v1: https://lore.kernel.org/all/c7c071ed-6a4e-4a9c-ba9d-c745fd42c22f@linuxfoundation.org/
 tools/testing/selftests/firmware/fw_namespace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 04757dc7e546..5b0032498ede 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -38,7 +38,7 @@ static void trigger_fw(const char *fw_name, const char *sys_path)
 
 	fd = open(sys_path, O_WRONLY);
 	if (fd < 0)
-		die("open failed: %s\n",
+		die("open of sys_path failed: %s\n",
 		    strerror(errno));
 	if (write(fd, fw_name, strlen(fw_name)) != strlen(fw_name))
 		exit(EXIT_FAILURE);
@@ -52,10 +52,10 @@ static void setup_fw(const char *fw_path)
 
 	fd = open(fw_path, O_WRONLY | O_CREAT, 0600);
 	if (fd < 0)
-		die("open failed: %s\n",
+		die("open of firmware file failed: %s\n",
 		    strerror(errno));
 	if (write(fd, fw, sizeof(fw) -1) != sizeof(fw) -1)
-		die("write failed: %s\n",
+		die("write to firmware file failed: %s\n",
 		    strerror(errno));
 	close(fd);
 }
@@ -66,7 +66,7 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
 
 	if (block_fw_in_parent_ns)
 		if (mount("test", "/lib/firmware", "tmpfs", MS_RDONLY, NULL) == -1)
-			die("blocking firmware in parent ns failed\n");
+			die("blocking firmware in parent namespace failed\n");
 
 	child = fork();
 	if (child == -1) {
@@ -99,11 +99,11 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
 			strerror(errno));
 	}
 	if (mount(NULL, "/", NULL, MS_SLAVE|MS_REC, NULL) == -1)
-		die("remount root in child ns failed\n");
+		die("remount root in child namespace failed\n");
 
 	if (!block_fw_in_parent_ns) {
 		if (mount("test", "/lib/firmware", "tmpfs", MS_RDONLY, NULL) == -1)
-			die("blocking firmware in child ns failed\n");
+			die("blocking firmware in child namespace failed\n");
 	} else
 		umount("/lib/firmware");
 
@@ -129,8 +129,8 @@ int main(int argc, char **argv)
 		die("error: failed to build full fw_path\n");
 
 	setup_fw(fw_path);
-
 	setvbuf(stdout, NULL, _IONBF, 0);
+
 	/* Positive case: firmware in PID1 mount namespace */
 	printf("Testing with firmware in parent namespace (assumed to be same file system as PID1)\n");
 	if (!test_fw_in_ns(fw_name, sys_path, false))
-- 
2.43.0


