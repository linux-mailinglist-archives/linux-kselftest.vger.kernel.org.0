Return-Path: <linux-kselftest+bounces-9796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD6C8C12AF
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 18:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC5C1C2101B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C3716F839;
	Thu,  9 May 2024 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dBCijhzA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEEE16E893
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272045; cv=none; b=BpeqzRpH4Aai2ZXqdP7cYwoUKn9bYIQLr6HHQjuYQi5UIcYsTBgZBjEM0bwzFbjDOwIOQcderBNhUwRGwiBZiVTAafLVS80QtT3chEHV2wRMd1Y3DoRWNFqzI1gBCcTKxPOgUqgq6JlKNaCYwrAlIVQxhly6y2M8dlpuih/57Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272045; c=relaxed/simple;
	bh=7UmJFOIZmJ0IzFbc84uj+KqOhEdAIjk/Seq8qkyzyjQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Qe8SR40+wVuLBs+bcd8BlA95S++1aYCLEQlJ7PRRc35/xcJtrgnI7FTTD27z0W8Jfph5nXgJqgEqPvU6RzchHpQBZuhleLeIgTPzE3lzMeMwF8cAwBaGHV+YhU+tW/carMx49k9lWKGV1uvRtkPDM+UyJOfrwaYQkMKNu+1ZsSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dBCijhzA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ee0132a6f3so8684685ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715272043; x=1715876843; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T6MVJPZDpjbEi2OtO01WoKmeHaM3uIeI4GUPcfpFRJE=;
        b=dBCijhzA2p8lVEepfwRgQZxBZJ2G4atutfClKPytErCpFNyQc6blfyjbvQ2GTr+Kp2
         JyeB+YwuprWMBksmnlNWekcBNdOLXywD2zx+G0MTrxzmeE/K+arnAoU05LFekNbqbtO3
         PqjJy94dPwXXFfDSdY1MIQUZ5Jep2CHtxVmqlX8U8/Og+1W5I5ssHN7mUDmAHGQZUCyR
         uBPKMnDfRS139OnIgzjgv3q1UAplG2IPnNzEdJdk/4eO/pAZC15wYDpZsd5CO81qMLg6
         sGgr+WzOrOkajFcNx4NrQD6+zUHG3ofB8xcT+03fN70sDYBg9OKuN1g8QU2/U66Nmmji
         z/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715272043; x=1715876843;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6MVJPZDpjbEi2OtO01WoKmeHaM3uIeI4GUPcfpFRJE=;
        b=Wed6TciuoF0f8XWJPoYlpuiVLEQK7jDdJBg8hofa8VRkj2e2dyfxOoWdNtLyS27/Ud
         kW588m43XOK31De0NkBPrsH1/C+ZKYvg4KLKWVJAzS8rznVFbBSFjzNr+C9804i/WMd4
         TxzFh5I4CZmu7DLNFh2ghOwndxcTt4A9yBDf2K06nuQkQLyObcKzLftU/PlbquIRTg1j
         omYDVGh4nbchMtYgGQKS+dCFOPFuTUyr34dLu2jAvHvoekHuAitJjZqXgxfSOk1ILsJC
         9VJPjM8KkPHVZq8IXpQl4fxtlYbVmNdSMwuYxHW0T8IvcRi3LD3XP3UPTl58eeX4KR2M
         03Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXLq/xZ1pFzPqaAmMRjzo/LnUB7CYyW1zUNhZo696isXkDCgeVHBJurMuNdADsQKouTbnKjqP0euYcRsWDN4kfVpES2NAPCCssil1UxEr99
X-Gm-Message-State: AOJu0Yz4gnGvh1DTXc0pRPg34wme/zXlKdrXfiMTL3DLXPyqalhABlNA
	4gLpED2Bh131S72kc+mJ1z61oFFmnKka6Iz83y7jSg/Np+aeItxpa8Um8udUwQ4=
X-Google-Smtp-Source: AGHT+IHyYFQ4n9Z2BCpwxAFocKmxELbS3p4H6chMEDQiYGq6rWVxVhmmrCJ6qfgUPoSE1gevGgRE3A==
X-Received: by 2002:a17:902:bb17:b0:1e0:115c:e03c with SMTP id d9443c01a7336-1ef43f4ce9fmr1318985ad.53.1715272042621;
        Thu, 09 May 2024 09:27:22 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13805asm16210285ad.264.2024.05.09.09.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 09:27:22 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH v5 0/8] Support Zve32[xf] and Zve64[xfd] Vector
 subextensions
Date: Fri, 10 May 2024 00:26:50 +0800
Message-Id: <20240510-zve-detection-v5-0-0711bdd26c12@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEr5PGYC/3WOQW7CMBBFr4K8ZiJ7MibQVe9RsXDsCZkFCbJTC
 4py9zrZNEVi+aT/nv5TJY7CSX3snipyliTjUMDud8r3brgwSCisUCPp2hzhJzMEnthPZQlWG30
 IGJzFRhXnFrmT+9r7Ohfu4niFqY/sthUyhJawMqeTbcCAG8Kj8r18fybpJHPlx+tS6yVNY3ys5
 3K9NN/9yDVoYIOB0Oimc8dtaTmS6U8ng686Lbr2ZNv20KKt/+nzPP8CamGCNCgBAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
 Andy Chiu <andy.chiu@sifive.com>, Guo Ren <guoren@kernel.org>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Vincent Chen <vincent.chen@sifive.com>, 
 Greentime Hu <greentime.hu@sifive.com>, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Yunhui Cui <cuiyunhui@bytedance.com>, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-a684c

