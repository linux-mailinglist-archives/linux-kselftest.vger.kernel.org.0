Return-Path: <linux-kselftest+bounces-33201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 577D7ABA019
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 17:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 371E57BA84C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B491C3BF7;
	Fri, 16 May 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvFcTsIx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37F7D07D;
	Fri, 16 May 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410015; cv=none; b=ZIkHV0HiYrqYNR35498qImmai5V1Wdfc6kwsNyfe5HXDcPS0Jje47lQNZ6kR2MLs8SSuvKbtiMRd/t9F0+jGSvhGqnZpF6QHskNEb2S+OdB/eW/zq6lMCQXIxorGxPKhfhxGZwcgTzaurIe5MjtMiD05AYg5O9UvUD1Ru14fEV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410015; c=relaxed/simple;
	bh=OkmWPTjquT7Em9YA1xUAAyJ9lTFW7kG9d9lFkrcF1xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4FYiyLp668SRmNTTqdSyJZk6/wCMtLRM5tRuh8Ste9mCrWMJXH8jEl6wdSZooYN2LMX1zGAd5qVGmLZUmBy7tcARB5LI1ueG7EpJU6bgcdsW6fNfM80LCL7ocSJHRZ7z28J+3tjfu9OCpZHoKaUixN7iWf7q2VbdXpKRiB364c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvFcTsIx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22e16234307so24780615ad.0;
        Fri, 16 May 2025 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747410013; x=1748014813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oVa+nx7ZX9lU3h4aLIs2hsaIJXIw40eNIECVbp/jk1M=;
        b=JvFcTsIx9m74abvjn0g2gark2qNR8C/EBOA/GK4LIRBLZBEzXWRTtSJXlOzOfuWGVX
         mC/+b0KcdYpeEgxHXJW+cPaofa6wWDkkb2QS3GQvxiEdGJagv4uWpoLpmZVqx35b3Rkx
         NHxDCwb9lqF6QjnlnbeWKlZbAaHhKsEGpPucdRavoeXS/yUlRAgDRgfXkPOQwZtc1wLx
         tdYV5yxkqfrZAAji5Kv1iro4uWIvvIGPLCAwROiQ/oexjyi9Wp7qkH5lbCFymkuXPlA1
         xLNf22NVBCcpBQxarDiktXMPWQMKvNZLCOvmcm0UnwSlGXDFkk8XWZBjA+rib6liCJEb
         2Qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747410013; x=1748014813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVa+nx7ZX9lU3h4aLIs2hsaIJXIw40eNIECVbp/jk1M=;
        b=bQ2Z+78hgkTF3eY7E5WUdsbPH7znX/XIvVfHaTnRVZkmCUdMxekhM6jwaAUHNcqKLb
         sqpQ75LQlwkEwiUFuSURCjvTT6rqjXyBQqyTtXFzhCpWAllNSkploT8/XtUdJF5YorkZ
         gkIH/lAW+RwVnQXJD91TKk5ZT5IySkPay52Xh3CxfyQBN5chYdJfvXuY8kfHhCY444pJ
         FL2p/n8xUtVZYxRGOUz1suO2JJIWUqWQz2vur462fdzm3ohT1fSXew3IhDRnpeAeQoK1
         v2TRMZey3vuASYNnsPC4YpZupkfIEHxEJtFZ6CeZP3K4hAKzwClHbogTuIKlRMtpY5fx
         +0rA==
X-Forwarded-Encrypted: i=1; AJvYcCUUXiu37b/eeU2MJSm6XdzwHaFsWslIvOiOELW1CpAeIR6zDR1rsKAXLpNR/IpKDXgo5iLbIsHRIcNE7BBbgc6X@vger.kernel.org, AJvYcCVJnRZKtTP0o6Dzy0z+8B2GlGiOjTxEV4MutRsXb76z39nT10tmcBNreQ1lG4DNCMxqHJNEC/rwflcpX+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIXH+3OWKf2sz0jO6mpV5QHgTaaKuaOdXMq1dtNrbevNoUcGS4
	60obWkvc79lMqpWcsrkk9fh/Fl61561AAm6DoDHdpClOl437rvXr83lq
X-Gm-Gg: ASbGncvBXtGOET8Mn9ysUYCwvn6JvFl/n+Rl4ux4/EDNmO563DO4HZ9rF1aRY9VzGBt
	O0YcicNryi9CpSWO/eyBU4FS1jzk/j4eC8XOjlrb2/S8ACNkI9WUOUsE/n3LZidTDVG5upCdPhp
	MOsWBHSywXpM9huETVhbnbYRItVEXHuPG8VCyUOo/HKywdQNMp1Yzf/AdVikG8f2TaaoxUYGFzn
	JW6PIc6D4Lc3GeTM2ZSeopw6jqRPwycrm1awGFEZRtFhYdlpU8W9a/O66FbXNQ2iXYMG+Oday2s
	Kljixz/qhZeAtsng8zGAw+O0DLIcDkzDt9f7ulLSK6CMSSzGhvHIrkM=
X-Google-Smtp-Source: AGHT+IHy1MRjqcETdIo/u3ddZC5u7do+au8+0mzwwoELqO0h9122LYf6ihu0l2hPu6Hx0SNxBvRd7g==
X-Received: by 2002:a17:902:c202:b0:231:c89f:4e94 with SMTP id d9443c01a7336-231c89f4f9amr57706715ad.21.1747410013439;
        Fri, 16 May 2025 08:40:13 -0700 (PDT)
Received: from harshPC.. ([2405:201:400a:31fb:ab0a:c20e:fff6:2111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e980c0sm15779495ad.126.2025.05.16.08.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 08:40:13 -0700 (PDT)
From: Harshal <embedkari167@gmail.com>
To: shuah@kernel.org,
	skhan@linuxfoundation.org
Cc: Harshal <embedkari167@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] selftests: firmware: Add details in error logging
Date: Fri, 16 May 2025 21:09:53 +0530
Message-ID: <20250516153955.111815-1-embedkari167@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specify details in logs of failed cases

Use die() instead of exit() when write to
sys_path fails

Signed-off-by: Harshal <embedkari167@gmail.com>
---
 tools/testing/selftests/firmware/fw_namespace.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 04757dc7e546..deff7f57b694 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -38,10 +38,11 @@ static void trigger_fw(const char *fw_name, const char *sys_path)
 
 	fd = open(sys_path, O_WRONLY);
 	if (fd < 0)
-		die("open failed: %s\n",
+		die("open of sys_path failed: %s\n",
 		    strerror(errno));
 	if (write(fd, fw_name, strlen(fw_name)) != strlen(fw_name))
-		exit(EXIT_FAILURE);
+		die("write to sys_path failed: %s\n",
+		    strerror(errno));
 	close(fd);
 }
 
@@ -52,10 +53,10 @@ static void setup_fw(const char *fw_path)
 
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
@@ -66,7 +67,7 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
 
 	if (block_fw_in_parent_ns)
 		if (mount("test", "/lib/firmware", "tmpfs", MS_RDONLY, NULL) == -1)
-			die("blocking firmware in parent ns failed\n");
+			die("blocking firmware in parent namespace failed\n");
 
 	child = fork();
 	if (child == -1) {
@@ -99,11 +100,11 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
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
 
@@ -129,8 +130,8 @@ int main(int argc, char **argv)
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


