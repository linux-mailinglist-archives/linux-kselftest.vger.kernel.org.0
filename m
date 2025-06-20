Return-Path: <linux-kselftest+bounces-35401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99DEAE11E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 05:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464484A065B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 03:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E299E1DE891;
	Fri, 20 Jun 2025 03:44:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F53137E;
	Fri, 20 Jun 2025 03:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750391095; cv=none; b=XakaLmBmz5znUNMcr3pryfDNPu6Ohju4WSUGa1Loir/A8iwQLwvGY7u1dGAVrb6vsYUoAWRZQ5HPpDSfF18UH5PiJyBqgFrFnCxayl9fgbQ89lBz06YP5K6zHsVydXij4gIr2aV5drfgjCv7xHmxJvW+zAm6+jn7bz8lhEsXmVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750391095; c=relaxed/simple;
	bh=P7EHuatOw0HJymVzvrWD+X6sUqOycTlOF98vV53nhXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kyf6VCnZA1kAofEfn1MpziPl1XlXXLbE1388V9aG0Gl+Yl+MUlPC7APZAaxOXehB+zLZzLHthUp+1hqMV0JmiBh//2DWzRh9sG7xuOV/JldjyZ9KrEWIeQkqEF5odAr51YzZt60avV6BGJ5PyE32/OhCkmdFUBxCtDQZrNKz2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fae04a3795so15788186d6.3;
        Thu, 19 Jun 2025 20:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750391093; x=1750995893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSai09kLwTiornoBu0CbbBfe0Py2/uLeJD/zKO5PYCE=;
        b=oTzIAVLfKr6L7CZVADjK0hMty81WJ+911kjaagREoEUI6MzOlIViVaGADoebiFga/o
         x+EJxyO+b+Ughfhs2OtxM2Sy41kj6lRlBO/V78Tshawi6C8bwmD8POPK8taaoKWu8M2J
         10sDy7n9GOeRyIZvFZ3SqAyGeX12oh25hHCKDIFA5U72OiP/qF4v3gk2kOlvEkD9+8Fm
         WCZC28Rmxgj32eAUHhHbBBciaB+D3BkU1O1UOFlN9nrbmP3afiGVmSK0jRIN+doMV7MN
         1LgwMgdmaN8vWMpT2qySrW1sxVQIxPrsoENOHWxd9jM4kwnMeoh65hfhfs10fwXVgAVD
         Ob8g==
X-Forwarded-Encrypted: i=1; AJvYcCUvHzHj5FaUs2A7xASsc6eXoj7gQfTZVc1g8MCYKUi/3uKJ9SGNxiwfhQhv3pylcEOJ7LmGDuDaiBFAhK70v1Z1@vger.kernel.org, AJvYcCXjCHuMTQBUIYBRBlH8Aayy0rHcamtiqaqex3QEzPDIGJ/FjyKT/jBNfdGGRVV9VTwx3Pd7dI+ez4bZ9hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5zvOA/ttGjjAp26V/yImgIcgYzMYXSSIQgtlK+6B3WxzCPIV
	lovh1B43Ag89DDqJoI8KUIQY5QDj8M9ywofaryTuQptlF4bVQrwliYJ/
X-Gm-Gg: ASbGncu3Fr2AYqDxIvyeKvRiT3o7J6jW9wSN71h9sl1rhVNFvz1ofQfTuBhrnkM19Tw
	oNSg8hy8/uXId0cNYtMLcYRKb4sl1RG3TjF6tsn8hHcManNFJfOnFFW0v90/f4iSwOEW8/VkrqH
	rLWO92h40kwKW1o8oi0tiNwF8HcQSm/6IE7hHQedMzkypsVlY6/fJwv+HcoJV+dO4gXrfybPF85
	cusoxfFEujabBziFZVT7scRd9UwyrpKBlsmybMrQPhOuxOI76p8D4K4cxlj45ubPzKBPXWd/ajI
	PlSkvVxvfRZpRhGIIYEDw+NcFDkalxzt2eWAwMYFrPC5yoj/j8xJr1hLPVFTTeOct9CPgDB46bk
	W4qNaO5wgjfn7Owx4pSru0A==
X-Google-Smtp-Source: AGHT+IHi4iU1iPpyzEHAhroXiglcFsXWdqg9UxMYuR20focQP5I4OeeysScbkbSt80zzPAp7A7pe5w==
X-Received: by 2002:a05:6214:54c5:b0:6e8:f433:20a8 with SMTP id 6a1803df08f44-6fd0a4683f0mr22883966d6.9.1750391092802;
        Thu, 19 Jun 2025 20:44:52 -0700 (PDT)
Received: from localhost.localdomain (ip170.ip-51-81-44.us. [51.81.44.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093de90dsm7434016d6.8.2025.06.19.20.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 20:44:52 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jan Kara <jack@suse.cz>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/filesystems/mount-notify: remove __kernel_fsid_t
Date: Fri, 20 Jun 2025 11:43:26 +0800
Message-ID: <20250620034403.2932627-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When build kernel selftests on Ubuntu 24.04, I got a compiler error:

mount-notify_test.c:22:3: error: conflicting types for ‘__kernel_fsid_t’; have ‘struct <anonymous>’
   22 | } __kernel_fsid_t;
      |   ^~~~~~~~~~~~~~~
In file included from .../linux/usr/include/asm/posix_types_64.h:18,
                 from .../linux/usr/include/asm/posix_types.h:7,
                 from .../linux/usr/include/linux/posix_types.h:36,
                 from .../linux/usr/include/linux/types.h:9,
                 from .../linux/usr/include/linux/stat.h:5,
                 from /usr/include/x86_64-linux-gnu/bits/statx.h:31,
                 from /usr/include/x86_64-linux-gnu/sys/stat.h:465,
                 from mount-notify_test.c:9:
.../linux/usr/include/asm-generic/posix_types.h:81:3: note: previous declaration of ‘__kernel_fsid_t’ with type ‘__kernel_fsid_t’
   81 | } __kernel_fsid_t;
      |   ^~~~~~~~~~~~~~~

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 .../selftests/filesystems/mount-notify/mount-notify_test.c | 7 -------
 .../filesystems/mount-notify/mount-notify_test_ns.c        | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index b4cb494206e5d..2d197ad8cb75a 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -15,13 +15,6 @@
 #include "../statmount/statmount.h"
 #include "../utils.h"
 
-// Needed for linux/fanotify.h
-#ifndef __kernel_fsid_t
-typedef struct {
-	int	val[2];
-} __kernel_fsid_t;
-#endif
-
 #include <sys/fanotify.h>
 
 static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index 1bd090e9c8dd5..d6a6a7ee87028 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -16,13 +16,6 @@
 #include "../statmount/statmount.h"
 #include "../utils.h"
 
-// Needed for linux/fanotify.h
-#ifndef __kernel_fsid_t
-typedef struct {
-	int	val[2];
-} __kernel_fsid_t;
-#endif
-
 #include <sys/fanotify.h>
 
 static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";
-- 
2.43.0


