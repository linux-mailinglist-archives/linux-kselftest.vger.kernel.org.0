Return-Path: <linux-kselftest+bounces-27263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9138EA40840
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 13:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29814424967
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 12:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19E020ADFA;
	Sat, 22 Feb 2025 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COYBlGkI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392220ADC0;
	Sat, 22 Feb 2025 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740226375; cv=none; b=hiQXZTiQ2qEKWsBuXjX3ZAYZGLs+YJObIMDBFH4iuSr8gnpPfS5vOzrgrw3gwhAza6WUwFAQ5AQQz7a1kYNsqsxhiNFcEQn+jy/nGQJwxCNvoasGHmS+/EoIs442P6mLy6LDhgUyE0M8/ZCF9XpfqOUy4UGLx87SK+ZnnGjBZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740226375; c=relaxed/simple;
	bh=1uN/d/y3gqDT7fTikLmdFAyvO+IXNPMmqKhMVXHCH04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zem+2D5YOS7whEoesgh8x+BkKxmlD7+/y/Ao9D1g/DNSzSCNDU9Hii9k1iy446vsew6tukIVJ/vulv0DPpQzMvr372kx/pSwru8JqLMPVKDz5nff0Igyu5pBnUe7AotiK9yUqqSTzpYj60mKCi3g6yc8/dNZwuBAdk3vmpEAtFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COYBlGkI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220d39a5627so46029765ad.1;
        Sat, 22 Feb 2025 04:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740226373; x=1740831173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6704fXeFmc3Lz8DxDkdN/EEHAv7wENXK6c5pFFXfho=;
        b=COYBlGkIZg/XplL017evcxqinxdauLHGQ3OluHIFTT9U2/phbhql3akQvIwwy/Y3zu
         cNygfoaO4UuwzlenC46q0HBFIJRr5aazo5xKJqCvkNF8L3Lezlob3+qNYZy5uPrahfEH
         KQO+2eEg3Rxc6MQeV7jOzuOSQS4oMZFw41NhebyeMFe2kEp0RQ+lRARDsxaCGVXuZlQp
         PZV3TDF20Xy24Ugff5DXH45DrRsmknWAruVFXh6bJQuQeIl+W57XLu7qJOuVq+sJ98m2
         lu47dvZU+fMRN4ukZmFXW2Nx5sltgm2Y01DH149iKua19e6E+/Ck8CRr7QFbJFvUNHDj
         3Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740226373; x=1740831173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6704fXeFmc3Lz8DxDkdN/EEHAv7wENXK6c5pFFXfho=;
        b=a6Y207FG2BUHtLusXhBJh0eEiesa1+FDyfJlwbAECE1Jaaz00uepCHF94m3TnRTihF
         jX9hZ/z6X61/k+Pc6+uzD6GlD3uLYNWSlKtWyJGuk1NoVkeb+gkYnmtp2rrPkaPwDEhL
         NFb3ZiC43NxGa/wGEoSzkOVYQZoPlTdxUOWlnm3ECDfgGjSO1KgDRfDjPjl4SPhLq/gg
         cycyKgkQ/XizphbhumnQsTJBX4kidjNP+wW3bvNieb9xDYGUblxipN18OmadjYSc3PzD
         4LFtCuYceLjpPIvYmc2Tm/rIlbKqIQ/PsKe/ZXpoLtzukxWWW1X3zjRMviqueBnEPGGb
         HHeg==
X-Forwarded-Encrypted: i=1; AJvYcCXcPtgV5h+FZbNMVZ7/LtQRLi+ZauqyBBH8QqvAj7i1GTR+OwEorYJCKAY8/v5buMppQF4PppIx79GSk3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoD8Yte2HJaRfIczNZidZrJigwQo7vn9yFmLSDi5YiIPihmE8G
	Lg3aKI41xIjf765GcuFbVoT8cOsjRycbzvXh7duBkx2YKU+ujFMQ5TIFDAqz
X-Gm-Gg: ASbGncsX1mPAPkhoDCpfbjcaqqc4EtZT9V4TNVYcf4BhUFLkSbQzoAPyuLN0/3XiDae
	l/2Rys5AaLAjNxSRjnuXY7pKmZXYYZxuy8HXIsG0bZ77YNgJ3XTBQGe5dqvAAUM32Yd0KHkphal
	BOw+UjjRR+OaW5OkfUtEejXD87ZCu9TekbztsO76865b5bFq98K5gHsFvGJ+0mJFOyH+tbYUaG0
	YYw5niioc2JBw9HFeqxhLH5Pf+hFcddH7HcmhUtzMtJuO9IUvSJjyURVv+6JdVvLH+ik4jMepec
	jS2TQbTHJLMMXk3ulE7aknCID5hUbtsGQV9dQI2TkCA0CLXUvb0=
X-Google-Smtp-Source: AGHT+IFEbKzqQq0X0O1eqrz0p9aWIIuBnWCFh0bISK4XGm04eaS/Wt1olern6kLx3K6KhkLGNp6/mQ==
X-Received: by 2002:a17:902:f546:b0:215:8847:435c with SMTP id d9443c01a7336-2219ff9d73cmr113606235ad.12.1740226373521;
        Sat, 22 Feb 2025 04:12:53 -0800 (PST)
Received: from ritvikos.localdomain ([2405:201:5501:4115:11c1:1995:3e9a:6ac2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5364676sm151875145ad.82.2025.02.22.04.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 04:12:52 -0800 (PST)
Received: by ritvikos.localdomain (Postfix, from userid 1000)
	id 92EEDED9143; Sat, 22 Feb 2025 17:42:49 +0530 (IST)
From: ritvikfoss@gmail.com
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] selftests/mount: Close 'fd' when write fails
Date: Sat, 22 Feb 2025 17:42:49 +0530
Message-ID: <20250222121249.50588-1-ritvikfoss@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222114709.50011-1-ritvikfoss@gmail.com>
References: <20250222114709.50011-1-ritvikfoss@gmail.com>
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
Changes in v2:
    - Fixed formatting

 .../selftests/mount/unprivileged-remount-test.c    | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
index d2917054fe3a..41d7547c781d 100644
--- a/tools/testing/selftests/mount/unprivileged-remount-test.c
+++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
@@ -54,6 +54,14 @@ static void die(char *fmt, ...)
 	exit(EXIT_FAILURE);
 }
 
+static void close_or_die(char *filename, int fd)
+{
+	if (close(fd) != 0) {
+		die("close of %s failed: %s\n",
+		filename, strerror(errno));
+	}
+}
+
 static void vmaybe_write_file(bool enoent_ok, char *filename, char *fmt, va_list ap)
 {
 	char buf[4096];
@@ -79,6 +87,7 @@ static void vmaybe_write_file(bool enoent_ok, char *filename, char *fmt, va_list
 	}
 	written = write(fd, buf, buf_len);
 	if (written != buf_len) {
+		close_or_die(filename, fd);
 		if (written >= 0) {
 			die("short write to %s\n", filename);
 		} else {
@@ -86,10 +95,7 @@ static void vmaybe_write_file(bool enoent_ok, char *filename, char *fmt, va_list
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


