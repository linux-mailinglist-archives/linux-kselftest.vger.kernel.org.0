Return-Path: <linux-kselftest+bounces-21978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF6D9C8075
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 03:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4FB2826E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 02:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662211E7C2D;
	Thu, 14 Nov 2024 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qrasu0YZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384D1E6DCD
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 02:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550889; cv=none; b=MhSOFrji3cLhuRnrEFuHkHbGxvWI+cHhN73kyMXb2ozsajOq+VvSMO+ddfHnVPMPJg5SP5kYWPJUrth+bryj0MYiTZpACEGw++/zu9LtNkfg+56mmm59IWsSczKWffzZGs7h67sJXlUX+12zgY6B0NtoEKAqjiWG7LR/PwHWIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550889; c=relaxed/simple;
	bh=4adee1rJ2Lzk/NbNC6kj1svzJ+ZECFrspm3D500vT2Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s6w8pVKHzl9lUANUpaedkwUA7DqqNGhf63uNlkxjxzF7w59XMJPHy8CKnU5JxYsYxPX8ayXkKTrkmtYv5Qx+M0+reDTGhlQZSrNf2r3o1C3+d8EkKQy9XYgtJCZkyA+Yq72YRBJp9y0tiONFTzmwnJfeHUl+0tKrcCHc2a733cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qrasu0YZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cbcd71012so769525ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 18:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731550887; x=1732155687; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAPPnWOiIBTXMXnajrn8rBaT92RPERw4hYKmhrHTtdA=;
        b=qrasu0YZDbhFEe8m9sBzrjVMtc3SWyBMCIxYZEpS174TL3IqzoGiei9riWeM9q/ilG
         mgxU2u1fLZApshtaoIYCKHsJPenFMqWNyh/0pyhc3nyGlEWxZYYgrWqVggOj8p1I+mrh
         WALfSK0xD4RmzbWPSgx8g9ym35h5NmD/GbNMWoDMs10fTrlBiqBiI6m40rto0vUixg0A
         QkHAjKWBCSZ01L8/uh6xmeC4RTcKwT3FHjoQVre7Luws6BC3QiPgDAoNZfAGW9sZO+IM
         AiHtIsdrYvwE/3mfcs30QKVspA4/XjL0kT7J8s0RbclwvW5/1/xiosUHhLxhFWM2wrcH
         Fafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731550887; x=1732155687;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAPPnWOiIBTXMXnajrn8rBaT92RPERw4hYKmhrHTtdA=;
        b=MutjOkQEHm/e/TaYQGQYqqBHHnDRj53HMvLUEEvIC0PU+SY2steShcnrdkvfTAKKKJ
         iglndYsJ+Z5X3TZJrijQpDB/7vPUWbEjxkTixpXtSm1cOLE+BjorJJq5V9PObegbrjj6
         9cVreMKsQuS9XTahtXOPK8Tf7ehmzldttUkIEl2FJTvYV9RmpdQLRE37+m2Jmvwf+TGq
         BZgZ9vPhKbqhcHrQx95lWhRN6USn9eQmZWk+VLN3Wi+j8qDIBO1quMGxt8cz9daqbA5Y
         j7q9OE4GBnF8trkvfPvb9YkApuN4v5PDNgDRhhRSQ+/qOsi4iPSaLjYlYnaCb2XSdyVj
         dT5g==
X-Forwarded-Encrypted: i=1; AJvYcCUfXRfalBBEthQscOkOqchQyqLa3FJL1Enhun/EMS1jqXfFO1zPIG5WyyRIrnkThAiQyLLKsZm/EN070y8Qf7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIPRe27CPEJILr3jmy0FbmIBILuFIyD6atTizpO2yRNs+rmenT
	A/NVinr7PmkFrUOjP5LYkUA+2kRxyPkKlRKDinwU6LTMmEkUtU/3wAaf6xoQI/w=
X-Google-Smtp-Source: AGHT+IHuXprvulo3ZCLf0sfgdG+OnZp1nx6yWT6PK7qC0c4Aw0qazCuVzUZYjNYDQkIN6OjFSS6WdA==
X-Received: by 2002:a17:903:1788:b0:20c:aae9:7bd7 with SMTP id d9443c01a7336-211c50604c3mr7533515ad.39.1731550886653;
        Wed, 13 Nov 2024 18:21:26 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c499c9sm406875ad.68.2024.11.13.18.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 18:21:25 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v11 00/14] riscv: Add support for xtheadvector
Date: Wed, 13 Nov 2024 18:21:06 -0800
Message-Id: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJJeNWcC/33Sy07EIBQG4FcxrK05h8PVle9hXNACDgunpp2QM
 ZN5d0/HxVQkLrl8/w+Ei1jTUtIqnh8uYkm1rGU+8gDx8UFMh3B8T0OJPCEkSAWaYDifDinEmqb
 TvAyOKFJEOypJgsnnknI53/Je33h8KCtv+7rFV9xmf4IM+N9BFQcYKCftMdqM4F+WUue1HKena
 f4QW1aVO4/NQapk721QziCFaFTH0963/cR+zJl8Gr0xLnW8unsLsvGKvRy52UmII2LH653/06/
 Zq1E5nScbtc4db3Zetv2G/eRDBiTIAaDj7d6rxtvt/lahRwgxUO/+7j/vtv4MipAfD8l2vL97B
 6bxnr2RQZsoY9Cxd36Ee4BHbD8QcIKL5Al4VSrTJFyv12/wxue57gIAAA==
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
 Jessica Clarke <jrtc27@jrtc27.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Yangyu Chen <cyy@cyyself.name>, Andy Chiu <andybnac@gmail.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8426; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=4adee1rJ2Lzk/NbNC6kj1svzJ+ZECFrspm3D500vT2Y=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7pp3PR9CgdETDhncNTdfzYly6RVtnyr4qwcvcnfHG8tX
 NagE/W+o5SFQYyDQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgIm8T2f4X94VNzMwKax0b9aV
 m0U/rZ/vmLNVR0TCXZrfuH/l1lfd5xkZDll5PMz4yvmH4fauRMVLalLCyoIaK5cIBD2Za9XWO6e
 dFQA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

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

