Return-Path: <linux-kselftest+bounces-3611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495783D1AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 01:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E70C28FEDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 00:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A9B385;
	Fri, 26 Jan 2024 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="dvHNnoNc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31927613C
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jan 2024 00:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230177; cv=none; b=XI7YsL0CwI1SgyobbBBwRieY4bxYBgbaYaPM5pfhWW4G4mHyMwgCncmtPWpSWgrhYHbpGrWiF8Zoy40Lgn0VcEFlRNNIHPB0AyM+HGFvFMW0AvNck3d0bj7GQX+Zg1IYFSF2/wpQIfv0latBcZ532TAkmbDT+x+SrNIIiw1S7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230177; c=relaxed/simple;
	bh=rmWhFcdsNxXUSCMQDXz+88zqGib8RUJOK7+Sza9SDSU=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=D6yiHRjLgvImJAXjtBcNuC/6EGJZawv2DmOafF0kSb0tRQ2pWQ+x7wUMCHIM0QVZEOGK3J21WjTFWUa1MdJ1VEhbPBzgQQL3/Lia9NX/KTu3O3TR9G3yfQ6ZEgfN0wEOS2CgdS2K1T1K8qj3cbLwTFKrZH2tWrCqGDMfhsvUC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=dvHNnoNc; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ddcfda697cso955541b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 16:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706230175; x=1706834975; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N9uafrp3fc4kGAl+934fREdGS1qqPDapu09Ox74QV9k=;
        b=dvHNnoNcn9Ak+bO49m4RCUXYkqw2knyqlNyIuSOfmndNWVTO2csz2nq62H/Vy0kYjB
         2nt+TVY72vkWvbwLXmIUk+JPmUirMyhgNh5zE9jqCL/Yda4V7ZbNG7S0n02+K78xtPsH
         dnvmNvmDo90DtC9yDu9G/a1hjWO5hO+ZW19WbH6RpE3ohvTUHVFiLafBY0yW833DIN/a
         Cb3HzcQiuhzWOakdQTx7HcjNs72qEo1v9ukUts5KaKRtgmVoQ96I1R+eshdtRZ9Yk1H7
         QSU3TuyZBsWtYYvR4XMUPtqaX0O5gq01UluF1AAmckXp2ZzDLwssTbxfO/D5FPuWOCiJ
         YKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706230175; x=1706834975;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9uafrp3fc4kGAl+934fREdGS1qqPDapu09Ox74QV9k=;
        b=W8lmX35w6cakHQAjQDwifM6xAGCN+1rKeV+D81dZG9+BFpFEFemvV/7x6Ce7rD9/pz
         J+RXVUE9Cw+ZLJCHuyhw8g299wAqSRLQT4XjQiZER1kcc50GebnNT1wSti6488rqc7Mo
         ve1ULxXlIrJNh+QhTHaxKx78gf79pVbegAP+0vCIooz1jwy4VlXV+1niIkYe3Zr9wTqZ
         ++qvtgkNYNYh+vKeQIK6x7KX+RxJlSvVF1qhv+P0oFGdgZJxKNvV735yBns/Z0jDyM5w
         us5JBoC999ikTuS4FgVvKA/zqZo6utMqopA3uQO8bSwp86gab5BD2gmb/HV4W4M3KQFP
         IZdA==
X-Gm-Message-State: AOJu0Yw7VMzOWZC7kiM5CF7L2qLOR+hl08L+uBDlkfXnZETM1Qp9xVzC
	6LCpD5X7RMMtH0Mq4sAd0w8+J96nbXBI+a63caipNkwp91PKa1Ioi8cggNBpEosrGV6ILQcbruh
	FFHU=
X-Google-Smtp-Source: AGHT+IGTw60AL2/QSO7IQBzuDEZvA/+8ojkClvQTTaJeMzWmVLrDtGwe+eObUIcOM0vm3ouFVLKOPg==
X-Received: by 2002:a62:ab0a:0:b0:6dd:853c:21ca with SMTP id p10-20020a62ab0a000000b006dd853c21camr446272pff.64.1706230175477;
        Thu, 25 Jan 2024 16:49:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s191-20020a6377c8000000b005c67a388836sm111121pgc.62.2024.01.25.16.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 16:49:35 -0800 (PST)
Message-ID: <65b3019f.630a0220.80979.0576@mx.google.com>
Date: Thu, 25 Jan 2024 16:49:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.8-rc1-5-g93ffe3f1e97da
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 5 builds: 2 failed, 3 passed, 2 errors,
 6 warnings (v6.8-rc1-5-g93ffe3f1e97da)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 5 builds: 2 failed, 3 passed, 2 errors, 6 warnings (=
v6.8-rc1-5-g93ffe3f1e97da)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.8-rc1-5-g93ffe3f1e97da/

Tree: kselftest
Branch: fixes
Git Describe: v6.8-rc1-5-g93ffe3f1e97da
Git Commit: 93ffe3f1e97da3657451004145e767f88ca218c6
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Build Failures Detected:

i386:
    i386_defconfig+kselftest: (gcc-10) FAIL

x86_64:
    x86_64_defconfig+kselftest: (gcc-10) FAIL

Errors and Warnings Detected:

arm64:
    defconfig+kselftest (gcc-10): 1 warning
    defconfig+kselftest+arm64-chromebook (gcc-10): 1 warning

arm:
    multi_v7_defconfig+kselftest (gcc-10): 1 warning

i386:
    i386_defconfig+kselftest (gcc-10): 1 error, 1 warning

x86_64:
    x86_64_defconfig+kselftest (gcc-10): 1 error, 1 warning
    x86_64_defconfig+kselftest (clang-16): 1 warning

Errors summary:

    2    include/linux/fortify-string.h:57:29: error: =E2=80=98__builtin_me=
mcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings summary:

    2    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_=
memcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]
    2    cc1: all warnings being treated as errors
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x14cfd6

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_memcp=
y=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 1 warning, 0 section mismatches

Warnings:
    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_memcp=
y=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning,=
 0 section mismatches

Errors:
    include/linux/fortify-string.h:57:29: error: =E2=80=98__builtin_memcpy=
=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings:
    cc1: all warnings being treated as errors

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warn=
ing, 0 section mismatches

Warnings:
    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_memcp=
y=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 1 warn=
ing, 0 section mismatches

Errors:
    include/linux/fortify-string.h:57:29: error: =E2=80=98__builtin_memcpy=
=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings:
    cc1: all warnings being treated as errors

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14cfd6

---
For more info write to <info@kernelci.org>

