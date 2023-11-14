Return-Path: <linux-kselftest+bounces-62-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E96CB7EA860
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 02:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E49D1C2091E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 01:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89F4612C;
	Tue, 14 Nov 2023 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Vex3kV7s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818236101
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Nov 2023 01:49:39 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F35D44
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Nov 2023 17:49:38 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ce28faa92dso13196955ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Nov 2023 17:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699926577; x=1700531377; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IlaifV9wtzi9NSB87VgOagHUZdYKl1cfFGGAuhD8cSU=;
        b=Vex3kV7s8Wv4Qfvg1JeLB/1Lw1nQ3EPt58foZ65W1lWFm0T04KNyFMD+mk8++73EuU
         ZZheso4spFobpaV78Pzo7aaM5Erc6Cir7YUMxjlrkYYNFpTnUbAuIlL1P0OkIxqs8YS6
         ZdBmorvYUauyiz4nu6v8wPNYyhqALvmjioGI3lDE/nM9ULkr1be2YOhfYq9YhrOrhGR9
         eno/cI799wmlMyM27sdvdqyXsmaGsRG1I1MovYblglIP8lQfkyqwWNp+pg/nygxIgEG4
         8NitF84MgEssRI/Q2dg7BFRs7IroW6tSY5oH6Ylc6DsRDPC3CouHfXeTV1fsaP7q0AWM
         7GJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699926577; x=1700531377;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlaifV9wtzi9NSB87VgOagHUZdYKl1cfFGGAuhD8cSU=;
        b=SFJfihT/ugCbXYS9vrFyuMgVupSJZG3bWD9cmuCVkHQm2k7muvSg42OW6fqITaeSqy
         py1jPR3OrIycSI4EmdUdvte4DvJY29HbB37u4z2T969rPJC1RqVyDtHKqa5K8ZTfoMy2
         oYBXSnXyl9zWbS4G7gLwsTajLzTII98s0QTlb0R3SvMxHdg1gxqstZ9qslCsYJKiE2GX
         26h390GGFknza5x3ocNL5XqylsImiO/hRMWwS0KK+aCNzNdrgT7BWCW+0DgC27q4su1d
         EXioTeezNWRI6kVlk9AcOntSp9MU8JT3NC1+QB8A43Wd/gzuGSg5PAPQGuNVoLt702O1
         Oesw==
X-Gm-Message-State: AOJu0YyGjiTcNp9ZJ+R3s5PrA61GZ3kNwUaUMb6QUXuJBdWBbmt33L+t
	I58mJEcpJy2WvZWWQWNZy7t5ShZMtTsKsg9xzctoIw==
X-Google-Smtp-Source: AGHT+IHqLwVezzLfJ+xrOKntJ3WZNNQeQHY7RL41aYeNDHe5TNpLaPtVpPWoA49Pe793T+9HuwkvHA==
X-Received: by 2002:a17:902:6908:b0:1cc:b3f:dd81 with SMTP id j8-20020a170902690800b001cc0b3fdd81mr782098plk.67.1699926577523;
        Mon, 13 Nov 2023 17:49:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709027e8500b001b8622c1ad2sm4767672pla.130.2023.11.13.17.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 17:49:37 -0800 (PST)
Message-ID: <6552d231.170a0220.240a5.b28f@mx.google.com>
Date: Mon, 13 Nov 2023 17:49:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.7-rc1
Subject: kselftest/next build: 6 builds: 2 failed, 4 passed,
 1 warning (v6.7-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 6 builds: 2 failed, 4 passed, 1 warning (v6.7-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.7-rc1/

Tree: kselftest
Branch: next
Git Describe: v6.7-rc1
Git Commit: b85ea95d086471afb4ad062012a4d73cd328fa86
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Build Failures Detected:

arm64:
    defconfig+kselftest+arm64-chromebook: (clang-16) FAIL
    defconfig+kselftest+arm64-chromebook: (gcc-10) FAIL

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x14bbfb

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
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, clang-16) =E2=80=94 FAIL, 0 er=
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
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x14bbfb

---
For more info write to <info@kernelci.org>

