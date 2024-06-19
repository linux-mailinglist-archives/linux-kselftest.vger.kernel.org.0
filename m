Return-Path: <linux-kselftest+bounces-12224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3C690E98D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 13:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC37281477
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 11:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E08A13F428;
	Wed, 19 Jun 2024 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lSbd6Ypf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC7D13D535
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796940; cv=none; b=QlWQFKWhsLcVRTgn2N4NfdVphhY+yJA8Ut3L7mDB+IWlHgIkCheM0FObiJxJqi0EziMF4pTCCA8ew13tLwRSuFc04RISejwXw9MmO/Mk/MnZj7sfbE9JCU3sZ64caYnO8OeJyI1YNagBDfzfk5wyGnf61Z1WIQaIggTZCgRSNoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796940; c=relaxed/simple;
	bh=ogJzMFOU2z8MIyBsPO4WNFI+wnMHGOiUEXtKmmzBSjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ONDDT/t9PTwj2yeYmfFuQfNGjdh7NzO7dk5iE/11txifWEAGn6d8+7inuRAY557Lw5JJRwVErG772EGCnA4lbyyp/KcDZALWEg1+kpBhyw38jR/RFtJctRPSkh0zT27+G4nmBti1qooqGWlv40S/eB6JZn/Yx5fW61CqwzMzppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lSbd6Ypf; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec18643661so5915381fa.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 04:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718796935; x=1719401735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R68cnnEZYSz82BBlgeePthLtn1GpI/DDwCMXiGYDPIE=;
        b=lSbd6YpfkSDjIg2OsoeY0h4+xpO9ZjXOZvYt5my574rNML/8ISWsCAHkL4YFBmYLGT
         4fj4QXtLV16fWxdRHFJZFaPb4zjBXzLXv5H4HTH9qqVbpbQZhueWfE34C9KT0iUa8ZIN
         reF3MPFMzkThJ7D5iJfXyx/Tf1ZHjd9Us8novL3vFTiFbOV/Th7X3urCh+SySLRjH5L6
         HTAtHQWVVJoZ15OMqVswNBC9+EMAyzcDOxtVkPxRYzIbw73ANpDmJWV3N497AHjQ2Yc9
         tMTh8YuWhHylHgw9qVn8GYopn5JrSA4ifTvb7yMfF6rFvr5d8sjp+x5r4NUZ+SXmD9wF
         Fpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718796935; x=1719401735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R68cnnEZYSz82BBlgeePthLtn1GpI/DDwCMXiGYDPIE=;
        b=XLTSfY/cDl8Q1nl5vHDy+8cv9XsW7+LJv6yGRhCv2n/tw0Hs53lucF5jN03kTcjMkJ
         zxn7Qofwt+/Urw43sKmEOu1zwaCmDjNJ2XLELLc+VqskRfkrrGDjGRa/794ZtYKpMPja
         54ocIxzWCbzgh9AKbQCKnIB7AKKnNCoffZ8FBBrXWc7QCLuiH/t7siTyQmagYKjQxevY
         hv8+9nTt0gD2y0I5oAHmYsp9v58nttURI9F26vhhbbQqPWrxp4haPMC2PmMDxQIHZoUK
         X65Hui1UylR17ocBhWgxkrjddu4X3YD5nFZIemqBgN580PZAgVhuJyKl00ciNCKhdh0A
         sM4w==
X-Forwarded-Encrypted: i=1; AJvYcCXzV94WQlXgxYQa2iYypNgH3zHT1aCGMMxnV8E+XeykVVBupcvY/mt9BP7+JW9whX9PJh7aTIF9T7d1u/B5x+8S/qkU3xWfmifYUp2sYczV
X-Gm-Message-State: AOJu0Yxq1SsRv4QcT4Ju5xg6u0YqhpgdiEpD8f2sZgNTXkBfETZl9S1Z
	m5yNcysmcu93KJgYo5vzuYPjKaFHDc0CjtKjtJjKSXathmNUf4ekLpNv1zvX2pk=
