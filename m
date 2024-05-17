Return-Path: <linux-kselftest+bounces-10327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17DB8C8095
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 07:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4B91F2130A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 05:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C8F101DA;
	Fri, 17 May 2024 05:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gpUKTjX4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017010A09
	for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2024 05:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715923048; cv=none; b=BcCjOpq85xx9SmSbP7iXzfe5jsqcWDc+t5nv8hzjiihCRWddwEuybNZhOhcSApdtRd9CI1+TCopMWZlCslQ4MIXqILCjxPl8msZCAY5sy+kfM0tlc0DMeDC2zpqCGCfcp41vX+eAn0C1SI3ghSVauukHdoMBbxo/lLLcuehJEJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715923048; c=relaxed/simple;
	bh=zPrHB3GR5O7YVOykcTjkrIQEBjRMaOHIDgiXfrN9U+o=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=nbakT/Xha/cCe0vSbj5WKM+AnjpEHCm4qVScNN93k42GJ0FSweFwOjW1/+VKmsQnfUpC83YpqGwE2TLQ82XBU3Gcwi+dxkVQzKQL/kLM7kXSiWj2yE1IFuVSom/58Vq7KNRqobgrWZ0aft7XBitZUBMPpC71yknw3qtdUTkz8n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=gpUKTjX4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso1944485ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 22:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1715923046; x=1716527846; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0HA2QCQGGmRXfGbWi4pU0AQ6+/oPDkgwvPdmrw/7Ql4=;
        b=gpUKTjX4N0p1Fxe4wnoR44kKkjENoef6rgsZW+FFgrz9pktyF4uytcYx0380l71Wda
         ekD/Y0l2zEa0l8+icujsp5YRxVfJxiFOjNCkYUErdBn8teXos22U1XapiAfrK3rHVd40
         J6uVHByuG2bNe+AzSDQ+nWCCYcHu0yIoQuyg1KbewkDn1/AJ2DGXvtN9XGfkqAXQunhg
         84W9nt26If3QO2m19F+cjIsEZtZaxUPD4RRTYTZ0TtHoYKbnPkfrmcnhDFG1tzE2+slK
         hBZAAmmbMaTvYBy8ldRMMrzrgepAKP/MmKthkGZ3XEP9Jplhofj4rKpGeviGEN8LEOfJ
         an1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715923046; x=1716527846;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0HA2QCQGGmRXfGbWi4pU0AQ6+/oPDkgwvPdmrw/7Ql4=;
        b=NIoPhuhqf6OzKP6G9atvIMaG3Pv/4pKZ+FPQejaHDVv6IoypMeu7eGJoWQ4GpN1CZ8
         aaS2fFYpz8uYe5xvN+KekIaLMVqB/KoIE+sgeLs4l3s61nnapqbcnslFRr/rV/cZhBUE
         o6n4wmIFuYV4yS/TJFx2pZCjuVZX8ckhnugXsnUezYmVAFcWrCrSeZuSZ66e/TPqWbKN
         531cG/mlilXbSAhDBsfigIfqgPHkAeNb/8tLk1Iug96d8ANZv1sdYSKCX/1n6TOjwdlN
         A6b1aqeP9HgEB+MOYUCnq0NbEW27zKrPC12dJ5I89wvdwAJIbUtjtg9lnHlDZWeF0jvu
         EKDw==
X-Forwarded-Encrypted: i=1; AJvYcCWiHTmNrIenMONHMDxnoEG6ig518uZOYi+odjJJTzpblsV8jhjnYUiymWqwhZa8t13RnEyulQpnKyjJwCzZ2RwQzZJAHv+nC/o+zmD72Pdj
X-Gm-Message-State: AOJu0YxkIkTRgUw8zFipmd/QwOGcdgymXAjR2GuJTn+RT4PUXCmBU5l5
	Ijy1mD8cyVP3PUWiRQjIsxznQXIVoIxtgSXCd96EDgabF7PoaOQU73hbIA+XVS8=
X-Google-Smtp-Source: AGHT+IGDJyQWzHx7e8aJVWoSnv+xytzbgZZ3rX3P1UUQIE+VxPJpqwv3k987FOAVOOkBcmtEzB3GOg==
X-Received: by 2002:a17:903:2342:b0:1f1:e125:f870 with SMTP id d9443c01a7336-1f1e125fba0mr39520815ad.40.1715923045990;
        Thu, 16 May 2024 22:17:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f0958fd757sm37659555ad.45.2024.05.16.22.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 22:17:25 -0700 (PDT)
Message-ID: <6646e865.170a0220.edbfd.a5db@mx.google.com>
Date: Thu, 16 May 2024 22:17:25 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-8287-g31a59b76b978
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.9-8287-g31a59b76b978)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 warning (v6.9-8287-g3=
1a59b76b978)

This legacy KernelCI providing this report will shutdown sometime
soon in favor of our new KernelCI infra. Not all tests are being
migrated.
If you are still using this report and want us to prioritize your
usecase in the new system, please let us know at
kernelci@lists.linux.dev

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.9-8287-g31a59b76b978/

Tree: kselftest
Branch: next
Git Describe: v6.9-8287-g31a59b76b978
Git Commit: 31a59b76b9780a9b2d385024e2d6d0d051bb06a5
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
 !ENDBR: .text+0x14dd29

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
BR: .text+0x14dd29

---
For more info write to <info@kernelci.org>

