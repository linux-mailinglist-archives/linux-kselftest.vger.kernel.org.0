Return-Path: <linux-kselftest+bounces-47027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FA7CA480D
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 17:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B14830D8D40
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 16:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B14309F01;
	Thu,  4 Dec 2025 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC729Wfd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E13308F1A
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865056; cv=none; b=lmDu4KYNvR16M/OrOf6uXV7iHes1hwxrJGqfsw6XsQII/n97NqcsnCaID3ysT5iOgQWcF3/sEAJl+wwGY9+8RmQ8GufApK73O9qRLgic6nCLH1lsSSB36yEfikkavkU0WsVPaVIjTwfyHfflxnO7IgOAgeq99nBK1NlapmxhO7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865056; c=relaxed/simple;
	bh=gzLs8cHkNcBOmjzqsUvEBw+4jkBx9B1WlBta8JzQ6x0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwpSUC1z/wbZ7wYR4JMvbT101k1KJdyiwwy3Oars5kbI+96K8/xhQsrdXpe/wn1dNszwYcv5yqNAfj3YMkSqPETuueG16HrwHWIfRSiyQcXHzgpLdGvx00pOxl8lRJ1ew9ZGUnDY5H5yBewrdrOc8kCLzrpVWE/JeJWVOAW5FU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JC729Wfd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297e264528aso11347045ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 08:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865054; x=1765469854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2C4Shuc2pUkek0loEVubh36sMLFCuTDFArc/gXySHxU=;
        b=JC729Wfd5L9BDOJQZsDM4iSthWv4Tx/pqJWxdTLw4IwOrhIncFI+v9a8P7uvHL8QXV
         fx/pH22faCHHrtNQhGZCt8j03fMNeNSMiU1xVMFnX6soMlKYCDZZvSv37CICepe5G/pd
         YPLlECotE7FH9ZWfzQaiaRm5IcaUSaFIYGjnlYmm2lEmTRFwZ6OsF9wsrnEwQbE7tIzN
         rn3sdJW7TatcYxgXsIGtxgQK203OpQdnO7gTZ54oHZjgx45T3OCwauKy/UFIL0JdA/ES
         k3pDMoZJmdPvFxHUUYL+RnJXzEbS+BuEo8dA0FPKd3kUgp+v1fPwYH55DvNfzHGRn8Xf
         BdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865054; x=1765469854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2C4Shuc2pUkek0loEVubh36sMLFCuTDFArc/gXySHxU=;
        b=prthTjpu9N7owyrwr9uNPjIUgZrDoW4Tst7kiDtRn2l0vEWmG/TwEuhyRV+pl8fGKU
         5hvdyGoWBdd03N2/5lfSRUMs2yfOfOy70ED64l0crXH+5Y+5xGNmF4j/xCkYRLFcpUNo
         Jr3DaUwzNaA6qIAuc9Wk/IX5GIV0Jlao1VmNqWZjcJHhV1BfsSb9cqP42vNtXL6OeLQ8
         WIvFNRgo8zQpexQQ+TEgL2BqtUhM9TsN1k4q82L00+q8ZXKIJ6Y1WTHY6K0MmDZKIxCM
         aiWSH+CWMeJlPrMHEjEBo8xCBYy0bl0UYh8+BeiON3l9K9MfXohkxaRv0mYsoB+LZ29N
         dNGg==
X-Forwarded-Encrypted: i=1; AJvYcCWuNmfIfrvaK1yvnC8DRhxm1DGuDZrXRFB/J0hKBvvhcy2F3JoiyPwHwqq2TYU4xbw+jCwM6rc4aLXT14+p2EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYPKxcxJNx5L7Y9RIkd/OixxiX5fn9E9J2oylqTO2jkEPdcjA2
	wuCA3JTVB3Kh/aWPmN/zpzJe8ih/cSM3f5dHlXLV8aFR0ayuvYKscYEL
