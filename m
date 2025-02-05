Return-Path: <linux-kselftest+bounces-25799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E17A283C2
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 06:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B361665E9
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 05:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D550521516C;
	Wed,  5 Feb 2025 05:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MclkfxxS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A48F21D591;
	Wed,  5 Feb 2025 05:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738733974; cv=none; b=hfxAg8aF2bbQvkRkwcXZAiTghpFYo6nY19DQhKz5+6eL378YgMYdcX3q0bK1pFYJc3keWgK/YdxMlNPIaVgc1vlofb/iLyrR+iyFUvZsjwjc8sF5Egm7D2vyoJLSFb5cmAQTeft5jFx2mWqLduJOLfLo+o4b35QhV2mZBqxJHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738733974; c=relaxed/simple;
	bh=wRMSTlIHoaEU/DmkPcVfRBAGfm3mkOsFJgbtEQ6blDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lObdFkYkwATmLAAw5wUonXwdQpR0LLabZ5Pn8ifTx3TX30qh56ctN1VUVXFNNYs48JOWKd8WzYaIUTNYr9F3rOFhnv4hrEL+tA0kzX5QutBzAql6361IliCRaqHETxOK7pF2hyomcPaOFtoiTmcQNG1qBh1P0Ls5uVyKw2oOJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MclkfxxS; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9d17ac130so1641597a91.3;
        Tue, 04 Feb 2025 21:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738733972; x=1739338772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dsul7VtDFl3am4+HHPYwB3KbX5Pdkh87uLvEk51HcKE=;
        b=MclkfxxS7y4SRoSJ35kiLq6ScjRWVd0T/LHPVeor73BW6DvrH6Vtdb5yJ5bb720GKq
         Ox4MDhMiyjsaYNTm7oHTDsPwq77e7Ngj8BwOE4zj2fEJudj8mVuBRxHmv1lA8nhWg7JA
         /Q1r3BGxxpa4Wg3EbjGYVzJ53YMH/Hgy+n27ch1BMLTDH36JSwjbENBmzafB7nAJxZk2
         FxtouCBF5mIckjREoXHZwvFcscrwKleitZfwh28ukdHeMwBad738V3BSgElemD7q2XeH
         GhatCjs5jISKdBSce1uxcCtIFFQfHr/WnXdp5M7cVsQcTEj3EfpD5uy4h3/WH3/ESo7r
         ifqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738733972; x=1739338772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsul7VtDFl3am4+HHPYwB3KbX5Pdkh87uLvEk51HcKE=;
        b=Ss6vg21bpjyzV//zHElxpRhWuRMsFlMtzeiB+L6iJCqGsvSTdLBRPyXno+TiOMKwaz
         LwlJTpn2PF6mPAU5IxAi4tLap6PihXaYNy64t3qfE6irzk9ZGzXT7VABgbOwZKvB9kfn
         K3q9dLQm9jW3GQqZISos6wrIJi+ODoqZWLRQuQVOfb4G8tOpr8LlxTzXlEqE+jEHSrOZ
         aBGR98rzYh2NhR5WMLupYpJax+0Tzr+uj+YYCQ5iDbuloj+TMZq8gUGpxR4xGfsrQA/J
         7SbLtt4vQ+PIwDgdSm7RyyZGYCEXIys9PcVWdAyVgj4xAqbfIay0XAVMQIZ3mDnuK0NJ
         hnFA==
X-Forwarded-Encrypted: i=1; AJvYcCUGnBFYRymDXWej5rhK7P43Ua50k56psBuxsGbebRzD7B14hKQDI2X3QGHB+v732U5F2TggAgH0gKS86pM=@vger.kernel.org, AJvYcCX/PAUVc3JdY00AwdvftygpcorkPFh5/m2x0KGyZUbMrGS74qJ+U8gNzX899cTXFaHslvhfSMs28BoWHa+OQQtk@vger.kernel.org
X-Gm-Message-State: AOJu0YynGPljDFYIptnR6x41jnipAhQu+BH/zIs5YsQnyo/VWRErJ4Ua
	aHp6qi23eWD6FJo/fHqzb5neK7JZRYo1vy3JIxKqpPxBteMMT6Ai6/Mcyljr
