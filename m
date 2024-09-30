Return-Path: <linux-kselftest+bounces-18694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5BC98AFB7
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 00:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABEF91F23E6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 22:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD5417BB32;
	Mon, 30 Sep 2024 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="zLI9PWde"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF1155346
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734601; cv=none; b=f2NmnE2BKTG/g4oKfsoNNulZjdpmyo9RHFNMiftqvDFIcJjhlEMBQelZK8RP5N96cfGcr49ik1sGszdpcvMlFt/Lu5K2E26EYr3b9Ot6gK1JbyGeBRfXcmL8HwkVB3ugMIyp31ircI8C6zPEAtDaRTGiDrzWhV1ehV2YRsmp/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734601; c=relaxed/simple;
	bh=h0BbWv8/Gj4nUJ9F9dJAIJf26r5UJeTacWg+VnoDxcU=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=E+8sA58idnvq7aZopfR92ti8mkky4GfTGBumtogLKDAHayVk5l+mrxfn6CDBY0kMHbYl5aF3n1RotD40bE4DLNL5KkAkmzsgilAqWpdbaAecAC87wOB+DSfYJzSJUzJlRCU2sjWkPt6ZcSZa+NpBLWEXUbk1O8TA5eOuM0Sfzqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=zLI9PWde; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b7eb9e81eso16908455ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1727734599; x=1728339399; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NuwExb+ctB4d3MRyph5P0f2MPVq4R+LiM99PHkBNcmU=;
        b=zLI9PWde/QL2E6lsj+ZKT/l+GN7XKeJBVZ2JoWsvmmp1tTuYdHarrM8vfS6rMVRNdE
         F8Yqt3wAVXFHFqjMbpK6EU0UimVPms63ldjeP3kTDvk/3qvcMUSmMhKeQvzAOKe1TiNt
         qtRGWfWMVd28PPHuyUxi3ZR85YVsszM0aMjKiqu994ch3IOgGvAnohbe7u572VOeIZ2H
         DEnj675Gr0oipG1tEg7KGWWXqvPRB0u1xubb0pu1fnuU8Yf14FaJjKy1fs7+em+pLHQG
         5NIh5el9h7dF8bJdUPmh5w9I30iD59EjL4rgeX1OK/rYTHfoca3zMJVm9ysk/mqME4WI
         gOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727734599; x=1728339399;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NuwExb+ctB4d3MRyph5P0f2MPVq4R+LiM99PHkBNcmU=;
        b=sk3XoYsQu88YwMbXgzGWq4gAVKl8KsjZbXZk1h2TgW/Kj+kshAahEv9wK6DE0lLltZ
         0/3LsWMVE2GikhuZzof/bq9lQtk+JcFoZv6o0AywswlRtmmEyBcXZSIBusUHp2Mwo8JZ
         lZWjaWkSzM2w3MfE2zqrbLRVKFYStAj0vG3+uBk5bM43jEqmv5m57x+eFgCA6sXw/v35
         FnuXF5zRc88o6jtNqXvW+92GWsDtU46fBtf2YuDeUiLfrnU1BCgTsYVs6zfCgsMk4Cj7
         jn9Hiznbt6tIIzHP4fGaW+zEtvPrU9HKSpUX4Ur9GuPmeMV2TvW4DKw00kU8iEpJsisw
         WgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdKUKGxhMq+gT7a3KBvpey7Bb9WYGN1JXNBf7D7dDRNH/pDTN9iOtKi2xj2/O0eT3nmAzLEDg1mWCXOopdKQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaW9VTYEs6Qvw7eoylmOJJm2H3M5r/e9sww6XKLvucM/CbNcls
	dxEPcdcqYXujtGh5svgHfkxpR6/ntRDKa2nz6F0He4LhW+XOwcJuVkbEjbamCfypA/LEObqX1Bu
	r
X-Google-Smtp-Source: AGHT+IHCs7ars2G6zntEk8M5iKYFmZqv+V0SqwJ4uZQszivZ0c9YshL+SPjci5OeLDcKVNt76iEdUQ==
X-Received: by 2002:a17:903:32cc:b0:20b:7e0d:9b with SMTP id d9443c01a7336-20b7e0d0341mr78839635ad.18.1727734599228;
        Mon, 30 Sep 2024 15:16:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d926f7sm59176015ad.83.2024.09.30.15.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:16:38 -0700 (PDT)
Message-ID: <66fb2346.170a0220.23a1f2.8f28@mx.google.com>
Date: Mon, 30 Sep 2024 15:16:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.12-rc1-2-g010b07d11e25
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 7 builds: 2 failed, 5 passed,
 1 warning (v6.12-rc1-2-g010b07d11e25)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 7 builds: 2 failed, 5 passed, 1 warning (v6.12-rc1-2-=
g010b07d11e25)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.12-rc1-2-g010b07d11e25/

Tree: kselftest
Branch: next
Git Describe: v6.12-rc1-2-g010b07d11e25
Git Commit: 010b07d11e259e37d2cd5579b8f2b189342ececb
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

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x14fd19

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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x14fd19

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-12) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

