Return-Path: <linux-kselftest+bounces-47028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBEECA4BC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 18:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32B55302419B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD60630CDBE;
	Thu,  4 Dec 2025 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SspbDLhI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C23093CB
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865057; cv=none; b=ZQgoaMzVekF8ja6pInPkCn7vH3FYDn1+cYTaEPVRnD+83RsmjBP788cV1fs5cUnjFPtJzmLIYZQGgtxQmsFBXjDz+KxwUEhFdMCQO+vLF8ftllcgPUGnf8l9E4eTlwrAcFRF+QB6taSHWtEi1EHTdN18uhc+eFuavQA0tgjYWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865057; c=relaxed/simple;
	bh=4YXW8OG0rCOOXlu8/hY+ND05Jy2SB13kOh4JqU1k2XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqSxOLyDJooDt4lEM5VInk+A/NKygCelG30qe6neMGrELxvcWYjT/qGew0mFBofBT4UGqb2kBasbwSS7gxg8gkBtL7vEbItiBjxLau4ywerRHz9PS7TwIo92qmB1dlOhJSBsO/ubrAkBumxL4gJzqKQYi8lWVZrWNJ+5QMV5rxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SspbDLhI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29ba9249e9dso15362485ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 08:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865055; x=1765469855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgJlpBD9Oy6edvzJI48obEDsgxUSySjXL9hrT+JA5cI=;
        b=SspbDLhI5HsDxGVZqEkyNWiMNsuX753+cCaiAZIgB8ja/LnTkCv0hG5ErwLr4gqqUU
         jeqHih/fgsW20UzUUkYfIkGQ4Yjopy7S0lqZx89sP+7ZLi0lwRW4RPMDCOekq0I7Ki1c
         v4zgFqfY+PN04JgIDwguvTOZXpzlpmdzwhpMND9g06ks1FiSE7NWW8YdjP6+CM24uqM2
         LFd1XjqoW7nkUWBBOU0C9FQfRVkdJ9UjOjJyJ72pZA180qbx5FilzdzQfnWuY0bSEa83
         euu8FvwJoSP7r4fSj1Ru0KU+LW+IY9o4S7WGgKjWOU5rkSz4lJXZGSN3P8m42eqYHz6f
         CUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865055; x=1765469855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgJlpBD9Oy6edvzJI48obEDsgxUSySjXL9hrT+JA5cI=;
        b=PCa9nH+AUMXRGxq8TLDNbxh+DDxykLY15FPkO0mlR8J+HyZGxIYNFIOvWRt2AKhRD8
         lv+APg3ZxAsA2GkiBTG+FGk9X16tTU0DYcreCWWxZJ5xwcTMiyi1RddbbyU720EljC+y
         JcmX1rGoy1tzIkawdtDcnMTgY3I0lqPdWgAJ7AFRs9jAhOAhOkJyKumdIrMjaIqL4QXA
         iDRn3KLlMT6Kr5H83Fu2wkpF0+oGm5oi3EThNMb2Gkwce568tx1VXuy6tB1oZo5GIre0
         x8vyLcM0uyj3yVskjN6ky8oyeQReZAmSOBPq87DYue7dCUgNGiEe6YxXP7jguUykREzW
         xnqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9eeH6bG1E7VIaVLeQKgCLe5D9neUFx0AkNHiwcgVCwTQCfCJ55dNa81cGH9b/3iDxu13T0o2kgvZA7nagJGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh23rNPIvBV3IzJQm4bqc8KHDlw+fFaYBlbd1ho+yXwm2R8DKG
	XLX6T2BNZO1nC7FzSPMSZd3XuSJMjCQ+orGAkRWLq7s4IgzhLLzVY4sr
X-Gm-Gg: ASbGncv8ylNXjeTvBAV9q297aWyd5DsV42SaFLeUUncX/WuaPOzwyAZDOSBqo58SEW0
	aYTm5qYxe08kp3ssVIRggXuZWcX2qvFwBQVLYLeTuYstPl6smSxVCwi4J38iLk4am/GQ/Ttexh0
	VCLaXplEneJyv1A9GzXjyIf37737SX2J3/zfFbNKE4YgWgG/dNNlHdoma+/v5MRg3/6O5JYvnYA
	JgJeUncFkq+IhDYBtUTS2XQCQLJH3l0V96fYPcfY1dspb2IecjXi4lXTUXk7wu/S4sJrZJru1+y
	H+8QdWmq2wTtCaBvLpad0rsyp1hPXwOjPE+p1gYpf0GBS37W0g2Ye9NToGp89tl+MBldbD16BZ2
	x3Dfodey91P5Bmwu+M+HXDXC412pjmIQ6TrGC75mtSYIvaES4SR88b03TOy9YQtngDAyMTbvWHv
	xjCFI6EjG3TfB+OmKTLMHRM2sB/ZRxFzJAAA==
X-Google-Smtp-Source: AGHT+IGaXC6rcyg8E4GPS8vJXLuydedpCNwD1tzv65eDrwpYnZVI13Qf3ZD8xny7+gJkE7253VSp2Q==
X-Received: by 2002:a17:902:cf4a:b0:297:e1f5:191b with SMTP id d9443c01a7336-29d683254cfmr83648775ad.11.1764865055241;
        Thu, 04 Dec 2025 08:17:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49b196sm24694395ad.17.2025.12.04.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:34 -0800 (PST)
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
	Guenter Roeck <linux@roeck-us.net>,
	Adrian Reber <areber@redhat.com>
Subject: [PATCH 01/13] clone3: clone3_cap_checkpoint_restore: Fix build errors seen with -Werror
Date: Thu,  4 Dec 2025 08:17:15 -0800
Message-ID: <20251204161729.2448052-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251204161729.2448052-1-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix:

clone3_cap_checkpoint_restore.c:56:7: error: unused variable 'ret'
   56 |                 int ret;
      |                     ^~~
clone3_cap_checkpoint_restore.c:57:8: error: unused variable 'tmp'
   57 |                 char tmp = 0;
      |                      ^~~
clone3_cap_checkpoint_restore.c:138:6: error: unused variable 'ret'
  138 |         int ret = 0;

by removing the unused variables.

Fixes: 1d27a0be16d6 ("selftests: add clone3() CAP_CHECKPOINT_RESTORE test")
Cc: Adrian Reber <areber@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 .../testing/selftests/clone3/clone3_cap_checkpoint_restore.c  | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 3c196fa86c99..976e92c259fc 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -53,9 +53,6 @@ static int call_clone3_set_tid(struct __test_metadata *_metadata,
 	}
 
 	if (pid == 0) {
-		int ret;
-		char tmp = 0;
-
 		TH_LOG("I am the child, my PID is %d (expected %d)", getpid(), set_tid[0]);
 
 		if (set_tid[0] != getpid())
@@ -135,7 +132,6 @@ TEST(clone3_cap_checkpoint_restore)
 {
 	pid_t pid;
 	int status;
-	int ret = 0;
 	pid_t set_tid[1];
 
 	test_clone3_supported();
-- 
2.43.0