X-Gm-Gg: ASbGncvqKN2gwtjr38rX6Lua2PnI9qkQhQh+/95WE6P6UCtlbogLre+ux9HdILDLeA+
	jnlfe2bXA6rthnHW9sRreCNvIlJGtWCZMdfTCa8mZNfRWeRLS/F2bm0+B0eGSPnGdy4VybCeno8
	Mp0qYIEK8UkVXg6qWX9Tv9U8tIo06cDgBa0apIIt8zoviA8gvNbjQSfjMmxJtcLUrG38h8jYyE9
	foE4Qgtd7NujBhyqc10HFRh6XSSBbRaFS4e8i2t98bnadf9LQiCEKUJrNHeMzIcp7UjztWCIJ5W
	xHb2emHRG/OHiPOrYpOML+J0xcZTbdf6Sg0=
X-Google-Smtp-Source: AGHT+IGxX/h10NXM0LIDTbYPxDYqVH+ZwKPX8fNuchz7fcwwLZmtRcoNtGkMiYJe6nYLWjdbFSvaxg==
X-Received: by 2002:a17:90b:4c4b:b0:2ef:33a4:ae6e with SMTP id 98e67ed59e1d1-2f9e076772cmr2939422a91.12.1738733972290;
        Tue, 04 Feb 2025 21:39:32 -0800 (PST)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:dc5d:87af:eca4:905a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1c06393sm581025a91.0.2025.02.04.21.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 21:39:31 -0800 (PST)
From: I Hsin Cheng <richard120310@gmail.com>
To: shuah@kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] selftests: pidfd: Fix compiling errors and warning
Date: Wed,  5 Feb 2025 13:39:26 +0800
Message-ID: <20250205053926.257732-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When compiling selftests files under tools/testing/selftests/pidfd/ ,
some compiling errors and warnings will pop out as the following.

  CC       pidfd_fdinfo_test
pidfd_fdinfo_test.c: In function ‘child_fdinfo_nspid_test’:
pidfd_fdinfo_test.c:231:13: warning: implicit declaration of function \
‘mount’ [-Wimplicit-function-declaration]
  231 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
      |             ^~~~~
pidfd_fdinfo_test.c:231:36: error: ‘MS_REC’ undeclared \
(first use in this function)
  231 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
      |                                    ^~~~~~
pidfd_fdinfo_test.c:231:36: note: each undeclared identifier is \
reported only once for each function it appears in
pidfd_fdinfo_test.c:231:45: error: ‘MS_PRIVATE’ undeclared \
(first use in this function); did you mean ‘MAP_PRIVATE’?
  231 |         r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
      |                                             ^~~~~~~~~~
      |                                             MAP_PRIVATE
pidfd_fdinfo_test.c:237:15: warning: implicit declaration of function \
‘umount2’; did you mean ‘SYS_umount2’? \
[-Wimplicit-function-declaration]
  237 |         (void)umount2("/proc", MNT_DETACH);
      |               ^~~~~~~
      |               SYS_umount2
pidfd_fdinfo_test.c:237:32: error: ‘MNT_DETACH’ undeclared \
(first use in this function)
  237 |         (void)umount2("/proc", MNT_DETACH);
      |                                ^~~~~~~~~~
make: *** [../lib.mk:222: \
~/linux/tools/testing/selftests/pidfd/pidfd_fdinfo_test] Error 1

Solve these errors and warnings by including header file <sys/mount.h>.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index f062a986e..f718aac75 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -13,6 +13,7 @@
 #include <syscall.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
 
 #include "pidfd.h"
 #include "../kselftest.h"
-- 
2.43.0


