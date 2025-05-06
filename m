Return-Path: <linux-kselftest+bounces-32535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E37E7AACFB2
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 23:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C5A4A8B82
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 21:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C1F221F16;
	Tue,  6 May 2025 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMEhu4ae"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B52221734;
	Tue,  6 May 2025 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567361; cv=none; b=cIxybZxWdCZjh+cuUJrbGESnnhdrbopyYpeBF0yJhquLwQJL+XCP/55qnuyBFDEJHOiedOWRcY/wAU5cW5QxbRyf4HDyO67zCxvX7yaAujZBdjWMOSVaczq3xdu+n+vyMdxS8CQSfueb9PWF9q8UQgpvi2aR86t8++p96ybXda8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567361; c=relaxed/simple;
	bh=I+Fx8q3goyJx2Gxb/9/UOHkYu+kY2IGAKZZIg6IZzSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nLBBxeTYnJ3P/xQBR2cY0E5ZyxT5StD9P2Bu65A9rr8QRhsAfdGN+bprBilbyGu/F1bVH5yFP5AE1MHTfTiE4RFAl3v8TXi6wqEgesKgtCTOtnNrMmAHSp2P9uRX2VuGJUo8b7aGCtSai/rKzBTZCJy7BjsFPNvw18dzzYGBtSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMEhu4ae; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22c33ac23edso67850025ad.0;
        Tue, 06 May 2025 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746567358; x=1747172158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eIsa1bhwZTWpZl9eNabO08QufObEhVlhwC0HW+Z0IKg=;
        b=JMEhu4aeA4oXPWvzDsWVnQWTzGVwvNRBi9jE+phEOjGMZoPxFg5UIWdPHRo6ZLtZZf
         5tmaAyC7Hh0l0ZOJosxMMzn2Zl1PnoVkdEXFbTbOhLyZjRb/gCMCOAbTIrltrFqAe9Cc
         JcqMAeE25RiM8AnG5741MzuFeLc5kRYOlOXSm/UR84YYlG1zp28KxFqNy5AoLxz7CW4l
         vCy9cC+fA/00Xl419Hyf3G7Ef0IKMS32JNHzeRyJAv2MjE57SBK8Uqafr5FXS7heTnP2
         C8npHxtzjHlzL8YkTClywVUnOAWpI2nE0hfAZWvMc0OyF6A+s6JJT90UEfPW4SfpzP69
         GS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746567358; x=1747172158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIsa1bhwZTWpZl9eNabO08QufObEhVlhwC0HW+Z0IKg=;
        b=fUUBNkLIKhd0Yd3qtZsULUIC2VIT2PaCxXUBkjE8cMxwRzxq2wMYUXgdHbbLo2Yhmv
         ZxzwVng5ACv1Q01aoo6id2lp4ijj1jYBI2CWdC5TBDEVBP7mTdi06Mz6RVSJ2Bq/R0U7
         RPTMTtxEvPp4ntnQ6LIbAGb8bo0N6nhIMbHd29LJqJabksB66wR2HkuqVW83LkSYl+/g
         +s9XWh4wIYMxhiaFt2BK85VOhugskujC5muER+ebEXRxz8znqBqH2Bd9CQTTft/FDl/U
         Xcx5MQTbTGXgWNRtK0pzDLdegTMD+2Q1URygszsUKjkg0pCbhDKx4/fnjtS+LYGZycR+
         5B9g==
X-Forwarded-Encrypted: i=1; AJvYcCWQ7dKDGSe4iqRi3qXfqOgAZht7Zzp14Mzd76RlAGy3BFJcuVZZBpBaxKsOGrDpKeOURNfUxtn4HshPcNuGk+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi9rm/hUK5RalCLmW8vHz/UzKC9c9m2ilBxyVibWoDUc4S3c4q
	BfzdfXM06121NPSMXF6Zpx0Q8m9RG6JW5Ez4Pggkn9FzcUNJW0d1
X-Gm-Gg: ASbGnct6a48oJczBMgfD7oUS7vw+se0bK5Z5NXLJtHY+jVIpB4uz2NqdVXPeZUtBi9j
	+yO8cqVYbDCDMoC28GUzqGX81fqEg72ezcAyesDTwS7mqYhjWR+rDrc9vE+2jy4YsNJ3CuXICzf
	vg37v8XG4esD5nnJNfDPg67LfeJNq/l2Af9cyItwQ3E1/KLinJXIAG3fjtV0El5G+TTM5d1uhaP
	smBbGlkEARrP8b6b3v3XygagjhhhLEA99Lv+MVAOYlP+NQxpYmNpmg//HslIpWO6ALosiarFzYc
	5WpVtW5MD+ItTmLkY/xC3IAGOjyn2c5yYaPAUaZDd4KGQFw2XlVHPCmuLBcni74E4K9sL0kNZ/U
	zvjmBP22kvuAQn/VDkPHx0lWqWMUKNPMaEw8=
X-Google-Smtp-Source: AGHT+IE0dnaFFX5Qnoy2VbjG0XY7suKj3R2ErvmlpliCrYY2tLb235jAN3MLyeBZ63WibuaxM+zj6w==
X-Received: by 2002:a17:902:e849:b0:22e:5389:67fb with SMTP id d9443c01a7336-22e5ea2dc51mr9571055ad.7.1746567358092;
        Tue, 06 May 2025 14:35:58 -0700 (PDT)
Received: from server-kernel.moonheelee.internal (d173-180-147-14.bchsia.telus.net. [173.180.147.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e150eaf91sm78933155ad.1.2025.05.06.14.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 14:35:57 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: brauner@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH v2] selftests: pid_namespace: Fix missing mount headers in pid_max.c
Date: Tue,  6 May 2025 14:35:35 -0700
Message-ID: <20250506213535.5235-1-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix compilation errors in pid_max.c by including <sys/mount.h>, which
provides definitions for mount(), umount2(), MS_PRIVATE, MS_REC, and
MNT_DETACH.

Without this header, the build fails with implicit declarations and
undefined constants during selftest compilation.

Changes since v1:
- Included example build errors below for clarity

Compile error:
pid_max.c: In function ‘pid_max_cb’:
pid_max.c:42:15: warning: implicit declaration of function ‘mount’ [-Wimplicit-function-declaration]
   42 |         ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
      |               ^~~~~
pid_max.c:42:36: error: ‘MS_PRIVATE’ undeclared; did you mean ‘MAP_PRIVATE’?
pid_max.c:42:49: error: ‘MS_REC’ undeclared
pid_max.c:48:9: warning: implicit declaration of function ‘umount2’
pid_max.c:48:26: error: ‘MNT_DETACH’ undeclared

[...output trimmed for brevity...]

make: *** [../lib.mk:222: /linux_mainline/tools/testing/selftests/pid_namespace/pid_max] Error 1

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


