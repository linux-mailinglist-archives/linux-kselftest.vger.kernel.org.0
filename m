Return-Path: <linux-kselftest+bounces-11523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA6C9019D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 06:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD291C20DFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 04:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E783B65D;
	Mon, 10 Jun 2024 04:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="i5STZ3Fe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8B6AD58
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 04:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717994737; cv=none; b=SJdelZ4LAX4/dYxT4U5ANjhciwcnd64wLbk2lRWJR+NGlBd6SMtW17NGBOK3dTRaV+5WZmX2MrrchRwp4HERQBjQFdiY60u5+uy5nm9WzkFR1UUhpLyQ2EdeCC80NDrkcAUVNMG3zq+I5eCxOqwWkJgJC0M4Wg2tc8DI8G5MB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717994737; c=relaxed/simple;
	bh=vkSpLdTOCKmV5IhZYXnWR8/RElz7fkjEtj2s36qYkjY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M9p/N59U7O6xUDpKtfiXkJZV/itAwwG38WQsMTz62CqNnc6i5bVoLsxSGfQS4zJgWo98DskndZ/5CFta93CaMFt8q+1sJKri4kq6N8Rb+9l3vsMHQ0TDvaqAXnYg1U/SqfAyiNkGdClHe30M1b+GCrh9wHKWKxFWYQYljlA49i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=i5STZ3Fe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f70131063cso7183865ad.2
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Jun 2024 21:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717994735; x=1718599535; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dN55AJF0PHuFpfwbQ/DJHVULjunoR3y3+KEw1Zkzgt0=;
        b=i5STZ3FeaXcWmhvT5UVchXoV0MVop1kwyyYt6Cbm4CUnnSQE8ke4sr1kAqG4PJlCAU
         phxYKIJgcCWaRWB/7i0/9LGDB1zzV3403j6BMb5LSTQX5XINYO8lLeIlNT250bonSWIv
         Jbdks5kgz1nollG5X+mHB/DpLgiX7dNdi8oI8KARhI00yCTVi4QZIYMgPqXQ3r/6jiev
         bLPnwU0SuYZHZXNuUYjrC/SnKeyqeXw6ZUFIJjBFbfO3l3TY4PS79T681A7XCZ5oKKYU
         GufQaJV8C4d8eHtH/pKWHYgXSy1OXWyneT3KrIj7v2cXZ4KLg+9cCRQHlSCCegBwGf+I
         5nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717994735; x=1718599535;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dN55AJF0PHuFpfwbQ/DJHVULjunoR3y3+KEw1Zkzgt0=;
        b=gwqTkwI0UUeAfPlcMSipPSOjh4XkCcb2btowTwMF8k5khwBX6aihwQIT/w9rUUXCfE
         xU12LsVzRH+EgcMugSaaHBMb3Mi15SWT1IUjnlt25xpiy2U4dX66NKsNh0o/tFQ4ahcB
         j0pU+rL0uBVteXh98vwFmj/L+VSkUrJ6Hs7hvunxFEH2QgTusml9bNz7g35nuz5vIYs+
         LYtZqo40cJ/W5LYKqapAAdcz0i5BcvnddGqP/qJ1wXC2J8J/eRz8m5Qsc11zZkVXjD3V
         kQwVWrE2wHtx1gCSO8L+cMnrSFppgvkkEnQaztn+bFu+jAr1iqC3rzWdMgJx/jraaBrX
         8bbw==
X-Forwarded-Encrypted: i=1; AJvYcCUXJsVYkG7CUaZZR9GO/KzQ6E4o8g1Nz9w+aCeqw21g41ajOZ+mkw6pPvP/yiZT1VKpTFNSbNTF1lCoY9KZdqGGW8EoaJLPlXXzoj8oPyml
X-Gm-Message-State: AOJu0YwZ395aH+fr/8HhzBTe/erf3txMBsn6gGn0V2bOJYNq3k1AlB5I
	uLFmwY/orBXLYufMzn3CV4HUfON8ngWPaF7iXSvEiTb2tMhW3+jpi/YDDjamNKc=
X-Google-Smtp-Source: AGHT+IG9ZML7kOKf0moW7WjG6bvAFzHf7/IU/wowJpUgrFMvTbXgWuSVm5Gfggt/Rs9gPxYhtiFXlQ==
X-Received: by 2002:a17:902:e811:b0:1f7:1821:77ad with SMTP id d9443c01a7336-1f718217cbemr8801395ad.14.1717994735007;
        Sun, 09 Jun 2024 21:45:35 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76ce8asm73124095ad.77.2024.06.09.21.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 21:45:34 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 00/13] riscv: Add support for xtheadvector
Date: Sun, 09 Jun 2024 21:45:05 -0700
Message-Id: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANGEZmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU2MD3YqSjNTElLLU5JL8Il0LY+MU4xRD8yQTI2MloJaCotS0zAqwcdG
 xtbUAHd9+x14AAAA=
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717994732; l=5669;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=vkSpLdTOCKmV5IhZYXnWR8/RElz7fkjEtj2s36qYkjY=;
 b=F8iBE/qU+gWHTYOUzgJ49eC5lJBiserczetPXroe2jYge4JeZOhpyar3pRnFA6RzDVYnQPUxO
 91UulT4jaLZCLDyQtCbwIv10SEdkoX15vesDG1F1IZMrDbhIKYXPJyh
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
Charlie Jenkins (12):
      dt-bindings: riscv: Add xtheadvector ISA extension description
      dt-bindings: thead: add a vlen register length property
      riscv: dts: allwinner: Add xtheadvector to the D1/D1s devicetree
      riscv: Add thead and xtheadvector as a vendor extension
      riscv: vector: Use vlenb from DT for thead
      riscv: csr: Add CSR encodings for VCSR_VXRM/VCSR_VXSAT
      riscv: Add xtheadvector instruction definitions
      riscv: vector: Support xtheadvector save/restore
      riscv: hwprobe: Add thead vendor extension probing
      riscv: hwprobe: Document thead vendor extensions and xtheadvector extension
      selftests: riscv: Fix vector tests
      selftests: riscv: Support xtheadvector in vector tests

Heiko Stuebner (1):
      RISC-V: define the elements of the VCSR vector CSR

 Documentation/arch/riscv/hwprobe.rst               |  10 +
 .../devicetree/bindings/riscv/extensions.yaml      |  10 +
 Documentation/devicetree/bindings/riscv/thead.yaml |   7 +
 arch/riscv/Kconfig.vendor                          |  26 ++
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi      |   3 +-
 arch/riscv/include/asm/cpufeature.h                |   2 +
 arch/riscv/include/asm/csr.h                       |  13 +
 arch/riscv/include/asm/hwprobe.h                   |   4 +-
 arch/riscv/include/asm/switch_to.h                 |   2 +-
 arch/riscv/include/asm/vector.h                    | 249 +++++++++++++----
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
 34 files changed, 898 insertions(+), 271 deletions(-)
---
base-commit: 11cc01d4d2af304b7288251aad7e03315db8dffc
change-id: 20240530-xtheadvector-833d3d17b423
-- 
- Charlie


