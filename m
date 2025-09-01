Return-Path: <linux-kselftest+bounces-40397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E90BEB3DB28
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA26189B8C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 07:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD9F26D4CA;
	Mon,  1 Sep 2025 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNBOWLT8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953126B75C;
	Mon,  1 Sep 2025 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712163; cv=none; b=koNcW/jVkXCu8AVeULyIuhYKn06hXoVylpT+4vdR39aE04dXatzMAcgqAZDeyWiJejrdSna3XF1Ax6tuNZ2HgH0iMLtafE1MOdnHWedAefcT6+k548V5wSpU/gisgukzX7Ve/TsfkCmgiTcS4Z5pEOT/kAtF3OHAHwV5cmpB98U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712163; c=relaxed/simple;
	bh=J6zMRZ4XqHFK/EhlYEXT71zKq4ZAuK6GL79gKLwQatU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CGZEKk34xDbJxHeC6DqnDCjwtt/0x86lyBOBNC1khBj3mKANUf4lfQ75rFQ0WFYhCiW0b5yN0GL6ifJA5VzVDblxLeSRx4ZQA5Ge3+LLCWglC4XUkM2tDF1jmQxGETuRK9RH+JbJ3+c8ueR8KAJiyhMcmpPqXLIFZRHngdlqI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNBOWLT8; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-24a1270e0deso11396465ad.1;
        Mon, 01 Sep 2025 00:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756712161; x=1757316961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L0ePC0WzColXkaFbBrk+Z/IecQrL5Wt4AmBIdBx+2Qg=;
        b=YNBOWLT8lalvRn+ngX1hTmgu/u1VmDOHHmK2RkK7NZL1TmMKIAa4ucN+yesWbhaz7d
         uuc066giEtpTKX1+40ulMdSocwCKoYRsTzbIlSeUFfm3gM/t/kmGFHaVsI373tHwo2gd
         iuXb6IrllrAhtcF5Xh+2tLbPO9QMUhkQRTZd+FtZRYWzdBO6jAzC31K6F0Ep8ZCPyFqb
         PurUKveedrTWX8lO8xdFil7wD2ww838tmWSb6IgEISJ1ho9ozTBYDGbTDxtp7OlimPey
         oyDOgM8ECcdwXiTI31VERXf/7PjQ1hYwi6lMRYjtbspsyzd5ueJRKG+wTj0uxsy3ZoL6
         u8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756712161; x=1757316961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0ePC0WzColXkaFbBrk+Z/IecQrL5Wt4AmBIdBx+2Qg=;
        b=w6gfZ5Ke50pfmC9jyGm4ANSgD03IXNwUXK7QiyU5oH1CHFsrULTRd6Gfd1+FN2ygmg
         xXUyYpynTT19xhHu+MMFEGsYg/xSFJpnP8CG1/6tJ+OFGJs6ohCBE6npBVFppSqrKadu
         u1Gg7XsYhg6BoKbRMfu9uZLJiwKThVfo260aFWKkJ85GbXb+7SvANfWpg+1gdk3Kz04n
         JCN5x6yc+g36Urc+ip5x11uE+Tht8ZtNp5dop51lnQ+bjV65FlRiYZBSO4pswbw4U3ks
         wqfg8FSleBMUoMdLtxld31vc9yqvkb7yItQxrmj8b1Om7ljswZwwkgwlxFN2eMS2Djio
         HOpw==
X-Forwarded-Encrypted: i=1; AJvYcCU8eud5ZoY6wZyrEyttyMYgZGjcrzZpdVxbnYm6j6zt5BbLfqBsRueBqbXKPxqFbrVm7Gk=@vger.kernel.org, AJvYcCUez+OVMTA6po98A/8b01mJRYBO4iRsP5dQamGCiAhrM17np5hvERWn5Jish32kiNaJ2nvxbGZG7deEO4uvlmBV@vger.kernel.org, AJvYcCXgOi9EVzGGJ0MW/CR0MfEohAQgaSzfOncD1O7fAbkvbIn1TZzrgulEcHJBrC8KjmD5u+PNLrT//vt9buuW@vger.kernel.org
X-Gm-Message-State: AOJu0YwzoyWwZyy5OYfpZmn8pE0EWEYHaCHy0SscXJc2jpBeEfRFFcPs
	f1YFso3Y+l0qWTMjle18/qY71IKWO32NplIwGcX/b8Qmomq3mYQkb7R5
X-Gm-Gg: ASbGncuqOPKz8M/QzznbtxvCPsRV/CczX4i54CnOdyoKHekjUKSgj82P69NSGD3XAlQ
	FmMeHCBVlfv/8HXF1pSl33jaiFhj0edBENpoeaPZw5RSh/FkNI4b476wOtN4QWYOMJKGzB5tSNu
	RJXDkgzMyXissLCYBzYQhFezg3UxydqltXZrW6V51uYBFAPngV9f4ue+SS5YnBdHpPZjNRyjoLZ
	+3qCl7uKUXblVzIAperbZmnC6QsxoNCBLdlyHFcK0OMNcJ6aiPku+QNABd1dHpCVZE/o0l2GDxe
	fTVE5b55xe4apo2TBZFZbY241Rvd1sKMwGEWkZTIzFecfZLkeBvdVKHXNPR5XPxaIpuInAqkuAG
	l47qU36OJtvh6niRPEGrH9g2Msj4rqVU=
X-Google-Smtp-Source: AGHT+IHCC7OUu97GWMAOQYi+hndVB3qfPEyGEt/pCflpkaED9w8c03pQ0ntMhKZbeOTUw6gDQtgfvw==
X-Received: by 2002:a17:903:2c06:b0:246:cfc5:1b61 with SMTP id d9443c01a7336-24944b15b97mr87894275ad.55.1756712161144;
        Mon, 01 Sep 2025 00:36:01 -0700 (PDT)
Received: from days-ASUSLaptop.lan ([2406:8dc0:6008:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903737b05sm95867045ad.49.2025.09.01.00.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 00:36:00 -0700 (PDT)
From: dayss1224@gmail.com
To: pbonzini@redhat.com,
	shuah@kernel.org,
	anup@brainfault.org
Cc: atish.patra@linux.dev,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Dong Yang <dayss1224@gmail.com>
Subject: [PATCH v3 0/3] KVM: riscv: selftests: Enable supported test cases
Date: Mon,  1 Sep 2025 15:35:48 +0800
Message-Id: <cover.1756710918.git.dayss1224@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dong Yang <dayss1224@gmail.com>

Add supported KVM test cases and fix the compilation dependencies.
---
Changes in v3:
- Reorder patches to fix build dependencies
- Sort common supported test cases alphabetically
- Move ucall_common.h include from common header to specific source files

Changes in v2:
- Delete some repeat KVM test cases on riscv
- Add missing headers to fix the build for new RISC-V KVM selftests

Dong Yang (1):
  KVM: riscv: selftests: Add missing headers for new testcases

Quan Zhou (2):
  KVM: riscv: selftests: Use the existing RISCV_FENCE macro in
    `rseq-riscv.h`
  KVM: riscv: selftests: Add common supported test cases

 tools/testing/selftests/kvm/Makefile.kvm                    | 6 ++++++
 tools/testing/selftests/kvm/access_tracking_perf_test.c     | 1 +
 tools/testing/selftests/kvm/include/riscv/processor.h       | 1 +
 .../selftests/kvm/memslot_modification_stress_test.c        | 1 +
 tools/testing/selftests/kvm/memslot_perf_test.c             | 1 +
 tools/testing/selftests/rseq/rseq-riscv.h                   | 3 +--
 6 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.34.1


