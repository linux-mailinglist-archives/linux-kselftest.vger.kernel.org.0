Return-Path: <linux-kselftest+bounces-8954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C03F8B4145
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 23:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6DB1C2085F
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 21:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C133613E;
	Fri, 26 Apr 2024 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJQxerLA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4726364A5;
	Fri, 26 Apr 2024 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714167209; cv=none; b=NsD7o6WWuPiZEu/3FWZfzVezidGFlcLzf4rRMlL3W4F/pJAjjl7P8BnuS4gpo72LaMdKzQygoiaqjcVz4AhzsJgT6dz3O40m79o+CQm3Lzb/COAzyp3O+sJd/DgFWIiGYj8g41BhZ3fulGbigKAUFLYkz2KVuBLkYNHB5got00w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714167209; c=relaxed/simple;
	bh=BRXUXLpBGxxQsER/ZsxTVxHRK9HYywVj2onYAAeAWb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YjIvBbVSCGZW1o/WME6MBLBLQ6ZHkInuysN3RSIbaNYfQCcUlzoesQDoS5gvOrX344wHv9lVcf9JVoH58ywcsF3tha0L7u0UpXK2ySkd4Edh2JjlZh/oL4UMXAht8rgfTL345gINiKbyAgLRRV9Oge3lnBXZuYmHe3ieQOiFJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJQxerLA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-518931f8d23so2792162e87.3;
        Fri, 26 Apr 2024 14:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714167206; x=1714772006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iZTGLY6ClByt4vmgeP2Z+fu7nhm7tDi0YebE9nPM0t0=;
        b=GJQxerLAdprBLcxkraA+0huE2PMgPgLfyPost3asv8Ky42rgHlMeZcUJhf+vuvgbPC
         TEaIxiy/+kZhU5foLHa/aRFMaTq524HSU2AK1zYPYKPgPzchIRDOOFkf6GAqkaM8wuQ7
         y2djHoqNp7FrDtyCQKY1R8B5t4a5W6H822qBZH0n+0tLAE7U5NrL4HmI0ckFSA3CDkbe
         wL2+Qftgyt8CBiOyS292T5I7Oky7ovr1L3+ib2nDFxrTs98fh7auAkpUPHY2PksUBXBi
         6vzeowgckwhIAO7yKDyUFtk4A5O6tHsrn4U+DrOpWXmLpPQdEdVms2MCjVT37Ro9e0uP
         8GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714167206; x=1714772006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZTGLY6ClByt4vmgeP2Z+fu7nhm7tDi0YebE9nPM0t0=;
        b=GHDzhxZc4NQRuq2cQ/GqepI9nklP4VLkd1B2hKo8aWAZwIukXLpFOhn4Tulj93Up8R
         +Aj8iIt/g+J2+4tkwf6tpCXqvF9e5I7NGmiNTmHzmDVycfkn/n9g2/AVHXZ5xInuYsjP
         uoZ/zzZae3rncLUI7n/nz7exjGt9yfvpqcW8uEoqm7vOqfxb9NaxQueY3XPv3dPWdmCb
         o5tKxGd/NMmf46icnTH4TnQOk+ozXpPcphpM3307sTrZfjQK7dDp+EfRE1zTqvDDc2ec
         AvAiAKrC43MgJ5q7dXoEN78/rKbdcGiq5vhNYcF3eql70/OJGVtQccYLp/V7p94Zw3Dt
         8M7g==
X-Forwarded-Encrypted: i=1; AJvYcCVf+w2FFTma8yzTsZ2EiXAvpGyOjpuXkMnDH601iISNYiK9yrnExePHpoFMF1xmHaSl8zZNAvGdCmVLWs968EerCGqs5wtUPXcaTs1isH7b
X-Gm-Message-State: AOJu0Yxu9lV7aHHcQ0lpUs/v2joc02JYIy+o3+y3LXypuzIwon8ge86U
	rvSIdi5Q8yswvuoEXEAK8sYyEpKzpAX1okSj5CtX0vCZn/c4Yg==
