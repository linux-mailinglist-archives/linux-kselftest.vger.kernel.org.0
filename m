Return-Path: <linux-kselftest+bounces-17781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBF39760A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 07:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24D41C22B93
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 05:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FEE188A0D;
	Thu, 12 Sep 2024 05:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oAzXMF0f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE9188929
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120547; cv=none; b=Ies//DIS9JtCPHgcz8QmFSEuXNXTvrSBGFBHbKwzasLU/N15thKonFA7puYyDOunEoPujbeCdi4xng5igq50elkaDkWmx4I4h6013uC0XeZZw4XxCUgYXQ5wF7R+P4zifjCF1XcUyoFpY/Sy4BlDXRi23u+Qu1I8WwulMoTwedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120547; c=relaxed/simple;
	bh=o+xGimf4uv1DtTQWCqU/EUmhyATy4y8NMqx66C5v0vg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eV4nIMgRXylFoSNGHlxBy7a34uSUjARvNa2CfJTklzcg+RlVM28JpSVKQUtgK9hYqODM15gvsirc3GE9KYwine5bqErUow7AlE6dF742VEObZC7RqQPv48AqLIZ4/fo6lugJtM66uqS6dJSYhDqgsMYooL6WSgn/FUVGP+uu4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oAzXMF0f; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2054e22ce3fso6439405ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 22:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726120545; x=1726725345; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r2sJuto8J6qlx9l4vhzQd/fiMVew5qrixv4vGRu31KU=;
        b=oAzXMF0fAB3JDkL6RzLw1jfQ1JcKzn+XRXwvkQ8A9QASZbtG4yhY1o01lxOmh1JpvZ
         Mdemto91iVFp74o7ASXeNHaj12ewScJ2IAoeVL4HDYt0VZXs+Tf4TfBOV/zNkYVf2F9q
         xX+Bu34SmtJLRxvGxYRe8IC9pDA/1TiNZF8HzkfZ55DWtqenRIEiz1/mEf6USD8TgkPX
         4Rq0In4PWOvotidMSw+PgeUs+3BXUETvUsDQRKP3muApW9yaethvdnpI+3XKIcZnO0q4
         zNCB+O20wJbe3ke8O1+8Df5/leUt/N8JsrCAQrItuwnbeMAdNYLVOSCBtxPdAq3ka0mX
         ke4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726120545; x=1726725345;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2sJuto8J6qlx9l4vhzQd/fiMVew5qrixv4vGRu31KU=;
        b=EW8dw/GQSgvJKPPlktlEeMVsTgOPwWIxFHFj3ic932IjXTW7/kjTcoMa0Jmfd4Wn6E
         TBJ7O3l0/bg36/ud2ooSqB9fRHW7Ndr5pJBCRxfScQVezrnoFDH6mF6muGAhvJXpahaS
         j5yisyLh+dpittgZlZVV0+CjqiEb+tcurJTt5ZdRdRsHrdyXfUkzV8YCxRIQXqqfMGPP
         QkHi/I4Wjv6BL/1Vz8zwD7YjUp9VL6OPkhDs2UvoKSt52skVzIQZ58m7bKuVNuQhFEbR
         e20V/MMS7aN8ltVZqKQLoTw9Ff0atEWVC7N0M6H/UGHisJuGEgzpY0dszcTsfcXf/4FJ
         JgEw==
X-Forwarded-Encrypted: i=1; AJvYcCUIjpJ4XaGaMQ5qEBBXYiiN4Q/wCkb75/Q8xryr2j2MkuyzQqG+rnT5Dy8tXP56rBYiwPoGPNckvm0ri6+IUGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnlT2KUSTLInZE25MGE+tGtgHNfUT0T2FSgvZCUs7h3YUQP05I
	/blTksmmwhbD0/ODsEmR8wCne67AoRbqVr7TtKaRJlKkg+J2TdWvYvkV95eTGxQ=
X-Google-Smtp-Source: AGHT+IEA96LdD8UiE6swQbLpeiAMLHbKY/mHMp7gIRsZWC3xyHAl8dIHybcEurM26z7GNO1XLs0g1A==
X-Received: by 2002:a17:902:f693:b0:205:68a4:b2d8 with SMTP id d9443c01a7336-2076e3155e9mr27603745ad.11.1726120544539;
        Wed, 11 Sep 2024 22:55:44 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe99b6sm7870465ad.209.2024.09.11.22.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 22:55:43 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v10 00/14] riscv: Add support for xtheadvector
Date: Wed, 11 Sep 2024 22:55:08 -0700
Message-Id: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD2C4mYC/33QTU7DMBAF4Ksgrwma8fiXFfdALJzYpl7QoKSyi
 qrenUlZNBiL5Vj+3hv7Ita0lLSK54eLWFIta5mPPCA8PojpEI7vaSiRD4QEqUATDOfTIYVY03S
 al8ERRYpoRyVJMPlcUi7nW97rG8+HsvK1r1t8xe30J8iA/x1UcYCBctIeo80I/mUpdV7LcXqa5
 g+xZVW589gsUiV7b4NyBilEozqe9r7tJ/ZjzuTT6I1xqePV3VuQjVfs5cjNTkIcETte7/yffs1
 ejcrpPNmode54s/Oy7TfsJx8yIEEOAB1v91413m7vtwo9QoiBeu93/3m39WdQhPx5SLbj/d07M
 I337I0M2kQZg47t/tfr9RtvOSFLrAIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8203; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=o+xGimf4uv1DtTQWCqU/EUmhyATy4y8NMqx66C5v0vg=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9qjJvv8pmLtq1O8PO/onlrRc2Kz3zuOXctKlHMZL07xn
 SPznu9CRykLgxgHg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABPZeo7hn9ULb53WSa++pM76
 pz7jtja7ckL37tm/j1tGMZ6sW2Mc1MPw30cy7n2avPsZjvqQY8Zadow3Qo/+XcJzbrWpwsnXHcs
 3sAIA
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

The series titled "riscv: Extend cpufeature.c to detect vendor
extensions" is still under development and this series is based on that
series! [4]

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
 arch/riscv/include/asm/vector.h                    | 225 +++++++++++----
 arch/riscv/include/asm/vendor_extensions/thead.h   |  48 ++++
 .../include/asm/vendor_extensions/thead_hwprobe.h  |  19 ++
 .../include/asm/vendor_extensions/vendor_hwprobe.h |  37 +++
 arch/riscv/include/uapi/asm/hwprobe.h              |   3 +-
 arch/riscv/include/uapi/asm/vendor/thead.h         |   3 +
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/bugs.c                           |  55 ++++
 arch/riscv/kernel/cpufeature.c                     |  58 +++-
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
 42 files changed, 1048 insertions(+), 272 deletions(-)
---
base-commit: 0e3f3649d44bf1b388a7613ade14c29cbdedf075
change-id: 20240530-xtheadvector-833d3d17b423
-- 
- Charlie


