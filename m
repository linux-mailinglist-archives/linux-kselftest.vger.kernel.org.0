Return-Path: <linux-kselftest+bounces-14581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF57943897
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 00:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1C71C2153B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 22:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B667116CD0E;
	Wed, 31 Jul 2024 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="rwv/rV4E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A91101EE
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463633; cv=none; b=o0A4eIg3aey9E6EQr8LsH9kEdKUwPcO7nhmYePTQQHdao4hmLGGOSl+19DLQev2SHG83tnPYd+XKCdp1MlC1B1NFlG+S0FUHybJm6Y+Jz8ygbAMuhTMa0Ku4M1PLOEoVgCl7KwxXMWLptDvC24gLno3dsnhawGUq547316AqRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463633; c=relaxed/simple;
	bh=Agp/tkPcQ3tMd9t628wANzUxEliIbWbCqrBLVAho+hc=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=jdn3Xyx3qlU3Rh2ulIlrZBgBIt8n99iMJCsDjQ5PF3mt3LxB02p4WMKt4cXgs1Vtcytd7P/CS+PMTl13nUSp2TgTGSrWMPCJd1XsRrij0L18Sg0096jLgErKLPpqfGXD6aEHc4YGbDhEkwcptcyBav2yqSEvq0sUFXNCcWnrU/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=rwv/rV4E; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc52394c92so54817795ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 15:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1722463631; x=1723068431; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7j6PpWn635gl0S2VD7q3oQi3wGis71xtXRcJszX13pc=;
        b=rwv/rV4EWOYhbpzKKiHqGx2EPFcNuSPw41qZQ5sUJGIoExira59+UDEsmspsCOUFqq
         qzmrmZIeECUQISMhq7qGPIi+JUZjnAq53zgLQG/n+9ITAJFik98iFUThnDy/BrY4+kPf
         xx5BZHxOMFUumPKFxN/kPhwTGPbQTx957/3PXOmRG7J9CsVwn1SH1fMc/jUUWVFe3mvY
         oahH2IWHeI87Y0ORoFE9R1QAS8WRXznolc1xap/+KaSXjw1MzEEsS6LiJUy/xcn1P369
         v29EP5YZliAYLIFzvnTg+iuwe5SO+VuL++2feM6gauzLSTXXdtWmprY8VvTQOdZTvKyO
         3oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722463631; x=1723068431;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7j6PpWn635gl0S2VD7q3oQi3wGis71xtXRcJszX13pc=;
        b=TZ59JxG27mKgRN6Qq/tDUsRJqv9d7oHMziL24+1K1Pi8IrsA9tpIHD/n7BYCFInbh7
         L+MuEVjy0shyy3K53rACeQ0KzxInY+edx68xAPy9P0FWH39WQ+sZM7l7xzVt2IFbjm7Y
         UmnVhMBgVF1vph9mojCdqfBRlGflNIoYWsjD8xmW4WrbW2Sm+iD7mPSlaZwUldE2/6S4
         AZ8kdimh7h0fjcp8d6DWlUtTQ5wqn6oyUKRyC5TvXuokfVmXZhGM/s8MHgPyMlj5bkQ/
         9LlbclXhuTrlENcNHnu30fnZiH7nuVoXbKDCq0RimdB7khjyGv9nOHHxKcmwu1gJD9Jo
         EnVA==
X-Forwarded-Encrypted: i=1; AJvYcCXFFqyfNA34Np//8uBee+hGOpWRz5qc3fFA7Irj5+tAqaEfGMy2XaArQLBL4T/XY89G42N39kQnqGs5GKj3Fc0cOcGUJ0ZGRBofRDRbJE6J
X-Gm-Message-State: AOJu0YzKZtJwcM8TEmcuAXjZt72qgW11XG3UOnwRCmPPAo4Pv82akPey
	Vj0B1bSToSWJrWCFC2rBU++YkNJOErBVCVj5DXNo1B1ssbX39hRymgKfYXmbvnkNyeaGHD0gbBv
	S
X-Google-Smtp-Source: AGHT+IEEopCBR/secEel3lEJ/QGOxyTdu2n3iSbuvGnPdq87IjpBvU3/ELFDgAWd8E71a9azqnfzgA==
X-Received: by 2002:a17:902:c94d:b0:1fb:a1cb:cb25 with SMTP id d9443c01a7336-1ff4d2363ebmr8893515ad.40.1722463631072;
        Wed, 31 Jul 2024 15:07:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee0190sm125250195ad.160.2024.07.31.15.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:07:10 -0700 (PDT)
Message-ID: <66aab58e.170a0220.3388db.0d49@mx.google.com>
Date: Wed, 31 Jul 2024 15:07:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.11-rc1-1-g170c966cbe27
X-Kernelci-Report-Type: build
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 7 builds: 2 failed, 5 passed,
 1 warning (v6.11-rc1-1-g170c966cbe27)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 7 builds: 2 failed, 5 passed, 1 warning (v6.11-rc1-1=
-g170c966cbe27)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.11-rc1-1-g170c966cbe27/

Tree: kselftest
Branch: fixes
Git Describe: v6.11-rc1-1-g170c966cbe27
Git Commit: 170c966cbe274e664288cfc12ee919d5e706dc50
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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14ef94

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-12) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

