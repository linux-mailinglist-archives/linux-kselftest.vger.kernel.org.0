Return-Path: <linux-kselftest+bounces-61-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC897EA83A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 02:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839921C20837
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 01:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D629567D;
	Tue, 14 Nov 2023 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="fZDtYlPr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D636101
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Nov 2023 01:33:59 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618011AA
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Nov 2023 17:33:58 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1efad296d42so3087088fac.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Nov 2023 17:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699925636; x=1700530436; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AfyoaSZxLG4mONz20qtRy4uGCohUX52TcuPYKomUUzQ=;
        b=fZDtYlPrA4kaBKR/smPneNB9kJcLQOgk2NbpxezV30R4QYkz7CZR+oMgHBmVdrchLT
         3O8p85BkxBi5FMLJD8vq/v6GocJxGmGGUAKrgGfM1hYQu3HIfvtyNbi/Ie6No3job29z
         IE758H8oKP7BUrRmZ8SE7ZdOd1C2UOK9yWIG+Z2E+lCyNpYjkh0593CTarpm8BYmcbLp
         +RhJ7ntcInupuyFwlm9Qm8fOqQpTMvR3L6lL/vape671IRFgxiY7dVAuH0Wp/t9HimaW
         h3V2MLZxBxzjIe1IbrpTFAtVkfO+27vedIX+DeJDpeX03Z+D0rEpZhV4K4Upzc5qlzKl
         tXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699925636; x=1700530436;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfyoaSZxLG4mONz20qtRy4uGCohUX52TcuPYKomUUzQ=;
        b=TJMeWuj051C9/rrzPn5TcefnOkcT9kP1DwizM6xZWmj4OQzCGye5bODIDjmLLPbvcH
         ZSJHVJyVus3sPWfPWZQv4dBr5IaVru6i0mr7evhe2RYcnVQu7l47pGyoOxCZGENd02a0
         FTKwbWxNMtW5XPIOPjvVh74N1Isf5aXA+CovgpoHFcyf8tUk4C0YrQNJi4ifRKygjHtN
         Net7Pe0T/HU809t6v7dqTaENzlvhUWmgg8Ahy4UnfNlVoR3lZ53vEs8lrTbq7VEORXPW
         Pu6NVzKjtAL0a6jdJpeaLS4hnZdGSd0o3YIKtoGsUmvxwSsMZg/MUX8uS3C5EjlASF4r
         G96A==
X-Gm-Message-State: AOJu0YwcjPyIZt1lezgINlAlat91YSq1hqP7ccGuv5m1+L65xd5NVFAm
	nXqkiPib5x68f9nKLQbrSadw2W2MBH0C3cpybbvzzA==
X-Google-Smtp-Source: AGHT+IHcRXaxpCB5hQYsMYqicSpjdmZgKyB/tnnnXiwUB38OnfbOKE3Ytffnq6NreabMM70QEJuPYg==
X-Received: by 2002:a05:6870:d0c6:b0:1bb:509a:824f with SMTP id k6-20020a056870d0c600b001bb509a824fmr11184582oaa.55.1699925636573;
        Mon, 13 Nov 2023 17:33:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7821a000000b006c6f794e712sm200366pfi.166.2023.11.13.17.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 17:33:55 -0800 (PST)
Message-ID: <6552ce83.a70a0220.f3c19.0b03@mx.google.com>
Date: Mon, 13 Nov 2023 17:33:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.7-rc1
Subject: kselftest/fixes build: 6 builds: 2 failed, 4 passed,
 1 warning (v6.7-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 6 builds: 2 failed, 4 passed, 1 warning (v6.7-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.7-rc1/

Tree: kselftest
Branch: fixes
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

