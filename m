Return-Path: <linux-kselftest+bounces-35402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90990AE11F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 05:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D431219E2356
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 03:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5E01E0DE3;
	Fri, 20 Jun 2025 03:52:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B1322E;
	Fri, 20 Jun 2025 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750391555; cv=none; b=c/KS4TqzLcHKNJ7wBxi1IPygupXQY9+Q/edhmK4AvKRcZsakdaEjX4DdTddlS9WgI/qW94aycVxFJS3b0P5ayVoYC8dTYqHjobDGY/H9cgz81qCpMoalzTr231BYIlIjwSjafOFdX5w2DlLAAQr+4uTKcZHsn4cxrhKX/kY9low=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750391555; c=relaxed/simple;
	bh=C5pcRfu/ST9Gldh0BomV8pIqszrfWCFt78LFG8aUIV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sfIquxwLBh0yA0LoqsLN3IY0Jw0mpB9Zun2ZNtwh8KUPih2O8qsQByyIHEcmZRL4IBA0JArA1vuu2J2ET3dP2U9Esm52Ynabx1/Cf1KhunxeRguIaGgOhUa8A/kjlxjJc2TrVzmrzFZZolMcA9MUIbTk79G7xW6OYjAQfnMThSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d20451c016so90817285a.1;
        Thu, 19 Jun 2025 20:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750391553; x=1750996353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCQU+V6gMlWdniVWGhqWR9mP13FlyOJFFSWy/2Jh23o=;
        b=ldF6HiPrmi0VLEe8KsFCmcKyzKd7QReaBJScVdOIV8yOLpCCGP8FtP+7IJbQmu7VY8
         eeg829i7e4d+ysGT4LH8LKTzAaxSILNyhPQSVLLFz5DlVoC52LhotL8ooCsgAgNB7VTc
         0ddc1p5Zoo+y2mmvR9Z+kfyCfl2yZoqzqKaZnHPjnwORMEEoLjASyEWtQ9g2lvSYO323
         2R5zQA1TyKJipl9L9/ljIxe6lKS/pb402wHjnkKvHKQi8CTuymARPFbH6OIXBNPs5U1W
         4TOU/bz+Lt276ksX7ro66PeFVetICtBpOEcmRvQc3/dPoIZObTcPeUnx4zhFntiPTKC8
         pf9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgBNz8AcHxQ06DF4lPv1rKSDU/u/pPBAzx+5+u47NQe/XqEnOH/Md6sduLrTqYq/fvsNmE8PdPVVdoQLA=@vger.kernel.org, AJvYcCXfkcmz418OVh6zi4ItFl6VUqJp+CP6gVn8IbGmCK1iWmE/tRv5rR/+Xvq0ELxUiRAhMngRqWxRC+ChyohAuCon@vger.kernel.org
X-Gm-Message-State: AOJu0YwbgkpZoV9kyaSLEtvjUU2M3HYDLmhc77QcaSLG3k779FbwnOM7
	sAAUu4lYrhlMzZq5xFV1Ke//bh/lwyUaFy2ypLHrlGNWIA1GRhW9+ocn
X-Gm-Gg: ASbGncuWs9Qf8H0vzAXfxbFACLJ8cXEC0mx8zpbc2rcJ1jM5PdJH0ZAPJYzVuRvFR8L
	jIA+EaWbAK2eKZTBpKnabgpJg+dfUmYUt7MUSjtdy7lEYnwpkOiqzUeuoF6cDZh0VZgzaCKYqoW
	hrXSif7naEsL7dUWsbNBXMJOYoG5HCUPDkDRUeNBM/hcmg3dtx0cP5GQyKVJBEhWp7/HdvYvZKg
	VMKzYV30BC8EdhKANFugAo6IOxgy4T+6b1Zx/Wrmg1iqi3Bhk5C8LkyEQxXdvarqjPIxsRRdT9r
	oPU3/aqaONwCr89k7w8rlKXUz//W44HrfDU7oFY8NgMsp5CGmvFBbhdv4wRuAdFzlfW5B9PK1B/
	oA930cUhh95SuTCdBpSbqrg==
X-Google-Smtp-Source: AGHT+IEcwI2hpTQWwwrqRmJsRHqV5X+NhjnxJ43A/nMvH6M6u4hE8wmvqWIX9pdcyRhKFD/jUr7kKA==
X-Received: by 2002:a05:620a:2912:b0:7ce:f58e:7e9c with SMTP id af79cd13be357-7d3f98c1dadmr239724785a.7.1750391552779;
        Thu, 19 Jun 2025 20:52:32 -0700 (PDT)
Received: from localhost.localdomain (ip171.ip-51-81-44.us. [51.81.44.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99a57b4sm49044285a.27.2025.06.19.20.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 20:52:32 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Jan Kara <jack@suse.cz>
Cc: zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/filesystems/mount-notify: fix unused unused result warning
Date: Fri, 20 Jun 2025 11:50:48 +0800
Message-ID: <20250620035125.2938774-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When running `make kselftest`, the following compilation warning was encountered:

mount-notify_test.c: In function ‘fanotify_rmdir’:
mount-notify_test.c:490:17: warning: ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
  490 |                 chdir("/");
      |                 ^~~~~~~~~~

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
Changes in v2:
- Apply changes suggested by Shuah Khan
- Link to v1: https://lore.kernel.org/all/20250610020758.2798787-2-chenlinxuan@uniontech.com/
---
 .../filesystems/mount-notify/mount-notify_test.c  | 15 ++++++++++-----
 .../mount-notify/mount-notify_test_ns.c           | 15 ++++++++++-----
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 5a3b0ace1a88c..f8e0c6b06e2d9 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -458,12 +458,17 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
-		unshare(CLONE_NEWNS);
-		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
-		umount2("/a", MNT_DETACH);
+		if (chdir("/"))
+			exit(-1);
+		if (unshare(CLONE_NEWNS))
+			exit(-1);
+		if (mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL))
+			exit(-1);
+		if (umount2("/a", MNT_DETACH))
+			exit(-1);
 		// This triggers a detach in the other namespace
-		rmdir("/a");
+		if (rmdir("/a"))
+			exit(-1);
 		exit(0);
 	}
 	wait(NULL);
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index d91946e69591a..d6a6a7ee87028 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -486,12 +486,17 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
-		unshare(CLONE_NEWNS);
-		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
-		umount2("/a", MNT_DETACH);
+		if (chdir("/"))
+			exit(-1);
+		if (unshare(CLONE_NEWNS))
+			exit(-1);
+		if (mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL))
+			exit(-1);
+		if (umount2("/a", MNT_DETACH))
+			exit(-1);
 		// This triggers a detach in the other namespace
-		rmdir("/a");
+		if (rmdir("/a"))
+			exit(-1);
 		exit(0);
 	}
 	wait(NULL);
-- 
2.43.0


