Return-Path: <linux-kselftest+bounces-32920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDF8AB60A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 04:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94F34A23BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 02:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C463F374F1;
	Wed, 14 May 2025 02:01:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99EC79DA;
	Wed, 14 May 2025 02:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747188066; cv=none; b=fmlZ6t0bc2oJfNdClFslvkODqnILZi4hQ6fvOZrBGH1ktYhPMhkL4YXBfWQF6K49HCWuBiQuzTRP7TG9E7nqXRM6XiqSIJ6Tu4wKqGFQaKVHgNj6HtwhuQcThR5YC0difB7IV+AXYwFYIyBdffFSVUK65JgLkmvUFbDFh+4I1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747188066; c=relaxed/simple;
	bh=X2YnDQKOkJSUPARQ4w7uQ4dcZVtcCXIGvVuf74mpIdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLOPE6bbtAx+CFP8dt5a51Mtxe3KqcSj3++hZ0uQiBzjSeH7XjSML69gw7pF8pbfSbnmd88BFFP9/INoSKuitZDkv+LhjxQlY+o+51eVx89h07TWsKgH16JsDNyPvQKf4G0c8PxY0lm7aOHapBA28vTxuTR731RhpiRKC96HEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f53d271c4cso57058686d6.3;
        Tue, 13 May 2025 19:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747188064; x=1747792864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXzw68QAcezvzld8QKy698596JO7imkdASJzFhaH0og=;
        b=LqEE6GnXX1n267B5XxL6noQwCFEDY5ATJ81X0yrw64miufYesb69XFpuIR8xoFBZMU
         gHgqZ3vQVE8kFMJj5rce8bWn1a7gTgo341oMxZOwrHzR6Ui0X7SbwWUcPGtA+dRX3uyN
         9H6aVTQwpQhT8plGeW9pi5nOBBu/KUzdS6gvkw72tXbR/IDvC+nNRN6Vr5EaOUDmHpRK
         VeEmAFe7KxyZZEyo0LEp4mFiux4s/XZsEWVBELZpLlX/12YsSSyADHQnYucxHdPwqMO4
         kblfyeCvRLDl9hnnt46HFTWwM7RrbIYeTFSOyUqJbzHJ/vPE5gznvGJHoU9YwiGbkuOx
         naQw==
X-Forwarded-Encrypted: i=1; AJvYcCWJPhvoRyCzZ1il7uR+kh1klRZgb5sP8qv2iZnelM9loGobsgs3EJe93al0c7b+2zMrGpUbfLyVJDiONBAQwA6t@vger.kernel.org, AJvYcCXwvJoP65op0YUGju4qWGngTB9Yc1Hya1s0UmJJNfH8A9EJWlY1Ys0x0g5VFDIxzB2HN5ApWAPuyB5picc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3v04RH0EWGnhVvncJpyTHzp7TptgRxixxHRqbcRWi9jQJcU4w
	6t4NYtXcL4w3qNF+IX5BkRit3fm+c3auh/u7elQRtHrSgWpLXmByHFeucGis
X-Gm-Gg: ASbGncs3nh504K13isQbvohpeFLAleI9WJwnaW0Ji2tqkiV22EyttupQHhda86Nem1M
	Lsdvgdu/0oZ8rW8K0dmBa9e3CXdnhiAhnp519m8uwrrBWy9QhOqv0QVPL9SXgq41Oerr+pvUc3X
	67jQfBAL9tIpBQlQYSISnziUKJdU71ydX6GBYYaMjLwkuywja7cXopY2XwiZtjzgMc8/kyE++Ru
	49XC+lma/Cy8ThyLcqelxc5Q4E3IKMtY1VwnT1yiUrttCIVUaLvP46hyDlpDdKaVUbkyc1GvILh
	V1Xf9ljrpA3XCfjka+JpCFNGJKLGoB3IHPneGgqmaggSfMgg1ax1dMIVdoWG/i8ZchgRKONUlHf
	XVXztQ7qgUEs=
X-Google-Smtp-Source: AGHT+IF1CMPu/PfSn1lBIltrbvXWNBCcw8j05iaOgO9dGDCwHa0exQN6ynNqfBKAFgMgmJU0D8ucpw==
X-Received: by 2002:a05:6214:dcd:b0:6eb:26ed:4d87 with SMTP id 6a1803df08f44-6f896ed823amr27450906d6.31.1747188063638;
        Tue, 13 May 2025 19:01:03 -0700 (PDT)
Received: from localhost.localdomain (ip170.ip-51-81-44.us. [51.81.44.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a472b3sm74866406d6.77.2025.05.13.19.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 19:01:03 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: add missing include
Date: Wed, 14 May 2025 10:00:40 +0800
Message-ID: <20250514020040.197152-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I failed to build this test on Ubuntu 24.04.
Compiler complained about undefined functions mount, umount and some
mount related flags.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 tools/testing/selftests/pid_namespace/pid_max.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
index 51c414faabb0f..972bedc475f12 100644
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


