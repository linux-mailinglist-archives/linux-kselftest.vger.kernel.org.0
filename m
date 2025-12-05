Return-Path: <linux-kselftest+bounces-47113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E16BCA87E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BE0C3027EC1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3193346A02;
	Fri,  5 Dec 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6DYlxzK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7705F3451D7
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954740; cv=none; b=mlVhOenupfcJ60X51o8ML1b3xrnCTrRtrqh1ctQfIkHniMAf8PhhhgsIiRLqoaGDIVls3wDGV8iOwxkoGoiKcUutsEcvSmmsB1qSdtvtIz80GLyFM88+saS1v1q4kosP+GovJi3RiRu8/vti1aJ3Qpr28AoLX0daURYoiOezEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954740; c=relaxed/simple;
	bh=Ke9Hk/U1tAD95iE3yn3zf2OpEhZ/z0cUps2pNlkpgN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uzEoBS4g1ymrMq848eSl9tQpvpsyUJ20u/zzq5y6XVaCSJSvRCB1S9IyRcYFO+b+e3t63e2o6LGBAfWEBTu9W/Sqi+tJnO4tfXpNikWqUoyu9aMGDnNgGgMkxL+xGcOqtqyIPE8cbMDXERFrWJClcuNCBs60buCvZgx2QSNi04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6DYlxzK; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso1987694b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954729; x=1765559529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qORTeh1RcK0OLbEB6J4TCs98golUP6RBmjRH7IZnXsA=;
        b=S6DYlxzKruzDfBHIyj/heAqkkyMEmdAfW3L9vPdmwoamBke00Z/laqgNYOsutGWAdT
         pjzvi2xxee3wUmzepkOB570WTwyyRLsUrhUh9Ad9OZ6kURalpPG66IaCY1N/y6zX/xhf
         OfHZSpCjzM/nN9ZMQRjKiXf4S+0gsQXmNVWQNG7/do+yxT2C9Rd165VAMA5D/tzB8TJ7
         UT5/5e0zejwtA8UwbYQzy0KOcNMdDDOxAfXKGFUO+PEV1RP7GvC3hT7mLkAPBahbWYTC
         R0qhxeRXPefvCAQhF0M9gBJUDwKyGItQjcJDO1E4cazifF33ayaxOBoUQcxSx2BESR/p
         /qlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954729; x=1765559529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qORTeh1RcK0OLbEB6J4TCs98golUP6RBmjRH7IZnXsA=;
        b=kX04Na0tAIlICaaT9EQa7bqsD5cSMX3le6Pujxyqh0iL1tQLtntI+aWEIFG1E5sZni
         XcV/vTD1VBbLL6jD/mdeKQGJH5KqMQ+ApNiAhlO/PeN0FkzspLGgYLS8TwrUaSMWQ10F
         Zeh2kc5sdvXyxex/sWD4qHSO11HHFV9DJcFwGUpZwEs0nPTk67N3wlkBJa2ZogtvVa5T
         ElldQLWdWub6gqLQZAi5oi3XBhRheSZ5pStyK5VpAhr39CNKVcsyl85awZ7/N5OJGJwj
         F+UgLZzsCoyg4cVV+J4RqRCmKcIRdM5ga4/4/n06FxhSc67pFA6SXSVr+G5slxEIk2UQ
         UYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH4XoTG5Qk9VrWHo4mU5nVFj5DK9CEwZtNpVpgRp/FNGjhU+gl7S64oUjeoG4M9CLJ5SDQ06/QYkY8vpf/prY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxknikCY35cfgPbHE0k6UNTxz5FhA98bMEYDBIO3A3D9MH6d89D
	dH8XFOWgiXdV8vK6b2eKW2JdGKxlsh25qkGl6zBgPP+BikAKrYWgPThw
