Return-Path: <linux-kselftest+bounces-7163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FCC89850C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 12:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAB3287917
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 10:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54697F7C1;
	Thu,  4 Apr 2024 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="m9/oW3Kj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3051865B
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226866; cv=none; b=j/c8JMa1ZR5DrKTeco15m2Y2HxfT6+K/TXuBbuR0OD/SqWYP+ly0oX+9iyxIBregaSnOIiu0Yuy4AxnNJWtSUbfT9GdpPX0p/zZmPN0f1wCRRavuPqUvlqYCIVG42szcJ2PRAAL2WbZvAgzn+UudOGZfc8l8/QUk2Zq8R01SeMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226866; c=relaxed/simple;
	bh=2/q4jfOj6U1einCYXJdHvK78eAQ3vHaYbSRzBTdpsBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P/aYeN+F+BCjFtwWlKznP/9E6mn/bQrHUCyga//JRfBNnnQZNh5TeSzVEBX8yGYh9gCDxx9IPLX4ewpOQsKjq5aS6ChZ30Jgagvj9yubXLc1fZhzC3EmbdypxVi7tk5n//K0jLWdgIILF6GO4+inPv4Bebscik9PWsrJ2dvO/rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=m9/oW3Kj; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d84a5f4a20so1728541fa.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712226863; x=1712831663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h0yWpEBMuRREaN4Rfpr4/p3Cbe2kX6z7SdkYvYffV00=;
        b=m9/oW3KjpOr27N9nfPPmNzaCEB8cK9KH3zQA+Xy7uidbef5hRIvmfyD1u9Y06YStT+
         BzPXWgetDznouQS8INkOz2wS91EWVtiApc5C1/l5PhRXvJhKI4+/+kX2gqDhpRIJrIi5
         HUeipZ+CFkuPtDzHlw5I4YWsYBMydVUwnJ7UKmE4RH4HjmQIw3TDdx0uXM5vnB8NA+fv
         nT1CCzOP+mdWKaAxpx6Wo5GWFhLq/TeKDcxbUXNkhuR/f5k8Iwa/RQKndW1+aKlQ6Uum
         DkdXKyrZ14urAGlK7qL+nAvTTf8kZEwT+BF5nAlk8WypzhpmTcwnHa4bBu477jftqZfc
         ZArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712226863; x=1712831663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0yWpEBMuRREaN4Rfpr4/p3Cbe2kX6z7SdkYvYffV00=;
        b=aj90RT4dX/vvcjMI6GZPNd3bkT4z0g04vI0L4V0faobBPh42A6+AUJhc8ydh5PNBPD
         /xAYH0iZtKhMbp2SiYJs2TSVI7kh1iKouOYACJQumdn+K92lQZNlka+KxfbfamWQwOpi
         GMuxR4zQOTLJFCEgyCkfj1S9reSo73UCONOjwPiTl/6QfFbWNLECpZhimWO+wv0XLZ8V
         3HIDEKfMFB7ptIKab7Qpy5NtM4JIWi936xgPxiZrNcNxliUwDJD3B+IdvFLUrEM7La7t
         5+aqVeUvC9J48mnuWWF16nDfM3w9VFB5I6++n1NCLV0A+MmIhkEBUpVCf72xyVIh2Dc0
         ReIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHuXLfW19tTmV+EZCuzUlvpi0Q5UZ+S7/7Vmx1J9sDR4lS76GtKqZw8PbEFgtnAprV7iHvgzNrOw/1yphUWARCy2e505/dmtBWypPbMk9i
X-Gm-Message-State: AOJu0YzQDY+H86NQUo6gx4XDMb0U/ayCHckGDDuRp0xYq1NMBzN+IItv
	RMXX0Qn2YjDwMJ0ywl0WA7Oq/XTN3q4EdOIxlzJxMetSfoGXQ9jihbCDsafrBm4=
X-Google-Smtp-Source: AGHT+IGgwXcPXNss81WaNWWIVnkPiMwtrKqgSEy7SDtHw2OIS4sQFnmrJ6LWngbeMCuWYCY0SDTSXA==
X-Received: by 2002:a2e:99cf:0:b0:2d6:c59e:37bd with SMTP id l15-20020a2e99cf000000b002d6c59e37bdmr1469136ljj.3.1712226862690;
        Thu, 04 Apr 2024 03:34:22 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:555b:1d2e:132d:dd32])
        by smtp.gmail.com with ESMTPSA id ju8-20020a05600c56c800b00416253a0dbdsm2171340wmb.36.2024.04.04.03.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:34:22 -0700 (PDT)
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
Subject: [PATCH 0/5] Add parsing for Zimop ISA extension
Date: Thu,  4 Apr 2024 12:32:46 +0200
Message-ID: <20240404103254.1752834-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Zimop ISA extension was ratified recently. This series adds support
for parsing it from riscv,isa, hwprobe export and kvm support for
Guest/VM.

Clément Léger (5):
  dt-bindings: riscv: add Zimop ISA extension description
  riscv: add ISA extension parsing for Zimop
  riscv: hwprobe: export Zimop ISA extension
  RISC-V: KVM: Allow Zimop extension for Guest/VM
  KVM: riscv: selftests: Add Zimop extension to get-reg-list test

 Documentation/arch/riscv/hwprobe.rst                    | 4 ++++
 Documentation/devicetree/bindings/riscv/extensions.yaml | 5 +++++
 arch/riscv/include/asm/hwcap.h                          | 1 +
 arch/riscv/include/uapi/asm/hwprobe.h                   | 1 +
 arch/riscv/include/uapi/asm/kvm.h                       | 1 +
 arch/riscv/kernel/cpufeature.c                          | 1 +
 arch/riscv/kernel/sys_hwprobe.c                         | 1 +
 arch/riscv/kvm/vcpu_onereg.c                            | 2 ++
 tools/testing/selftests/kvm/riscv/get-reg-list.c        | 4 ++++
 9 files changed, 20 insertions(+)

-- 
2.43.0


