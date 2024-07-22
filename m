Return-Path: <linux-kselftest+bounces-14007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC809395BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 23:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B2E2822E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 21:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E640345014;
	Mon, 22 Jul 2024 21:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QgRsKGqQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09F43C099
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685493; cv=none; b=jKKz+2+sOFfdsFvn/x5a3d09sQxsJvrSkt2ouU7EdGZOaeHxNsvbr/KZlQCieO8momYq4rNc0k/nPgpJA89a9OOA0OXUviK7Eykshla32aR9yWd7OldnqKjnK7K7gw5GnLzngzyVcFwPkY8OALuHXLZTRzR86BLKKNKMmtHbTJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685493; c=relaxed/simple;
	bh=yJtg1hTrBiZ4CAX9VN8QzkdggpJgnALtnkaOzGygba8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OZmrnXrcJacmUQY+SgAMg/9LdUCqsxAqfmTLohilOgD5plVD0nfSTpXJvgMlprBceti+ZBxJyKw2TZOuJm5WiL+z7bvLkeE4jo4C+pw5m9lxN3OwHWkQGaw2p3ZaRSUSrfiRmgiWS5fIeru4szQkeXCS2CBt6SASFtMKXcOm/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QgRsKGqQ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7669d62b5bfso86826a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721685491; x=1722290291; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wKNXrH3uRfrUHwuvmyxzEYstiGhgKC7vXRXEaoabqN8=;
        b=QgRsKGqQ5I7pUG4hSMn9P8LCtPMQtGRg1/NP3rMsUAHPIVy+Xb9PWS5O5k7tkBAcov
         ExLQekVHQInMFoESOn25yuOhFotSlIu+QSAqBMZEYzDhuKYiI3rvnC9pxrGSShY+f6pz
         LaRZeL+JtvGeB0iZOb0ynxLuQGhZNyrgHH8VbfU+g6eN90c3w2HxnFbOZ3YnxyJ2dd7f
         hvvwuahV8/l8InTaPmDG0mhYmnaf4Tasaw9zU7m0VxQZX+aPONNe84DDRUMMk2KtXs3g
         bMZu4QHEaiXsSYQSxh2BIQ0nl8d9Q0z8evzcHyHPRHFsWe8SORCjUg6jY41YSX6aHP5P
         xQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685491; x=1722290291;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKNXrH3uRfrUHwuvmyxzEYstiGhgKC7vXRXEaoabqN8=;
        b=WiK9xm8G4chvpaeAJXFlhTV1CxJ23pC/uNauvZ4mOkpaX61FAXax+g459QK67TfAEs
         hIR2v+wdsir8AAK8kZPLLxarN7LhmMLTDk/TiFgA9XFA+6n/xKkvC6B7G2e4Xtld/iy3
         U0yH2253WZYkZ+DyzPLwfU89BqpHu8og9jz70igDe+lYtyrDo06yIFMiIxYplSIyzkMS
         kQFYdm1WU7yyrA1BvoDyfPYsD5UFse3swACEI+8oKseUGsPoxeTkEECgnt+2yDQJnzKK
         2A25HsepzTgvGLlAIajJf/d8hYToCxSfCc2pbAWUvU7auYCaqc6JE+Lgf+f09UMmvKHj
         uFCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoWK9RrDgcYnpRJtt4fUzdFmgQNd+UQ4bS2itcfDefE6FV0LCirKtEs2gRFU7YAzoK3o+YoRmG8QS5qiEXiKqJo7nJV1x6qKTdABAl6cc9
X-Gm-Message-State: AOJu0YzyUyosa+w/0ovQHSZYWKgRoKDW2uEo+nM8NHxMojH3z7+OqbQc
	zdDH+7quw81xgk+gCTIVWPqPRDBku9PUKZq0JHv16GhzxDnrigljuUW+SVCiw6g=
X-Google-Smtp-Source: AGHT+IEJKHWbrGpgFOQo0ZxK3srMWG+z72k5/Eg5bPpA7ScCrmMHr65nXQSYsTaNjh4B+JI/xRRVyw==
X-Received: by 2002:a05:6a20:6a12:b0:1c0:e288:e5b3 with SMTP id adf61e73a8af0-1c42857a5damr7306720637.25.1721685491022;
        Mon, 22 Jul 2024 14:58:11 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f44f0d4sm59997775ad.219.2024.07.22.14.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:58:10 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v6 00/13] riscv: Add support for xtheadvector
Date: Mon, 22 Jul 2024 14:58:04 -0700
Message-Id: <20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOzVnmYC/23OTW7DIBAF4KtErEsFDD+mq96j6sLAULOoHUGEU
 kW+eyfpoq7r5RvxvceNNawFG3s53VjFXlpZZgr26cTiNM4fyEuizJRQWhgQ/HqZcEwd42WpfAB
 IkKQLWgEjcq6Yy/VR9/ZOeSqNnn092ru8X3+KrPB/i7rkgkNG42VyWQr/WktfWpnjc1w+2b2rq
 42Xu490Rd67UQ9WwpisPvCw9ft9IB9yBo/BWzvggde/3gm185q8CrQ8KJGClAfebPy/fUNeBz2
 YHF0yJu/8uq7fLN52hqsBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721685488; l=6875;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=yJtg1hTrBiZ4CAX9VN8QzkdggpJgnALtnkaOzGygba8=;
 b=EX6Nu4zGRD0+PPZ7gxDAwTcdVHl3/BJzl/QQ5Q2W2vu1jtJyYogBu9j/9LMXPyInz8LZGIQ2E
 DOWFDmPCD1QAlslrRS5csADVT2AZrYHd7zb/5/HNIBCLHqTxQQ/ZpFy
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
 arch/riscv/include/asm/vector.h                    | 223 ++++++++++++----
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
 34 files changed, 889 insertions(+), 273 deletions(-)
---
base-commit: 554462ced9ac97487c8f725fe466a9c20ed87521
change-id: 20240530-xtheadvector-833d3d17b423
-- 
- Charlie


