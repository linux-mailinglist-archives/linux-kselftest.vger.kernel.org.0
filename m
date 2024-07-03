Return-Path: <linux-kselftest+bounces-13108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B377925335
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 07:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0461C2125B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 05:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A25474413;
	Wed,  3 Jul 2024 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kLTY/YIu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8A61FF9
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Jul 2024 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719986219; cv=none; b=K3oLzvJLKjjIkmoh9rkHMJnfmB9ZLP/+WytlkOn6UvfoLNmUHlQEEpA+6xOur6iRMWvr2TErfvZmQ2QqTOoNrZUefLen4E/OjxVy+5Ji0VeTNUMKbVig4tPVCsdsyv8SH+lgjUbgoHZBsvpSibdPdbunKYRXmi5d1nUaJdFCzds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719986219; c=relaxed/simple;
	bh=Hl6QvPONN+05yHcIyDxD/TivlmLaEDWo+M0nr36Aqpo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uc0eCm9vDDUfiQ8uVgOP2t2J2+5hXHGhESa6Kn+HeEysjsbujQu9quRlOsOib7rPgjSVEYM0w0upFJYIuwdw5lEcv5CkQsNQx/8fzkV/w2SmW01RPWl+PtCjonVs3TEQP6HKGpuWjVkeSOM3x+v0w3ajdi6hedNO1uW47b4AUjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kLTY/YIu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7066c799382so4263318b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jul 2024 22:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719986216; x=1720591016; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3t4UWZIXNmwlleeYAQCp+9zxVS/7gI08QvUREUzgO84=;
        b=kLTY/YIuRXQFX1uoBSRxqyuB4PPODqP8Et2sykihrLa62djkpvNuSqWT5KvUCR7GE3
         ofRvuBCBEAnhaAXOQeJpZbpuqci6bhyM0Zz+73tyqiry+HU97NdXTcvweC8uFeVQTCU4
         a5vaZrUMBLlxYz+KfyxOSJz13zlhis6wRMPtmsZ/eLvkYRzUwJcqbQBr7hAyW629bVgG
         3QGeumDCQBiGkWf2NtZ4gGy3KgkCcH5KJKPlekXrBJkWPpJYdr4ZU9dynmdztoCw7F21
         HPB7+tL63K5jKIDir9sOOkQw/0NKyMrx11phaPhr2eOvU0PDvydAN1UCYiVAvCYVAm+B
         085g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719986216; x=1720591016;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3t4UWZIXNmwlleeYAQCp+9zxVS/7gI08QvUREUzgO84=;
        b=UXntoufYqpnhoR1Sijj8gPSZkIS4FNZk7aw2j/NDZ5mFXXo7GmBAyekm2SykAsMwQc
         4yWVZiwVnwEBYDM4CvBF2gzeTfE12ubQsT5mEGNtHKXhM0M2KPB/MVkcyCQCQKq2vC0X
         iOrb1GxtXjXaAdRYIQFdpBhtcE3j3OpyO3PRcxRkesJZU4gwtx7ft/VoW9XRchaOJKHP
         wQD3ZpAQ3VL3cnHvnZtPP1WCKE95DEiwQUrye9ykSdyqQtcroOlX9freF9C1NvlCY4G8
         aItO5NnEAd+hv+HBzE1ehzUXwSrXEHNcvYz9T3MzeoWpSbZinWMTkNV8xi8QxN/9xaJS
         R5NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWymgdJMCGG/Ghw/3sGtjt2LOQaqIhD/0VQuaBJgTYbVQGREiTqiDv2+FO7SvBcoErrj7nJzkTB2BoLulh/aW0xrUIKv2/V1hN7kypW+9gw
X-Gm-Message-State: AOJu0Yz9nTq1gbv2CqdwcA+i7HxSTGqxAx3Hpd6BwKL8dEyxCB3qthDi
	xmAXx6ebQbz9CEm3lNMA5j5SkvlWf6Rn29wsEmN41kk/y68LMdYw7ZSl7mUTy3E=
