Return-Path: <linux-kselftest+bounces-32895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81CBAB4D08
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 09:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32024865F4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 07:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571B01F1510;
	Tue, 13 May 2025 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWs8wiYb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7371F153A;
	Tue, 13 May 2025 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122280; cv=none; b=mWJNqxk4ds04Qe4Lyt16M5fRFlFpEyf8MjfAEnKyVSBptD6u3vNuZfzKVwNorRtj+MN50XLaY7j3C0aXnkGlHp/l3d6wtNIAhAc3eFRI8OEQObqv2KmfkCFYT2gjtapkMjpsHrzhP+ZePZrtIApuxN86b+isr1AHgk+F5NDBcG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122280; c=relaxed/simple;
	bh=nIZuPeqTegif47oCQTUNH8k+hdHDeA7n/xNjQQbZFxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AxOTnHD7ibVN7mJqwYY0ob/FSGwGmHYzGTmCfs2pe0QSWqmThjJg8jZ+7zXX2LFtFCj7MkwGu+PoAOK04CQl7TKuwCzz6h2IDkzlhMX6+Gb8qzwzRr7XOdpJCVDRx6E3Stvme8n4B1taglbnQmjy/w3HiiSab0iyi10pxNp+PC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWs8wiYb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e4d235811so76617355ad.2;
        Tue, 13 May 2025 00:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747122278; x=1747727078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHubMDjEe69tABqy0YiKs+m3VAs8YycqY7kD4Q/ukJU=;
        b=mWs8wiYbSrx2hBd3eCETc4Wdje1eKVOeZgws5GkoqEqQQ0Erx9k1+yzJ/M4HJz6O3G
         E0IwdMcI+5A0Z4lC69wIvHwVWNGT/jvLwxLEIEtkrvfmYbsS5WUOl+pzcXAGC6SUr1w9
         205pYUGhx+ZHLqkCZnWetuH+zWk1cU4xyQmqgtRX7cGLIl1EWRbS37lXaFlgGc3jbiUT
         Vcf3/ZZYXUm20sKwa2aCtKGPJW+FhtpGa/W8Mb5VHjKAMsydafOWk/mYe5+9Y3A104Pb
         1949S+CqozyhWfLh+NbAzNORX4okSrhg7VWecGcce88+sV0PibapDjgtTP0RCqhPZ3+U
         EcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747122278; x=1747727078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHubMDjEe69tABqy0YiKs+m3VAs8YycqY7kD4Q/ukJU=;
        b=R67RPj5BYIgYft7yOD3eSyQ2Errwnt8MpRge9RDLhi48c/Dm/K02v5nSQ1vJDh1/nK
         nDa7WQed1Km+lL1aTGC6j8tox6cp0GEFzGv9UrW+jmCghs9nZUP6379g0GrS9reazbsu
         iq78miGE/LBH6uLWaX0ByARTNFtlniL4WNoxw5xPJl5TZ7a3EKy51B2pbr+D1BpbJymg
         2dGhL49eqkip1skKjwtZbmFqeaFgGl8XwmZRE+uolfViBGaa6f+dQ05JzE/ilJhmtN49
         ipK0ixo0htAyBxheesw7W+Q/dAncpomWCWQ7ewycZ0Uk9W1PnowQNyQbI4JLTULSHR4u
         ZjSw==
X-Forwarded-Encrypted: i=1; AJvYcCUOowFbmt/aX7PNBfvOk2ydJyc9aBBkfQP6Kc1ykKK38n7HrGrPg9ogpUbWPPFVIU6cd3lM0Hjn0gT4dz0=@vger.kernel.org, AJvYcCVNDAD4lVBEz53RLUceQPgkGdZS74mhpEqog1LV0MwYaL6fxE1lSd/rvnQZoyU+ApblOIldMBEwaTD8sD6Q18Um@vger.kernel.org
X-Gm-Message-State: AOJu0YzFz0G98e47tCXHy18d5NNhkjvwm6GsuUDdLYoi4sZFGBn/fvIn
	Up6hJRG2t2d7vCfNshiVrLYy4DCu7YCSZeilm7Za2IIdCZsXqplg
X-Gm-Gg: ASbGnctWtd/5jJ6Ul7F0BDSuMtja9i5pH35c5CAfPbfh3/9G4PspP2Q7HSEBpyTZS5I
	92KN0K1Gm03A2sXIrhcRi+tDv5H7BrJhAcmaLSjHZSWdXSDeVGR8DFUrZ3R0t2sgsH86n/C0O0c
	Hs6UJLK6cnmukD2jF7z75L64K0KXsF8gGAjlALvYf7YsvK63jj7Z5wNqycA8DtmU9NnasrtcAmM
	H9IJc/RkglcjGYiEdIJhAaafH3wrj5Xu5eCG5BpsjmU+lElNJHa26BJGRN/lST45+o0C1KEbJhA
	wY8qO3yRsx+Q/MyvXVjIYq1g27GOPz9co9KfJeVqNCFRIDgzQVvVpIMSv0R70cU7CuoD
X-Google-Smtp-Source: AGHT+IE9XqGs8RIByAH/heXDy1iGIFxLvCCTPwDBLoNFrf5epMfu2dEiZSXp+5Bo5QBTDReSyjCDCQ==
X-Received: by 2002:a17:902:d4cc:b0:220:e655:d77 with SMTP id d9443c01a7336-22fc91a02ccmr247353675ad.36.1747122277972;
        Tue, 13 May 2025 00:44:37 -0700 (PDT)
Received: from seokw-960QHA.lan ([210.100.209.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82c3063sm74813535ad.244.2025.05.13.00.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 00:44:37 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: shuah@kernel.org
Cc: wen.yang@linux.dev,
	akpm@linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryan Chung <seokwoo.chung130@gmail.com>
Subject: [PATCH] selftests/eventfd: correct test name and improve messages
Date: Tue, 13 May 2025 16:44:11 +0900
Message-ID: <20250513074411.6965-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

- Rename test from  to

- Make the RDWR‐flag comment declarative:
  “The kernel automatically adds the O_RDWR flag.”
- Update semaphore‐flag failure message to:
  “eventfd semaphore flag check failed: …”

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 tools/testing/selftests/filesystems/eventfd/eventfd_test.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
index 85acb4e3ef00..72d51ad0ee0e 100644
--- a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
+++ b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
@@ -50,7 +50,7 @@ TEST(eventfd_check_flag_rdwr)
 	ASSERT_GE(fd, 0);
 
 	flags = fcntl(fd, F_GETFL);
-	// since the kernel automatically added O_RDWR.
+	// The kernel automatically adds the O_RDWR flag.
 	EXPECT_EQ(flags, O_RDWR);
 
 	close(fd);
@@ -85,7 +85,7 @@ TEST(eventfd_check_flag_nonblock)
 	close(fd);
 }
 
-TEST(eventfd_chek_flag_cloexec_and_nonblock)
+TEST(eventfd_check_flag_cloexec_and_nonblock)
 {
 	int fd, flags;
 
@@ -178,8 +178,7 @@ TEST(eventfd_check_flag_semaphore)
 	// The semaphore could only be obtained from fdinfo.
 	ret = verify_fdinfo(fd, &err, "eventfd-semaphore: ", 19, "1\n");
 	if (ret != 0)
-		ksft_print_msg("eventfd-semaphore check failed, msg: %s\n",
-				err.msg);
+		ksft_print_msg("eventfd semaphore flag check failed: %s\n", err.msg);
 	EXPECT_EQ(ret, 0);
 
 	close(fd);
-- 
2.43.0


