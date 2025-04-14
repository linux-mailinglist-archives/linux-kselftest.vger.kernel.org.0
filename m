Return-Path: <linux-kselftest+bounces-30672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A23A88078
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A32116A17C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 12:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598392BEC59;
	Mon, 14 Apr 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nasWIn7E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0140F190057
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634159; cv=none; b=JDC/DEo1WHeNQieY8v8g/NHgxQOiZ9AszXSUIri+PdYDgU3YZdna5LhNuLoZj2W0aYvKWDbf01JlPzbPNYQt1g0rB8qmG6Kqz565eOJ0zKpwJ/UN0FcnVkcUHBBzugiB2SjWJ4M349MPImqSZQeh86Dsq7LZS5QRZ8PZj6N0+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634159; c=relaxed/simple;
	bh=2mocTyMZccQWl6hqt2SiR6urZCNyzBGg08Agjt8O9rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dMdMBehCa20SB8c+5DcWb9ptHwI6VWr9t1nFOT0rSaoGzjBiB5ui2U7gJB5F4DieRjQua+E0Kk7vbLCbAkalp0+qNl/J7kM6CTRhf59tOJ6DGeRZDSyRBSWIR/mmIi6C39vHI7qTyFETrXb53Ge5uDCPSlqqCm8qlxA4PSRe4gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nasWIn7E; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so44167525e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 05:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744634153; x=1745238953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WQmio3wqLQnFz3mNwa+nQ7W5ScqINI2CxtaTzG1u6QU=;
        b=nasWIn7EGt5/MBjrKgbeLE+0Acn/uqcYzqxhewurgrw8Lor1bsor/mS9Owd7yYJOT4
         XfQd84eOjHJb/Ycvj5Dew0EZZ7SlO+sqF26ym+J45dZ2eN2jQdboOYeUIhG7hOjAUFtG
         KaQAi/gRVZAjgy5HKEWj/gA96KPuZi2xWl/JbFanbSMPZ+vyRrWthrduBybk3+ReNLQI
         HntP5zT5pHwIUZzDeI9Dmb/NPgbLWLGmmstmGp5pGxXlbgWutVqVSCpZl8YY1yAd7ox+
         zBeOaLGi+6iIEi/PT0xIp/JnmsvKFzYEYdK9WR7qqtcvTlc8iKtN+tIJga8G2b+/MonG
         zUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744634153; x=1745238953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQmio3wqLQnFz3mNwa+nQ7W5ScqINI2CxtaTzG1u6QU=;
        b=ucajLYQjSfHSi7fiSrcNxcsFzi5K5tznOB1fh0a1HjlPoCxhxgJj/+SFsYbN0gR0i7
         PqKG+MEpa1+eQAIuHXDkGj+efZ5ZmGYVz/1kz8rjrGkhuI+C6Doree4keN8z82l/NtS/
         /5QiOQGfB4EN5nIpWfTvF36CWVH5FOChHJhQpRqC3uSq4fktRjpdVQVnmmF2x0l1Zze/
         jWYS86MnlXJ/ReTKOXzQ8wR8ooEMayzfyQbskqE8LvDS1CmdCqZmKBYdOZ5b3WK2QHRI
         sK3IAEoNGDjBXw6XMmGowjB1j4MMjNx61cD2niJpioxE564rWwPPngwyz9SAUNdt621e
         djhA==
X-Forwarded-Encrypted: i=1; AJvYcCX9koGoOkMJz83aEaC22TTaaNRcqqvQKEDuawMY2chNzwbx6Vpld6DgmIkhkA5/xLZdwLG4S9yJPPswcUIdkRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypVAiTdu8noFYmx5/VgDtfCU70Rnfw/xSzH9Ufm8FhzeF4o+xm
	smzBGkF14pfhurXWvRz5RZAlCYnXfN82/nPmDgsWU2V0K4vjc3bqN5omHMc8WDc8RDXDuBe6ISm
	t
X-Gm-Gg: ASbGncseeDq7Q67c2MhkWCn0P2X+BYWdw3Hy3DrW5n8PmXFjH/Ex7dTs0p1xbGWfzwK
	iqlzceSJ6t16l/RHqulis/8/AnisyUx7yQrSLlwzOHtr5zgyyN9qrrVhLgR+RMB9XIkZyWI4eC8
	E2UIRz6VkoJJ+9juECOWxXn/S/yOhlOfpErC0q0vsajFxBQlmDiUcUgfyjmFBpGFOIDj5MrqNvJ
	szEPKKo3O5GbhuPKdUyS7exQ1FDOo6iokhqg79snI7h71F4EKiavgQOlyCJJ7BMh7Cjgs4mmEs1
	37prpgf1DXLu4uSvCyyMWfRPJ8oFJanRnvaUXCf8fg==
X-Google-Smtp-Source: AGHT+IFJJtwFHDUCk/X/IbkfQRGm+JIG/6RFDceYpwEU9uYCKZDnLPKJFVJZ9lYtIGA9fiFwvtiSuQ==
X-Received: by 2002:a05:600c:348a:b0:43d:aed:f7d0 with SMTP id 5b1f17b1804b1-43f3a9be478mr93613435e9.28.1744634153055;
        Mon, 14 Apr 2025 05:35:53 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9780a0sm11003166f8f.50.2025.04.14.05.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 05:35:52 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 0/5] riscv: misaligned: fix interruptible context and add tests
Date: Mon, 14 Apr 2025 14:34:40 +0200
Message-ID: <20250414123543.1615478-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes misaligned access handling when in non interruptible
context by reenabling interrupts when possible. A previous commit
changed raw_copy_from_user() with copy_from_user() which enables page
faulting and thus can sleep. While correct, a warning is now triggered
due to being called in an invalid context (sleeping in
non-interruptible). This series fixes that problem by factorizing
misaligned load/store entry in a single function than reenables
interrupt if the interrupted context had interrupts enabled.
In order for misaligned handling problems to be caught sooner, add a
kselftest for all the currently supported instructions .

Note: these commits were actually part of another larger series for
misaligned request delegation but was split since it isn't directly
required.


Clément Léger (5):
  riscv: misaligned: factorize trap handling
  riscv: misaligned: enable IRQs while handling misaligned accesses
  riscv: misaligned: use get_user() instead of __get_user()
  Documentation/sysctl: add riscv to unaligned-trap supported archs
  selftests: riscv: add misaligned access testing

 Documentation/admin-guide/sysctl/kernel.rst   |   4 +-
 arch/riscv/kernel/traps.c                     |  57 ++--
 arch/riscv/kernel/traps_misaligned.c          |   2 +-
 .../selftests/riscv/misaligned/.gitignore     |   1 +
 .../selftests/riscv/misaligned/Makefile       |  12 +
 .../selftests/riscv/misaligned/common.S       |  33 +++
 .../testing/selftests/riscv/misaligned/fpu.S  | 180 +++++++++++++
 tools/testing/selftests/riscv/misaligned/gp.S | 103 +++++++
 .../selftests/riscv/misaligned/misaligned.c   | 254 ++++++++++++++++++
 9 files changed, 614 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/misaligned/.gitignore
 create mode 100644 tools/testing/selftests/riscv/misaligned/Makefile
 create mode 100644 tools/testing/selftests/riscv/misaligned/common.S
 create mode 100644 tools/testing/selftests/riscv/misaligned/fpu.S
 create mode 100644 tools/testing/selftests/riscv/misaligned/gp.S
 create mode 100644 tools/testing/selftests/riscv/misaligned/misaligned.c

-- 
2.49.0


