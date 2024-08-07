Return-Path: <linux-kselftest+bounces-14896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6521B949CC9
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 02:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D201C22136
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 00:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CABA1DFCF;
	Wed,  7 Aug 2024 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e+cXRFb/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A9E46BF
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Aug 2024 00:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722990707; cv=none; b=fRbCUxlOxYlrGrrABdkm7GPjbu6wLCFLHt17Gnt/dL7v9ow9URSjKZr7f87xOO8kWBYBeTYr4zG1hml1r+7MX+i2R4q+MxxXYQHLpPy6ua74S58JU+MyfxcwfMFMjh3kZNIn7Rfv1S0HQOM5PvXDDdYRSGEalhKnXee+2ln1wjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722990707; c=relaxed/simple;
	bh=hacy5mno4SE477aLGkms4pcURrshsIYaghRvD/Vlia0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HntMXdNs/5N2kDS39+j5QYAedl07zscVRJm11ATr0fqkW2TjRxkzWoQ6tQNNCd0l6jywYNGJIjNigsd8DE91vCHSIaSpzgzU+hTYjKLyzp+s5A/fQ/uygSGIeWmMyiGJQcKFYoEqpF/u19SYITlwcBTaEiq+tp2M/fEps7cgl9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e+cXRFb/; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39641271f2aso4142825ab.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Aug 2024 17:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722990704; x=1723595504; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qmFKXoGZwfZnYgj1DayB62f8TZphYzJ75TSkCe5doRI=;
        b=e+cXRFb/YrWWLjN7GaQXB3mWK/C5389WVlrhRBbEbANoX/oVg8SoMJj3NpgmS3MhAy
         7x+8WzGyCCPFKFNSQGdL+EZLnkH0RgaTG9wQkwLRNJicBnQwKEHiKC0i9zl0Ez1Z3IhM
         I70+TgGJMdkhxiy+WVh406lbsohT7v6rBxgAXm4/L9Mju3tX7a4zxFrdjspNZQTXj9K0
         fmKq0nAAqvMwkbKZG+150SPk8hT+xjado7osER9Os/dLyZzL/NMnEmx/XCPl1g5yIRUy
         HFEt2FPRW9BK/nnNgucZMaV91ed/D8WNZl3ePsCK9cMOFoz09hATWWeLnYXCSAIlOdrV
         jDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722990704; x=1723595504;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmFKXoGZwfZnYgj1DayB62f8TZphYzJ75TSkCe5doRI=;
        b=HpfYMlNcqSGppVJ9hovXulgvcw4OxgKE2MvmR9+/vVs9daD7D48QLLB6LSvfw9HI3O
         2NaKfr4brLdZjIOONSMFE8uehyc0K/l5/hvnSMsI0m792pm4FGAoNu0OuJjfpYNeX7iR
         XmEKLeUa8el46MUbgD5V+qKgGD5fJSAmFM6g0AyzBJI2mu2wl7Qft271E0xlgi5q0SqL
         +nSicX7O4vgCCrzQk0iQRgF0q5CzQzwWwsN1Zlldb5OzQXU2eIc2/4Csi9jmRPBli/9i
         t7OWnl962JxHS0LJYnAv3zPuwPavyyvdjmOEmi00QWCe7WgHd/w5g2YmYGpOFAsbhZEs
         dqDw==
X-Forwarded-Encrypted: i=1; AJvYcCWfihb18njR9xw6PWbLhCNUEoe4o7z4xsT5i+w8p7quaWukWwIf0gP2ylSGLlFxVlmaAr5/4VCegzgTXU08exc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvP3woWGv9fwk6GF7Ked7pPsbnHhxt5d0kLA9sFmISOKv4cJe
	L+VsK+PL3Z6R3E00ZMZFWoq8Jbe0eEPLTmqn9H3kXNp0OZRSiqnfyqYuDBSYMFA=
X-Google-Smtp-Source: AGHT+IGwwyszG0CNT0JAFMndi0eaSYc/oFh0VHN9tlAF+a5IcvBOCM39f9Fn28nQRfIlK5+QN9fOxw==
X-Received: by 2002:a05:6e02:1d95:b0:380:f340:ad66 with SMTP id e9e14a558f8ab-39b1fc1348dmr227275905ab.26.1722990703557;
        Tue, 06 Aug 2024 17:31:43 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f5aasm7476174a12.6.2024.08.06.17.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 17:31:42 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v9 00/13] riscv: Add support for xtheadvector
