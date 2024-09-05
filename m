Return-Path: <linux-kselftest+bounces-17191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B396CC91
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 04:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79DA51F262C8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 02:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC1D83A14;
	Thu,  5 Sep 2024 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gdeeKeH6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA3AC2C6
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Sep 2024 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725502860; cv=none; b=iM24LI/l/OFiOTag10GyiXS80R0pXcEyQi0Hc5Loqytk4E4bU4RAxyoHFMYjmbfDCcAqkhZvwHkwDOqZ7F84G8oGM/rsmIfn2IMR7Xe6sgmUo440RgXOvpry97au6u0vLwZyj5NTD8Sn8A4fDEdncI2+eAydA4I2q6wIg8LuHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725502860; c=relaxed/simple;
	bh=PuMaCJ0oNer1ZCa2Nb14N1hIGV2MCpKDrRJbd+Am7bg=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=n9y4xM7vpPFLOYp/yRXmWNUzULP/DwTuhYPV9+24+Lgc791MjGtoU0Ctbf6fXM1z/sfR1yDcp7GvVT2OAnMmENO7GXLxSTawN3HJmUv9AO3quc3zwFoHeCepMTNPNHDqQdQ7brx8sJyhSS87VI2naMAfSWVLNIRru6SUEb8RlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=gdeeKeH6; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2705d31a35cso237006fac.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2024 19:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1725502858; x=1726107658; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C8hpspt1HBa02fTjcpnwQRCE5KavXfzv1rKEiRhJ8nI=;
        b=gdeeKeH6xkC6N963aZsYhoTZdtNNqyOh8nLMhC2nqyeEbosUEGucWOPQf+kThAleoE
         uoP527o5ApI3PZwL2wLgVRUClFPJQIK8dlUNX+7c4EcSC90v4ggooPo7lwM4IzssiI/M
         D7b2QUp+yNTW4lCKH4/N0FjCD+pG5LQGXSElon8nccq/uXXFzpeeQJL+bjsPdlsb7dNv
         +Rs/sTJTLYOzDvAcNXHwiejTsm8mvcAmtkE5BbsPG8aPTHyXoH4PtJL0xCE3/M6l1xMQ
         5LFhOZDARbKGcnywJUsktGAjoL3N4G3adgF0RzJ6/SiHo5PHawq/PJJfl6nH12+PAW9E
         3E0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725502858; x=1726107658;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8hpspt1HBa02fTjcpnwQRCE5KavXfzv1rKEiRhJ8nI=;
        b=eVcFQ1uZ11nmwlvfIbZQ5uTOBTx45Z8L6qSjBq0akU0n5DoILUOTgdOGnCF6JIGTMZ
         ZE3iM8oE9tQx/JQXdoJvpxGDQnYQ/VJuP7HQhsQEwr84yVKZzxqkxts4oTW+7MQ00yca
         4OxjS99KfX8iuXUMkcNnXkk/J+wElbf3vtrQQXFVMsitUofhnmBQrTr8yWzR4pBAWF+/
         ILsghDUeNfgV/SMb6QyqhC+svE9pr/mzaUUBYUDzy6a1zNiPORM+2CRwOsq8LzRZXhXc
         ZKzgXZajNbihI51z2wuOvZQx1zauDfYuXm3dPSexg9H4nrYp3tIOB53KvcjUbU+yeIH7
         ochg==
X-Forwarded-Encrypted: i=1; AJvYcCWdJwDRCQYRCbN9jgqFI7/ZEuJvc+R8tsNmYMxoe+h9goIRX9uYMEeffFdiXXYJK67IgnuMzBYPlQHjsR+l0fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSYvor8VXa5duojNZWEx6W0hKhIkkY163WJqk7oGueizdG2cC
	tAmP9/1Rdycxstyg2O/PLKn4LatrnJviBBwcgq3xlrtWzOZ50/7/5uWCmgELWd0=
X-Google-Smtp-Source: AGHT+IG9cwqlmoqlvg3zeut/qEKqPKGrV8sKJSC/NErWWkoH16NhA0nvdR2bg2+jIQEgsgh27Gla5g==
X-Received: by 2002:a05:6871:7508:b0:260:f50e:923f with SMTP id 586e51a60fabf-277cce5f966mr18691519fac.42.1725502858079;
        Wed, 04 Sep 2024 19:20:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8aab2sm2287233a12.20.2024.09.04.19.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 19:20:57 -0700 (PDT)
Message-ID: <66d91589.630a0220.180f63.9701@mx.google.com>
Date: Wed, 04 Sep 2024 19:20:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.11-rc1-18-gf0a6ecebd8586
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 7 builds: 2 failed, 5 passed,
 1 warning (v6.11-rc1-18-gf0a6ecebd8586)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 7 builds: 2 failed, 5 passed, 1 warning (v6.11-rc1-18=
-gf0a6ecebd8586)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.11-rc1-18-gf0a6ecebd8586/

Tree: kselftest
Branch: next
Git Describe: v6.11-rc1-18-gf0a6ecebd8586
Git Commit: f0a6ecebd858658df213d114b0530f8f0b96e396
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
x86_64_defconfig+kselftest (x86_64, gcc-12) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14ef94

---
For more info write to <info@kernelci.org>

