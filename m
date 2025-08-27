Return-Path: <linux-kselftest+bounces-40051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B85C2B38117
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 13:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 416F44E23A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 11:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D8229AB05;
	Wed, 27 Aug 2025 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvHbhYDD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14421298CAB;
	Wed, 27 Aug 2025 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294374; cv=none; b=iuPcdAqYBTSnduKg26f7m6bYsEGMuUVaUTqfNbK34BAUqk4lKv4CwazS4Z/5pS4bkNk4vlNEtfN1gUnf1RlUKGzhS8FIELAaVB48GqM0DwW1Pqo/G+Gj28v47HfW6v2wvhJhXrmJ2yFxkKbc2JWVmztW4SrIj+ab+H/g80zuAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294374; c=relaxed/simple;
	bh=u9OTU4Xk2A7POXiZ76mfiEEhC3Lzb8hnkPR7i69yNfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L1hIoQ9CBsAfjtdW8ry0yrwqfi53i1T2dEkihtY3qFXCf19/3FmFbfMD+eZ7ypVRwuULMHUZwTi63DLwB9w1dydhdAniduJAHBpbhwCOZKvNe6iNWkMrn7Bd2T+GwY1uq4lyoNTzyR1WvVGGVobTWDWf3gzjiTYqxda1P3NKGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvHbhYDD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-771e4378263so2769203b3a.0;
        Wed, 27 Aug 2025 04:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756294371; x=1756899171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CpcO0FpzfQ6tP5e2Bv81hhnFr9+a71IHnO4egieaRJ4=;
        b=YvHbhYDD9RCxUyXNj1sD+XdT45IfYw+sNfpbJNcHXIq2g4/ITDKR89rD6R7uVVeT41
         ElIgfzaxZWF6Ozp+yJD2B8GLyWC+oRqUHSyHakCDmbn/wDffYznJLoFg9o1MyeGSgZCZ
         crEXcGpCQbjNry/6/cLQ1JyCpjz40Tt1tkJdTK3fluQ/pqhWODTQHN63Cqex9RcWW8tk
         pM52MNZTh7lGDYYFpiVKvCPL5kZaByOoYbwAhoZ21zCDL/+2wCYbQlbM/AJxTvZFCyEE
         fTzQxk5UgMP9HFSH+TsedZUf21spDe1I14nZ4+jLHG6C0qiHFMHbepnS1sJpb/ilH4YF
         wBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294371; x=1756899171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpcO0FpzfQ6tP5e2Bv81hhnFr9+a71IHnO4egieaRJ4=;
        b=GVKztMlNqvaS2yQy1bziRTlutqa5fFTc+QaDPTJtgv/qmlHlF8HqCYWBoQ829CR4xb
         3Xw521QUMr9T/K6VoB+I75dZA3zJk4HgVZfS3XQgUndF8noQOJ1a6lT5ihX9zwLpOR6I
         NJpnw3jgnqTn0PqVYgISVwwWmJfyVkioF8XtfSxugs/vpFd64wcWpidJtXof/3frZE4g
         eiOnvxQ4YxUPWKRwFo5cv2pjMP3NntA3iC6OGW122kjca/3Nfbd39MtSIVZI0D4HboX4
         jNXgy6JY7zb2a4aLqB9j09tn3rQN1eexTTF5xuWWD/T3oZP0goRpEKC84FUSD6cChw8U
         Bxzw==
X-Forwarded-Encrypted: i=1; AJvYcCVaN9QGUfPJbhT1kVPcQQ6xfN7SBO6ofyTUF3J6WFJGifCUrBYVTQLhO+lHkSPec0GnS6a5DGaEWJAdjfo=@vger.kernel.org, AJvYcCVf4ALh8oYmLsQ4D/m1dGRqi0me55IHT8H8h4Dpnlkf774qe40Cpw145AJ4O5qsNpH7Di1ZmVt1wTZ6/vpxoHh7@vger.kernel.org
X-Gm-Message-State: AOJu0YxllqxG7AEnuoqn45+CNi52buh6KynLskHWXWbNW1QIGD0qA4kY
	rFJsmeuLToEQW8Eo8CO/bd26yvysmGSiEX3SIlGLLYU2g76mrzVvup5v
X-Gm-Gg: ASbGncvODJrZSOG9YulAAC+69jAgAbaxT/n17SSO1iluDKFPqHQA6LQc2l0ZJoTZzi9
	mSQ8a/W5Ub3V7dpAUN9Y4mpq8koN5W2Tle2tR/VCogW5kGi3s4QT1bM2JIjaUVIWmbsyJ+3MLLi
	0JaZ6f7l1z7fsUZs5WmRR1X+l6DtCP8OUuLboZlOC6kAySb110TXwlVAmXmmI6/ZyrjxK40zIl2
	odYxoHgDFw7V7Y0Icf/a4B4iUR0ZeAzKOR6Z/kaHF3SksKQQ9UJ4SdyPKUOJPTETAHw3K3JIv1Y
	+lJ9JqJtJidbXVViZQAlfp9YEvW9lWbbUxFV0egHjpWCYtImrh+zCw5lY57N6xKlM/z53yCwn5R
	VR2Ij+Zpw/qgW70cWdAFqLr2t3qTvtlxh2X5rIqReOBw2w2VT0WRZ732/MHllnlm4GeVkR0/q/1
	lbF6FAtdyfhLJA0nyzni0khvQ1kFud
X-Google-Smtp-Source: AGHT+IG4UV2HHnp/tCD+4rPlaCvAmsTvqXKJsbede+fSOHhgxu+Jba4EKmBftuPTHICWnTxtmzA/bg==
X-Received: by 2002:a17:903:1b4b:b0:245:fbf8:dd0b with SMTP id d9443c01a7336-2462efd4ec2mr256304915ad.57.1756294371251;
        Wed, 27 Aug 2025 04:32:51 -0700 (PDT)
Received: from server.. ([103.251.57.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248a043de2asm12565345ad.27.2025.08.27.04.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 04:32:50 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: shuah@kernel.org
Cc: brauner@kernel.org,
	amir73il@gmail.com,
	jhubbard@nvidia.com,
	mszeredi@redhat.com,
	jack@suse.cz,
	skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] selftests: filesystems: mount-notify: remove kernel_fsid_t
Date: Wed, 27 Aug 2025 17:02:42 +0530
Message-ID: <20250827113242.6106-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Build kselftests casues compile error:
error: conflicting types for ‘__kernel_fsid_t’;
have ‘struct <anonymous>’
   22 | } __kernel_fsid_t;

This removes the declaration of kernel_fsid_t.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202508110628.65069d92-lkp@intel.com

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
 .../filesystems/mount-notify/mount-notify_test.c          | 8 --------
 .../filesystems/mount-notify/mount-notify_test_ns.c       | 8 --------
 2 files changed, 16 deletions(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 63ce708d93ed..a853671f2505 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -14,14 +14,6 @@
 #include "../../kselftest_harness.h"
 #include "../statmount/statmount.h"
 #include "../utils.h"
-
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
index 090a5ca65004..2ca867687a60 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -15,14 +15,6 @@
 #include "../../pidfd/pidfd.h"
 #include "../statmount/statmount.h"
 #include "../utils.h"
-
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


