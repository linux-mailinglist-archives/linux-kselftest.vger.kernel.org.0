Return-Path: <linux-kselftest+bounces-27652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106AEA46C4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A3E166848
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 20:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5D010F2;
	Wed, 26 Feb 2025 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aN6dn1Pj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9DD2755E7
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601513; cv=none; b=j6p4g19QG0W2TUsg5QFsFe0Iox6X83d0IxbHRbYAqpa39xJM0j4zBjntX+f+5dqLVB7htjCfdJ06tvYlgy55kI+pjCKJOS9ZbfTf8DZ8aUIez+eZYWaizjHb5XzWpKP2kFZaivuJm+BJeqzq/KKbV4ooY0sFvxLQiSzwPJCh+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601513; c=relaxed/simple;
	bh=yOcQZkrZis4oPMTtV8S4se5F1ZKwXkbDx7myJ+Yf7Ck=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jcm4YtSHtRcp24CGUJsp6P5ZkBj004OF6r4dBuGBkihNuAj2sgfY9ijbV67xt/WLMeA+VPtqxD9qjExNKxxJ/CpwiIcs9SxP9rpxBylU+sYJIGymoJEGBXfRjcj7LZPRE8Eus4KKpP2TST32mdBK463ReyeN82OzQ2vsHC2FsH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aN6dn1Pj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2210d92292eso4205645ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 12:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740601510; x=1741206310; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vJfRhZEo2RIsfouA3ZbiUgm3ilY6Xa6tZ9F+JSMVv7o=;
        b=aN6dn1PjypZ0jQ5nNomEVa5i5fmA/Svbi1mljVduCK/K2AP1n7Qk8J9JItBWeG2LoU
         3agWvhMMtKi8UPVsu9BSR+JeUEMWGHCGJonTxk7Ex+K90Pbf3DxFf7wCq1HWPh7I0zBI
         r9EwTrdM4dqLppglovkSn/R0Zbal9xzRjWXG2yD23oaZqbG/FZrux1ncTS/b1qNH8yab
         fbE8gE4hd6e/DndzjyTb6B8kpe18HgO2NgtjwATenbs69IrxwMl1zmo3e5DFC5QtXTkr
         2fFiVOhkAruagWzjbRo0i8e4eLfkg9/2WUpL8va0oq1mc5UZ6KtwqLw0ItbHca6zaoHp
         js6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740601510; x=1741206310;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJfRhZEo2RIsfouA3ZbiUgm3ilY6Xa6tZ9F+JSMVv7o=;
        b=cYCujTuxVvEeDAbOMOiofHbYCiUzV564VKVUcxLhxAFhPKq2OyWU1JgP/B+EP39kzw
         sLrwuXRPiV75mf/S86oP3V7+dFYkN4IMX+JzKIh7mFYlFEe5vqpJvxafHxmIPgfGKwJe
         ePo6dt8xi11bU4iZQ6tWk/BCEH8Itmotddv7GsOhhnPIzZueZ/bi4x+rVqE4hNNlFxe+
         3h7FVjCa0z1/mpogM6R8P6M2tGHlPJxy4Jz3aFNLfYFuINVy52dqoGI313i1H5JZjZ3Z
         jTo0+H4pyv/K3rLo4hvkTZ7GbpisTGlwd9qOlnWeGLCu022lfh4z76X7Up/ewmHletcF
         VmYw==
X-Forwarded-Encrypted: i=1; AJvYcCUP+df+p6vGBfAGLjSg2iIQEYbeCLrsPSVsi4LZJGkTcWTWJJHjSrTtenE+KlWlKJ7UbVTL6huAKlNYwPYp04E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2wm70UGbiskQup1JpvDxpcyONgiiaEqaU71vxmBGmudrUxEBS
	W9bLn1g7NnMyBmfKo/1vh1en3PKSPqK+EEH5am2y6XtHDG3lou9VS/AaeUKS9sY=
X-Gm-Gg: ASbGncuuoVdowqXS/XIiG0maZf4ATI77Ptx9RuwmgunV1/98A0W031FDG0TfqbnXQQ8
	UbPGeK9trxHlxnD5DuFe+r1f5d1Hrz7FWnunoIHvBKvMCmxVATkH5BQud3yyTvgZyUfVAr8hztn
	dQpi5DcwwI0zFjOUHjS5gqz6Pah3f4nyB1HNSJYIVequGOC2RBLESlAlA+Ps5xMyUyXPg8jXoe2
	b6sVn9GtBeeo49kZSA3dtB/kSsFvjyNVTTpniqU4xFw0u4Abn519x9dJNnEo2+k//1eW78mQBX1
	PjcfccznDDHdRVwXlRWoeYnAfo5h+fjyRNZc4RA=
X-Google-Smtp-Source: AGHT+IGBMBO+u+81QuNJ5bB+1erdTCTpC0irRH+rlBfJ+nJ9B7BPIr1HT+61UNH4TSBhiFyqAE9NUw==
X-Received: by 2002:a17:902:ccc1:b0:223:2aab:4626 with SMTP id d9443c01a7336-2232aab496bmr63446705ad.11.1740601510471;
        Wed, 26 Feb 2025 12:25:10 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f7de2sm4100963b3a.106.2025.02.26.12.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:25:10 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH 0/4] RISC-V KVM PMU fix and selftest improvement
Date: Wed, 26 Feb 2025 12:25:02 -0800
Message-Id: <20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ54v2cC/x3MQQqAIBBA0avErBNsSoiuEhGVYw2hiZIE4d2Tl
 m/x/wuRAlOEoXohUOLIlyto6gq2Y3E7CdbFgBKVRFTiTHb29p7Z+nAlEsYYLdt+xU52UCofyPD
 zH8cp5w8fth87YQAAAA==
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

This series adds a fix for KVM PMU code and improves the pmu selftest
by allowing generating precise number of interrupts. It also provided
another additional option to the overflow test that allows user to
generate custom number of LCOFI interrupts.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Atish Patra (4):
      RISC-V: KVM: Disable the kernel perf counter during configure
      KVM: riscv: selftests: Do not start the counter in the overflow handler
      KVM: riscv: selftests: Change command line option
      KVM: riscv: selftests: Allow number of interrupts to be configurable

 arch/riscv/kvm/vcpu_pmu.c                        |  1 +
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 81 ++++++++++++++++--------
 2 files changed, 57 insertions(+), 25 deletions(-)
---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250225-kvm_pmu_improve-fffd038b2404
--
Regards,
Atish patra


