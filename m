Return-Path: <linux-kselftest+bounces-8074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91888A620D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 06:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90458282D44
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 04:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A0B23767;
	Tue, 16 Apr 2024 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RL8EmbKQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6A621101
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 04:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713240724; cv=none; b=eJG0gU/I/lLVIJ4RgZiKAsicLvOIzKSJmrnKbWT6XWPbq+qG8iVqX/8UzJ7SZdopzCorRdf2p/a0jZbJvwyiuY8XvTDW0LYgvrKhelehYPAod5LgW7fA4XV9H+GbZRzOZ/EC3Gw8u+Dt/5OwvBx3SZW09oJkJmE/E7SMgN4rtYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713240724; c=relaxed/simple;
	bh=J091ek3uYY0JPMkva6Z8nuyIiEJaaeRVIOz/yElPLPM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aSE+/mqTq308J3ICFkty5FX5PO0wwkQbl9ksyYK4BRTWBFS4oRUyJH94xGh1yD06I37msaMekWYYJRVAr979UbCNSLhMxPnessqBfq8AiMYc14BpKd32lghSmx216YMCoP4moInO4+G5x2t4UKMsZH4MTlnJWcsc5gNa3HuVK+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RL8EmbKQ; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c709e5e4f9so1773134b6e.3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 21:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713240721; x=1713845521; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYNBDXKfp2miao3VTddr2+Gj1R+sdvV0F9vIMyZhsVI=;
        b=RL8EmbKQ7onh1zhbJQ57nyXGvUp1Dsb9wtShT+843aExhr1MvyWoYgOSFLfYSrElXc
         4kBBxjDqr6FWUtblqh4DEEPuLy728hwiDP1M1OA2Do7cu9meK+IEm7rq0ccT0/elHsLD
         lvCBCHHfr48KknX0M1forYJ8huiYWrtSQw8ITnGm4mHpurHFbpzdloWITbM7zrLp/5iO
         +7eNv3JqRTDACzpkvWUm4vP1DuRm2mEZuiWigsP1yxxCUTpSIbpcZSdacfRYR7N4yXIA
         OxQenG31WgtzUg0/WdBykOnmMRyFrB7/Z61ojeAxOuAmnO+bmoL0YoiqtHUF+JbZoAwZ
         IVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713240721; x=1713845521;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYNBDXKfp2miao3VTddr2+Gj1R+sdvV0F9vIMyZhsVI=;
        b=Ht/BaTqil8wsM60VfOvy4udk2Fmwza61f+Wlx03Ef6EH/SlBBUU427Ic3hU/JbaiRa
         BjCiBAO89Gu34f1i2vgNhueOGzRdmGa6hMGCmqyRKwwLFosGOsy4L3csZHdchIZLQoBB
         05BbGPFT5x97NOBFYiW19C7g5Qho4nWAzAcTRcC62+sAOlD9AvWFN2BNWKu8aUdHPEUA
         ueJuYWkgMAPSD+LxWzwuBtKTl7oKAcyo5i+zVxsvtFYG1dPkl88WxFLz9pNpUqwnVZKo
         PllogCGH5tQkyF8ofXqFJ3WunNTllr5Wb4soX+qAZDrPzMZu0g4BWQAeXuZdd9IBDnGU
         D46Q==
X-Forwarded-Encrypted: i=1; AJvYcCUW3KDJcBe8B/zlXV3Z0FOw6kpgFVs4cLb233QpcrSp6HkGtTr3c4i/zYwwTM65sVpKlCVZXbWsnPSSU381ShyaeBSGEw9925LZg+pqINRX
X-Gm-Message-State: AOJu0YxWuIBBymcAh7v6RTYCRZLAEww6YnOv5lXwOx28cj3sfuAIhb/u
	6whIeNqqXOWCw3vcSqPsGSYBFE2t7iX49T1ONRPu1psxJr707ms09q/LtZ2YdS0=
