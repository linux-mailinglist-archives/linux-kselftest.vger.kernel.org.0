Return-Path: <linux-kselftest+bounces-33610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C40AC1DD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 09:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFB73AFE9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 07:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B4C264A9F;
	Fri, 23 May 2025 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="PTptsFHZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426420F080
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986179; cv=none; b=Y8R8FwMefcT00ZyHVyH9AmhDqpMqjUSgWMDV6DUnU5ZSWrI4SkBIwdndz+R0hooqcOyRAOkhCfAvVnkZer6J8zMaef2WMCQ1cQthF/mTwX/wWRnhMTdsHtunEQ1R348isv5Lmj7EcN5mEGARHprx2DOlGerVhFqKg8Ry8Jkpkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986179; c=relaxed/simple;
	bh=o8Z9F+s3H5s+WHRu8VrEBEw3xQJt57LQ6mx6MD0qMFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=obNpQYORdQY9XG1RlXEPr0YCtVibQevCwRxWZD3BIVQT7G+4mTGsgb0gIJQBGRM+e766+3gGf3DTcHX170IEcDFVFtYf0FUekrfFl6oAqjx5rReVDqfFJ6mLH0S9H3GaEDld4RMDmn390EO3FTF3d+wFP0oBTQOVYu8gqqCjVB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=PTptsFHZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-442d146a1aaso87749495e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 00:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1747986173; x=1748590973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sf5oVq0p4V1KNu2SAoViuAhUyDDrJF+OTYRvlB2marA=;
        b=PTptsFHZm8IP5q2doJKqNchdsqFNMVl5fv90piuiMgkSYyHvPjPS2/KHSrk8UWwRQf
         7VBWlsoFp+i1XMCFiNtRd7Hm05CPNYhgom23q0/yYraUPHwZdc9ZZ2B3R/wvcR4tKfnL
         YwyQ/mfq6Hr2euJhGOblWiDP37vP23GN9PG4cC9eHHijXXETCay4vDQHaNe7q3Jm5jpO
         1HtiK4mcS/iPH77Q5nalfwAeRQB7R30NhzyQ6Jg2vYwTbHd/4UmMkdDf5FnWH+RwQP81
         x1fUzrrHiulzc/Ung4lsY+/1cnycCWgz1lQUqrg4WzsW41RmbAxMwiwLo6ycj7KyiN1G
         ZyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747986173; x=1748590973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sf5oVq0p4V1KNu2SAoViuAhUyDDrJF+OTYRvlB2marA=;
        b=HebN1C3wJVeobNzmfE1Y6hsatUrdmJI3skydnU9jOwBISkbkOeNtupu05l5e4dLt1x
         83cxS+Jn5xk04EuZymk/NoP2yogORRp7QxBFpYZADD3d0lCkPPvyUIcd9SHZy6KsJDIl
         +NBd7gI44gT/6XDG8Du0GFv9C0tEISn9n/njsxCqC90B/uVrSsMhp2I733LdI3hvKSCJ
         HS5lEaxlIoDkn3H0opFMOl3F7kFtwngpS0VCex0t6D8303+v6uLqgXq1CUAUGE6zxxy8
         p6INw3BIkoTLOct9+HYe+pu1Tg8+x8nucoBY7+Nlp4SYgM/JLSSG7ccuEI5HzQQW17MH
         +ZJg==
X-Forwarded-Encrypted: i=1; AJvYcCW6B/evLyZOXSKVer9PomriEXZoj9/5PJ+V4BG+ZRqc5WBOczvp20f/LKAa3mRVDi4UFFEj9qBTvpHwx62nvp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvwNAH96orYXqMFr4iW4Klqs0SEH8kx4KP3F8Ry4cSBSi5CgZa
	WqIixqhQtkJwqpK0wbzH9OoSCOytuWROTH6CW1nYHE5Y573cFpvoN5DqqafvhzaJLEJrzEjKAAA
	ryPYKxEs=
X-Gm-Gg: ASbGncsKCPYnMjGKsfFiG7PVNs/yh3fGVZtuPWAynn22gRPcICtwOwQodPfmPYFq9kV
	zS5GZ55EL9wdf88YaCJWblcVKNc7dDGdFu5LGPENNULRvkN9hWgXeGM6hAtfP/BstSUTFtP0GgB
	CjhSQvGJDFu3A5SGQt/SX0Z7sqLFHRWLPy+7E+D7t6l7/46VLk4GzbqtWjazam0dEnV9glAJ45i
	PEUastwc26IpP4v948JICzGPIg75GA3zUEABWqb5WsoI2o4QPixogMwhKSnl+Tay0G9h3r/ceux
	QaDSARhOMsCq9rGYWO2hFyn47kcnA7PLeLQiCAdC+p8MjReMyg4AC7cQkwYt/K/Qcl33hS/BGEF
	Hw9E=
X-Google-Smtp-Source: AGHT+IGZ+zW9xJjdx7/pyHegoY0b4cvGq/St5kfIPDWd2+jyQJwKX8XOdYUArgxgNbWKJ8peo6soWg==
X-Received: by 2002:a05:600c:34d5:b0:441:b3eb:574e with SMTP id 5b1f17b1804b1-442fefd77eamr257454705e9.5.1747986173415;
        Fri, 23 May 2025 00:42:53 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:aeb5:4cbf:e382:76a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f23bfd54sm137616955e9.17.2025.05.23.00.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 00:42:53 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: shuah@kernel.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH v2] selftests: filesystems: fix "memebers" typo in mount-notify
Date: Fri, 23 May 2025 09:42:32 +0200
Message-ID: <20250523074232.15274-1-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrects a spelling mistake "memebers" instead of "members" in 
tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c 

Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
---
Changes since v1:
Improved commit message to be consistent with other commit messages.

 .../selftests/filesystems/mount-notify/mount-notify_test.c      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 59a71f22fb11..af2b61224a61 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -230,7 +230,7 @@ static void verify_mount_ids(struct __test_metadata *const _metadata,
 			}
 		}
 	}
-	// Check that all list1 memebers can be found in list2. Together with
+	// Check that all list1 members can be found in list2. Together with
 	// the above it means that the list1 and list2 represent the same sets.
 	for (i = 0; i < num; i++) {
 		for (j = 0; j < num; j++) {
-- 
2.43.0


