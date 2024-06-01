Return-Path: <linux-kselftest+bounces-11074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C078D6D31
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 02:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DBF21C2145C
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 00:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AFE1878;
	Sat,  1 Jun 2024 00:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="3G8xlHjp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D9EDC
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Jun 2024 00:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717202675; cv=none; b=fyw98IYgg7sAEbiNke77NeFaaCcKXIs8tXyQSqNhpKxe+ivvVff7lrxq6Rc2BWW8kRijuerVsi+C4+ffpNz5y+ITkauvIipx1xu5P7vJBzTS+U67ePtX2I7PYWD3ZrU0W+dhGOBj+dOsBwjV0QV7N25/SOK50JwRDipUcxW/xJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717202675; c=relaxed/simple;
	bh=L4bgoqTEPwFk2yxqpxSEzpZqsXhsFjiEKCAm65jSotk=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=eL5CjieST1W//R5El8Vl9oFXpllpZOsBP4gpcSA42xitzrRpCRkqqmq97/V27wbR/umbkx19F39rgwdT/6UkZOjzF4MFsINdh9gtEHPdtHT5/VTTuYXdbkusvL4NniSbysRBrCkN6fBqKwoeyLUTNCoIClIGu9IGwf9VVcGafZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=3G8xlHjp; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6c27b1f2dfaso1467686a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 17:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717202673; x=1717807473; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DiC6D3No/f13zxZoBE8wViK3SqRt2d6MOJuJYKvAPO0=;
        b=3G8xlHjpS3WqT7V6ahO9rAXgfbTZgouezhLgX5HU14GU2sM+G1DL6WOghuCf3Fc/Jy
         wiVzOiXZhskZfMZXdLxv+/2/B+Dq3zQL+jwl/NejHvVE/ovw6az7P5oHa0Txb6w/hNjV
         9jJcKW/sDiWYQpRY32QfkhSAVby6362en5ng0rYBev+/SlxTUUwyzFlmsKe0sPr/PgSR
         j2FhJFVxFhSGdV4NB5paaqwMKoMp6lFLjiM8cMHCo66Rqeg7EfNuzEDUc9qlwMo46G7X
         XA+YmbtuZiS+svLaZxSFF8C5cW9ILa5NFEt9PgtmTdmf+8Tl0q6Z7B31+fxJgI/MBLJX
         DOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717202673; x=1717807473;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiC6D3No/f13zxZoBE8wViK3SqRt2d6MOJuJYKvAPO0=;
        b=szpOSeGBHK8+axXw8+7mFMUOaVyRWV1RKfcYURxSDxPrnWHd1Elk19qre/ttUJxOtx
         sT8ifVcAkxSCaLe8H1X7rEwR5MDT0595AwgB6ztY7gGYluJJzxtMk+gxtIKrpElP+g+L
         SD/zy4aRaB1c+pquM/CP6mAB0Hxz5j1qFoIptErFqlG5A0ZMpkD4T/tAjLiL5YKwtXol
         VlLbUdzbRt5wJMIkgUd9B7QQFlkeysx94pOO2QT4a0edtkyS8hJR9MyHe9yPi9Q4Rrdw
         ykPjw/LVhcGIMtIPHNqXdN7cdv8Y4FyLxjBWMEuK3yHay+B9l0RTyPWnmikrEU/aGbHv
         sKWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLnWe6MhaH9A5shSyWyhvQSyyXkI/BbOnqNiiqt58EvuWNeh0FR8vHLWrJDzM3zhSxal+90R2pCulhOVNzdyqh8LZPo9jd/A21tY8gXeRl
X-Gm-Message-State: AOJu0YyHzehtVS5c70054szjOQCAHvyKRGJaZz2ymfZmQa1R6Ljsq2NL
	xnfwu+EOYSDED/RUztiso9vdbNuYOiO3ZxTGNQS6fB5Uj2oyGJiYOfEy31ytSFOIdyP4sw3eMdJ
	1
X-Google-Smtp-Source: AGHT+IHze9T89P1sDEcGFjdEMMUPFMSFX8DQVNsTq7CvlDak++m895JHR9ff/NCIBY8OQPKV+rZ/Nw==
X-Received: by 2002:a05:6a20:a110:b0:1b1:c77f:56c3 with SMTP id adf61e73a8af0-1b26f0e6f30mr4568402637.7.1717202672899;
        Fri, 31 May 2024 17:44:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423da778sm2030669b3a.45.2024.05.31.17.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 17:44:32 -0700 (PDT)
Message-ID: <665a6ef0.620a0220.51ed2.690e@mx.google.com>
Date: Fri, 31 May 2024 17:44:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-11-g4bf15b1c657d2
X-Kernelci-Report-Type: build
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.10-rc1-11-g4bf15b1c657d2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 6 builds: 0 failed, 6 passed, 1 warning (v6.10-rc1-1=
1-g4bf15b1c657d2)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.10-rc1-11-g4bf15b1c657d2/

Tree: kselftest
Branch: fixes
Git Describe: v6.10-rc1-11-g4bf15b1c657d2
Git Commit: 4bf15b1c657d22d1d70173e43264e4606dfe75ff
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

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
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
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14cf94

---
For more info write to <info@kernelci.org>

