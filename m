Return-Path: <linux-kselftest+bounces-7549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD6089EE45
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 11:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42B42831CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6781615AD9A;
	Wed, 10 Apr 2024 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FdZ1AB63"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F74315AACF
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740274; cv=none; b=exu0KYqvPUHrurvkLZn+k59JQICA8PpuP4drNKUCjX+P1tdBgcL9toa7USu9WRnl5g2IhTOsWw0UqI2CxOpuMzb8Q52+p2mR2v7Yt3wmskH1i3lSSwLfVXk3bsyRKEhzM80RgCfB2KGuMC4VqlNBN3hmvmCC1tyv+HJM7gG5vHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740274; c=relaxed/simple;
	bh=02wvApY4YND9L077VdDD/SvGSk0u3FcO0EiGYiuzYnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OAqF6YI3umS4QyXP+PBkOTS0zFTVhILq4Ytt+LWiHZMpljfCjcoqp9nKseUNuj/SzcbREv2pFmHrNeuHylwYPM5vHpFG/8Zw/OBswkJwdSZ8DEnm2fEouSKcsp9qVv3OPBgUEHHDkX8o/hKo5UfcLhaA2EoOfdfHEK6X7yy16yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FdZ1AB63; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-345606e8ac0so589023f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 02:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712740270; x=1713345070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9SSkPjIJRaiY6nqvP2nXREr1dqNKWljAWGAyK7z7Oro=;
        b=FdZ1AB63nr0YKyaVj2pv8TgPftr2h7prARsnXTmUCy9rF6XEob0XnX7FZCb688LVIC
         fvEJXwZMebpTUfXJIKfCbveRhUHfxPfHVKA+9ytZ5gTKUcOfR6/quQSpeaYGu8MlioRi
         BwcZFc2B73oV7o8HReulOeM8O7MrgxXZNGxyCof8h02COqdPpv25pWYCuiTj+MBfPQzN
         WTj4zx1M+NypiM7ediOCQuqAqwJRdVuND40SMibdePC7CzuMjRz0WPyj0s64mBZB9vbb
         pwz2jjs1jeLiylmdAqMUuERRuefaSNn6m2wfhBsYSwrhcBEhJ/2y+uENsAWPD3FckMu7
         tFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740270; x=1713345070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9SSkPjIJRaiY6nqvP2nXREr1dqNKWljAWGAyK7z7Oro=;
        b=YGMv2aCoDPnzqnkoy8Haweu3doX2Jw0+n/tN88eIIi/swYXsor/emESMR4/XBgxSaw
         4praod5fCn0uO/m/VLFFfIyWIhEbLwHAXdVSjO+gDaWK6UNyWMOVD5L+GvQY8sq16T98
         6PCLjnYrkiRAFT7590y1FT4UEXgnjIOWyfHHyrBAVlsM3Ts2feBkOReffm9xnewCxYWF
         PUHT1C9MypaYwOa3DTRRTKG3lR08ZaIUcogCYgGG+N43BV+WCStHZn43abB5uNUozzBq
         c5oLzSVCBB5ATIaJ3bx5xFhKIRNo9UWI8oRirrf99K5CDxfpuIqOx+1ryDnBMmC28V2d
         1Buw==
X-Forwarded-Encrypted: i=1; AJvYcCV7hAXASYKqGzWx471WeowvJ5ZbCvsholYUrqGCFPq0k8wB3v+Pt5Zh0QNcwcHezNBoGPuXqpNYXXSEhqIlvK6XjeEyJ4JLYCT33Aj+BWLW
X-Gm-Message-State: AOJu0Yyn4SB6x12lmyCiDb7M4zRK53Osd+i10ZvLC1IXPpQaLXzL0J7K
	2CeAC5Q770hJzuEGu3vpt31ihhYy/SiX1BcsHhmn0p14M/9N1Cc0MCzr1P7u5QY=
X-Google-Smtp-Source: AGHT+IGq6GULyAjPCGB9cLzSRwOlrzNIJikNMv8sgGSqEmo6q9aRp4LbhqVra1QQcW7xHav631ZdHA==
X-Received: by 2002:a5d:4a52:0:b0:346:500f:9297 with SMTP id v18-20020a5d4a52000000b00346500f9297mr1449075wrs.2.1712740270397;
        Wed, 10 Apr 2024 02:11:10 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:d4a6:5856:3e6c:3dff])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b003456c693fa4sm9079086wrx.93.2024.04.10.02.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:11:09 -0700 (PDT)
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
Subject: [PATCH 00/10] Add support for a few Zc* extensions as well as Zcmop
Date: Wed, 10 Apr 2024 11:10:53 +0200
Message-ID: <20240410091106.749233-1-cleger@rivosinc.com>
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

Clément Léger (10):
  dt-bindings: riscv: add Zca, Zcf, Zcd and Zcb ISA extension
    description
  riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
  riscv: hwprobe: export Zca, Zcf, Zcd and Zcb ISA extensions
  RISC-V: KVM: Allow Zca, Zcf, Zcd and Zcb extensions for Guest/VM
  KVM: riscv: selftests: Add some Zc* extensions to get-reg-list test
  dt-bindings: riscv: add Zcmop ISA extension description
  riscv: add ISA extension parsing for Zcmop
  riscv: hwprobe: export Zcmop ISA extension
  RISC-V: KVM: Allow Zcmop extension for Guest/VM
  KVM: riscv: selftests: Add Zcmop extension to get-reg-list test

 Documentation/arch/riscv/hwprobe.rst          | 24 ++++++++++++
 .../devicetree/bindings/riscv/extensions.yaml | 37 +++++++++++++++++++
 arch/riscv/include/asm/hwcap.h                |  5 +++
 arch/riscv/include/uapi/asm/hwprobe.h         |  5 +++
 arch/riscv/include/uapi/asm/kvm.h             |  5 +++
 arch/riscv/kernel/cpufeature.c                |  5 +++
 arch/riscv/kernel/sys_hwprobe.c               |  5 +++
 arch/riscv/kvm/vcpu_onereg.c                  | 10 +++++
 .../selftests/kvm/riscv/get-reg-list.c        | 20 ++++++++++
 9 files changed, 116 insertions(+)

-- 
2.43.0


