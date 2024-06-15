Return-Path: <linux-kselftest+bounces-11993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 809CD9095E6
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 05:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E831F23A1B
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 03:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE4F8BE8;
	Sat, 15 Jun 2024 03:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="fGyk/dMR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27493D60
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Jun 2024 03:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718422666; cv=none; b=hVQF9GFnAk8OlI40SDNMRreOPMGxfNeS7wNAex/2uRabJdpNqQOocq+1jPohxQVWq0Ur0xMq8uig8e0fWgCDBjOOi9bEaHULMTcLKaplcZcBC1ZVIQSSibCwPUkiqnPx5GPelAx+0PClv12yxsLIRAlncDhsvl/+EYMpyKqx+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718422666; c=relaxed/simple;
	bh=sVMfCiZg94+yWGYZORXG4L9SWFeU0rYgD7CbcubGV7M=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=U7Fv/PlkZenw8TJqgq4w9NjsyaIM+QskcbJXZ5a4h5ojmGMBJOpyu/imHc5CBwSaEAND1xksljnivueSGUoOGj+Ad4ObCDUuMZTQ+CiPInv7YvU4KiTQB/DOuGGLhd/iL0iAOMQzBhVLiSERzOLQSj25EvUvTlA64cTnifOArQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=fGyk/dMR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f65a3abd01so24511375ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 20:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718422664; x=1719027464; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d0jNhvwoBlxRYFAWL2M3fOxVyCzGQcy5b+oObsdvFms=;
        b=fGyk/dMRqJ0aVILbr6A6uQzXTBKBAXyCu6FODwJeHus3RxaobQWdbwqvL7f1a+dKw4
         58WlQzosSjL+WzkkCM0mVCdvI2/tYKpRQsZFkF3maFsL5d49AcKnTx6ryHgtIVgFv2aW
         HHrVHOchkCN2sn3k+O9I60OTB2I6+yweND88GrXE2ZyBiyHKC6G5SsPMWG+IJ6fwqiPa
         0Ojy1Y5gbw8cLPtL0lbzBQDSMwyk/Yg/NU7s48fBjbnrAfXRW39LoGa8jZvQMfJ8SnPz
         EUugdJqIWL378DDMxjf5qIpdGeGFC/oDpyQ7w0QnZ2zBQeh4jdPyp3XJgPleCvUz8t9V
         rGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718422664; x=1719027464;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0jNhvwoBlxRYFAWL2M3fOxVyCzGQcy5b+oObsdvFms=;
        b=XdaENVLLgrSrkqb/lvixCKqEQFI88zMmbxi1sdoIi9pTmzMp5Wa3aIEp76Y3oQANNJ
         fEMeINh1lXj8z48ig8f/TqGnq2gFCAtSGrQIHDmdDEVaY0u6ImbFIQWMoSXMcoHmewKc
         5L8duUjbLOxJ96UMUts1LPwJiRBw3+7S2NXvi6oXtdl/LHfvCHqP8hkcBqJj8cjWYH+L
         j0Lsc64V2uU2D7k/sIvGjolz2H3W1GZiZSswqBMbAOxbTmHB2krXshkXntJEOHxxKRZg
         wcXPy3hYx+eaKYJDe5pLQLxy8x0S7YarZzz+rGKQNSLdmpxcImjymnGdRVJDd0Sq/rN7
         hTCA==
X-Forwarded-Encrypted: i=1; AJvYcCVZAct3ilJi0jYupYwxpLDLkJHzg1ZDa4eKHeZzKoAKnmnxMQ98sTniMmstE3oM90VAtZhln3jo2Ep5EMiGSdI9O6a/6QSsUfLDy6nwz5Hg
X-Gm-Message-State: AOJu0YxzXM3dTqFicB0gU3QKUU78yhiknbnu+xxTS/igUyGGraM18JKb
	Q9gU4X21ehoWjHY5/v5Q7giU6E/YJDSdjHefftxt1k1QBGEbVGeSFwlFCqaQJdQ=
X-Google-Smtp-Source: AGHT+IG6Zg3obVhv2P++d1udljt1qMn347hqnqhNk0WDGApChHuDxwWZz5fFkwY7Xn4fKS6wKdFelg==
X-Received: by 2002:a17:902:da85:b0:1f4:7ee6:af17 with SMTP id d9443c01a7336-1f862a000cemr56726445ad.64.1718422664024;
        Fri, 14 Jun 2024 20:37:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e72483sm40402145ad.96.2024.06.14.20.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 20:37:43 -0700 (PDT)
Message-ID: <666d0c87.170a0220.7dd5c.d09e@mx.google.com>
Date: Fri, 14 Jun 2024 20:37:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: linux_kselftest-fixes-6.10-rc3-4-ged3994ac847e
X-Kernelci-Report-Type: build
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 8 builds: 0 failed, 8 passed,
 1 warning (linux_kselftest-fixes-6.10-rc3-4-ged3994ac847e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 8 builds: 0 failed, 8 passed, 1 warning (linux_kself=
test-fixes-6.10-rc3-4-ged3994ac847e)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux_kselftest-fixes-6.10-rc3-4-ged3994ac847e/

Tree: kselftest
Branch: fixes
Git Describe: linux_kselftest-fixes-6.10-rc3-4-ged3994ac847e
Git Commit: ed3994ac847e0d6605f248e7f6776b1d4f445f4b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    2    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x14cf94

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, clang-16) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-16) =E2=80=94 PASS, 0 er=
rors, 0 warnings, 0 section mismatches

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
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14cf94

---
For more info write to <info@kernelci.org>

