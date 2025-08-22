Return-Path: <linux-kselftest+bounces-39704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A65EB321AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 19:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10201BA426A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 17:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED9D27AC48;
	Fri, 22 Aug 2025 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="gnyQ+SEB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B871244670
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884841; cv=none; b=E6ssYsMi6nP/7u63lqQi3FpTNh5t1zrvdeQRPqNO61okN2vmNgWbQf/YCqyo5SzQC17bZDU7/q8s/11/CjoqF1qYz/CAoQpPuEQVKl1tW0+IVEMGIeKzIT04Av4X8q5IrC0ehO9IqZwqGNiBGg+sL+rSDt/dZwg/84xRt/sSn8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884841; c=relaxed/simple;
	bh=UgFHRDjkDkg06sIoVrJh/as+4V75o1if/J/a4MOlfQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PuNF93YOJOBmW3Y6p2BmLNaQBhHsQg/CepZtBKPCWrQn4AsZYyKCsGyF4znRv+8mlxbCiQ47gpn44Ajv5AK1HbkuX5o+U/M77gnoFA7njT4+VlEihKD0GGc01LzS0dB6Y8IcAnLhQIC60rGLiWOmyOvi53s+3Y6sAnbbZEzpp5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=gnyQ+SEB; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b297962b20so21364841cf.2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755884838; x=1756489638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7xWd683exLd05Xd2k+2/c9D8N3YKjun132TYqkPk7vQ=;
        b=gnyQ+SEBSGjqtQfjPpLg+SSoyjTrq/CKSxCHUcvhwICLIzG7SES4SSl7C+9QWRcGws
         A1GtTYyEv8Ri7XvBIdnEp7cHSUZIO2kibTiBhFn6arMCWiTdauBfMBHx8Let3ZznE0+V
         v9sjsZJpHlysvs9CHVvoJIaFQoKmZpy52BXrln6jE0pJjaQMcQrNOC0t/GrbiT2p//KX
         aWC8pKVqckivW9OsuZZS9I+YjgYU2Tm/YTkFcBI6r1WQRWcll2KWfNtouHAUU/AdVgTe
         WqkaGhIi/bFof7uZDAl6MbhbUP+P7k9ypKYJCGriKDmbv4Lq/JutyFdr9qroTWyhNeq2
         nNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755884838; x=1756489638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xWd683exLd05Xd2k+2/c9D8N3YKjun132TYqkPk7vQ=;
        b=DFGk/y0vP+edVMyXfH+I4/v3gZX2+GGypZg80cIaAN7BaoT74He5A1o9O+/py/XuiX
         08tT/N8JzDSe5TbzU8x8KbS0jZ5D0giNLVCfX1vhgjiwjNNd07amVhkDe8PvxQB6MNXV
         CW957S9skJVGVNJx220EudDTOzGHP7N6DM6jzjwccSvsQo3Ww/0vGtsj9BcsHSPB6r/j
         IsVLYBth3tYZU8mnKDzr57l2NhtsKGfTzGH2RCVNRl7XvRKsi0A3HPbJKHbYnp2OrnPE
         uWPmDsIpsEL6aeo0kaVaICrTOjIkETIuLptNfDs05gnPik1JpjB1vmswdteow3jf1lrg
         il/A==
X-Forwarded-Encrypted: i=1; AJvYcCXVHE9GCSZTLxx2FSvHVi179Ofek6vPDZlM7m425rvYYURkhBZZR4j73GK8etOQnLteT1BiqVGIUu8e6pGYwuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySNNj6ZgXaDY9QteqxWc4J0Uwfe8XQa2U7iJ9Ksy01lfNYQ3fT
	L2FPbwWLG2JRQy4fE1EnPST1Z1pswy5ZoXTqMcidokn+QiNXylsGEgjL5q82G/xKS24=
X-Gm-Gg: ASbGncuEXDs2TJB7x/+/yY6W5D1U4SzL0x1F3s3gkFgeLNJiZSRhGXFPqFqqF2t3VuL
	NsQpbtFkwyyJ8RuHsbFBiQY/sz14uwGHs3QRicNfK/yOcPD5ilKqZF1mtEQcWKAckYGaI6ZXvTh
	4Nt6JEC5+UHF80JyLPunBPZk8ZKclQJx0MWJfYe3Ki2wGUqF0ZzjWptho9crPHCiDVsKi5hAPf+
	DdLyqgmEwHvZNHZ4DV7iixf9Zqb99KtEUYrIJ4/cptGKwOQDrSE891iZ30Xg3/H6JfXlXl0r1l0
	FpE5BpRt6eXbP6vTnWwLdrv2cC3rFQv4CrIWHOrt/cOpqgZ20YLdzJZmgjnEniHEkTX6CCFOKCY
	R1Y8XBTbqCSFWwA0nwEjS6sOuRgHQljAUrLoKD2gQjYdY1k7EtONGxq6tdkXKjHCpn1W4wtUdDB
	BqNxoAP1nULDRGh7qJ
