Return-Path: <linux-kselftest+bounces-14413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C294016E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 00:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E642283316
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 22:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521D71891AA;
	Mon, 29 Jul 2024 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="0alE0Koi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088613B780
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722293801; cv=none; b=npaBY44XEhqFrpC+wZgWIbc1l6/uie5gCIXbpeUjM8EPjFOmSt7pqWcDsL7mzbHu9Jxvsw/xMWtcQQuv9sEpcZq9UvHk6tvkGiwjhRUPzYFs1j9zlpDbkk8e4P8wbdpKpF3mZMEqvi84i4fo9OaLBWkDGcAoZl7spFr8B4tgloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722293801; c=relaxed/simple;
	bh=M5cUuXl/83mpot45AWEVs1AttwxEMBfx8QUhVJglvTw=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=fNd2SSu7iXoXwOATjL+zqMoR9LKX1r2NtGbkOKUC8H0yQ/Jgg6pzRGL0lQ7IpZjtyajn/+cdXdDrTjXsDCyxUcaXd/41GyA5c6GgHIEgnjuyxhWkG2EdU3Th3pTe8CNxa45FiG/aLr5f7IfRWKx0VTYkwqzInvn2vf7wMW7iWuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=0alE0Koi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc566ac769so21737435ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 15:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1722293799; x=1722898599; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0E2ZDGbCHhoaw+XyWJzF5/gKu5+yURuxBQLmT7HB/5c=;
        b=0alE0KoiN7mRyJfylrR46apRtoyT1hDGhnu6dkmXbF1mJpPhjBJ5DIuFeevatc2Qwt
         bvWStG6OM0zrnsrCsiLgWGxytWQwsRDPSYUOGoDnOSd+N4pD3e2GoaepZ9hI5tbB51by
         c3cCqo55ZBp0QsB54VabhwpF4jlKfxwtw1kqurjNsmeas+u/NTinGw3CNtVr28nktzRR
         B69RKBgqPCVK8xi/t+MEKFNH8TyZ3IyntN1Tl65qXxKY6P40yf/9VlkgIocZWYfP4zuk
         JdVNipNWMG4qIub4/2zpYKyn4CCIGON+2wmPSyuQdVziKL8hbwDb4XUfKNZDiPuX3NBe
         PK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722293799; x=1722898599;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0E2ZDGbCHhoaw+XyWJzF5/gKu5+yURuxBQLmT7HB/5c=;
        b=gWTk+eo/39r0dHVkpqRW/mg0fjQUGrB7j5fIo1vXNiZlDt1FJPSynYyJW1WcEoggmb
         eBS32EJIoyx77ZbC7ZXfWffwKqG6996lGvlz0Gzc33osfICqt2nOeQvfMEh1zh64CrP6
         Btqdsln1RGJM0lyf2XKWpFUkLbFe4wL/hTzuhD54GCyv+Z+vrIBF1Kg3OFq6kiF2rWkD
         rrGMQZHYExvIVgWnZ2ITz3ArAeuOl+Q07TPvvxW7l5hh62wWr6iT1clJE+zzA0+tBh0K
         AXoIU0YgGsWoV+k4lgMivoQYrzJ1R4okqw+lcS2LuvvZerGsPQ2hKM/PGB/okrNvVEES
         N34A==
X-Forwarded-Encrypted: i=1; AJvYcCWemejtGkxgeJc4zbGrv4bqldiOa3vyxlFKnRXzcHbcnA75EqYRak+72ED4iGTResEY91p43OaqvXZDkqlVKbBvndwInTs3jrwhLJx+FEo5
X-Gm-Message-State: AOJu0Yxx6iW6G7VvVEbrjPdcmSyUsA+xeQLGud/LPkdlG9e+EQq4OnGZ
	+Wk9AHSNlad6Yig1DywULOFkh9y63S/WSv3SgsX4SxZrXIloV0+GL0CIG1iAms4=
X-Google-Smtp-Source: AGHT+IHtItzgoN7JtCbtLAkVguwRak6uUQE3STaRtEQeDj4aeVpk9iuKz+hwkHSItqe58bSH+xO8Eg==
X-Received: by 2002:a17:903:2284:b0:1fb:8c35:6036 with SMTP id d9443c01a7336-1ff04780bb4mr83896555ad.5.1722293798954;
        Mon, 29 Jul 2024 15:56:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee2555sm88512405ad.137.2024.07.29.15.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 15:56:38 -0700 (PDT)
Message-ID: <66a81e26.170a0220.1feb86.6a74@mx.google.com>
Date: Mon, 29 Jul 2024 15:56:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.11-rc1
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 7 builds: 2 failed, 5 passed,
 1 warning (v6.11-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 7 builds: 2 failed, 5 passed, 1 warning (v6.11-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.11-rc1/

Tree: kselftest
Branch: next
Git Describe: v6.11-rc1
Git Commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Build Failures Detected:

arm64:
    defconfig+kselftest+arm64-chromebook: (clang-16) FAIL
    defconfig+kselftest+arm64-chromebook: (gcc-12) FAIL

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x14ef94

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-12) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-12) =E2=80=94 FAIL, 0 erro=
rs, 0 warnings, 0 section mismatches

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
x86_64_defconfig+kselftest (x86_64, gcc-12) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14ef94

---
For more info write to <info@kernelci.org>

