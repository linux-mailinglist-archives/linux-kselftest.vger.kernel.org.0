Return-Path: <linux-kselftest+bounces-9328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8A18BA621
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 06:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBCA8B21A9C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 04:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6813139574;
	Fri,  3 May 2024 04:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="l5znIWWF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ADC139560
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 04:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714711607; cv=none; b=pUvmCo8DZl7UkFlHinxOw6u1yNDcHh+smODMMhhPzJ/p0Pk4A5QIxElCowNmGKzc5Z7ShWEKIWpAbY9Q7Jj4bQs0WWyIxkto+ljstaQKVLQaOWOGsBvXlMVmL1105Kjg4U3vsH5fweiWyFOAudk5itUeEF71myJPUNdJTL5eLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714711607; c=relaxed/simple;
	bh=uEn9azPxu+2cSfOrb9DxE2DrRYwS4KDxoM1P55N7x4c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GezpcRRjiMBdAUYQ1wCcnNsqCvTsAAghsu9kguHK1CLUC8DYVk6jP/MN/bvVB4Q9VCMlzbMcY//enYNKWab8UpTjyc9XoZRrxcBoB2EqTFtN8BieJ0cjRxQIf/wCjrim30PRyVPwiFxIW8JWc7t5I2g3I34mfEsOpI+BJBd4hyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=l5znIWWF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso8006398b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 21:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714711604; x=1715316404; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=01vMRQO1jBulr3qyOrq5vgfs/ZFmRfI2JOoBheEyUns=;
        b=l5znIWWF/9UV/GFasTvXC8F2U/Mc7+zP4fLfKInsKBGq72nUohPbHa3Yro2oDqKKgD
         SyQRad6WSECmvkjD/E+hkLDQxwyLI3n8js6yrOWOFXFALHc2i8BrzeiCcsrhyaUOuTvi
         qTf2KwfxnVH5+a5dkHPr+L6N5CocI1eTACiwd1NvBqWdQoFwx708t/0lXOCw89GLToDK
         pTsFQCLEeFeyZp5/71Fem/kaHBFlYo+ry4etsd0SVXlUMAkjIIdQyMEiXB+EdDdTnZ1L
         /ziBQCeYn2bqBqFW3Ip1YZz71CAoI8HxCSs1x8GqAqVD4k/qcRTSZ0r3KJvVOfPRBUe5
         nj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714711604; x=1715316404;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01vMRQO1jBulr3qyOrq5vgfs/ZFmRfI2JOoBheEyUns=;
        b=mTLMJFa2VszcTN2nqmuJ2R57GS2k4DJe/h+omi8HGGiuE5boiy+tpsyQL4eHUUL3Mt
         pjIJRInTzMJIjOgG4IUqXwE56BT17yCAD/3sark5YFnX5yk4UQQDRIYq1fZaZdYPmdXw
         XXHNqGvOdYa/386oH7kUW+f6NMGFwIhfoDRY7tU2rm5MJa0UNz+5ZIEh9M1SrdDs65aZ
         7BSEtgkR5WpCHEVjoNyVwn9Ah05Qhe6aTbOxetC5JxenTVCxqijGOKKzlLKmv+7qPY1H
         +YVQ46bkWH6lA+jUYFy+hewg+7ElILru2jzcsFgNDYCCaJKrwAqRXer7CFQWXx0t+VaR
         iDcg==
X-Forwarded-Encrypted: i=1; AJvYcCXxH5kz83enJs4gGSUp4AtmnBuDkFx12YXBcZUWyCgyuNMShWO7HIo+ZgCIIXUmvJadFby7YhAbDrGbULNrAexwu4BXmf2drRaTPglFI5XB
X-Gm-Message-State: AOJu0Yz9jDfTkzGobKZa9/V5r14mecPaf78c2+cbevItuimWFvKU9H3e
	6MEMreBzKRR7PNNU/C0hSXZOuDxBZ7s+5tQOK++x77vBfTaVSWbMxWIc0/6XLdA=
