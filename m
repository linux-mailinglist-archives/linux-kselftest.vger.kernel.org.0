Return-Path: <linux-kselftest+bounces-19484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 753EF9995C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 01:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14BF1F23862
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 23:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5BC1E47A4;
	Thu, 10 Oct 2024 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Y7kSJls+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232161E3786
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728603292; cv=none; b=sjMy7GD8D7/ijmcV/Vxw3DViIZKlG4LEmHRxfsRuvenSI33RZMR8OTH5ZxsKTz5lnWRqxjh9JFkpMX5m3799oZY6r9EhqRojHJ2Ou5S5flt6Gmxv8S2v3lM6/M6tdp4Iqts9QKT83HesewZQqr4OP6QPJl+hRj7PGjuxmeAmjXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728603292; c=relaxed/simple;
	bh=lMm6t6+EIW/lmiW5nuw5YD2yLIe0pWn4/ZkH1YerBmw=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=GjRAjuyW4ZrOFjbKeThNx3qcLg+3tGOjdBRNNNW6ivlqpfv6wkFkslNz2XSk+POo6+IDe4Ksiev70+xkbbXgQax6t1YPsHPqu6FrHP8eCFKJfdbDKa6mo5O28dkBfcJKGct5MsgE95b53Oqx7vMCWLWnhiqJXyaeXOXalFhKVd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Y7kSJls+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c9978a221so7608775ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 16:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728603290; x=1729208090; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VLnqZTPJV3XcENLKlTq2ar0dsotkt/t6G0VGHFWWdXo=;
        b=Y7kSJls+w1C4EA02HC6x53P7zKdWd2RNuQsnJ3NeyLPYzMauZyCLebANSb/oMReBTQ
         39/QQOBZUEcW0nHK2K/6bidkwo5paH//uoHAVf8sUSoVOVSfpRkBrv5gsLRWjXgAo79A
         bbvL0SDn5J8iHuyU4nc3v9QrT68cr6fxnBH0eNHsBikPID1rzmJW0OTrnGjKCqw50V+J
         JgecO+Fnxl3Gkxc8tdC9NXpLkA45dBP37igG7e6RezLNkVN/vX8Mf5Tge/aquCzCUoAW
         TMmryYHQXUhZo6FGfh0Mg4mMqtYnN3Ow/YryqkmefNfXHJuqEWSZRMoSfffpmJlA1jfE
         BGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728603290; x=1729208090;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLnqZTPJV3XcENLKlTq2ar0dsotkt/t6G0VGHFWWdXo=;
        b=Ci41JWbBIzJYb5yNbx7cSQAeZ3fuKXhrOCRhgRxTyWP0ZtayLyoIaNngrWyzivWRPQ
         +DWT7umHhaE28s+Uj6RaTMLN4bG3RzUZVI1hkO1TN61lLHM+ZcdMYptkLjfSxMfvHe3o
         eMnqLqLYSkTQZXbLczs45fL1pNHL6axlLjVUpZYnPPe1VCE5Un+uTnyiV8R24jjsdhgn
         U3jN80+rTIXyPubGb1sxK/PZQkgyVD77lqh649zjm4gwWABbU2pEwBrzQx96fecQCGXS
         hYhD1qhud5tvXEGjcJJzbxUlYOc9Nu5plL7P6GtYGz9ZSVpbWJTyocYdQ3WoGe5Zn2B9
         jVbA==
X-Forwarded-Encrypted: i=1; AJvYcCXqspAb5zm0o7iSexx+vI3YQaFjeQcK46yEYsCAsFiiJJidSMSdUdYG3cC3ZXSEEkttFvklsgm4cj6TtSFiWMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJn76JN9cBMP5L2nDgaoLj/22EjRzrenGfue2jSPZt7FQjbHx9
	g7OF8MFpcM2+oeGqUed0wvB/M3FxbFiVRdqqGNNh705CSaxIhB24iHycBawTjQo=
X-Google-Smtp-Source: AGHT+IHv2KF9wbLwKdIzqKRvBEpxvdPdj2Ocv227rua9vqiA1KGsGiVBuFFJE8u1M3GFlzAZs2iung==
X-Received: by 2002:a17:902:db11:b0:20c:70ab:b9e1 with SMTP id d9443c01a7336-20ca16fb461mr7097585ad.56.1728603290361;
        Thu, 10 Oct 2024 16:34:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e76f5sm14385825ad.133.2024.10.10.16.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 16:34:50 -0700 (PDT)
Message-ID: <6708649a.170a0220.72a6e.5d47@mx.google.com>
Date: Thu, 10 Oct 2024 16:34:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux_kselftest-fixes-6.12-rc2-6-ge26e42b5679ed
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 7 builds: 2 failed, 5 passed,
 1 warning (linux_kselftest-fixes-6.12-rc2-6-ge26e42b5679ed)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 7 builds: 2 failed, 5 passed, 1 warning (linux_kself=
test-fixes-6.12-rc2-6-ge26e42b5679ed)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux_kselftest-fixes-6.12-rc2-6-ge26e42b5679ed/

Tree: kselftest
Branch: fixes
Git Describe: linux_kselftest-fixes-6.12-rc2-6-ge26e42b5679ed
Git Commit: e26e42b5679edf8c1226970325366f962555e58f
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

