Return-Path: <linux-kselftest+bounces-39160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9D2B2919F
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 07:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09074817CB
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 05:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCCF78F20;
	Sun, 17 Aug 2025 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm5QBlzj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB81FDD;
	Sun, 17 Aug 2025 05:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755408298; cv=none; b=PqcAQjSrp+szST2u4NmDW+ll9G1WiDfNENWaRc5U0XcsrqHjLZinV0kKEQYoRST9drMzjlvTzKJXqHiSMqh1UrrZxb3jXJWnU47mcLt7Z/E6/OhPLOmSBxtbYy/284MaYhczRQ/GlnorTV3ceLIwS/U3WnNnQ0qejB+1utZYLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755408298; c=relaxed/simple;
	bh=2Krz1q4dLXwXDvNiRnwBsAnhUvKZtc4rAuQ9af6bRPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jw4GXj6jb5B3dxrtt0EVOoYI2wRkX3/20A9Jok1aFNHjbDUDF6kr2eVhmczuoZwXhL+ZtiFZ48MihilUc2TbuG6cvBJI/n7Wlum/FJuPn+E3zOuy53qWatM7cdiVfKsTXOa8UzGTqDrVVmSTLylMbcU+E7fdGxOoxh0RK9ptAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm5QBlzj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e89e89fso4163317b3a.1;
        Sat, 16 Aug 2025 22:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755408296; x=1756013096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kp6ZpPi7OjGlmUly9kUQqc77MGv9H1CyM6s09oVZLEQ=;
        b=Tm5QBlzjoV+TNVsFWCScUKQnBgQM+j5yQnZAzNjcxr6QarrAeuvJ/EoQNAcI8MnDKM
         ao22zp2oZS+BjPpwDfV0LfZAc/LPsX8gHsQGeMa9IIgbuO8PxcIE/YCMinQ/Vn0FIght
         3f7/mo+9/okwtAo4tAohjms5MghpQ5Y2PvBr+lTCFvCJXMfkrBRMhhDJw2B5Qx/pb+hR
         c6Po6BFTFth2c0pVAdLZwYqYapB+Mua3xvEzQxXFQ97u+W4BOID4YwCy8eFtR+Kg+vIO
         OH2fA7AwTNzkfMTp5dXmA4SskdlwgBAnsMJj+ohRG3TQgJ1W5daClK4/+Btx81m5Q/Mi
         yzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755408296; x=1756013096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kp6ZpPi7OjGlmUly9kUQqc77MGv9H1CyM6s09oVZLEQ=;
        b=ECZdd4EVavuld1Bar9IEHzf7JjQG50vIk9z0eqb8WMKnJZtb4g2ObtOFog7p5YHISW
         xbLNdogJVQf1WwUU/NZLQ785ir0XppeY/4PI+e4xkoEdGxrSbZ/DSLRLwgG+9dR3ATXO
         35aGeCNOu22UW/wQMDgCN4dVnk5xxEEK7jNZvdqqYoITSWn80sFbKkPZuBVVf6pVP0zK
         EmarXTu9GkB6mHCc1SBwDNpwUVRTUx7xgAs1QFFKMmLjquKmg0GOPWdfHfy1Wsl/WNTV
         VbRYrG7HCbEbW2Dg5EOpaaEZnQloo3bPT8DhXNsataH7wzPRwkTGfs29xj3nJ4Lk9Itz
         /65A==
X-Forwarded-Encrypted: i=1; AJvYcCUZsaWs/vKppIJ23VdWoL1GTObxeG0c39Q4qsZ5O96PI/T6xwFvQon80Uu8vXHIHPD1F1x3Nr2ITvX8sy8a0NGv@vger.kernel.org, AJvYcCWobx+JIGAnI2KtAozB2K/zWjBQOA20PfMDgrE2n1zpDXLn+GisVM34gm08nsey1OaZGttfVUGhhAUfxv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2knfKDF3v/PNpSxRDqsBMVGaA5YgSyrHvXi7c/KG9KmhFyBtE
	Aqv3UnovymxJR9uw+DVh0pjrNS3nRIqns8QfZNcWVyXAsKuy7ts0f6GA
X-Gm-Gg: ASbGncuNg+drUF+FEIHH4XOCgYd0f7MN6dQoKVGwrR6NFwtCqRYiVCMzYTYfEEzbNCE
	5J7lrcxkHo27FORCO6eJHeH2FG0H8XXrhyCjIwaZIn+xrtK7Mcb7svIeA0aVbWqFAv7oyHLBmua
	UB/uJ/EsPG/z7ecdsKCzx840hey4fus2C/u2L4PzDNPLlj2k0x+dLcVFOHOYL3muxDUnVhHNFUG
	EN7fE0yEp8Lm5BZ6mZ/d2/jMrFO6a7eKK9n+25KX+OvK+7W9F1XupbYLzVujKZfIY93olrPyUeF
	C/hEMz0kdwBJ7UZqDl2gtjObenbSuXFJnkLR8+HiKdgrI6LP1xZJvutyNZgKyvB40FcbBJbEGDK
	HoAEVpoWgbB0HQKfQT+53BmYJB7CfYF/GL1NJWcHR/sY/y+LFtuWT
X-Google-Smtp-Source: AGHT+IHTOFAVDjbY+ObLGSmXpNKeykOOIucY/+DA6Zi+qpo1sI0TuzxIfh9hG033j8nirlEwbliW7A==
X-Received: by 2002:a05:6a20:914d:b0:240:1119:d725 with SMTP id adf61e73a8af0-240d2ee0e53mr13455093637.34.1755408296060;
        Sat, 16 Aug 2025 22:24:56 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:ad1b:5a79:43f0:e247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45566f98sm4407191b3a.72.2025.08.16.22.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 22:24:55 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH 0/3] kselftest/arm64: Cleanups and readability fixes
Date: Sat, 16 Aug 2025 22:24:48 -0700
Message-Id: <20250817052448.8885-1-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

Hi all,

This small series makes cosmetic style cleanups in the arm64 kselftests
to improve readability and suppress checkpatch warnings. These changes
are purely cosmetic and do not affect functionality.

Changes in this series:
  * Suppress unnecessary checkpatch warning in a comment
  * Add parentheses around sizeof for clarity
  * Remove redundant blank line

---

Vivek Yadav (3):
  kselftest/arm64: Remove extra blank line
  kselftest/arm64: Supress warning and improve readability
  kselftest/arm64: Add parentheses around sizeof for clarity

 tools/testing/selftests/arm64/abi/hwcap.c       | 1 -
 tools/testing/selftests/arm64/bti/assembler.h   | 1 -
 tools/testing/selftests/arm64/fp/fp-ptrace.c    | 1 -
 tools/testing/selftests/arm64/fp/fp-stress.c    | 4 ++--
 tools/testing/selftests/arm64/fp/sve-ptrace.c   | 2 +-
 tools/testing/selftests/arm64/fp/vec-syscfg.c   | 1 -
 tools/testing/selftests/arm64/fp/zt-ptrace.c    | 1 -
 tools/testing/selftests/arm64/gcs/gcs-locking.c | 1 -
 8 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.25.1


