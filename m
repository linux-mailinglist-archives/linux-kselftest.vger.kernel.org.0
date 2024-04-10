Return-Path: <linux-kselftest+bounces-7521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1343189E9A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DF3B209E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 05:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86C8125AB;
	Wed, 10 Apr 2024 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="3aQcEjk5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBB811C94
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726438; cv=none; b=VvCbcRXCWLyV07VKPlBD4sHDqoQ4h87LuPJO5bpziriGk3GlYveburzbGDOfyDGo2pESJ6hA/YfS8zszr6qcOWHTgPHC0C27ruYd3Zl3QOj0lmIFwFobvyZTuIF0KFwuqIygLr0A5SQQwSdy3uD2EyPnQ2NIgayTYZ/6zeBUwpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726438; c=relaxed/simple;
	bh=6iMtNTAJrFhszIC9u+DtPA39hZQzzte+AGtoVRuXmSk=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=kMh2FAq18wxcrXwXA0t3TACzlewiSk5z9YN04muIrJsHK9MIuGXSwQAWgKJuMkqWbxM8B+lLKDeH8nXzH3vLC4PLyg6BJq0dGacX1RY3gFp6QRhQ2hEDw+pMMfr88q+aiNzQiv9TljwlXFs7zObujCYNtXPB8NR169gM3KzxlPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=3aQcEjk5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a2d248a2e1so4146165a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Apr 2024 22:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712726436; x=1713331236; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4wUVRoA/AngSbfMWJDc4MLO0mdL5mBLNJiQeB8Xdq6A=;
        b=3aQcEjk5QZLArWI5rIVjoxxePlptsoziPkUdyoqh7MteEmdSQ6MZawXdRcM3Q2QWqQ
         v2Pkt6DFCzy4QzxVgqAEIOFVIiTMCJDrLtFQ0fI+DZ6GQ836dhnjCZ3TtRQ/0Xwgx2/X
         ifnsPL2NJcwm0F/C+PS0qmp1ADtJFrjKXeJZSB9FEyLpYg3XxxCQ3WKr0AoYNMNtpt4i
         lkx4HJ1OdpnroEZRVyvT9SgQK+r07UWNqr9O5e4XkSBpkxMkoNOrwT07qSvJAx+Ipnvv
         +i8fHrL3yz8DzMxh/mI+FpR+k+Sga3Y0+10sP3EQ7wZn6y0ZTA/0LZiy1ZygLE8jNsRe
         8Erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712726436; x=1713331236;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wUVRoA/AngSbfMWJDc4MLO0mdL5mBLNJiQeB8Xdq6A=;
        b=M5b9MwM0feq304Wj6vEGLyHNeInxN2Z0heruBHe1miQcM8lrWk5qCRNRuGPK87stgc
         97/kyHc9gVGSxrHU6AdJ5I8IM0zK3SNEz3QqSpIWduRMbyFakunAhs8q2cnNN/FbKve7
         C3r5W+LyPbRZFj2r6fL+GQCa2fuk8PVfDTiKnqpxDQH4ENrI6Mp+49FT9AyYhk9YntaX
         mU285b+oGT6zdh3XhDqW3hXgskKSI164WE2EkGy9qfADrvBtq7cm2orACu9139ikwdTO
         AMwZH/AlolcdweToeGH9P+7dnHdeCfZ/yEB1Q7wWBxXJvw4xZhVzcmT58FTmrU5YuFqm
         f47g==
X-Forwarded-Encrypted: i=1; AJvYcCX0prpRPpKt638N1UOLrsVp24GD60ALIxwBM+cJ3NFiZBk7Kd2KEJ5Qpmfmwg6/TX5oQZfXkSLEGyzoLgnYogPdjtQxZf5f7pp8sZDCtYfT
X-Gm-Message-State: AOJu0YxydRXbIegd8mkv/rOXXTUHO9vRnawKgtSMZcI1YLNbvg5Y5qaA
	8u8f+24xXpjIRytiihlrrENV63VzoS8u/wFe2lIjrxZiP4agT6ZHM7m1FzCvn/LTx/86DSM85uX
	3oGg=
X-Google-Smtp-Source: AGHT+IGrT4AWZPNVVroMbVi3ZrkBeMm4uPQ5tf4pEA2kmD+qifcFbZISd0iLPR4JOdJ5LA92yirDLg==
X-Received: by 2002:a17:90a:784a:b0:2a5:f53:ba94 with SMTP id y10-20020a17090a784a00b002a50f53ba94mr5878671pjl.24.1712726436299;
        Tue, 09 Apr 2024 22:20:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ce17-20020a17090aff1100b002a0187d84f0sm555845pjb.20.2024.04.09.22.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 22:20:35 -0700 (PDT)
Message-ID: <661621a3.170a0220.7ba75.1a49@mx.google.com>
Date: Tue, 09 Apr 2024 22:20:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.9-rc2-16-gf8a3e7c8a5aa2
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 4 builds: 0 failed, 4 passed,
 1 warning (v6.9-rc2-16-gf8a3e7c8a5aa2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 4 builds: 0 failed, 4 passed, 1 warning (v6.9-rc2-16-=
gf8a3e7c8a5aa2)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.9-rc2-16-gf8a3e7c8a5aa2/

Tree: kselftest
Branch: next
Git Describe: v6.9-rc2-16-gf8a3e7c8a5aa2
Git Commit: f8a3e7c8a5aa2c6ba90a014edbaf827c12da80c9
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x149ce9

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x149ce9

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