X-Google-Smtp-Source: AGHT+IFsCC87W4xVADXKP6E1LRVpjwgMonVuzzedwVb0Jp+JNzVJhthcLxSn+Xc6UH4SRMqEmwjj+g==
X-Received: by 2002:a2e:a548:0:b0:2ec:3e14:fa1c with SMTP id 38308e7fff4ca-2ec3e14faf7mr12339341fa.5.1718796934705;
        Wed, 19 Jun 2024 04:35:34 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:e67b:7ea9:5658:701a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9681sm266192075e9.28.2024.06.19.04.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 04:35:34 -0700 (PDT)
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
Subject: [PATCH v7 00/16] Add support for a few Zc* extensions, Zcmop and Zimop
Date: Wed, 19 Jun 2024 13:35:10 +0200
Message-ID: <20240619113529.676940-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for (yet again) more RVA23U64 missing extensions. Add
support for Zimop, Zcmop, Zca, Zcf, Zcd and Zcb extensions ISA string
parsing, hwprobe and kvm support. Zce, Zcmt and Zcmp extensions have
been left out since they target microcontrollers/embedded CPUs and are
not needed by RVA23U64.

Since Zc* extensions states that C implies Zca, Zcf (if F and RV32), Zcd
(if D), this series modifies the way ISA string is parsed and now does
it in two phases. First one parses the string and the second one
validates it for the final ISA description.

Link: https://lore.kernel.org/linux-riscv/20240404103254.1752834-1-cleger@rivosinc.com/ [1]
Link: https://lore.kernel.org/all/20240409143839.558784-1-cleger@rivosinc.com/ [2]

---

v7:
 - Rebased on riscv/for-next to fix conflicts

v6:
 - Rebased on riscv/for-next
 - Remove ternary operator to use 'if()' instead in extension checks
 - v5: https://lore.kernel.org/all/20240517145302.971019-1-cleger@rivosinc.com/

v5:
 - Merged in Zimop to avoid any uneeded series dependencies
 - Rework dependency resolution loop to loop on source isa first rather
   than on all extension.
 - Disabled extensions in source isa once set in resolved isa
 - Rename riscv_resolve_isa() parameters
 - v4: https://lore.kernel.org/all/20240429150553.625165-1-cleger@rivosinc.com/

v4:
 - Modify validate() callbacks to return 0, -EPROBEDEFER or another
   error.
 - v3: https://lore.kernel.org/all/20240423124326.2532796-1-cleger@rivosinc.com/

v3:
 - Fix typo "exists" -> "exist"
 - Remove C implies Zca, Zcd, Zcf, dt-bindings rules
 - Rework ISA string resolver to handle dependencies
 - v2: https://lore.kernel.org/all/20240418124300.1387978-1-cleger@rivosinc.com/

v2:
 - Add Zc* dependencies validation in dt-bindings
 - v1: https://lore.kernel.org/lkml/20240410091106.749233-1-cleger@rivosinc.com/

Clément Léger (16):
  dt-bindings: riscv: add Zimop ISA extension description
  riscv: add ISA extension parsing for Zimop
  riscv: hwprobe: export Zimop ISA extension
  RISC-V: KVM: Allow Zimop extension for Guest/VM
  KVM: riscv: selftests: Add Zimop extension to get-reg-list test
  dt-bindings: riscv: add Zca, Zcf, Zcd and Zcb ISA extension
    description
  riscv: add ISA extensions validation callback
  riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
  riscv: hwprobe: export Zca, Zcf, Zcd and Zcb ISA extensions
  RISC-V: KVM: Allow Zca, Zcf, Zcd and Zcb extensions for Guest/VM
  KVM: riscv: selftests: Add some Zc* extensions to get-reg-list test
  dt-bindings: riscv: add Zcmop ISA extension description
  riscv: add ISA extension parsing for Zcmop
  riscv: hwprobe: export Zcmop ISA extension
  RISC-V: KVM: Allow Zcmop extension for Guest/VM
  KVM: riscv: selftests: Add Zcmop extension to get-reg-list test

 Documentation/arch/riscv/hwprobe.rst          |  28 ++
 .../devicetree/bindings/riscv/extensions.yaml |  95 ++++++
 arch/riscv/include/asm/cpufeature.h           |   1 +
 arch/riscv/include/asm/hwcap.h                |   6 +
 arch/riscv/include/uapi/asm/hwprobe.h         |   6 +
 arch/riscv/include/uapi/asm/kvm.h             |   6 +
 arch/riscv/kernel/cpufeature.c                | 277 ++++++++++++------
 arch/riscv/kernel/sys_hwprobe.c               |   6 +
 arch/riscv/kvm/vcpu_onereg.c                  |  12 +
 .../selftests/kvm/riscv/get-reg-list.c        |  24 ++
 10 files changed, 375 insertions(+), 86 deletions(-)

-- 
2.45.2