Date: Tue, 06 Aug 2024 17:31:36 -0700
Message-Id: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGjAsmYC/33Qu07EMBAF0F9ZuSZoxuMnFf+BKPwkLtigZGUtW
 uXfcZaCYCLKsXzu9fjGljSXtLCn043NqZalTOc22IcTC6M7v6WhxDYzDlyAJBiulzG5WFO4TPN
 giCJF1F5wYo18zCmX6z3u5bXNY1natc97esXt9DtIgf0dVHGAgXKSFqPOCPZ5LnVayjk8humdb
 VmV7zx2D6m8eaudMArJRSUOPO1930/N+5zJJm+VMunAix+vgXdeNM99azYcokc88HLn//TL5oU
 XRuago5T5wKud532/aj5YlwEJsgM48HrvRef1tr8WaBFcdHS0v/nPm60/gyBsn4ekO7+u6xcBr
 rZ2awIAAA==
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722990701; l=7570;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=hacy5mno4SE477aLGkms4pcURrshsIYaghRvD/Vlia0=;
 b=mmnaEmpUee/f4Zf0LA0h354GYefY/89ORkPfp6B4DMo6T3hYWyAIF/pw7KmSeXh5yT8xKbSbV
 8QG+nKQVY5MD8/770ix9gLM9OCS/0STHcw/61Gavj1L9vA8AG6oE7Q6
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

xtheadvector is a custom extension that is based upon riscv vector
version 0.7.1 [1]. All of the vector routines have been modified to
support this alternative vector version based upon whether xtheadvector
was determined to be supported at boot.

vlenb is not supported on the existing xtheadvector hardware, so a
devicetree property thead,vlenb is added to provide the vlenb to Linux.

There is a new hwprobe key RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 that is
used to request which thead vendor extensions are supported on the
current platform. This allows future vendors to allocate hwprobe keys
for their vendor.

Support for xtheadvector is also added to the vector kselftests.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

[1] https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc

---
This series is a continuation of a different series that was fragmented
into two other series in an attempt to get part of it merged in the 6.10
merge window. The split-off series did not get merged due to a NAK on
the series that added the generic riscv,vlenb devicetree entry. This
series has converted riscv,vlenb to thead,vlenb to remedy this issue.

The original series is titled "riscv: Support vendor extensions and
xtheadvector" [3].

The series titled "riscv: Extend cpufeature.c to detect vendor
extensions" is still under development and this series is based on that
series! [4]

I have tested this with an Allwinner Nezha board. I ran into issues
booting the board after 6.9-rc1 so I applied these patches to 6.8. There
are a couple of minor merge conflicts that do arrise when doing that, so
please let me know if you have been able to boot this board with a 6.9
kernel. I used SkiffOS [1] to manage building the image, but upgraded
the U-Boot version to Samuel Holland's more up-to-date version [2] and
changed out the device tree used by U-Boot with the device trees that
are present in upstream linux and this series. Thank you Samuel for all
of the work you did to make this task possible.

[1] https://github.com/skiffos/SkiffOS/tree/master/configs/allwinner/nezha
[2] https://github.com/smaeul/u-boot/commit/2e89b706f5c956a70c989cd31665f1429e9a0b48
[3] https://lore.kernel.org/all/20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com/
[4] https://lore.kernel.org/lkml/20240719-support_vendor_extensions-v3-4-0af7587bbec0@rivosinc.com/T/

---
Changes in v9:
- Rebase onto palmer's for-next
- Fix sparse error in arch/riscv/kernel/vendor_extensions/thead.c
- Fix maybe-uninitialized warning in arch/riscv/include/asm/vendor_extensions/vendor_hwprobe.h
- Wrap some long lines
- Link to v8: https://lore.kernel.org/r/20240724-xtheadvector-v8-0-cf043168e137@rivosinc.com

Changes in v8:
- Rebase onto palmer's for-next
- Link to v7: https://lore.kernel.org/r/20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com

Changes in v7:
- Add defs for has_xtheadvector_no_alternatives() and has_xtheadvector()
  when vector disabled. (Palmer)
- Link to v6: https://lore.kernel.org/r/20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com

Changes in v6:
- Fix return type of is_vector_supported()/is_xthead_supported() to be bool
- Link to v5: https://lore.kernel.org/r/20240719-xtheadvector-v5-0-4b485fc7d55f@rivosinc.com

Changes in v5:
- Rebase on for-next
- Link to v4: https://lore.kernel.org/r/20240702-xtheadvector-v4-0-2bad6820db11@rivosinc.com

