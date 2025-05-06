Return-Path: <linux-kselftest+bounces-32514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8AAAAC9C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 17:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6597AEC8F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E0F283C9F;
	Tue,  6 May 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+GyyHUV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB3C8FE;
	Tue,  6 May 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546262; cv=none; b=hg1DEpEiL6yeZzHRZr4vES+zpwkb5/t4Zc/8CQWTQyFp4nNj4egoEi6Pfh26Ezcm7NOk+wfVTrn4I59ahvQ7sm1+GYctDM++3x5k+UbRtYVKqIRLycq6Or1kfPOof8G0tUeD75+OMBsWywQih2F0auApQT0ivqYZj7jJu8g/E6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546262; c=relaxed/simple;
	bh=tPzB4Cr5GgKl89ad8RCRlDRGcX8EwjgQuP1Ms+e8B4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hmb2YoCtk+/ge/r4U1fqyONGEktWPqg/aAW6pKuk5z5PXgWNiSOElTLX9nOSFRKvmLEaLhllLQiSc2Tro+i9bVgyGljamWjyaOq5V4aHnWrStW/SenymRs2BTphHh3OvuxZ/Af2D4AgbRH5hS2YJm9KFY2qe92x2/9VSkrZ4j+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+GyyHUV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73c17c770a7so8267426b3a.2;
        Tue, 06 May 2025 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746546260; x=1747151060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W92479e3GDwcVekSJ+6iNPM/4aDW6S7waFt19f/PGiQ=;
        b=N+GyyHUVO2560hGgcmNz5VHdkYMhvtfa06NhlpqqdQ9eywilBDPmcyquIIcQI5fQy6
         kXiFq6q7hdrgSRFBvYwUhYAL+jbe/jaJNvi/d+Yg3j6zOZEOMz4VchNFsgWcfzqtzRyI
         N9C9QgWo8T+3NdwhKIJRisx8DznvJSWsjG6adQc2zHQcV0ddL8cOWBrhlaRJ9RmEXeO3
         1BX8zqk0p6mkd4ieBQm/8aF1T8redf5lalHzywf7dhVI/rCGgamBLeQB9ldi9Ac6i+y2
         9b2Nh7GyI7VsjOc57kt+CBg0Y2AfvY5B2+yevUpVX25a9dVy8AVZQj0PYmrL1Q5GJOri
         btjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746546260; x=1747151060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W92479e3GDwcVekSJ+6iNPM/4aDW6S7waFt19f/PGiQ=;
        b=Wb7kMitTHcmhyDiuf8Lvv/DhDMltIY/zNwWnZ8Us0yGeCJCWT224BwFfEkhZKQLT8W
         +N4ZSOgdEkAw5OK3JH7SumcKhDITDqn0u1zz9vF8M67fe+w3k7BWtxPnQsnwwuChJLwd
         Vj+hCdM2zqzPQyYx+QE3EXrQISUOqEKlxpWnzMx1g1KD2vc7nyIXbDAN1tQ2NgANEqSN
         nNRb0fw69/RoxrQ93sFfJL4B9f8/0R9TzVkHW13zIeulZu/gzP7HcqNrN21MzAoQatWW
         8MdQ4tCjFWHpamUFTyd0YDPFWc6yg3Lu1n8Xmn2KsUKF4P9UmflFQtLtQc7ZDDVOFoZn
         cC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4QFir/LuWOflxV9rqcBVz2ZTuSaMO4TfW6M+FqRDQHSWGNgS6OT5n8EYrggzd9HHH5VCF9WguLJfbwjtn564=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGLqN2Jq6/VS8YrH7p3eWHoFDGHGd51BkxQirAbBVpUTLfiudb
	IAx0p6FAYnS8M2ryWDXyh28AHAyho5MY4leDBZGmydhPzp24M+KFytMmkAMq
X-Gm-Gg: ASbGncszd8CJK5d/syC30aIAvHjyXtykmxYcecDZUiN7W3/24Th4PWuGWr3vh1S3Lx9
	QsDd/bajtEcM1u8qqSwtgts5K2SgbcrrFQpN8gzlU5PnIIfBNsaL4we1c5M8j/yyJo25EMsB6I3
	EGfBs/1AaeyPRQyH73VZ6wxqXkmIa86QqyDWwWQaXO55mgYuGVJiUd2dlj/46Vf7khbjex0kHR2
	/+nNU4mq+uJmM2PlraWUsrs5UdFdsGoQ7UaBgsoA4jduSLjGRbCTx045po+raNs+AXarXEeRjUu
	KMy2RFkM8paPyokSVw0kN9aG7lvDTiD4cuqJW8Z4hPjnvOtqI0TgLftRkcKcRbdxtaZEiyX8VEv
	FslO/wwHUUvp1HxocRqn/Czj6idMCFGP1ipg=
X-Google-Smtp-Source: AGHT+IHVsHgCGhiIOVqITpHBM3uC93n8OV65My3h+37NXsLGcvJQsk08vps7/EQokyGbCmT/2HP9dA==
X-Received: by 2002:a05:6a21:9102:b0:1f5:931d:ca6d with SMTP id adf61e73a8af0-20e962058fdmr17563250637.1.1746546259972;
        Tue, 06 May 2025 08:44:19 -0700 (PDT)
Received: from server-kernel.moonheelee.internal (d173-180-147-14.bchsia.telus.net. [173.180.147.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb391fff6sm7715747a12.6.2025.05.06.08.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 08:44:19 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: brauner@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH] selftests: pid_namespace: Fix missing mount headers in pid_max.c
Date: Tue,  6 May 2025 08:44:16 -0700
Message-ID: <20250506154416.3102-1-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compilation error in pid_max.c by including <sys/mount.h> to define
mount(), umount2(), MS_PRIVATE, MS_REC, and MNT_DETACH.

The test now builds successfully.

Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
 tools/testing/selftests/pid_namespace/pid_max.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
index 51c414faabb0..972bedc475f1 100644
--- a/tools/testing/selftests/pid_namespace/pid_max.c
+++ b/tools/testing/selftests/pid_namespace/pid_max.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <syscall.h>
 #include <sys/wait.h>
+#include <sys/mount.h>
 
 #include "../kselftest_harness.h"
 #include "../pidfd/pidfd.h"
-- 
2.43.0