I have tested this with an Allwinner Nezha board. I used SkiffOS [1] to
manage building the image, but upgraded the U-Boot version to Samuel
Holland's more up-to-date version [2] and changed out the device tree
used by U-Boot with the device trees that are present in upstream linux
and this series. Thank you Samuel for all of the work you did to make
this task possible.

[1] https://github.com/skiffos/SkiffOS/tree/master/configs/allwinner/nezha
[2] https://github.com/smaeul/u-boot/commit/2e89b706f5c956a70c989cd31665f1429e9a0b48
[3] https://lore.kernel.org/all/20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com/
[4] https://lore.kernel.org/lkml/20240719-support_vendor_extensions-v3-4-0af7587bbec0@rivosinc.com/T/

---
Changes in v11:
- Fix an issue where the mitigation was not being properly skipped when
  requested
- Fix vstate_discard issue
- Fix issue when -1 was passed into
  __riscv_isa_vendor_extension_available()
- Remove some artifacts from being placed in the test directory
- Link to v10: https://lore.kernel.org/r/20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com

Changes in v10:
- In DT probing disable vector with new function to clear vendor
  extension bits for xtheadvector
- Add ghostwrite mitigations for c9xx CPUs. This disables xtheadvector
  unless mitigations=off is set as a kernel boot arg
- Link to v9: https://lore.kernel.org/r/20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com

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
Charlie Jenkins (13):
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
      riscv: Add ghostwrite vulnerability

Heiko Stuebner (1):
      RISC-V: define the elements of the VCSR vector CSR

 Documentation/arch/riscv/hwprobe.rst               |  10 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |  19 ++
 .../devicetree/bindings/riscv/extensions.yaml      |  10 +
 arch/riscv/Kconfig.errata                          |  11 +
 arch/riscv/Kconfig.vendor                          |  26 ++
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi      |   3 +-
 arch/riscv/errata/thead/errata.c                   |  28 ++
 arch/riscv/include/asm/bugs.h                      |  22 ++
 arch/riscv/include/asm/cpufeature.h                |   2 +
 arch/riscv/include/asm/csr.h                       |  15 +
 arch/riscv/include/asm/errata_list.h               |   3 +-
 arch/riscv/include/asm/hwprobe.h                   |   3 +-
 arch/riscv/include/asm/switch_to.h                 |   2 +-
 arch/riscv/include/asm/vector.h                    | 222 +++++++++++----
 arch/riscv/include/asm/vendor_extensions/thead.h   |  47 ++++
 .../include/asm/vendor_extensions/thead_hwprobe.h  |  19 ++
 .../include/asm/vendor_extensions/vendor_hwprobe.h |  37 +++
 arch/riscv/include/uapi/asm/hwprobe.h              |   3 +-
 arch/riscv/include/uapi/asm/vendor/thead.h         |   3 +
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/bugs.c                           |  60 ++++
 arch/riscv/kernel/cpufeature.c                     |  59 +++-
 arch/riscv/kernel/kernel_mode_vector.c             |   8 +-
 arch/riscv/kernel/process.c                        |   4 +-
 arch/riscv/kernel/signal.c                         |   6 +-
 arch/riscv/kernel/sys_hwprobe.c                    |   5 +
 arch/riscv/kernel/vector.c                         |  24 +-
 arch/riscv/kernel/vendor_extensions.c              |  10 +
 arch/riscv/kernel/vendor_extensions/Makefile       |   2 +
 arch/riscv/kernel/vendor_extensions/thead.c        |  29 ++
 .../riscv/kernel/vendor_extensions/thead_hwprobe.c |  19 ++
 drivers/base/cpu.c                                 |   3 +
 include/linux/cpu.h                                |   1 +
 tools/testing/selftests/riscv/vector/.gitignore    |   3 +-
 tools/testing/selftests/riscv/vector/Makefile      |  17 +-
 .../selftests/riscv/vector/v_exec_initval_nolibc.c |  94 +++++++
 tools/testing/selftests/riscv/vector/v_helpers.c   |  68 +++++
 tools/testing/selftests/riscv/vector/v_helpers.h   |   8 +
 tools/testing/selftests/riscv/vector/v_initval.c   |  22 ++
 .../selftests/riscv/vector/v_initval_nolibc.c      |  68 -----
 .../selftests/riscv/vector/vstate_exec_nolibc.c    |  20 +-
 .../testing/selftests/riscv/vector/vstate_prctl.c  | 305 +++++++++++++--------
 42 files changed, 1051 insertions(+), 271 deletions(-)
---
base-commit: 0eb512779d642b21ced83778287a0f7a3ca8f2a1
change-id: 20240530-xtheadvector-833d3d17b423
-- 
- Charlie


