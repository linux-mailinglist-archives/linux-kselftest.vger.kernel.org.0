Return-Path: <linux-kselftest+bounces-9399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAFF8BB2B2
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 20:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE941C211B4
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF74F158A0B;
	Fri,  3 May 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fJz2lhJx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DC158873
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760324; cv=none; b=pYZot0taX2kGbcq+wLzy5sXlUKhHARuE+bcQuNIXxM5HKU2l+Ph8MbV8wegNtvhie3VtLWo+Opcdn8JchZR9MZyDonOxaj+vbRyV94cJ8/futgM6eNV1cJVOzF04b7oLMfvS10RRH7l3YOS2fYaj5Rpq8mx4aPE0n/AY7P2cMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760324; c=relaxed/simple;
	bh=r/6gY2+LXNqc0EJoEqcqRGtQ40Iamm6JOA9ZUPtJzps=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oBX+8/HEZsy0AvuDt5My0qBqFjJg8j79qO4Xt1kYBTd7pjiV9s4s0wr9EWCRg2Fr+2uIy+WSjSGJoU7SL/lbDcqVS3S929pD90ppPRaw+0qoS4D+O34+PNYA94pdiRmgte+Rsv8G6DQ6khwI7WG14ZdyEfNbLohFXsk0yg0keaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fJz2lhJx; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f44b5e7f07so2189b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 11:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714760321; x=1715365121; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ChcKLFzPe2eQn/pwaNx0shjH861FBoRdOTFTkIbkbG0=;
        b=fJz2lhJxPNmqjiyH44gXYI9sB1drx9OXtMLN2gT1QNYJaSGcj1/6xDK82Xc/tNQKTW
         J3LPOp5k4BLue80BoYjsPWaKXW1amENFZiqjNecmL/6rY0AdmI+5ozhoAsR4XGu6qGzV
         CGajpo2BzUkq/k40F/wu1FAa4W710EHKTB1KEW6uKhE+PvMR8GCs1TnhG0mChNISao+0
         IixVdVj31cGOuoSfZn/IpHB9l5l/z8jAEQ4G2aay9A8UaQr3yvgf/Yv7JDAdeA/og89v
         J751hyRKV82jjohEADJ2XEx8Eq49SQVk8nBaO0PRxbhIAXQmsrWOZcAap9UwiyzDzGMa
         PIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714760321; x=1715365121;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChcKLFzPe2eQn/pwaNx0shjH861FBoRdOTFTkIbkbG0=;
        b=TPDcIn5CmznRYOz0mt5QJs+JRYTF/5YuU9K6o5YmtYOGomPBht57acwuRUo4cXbuSe
         4xqakJ6yZx5gvGXUTLHaQbwLmeiiZnw9TL282zb65esia09Bt89qtTi/YK6ar+so7+9k
         kW4yuP9aiZBaPcsj4F1difyyQU8l4tDJ6IVkODEMr9iPspalEa98sjZBpPOdLn51NZG1
         sFpjtARdgJqgnRH7dUFq4U/89RQaUtF7HQLWWeSXBODDO/3YK0Z3Tqasv4dNV4NVfToB
         wKsqk/7HqCG9fXqoFUn4ZHzXv//qiw8iH50ESPaAoFv829WbPFTCmyWePa3O5HQXuHkg
         wNWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWULbhmRDymL/D5zC/miYURcr6lLt8/9/STR81XWld2+fIfN1Cfw3eml5dl/I4TsZ1E9Xge2V4lKiAamwF/cVjg7lQcFWKw02nYOgPqUQpD
X-Gm-Message-State: AOJu0YyXYzI2vWE4gm64ERNzRuED6t4/7aT4e6KW5ZZGlQwzgkNkfay+
	cj6YEvgog8JyzRTZTx8tKUaQus35b/DhTWu+nTm8sqI6nd8jTIVfdXrkoUD0C9A=
X-Google-Smtp-Source: AGHT+IGI2dGJ0NIoMKX8oUxPlZVNjsAo20iUsO3+gNq4qBhznQ5MIiDUtuKMThvEHpuPWqgQINkz2A==
X-Received: by 2002:a05:6a00:9a3:b0:6ed:de6f:d72f with SMTP id u35-20020a056a0009a300b006edde6fd72fmr3985766pfg.20.1714760321217;
        Fri, 03 May 2024 11:18:41 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id fu6-20020a056a00610600b006f3f5d3595fsm3355421pfb.80.2024.05.03.11.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:18:40 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v6 00/17] riscv: Support vendor extensions and xtheadvector
Date: Fri, 03 May 2024 11:18:15 -0700
Message-Id: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGgqNWYC/5XQzUrFMBAF4Fe5ZG0kk782rnwPkZJOEhvQpiQ1K
 Je+u7l3Y5Eu6vLMDN+BuZLic/SFPF2uJPsaS0xzC/rhQnCy85un0bVMOOOSSQDqfKVtk9+jp+V
 zWVJeh3Xy1g3V45ryoAdDQRkIyK0U4EijluxD/LrXvLy2PMXSTr/vrRVu038WVKCMShtMD8pjJ
 /VzjjWVOOMjpg9y66h876qTLm8udk73qJnguj9wxc7l7KQrmqs7DEHyDhy4A1fuXX3Slc1VGJQ
 Y1YjS8ANX/bqK8ZOuaq6DUSEDYY3++99t234ADqm4rjsCAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714760318; l=8914;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=r/6gY2+LXNqc0EJoEqcqRGtQ40Iamm6JOA9ZUPtJzps=;
 b=ph6fqG1mkKm/tc4k031UnxPL8X8GQY0Ex28RFoSgD78qWqiPQUbgoqbG/iD7cytowXJbwa4EN
 EujXp5tfYLYBgbrbLRnHsXm0nqol507hiC8zBipfHHLaq6NpR+lqSPL
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
Changes in v6:
- Only check vlenb from of if vector enabled in kernel (Conor)
- No need for variadic args in VENDOR_EXTENSION_SUPPORTED so just use a
  standard argument
- Make 'first' variable in riscv_fill_vendor_ext_list() static so that
  the variable value remains across calls to the function (Evan)
- Link to v5: https://lore.kernel.org/r/20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com

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
 .../include/asm/vendor_extensions/vendor_hwprobe.h |  37 +++
 arch/riscv/include/uapi/asm/hwprobe.h              |   3 +-
 arch/riscv/include/uapi/asm/vendor/thead.h         |   3 +
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/cpu.c                            |  35 ++-
 arch/riscv/kernel/cpufeature.c                     | 175 +++++++++---
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
 45 files changed, 1319 insertions(+), 341 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240411-dev-charlie-support_thead_vector_6_9-1591fc2a431d
-- 
- Charlie