The series composes of two parts. The first part Specifically,
patch 1 adds a comment at a callsite of riscv_setup_vsize to clarify how
vlenb is observed by the system. Patch 2 fixes the issue by failing the
boot process of a secondary core if vlenb mismatches.

Here is the organization of the series:
 - Patch 1, 2 provide a fix for mismatching vlen problem [1]. The
   solution is to fail secondary cores if their vlenb is not the same as
   the boot core.
 - Patch 3 is a cleanup for introducing ZVE* Vector subextensions. It
   gives the obsolete ISA parser the ability to expand ISA extensions for
   sigle letter extensions.
 - Patch 4, 5, 6 introduce Zve32x, Zve32f, Zve64x, Zve64f, Zve64d for isa
   parsing and hwprobe, and document about it.
 - Patch 7 makes has_vector() check against ZVE32X instead of V, so most
   userspace Vector supports will be available for bare ZVE32X.
 - Patch 8 updates the prctl test so that it runs on ZVE32X.

The series is tested on a QEMU and verified that booting, Vector
programs context-switch, signal, ptrace, prctl interfaces works when we
only report partial V from the ISA.

Note that the signal test was performed after applying the commit
c27fa53b858b ("riscv: Fix vector state restore in rt_sigreturn()")

This patch should be able to apply on risc-v for-next branch on top of
the commit 0a16a1728790 ("riscv: select ARCH_HAS_FAST_MULTIPLIER")

[1]: https://lore.kernel.org/all/20240228-vicinity-cornstalk-4b8eb5fe5730@spud/T/#u

Changes in v5:
 - Rebase on top of for-next
 - Update comments (1, 7)
 - Reorder the documentation patch to the front of patches that it
   documents about. (5->4)
 - Include ZVE64D to the list, which single letter V implies (6)
 - Remove ZVE32F_IMPLY_LIST (5)
 - Change the semantic of has_vector() thus rewrite patch 7
 - Remove the patch that fixes integer promotion as it is merged else
   place (8)
 - Link to v4: https://lore.kernel.org/r/20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com

Changes in v4:
 - Add a patch to trigger prctl test on ZVE32X (9)
 - Add a patch to fix integer promotion bug in hwprobe (8)
 - Fix a build fail on !CONFIG_RISCV_ISA_V (7)
 - Add more comment in the assembly code change (2)
 - Link to v3: https://lore.kernel.org/r/20240318-zve-detection-v3-0-e12d42107fa8@sifive.com

Changelog v3:
 - Include correct maintainers and mailing list into CC.
 - Cleanup isa string parser code (3)
 - Adjust extensions order and name (4, 5)
 - Refine commit message (6)

Changelog v2:
 - Update comments and commit messages (1, 2, 7)
 - Refine isa_exts[] lists for zve extensions (4)
 - Add a patch for dt-binding (5)
 - Make ZVE* extensions depend on has_vector(ZVE32X) (6, 7)

---
---
Andy Chiu (8):
      riscv: vector: add a comment when calling riscv_setup_vsize()
      riscv: smp: fail booting up smp if inconsistent vlen is detected
      riscv: cpufeature: call match_isa_ext() for single-letter extensions
      dt-bindings: riscv: add Zve32[xf] Zve64[xfd] ISA extension description
      riscv: cpufeature: add zve32[xf] and zve64[xfd] isa detection
      riscv: hwprobe: add zve Vector subextensions into hwprobe interface
      riscv: vector: adjust minimum Vector requirement to ZVE32X
      selftest: run vector prctl test for ZVE32X

 Documentation/arch/riscv/hwprobe.rst               | 15 ++++++
 .../devicetree/bindings/riscv/extensions.yaml      | 30 +++++++++++
 arch/riscv/include/asm/hwcap.h                     |  5 ++
 arch/riscv/include/asm/vector.h                    | 10 ++--
 arch/riscv/include/uapi/asm/hwprobe.h              |  5 ++
 arch/riscv/kernel/cpufeature.c                     | 60 +++++++++++++++++++---
 arch/riscv/kernel/head.S                           | 19 ++++---
 arch/riscv/kernel/smpboot.c                        | 14 +++--
 arch/riscv/kernel/sys_hwprobe.c                    | 11 +++-
 arch/riscv/kernel/vector.c                         |  5 +-
 arch/riscv/lib/uaccess.S                           |  2 +-
 .../testing/selftests/riscv/vector/vstate_prctl.c  |  6 +--
 12 files changed, 151 insertions(+), 31 deletions(-)
---
base-commit: 0a16a172879012c42f55ae8c2883e17c1e4e388f
change-id: 20240318-zve-detection-50106d2da527

Best regards,
-- 
Andy Chiu <andy.chiu@sifive.com>


