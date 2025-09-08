Return-Path: <linux-kselftest+bounces-40982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C730EB49746
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DD6340499
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE083148D6;
	Mon,  8 Sep 2025 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNLmBGRR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B7630EF8F;
	Mon,  8 Sep 2025 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352960; cv=none; b=KcT2LAs5wgJEXv0j8O7CY43Ai2ak1gMnAMD0KDTJka+kAzLSrA85lc0ZSztt6DJTwFkh61YNFqZDGNIOAGtWhwzhjjeSCNNH/Ntdy4UYn5wtqD5FP8FSfGV0Co7V9zpv7wFzxDm0V2zlirMsdA/FcW2fhWfsGvUgA+3nI6lNAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352960; c=relaxed/simple;
	bh=3MI0Q9/nyUstOeHj740Wjg/XrHQzY+Zb03YFQJbvkJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iW/gJr8WFfyv3arf1unH3sVWAZn8kuySOLugEpdEHGhoGwQcKMkY1kLUJP4ik+FqrPbMhVeLp1WMdwsSceVJsIRKRuwMEQ3teXM5lqiYUTMJZ2B2FlqyBaEiun72UXVorOInj8ijaOeFtMIaSdaN2jGKTJxNxqRUaWSfjtOTi90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNLmBGRR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e537dc30f7so1375283f8f.2;
        Mon, 08 Sep 2025 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757352957; x=1757957757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G9MT7i5vkqpCAcgkA0fxu+rNAoTa3Goz5sl7XdMySXI=;
        b=LNLmBGRRt4J7Y/YughcAsBVFwL20ThT4Qczylh7KxJqGbbbZwzB8JRj8KG1TpugIId
         XVrqWBC8Y2pLfW434d07/9REqDwegjWhBHUhlHTlyfkczX5o/hYSfqj8BrH42i33Vuk+
         6pcjc9zxKPiMXcBCh/HdYikwCCVwKGEdv3UJDVxKdah6qzhykpNcjFgkddTwe1Ec6XjX
         z4ZskIuX8hG/OJoO467qHo8DgktJyE8qUMVhkm+RHEdERUtv0CO7ZYgPHpWfz8E8FoA5
         gEJqf772COEqei6/0+VYzEnkrslQQR9+AYQoS6uoLjiFIjmIshhc3TqVAMHpFcfiq4hj
         SP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757352957; x=1757957757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9MT7i5vkqpCAcgkA0fxu+rNAoTa3Goz5sl7XdMySXI=;
        b=CTastkrNCxn3O06T7aNpwnU05gvY47cpNFWgTG+cwznRodmWEU6g8REiLjcDwCb3hf
         RfS1Xf+NZqzGce7SQbEVv1/WqX89LHqNktrHe6oozVku5kmFZKmtHrllq/+lPoXYRUuG
         tCdjc/EordEMzqDwCN99NgL39cPT1PuDJnAwIqka/EnO2TQSa4AIsGg2dV5N3+YTBwxQ
         fIMY7A3+mNvpeekwOP3j+/jjHD5guIYtvTl/wSOLUGWRz2QMMaRuIK0LZtYXZxHBXs/2
         bSLOyGZ+XJIm8OMx8g2xOiYwnPi/MUJKNAw1C31/OExRoiy0g4fIQ+5rmluNXCN4YncX
         wpgw==
X-Forwarded-Encrypted: i=1; AJvYcCX1a/24T2YKwcvxfzvk/87DVXEMhxnv/2RLm/zLq/0xa3x5hWV/ZlfLZRFu3mWt+BymmcDHfxqdCJrGoTk=@vger.kernel.org, AJvYcCXWxbC9sgeVeHK/vqU4Zja1fnrQx286Wy7iBDvmbyP+llbUb7hm87dUYt8OwD17W4saAcgrywxY63lNzqpHOT9w@vger.kernel.org
X-Gm-Message-State: AOJu0YwMiykw8bAXOOu70il5cV4hKL0kamucz8CHYYXHSsjuIABTMrvG
	Q0oZYP6WvJA0m6YjT1qT2vOz/JcCWWbcPt0JCVSJQnyVl/io/DiNKX5Z
X-Gm-Gg: ASbGncszOwsejo9QjCDWlwQCatzLUZLU8THZ+pthbRjKBHH3u+ycrM9oa4uaBDHGJnb
	wE0d1Xl7rmGRBjnV+siw/Ql+0nsmat0dVWZRC90SEg8VxbCkHZIxQrSgbYlWQMrnsbBzmkCkc6T
	YgBhk05tFbfy9S9G0LhNcG8zOw/cvmTJt79tcm3i0nvPl2ZCFkdWZMvq5lmUzUnIHbEn6E4K74V
	KUoarhwdNaw/eE4fZcaSTFgtdSlvnHgZlBSFVq70RJfpg/gdU31vbCzX34fN5GHX7zmSjTMaepU
	S3slpqiaAZENidkLX4CWxSbKFeLdGCZ3ogAo4LycPNRk9V0z45kS3CiETp0YLE7i/M2JX8T0KZG
	rrA5iuICs4viIbEvfq5wDanhXjPlWm+SQeTF/1FGOE/CTcAOwc58PCAhXBX0LmbuuU86yKYPG/f
	PYfITrWd2nLUERMeEf
X-Google-Smtp-Source: AGHT+IFDSDXJKQrEZArrPIuM96vHeuqDlO5JsHzQT3eqCK7wNQTfwb+2kKo160Td3cu1AugzVzllEA==
X-Received: by 2002:a05:6000:26d2:b0:3df:b9e7:35ba with SMTP id ffacd0b85a97d-3e6440f0674mr6594835f8f.57.1757352956830;
        Mon, 08 Sep 2025 10:35:56 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dec3e2fd6sm8925865e9.19.2025.09.08.10.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:35:56 -0700 (PDT)
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
Date: Mon,  8 Sep 2025 19:35:49 +0200
Message-ID: <20250908173554.126182-1-alessandro.zanni87@gmail.com>
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
Reviewed-by: Jan Kara <jack@suse.cz>
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