X-Google-Smtp-Source: AGHT+IHqMBjzzJYPaU1uYNXIsZtlyNsCzcnND9ARf2tTr/ndhy027f8LF0O61LoiggvB5CHkWjfqsw==
X-Received: by 2002:a05:6a00:ccf:b0:706:6cb5:9720 with SMTP id d2e1a72fcca58-70aaaf3a9a0mr14350967b3a.34.1719986216101;
        Tue, 02 Jul 2024 22:56:56 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a89fc9sm9514103b3a.212.2024.07.02.22.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 22:56:55 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v4 00/13] riscv: Add support for xtheadvector
Date: Tue, 02 Jul 2024 22:56:20 -0700
Message-Id: <20240702-xtheadvector-v4-0-2bad6820db11@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAATohGYC/22OQQ6DIBAAv2I4lwZYROmp/2h6UFgqh2oDhtgY/
 160F2t6nM3O7M4kYvAYyaWYScDkox/6DPJUENM1/QOpt5mJYEKyEhidxg4bm9CMQ6A1gAXLq1Y
 KIFl5BXR+2nK3e+bOx7z23uqJr9NvSDH9G0qcMgoOS81t5TjT1+DTEH1vzmZ4krWVxM7nh0eSy
 L6uGlkrDo1V8o8Pe/94H7LfOgcaW61UjQd/WZYPHIMzeysBAAA=
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
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719986213; l=6557;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=Hl6QvPONN+05yHcIyDxD/TivlmLaEDWo+M0nr36Aqpo=;
 b=0vRKAtP4oa7aLnXi13AE21uwWQVt69/hB4BymscXb4nZYxw5in4ZUBxCMHjyddBzXtxgpMVVs
 x85UG530i7mAeng/cgJrtkk7msbK0rDDWOqHGiJst/OxYB5NyQPgwIM
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
[4] https://lore.kernel.org/linux-riscv/20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com/

---
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
 arch/riscv/include/asm/vector.h                    | 224 ++++++++++++----
 arch/riscv/include/asm/vendor_extensions/thead.h   |  42 +++
 .../include/asm/vendor_extensions/thead_hwprobe.h  |  18 ++
 .../include/asm/vendor_extensions/vendor_hwprobe.h |  37 +++
 arch/riscv/include/uapi/asm/hwprobe.h              |   3 +-
 arch/riscv/include/uapi/asm/vendor/thead.h         |   3 +
 arch/riscv/kernel/cpufeature.c                     |  51 +++-
 arch/riscv/kernel/kernel_mode_vector.c             |   8 +-
 arch/riscv/kernel/process.c                        |   4 +-
 arch/riscv/kernel/signal.c                         |   6 +-
 arch/riscv/kernel/sys_hwprobe.c                    |   5 +
 arch/riscv/kernel/vector.c                         |  25 +-
 arch/riscv/kernel/vendor_extensions.c              |  10 +
 arch/riscv/kernel/vendor_extensions/Makefile       |   2 +
 arch/riscv/kernel/vendor_extensions/thead.c        |  18 ++
 .../riscv/kernel/vendor_extensions/thead_hwprobe.c |  19 ++
 tools/testing/selftests/riscv/vector/.gitignore    |   3 +-
 tools/testing/selftests/riscv/vector/Makefile      |  17 +-
 .../selftests/riscv/vector/v_exec_initval_nolibc.c |  93 +++++++
 tools/testing/selftests/riscv/vector/v_helpers.c   |  67 +++++
 tools/testing/selftests/riscv/vector/v_helpers.h   |   7 +
 tools/testing/selftests/riscv/vector/v_initval.c   |  22 ++
 .../selftests/riscv/vector/v_initval_nolibc.c      |  68 -----
 .../selftests/riscv/vector/vstate_exec_nolibc.c    |  20 +-
 .../testing/selftests/riscv/vector/vstate_prctl.c  | 295 ++++++++++++---------
 34 files changed, 888 insertions(+), 271 deletions(-)
---
base-commit: 11cc01d4d2af304b7288251aad7e03315db8dffc
change-id: 20240530-xtheadvector-833d3d17b423
-- 
- Charlie