Changes in v4:
- Replace inline asm with C (Samuel)
- Rename VCSRs to CSRs (Samuel)
- Replace .insn directives with .4byte directives
- Link to v3: https://lore.kernel.org/r/20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com

Changes in v3:
- Add back Heiko's signed-off-by (Conor)
- Mark RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 as a bitmask
- Link to v2: https://lore.kernel.org/r/20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com

Changes in v2:
- Removed extraneous references to "riscv,vlenb" (Jess)
- Moved declaration of "thead,vlenb" into cpus.yaml and added
  restriction that it's only applicable to thead cores (Conor)
- Check CONFIG_RISCV_ISA_XTHEADVECTOR instead of CONFIG_RISCV_ISA_V for
  thead,vlenb (Jess)
- Fix naming of hwprobe variables (Evan)
- Link to v1: https://lore.kernel.org/r/20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com

---
Charlie Jenkins (12):
      dt-bindings: riscv: Add xtheadvector ISA extension description
      dt-bindings: cpus: add a thead vlen register length property
      riscv: dts: allwinner: Add xtheadvector to the D1/D1s devicetree
      riscv: Add thead and xtheadvector as a vendor extension
      riscv: vector: Use vlenb from DT for thead
      riscv: csr: Add CSR encodings for CSR_VXRM/CSR_VXSAT
      riscv: Add xtheadvector instruction definitions
      riscv: vector: Support xtheadvector save/restore
      riscv: hwprobe: Add thead vendor extension probing
      riscv: hwprobe: Document thead vendor extensions and xtheadvector extension
      selftests: riscv: Fix vector tests
      selftests: riscv: Support xtheadvector in vector tests

Heiko Stuebner (1):
      RISC-V: define the elements of the VCSR vector CSR

 Documentation/arch/riscv/hwprobe.rst               |  10 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |  19 ++
 .../devicetree/bindings/riscv/extensions.yaml      |  10 +
 arch/riscv/Kconfig.vendor                          |  26 ++
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi      |   3 +-
 arch/riscv/include/asm/cpufeature.h                |   2 +
 arch/riscv/include/asm/csr.h                       |  15 +
 arch/riscv/include/asm/hwprobe.h                   |   3 +-
 arch/riscv/include/asm/switch_to.h                 |   2 +-
 arch/riscv/include/asm/vector.h                    | 225 +++++++++++----
 arch/riscv/include/asm/vendor_extensions/thead.h   |  42 +++
 .../include/asm/vendor_extensions/thead_hwprobe.h  |  19 ++
 .../include/asm/vendor_extensions/vendor_hwprobe.h |  37 +++
 arch/riscv/include/uapi/asm/hwprobe.h              |   3 +-
 arch/riscv/include/uapi/asm/vendor/thead.h         |   3 +
 arch/riscv/kernel/cpufeature.c                     |  52 +++-
 arch/riscv/kernel/kernel_mode_vector.c             |   8 +-
 arch/riscv/kernel/process.c                        |   4 +-
 arch/riscv/kernel/signal.c                         |   6 +-
 arch/riscv/kernel/sys_hwprobe.c                    |   5 +
 arch/riscv/kernel/vector.c                         |  24 +-
 arch/riscv/kernel/vendor_extensions.c              |  10 +
 arch/riscv/kernel/vendor_extensions/Makefile       |   2 +
 arch/riscv/kernel/vendor_extensions/thead.c        |  18 ++
 .../riscv/kernel/vendor_extensions/thead_hwprobe.c |  19 ++
 tools/testing/selftests/riscv/vector/.gitignore    |   3 +-
 tools/testing/selftests/riscv/vector/Makefile      |  17 +-
 .../selftests/riscv/vector/v_exec_initval_nolibc.c |  94 +++++++
 tools/testing/selftests/riscv/vector/v_helpers.c   |  68 +++++
 tools/testing/selftests/riscv/vector/v_helpers.h   |   8 +
 tools/testing/selftests/riscv/vector/v_initval.c   |  22 ++
 .../selftests/riscv/vector/v_initval_nolibc.c      |  68 -----
 .../selftests/riscv/vector/vstate_exec_nolibc.c    |  20 +-
 .../testing/selftests/riscv/vector/vstate_prctl.c  | 305 +++++++++++++--------
 34 files changed, 901 insertions(+), 271 deletions(-)
---
base-commit: 7c08a2615f149f64fb1bb4660997e152fb3a11a7
change-id: 20240530-xtheadvector-833d3d17b423
-- 
- Charlie