X-Gm-Gg: ASbGnctCES6ALGrBJAzvQ0CgCUL6autaG8bRjeY/L4b3bWumw00HLPXv/x/5Z9oI7gq
	0gEkfPZKaQ+GBbaAUbn9CvnSX30677B31FjwgHcgssTq17e96fBbWmslFMavBpDBfpqxWXMt1CI
	U8ovlkm5VwG7ArNvny/7fcTkU9U7TDCQRbr33l9X9UQFBAxtSFivZFeWJytDOqGebDtx2GfIBVp
	ruxjhNXSkCE4ZExpjssJtAPyGPlZsO9r+eaX9BixTBTo6bSDu9oEmu3aM2yWt3ApqmL0YxFmWCJ
	QQ78Y3EqGGPHndobeVca+Nz9SKe1h0K8FWe2ww9c7uiZO3VcR9ugYpTNAw7Rdsqslx6Gn8gtxVu
	FfPOfW2FKRxIIz/gxKYtgr3+7REgmIIIKyVvzKq4vGIio1G0BD/y/zxsRA38hltot+EFMDeoPT/
	TeTH6mjlIajLvXlW7wu0k6Ifs=
X-Google-Smtp-Source: AGHT+IHG9Ub9xshsdF6kH5/FAkq+jq1T/rEVFAM65Ag5B1+pgNhqA3GKA+rpXsrwIeGzgMXlNvHVmg==
X-Received: by 2002:a05:7022:609f:b0:11b:ade6:45a7 with SMTP id a92af1059eb24-11df643be88mr5146019c88.1.1764954729409;
        Fri, 05 Dec 2025 09:12:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7552defsm20336959c88.2.2025.12.05.09.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 00/13] selftests: Fix build warnings and errors
Date: Fri,  5 Dec 2025 09:09:54 -0800
Message-ID: <20251205171010.515236-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes build warnings and errors observed when trying to build
selftests.

v2: Emphasize that the patch series fixes build warnings and errors
    which are seen even if -Werror is not provided.
    Fix usage of cc-option.
    For "ignoring return value" warnings, use perror() to display an error
    message if the affected function returns an error.

----------------------------------------------------------------
Guenter Roeck (13):
      clone3: clone3_cap_checkpoint_restore: Fix build warnings
      selftests: ntsync: Fix build warnings
      selftests/filesystems: fclog: Fix build warnings and errors
      selftests/filesystems: file_stressor: Fix build warning
      selftests/filesystems: anon_inode_test: Fix build warning
      selftest: af_unix: Support compilers without flex-array-member-not-at-end support
      selftest/futex: Comment out test_futex_mpol
      selftests: net: netlink-dumps: Avoid uninitialized variable warning
      selftests/seccomp: Fix build warning
      selftests: net: Fix build warnings
      selftests/fs/mount-notify: Fix build warning
      selftests/fs/mount-notify-ns: Fix build warning
      selftests: net: tfo: Fix build warning

 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c     | 4 ----
 tools/testing/selftests/drivers/ntsync/ntsync.c                    | 4 ++--
 tools/testing/selftests/filesystems/anon_inode_test.c              | 1 +
 tools/testing/selftests/filesystems/fclog.c                        | 1 +
 tools/testing/selftests/filesystems/file_stressor.c                | 2 --
 .../testing/selftests/filesystems/mount-notify/mount-notify_test.c | 3 ++-
 .../selftests/filesystems/mount-notify/mount-notify_test_ns.c      | 3 ++-
 tools/testing/selftests/futex/functional/futex_numa_mpol.c         | 2 ++
 tools/testing/selftests/net/af_unix/Makefile                       | 7 ++++++-
 tools/testing/selftests/net/lib/ksft.h                             | 6 ++++--
 tools/testing/selftests/net/netlink-dumps.c                        | 2 +-
 tools/testing/selftests/net/tfo.c                                  | 3 ++-
 tools/testing/selftests/seccomp/seccomp_bpf.c                      | 3 ++-
 13 files changed, 25 insertions(+), 16 deletions(-)