X-Google-Smtp-Source: AGHT+IF1lkpczyO5VkMu98cjWQ0XXr1YHQ2GghLC4lfyscz2a22P5OOgtrDeQ+hPsV03LeZpLe9hOA==
X-Received: by 2002:a05:6808:4342:b0:3c3:e0a3:8042 with SMTP id dx2-20020a056808434200b003c3e0a38042mr9969896oib.40.1713240721217;
        Mon, 15 Apr 2024 21:12:01 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z184-20020a6265c1000000b006ed4c430acesm8383149pfb.40.2024.04.15.21.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 21:12:00 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 00/17] riscv: Support vendor extensions and xtheadvector
Date: Mon, 15 Apr 2024 21:11:57 -0700
Message-Id: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI76HWYC/5WNUQrCMBBEryL7baQb02r98h5SQki2dkGbsqlBK
 b27sTfw880M8xZIJEwJLrsFhDInjmMBvd+BH9x4J8WhMOhKm8ogqkBZlUYeTCq9pinKbOeBXLC
 Z/BzFNrZVWLfYe+3MEQOUq0mo5/emuXWFB05l+tmsGX/pn4KMqlLG9e0Za/In01yFc0w8+oOPT
 +jWdf0CTbNLBtsAAAA=
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713240719; l=7271;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=J091ek3uYY0JPMkva6Z8nuyIiEJaaeRVIOz/yElPLPM=;
 b=jtNo9ylE6NCi1ESGRX+iW4qFY7sF9opfbctd6v6yYuE34H2fkm0PVdSrEHaxUNwBKi6/L2LkU
 vqyO4t48+HyA6DYlW4YyZpSs2X5qNoxxiVl5BD5L7R9Dh0YT36WBHLD
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

This patch series ended up much larger than expected, please bear with
me! The goal here is to support vendor extensions, starting at probing
the device tree and ending with reporting to userspace.

The main design objective was to allow vendors to operate independently
of each other. This has been achieved by delegating vendor extensions to
a new struct "hart_isa_vendor" which is a counterpart to "hart_isa".

Each vendor will have their own list of extensions they support. Each
vendor will have a "namespace" to themselves which is set at the key
values of 0x8000 - 0x8080. It is up to the vendor's disgression how they
wish to allocate keys in the range for their vendor extensions.

Reporting to userspace follows a similar story, leveraging the hwprobe
syscall. There is a new hwprobe key RISCV_HWPROBE_KEY_VENDOR_EXT_0 that
is used to request supported vendor extensions. The vendor extension
keys are disambiguated by the vendor associated with the cpumask passed
into hwprobe. The entire 64-bit key space is available to each vendor.

On to the xtheadvector specific code. xtheadvector is a custom extension
that is based upon riscv vector version 0.7.1 [1]. All of the vector
routines have been modified to support this alternative vector version
based upon whether xtheadvector was determined to be supported at boot.
I have tested this with an Allwinner Nezha board. I ran into issues
booting the board on 6.9-rc1 so I applied these patches to 6.8. There
are a couple of minor merge conflicts that do arrise when doing that, so
please let me know if you have been able to boot this board with a 6.9
kernel. I used SkiffOS [2] to manage building the image, but upgraded
the U-Boot version to Samuel Holland's more up-to-date version [3] and
changed out the device tree used by U-Boot with the device trees that
are present in upstream linux and this series. Thank you Samuel for all
of the work you did to make this task possible.

To test the integration, I used the riscv vector kselftests. I modified
the test cases to be able to more easily extend them, and then added a
xtheadvector target that works by calling hwprobe and swapping out the
vector asm if needed.

[1] https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc
[2] https://github.com/skiffos/SkiffOS/tree/master/configs/allwinner/nezha
[3] https://github.com/smaeul/u-boot/commit/2e89b706f5c956a70c989cd31665f1429e9a0b48

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Added commit hash to xtheadvector
- Simplified riscv,isa vector removal fix to not mess with the DT
  riscv,vendorid
- Moved riscv,vendorid parsing into a different patch and cache the
  value to be used by alternative patching
- Reduce riscv,vendorid missing severity to "info"
- Separate vendor extension list to vendor files
- xtheadvector no longer puts v in the elf_hwcap
- Only patch vendor extension if all harts are associated with the same
  vendor. This is the best chance the kernel has for working properly if
  there are multiple vendors.
- Split hwprobe vendor keys out into vendor file
- Add attribution for Heiko's patches
- Link to v1: https://lore.kernel.org/r/20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com

