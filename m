Return-Path: <linux-kselftest+bounces-8262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033668A88A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 18:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0595FB24A70
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 16:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F061F147C9E;
	Wed, 17 Apr 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mxulp7+t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85884E14;
	Wed, 17 Apr 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370589; cv=none; b=qT22NlYHDHp3Lj3lnHkXajKoA4DCCYHY4Fu9R74HwNAVRPyPpCvjaZJKmAVc7xxVLwXhulqwtbdIsIKrzQg/NK2EErYLZPVfCPtvAkqJK1b3blap3OVwncf/GNlGAD9ARdMTzxw5B+2ccsa9+EEPXmJ2KpP/t/6n6wJvzurKKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370589; c=relaxed/simple;
	bh=Krgol5AK1VFttgbaqcU7tHbCyGc9k/AScToO1HICDbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZFn8t7Bp7e6b3tFPaI251u37VeR73kvxOCPOYrqHgoOGo1axo6eaFdS+Eyn6QhUkcpu+9h1cQh8KiPEbc2U/HlbJdTqDWKjG3nhl5uvQ03V9I2b+5m+wiTPZ83uA6BA1mzVp/eo+CuLI5Vanr4YDB+aIw2sPetU9aA0Yj56PIQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mxulp7+t; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5176f217b7bso10366170e87.0;
        Wed, 17 Apr 2024 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713370586; x=1713975386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pe+uR9BPb/oqFUBU5dono2lVV+upurW6YfGvFkf6LsY=;
        b=Mxulp7+t/ArDfdC6wem3JPnAxzZ4QJtXE17ITGarSF7Q5Af5yF2Feso/f/awHqYfog
         qhC0XFrryUh7h+PWflK6xpCiYqwWD3+L7ka0CploYtWFMVWG2ZK8FCLlJkrY4tzZHzpl
         0FWClTAzyOWu51cJYVp1orQwbSYfOPiDNsI/MPto3lkUklYv4YoBFK9KsvXuZaTjSVck
         IqqQlCFIJjsUGVuhfq/+xj+PIUZ9S0FJtrdpXyE9/E5Gn/G92Jd2OFHQ9LK9gLazzJ7s
         3y8E2zUyXbQOsrLyzuuvX6zHruidZqcsTqndMQ68TPta8eWCstggPZiu/eCiUUsulPS1
         Cwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713370586; x=1713975386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pe+uR9BPb/oqFUBU5dono2lVV+upurW6YfGvFkf6LsY=;
        b=YQdHQor4fmfqWfCrDW8kSxMJyWJ7sE7lnBj+xdbnN2zxL7dOU6VEZOzBcJBxsVgDaZ
         pwnibW1QbY53/shGNoN3iGXRkV32ykMOlPkr0NtChyaACsXbxSm/9llZNuT2r6l7Qd/1
         krMlBK/W9NhG/rxoHyuCLy8zs5ysGYEaktnR8wla5zFKLkSNi3vS1AHGfOp/Tk25Rkc6
         mxGx62Yz4yPl3+BKqDv3R4GznEd56l6c2vHlQS9m7ZKVLxbAuvnC5ir0mNiF+cX8HguM
         ndHcLqo9TfbR1PLaCShgROpL4OFchS2dH871/tyxdunUGp0l1BF/WMlXHaRxpYCYuvf3
         yfLg==
X-Forwarded-Encrypted: i=1; AJvYcCXjj4e6L7EbwubVX5nJmPXm2jUJIJb3aOCqcLlRrhp3SFqy4bjb6yOOx78L7ezB8CrtAqVdmJ11M8BK5BGFVFQypJNYLd/0/WSaRq/8MorFVDJ/Xb0aqPSo+2JLEVQP/dXzCRtKt8soO+axsCZ1
X-Gm-Message-State: AOJu0YzHZ/8UyNs6yNPaKiJXLWz1e1tGG1qgXAbGsZ+LJZZDeI2qeHsV
	IAJCc5kT8EkhoDVOnHOLFshbIHDp/6siN2xObY2IHS7m7CBzAU7FnQING0dZZBM3zQ==
X-Google-Smtp-Source: AGHT+IEkY7P4AFWYwkYyKLfr8cDK0pP3jwxY/48uBiMdWNhvCs8rvo+P8wHKjnGAFlSJYjn5hRYL6g==
X-Received: by 2002:ac2:53b3:0:b0:518:c2a5:5a3b with SMTP id j19-20020ac253b3000000b00518c2a55a3bmr8662347lfh.46.1713370586260;
        Wed, 17 Apr 2024 09:16:26 -0700 (PDT)
Received: from localhost ([185.204.1.218])
        by smtp.gmail.com with ESMTPSA id o1-20020a056512052100b00513d1e9ce7esm1983196lfc.90.2024.04.17.09.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:16:25 -0700 (PDT)
From: Amer Al Shanawany <amer.shanawany@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Amer Al Shanawany <amer.shanawany@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH] selftests: filesystems: add missing stddef header
Date: Wed, 17 Apr 2024 18:16:23 +0200
Message-Id: <20240417161623.37166-1-amer.shanawany@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix compiler warning and errors when compiling statmount test.

Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
---
 tools/testing/selftests/filesystems/statmount/statmount_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index 3eafd7da58e2..e6d7c4f1c85b 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -3,6 +3,7 @@
 #define _GNU_SOURCE
 
 #include <assert.h>
+#include <stddef.h>
 #include <stdint.h>
 #include <sched.h>
 #include <fcntl.h>
-- 
2.34.1


