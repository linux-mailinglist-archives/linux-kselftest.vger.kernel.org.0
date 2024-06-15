Return-Path: <linux-kselftest+bounces-11994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344C59095FA
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 06:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A28A0B2275C
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 04:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2708D8F70;
	Sat, 15 Jun 2024 04:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="13YJRHp8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B400D502
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Jun 2024 04:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718425534; cv=none; b=cWwPLiP2Ayc9V3Efc34MMljw9AVgn65KObswJHWrxIyrw2iUa9dRvP51+gme3dk5qgkw/VRhi0NXSvU4CUs95vB2dTHjQu/ffORwjUxtGVHM2flKeevFfViQqY3ptncWwNyyfXOtQvTv3M2Rk2c+VgIhgAK2H1GYx1neLnyvWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718425534; c=relaxed/simple;
	bh=Y2r2K3uqXwcy81vdln7C7cr9SzC+/pXN4fc0wgOF+5Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=o3R2CuGifptKOfjqscJE5wkyRGbKKkSCge2ztI6XAcK8EOpvHi26cLUXkOwOipe7PG3mruehhiE/gjwDOy3hhXMpPUfA3Kc3uxJ412bas1eVONigDuZIvz8cF3puG2PsWsluZQbtABUgcYaizy4HwTkx/7n4r01LiYnLiihES0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=13YJRHp8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f8395a530dso25578805ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 21:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718425531; x=1719030331; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UhpOnUpS0Xo4s3kq4rj/lBrPd+8l/ikkkerNdqkyCvE=;
        b=13YJRHp816rOLJ6m+sVcwR7+iNAqSKX794ItTOlM9wvCSgN1VA3tzCPBz7bvAIDtB7
         r7wF4hyEobmzaNeinLErb4USbVORjP13e8n2CE50PUOAzwixk0W2+z+cHfqjJvdaiTPM
         g73Mw5qY17ulyHeqXxmNnPF5O0+zy2agKMhbjS/6Ialtr408DOP/bAlSFLlfsjauGQTf
         SSTfHPFa5oMIfQWs2uHqvwhDNZkysdtPEkv7uTbzx5zWXrG+0nbYsHzWhJRASnatZIoE
         tmGKXgYz6CPaRmPqjs4+lKXaZmfMRPcp2OKvnGRC5lkY/pwR9AMVEYCMdNDC+QrS89Jz
         5J1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718425531; x=1719030331;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhpOnUpS0Xo4s3kq4rj/lBrPd+8l/ikkkerNdqkyCvE=;
        b=f8NEehnIpcqKbv18yStD8Lq6GKOafEZMuLcSBBT8InGkf9pkfEoEg3s9bFfV+YRwgt
         Hf5Kb3wsykJg51odKGze6G2rnhcA2xBJgyoJJ1wqb1OfOJFszWn7HsbFogeYUqnPUnzq
         LaykCVD3fxhTOhZWi0FP4X9Uc122TyEh+eAEU3CxJ+vNKMrug/P5BYD+06TcOKZ22HwP
         4FzmOtsDV/HX3kyVk0A9U30sxUwZh6w744Zs70lAqnu4GZ3kLkp7GNKtDhx+N7P/oBpP
         xVCufIEhMTcBhsbuD/yBpAgqgYiL2bNvSd8//S0op2eemMtKNi0rMKVg5Sru/17MzeN1
         efMw==
X-Forwarded-Encrypted: i=1; AJvYcCWheKFPMHleE8e5zyZOO/iCmvtitZnpZmf8c1raOEUZPhVLePBxn0BvLTHu25bT/+qODzF4u+RubRwtyUiyJMpJc2ljIfSDGOuzK9G9zCRy
X-Gm-Message-State: AOJu0Yy50iKQ8yxgK5jkPMCK7FhhnkJyhXDfCwdrkg9SWZRSL1Dv7UH9
	CQt3FrcFyDrPsnYvgvaZ5HvnQy1Bd2H/pgBYU4n67kahj+E0lXafdNsHAvlj8hw=
X-Google-Smtp-Source: AGHT+IEWyiejrzm9pPuyzDS5RHbPkzl/1dU114CKrNt7VEL5FUswR4Vfm6veWjDxj3RV11e7acXJ2A==
X-Received: by 2002:a17:902:ea07:b0:1f8:3b20:381a with SMTP id d9443c01a7336-1f8626d2519mr50434695ad.20.1718425530944;
        Fri, 14 Jun 2024 21:25:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee6a7bsm40744935ad.159.2024.06.14.21.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 21:25:30 -0700 (PDT)
Message-ID: <666d17ba.170a0220.35c10.cfb9@mx.google.com>
Date: Fri, 14 Jun 2024 21:25:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-2-g64f5bc57b24e
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 8 builds: 0 failed, 8 passed,
 1 warning (v6.10-rc1-2-g64f5bc57b24e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 8 builds: 0 failed, 8 passed, 1 warning (v6.10-rc1-2-=
g64f5bc57b24e)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.10-rc1-2-g64f5bc57b24e/

Tree: kselftest
Branch: next
Git Describe: v6.10-rc1-2-g64f5bc57b24e
Git Commit: 64f5bc57b24e8c7935d51732571d405acfcf4b99
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

