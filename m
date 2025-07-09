Return-Path: <linux-kselftest+bounces-36840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCCBAFEF02
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 18:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B0B4811D2
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0E521C194;
	Wed,  9 Jul 2025 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR/gshMM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B05695;
	Wed,  9 Jul 2025 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079644; cv=none; b=sfFBCOWuejHlHdieN8+H16pJYICdBSz3Lt876Oe2xevAsZrnLVKI+ZetMUiPR3wUruS9x67RiS51Y065gFTLEPjMLraFJZepoBEDvFbV3qNknbPXtMKXiyakMZ9+O/AaJy0whptxzScMrsWJ+VOE+a6ZSkr0B+1wzNNfNgLdZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079644; c=relaxed/simple;
	bh=gdOJD1a+3ejnha62rl97O56g54Hbe6p4tJBVlXCF14E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ETsq4v1eswAPN1DYzYhq4XoRZRkqFd7iNLY/h3g/WamW6vaUDLgqjFwA/CLlSjDyUhvlRZYcTS2XUA4ZDH344reIkXuPhyGjwScfkQyT+XRUDWl7K+JUZccMlNdo3AH3+iHbAmnnz7HvM9//bxzYh3l8vLabvT+7eNkDkhuW61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR/gshMM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so823223f8f.0;
        Wed, 09 Jul 2025 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752079641; x=1752684441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2qSGTTV0QBho2aJ7hrZznDPyiFYmaeq6xoZ6+oBHN0=;
        b=IR/gshMMw7PYpdURsNnGQn+j2kDDgAJDYqzlV/YBuk7W3RlCouHZZEe4LgsCfpyO/Q
         /NnUVhfT9QzLOE0ikGlM3XAqZQUuyNlSlp2b2YM2TW1JXdZ/dfk4vDkas4abcVRSAviv
         EEvk9cnRXRkgzQ4tygNPTWcL3bJlW4JV1C3jaxw5WmE+3SSggxtZ0p7mANmDgKrpE2O6
         LZjgbqJk3kOxipj5LWl9kA60Hhw7SnoTo1UAw6ZnHOrsYx2u1cqxFroOc0EWTIssB75l
         ax8KkBALChaPQ5kAlZnJEL3G6P6aSnxiFcsNKu4rE24076drNQSqpK5KdfI/9jeMi7ZV
         DrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752079641; x=1752684441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2qSGTTV0QBho2aJ7hrZznDPyiFYmaeq6xoZ6+oBHN0=;
        b=iTkiKKEq5WTHGFiY43EwsbCl/J4yOlpI1Ni5pX9NvPBkBlQWLI4NN2Upd7VdiE7n/9
         /BbLvP5sZuSek90tD5VEhJnKrWayNz1GTjXA/Ns4YMhQo7YYq9rMx4LDFeKL60gPJxbq
         VEk9JoAiAIrsSm7pCx/vbUrjj3C/H+jj45Q+owvOnShmAjIKDuos3SKXoFGRCtARASxh
         YPpPmYNOSh13gUSvMs2tGf5BPTAJSf8j1cA5ZgMW86K7GwrVObqLud6CmTt9958rNDcC
         dxdCiAvieBkJJgDeJD5qU7ji4K5jhTWRzdQCj/aca9ry2V/Xz30xcrDYGdBT4u9egECh
         bhIg==
X-Forwarded-Encrypted: i=1; AJvYcCV0mJ6a5ZRAhhNP1gffeiBzTvdVXYvjRIlVNgkBmaKMiosKFChUXBkfkhVxNC26sRWVDfkOQvZ9laXHbAI=@vger.kernel.org, AJvYcCW/Pcwv0zc6WjIm7wRfag0mff4v3qOjaah+/AnrxyJ81q6hsiT7v3SiKkL7Cpfd7rLwVla9OzTjwRI6osELxUSj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04YmjGCNhXitjv2oS36tL0SwThvukqOlWKWzrBBv/o0y7F+D2
	lBSZZ4Xyw+HfHXz5tPqUHzoxB926TETNzaejWP6FbEOt6ffCJTxkwdJt
X-Gm-Gg: ASbGnctWec48XJMwOJYXgftjaM0zU7+t9Vp/tWjEj4Sb+eSaMsAuqPa9tFS4c+NSKC5
	3wUJeeg+cQngRYkB1cr7yEQ3YeDG43vBwjgqXbrjZFfi66SqaT0JVQ16kG+ErbsSzsnnCg0ngQx
	kUw65ma+g2aSoYobwCJpfJQ2jHWt+l31lMz3CbkyNGrzGK/KIoCteeG+tlidhz0csvcMFV+WaTZ
	8LYG6aXIYd5AgTMb4rLq99M17MBanomsm3jDa5spKNQGTwDyrmCukLIKEfpNHlRoNI4XbEgt49C
	mq67kD51XAKCfFA2G1pDKrlebXztJqcO1d4zux+yfj0FL3PdY5lHOtq9uVXhInjJMe39GWFx1FN
	2N8z1pizwaV32Pn9ViqdoIuxOgfRGmdSgFsbopATVL5srDA==
X-Google-Smtp-Source: AGHT+IHI+KPG8ZrpaJ/qVlYfo8CblE2TCfuXE0V3hZds3XE75QINRGMHxdKf8EF7biqAeFubuc4yqQ==
X-Received: by 2002:a05:6000:705:b0:3a4:f7ae:77c9 with SMTP id ffacd0b85a97d-3b5e7f0fae4mr198810f8f.5.1752079640707;
        Wed, 09 Jul 2025 09:47:20 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-91.cust.vodafonedsl.it. [2.37.207.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225985csm16723361f8f.69.2025.07.09.09.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 09:47:20 -0700 (PDT)
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
Subject: [PATCH] selftests/filesystems: Multiple declaration of __kernel_fsid_t
Date: Wed,  9 Jul 2025 18:47:11 +0200
Message-ID: <20250709164715.113504-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix to remove a multiple declaration of the struct __kernel_fsid_t, which
is already declared in posix_types.h, to solve the following errors:
- mount-notify_test.c:22:3: error: conflicting types for
‘__kernel_fsid_t’; have ‘struct <anonymous>’
   22 | } __kernel_fsid_t;
- usr/include/asm-generic/posix_types.h:81:3: note: previous declaration
of ‘__kernel_fsid_t’ with type ‘__kernel_fsid_t’
   81 | } __kernel_fsid_t;

To reproduce the issue, use the command:
make kselftest TARGET=filesystems/statmount

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 .../selftests/filesystems/mount-notify/mount-notify_test.c | 7 -------
 .../filesystems/mount-notify/mount-notify_test_ns.c        | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 63ce708d93ed..5a3b0ace1a88 100644
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
index 090a5ca65004..d91946e69591 100644
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


