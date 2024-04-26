Return-Path: <linux-kselftest+bounces-8945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72688B4118
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 23:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BD828260F
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 21:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDFA36AE0;
	Fri, 26 Apr 2024 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XQjPltLy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFDB2D03D
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714166968; cv=none; b=ikGAuZNxuW9FoZZFjjpt9n3s2o/z0xxsYJAMDJqb+f91/HlL0enKjoPE/a0pQKOEWJcz1sSGDeU2IrHRALyCvvR4axvc6Utf/dXI0JPFqyumXhZLOZkU2wTXNmLE+r8q+rh2sRN+XCGL4AU6yZ7bRApPHg6W2QAQehAY8OYeBW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714166968; c=relaxed/simple;
	bh=uRq8I3mtUwdbsfal6z0ovP3Ccv/tUy49SyaUZY/kyRU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TFFO+dxBVuUFJbHfzeXErQxkoOdXIURoyIwEjkjVdBGEEjqsqL7FzeqQOZlgNtEjWAuLXgmN2SBuolDcqrqpTZ0HtXU6mv0BNRytSlecui0ZaB9EmiklNxpAo+R3dyo3SE0FrpSz8Im4+Chigl1cLDDpBd+j7lwEfWzLwFwLXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XQjPltLy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e65b29f703so24153365ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714166964; x=1714771764; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=586HeuW0n4zQwi9YE9+ZauDHLIpV6SUCAbNdrNbl9sA=;
        b=XQjPltLyIJ7Rr3cFLDe9ol77FXNjqDtOJnGGl+atBZDtg0k4qQcmPIwQsk1W+qNWTO
         SU1GarZHiAH0s1xnJmXCcpdCesEbVW4qxFYeSDRNCbZ2wdXV8EImLdiaRdZ7gzhLRAdb
         1zonG1jKO1DxeqNnjLrzM3vlIhNv2ndh495QNk5PfSctajv9SgK1hbIVrNv400JVpt0b
         z1EHSdTgddZ3pBIQepB9LihRgC4GXWV1fZJzBsioGK0HLG6XoP09THiVnATAYa3KRv6I
         01c7IikaKxdDNJSOiJd/vL0Z/Nrqds3XskabMA/sc6wrqobmi8r5lwjdO97CHDILwcBL
         IquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714166964; x=1714771764;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=586HeuW0n4zQwi9YE9+ZauDHLIpV6SUCAbNdrNbl9sA=;
        b=fjn56+/ItR+QAlNhUe3NR65DrLHn3jKFRvaN3tBNH+hdCboU4BaDS+VyFTjWnk/Xhf
         6l1dJRnTiUej9OLGFguP4V5nlXRFsVW8I/8e6ST+VOSAvZNBnUfRiuuKzamof5BNvYSl
         ZeE9fuwRgGvq732Vx1+Xa+JZuI4T1b9RQWu2yl3Sc0krfRpEI4tW3MjC/diKUYcgH74R
         dKIVZapQON2qUNVpIoINQwREGhZ2DVCavmhXBiGOS2cWCahL1kdQ7A04jV47srq/eHfx
         DxIXxkD22ytJR4+/PvNH98bULoWv5BgNqGmhU9sWtLDXvhNSHuxiRFBO9H/nMfSVg1iz
         DccQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVPMU74kngrVOBqhXRZTBDXE+5Pm2SAEsLufJE/CauZLsCeqz5EaCWCmzkbMdx4He0iDWoNd7b6/463nS/+8/tDIMWq3Ns2bRTj+LoOG0e
X-Gm-Message-State: AOJu0YyXQ+FAxONDvWY0IoTQy/phU13YOKanwqSyN4WSUq5BQHp2UU7S
	Fwut5Q50TzcEH6KDBlXQzAfLg4FwZoM8qhJejPhSMljl5OVelgD4xJqIhDAe09Y=
X-Google-Smtp-Source: AGHT+IE+LmFnWZIaeb+k1GH0S221s/FR7O9jku3hQzBquIqTri/yXWOfs0mHnxCcWVzW4yvseAls5g==
X-Received: by 2002:a17:902:eb82:b0:1e2:36d1:3015 with SMTP id q2-20020a170902eb8200b001e236d13015mr4089836plg.8.1714166964575;
        Fri, 26 Apr 2024 14:29:24 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902650300b001ea2838fa5dsm7226720plk.76.2024.04.26.14.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:29:23 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v4 00/16] riscv: Support vendor extensions and xtheadvector
Date: Fri, 26 Apr 2024 14:29:14 -0700
Message-Id: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKocLGYC/5XNwY7CIBDG8VcxnBfDUEpbT76HMU0zDNtJdksDl
 WhM3130ZIwHPX4w+f2vIlFkSmK3uYpImROHqQzzsxE4DtMvSXZlC620UQZAOsqy/MQ/JplO8xz
 i0i8jDa7PhEuIve07CXUHHvVgKnCiUHMkz+dH5nAse+RUTi+Paob765eBDFJJM/iuhZqwMXYfO
 YfEE24x/It7I+tnt/7Q1cXFxtkWraq0bd+41ZOr1YduVVzboPdGN+DAvbjrut4AFLUftosBAAA
 =
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714166962; l=7863;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=uRq8I3mtUwdbsfal6z0ovP3Ccv/tUy49SyaUZY/kyRU=;
 b=LkqePQ1aClMGNb6hXt6NSVQbFV0RHmdRYLQnVbHSNjrGmFC5h9xyiIcPjRoIaagehcvvcYbCh
 hrY2/AsbvptBEcsWQW94xKfbmYuSV7vA2pHuAxdwUaAbSYB7by9Xjfs
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
Charlie Jenkins (14):
      dt-bindings: riscv: Add xtheadvector ISA extension description
      riscv: vector: Use vlenb from DT
      riscv: dts: allwinner: Add xtheadvector to the D1/D1s devicetree
      riscv: Extend cpufeature.c to detect vendor extensions
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
 arch/riscv/include/asm/vendor_extensions.h         |  95 +++++++
 arch/riscv/include/asm/vendor_extensions/andes.h   |  19 ++
 arch/riscv/include/asm/vendor_extensions/thead.h   |  45 ++++
 .../include/asm/vendor_extensions/thead_hwprobe.h  |  11 +
 arch/riscv/include/uapi/asm/hwprobe.h              |   3 +-
 arch/riscv/include/uapi/asm/vendor/thead.h         |   3 +
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/cpufeature.c                     | 155 ++++++++---
 arch/riscv/kernel/kernel_mode_vector.c             |   8 +-
 arch/riscv/kernel/process.c                        |   4 +-
 arch/riscv/kernel/signal.c                         |   6 +-
 arch/riscv/kernel/sys_hwprobe.c                    |   9 +
 arch/riscv/kernel/vector.c                         |  25 +-
 arch/riscv/kernel/vendor_extensions.c              |  69 +++++
 arch/riscv/kernel/vendor_extensions/Makefile       |   5 +
 arch/riscv/kernel/vendor_extensions/andes.c        |  35 +++
 arch/riscv/kernel/vendor_extensions/thead.c        |  36 +++
 .../riscv/kernel/vendor_extensions/thead_hwprobe.c |  42 +++
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
 43 files changed, 1283 insertions(+), 338 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240411-dev-charlie-support_thead_vector_6_9-1591fc2a431d
-- 
- Charlie


