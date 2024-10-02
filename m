Return-Path: <linux-kselftest+bounces-18935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3982E98E607
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 00:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE9B1F21406
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 22:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACC58F40;
	Wed,  2 Oct 2024 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="pU7OvpdG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D02197A6A
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907529; cv=none; b=k82F9QHVoSVLCTPZm1VgDpoM7R89PZ8k12bdTFgxuc0xgSJyhcJ20eSkM5e0tqpI6LWHQkJrxN+hgQdpAkbpI/C19a7IiPz4Sfd0/ESqO+L9sQb5mlofC3llqDJfbyj2u2SHPMr88/edtRFl34ULbiu//GjVxVDf8EbkkdyXU7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907529; c=relaxed/simple;
	bh=S7tIlzzhQd0ojybWWJjCqiaaiZKriBBd83lZpOYdpvg=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=EKRq1xfdTDkAVzSekJEZfzkBMPn+Fj1q0Ma26KXzbCtBSprdMIrsr/lqqHGMsZdPaBuEa+Lw4O68J9Rbl0C3c3Ti15v5OQxikBYihOPpAAeh/IsoRKUjypQ4AgsXJZ688eTFElSpYyFC6eod8iy0YhBQgCqXRL2PIuBwPMZ8GsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=pU7OvpdG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b8be13cb1so2487315ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 15:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1727907527; x=1728512327; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D5FnCx0U49rkTzQ5AluHcb/v3KYzlu4Wiw416t38EeM=;
        b=pU7OvpdG/Z4sFNOXuKabkqrcIaDG8pBzgI0xndBGHzGCZSdtwbvgDvSzppAoC5M2rh
         4YNcisjZZejCqMVXPT6rPWIx2i3TkFa6/K64UJ68Z+J/jdHEjKUabLSmdkq0rYD2Zkve
         cJVrNoip7ZHSwihyWyf90fyHwXS0PbZsn7VIbOVnRNAfLYnjmMzng/sdIkA4NScPx7Pc
         EpIExLCVvx6XL4hKjPPPyWaukNSHSRb56fT4wfKVNmwGUafyvDlz+nqY87mWtd6AYqUy
         TGoq23N13LGiEMphcbUgVrFAHLRo/BqQoHP+4hQWvJEKrWoNY5FC4GkX3RJAiuDK85hI
         Ze5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727907527; x=1728512327;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5FnCx0U49rkTzQ5AluHcb/v3KYzlu4Wiw416t38EeM=;
        b=phZm4mYGqRdaK8S4oP6aJGNnaOmygpMppygJEsGMX/85kURHCHoFFJ6aQtjfG2mIJJ
         4PK4+veLTwy3f+dgD8lHc4Fn4jAVrT6wr72WOVFBzor1IbIFHiCoBW1sawlBbtEfEPBn
         oji6bT571O5VuVdS845fMnQ1YW+gf6HCc4CkZtEK6TsTaF4VWmvyDif/Hv7OYOS+mY0t
         NNVGnNbh/TS4q307OtT7+KOx/zM3C5Yqt8F7LVeK+BsiE+4FpIY2k7Ii426R2Dss7Rm5
         gtiZNGQD7+CO2x717MAfsISW77WZWz47KDQGjJsFm7sSRo6drI8jsWpuYWlSUabABagJ
         OYwA==
X-Forwarded-Encrypted: i=1; AJvYcCXBFxp053t01ltko/j8lXFSnjrME++8wzwoejG9A8TDhQ7r0kus8nMBzZ6x8Gv/p6DxiLZhtUZN2pgfmOoBIIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBOC3+sVtSAi7j36H5RP5xEzdEBXn/J4847vtZQmZ78A5KBuDM
	+4bug+TZTrP4S1qpQlmlE13ePq6UpWQzfbAL6hpre0lnsWrRXLu6PrDXnHlgwfQ=
X-Google-Smtp-Source: AGHT+IFzaEnpV5LEWuEkHErba7F++HPnzJLuqoIwjnTfagL2a8f3Rj+Z2yNnfJPNoLdtrl0HMmPRKw==
X-Received: by 2002:a17:902:e850:b0:20b:58f2:e1a0 with SMTP id d9443c01a7336-20bc59ea64cmr61912565ad.18.1727907526679;
        Wed, 02 Oct 2024 15:18:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db5eb27dsm10540798a12.70.2024.10.02.15.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:18:46 -0700 (PDT)
Message-ID: <66fdc6c6.630a0220.90349.ddaa@mx.google.com>
Date: Wed, 02 Oct 2024 15:18:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.12-rc1-9-gc66be905cda24
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 6 builds: 2 failed, 4 passed,
 1 warning (v6.12-rc1-9-gc66be905cda24)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 6 builds: 2 failed, 4 passed, 1 warning (v6.12-rc1-9=
-gc66be905cda24)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.12-rc1-9-gc66be905cda24/

Tree: kselftest
Branch: fixes
Git Describe: v6.12-rc1-9-gc66be905cda24
Git Commit: c66be905cda24fb782b91053b196bd2e966f95b7
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
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x14fd19

---
For more info write to <info@kernelci.org>