X-Google-Smtp-Source: AGHT+IERB8md7pMPxdX8kJ5ivrUWSgGAVukLkHuaDgpDlvNNBoFxuibBgYX+uodyqeWSfvVnl+l5kA==
X-Received: by 2002:a05:622a:1885:b0:4b2:8ac5:2586 with SMTP id d75a77b69052e-4b2aab78821mr43353651cf.77.1755884838018;
        Fri, 22 Aug 2025 10:47:18 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e6023asm3121361cf.53.2025.08.22.10.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:47:17 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Evan Green <evan@rivosinc.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Nylon Chen <nylon.chen@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH 0/8] riscv: add initial support for hardware breakpoints
Date: Fri, 22 Aug 2025 10:47:07 -0700
Message-ID: <20250822174715.1269138-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds initial support for hardware breakpoints and
watchpoints to the  RISC-V architecture. The framework is built on
top of perf subsystem and SBI debug trigger extension.

Currently following features are not supported and are in works:
 - icount for single stepping
 - Virtualization of debug triggers
 - kernel space debug triggers

The SBI debug trigger extension can be found at:
https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-debug-triggers.adoc

The Sdtrig ISA is part of RISC-V debug specification which can be
found at:
https://github.com/riscv/riscv-debug-spec

based off the original RFC by Himanshu Chauhan here:
https://lore.kernel.org/lkml/20240222125059.13331-1-hchauhan@ventanamicro.com/

Second RFC by Jesse Taube here:
https://lore.kernel.org/lkml/20250722173829.984082-1-jesse@rivosinc.com/

Himanshu Chauhan (2):
  riscv: Add SBI debug trigger extension and function ids
  riscv: Introduce support for hardware break/watchpoints

Jesse Taube (6):
  riscv: Add insn.c, consolidate instruction decoding
  riscv: insn: Add get_insn_nofault
  riscv: hw_breakpoint: Use icount for single stepping
  riscv: ptrace: Add hw breakpoint support
  riscv: ptrace: Add hw breakpoint regset
  selftests: riscv: Add test for hardware breakpoints

 arch/riscv/Kconfig                            |   2 +
 arch/riscv/include/asm/bug.h                  |  12 -
 arch/riscv/include/asm/hw_breakpoint.h        |  59 ++
 arch/riscv/include/asm/insn.h                 | 132 ++-
 arch/riscv/include/asm/kdebug.h               |   3 +-
 arch/riscv/include/asm/processor.h            |   4 +
 arch/riscv/include/asm/sbi.h                  |  33 +-
 arch/riscv/include/uapi/asm/ptrace.h          |   9 +
 arch/riscv/kernel/Makefile                    |   2 +
 arch/riscv/kernel/hw_breakpoint.c             | 763 ++++++++++++++++++
 arch/riscv/kernel/insn.c                      | 165 ++++
 arch/riscv/kernel/kgdb.c                      | 102 +--
 arch/riscv/kernel/probes/kprobes.c            |   1 +
 arch/riscv/kernel/process.c                   |   4 +
 arch/riscv/kernel/ptrace.c                    | 169 ++++
 arch/riscv/kernel/traps.c                     |  11 +-
 arch/riscv/kernel/traps_misaligned.c          |  93 +--
 include/uapi/linux/elf.h                      |   2 +
 tools/include/uapi/linux/elf.h                |   1 +
 tools/perf/tests/tests.h                      |   3 +-
 tools/testing/selftests/riscv/Makefile        |   2 +-
 .../selftests/riscv/breakpoints/.gitignore    |   1 +
 .../selftests/riscv/breakpoints/Makefile      |  13 +
 .../riscv/breakpoints/breakpoint_test.c       | 246 ++++++
 24 files changed, 1641 insertions(+), 191 deletions(-)
 create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
 create mode 100644 arch/riscv/kernel/hw_breakpoint.c
 create mode 100644 arch/riscv/kernel/insn.c
 create mode 100644 tools/testing/selftests/riscv/breakpoints/.gitignore
 create mode 100644 tools/testing/selftests/riscv/breakpoints/Makefile
 create mode 100644 tools/testing/selftests/riscv/breakpoints/breakpoint_test.c

-- 
2.43.0


