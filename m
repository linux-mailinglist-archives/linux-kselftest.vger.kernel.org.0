Return-Path: <linux-kselftest+bounces-12191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ACB90E12D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 03:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF171F22ACC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 01:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA6B5227;
	Wed, 19 Jun 2024 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="d+WB/7VR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E1123A8
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718759839; cv=none; b=umocPUlKG1E+nyG4fNUAY0VR4DeHB6xsUeXmYmU/lfbr4s0p5zRN21jreXWiSf3WAH2c463Zf3baTvRjFoxNrktHmbWblL3nIZv4ZFqnkVp9Q94cutGI0sepPMJeQTPMMAZ8wYG3d4GVXCFTarPrnPDeN5opY+yjquDS1/Pp2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718759839; c=relaxed/simple;
	bh=r1BO3ohYWqvNEJxdDtk+dFEGCIEf1Wf43o5NQMif+HI=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=LM7G93byAlN20vdqiM/uE9maQtjJQunEriecgB8dPUQmOMHvauU6MnG2Lkb6pDeDxNHsI/VOzwjOWSWBGqrWcZX6Tnd5iFdZw6GL/IumUY6k2lb0HFL74/CcWCb9qCU7byqZoG9sTZu4xPpBv5znDiEUbwTDUl5bj8WQqP7yFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=d+WB/7VR; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-6e3741519d7so4186038a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 18:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718759837; x=1719364637; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xReDvTzDNEJkC8OAu/M7/FNa5LHNulGR05A49zLRYUE=;
        b=d+WB/7VRNBMMONNRCD7SMNZTbNsncBiQVTBe/2D4Gi+2WfspE7aiH02oYsMkQ6x2My
         KU8xZzQRPBbV4G8ttXuyt7ZC9+O+ljFeH5XqcRwzXNXifu3phZq93K0wFqyQVGcVzCYx
         rSBw486iaA265j0V6BOidnWCiRgxlXx+Zv4f3XfvJ9PcNvmH9Tt7Uc8EJ5ma/+d7peRc
         GdSh4DePGjGItI/UN+hbdYBqviSYZpLvjtiVH/rK5HlZLrV1tb9MGvnEfYKQp/vp6Fvw
         cggjNPhVFTLvWqWg7j+SbQY0PwPexMaJ59O7awl6m+nhz4v8S20lGWMfvjw196ZxfD2S
         6p1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718759837; x=1719364637;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xReDvTzDNEJkC8OAu/M7/FNa5LHNulGR05A49zLRYUE=;
        b=gtoirqe45gG98N3YhRVAEKaC5fgMqcAtRGafbKqYtATCe8n+iQV3dZImruI85paOs+
         0YZYzpHZq2J40lpDYIn95dhOPHWurNJm9UKkbl+2VCbt3MLtqEAQtFAWggZFjRX/+4lv
         jSjuPeUPcbG9zi4xivi7S7dfpskBuwAqSRQRx6YzLIOYydCr35bmVT1CO7McN7e2qvqD
         6CM1mZ7x7DI6YcNuVc4GUxQINa6xq0w7JGOV6WGjVQpQqfZnxKSe51euK5a7+DDCEl61
         QB3QNHY+HhcA1QM0aCS4P63FWsZCw9AcNmU6vkCAc65BvQFc4BnB+y4IpVkEQoZx7K74
         qHCg==
X-Forwarded-Encrypted: i=1; AJvYcCVfYUAbpjjBWkSQTJI6vCNh3R+YeLckD9M8/KwfBDraDIYHKdsljLEKU2vD62fzytZwPKW6YgqPG4GGraorTDcCMi5ldjZ0nFouR+ZQnx/y
X-Gm-Message-State: AOJu0YzOnfoH1o7ogrND9hpMvXTCKBgMlbbauHBKC8uPHc6yNLA6h+sR
	e9NZIb3eyg+Bi1YLdj2453di9v0KX2GoNRX0uVgKTqLVyvjzdj1Wg7l/QdMgU5Y=
X-Google-Smtp-Source: AGHT+IFf3/NBGyRV/HLjuvvOue7jXHwJlhnMwmlSDdeWkLA7FMCstRZwg/xcP3sbmBTfOqe77iU4Ww==
X-Received: by 2002:a17:90b:954:b0:2c2:7bbe:d6ba with SMTP id 98e67ed59e1d1-2c7b59fa6demr1323410a91.8.1718759837016;
        Tue, 18 Jun 2024 18:17:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a769bc3dsm13834322a91.37.2024.06.18.18.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 18:17:16 -0700 (PDT)
Message-ID: <6672319c.170a0220.23e10.7848@mx.google.com>
Date: Tue, 18 Jun 2024 18:17:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-19-g15a783a493b02
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.10-rc1-19-g15a783a493b02)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 warning (v6.10-rc1-19=
-g15a783a493b02)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.10-rc1-19-g15a783a493b02/

Tree: kselftest
Branch: next
Git Describe: v6.10-rc1-19-g15a783a493b02
Git Commit: 15a783a493b021975f3dd12bdd95a7080df0e8cf
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

