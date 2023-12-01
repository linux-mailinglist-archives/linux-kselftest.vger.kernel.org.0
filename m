Return-Path: <linux-kselftest+bounces-934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37730800306
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 06:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA346B20E02
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 05:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C112747E;
	Fri,  1 Dec 2023 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Cte/DEzw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E2610FD
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 21:32:58 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce015fd299so152221b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 21:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701408778; x=1702013578; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y//FlCWyDNlc70tGd79zofFtpe0XNmsAM8tlexPdlME=;
        b=Cte/DEzw536fLD3ODe/PGmdFE9Kax9f3JCJ8VEir3vhyhzYnLUTnQg4m8dD9dSM0mB
         5uFEsjtTtoaw4/WFm/VYhuUVPYRoeZDRmHRlzDZP7FN/kXO9QV5hkRdIaCSLS026OPRY
         txSMpr6DXSKnVz3AL/MxjatFlbCHtxgOnEETI8FiYiBHFVK691eaXdFNIjLiDAcmad9r
         0FfB2Xq51WvxkWsaLevt0SzMN6gp/O43V5tlHHdEMNJu2b8H2LwE5TDGbB+af1KgifLh
         XoG6e1qQjuirDK8E0Yru44kxVzXE2qLn9XGK4GmL/mRNcAAx98fVDhab2dN3kqr7TLjp
         K1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701408778; x=1702013578;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y//FlCWyDNlc70tGd79zofFtpe0XNmsAM8tlexPdlME=;
        b=i1CfbxWPO/MGlpxnzAuMwyjBb6jW8y9QfZ+jwgShpxuI/GpmixnKYMaEbCcegd7a9V
         +tyoSbMy1qibs8yFHZs1onFs4/L0MJjhz2s0HL5pT1EwvYIn9CqSjSw0HKA4hsAP7MdG
         IH6CpsJ+ZDTSlRJmm6EvhkHVfCvBcgGqTSwPevQwIbCrBj0EwJ1YbwuSmUtc9m5Cxqy4
         6o7PU0I27a/ejZx3pqdh1SN1Uw6N18/5TPMZdAF62TIRDtltoiKUb5EkqglSehLDdUCu
         AMQ2IFX7dkE1FCW6tpJzHY1BbDXSgrH75hOmg1QFq9ewzwKZnqGXROJLvuc9DMuJFzYM
         5qFw==
X-Gm-Message-State: AOJu0YwERA8tPphs1VSqiJ+lf+B4CZ/bXWPi/jIvCvoK0SRxb5ZRgXtE
	1SSBtI2UomdpU7UBC3bLTln8r2KADHjJhwI4VbEhAg==
X-Google-Smtp-Source: AGHT+IH6irknVYzJ0a8E8Jt73Kb8wKBJuT7iyOkxLo6AqrBrWf2xANdgIGXaD7+JL5sJtU3Pl8PkBA==
X-Received: by 2002:a05:6a00:3014:b0:6cd:fbab:3c5c with SMTP id ay20-20020a056a00301400b006cdfbab3c5cmr1958276pfb.19.1701408777916;
        Thu, 30 Nov 2023 21:32:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t10-20020a65608a000000b005acd5d7e11bsm1909887pgu.35.2023.11.30.21.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 21:32:57 -0800 (PST)
Message-ID: <65697009.650a0220.7e954.64f9@mx.google.com>
Date: Thu, 30 Nov 2023 21:32:57 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc1-9-g130a83879954a
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.7-rc1-9-g130a83879954a)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 warning (v6.7-rc1-9-g=
130a83879954a)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.7-rc1-9-g130a83879954a/

Tree: kselftest
Branch: next
Git Describe: v6.7-rc1-9-g130a83879954a
Git Commit: 130a83879954a9fed35cf4474d223b4fcfd479fa
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

