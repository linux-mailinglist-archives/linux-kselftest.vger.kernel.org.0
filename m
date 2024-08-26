Return-Path: <linux-kselftest+bounces-16317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CEE95F6B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B2F1F2275D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48991194C71;
	Mon, 26 Aug 2024 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="A7tZUWbZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A69194AE2
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690216; cv=none; b=pjMwA6oodSerbxahldsq7jyav29Of3xk+2t5cC1lnXaQ1vB59hiVkIrBrQUjT/8IcPlP+c/rYHl78nTPEvUny9MQBUAjzhhUfMxe41NDYk3dhkwR7NLusYTe6Zf/txL+pVinybPdz0GoRb0N7xy3CcTwY1jecxQojbV9QsK5r78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690216; c=relaxed/simple;
	bh=Ggjt/PK8ZO1KdyZKks/DPga8mkjKTc2hpGQom8saAb4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BJxSkGvJ7mTBIBnDJCCs94Js4BzWhoGUNvAc6wjvRW/qNHkh58T8fLSesVSERd9B507HXjD5eicqF1JFiNkH7X+Ge82WOijwvsHbNYy+4iIfBCYyT89J+NLXdktwscxmMGrxVzG4oVj+ZbafgsonsuPpnIqJCNSW/4WJ+lr2tw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=A7tZUWbZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7106cf5771bso3633450b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724690214; x=1725295014; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XzJj8pzBdC/SjkNgCg+eFusMGgeO5OB+75LPuxAheKY=;
        b=A7tZUWbZUnyjaIU4EGAohTjqDSdXGZVqKX6eb1n0SF5vo/5SLp2kWBx8FW7aNTgGxY
         3X9P7EXto7FkdocL4L/aRxdNnrVxMToU94+cKwmDkhwQli1lWNRGzfOANAAk+mYJjuED
         1Nyw4sk4NSnS7sU/kxTtR3QeMVSlcDzKi+THNsWN9zidsr3ZAIig3DN/bjf37kYRBFrY
         PD4+10qVFUsyHJr8iljLRMYx00id/iKEeb1dyhbi3esRZISZ9dOgTbOuY9ZnyL3wBRbO
         PfXUIxG63n4xuCjK6KdeVUYFB6CeaOs+1qlz9FFS2RD0F/yMv9cRoYx9Lrr+Z3s7qpcB
         Zl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690214; x=1725295014;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzJj8pzBdC/SjkNgCg+eFusMGgeO5OB+75LPuxAheKY=;
        b=C2we5I5QwLhqz5Feq6GDehyq3wP88BGqsLZwcBDCAsr6qQnzmq7WRtPq/6f5k6+ChE
         /eSoKBppQz+xDiV6QW9HoWDTEClBfC+ZgteAirHDyQgtRzu7N1G6ug2iWHdLQfBbIlbU
         PfAUQg9wKIjPJr2b3WSsr5z/qpo/MrpvsuoWiyYvmVzrHSNC4az9aJcVrF1tdyTC0c9A
         rw3S5MwwtOOCJucxXWXrC/v5DAf+13+rwBr09NC+zfkmF3+w2m7+jZ/laIs3fvps9vis
         Ei95Fh+JdLqyHIMrQ+eJ8Ob9XEN6GF2C6nlCnqsfyUl+j1Idi16nIfe4VYdNzhBEbDny
         TA7w==
X-Forwarded-Encrypted: i=1; AJvYcCU4WXgQSlPd16F550pBkYGc3RJI1xiRDnyAiXPAg7R2/BpSraqpqrSdcKmVtMxG0wkOBHJoVPzdKAFkJa/HptM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVB84DPK/wdqgUe95Hotc7Kl+FFOoElag+xdnYyji1l5mEL41f
	Fjpt2tu1dc3LMDNv3HD354j1zImv5yKra2dfPR6RzNkZ1K7l/fSevd3L/s7Z22c=
X-Google-Smtp-Source: AGHT+IEhhlwfKu+qrTkve0/BmPBWlOtzw1R6AUtvBmtz1f6WqoPjaogV9GfYZT3VAsdVTB8oqC9zcA==
X-Received: by 2002:a05:6a21:1584:b0:1c6:fc4e:e4ca with SMTP id adf61e73a8af0-1cc8a268142mr10196588637.47.1724690213501;
        Mon, 26 Aug 2024 09:36:53 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143434052dsm7174708b3a.217.2024.08.26.09.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:36:52 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/3] riscv: mm: Do not restrict mmap address based on hint
Date: Mon, 26 Aug 2024 09:36:44 -0700
Message-Id: <20240826-riscv_mmap-v1-0-cd8962afe47f@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAByvzGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyMD3aLM4uSy+NzcxAJdA1PT1LQUI+M0Q8tkJaCGgqLUtMwKsGHRsbW
 1ACMCc6hcAAAA
To: Jonathan Corbet <corbet@lwn.net>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Shuah Khan <shuah@kernel.org>, Yangyu Chen <cyy@cyyself.name>, 
 Levi Zim <rsworktech@outlook.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=Ggjt/PK8ZO1KdyZKks/DPga8mkjKTc2hpGQom8saAb4=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9qZ9bJn1kYurJt9sPFIkVbf8aYlF/gv+z8qKVxUu/jzd
 55zGU0lHaUsDGIcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAEykKZzhf8qODI2UOd4br+q6
 KG81cMv9HxRemBLzcrrfzp5uJ5WcZob/ldOX7r8f4GB2olQ9arpc/sQ6tp6gpnXpU9fu9NlXbPi
 AEwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

There have been a couple of reports that using the hint address to
restrict the address returned by mmap hint address has caused issues in
applications. A different solution for restricting addresses returned by
mmap is necessary to avoid breakages.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (3):
      Revert "RISC-V: mm: Document mmap changes"
      riscv: selftests: Remove mmap hint address checks
      riscv: mm: Do not restrict mmap address based on hint

 Documentation/arch/riscv/vm-layout.rst           | 16 ------
 arch/riscv/include/asm/processor.h               | 26 +--------
 tools/testing/selftests/riscv/mm/mmap_bottomup.c |  2 -
 tools/testing/selftests/riscv/mm/mmap_default.c  |  2 -
 tools/testing/selftests/riscv/mm/mmap_test.h     | 67 ------------------------
 5 files changed, 2 insertions(+), 111 deletions(-)
---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240820-riscv_mmap-055efd23f19c
-- 
- Charlie