X-Google-Smtp-Source: AGHT+IF6iCfmDk882D2SyrC7CBjgCyuHpLzco4SQL5zvj/+YB00TJI6GrJFEvw+EkMhvZBO9KKj1Eg==
X-Received: by 2002:a05:6512:3695:b0:51b:d593:8895 with SMTP id d21-20020a056512369500b0051bd5938895mr2239007lfs.13.1714167205756;
        Fri, 26 Apr 2024 14:33:25 -0700 (PDT)
Received: from localhost.localdomain ([85.89.127.166])
        by smtp.gmail.com with ESMTPSA id k7-20020a05651210c700b0051b3ffaf234sm1781564lfg.117.2024.04.26.14.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:33:25 -0700 (PDT)
From: Shengyu Li <shengyu.li.evgeny@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shengyu Li <shengyu.li.evgeny@gmail.com>
Subject: [PATCH] selftest/tmpfs: Use harness framework in tmpfs
Date: Sat, 27 Apr 2024 05:33:03 +0800
Message-Id: <20240426213303.12583-1-shengyu.li.evgeny@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Notice that there are a lot of Patch commits to enhance 
the consistency of output from our legacy tests, 
we plan to refactor them using kselftest_harness.h automatically by tools. 
This will help standardize the TAP output format, 
ensuring clarity and traceability of test results.
This is the version of tmpfs after auto-refactoring.

Signed-off-by: Shengyu Li <shengyu.li.evgeny@gmail.com>
---
 .../selftests/tmpfs/bug-link-o-tmpfile.c      | 54 +++++++++----------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
index b5c3ddb90942..8a9a29bff287 100644
--- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
+++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
@@ -23,45 +23,45 @@
 #include <sys/mount.h>
 #include <unistd.h>
 
-int main(void)
-{
-	int fd;
+#include "../kselftest_harness.h"
 
-	if (unshare(CLONE_NEWNS) == -1) {
+TEST(tmpfs_inodes_and_linking)
+{
+	ASSERT_NE(unshare(CLONE_NEWNS), -1)
+	{
 		if (errno == ENOSYS || errno == EPERM) {
-			fprintf(stderr, "error: unshare, errno %d\n", errno);
-			return 4;
+			SKIP(return, "error: unshare, errno %d\n", errno);
 		}
-		fprintf(stderr, "error: unshare, errno %d\n", errno);
-		return 1;
+		TH_LOG("error: unshare, errno %d\n", errno);
 	}
-	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
-		fprintf(stderr, "error: mount '/', errno %d\n", errno);
-		return 1;
+
+	ASSERT_NE(mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL), -1)
+	{
+		TH_LOG("error: mount '/', errno %d\n", errno);
 	}
 
 	/* Our heroes: 1 root inode, 1 O_TMPFILE inode, 1 permanent inode. */
-	if (mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3") == -1) {
-		fprintf(stderr, "error: mount tmpfs, errno %d\n", errno);
-		return 1;
+	ASSERT_NE(mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3"), -1)
+	{
+		TH_LOG("error: mount tmpfs, errno %d\n", errno);
 	}
 
-	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
-	if (fd == -1) {
-		fprintf(stderr, "error: open 1, errno %d\n", errno);
-		return 1;
+	int fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
+
+	ASSERT_NE(fd, -1)
+	{
+		TH_LOG("error: open 1, errno %d\n", errno);
 	}
-	if (linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH) == -1) {
-		fprintf(stderr, "error: linkat, errno %d\n", errno);
-		return 1;
+
+	ASSERT_NE(linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH), -1)
+	{
+		TH_LOG("error: linkat, errno %d\n", errno);
 	}
 	close(fd);
 
-	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
-	if (fd == -1) {
-		fprintf(stderr, "error: open 2, errno %d\n", errno);
-		return 1;
+	ASSERT_NE(openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600), -1)
+	{
+		TH_LOG("error: open 2, errno %d\n", errno);
 	}
-
-	return 0;
 }
+TEST_HARNESS_MAIN
-- 
2.25.1