X-Google-Smtp-Source: AGHT+IFN+LqcR4x0ykHQWq4R3GLZgewi1nqhjZN+W1cY/KaKAzcbLnPyctpKzUrcrZrXZ9sH8bejKw==
X-Received: by 2002:a05:6a20:9155:b0:1a1:878d:d3f6 with SMTP id x21-20020a056a20915500b001a1878dd3f6mr2120960pzc.26.1714711604181;
        Thu, 02 May 2024 21:46:44 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001e2bb03893dsm2240411plh.198.2024.05.02.21.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 21:46:43 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v5 00/17] riscv: Support vendor extensions and xtheadvector
Date: Thu, 02 May 2024 21:46:35 -0700
Message-Id: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACtsNGYC/5XNTWrDMBCG4asEraui0Z/trHKPUIwzGtWC1jKSK
 1qC714lKxOycJafNDzvlWVKgTI7Hq4sUQk5xKkO83ZgOA7TJ/Hg6mZSSC00AHdUeP1JX4F4/pn
 nmJZ+GWlwfSFcYupt33EwHXiUg1bgWKXmRD783jPnj7rHkOvp371a4Pb6YqAAF1wPvmvBEDban
 lIoMYcJ3zF+s1ujyK1rdrqyutg426IVStr2ias2rhQ7XVVd26D3WjbgwD1x9da1O11dXYPeqIu
 5oO7kg7uu6z/VCjJv4wEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714711601; l=8482;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=uEn9azPxu+2cSfOrb9DxE2DrRYwS4KDxoM1P55N7x4c=;
 b=64UMR0ok26Dl6Hba4b1PfwRIQYqpsi4KghXHUEOELcOCoP1OpIoib/fZcZ/XDqsDnneIpcw8t
 0bd99pHodWzCLL3rPJq4HwS1PCxKUIdq0r7AAnxrHgKQwX/FEp9oLRL
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

This patch series ended up much larger than expected, please bear with
me! The goal here is to support vendor extensions, starting at probing
the device tree and ending with reporting to userspace.

The main design objective was to allow vendors to operate independently
of each other. This has been achieved by delegating vendor extensions to
a their own files and then accumulating the extensions in
arch/riscv/kernel/vendor_extensions.c.

Each vendor will have their own list of extensions they support.

There is a new hwprobe key RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 that is
used to request which thead vendor extensions are supported on the
current platform. This allows future vendors to allocate hwprobe keys
for their vendor.

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
Changes in v5:
- Make all vendors have the same size bitmap
- Extract vendor hwprobe code into helper macro
- Fix bug related to the handling of vendor extensions in the parsing of
  the isa string (Conor)
- Fix bug with the vendor bitmap being incorrectly populated (Evan)
- Add vendor extensions to /proc/cpuinfo
- Link to v4: https://lore.kernel.org/r/20240426-dev-charlie-support_thead_vector_6_9-v4-0-5cf53b5bc492@rivosinc.com

Changes in v4:
- Disable vector immediately if vlenb from the device tree is not
  homogeneous
- Hide vendor extension code behind a hidden config that vendor
  extensions select to eliminate the code when kernel is compiled
  without vendor extensions
- Clear up naming conventions and introduce some defines to make the
  vendor extension code clearer
- Link to v3: https://lore.kernel.org/r/20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com

Changes in v3:
- Allow any hardware to support any vendor extension, rather than
  restricting the vendor extensions to the same vendor as the hardware
- Introduce config options to enable/disable a vendor's extensions
- Link to v2: https://lore.kernel.org/r/20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com

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
Charlie Jenkins (15):
      dt-bindings: riscv: Add xtheadvector ISA extension description
      riscv: vector: Use vlenb from DT
      riscv: dts: allwinner: Add xtheadvector to the D1/D1s devicetree
      riscv: Extend cpufeature.c to detect vendor extensions
      riscv: Add vendor extensions to /proc/cpuinfo
      riscv: Introduce vendor variants of extension helpers
      riscv: cpufeature: Extract common elements from extension checking
      riscv: Convert xandespmu to use the vendor extension framework
      riscv: csr: Add CSR encodings for VCSR_VXRM/VCSR_VXSAT
      riscv: Add xtheadvector instruction definitions
      riscv: vector: Support xtheadvector save/restore
      riscv: hwprobe: Add thead vendor extension probing
      riscv: hwprobe: Document thead vendor extensions and xtheadvector extension
      selftests: riscv: Fix vector tests
      selftests: riscv: Support xtheadvector in vector tests

