Return-Path: <linux-kselftest+bounces-19903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074969A172E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 02:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62E31F2617E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 00:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B0F79C0;
	Thu, 17 Oct 2024 00:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="fMaWLHVh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F11CD02
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 00:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729125161; cv=none; b=ttHIxpxjQkntGYPMP9fDXUU2PMJgnVrm2te1Yz8vnf9nXrzX4MvynMk21nl0O0fmYMUKRbdAzHaZ3iqQ2E3GRuo/XyKDyO5akgWdu8KEMtCGMYH67mHgJgHLXk0yM/UkBcvWYt6Zlfxk/71CwPZsmMn/0BCDHxjqSR0F/x50IhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729125161; c=relaxed/simple;
	bh=pD3LrBBqcKpCc42hohiOonrkRNu89QzmxP2MJIt/SFU=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=SstcVWmqC05ChM4Z0AUK+zH2ZaybvFff5Lt9ExFV48kEFXkCpUx904D8zvIzapkr5EUavIC59vMmiKnd835FJzcPCR25WZ/Q7fiplSghWiP0uvQq9cLeBN+zXmgmAPAu1/UlLVGAkumt/5aq/3YUpA9FYPUxkWL90Dm+pO/OzCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=fMaWLHVh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2eb9dde40so313868a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 17:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1729125158; x=1729729958; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U9re6ZuqqHvQFP6C0AWivpOQhxp21ATQJ0ak/9Y7lO0=;
        b=fMaWLHVh+DzsRX5voQ/oN54ETyD0o0QrsvlIwAb4P6H8GGv3Tii1e2KR6QgB411CdU
         8rxBMC0gCXXmRUgg+FpaW+e2s9yI7fdJfLtUnNawj0JHWtwLBTB7A9SzkHDoHwLtCwff
         CAjBDR/L2h/C5hy8Wp7xEJ1nE5/nE2JAmqZClId070EFlULOmcSOYVGLl3fIUgCnMI5r
         ZUc5dLNrK2QMcVRnYJ3hAKG0aoS0FZrsCnzP5btJsmnqz7+FnMu0dZEotkbksyq4DKxE
         DFYqP7GH33GLMLCWtBzJJ0ttrjdxxc4kwaUM6+u6kBGBni9ESt/NSuLYviUz1qvmvoFF
         Chsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729125158; x=1729729958;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9re6ZuqqHvQFP6C0AWivpOQhxp21ATQJ0ak/9Y7lO0=;
        b=fb2cIfquerjMsmBYSdUHJ6fYJkW2mQdg7zeycx2ZM3xcZOHJXDBFPyNXDpsB6mOqq2
         NbhjA5OY82CSWxA3VoAAW7bfrk4hRGkRz8wN2dkTI7Q2Or3ZUFjB69SSoASPmd0nwm0T
         GUbgzxzOFI+weac31v2kSHXRuc0CImecbwRCEslNrUW2H0CWFvnL6z9HGAQNfnbJIoTI
         favVeRh4N1QtVdbDRlskWhd/8K0qqDPOLYPnmC33rj8QVTgDfAcUimRLnX8m/fGS9+QE
         qgDJYUI24qVNZuD48DVxr/u8GVP4QiyxjfehCEcL/MxhGMBpXMdlRdlF1KFUJbFVaj23
         vhNg==
X-Forwarded-Encrypted: i=1; AJvYcCWRmcuKSXveyzugYwm/ZE1ihjbjGXTTab6LV2xFqOTV0kwtxQAoQMTlNBaSB9BLutpwJCMsjdKCEVdTh0A1yJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2TwA9S9QH1buKAgX3HbuyaixIaJFVx4pQGzCspfnO7TQ1dTZs
	UKvsdSWjX5lHSeKepBhMp4UIO7J+Izc3FufAL06BmByyYzZFTCaP5qSX45cHoQBV6Ra3x9DYRzL
	taUMDrA==
X-Google-Smtp-Source: AGHT+IE28zrIWEGNqM0GWRdnccl60Iqvl1pY1kLZP5ro7ykqfbyZkPfNA4AZo6cZai0z1RnMjYMu+w==
X-Received: by 2002:a17:90a:ee93:b0:2e2:cf6d:33fd with SMTP id 98e67ed59e1d1-2e2f0d91f22mr23264727a91.31.1729125157834;
        Wed, 16 Oct 2024 17:32:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e090857esm466446a91.52.2024.10.16.17.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 17:32:37 -0700 (PDT)
Message-ID: <67105b25.170a0220.137f5a.1e46@mx.google.com>
Date: Wed, 16 Oct 2024 17:32:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux_kselftest-fixes-6.12-rc3-1-gfe05c40ca9c1
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 4 builds: 1 failed, 3 passed,
 1 warning (linux_kselftest-fixes-6.12-rc3-1-gfe05c40ca9c1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 4 builds: 1 failed, 3 passed, 1 warning (linux_kself=
test-fixes-6.12-rc3-1-gfe05c40ca9c1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux_kselftest-fixes-6.12-rc3-1-gfe05c40ca9c1/

Tree: kselftest
Branch: fixes
Git Describe: linux_kselftest-fixes-6.12-rc3-1-gfe05c40ca9c1
Git Commit: fe05c40ca9c18cfdb003f639a30fc78a7ab49519
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Build Failure Detected:

arm64:
    defconfig+kselftest+arm64-chromebook: (clang-16) FAIL

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x14fd19

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-16) =E2=80=94 FAIL, 0 er=
rors, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-12) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-12) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x14fd19

---
For more info write to <info@kernelci.org>

