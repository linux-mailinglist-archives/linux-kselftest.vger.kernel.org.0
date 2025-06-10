Return-Path: <linux-kselftest+bounces-34532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1A7AD2BB6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 04:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAC41651DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 02:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553701624E5;
	Tue, 10 Jun 2025 02:06:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E33029A0;
	Tue, 10 Jun 2025 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749521213; cv=none; b=i9AsyW4I424jFVWlQjhje9aPXV4zT5rO3vhWb0SGSBog5e6Pn2Agf+uLW3ESowGwspj+Vj8oXLnkYh3jn0FJRFQxwmMtTYw/4pn+5ixIaffYNsauiZJlmszgQOuMlyy4VDIO0QFtsT3u7Lh5vjN8o4bxmwtyBmHSb+1c5tTkCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749521213; c=relaxed/simple;
	bh=JxIs9ti23+lhasBtOh4fpkazhknzy+eYTXszTYWShXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvc+WHSzNDjlibyrG91Y4MDVeCnutfS1QQ/VreBq/LP3GGS18VBPTS7nNPJA+ZfUhde3BAJs84ynhO9gbk9qJry2jfWqXIvPPgB7SZFQlPCbTvG1AsHv5YZrVb1uz1KpOsJ5ClTlmuLJQhB56+01Qx+GfSYbj7KothEY3OTjEYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fafaa60889so33647276d6.3;
        Mon, 09 Jun 2025 19:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749521210; x=1750126010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mkHlRM8iLp0NsM5Jk7d5tEtIOoI6iyctbL8lUwGW6Y=;
        b=kfhFVkds6C0q0KCuz0v4YVEbRdrsPZh50FbcQKC4uCZGMdayr0OMdqEf0/YqMRwRR+
         ofg7wrGM5h6jfCERk8VDblq/R1KPCuMd/xSdH9OAG5xXFrQP07WwL1HLfteuFQJtEyBQ
         ejHalxx5pAyAg9P1h29UxcGbIpgzeZbJGYGHP5Qk0sbLWVteWYkxbyhPWzy1IBDfjuvs
         wm1BnYVCTjBW1OYJv7M8flme/+5WG38mTNO0onAs6WtKLOC5w5JYS7n5CfKDRrUgaqdz
         fsxFka7AHaOAKiDZ02zPt8Z5yNE8dlQjGvUimM3nHUG9r/h8JoFd+Sxv1UJi3Av7av25
         Yarw==
X-Forwarded-Encrypted: i=1; AJvYcCUeabagiKOOzyCix7CDAdFd7y1crD1WttIWlwIOO5eF11zXYtrQ4egLN37xwCG6vU+uyo6sfxOfkb+fgg0=@vger.kernel.org, AJvYcCV+4KIH3yNCvjyrfk7+wz1oGWqCH/1Jd/hKgyqN3IYREEsoO8zSi9473T0hVXXgm2BRVEebtt0HvIjezouhiFmu@vger.kernel.org
X-Gm-Message-State: AOJu0YzKSvPDQ4ObfIJ4NUo2oicPUicCmHop2qH1trG2v7RJEm23C3QM
	S8KpKbQ+UzFrb5l5+3UYit9QcUPeULNj+U7/6Ei2dCQt/YCwc+tG+nMoCdLkSpiwgps=
X-Gm-Gg: ASbGncvvEn1MILfo5UkLCn8nKf6saobcfV8xRt9LRuklyuyQ2bETETYQjaNDduk2/eC
	Uj4CG7fmrYaof7rYoejSdLEioaJ3qP/7CfgcU7rQQIC2T49Wf8OhxwdVnEjJhtGcjMrmbrCcfMI
	korNGfB0JcMzwW4c7qTM5O1QBXqvQqvGeHlldck2SZwnxr0APt2FKH2bmzGukjcq3cT4xYThZxh
	hnPfFNI6pr5N7A0S1x5VNszMTcX6w0O7tJ8rLYmxZ8Q9k6rutEqCDB3h5KaCb3yfk2q3OdeTm45
	2h4HEr1hbq8lYHKV2Fx2KU96469KfRgu6V4iM/rZD95bjk0dt4rd7iYyOG04dUJATwREZNBVccQ
	jcT/SGB6CmR0Z7peWSZiDbWvzUYdrmys6
X-Google-Smtp-Source: AGHT+IE5Ma072djFPN248G01oBANw/8tQmCaQIDoBZX2bz64tV0K1zKZZEGVBX8OwfReAoU0cUNvag==
X-Received: by 2002:a05:6214:1bc5:b0:6fa:c6ad:1618 with SMTP id 6a1803df08f44-6fb08f61cc0mr263054406d6.27.1749521210212;
        Mon, 09 Jun 2025 19:06:50 -0700 (PDT)
Received: from localhost.localdomain (ip171.ip-51-81-44.us. [51.81.44.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ac95c2sm59118006d6.47.2025.06.09.19.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 19:06:49 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Shuah Khan <shuah@kernel.org>,
	Chen Linxuan <chenlinxuan@uniontech.com>
Cc: zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] selftests/memfd: clean Makefile
Date: Tue, 10 Jun 2025 10:05:57 +0800
Message-ID: <20250610020559.2797938-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing a test for fusectl, I referred to this Makefile as a
reference for creating a FUSE daemon in the selftests.
While doing so, I noticed that there is a minor issue in the Makefile.

The fuse_mnt.c file is not actually compiled into fuse_mnt.o,
and the code setting CFLAGS for it never takes effect.
The reason fuse_mnt compiles successfully is because CFLAGS is set
at the very beginning of the file.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 tools/testing/selftests/memfd/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 163b6f68631c4..e9b886c65153d 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -D_FILE_OFFSET_BITS=64
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := memfd_test
@@ -16,10 +15,9 @@ ifeq ($(VAR_LDLIBS),)
 VAR_LDLIBS := -lfuse -pthread
 endif
 
-fuse_mnt.o: CFLAGS += $(VAR_CFLAGS)
-
 include ../lib.mk
 
+$(OUTPUT)/fuse_mnt: CFLAGS += $(VAR_CFLAGS)
 $(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
 
 $(OUTPUT)/memfd_test: memfd_test.c common.c
-- 
2.43.0


