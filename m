Return-Path: <linux-kselftest+bounces-14401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9EE9400DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 00:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B611F23242
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 22:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB1918EFF8;
	Mon, 29 Jul 2024 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ZHsc1p2v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23FE18A933
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290877; cv=none; b=ADo4IVL0UGTk1PqrF5Y6c8nyGSXtdlmrApluWUJ7e9FZBE9gT5lZ2C1+KCk6VxtBhfxNnWWSBXaeDFc/IltMUnyO8ympiXEm3XRQJkmo+BS1vGY0SME9qkqXQa42MvXaSxokWIwFfu1Ddvk/WvJXZ5r4ko8tHMmEMXW8x17Py5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290877; c=relaxed/simple;
	bh=vsCBABPIXGuBTk+NEVG4bZKInvnH5hzXXxIM1RKb758=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=pWLSBSD3H/zGy5tXYsgKy4nxE4WM2N+yPKkNKdf2Xm5FE5ch/Kpx3VH9peHGG7n2E++lWbLbX50BLCTp2GGQ8YItO1g7whj+xrewOYKicsf9nP193AHA9KVsU0/PnyuLpzOUpc6c4ykL6FmbW1Rfx2hrF03tf2ly8qfy6HlpMwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ZHsc1p2v; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb57e25387so2971045a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1722290875; x=1722895675; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Up6+bwsiEWX2cLXuiw33vb6loupZlBf1UXyznR/QXEY=;
        b=ZHsc1p2vhhXXTc3h4WgIQmMYQ8ixrtVZLcFmHFzW1lTarQTuhwgsCgzIInEyse52VJ
         xw+Jefo3b78VLuSVsmmfuawKFa2eZGopCoL/HhV/bWPyvgHWkg+mC1rC/4alkFZlszkP
         Ld5dAxJ2uvvXz2DxpbcG0PY/1jXg/KArJGr15RSf+Q8GpBVjQ3DHiyfZ3FigmWac3wb0
         PV1v/qai/Gav3yXW+ijZdlfhDsv1HOtFMMyMZVK+5XU8DxQk76I1yRJ9jjmm6xG0+vih
         GIrwbULiwfGvK5vQgHCsuiT0MSMn0JM3xN0m4lC/Cr6V0Fke47ygVB6I4+ysag1jkzK+
         gfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722290875; x=1722895675;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Up6+bwsiEWX2cLXuiw33vb6loupZlBf1UXyznR/QXEY=;
        b=xOTzolD7G2SHQIui4xQgE9GSmoUt/nQrtCqFIBTzkvKkSZcHxJxSQPV6FDSpjzHqLf
         Q1cBhOfHmoDS6s85jUdwU83yNS+HoKjHck8rbCrOBKGLOkDhqgsFQ5sFB4bOGmGHNYPO
         hVO9ILT9ZssdC5Ag83mJF6Oh7Khm/QO76/WOD1tJpjBi65Aboo+a44NCcKuGDTAU6l4H
         cC2v0RV6pLLNVmY//jcCcS/E0glCafKuas+FOaZg8wi/RLUK7rIxEEuENG6Kq4QXCg+J
         D9fdglpuH5YddjivaurO08ixvjLZI1sMPdjZe0VYKVgHbCBqHr5ZyAvJhJ6IhxqI1SO+
         kSTA==
X-Forwarded-Encrypted: i=1; AJvYcCWn6Ink3ljzVmfWsuR/2peOh/EQjzQmxI5KKZVNfTO2FYmnVPpo0aVIdmRsyhu9OcNwdoh1pbwFbqiBR0NdIKqFHufgKCP5GMwC44aXAza7
X-Gm-Message-State: AOJu0Ywn9NxRqxfiQSyGzHJpfZmIiVPM+1M9E6jxpimEby9q346cJ8YL
	GXN3/8maW6HAP1PWYFuOEy+GXTvLIIom+9HEd33teUuSuFSEsf37X57oqAWPkL3vyd6dzmV+uit
	Z
X-Google-Smtp-Source: AGHT+IFq9wYysbb2Zsl/M3wp5Pfs+1hlDC+JL7W2chcLJ+Tcvd07hJ+uWQqtYWfI7xG+Tr0lPApv4Q==
X-Received: by 2002:a17:90a:e64f:b0:2c9:7611:e15d with SMTP id 98e67ed59e1d1-2cf7e20a113mr10297640a91.20.1722290875109;
        Mon, 29 Jul 2024 15:07:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73eb887sm11167130a91.27.2024.07.29.15.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 15:07:54 -0700 (PDT)
Message-ID: <66a812ba.170a0220.dcd71.c398@mx.google.com>
Date: Mon, 29 Jul 2024 15:07:54 -0700 (PDT)
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
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 7 builds: 2 failed, 5 passed,
 1 warning (v6.11-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 7 builds: 2 failed, 5 passed, 1 warning (v6.11-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.11-rc1/

Tree: kselftest
Branch: fixes
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