Conor Dooley (1):
      dt-bindings: riscv: cpus: add a vlen register length property

Heiko Stuebner (1):
      RISC-V: define the elements of the VCSR vector CSR

 Documentation/arch/riscv/hwprobe.rst               |  10 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   6 +
 .../devicetree/bindings/riscv/extensions.yaml      |  10 +
 arch/riscv/Kconfig                                 |   2 +
 arch/riscv/Kconfig.vendor                          |  44 +++
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi      |   3 +-
 arch/riscv/errata/andes/errata.c                   |   2 +
 arch/riscv/errata/sifive/errata.c                  |   3 +
 arch/riscv/errata/thead/errata.c                   |   3 +
 arch/riscv/include/asm/cpufeature.h                |  98 ++++---
 arch/riscv/include/asm/csr.h                       |  13 +
 arch/riscv/include/asm/hwcap.h                     |   1 -
 arch/riscv/include/asm/hwprobe.h                   |   4 +-
 arch/riscv/include/asm/switch_to.h                 |   2 +-
 arch/riscv/include/asm/vector.h                    | 247 +++++++++++++----
 arch/riscv/include/asm/vendor_extensions.h         | 103 +++++++
 arch/riscv/include/asm/vendor_extensions/andes.h   |  19 ++
 arch/riscv/include/asm/vendor_extensions/thead.h   |  42 +++
 .../include/asm/vendor_extensions/thead_hwprobe.h  |  18 ++
 .../include/asm/vendor_extensions/vendor_hwprobe.h |  34 +++
 arch/riscv/include/uapi/asm/hwprobe.h              |   3 +-
 arch/riscv/include/uapi/asm/vendor/thead.h         |   3 +
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/cpu.c                            |  35 ++-
 arch/riscv/kernel/cpufeature.c                     | 171 +++++++++---
 arch/riscv/kernel/kernel_mode_vector.c             |   8 +-
 arch/riscv/kernel/process.c                        |   4 +-
 arch/riscv/kernel/signal.c                         |   6 +-
 arch/riscv/kernel/sys_hwprobe.c                    |   5 +
 arch/riscv/kernel/vector.c                         |  25 +-
 arch/riscv/kernel/vendor_extensions.c              |  66 +++++
 arch/riscv/kernel/vendor_extensions/Makefile       |   5 +
 arch/riscv/kernel/vendor_extensions/andes.c        |  18 ++
 arch/riscv/kernel/vendor_extensions/thead.c        |  18 ++
 .../riscv/kernel/vendor_extensions/thead_hwprobe.c |  19 ++
 drivers/perf/riscv_pmu_sbi.c                       |   9 +-
 tools/testing/selftests/riscv/vector/.gitignore    |   3 +-
 tools/testing/selftests/riscv/vector/Makefile      |  17 +-
 .../selftests/riscv/vector/v_exec_initval_nolibc.c |  93 +++++++
 tools/testing/selftests/riscv/vector/v_helpers.c   |  67 +++++
 tools/testing/selftests/riscv/vector/v_helpers.h   |   7 +
 tools/testing/selftests/riscv/vector/v_initval.c   |  22 ++
 .../selftests/riscv/vector/v_initval_nolibc.c      |  68 -----
 .../selftests/riscv/vector/vstate_exec_nolibc.c    |  20 +-
 .../testing/selftests/riscv/vector/vstate_prctl.c  | 295 ++++++++++++---------
 45 files changed, 1312 insertions(+), 341 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240411-dev-charlie-support_thead_vector_6_9-1591fc2a431d
-- 
- Charlie


