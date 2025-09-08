Return-Path: <linux-kselftest+bounces-40979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114F1B49731
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08F43A45F9
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8A9319848;
	Mon,  8 Sep 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQRtpNnD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C67319845;
	Mon,  8 Sep 2025 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352885; cv=none; b=NNu6TejcBg3EMA8N9eVaHaPIunOiW5/m0Vl0OzEJ7q2K/NZeWO9pZ7cF07tDT6qaAqCPkazxpZkoWQBXlfz6fPRQvhMOnw99HQHjBek1tcsyBUhHIn+nLH5qsCNBbChGlLVupJa2nVlLeZtLtNbxqeddboMOg0T+GX2P5StZnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352885; c=relaxed/simple;
	bh=JmOsx5cBItV32FNWImzlQTBoy6p+tMlQ3/JbFRpfLZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uNdiOW/3PZTdp+pQw2wGclWo32q+1h5nVQ+DlxTIm9Aftec+vNySKy8nBgdAY4Cge3HEtzC7pxmU6N5+GSiGPwjrpNqgVyEqWZHYJLn65wYRlxHfgVCY5ZnTEK8djfiJgF5DmLybINB/yrWyAQLrygVp/LWLtYf1NzAiFcqGkRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQRtpNnD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dec6a6554so1272245e9.3;
        Mon, 08 Sep 2025 10:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757352882; x=1757957682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ji7e37qngWvjbl+0kQwPCSQJoUjgF+G1Qx/ETbmkYcI=;
        b=bQRtpNnDNQBrdp0OkVL6jDMrbIeMdbuthvJLIgXDNfN7oPCLDqx9BOrwfCK/qQ0b6h
         JY5h6KHCEUpKmTQn1kuiJX3HVbrkqpWDI8vhW04Vpd+DJZhDvyabplLRUPdzh4y5yt4g
         xf9thiw32t7K6ml7tsxJ0klmkLuEMvUxSwImDvhCBZSJhBY3+yBfvITCVHxl2SenEqni
         4yPpfPw/i+r1jN5/0mw1eHDsO/kro2ql4ev/HrdlU1f8GfOF0OzoXTfQe2t8/hXRC+8k
         yC4soDBbLXYfYyZxTFUKaQ2uUYnQHrR89QRN7nEHQHJixtUw+SVZSiQRA4IB6uMzmfew
         3xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757352882; x=1757957682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ji7e37qngWvjbl+0kQwPCSQJoUjgF+G1Qx/ETbmkYcI=;
        b=FDMyn4lQktdylJ1vnVzSFlPEpYS7cUXAdODG5IGQZvI5CCqr+6KCTqMz3AtKL7aUTd
         8QzvXtch0UvzKE8adqWU6XI6+sNA0xwnzq8hTF++m+G1OsQRuNIKRmvhgmJZoj68j29P
         wxsMLBfmYtC/XMRVpq6xs44CUUXTzKoBVXSXbHU+r5//oWe/dpnbTWMlZz4abEjbDkdg
         sRu9KbMkqoSIzHEP0SOEowSjSV8Lc8ZlK/sGYkvq5cL7xdND00rJTiQws5t9kN9/aqto
         JAhGyooe8ifQV+hAWJlHCFq7c4RLriRGIQWMG9afqKbw2wdAKPFc4OsjF6Bao1fSOX24
         NifA==
X-Forwarded-Encrypted: i=1; AJvYcCV9YoFvtaxqO468cyRXOHB5ZLPX5Ixpo2DXbiB20+a5spRVviYGKNbxwiminjr5UhzfgFhYjOzXEa3GCbM=@vger.kernel.org, AJvYcCVLjGRgvQttiuYy2NAGhlh1HoBLk2wJHBhY4fziT9QDSwSayaT4V4/vRSj6rzt1FrE8Cp06Deikd7/4qEIYBey5@vger.kernel.org
X-Gm-Message-State: AOJu0YyksZTEigSiH11QmehH+Gr/NZ7TN6xX2hs3McvxpfrV03m1jMDj
	5RX6m3vAFxJTRtvRV3l+xx0+9BL//ONQs3K2ZFVLSXt57+iVQE81ZaF/
X-Gm-Gg: ASbGncvxRxjLal67XbxODekbowBAFJeab6o5kPHjhtxA5HVS8tDvg0jkU5NS5JBjiYT
	1H5ncqQ0ATSvyQ/XLv4ZwmShuOF45idkT3Xilk59ejhmvc2Y6pcXg1PRW8NPKc1W9o43TIChoqD
	cABl1m33wfFJvPFsi4JDF0JHMINWZpZj43OowcZFQzmbgwVZngjrwIM1eX/99UuHDp2YLBXieTv
	uTQPW+ApBHuuFVJSsj0wVdfMzcSFyS3mtiYY669HYA9XifUlg5hA2IiFI+WuHFaSGwa9IaydLVF
	0CiBtqhMvp+BL4YkNhsufcKZfbxa9WCOafeZ7n7lM3hHodPHXF/zuXSnHaBWhcucGH2udEW4PW9
	e1/EuE9VJRVBXfebRq5Kej3TkYgmt7I1cfT2Atr1U2MzQaleuN3nxrSITNZUuMI+ibBayZkKhNW
	79dWek7w==
X-Google-Smtp-Source: AGHT+IEUSXORtVaUF/ufUM4qnO5DSLC8wh1auQIxRV2sQBrJfwQUJ1ChNVW52w9gfrRktlUocfHNww==
X-Received: by 2002:a05:600c:3b1e:b0:45b:7699:f96c with SMTP id 5b1f17b1804b1-45dddec7d63mr59283075e9.21.1757352882168;
        Mon, 08 Sep 2025 10:34:42 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de2132cd3sm86596415e9.9.2025.09.08.10.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:34:41 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: shuah@kernel.org,
	brauner@kernel.org,
	amir73il@gmail.com,
	jhubbard@nvidia.com,
	jack@suse.cz,
	mszeredi@redhat.com
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/filesystems: Use return value of the function 'chdir()'
Date: Mon,  8 Sep 2025 19:34:18 +0200
Message-ID: <20250908173422.126073-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix to use the return value of the function 'chdir("/")' and check if the
return is either 0 (ok) or 1 (not ok, so the test stops).

The patch fies the solves the following errors:
mount-notify_test.c:468:17: warning: ignoring return value of ‘chdir’
declared with attribute ‘warn_unused_result’ [-Wunused-result]
  468 |                 chdir("/");

mount-notify_test_ns.c:489:17: warning: ignoring return value of
‘chdir’ declared with attribute ‘warn_unused_result’ [-Wunused-
result]
  489 |                 chdir("/");

To reproduce the issue, use the command:
make kselftest TARGET=filesystems/statmount

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 .../selftests/filesystems/mount-notify/mount-notify_test.c      | 2 +-
 .../selftests/filesystems/mount-notify/mount-notify_test_ns.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 5a3b0ace1a88..a7f899599d52 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -458,7 +458,7 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
+		ASSERT_EQ(0, chdir("/"));
 		unshare(CLONE_NEWNS);
 		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
 		umount2("/a", MNT_DETACH);
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index d91946e69591..dc9eb3087a1a 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -486,7 +486,7 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
+		ASSERT_EQ(0, chdir("/"));
 		unshare(CLONE_NEWNS);
 		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
 		umount2("/a", MNT_DETACH);
-- 
2.43.0


