Return-Path: <linux-kselftest+bounces-8315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19308A9A06
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 14:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6951F28353A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 12:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A0715D5AE;
	Thu, 18 Apr 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="m2Tx15Tv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020B1EA91
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444237; cv=none; b=rQTS7S1l593eqeeblzsSGEe5a3sRttjPBo5Srz+LX76gZrGTwnriRkw1Iejyn1A9qIWrYUV+zBddg6x8Q3k+QctQruahYxgHZ1PxsGUgoXV8bIfYziu245nemC8w9mlzOU5WaNAAUEzXJfTgsPXvCcXB4Ccy2CLWEsKBSqRfMvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444237; c=relaxed/simple;
	bh=BSPP+JhpgqmbSOjXMNtVSOk6UyemTIHuAPZ8lvb1GHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pl8otcxzHCnpuiK42jWrLDFdA1oqoP3r7gfQc+W8NTr5XycJl6aVzYfT8/D4jvViRGkUEAdG+kU2l/mG4ejT2vQalFezBLru0vpVIIPSFTl63G+iAJYBACzdzphkR1gtk+01+hXNAwbxHJjzYOMaO+ixocVKgiK6l+kk75uehhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=m2Tx15Tv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-346a5dea2f4so182891f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713444234; x=1714049034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32JRcAZ8LHhKBfsqOJDGu3ZSnqgwx85ZTFPgD6hMyrs=;
        b=m2Tx15TvdFRjHOdqyJyX67kMDKVBuysCC/o7Fc9xL4ucSvqrtNxR4vZRDWYRbobUGn
         bLdFWiuGaWdEo41pwwa2YLmKM+RdWZ3DXUQxl0kTRJpZrf5R+UeEKp1SCisFyZjSyHgJ
         qgrdEIO02UcnfX5osQXMANFnB0X1WEyATveHyhPHLMXnwoMCE6PhHNY71HivWRzEjxrN
         E3lwqTgFApDl2uHX3k9u6Zxb/mf34ndDFdxZXIMfFAPvk5dh79sByNmPYnVpEmgF+4t7
         NkJB5+jU3wUJojc/JesjaejkSlKV6V4HD+tFPJtt6RDgyyZxjLBScj0AT75/KIr0RJjj
         icKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444234; x=1714049034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32JRcAZ8LHhKBfsqOJDGu3ZSnqgwx85ZTFPgD6hMyrs=;
        b=CTF9lGb5v91+UnRRlCdsDgqHEsC7ou4Q0M6mwfKuCIC9MecO3KQbCAQh4RWP9Y6Qf9
         6VVUha6WgLdu1zAVYkLa1UHxhTo/lQt6qHZuP98ffi3gqzlA9Fw2+D0l0grcUmvzeMsW
         iv2H6UQZIY1jiquy141jrVl8IE2JSONbQYtOO/hmXKlmQkUJbeLX4ZZ4DFKQxkCXOSbD
         6EgKgt95j80ShsxMNzsY2mYAJ2AhZuhM3Iefpu9k8AIJFAZv16thO0tatwVeLDXKYhyY
         K7m5TTLrqw7HAPQ5cmlMpGTyPVOJsKPUNUQfjE4JzO3c4Tt7IuVhCY0GfdtE7Dp28rQW
         kgWA==
X-Forwarded-Encrypted: i=1; AJvYcCWaqXXtLD7mU0qOUuosrTaB675NBzCy2p4uFZvY5NS5Tw3nYqxJ5sKoV0dzArqoP8aJzv94BOYv/NJAOMKWiUpDRRC4Ljm1HnhD7MdArS9K
X-Gm-Message-State: AOJu0YxAZ4QAdVt8+VumQ6HbQLZG2I6M+TxSdfw7JZReMxYL+rFWmS2a
	vT2lWLuLlVNc+wHn+0XwDR1kL2pSeFs/oq2QUSFBVCcKEeBb62D0J3Yh2Ewse5M=
X-Google-Smtp-Source: AGHT+IFziCRGNRnIuKdQWAYceCQlX3IZZXZCOpe0+zYvs0VTpiLEE6booy5ASHtPCGw5+ceQDaJ+5w==
X-Received: by 2002:a05:600c:1c91:b0:418:9a5b:d51 with SMTP id k17-20020a05600c1c9100b004189a5b0d51mr2042383wms.0.1713444233704;
        Thu, 18 Apr 2024 05:43:53 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7b64:4d1d:16d8:e38b])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b00418d5b16fa2sm3373412wmb.30.2024.04.18.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:43:53 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 00/12] Add support for a few Zc* extensions as well as Zcmop
Date: Thu, 18 Apr 2024 14:42:23 +0200
Message-ID: <20240418124300.1387978-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for (yet again) more RVA23U64 missing extensions. Add
support for Zcmop, Zca, Zcf, Zcd and Zcb extensions isa string parsing,
hwprobe and kvm support. Zce, Zcmt and Zcmp extensions have been left
out since they target microcontrollers/embedded CPUs and are not needed
by RVA23U64

This series is based on the Zimop one [1].

Link: https://lore.kernel.org/linux-riscv/20240404103254.1752834-1-cleger@rivosinc.com/ [1]

---
v2:
 - Add Zc* dependencies validation in dt-bindings
 - v1: https://lore.kernel.org/lkml/20240410091106.749233-1-cleger@rivosinc.com/

Clément Léger (12):
  dt-bindings: riscv: add Zca, Zcf, Zcd and Zcb ISA extension
    description
  riscv: dts: enable Zc* extensions when needed
  dt-bindings: riscv: add Zc* extension rules implied by C extension
  riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
  riscv: hwprobe: export Zca, Zcf, Zcd and Zcb ISA extensions
  RISC-V: KVM: Allow Zca, Zcf, Zcd and Zcb extensions for Guest/VM
  KVM: riscv: selftests: Add some Zc* extensions to get-reg-list test
  dt-bindings: riscv: add Zcmop ISA extension description
  riscv: add ISA extension parsing for Zcmop
  riscv: hwprobe: export Zcmop ISA extension
  RISC-V: KVM: Allow Zcmop extension for Guest/VM
  KVM: riscv: selftests: Add Zcmop extension to get-reg-list test

 Documentation/arch/riscv/hwprobe.rst          |  24 ++
 .../devicetree/bindings/riscv/cpus.yaml       |   8 +-
 .../devicetree/bindings/riscv/extensions.yaml | 124 +++++++++
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi |   4 +-
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |  20 +-
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |   4 +-
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  20 +-
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi    |  20 +-
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |   4 +-
 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 256 +++++++++---------
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |   8 +-
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  20 +-
 arch/riscv/boot/dts/thead/th1520.dtsi         |  16 +-
 arch/riscv/include/asm/hwcap.h                |   5 +
 arch/riscv/include/uapi/asm/hwprobe.h         |   5 +
 arch/riscv/include/uapi/asm/kvm.h             |   5 +
 arch/riscv/kernel/cpufeature.c                |   5 +
 arch/riscv/kernel/sys_hwprobe.c               |   5 +
 arch/riscv/kvm/vcpu_onereg.c                  |  10 +
 .../selftests/kvm/riscv/get-reg-list.c        |  20 ++
 20 files changed, 394 insertions(+), 189 deletions(-)

-- 
2.43.0


