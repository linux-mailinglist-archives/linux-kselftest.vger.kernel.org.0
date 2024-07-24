Return-Path: <linux-kselftest+bounces-14165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2887E93B743
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 21:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27FB2859B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 19:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063D916C42C;
	Wed, 24 Jul 2024 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zLjTBbHH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEA516B399
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848442; cv=none; b=h0uWFFP5+kvbj8OwxfBSSPKy7Xd8OkHA+5rrpj3TeteoMPz1QSvpRqw43sGg3rES2ZWg3CEzN1ZVBxu4u+iTHx89LwcyfsHzA8bfrG7SiKOA+rhE/zWaNRp4jsR6zc+pduNIq3LkjoAbkOwl19NOPJ+Pinrb6H0r3TvGdh9qr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848442; c=relaxed/simple;
	bh=HDyW4OKcATYcmOGJW1pqc68intlppLBSsV9QxPNcEz8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YPVYxpnd/0Np+OGp5jmUrzRM4QJvEaLpuy+Sd6rMI4c3vDJ4GmbRsF5n6fbdic2uI599lvqGTP10kGh0JTujmph8FkNmRVBRF7n69R43XFqvkJkON3+L5ohNGX4i8MsxWPwwcYe9LtpAgBjai2eLen2y9BpAOK03bOXeU1mAdRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zLjTBbHH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a2123e9ad5so885925a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 12:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721848440; x=1722453240; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dc6RTkugPLXnGOf7kgEFpncgSDKIBk0i/pHC6Z6/Jg8=;
        b=zLjTBbHHfUIy4O077ILHDytLo+MI6tV0NTw1yfOuGRGCJhIKiTVfz8OBYfC/BZ97pX
         EyAoshRkcEgN1pzoH3Ye6wu1aU83pjMhxnSHSTNrlfUzWs1/Kw5p2dNxa4obRKtqQqVh
         aW2SayE0hC5pc8UeMNL20gQ5c0i2W60QodW6S0Rma7s1GqyjHS4rzGQgQtHQp3/589ni
         4joNG/LIEujyCXrghN22bTQZ6NSFlP41KytJTN4jmYIQKYipeadwuuZvsPDi6P0uxgd+
         6DAyqEHzF5ivRKkYO9iS/saErNjxGdHEPYRRQN+mGWTkTCofQGCYELPh7EVafxYUPdoD
         yQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721848440; x=1722453240;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dc6RTkugPLXnGOf7kgEFpncgSDKIBk0i/pHC6Z6/Jg8=;
        b=RDaQcid5wEmkWYFD/yt9lkwW1o/RbpD8KztiQteto2l28Le8fUk+obEHBrX+7NLDcO
         QxlrW1XJcvYc41jHyjEAlTlXD/WBktxSMhLHQqIvuZVkw+CrVAJGPLBpELAML5hsS0e4
         gWKZzqqeIXrSI1stsYRoqZIHi9/gfmT7vpcf5CMbnzdw9F+nRczdsrRJCiwL4FXOwYLl
         nFCQyfF5529eoEEpyXZbvH5YYWd6d/FgvGs43DJhftp9hUdoxTz3wCAfHKc0Y3b87urU
         Vm/bfm1qLvlcAh8OlW2wnjK3m/YwRvIH+XZ9z/6HY0ChiGIOMBStcZGfjH6lV0T64c0S
         CScQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOdzaRKFQcZflh0dPI/b1IJ+hnDjZiptCBbhm67gU2V4A+bgDq5Do989qXP3QWScm65tgKmiUK7nVNM3f9kT6X/lOC016aBYCZ+Ac9fkca
X-Gm-Message-State: AOJu0YyFH7o3SpfgDruVRDnVAaBJCgDsnkpKh8r1B8BIqWEbpiFnjLP9
	57CxA/W2FeJD3C3JixvXvE/dfn244o4frD3einKnB9kgUPTiQLHYgEgaiIt+Xng=
X-Google-Smtp-Source: AGHT+IF2lkgyH3ipXW4dYplDhf3pwXiHlPGdqhyCGZJmnq6o9ERzmiZgwpNnsvxAZhXQ2fFhZ0/x4w==
X-Received: by 2002:a17:90a:4d87:b0:2ca:f755:1040 with SMTP id 98e67ed59e1d1-2cf21547c07mr994142a91.7.1721848440377;
        Wed, 24 Jul 2024 12:14:00 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73edecesm2022359a91.32.2024.07.24.12.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 12:13:59 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v7 00/13] riscv: Add support for xtheadvector
Date: Wed, 24 Jul 2024 12:13:51 -0700
Message-Id: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG9SoWYC/23Oy07DMBAF0F+pvMZo7PEjZsV/IBZ+Ei9IqqSyi
 qr8O9OyIJgs78jnXt/YmpeaV/ZyurElt7rWeaJgn04sjn76yLwmykyCVKAR+PUyZp9ajpd54QN
 iwiRsUBIZkfOSS70+6t7eKY91pWdfj/Ym7tefIgPub1ETHDiWrJ1Itghwr0tt81qn+BznT3bva
 nLnRfeRJsk769VgBPpk1IHHve/3kXwoBV0OzpghH3j16y3IzivyMtDyICEFIQ683vl/+5q8Cmr
 QJdqkdTnwZudlv2/IR+cLCITiATq/bds3tIppJusBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721848437; l=7095;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=HDyW4OKcATYcmOGJW1pqc68intlppLBSsV9QxPNcEz8=;
 b=f3enMXbJ/trQYvs+Dn6l+vn9AxiY48aFwvwOn8igXqnU3DemMj+b8qlJPttYXKzlCnmIA1nn0
 t5SiPgAhHg8Cbn/IV+iU1ImNQY9KJhScsGYrWjVAZmumMt/7hzaclMY
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
 arch/riscv/include/asm/csr.h                       |  15 ++
 arch/riscv/include/asm/hwprobe.h                   |   5 +-
 arch/riscv/include/asm/switch_to.h                 |   2 +-
 arch/riscv/include/asm/vector.h                    | 225 ++++++++++++----
 arch/riscv/include/asm/vendor_extensions/thead.h   |  42 +++
 .../include/asm/vendor_extensions/thead_hwprobe.h  |  18 ++
 .../include/asm/vendor_extensions/vendor_hwprobe.h |  37 +++
 arch/riscv/include/uapi/asm/hwprobe.h              |   3 +-
 arch/riscv/include/uapi/asm/vendor/thead.h         |   3 +
 arch/riscv/kernel/cpufeature.c                     |  54 +++-
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
 .../selftests/riscv/vector/v_exec_initval_nolibc.c |  93 +++++++
 tools/testing/selftests/riscv/vector/v_helpers.c   |  68 +++++
 tools/testing/selftests/riscv/vector/v_helpers.h   |   8 +
 tools/testing/selftests/riscv/vector/v_initval.c   |  22 ++
 .../selftests/riscv/vector/v_initval_nolibc.c      |  68 -----
 .../selftests/riscv/vector/vstate_exec_nolibc.c    |  20 +-
 .../testing/selftests/riscv/vector/vstate_prctl.c  | 295 ++++++++++++---------
 34 files changed, 891 insertions(+), 273 deletions(-)
---
base-commit: 554462ced9ac97487c8f725fe466a9c20ed87521
change-id: 20240530-xtheadvector-833d3d17b423
-- 
- Charlie