X-Gm-Gg: ASbGncu1uINNKT9qRsPi3m7iZG9hZ2bEByBZt/LXsPGLXMX6Xs10/1/DjUKple2VMdC
	A4v05RYKiH7JeBdpo3UFg/NPL5GMkNGfZRUl8UIO1w7O5fngCOs18aWH++VY9NbJCK0S76u1qDO
	Rr8hSwwRpePMdGehC41j9/xdWYhIiEQ0DpxeZChmurMek8NE79xD4VrqWWQXGMpd5BLBuzGrdk4
	bfumEOfq6l6/ufSkgoCGEKTIP8mrEeaIlW87t25RtcjIQflCEUICmt9YaDw3QpGP2PPP7nGwvQI
	ME7uZ76heutpwSdHk/kxvGuo+y8UxIc3na1/gykxoSpt6g5f2nuLCxQK/M5FSmxnwUaSsGaPrM5
	XlKSWgP7NkGePAIdERACWVxH4OZ0Q43ov6BwufsHLaFl8iDU5txlDuKVXSM8SN/8Ns4hvFiU9sy
	EgJPTTO34BY5jUOreEZXJ1R+wZlpwLjorGFQ==
X-Google-Smtp-Source: AGHT+IGUb5OCyLlu/xRJZk4tuT9BSuBNLmXZkJmmtQJN4OxIZEiB2Z/OnHD/QTUXMM+QYl2sFQTNCQ==
X-Received: by 2002:a17:90b:2e46:b0:349:30b4:6365 with SMTP id 98e67ed59e1d1-34947f1afb6mr3587048a91.27.1764865053868;
        Thu, 04 Dec 2025 08:17:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494f38a27asm2278321a91.4.2025.12.04.08.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 00/13] selftests: Fix problems seen when building with -Werror
Date: Thu,  4 Dec 2025 08:17:14 -0800
Message-ID: <20251204161729.2448052-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes build errors observed when trying to build selftests
with -Werror.

----------------------------------------------------------------
Guenter Roeck (13):
      clone3: clone3_cap_checkpoint_restore: Fix build errors seen with -Werror
      selftests: ntsync: Fix build errors -seen with -Werror
      selftests/filesystems: fclog: Fix build errors seen with -Werror
      selftests/filesystems: file_stressor: Fix build error seen with -Werror
      selftests/filesystems: anon_inode_test: Fix build error seen with -Werror
      selftest: af_unix: Support compilers without flex-array-member-not-at-end support
      selftest/futex: Comment out test_futex_mpol
      selftests: net: netlink-dumps: Avoid uninitialized variable error
      selftests/seccomp: Fix build error seen with -Werror
      selftests: net: Work around build error seen with -Werror
      selftests/fs/mount-notify: Fix build failure seen with -Werror
      selftests/fs/mount-notify-ns: Fix build failures seen with -Werror
      selftests: net: tfo: Fix build error seen with -Werror

 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c      | 4 ----
 tools/testing/selftests/drivers/ntsync/ntsync.c                     | 4 ++--
 tools/testing/selftests/filesystems/anon_inode_test.c               | 1 +
 tools/testing/selftests/filesystems/fclog.c                         | 1 +
 tools/testing/selftests/filesystems/file_stressor.c                 | 2 --
 .../testing/selftests/filesystems/mount-notify/mount-notify_test.c  | 3 ++-
 .../selftests/filesystems/mount-notify/mount-notify_test_ns.c       | 3 ++-
 tools/testing/selftests/futex/functional/futex_numa_mpol.c          | 2 ++
 tools/testing/selftests/net/af_unix/Makefile                        | 2 +-
 tools/testing/selftests/net/lib/ksft.h                              | 6 ++++--
 tools/testing/selftests/net/netlink-dumps.c                         | 2 +-
 tools/testing/selftests/net/tfo.c                                   | 3 ++-
 tools/testing/selftests/seccomp/seccomp_bpf.c                       | 3 ++-
 13 files changed, 20 insertions(+), 16 deletions(-)

