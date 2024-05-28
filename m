Return-Path: <linux-kselftest+bounces-10800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5A88D26B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 23:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43A7284DB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 21:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D620A16F0F9;
	Tue, 28 May 2024 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="uZ4CMTlC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52709224D1
	for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930383; cv=none; b=aQKF/c9rIDgTAsBwmeKf966GShn3iDz4FXhdXafqseygMvgKJOJq9UmWTH9/LTCpFuY7ZR/lPnhWNFiWxXqY0KdDf4RlXK5MnpUu6oh+MJmdDgU2TFEJNDg3fdSSOlmedGMgj02gB7eoMS9mEYXBZdb/alqrVHWgTXNqeKMA+Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930383; c=relaxed/simple;
	bh=8XDZMQA8yLU7L2RlNaJeQLSuygUh3vnvwaj1UF6r1Og=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=gCgSuUgFEks5gmDELUiuYNy5FtRHCmu3pg6LV2eTNFHj3B7Q15CTC9b3Iiqc/6/j/BKiI1ONudeBuIuQQ7RZhwxsEOqmepE9lCNUY6MSAzxHKxkZEX7DCU92HgFcAQlVlod5OGzgRzaOtVsgc99ReSKYgSn6TgrDvT+ws3frInw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=uZ4CMTlC; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-371c97913cdso5973785ab.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 14:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1716930381; x=1717535181; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i4S4WXgcd0atXXE+M7FeNs/HJAbYi0AA5YD7Vabb1Rs=;
        b=uZ4CMTlC6TC9oPwlsTuMBCUH6v7TgXy6vcFhN1+m7lut3f6DP/eyMGzlqlusCADWxK
         q+PKxcpEOgQd0+O82+SJzaAE6R+PW+n08Bw5d6x+FZbr6bYSE6t83MbHO1bR95XUggS5
         E0xwBeMn6kGzQh/0SYqSoL1hqN59SphM3eYscWMuXzFiiEDGY7j5vAN184eiS7vBPtp9
         RV+5cD2A1EMunku7uNchkj26A9DamJW4z+U9Nc0oSKAEXpnYSAcC0X8BwQ1Z00m/h+mq
         5C1FkMqquUbdYq5FRpBI2dIa0wwyYu6uZuzut6cVIhgOD+WcDkSP8wXeonpW2XW5lGWb
         JLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716930381; x=1717535181;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4S4WXgcd0atXXE+M7FeNs/HJAbYi0AA5YD7Vabb1Rs=;
        b=YtEQZSYfz9fcLPaUTUcn6Y0jlpKJAzfKSldYQvvvbXaVlqc4Eiqa1e+rrZUMiQy2/l
         61R+RsdzSGmOTxzsW+KOpurWmNngW3tEyRU4Y2CiXvYj1ZRq+hEplNuBR458Ivf0BR2C
         NPZdLhNXfg3rMaLOO9Ij0FXjpIWWCXBqZdsTx+Y8X49JaTWYFQ4jPJTz67rqqtrLF9rS
         82xJPqHXfqLKS7DfsP5IOtNN12Zm1dviJH0ErC2hTfVqFXWWPk4rMMkpziAgd8mOdfR+
         kz4DIw+FFGrDyYaPuy8U5ewA91pvdbGAkR1hqvpbbC6S97uYTo8Nr4ehkw/2tJOvcaZ8
         TVsg==
X-Forwarded-Encrypted: i=1; AJvYcCU72J3By1GuePX9tRG1IW+3slb8uRCBE4nlPDtxk+mUcTN0TKPUJJzBhKzaxIvLu1q1zeFkWWKCFq60GvFH+6hEuwDIdtUvklkXZk3wcWHm
X-Gm-Message-State: AOJu0YxBCn6RKoQHkbUon3pnq7w1M2uFanQY8YWqEHtBa1UnjlzbnsPo
	TQhnWD9/MmSo7AHjj4pD6xMspwB366vf0UV7XQ0eVvcgjhNVw99XQ7uHgFTNNS/5R2kOM0KF68E
	/
X-Google-Smtp-Source: AGHT+IFWC5woDyxO3nUUYCyHzPxs/aBdfx8j1ry38t3zZZH8vmMmm1cWdaf5wbYHs1eJPEmRRJOX9w==
X-Received: by 2002:a05:6e02:180a:b0:374:5a8c:c006 with SMTP id e9e14a558f8ab-3745a8cc123mr65094895ab.12.1716930381430;
        Tue, 28 May 2024 14:06:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682265461besm7931098a12.61.2024.05.28.14.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 14:06:21 -0700 (PDT)
Message-ID: <6656474d.630a0220.d2576.45e5@mx.google.com>
Date: Tue, 28 May 2024 14:06:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.10-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 warning (v6.10-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.10-rc1/

Tree: kselftest
Branch: next
Git Describe: v6.10-rc1
Git Commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
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