---
Charlie Jenkins (16):
      riscv: cpufeature: Fix thead vector hwcap removal
      dt-bindings: riscv: Add xtheadvector ISA extension description
      dt-bindings: riscv: Add vendorid
      riscv: dts: allwinner: Add xtheadvector to the D1/D1s devicetree
      riscv: Fix extension subset checking
      riscv: Extend cpufeature.c to detect vendor extensions
      riscv: Introduce vendor variants of extension helpers
      riscv: drivers: Convert xandespmu to use the vendor extension framework
      riscv: uaccess: Add alternative for xtheadvector uaccess
      riscv: csr: Add CSR encodings for VCSR_VXRM/VCSR_VXSAT
      riscv: Create xtheadvector file
      riscv: vector: Support xtheadvector save/restore
      riscv: hwprobe: Add vendor extension probing
      riscv: hwprobe: Document vendor extensions and xtheadvector extension
      selftests: riscv: Fix vector tests
      selftests: riscv: Support xtheadvector in vector tests

Heiko Stuebner (1):
      RISC-V: define the elements of the VCSR vector CSR

 Documentation/arch/riscv/hwprobe.rst               |  12 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   5 +
 .../devicetree/bindings/riscv/extensions.yaml      |  10 +
 arch/riscv/Kconfig                                 |   2 +
 arch/riscv/Kconfig.vendor                          |  11 +
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi      |   3 +-
 arch/riscv/errata/sifive/errata.c                  |   2 +
 arch/riscv/errata/thead/errata.c                   |   2 +
 arch/riscv/include/asm/cpufeature.h                | 170 +++++++++---
 arch/riscv/include/asm/csr.h                       |  13 +
 arch/riscv/include/asm/hwcap.h                     |  27 +-
 arch/riscv/include/asm/hwprobe.h                   |   7 +-
 arch/riscv/include/asm/sbi.h                       |   2 +
 arch/riscv/include/asm/switch_to.h                 |   2 +-
 arch/riscv/include/asm/vector.h                    | 246 +++++++++++++----
 arch/riscv/include/asm/vendor_extensions.h         |  18 ++
 arch/riscv/include/asm/xtheadvector.h              |  25 ++
 arch/riscv/include/uapi/asm/hwprobe.h              |  11 +-
 arch/riscv/include/uapi/asm/vendor/thead.h         |   3 +
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/cpu.c                            |  36 ++-
 arch/riscv/kernel/cpufeature.c                     | 204 ++++++++++----
 arch/riscv/kernel/kernel_mode_vector.c             |   8 +-
 arch/riscv/kernel/process.c                        |   4 +-
 arch/riscv/kernel/signal.c                         |   6 +-
 arch/riscv/kernel/sys_hwprobe.c                    |  54 +++-
 arch/riscv/kernel/vector.c                         |  35 ++-
 arch/riscv/kernel/vendor_extensions.c              |  36 +++
 arch/riscv/kernel/vendor_extensions/Makefile       |   4 +
 .../kernel/vendor_extensions/andes_extensions.c    |  13 +
 .../kernel/vendor_extensions/thead_extensions.c    |  13 +
 arch/riscv/lib/uaccess.S                           |   2 +
 drivers/perf/riscv_pmu_sbi.c                       |   7 +-
 tools/testing/selftests/riscv/vector/.gitignore    |   3 +-
 tools/testing/selftests/riscv/vector/Makefile      |  17 +-
 .../selftests/riscv/vector/v_exec_initval_nolibc.c |  93 +++++++
 tools/testing/selftests/riscv/vector/v_helpers.c   |  74 ++++++
 tools/testing/selftests/riscv/vector/v_helpers.h   |   7 +
 tools/testing/selftests/riscv/vector/v_initval.c   |  22 ++
 .../selftests/riscv/vector/v_initval_nolibc.c      |  68 -----
 .../selftests/riscv/vector/vstate_exec_nolibc.c    |  20 +-
 .../testing/selftests/riscv/vector/vstate_prctl.c  | 295 ++++++++++++---------
 42 files changed, 1226 insertions(+), 368 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240411-dev-charlie-support_thead_vector_6_9-1591fc2a431d
-- 
- Charlie


