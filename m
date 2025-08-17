Return-Path: <linux-kselftest+bounces-39161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EB3B291A2
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 07:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BEF1B240A9
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 05:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A5F18A6DB;
	Sun, 17 Aug 2025 05:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1cG1SVM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27AB3AC22;
	Sun, 17 Aug 2025 05:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755408364; cv=none; b=rc5UZWCNEcaG5HKUn0vzdRoUhRDgkxDCWStmN05W0D7Rkkpw99+nRjiRjFDk1M70pWIXTek53Fi8ijJbYzy7ZrVRi7g1giRIsy0BEWjb5wKLSSEtOVc2XHzOPu/sV080ysrCmpUPdhoU3lx3ydWiP0Nbyx6TS3+AlD7hBwZH/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755408364; c=relaxed/simple;
	bh=2Krz1q4dLXwXDvNiRnwBsAnhUvKZtc4rAuQ9af6bRPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NlbuCPQxnUUcmfxeT2GyIfR5t3NhOH4IzVJHz6kp0LYGEcJ1k751LRZPPF7g9WQmALyHc6bKqC1RDsjpcUPDniSekGwQ1YbWg53H4H+rNLWB6byP6s1yUV9Ms0D8szvLjLYg9mXmzLhGZZcCyyp9vD5OQ73itY2nB1hdyhfUm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1cG1SVM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24458317464so33212535ad.3;
        Sat, 16 Aug 2025 22:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755408362; x=1756013162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kp6ZpPi7OjGlmUly9kUQqc77MGv9H1CyM6s09oVZLEQ=;
        b=a1cG1SVMMa8yRxuNjjDTsWj8J5gZ/PcI+4QW++XULVqvUhRk5SGhSv2mbnr8DU0zds
         XlTw/mQbbg01tMDwp/AO4ItFq6K58NnRw6i5MkWbTE9atICidO9Z9hXt7SDHoede/6TH
         e7uFQsukYPk3kw6XHaK/vGqT9T/8toJU0fJYI0cKZPbaYkBS4Kh+KQ5sUOcRXgCKS9pb
         RXweP+B/bDvfKu+fTLI8fVjJ86cCBURrt0ywXPJ9QszuMhAlTTPdlgJQyJ2MGs5p3UKt
         cEDJhEWrCG5alSKHYoLjLkNPrcfTdY/RNhizCGK1G65HP6x2pBKahAs1IP7NDemVFBoo
         16tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755408362; x=1756013162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kp6ZpPi7OjGlmUly9kUQqc77MGv9H1CyM6s09oVZLEQ=;
        b=hAP82qnS85TlMe6gxXBTR+JKEoehlUXTISmI+sIbz6bjxhOpMFuvfXC4F4MLb6sc/0
         tH0q4bC0Ul3B0b3qoU9MUiPaHyUGpwbqHaflZOLk4zmwaSOL2UmZUGKq/KtMcZFuwpwh
         NINN+S9R/rIQhvPnx81B0PaxEx0x8sONEJytpp2Ev9Zm2nSKbqp0CrktX0oBLUSH020k
         uHH8d4oYUSk7Yc6HXOKH2TEsPKxZ8Wcz6Jb1/6oIjYD23PT4GEbAocGSU0nZeInzZHL3
         eWYLCJaNCwp1YzYf/bZ+BM3bjOkJZT9MgdAjyLOHivjTewcZCerVrsPunXjFNNmv2Nq5
         5vlw==
X-Forwarded-Encrypted: i=1; AJvYcCVAaFhU/wuOlycU4aMLjMIYcjc7Ef3GvFStAtiZQUegQXdShDgs5e3ZU7BIj4mcPNlfMznIW/8hNIZUOcVJxwHr@vger.kernel.org, AJvYcCW6Gjr1ULLJgyV58a43wq2FgelJ6pO95JHKLLtUbJiGDxGU4n4VwowyDhht2Cvr7XX/MT+o05djL8SBQqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdJEOH5c5AEyBiOEIsYz892qM0pd8N37C9pQV43ZoapHlOqzyo
	L6xJttGuYAu1FmJhe32t0PEh6jSB5M3nJ3iA7+IcSDkjh39skKeUDVdFAUM5PQ==
X-Gm-Gg: ASbGncsHXlEko5vdyDe8i6PeLpW2GCjJnQ+Zpy4in4LAtsnUYIAqvLTdOk9RobdiMyt
	xcPrDqrEiehvSrUNTmgrYJltgyRunn2uBa39XSzcS3Wejxh1J3PrOWyuvuH6iGHAqn+oPQS1iAa
	zeDOLkueGUQxyA9K2Wo0SjbtvbqQq9ujwhQmeBCNckT/OjueU2g/OLygvycpiR4s0Uvi0GIVimM
	DQMAHJSKp90bWfsrOxy0TW3bUTBQO/fpK9ArWqB6tvK9x7wiSm7xyyTvWF1j9aUfMcz53wQ+/Xq
	xVFuOhEDo3vdxB1cDU6IJWtJA+Okby2ft0IReGW9l1IJ3SRahSaxP84daHaJ7+VCg/SvitQPQf6
	nwCFtAccFcSJKy+fFpKoILbL4j20FQEwnUTx+jZUKkg1ag4JhrCZe
X-Google-Smtp-Source: AGHT+IEDD3XccFyEsxtRe90uLGhRTo1HmJxVWG7SGM+BdhEiUeHqecNwyLTeQDCPVc4fwXs76xqGrg==
X-Received: by 2002:a17:903:228a:b0:242:ff89:d724 with SMTP id d9443c01a7336-2446d9053f8mr116183995ad.47.1755408362290;
        Sat, 16 Aug 2025 22:26:02 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:ad1b:5a79:43f0:e247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d592448sm47417625ad.161.2025.08.16.22.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 22:26:01 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH 0/3] kselftest/arm64: Cleanups and readability fixes
Date: Sat, 16 Aug 2025 22:25:49 -0700
Message-Id: <20250817052552.8953-1-vivekyadav1207731111@gmail.com>
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


