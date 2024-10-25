Return-Path: <linux-kselftest+bounces-20627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6B49AFDBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F176B21DD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDEA1D2B2A;
	Fri, 25 Oct 2024 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Z1he8XBc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5381D27AD
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847643; cv=none; b=VUYb9u3DyLYmNe150zMBg0VpucJUTM+fEdzdAY7mIRKtFW3STPx+m83t9zb0FdRsLqMSy0xyIBg2t1QarqFm4pd0aAWpyApjjp1PDZGSSDsH2o8yZtIQO6k1krNeq/3kx6cgeZv06EL8m8Uwv+AQOgMV7GNaVZH05Vm9vLOJgTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847643; c=relaxed/simple;
	bh=0gQqE/AHVcfyYnZYCE6RASfSYm+bCIaQ6zKFkagAmfw=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=VwwZiNx2f9nSlwIAzmjrYb8/AWju/SmISwuqVKLfB/prbEtaYqeY8++lxqQnJNPoddx1x5Df99vWYvZm0SPnQGOdkJf2TsdkW1XrLzKpaxaWwOKA7ze1ZQ+MgfAH8CuJxLQ78T07jNlM/rsSbK0l7pcqeMgBCmlM4KXvn0mhsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Z1he8XBc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c8c50fdd9so17986625ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 02:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1729847640; x=1730452440; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S6X5AqFoCsAZAJNeSewNG2nAaoALvn9M7vJk5Wm8bWY=;
        b=Z1he8XBcVh2nIvcc15Vh0pw1CT3MZjofDhdf2nf7KQj6PFrunqdklZvku0zieZRBMU
         pcXHU2/f7pf8UBiGLr6h2mwizJl39P7GBWPL0nBfb7CtXp6WROqVrWExxOLIrW1N8vbI
         JDKzFYgMjx2cdVyfD8If1Q9wWFIeg9cdFrfjyJ43xPZjTomS9p01P0D/TCd+hEuJAfis
         Cexnb3TOi7MDBIZ0Xfhr3fimPaeytR6RmVUFr3plQMRr5lWplHUuWnQMMpzIxywEAH6+
         sO7Kdad60SQnsMf6N/IxjqqK8pDqWzikWH88SjcpuSd0ZB4JBHtRa2lHvEUrUgrjUJrv
         v9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847640; x=1730452440;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6X5AqFoCsAZAJNeSewNG2nAaoALvn9M7vJk5Wm8bWY=;
        b=PZQgNjCfzkul0BYnvLeEoZJCdeCMWQJw1RMI+fggqIbfIP0BL2CMYtM7id3OJoLqat
         KSFbp0kbmdf7bD1KuY+xHQ982GR3+3eh2Q6Bc8VTVY2NMRBLiH2EREEFiNXJnN2Bsa4c
         LyeU8r53cEJgjjXPEsWEigNKT6xU9QdSdlYh/eZYSte505xot8HzDWc/im1DGTYy71BJ
         Xfvs1gYpYLFC8GRdGnJfkLvWunK7m+AWyxbxBNrOniHIxOjwR2VuWP+lVpvRvjtBPjiJ
         AMSyEw394Ks8Psy+A80Q2UqRSg7+VNl2hcMRAIprFtABXqzc/3/1XiXVY3s0isVOtbCu
         LS7w==
X-Forwarded-Encrypted: i=1; AJvYcCWweKENneIrt1kXHUgMeV5Q1R9UZ2NbGcn7I7YGkuRvhbLjhoqHsBKX0xhGRHcvyVlmpGbjOvJDkTH9/7byFO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTcvDimTUQZrQ5J4HWV+HyHc/JzNYShEn2llThTFGh/+Yek9wX
	dyNu8Mcreck9h4CfSkA/k/F7aqWcd906srhGB3+7dwD714jco40GUQ1J56FX8yapodrjVdTxh4h
	kzb8=
X-Google-Smtp-Source: AGHT+IGoNmAh+vjVt2Z7bHn69W8GCMSEo9msNwSBso+ddKoEI7rMKazSLFSivfz7l9+DjWNU2cBs7w==
X-Received: by 2002:a17:90b:3010:b0:2e0:89f2:f60c with SMTP id 98e67ed59e1d1-2e77e5fa1b0mr7904340a91.11.1729847640514;
        Fri, 25 Oct 2024 02:14:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3555c33sm918961a91.3.2024.10.25.02.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:14:00 -0700 (PDT)
Message-ID: <671b6158.170a0220.3bd00c.25c6@mx.google.com>
Date: Fri, 25 Oct 2024 02:14:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.12-rc3-6-g2a027d6bb6600
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 5 builds: 2 failed, 3 passed,
 1 warning (v6.12-rc3-6-g2a027d6bb6600)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 5 builds: 2 failed, 3 passed, 1 warning (v6.12-rc3-6-=
g2a027d6bb6600)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.12-rc3-6-g2a027d6bb6600/

Tree: kselftest
Branch: next
Git Describe: v6.12-rc3-6-g2a027d6bb6600
Git Commit: 2a027d6bb66002c8e50e974676f932b33c5fce10
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

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

