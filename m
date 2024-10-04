Return-Path: <linux-kselftest+bounces-19073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8E599121D
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 00:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A521C22D6C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 22:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D0F83CDA;
	Fri,  4 Oct 2024 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="n6HwnAEE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA3F9D9
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Oct 2024 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079510; cv=none; b=TZx0iHuChkvU0H3RP9lqHywjvt2q/3bgNp1qU4a/JYfvSUfL1InBz69qK1mJutlCfNFuvXFXoh5+I3FRJZodmOpyzPyZjIDhPSUrltDF6oF536CdHP8jQAzwFlQeKro+g00HELhOd+winJx7EYNBBmh9wMAO/ZaWnfX+bIVUyRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079510; c=relaxed/simple;
	bh=o44XdLaqksYYre35WRZo88XdDp4wvxCViIgOHeeA8T0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=nDLW9EAnlDTq9T6Fq2ks1EqS5UZxmyHaBO1457X5TkQUMVSgA4D7Oqk2PqDAoNTduWB+pfUGraJLPQpRn5ET3bqL1o21f+xtH7agfV57y5NoGeblfTyElVoCP3t2c1V4VYvGot7qeOKLDoU1P9qG9UXzBOivRDzSqse4yLLV4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=n6HwnAEE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71df468496fso9064b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Oct 2024 15:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728079508; x=1728684308; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mXJ0mrxBnR+82WbLhWtTr81SvPWE/TPC557vehWhhu8=;
        b=n6HwnAEEI5MvL/dQYPRubmHZK7a7mqqsXcUUXVWojVKNX3Q8vUPRkV0jqNSBhOuSVH
         RWIivELUEwUkOOdWcoEdToAPoe13Bi4dSSZnSWGWd+tCuA7pjuyklKrs1fyQwWfsrkAZ
         6ADMkOH2Z/WdSqA3tokHYz9iE7V18XkiRuQ3m4vNUff10RDw8cLtPWXxP7nwc4Domeop
         O83y6+3f7AKd7rsuUKIwn10kTciXdsrmcl/xYxUjM51/u1E+gn0oaABoXjB1+DLRgbdR
         nlK3UV3FxXO0LB+Nh2Dc1B1bIRig6OgMmXjSxySdzEJt7zm6TQngYw+U5tbZIBKJfp+u
         htlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728079508; x=1728684308;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXJ0mrxBnR+82WbLhWtTr81SvPWE/TPC557vehWhhu8=;
        b=l+UnmkeE306tj4Hq//FcYmt6ANUVysx6m5Xtsxu3RNztSfImebVtxNIQX42o0NZ+LA
         KAr8Z3xAFjTSKN4BMXdxW/KxE5ppCT1Gon+/tsFnQ7maygduhGSAK87INlxaHyShG5jF
         D4CCyojJpiyW8XCxPBrhg6V/ww0W7w7oXU8u+Kxkowwxw0y7aK+ZYVbR4ygW0lGVu3DN
         h/2gJ+spvUV0jxfR+HcStaq3/3aX7e7khGVozFpUI1v9luwsdFrJNeSZwS3YIW4LDXmb
         j3EYqGsH6jkICjeI7Osyc2B18Cr0MA7AShtO5YxfFDVvUv1T1mrgOVvo9EWfxI9lEeaH
         bS5A==
X-Forwarded-Encrypted: i=1; AJvYcCX1xbIesWB0ZTfUcSkaFplGqam8MttBt7Gx6sr5Icqd9shcgvFNg5rMSkgcs71gOlWjEBSAovBuM/3EnGaJOSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu61MnymWAd16Pa9X5bWSM2q9XdDlxLU6UgEaoowSM8A2emMUY
	0AwAn6hwajuhcuXmhgTlboKnFw9J+1FycYt211QeHoMZgMemMkz00zivWPnT8ECV693IVgyzKj0
	t
X-Google-Smtp-Source: AGHT+IGQp2OSRUbIoo4C4ada2ZthFr4EExyT7rcqnCIi17HFR2I/oMZ+oqorhFK+/V4pyWo2itqO2Q==
X-Received: by 2002:a05:6a20:e687:b0:1d3:ba1:18f4 with SMTP id adf61e73a8af0-1d6dfa42880mr6023761637.26.1728079507977;
        Fri, 04 Oct 2024 15:05:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d66821sm361864b3a.175.2024.10.04.15.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 15:05:07 -0700 (PDT)
Message-ID: <67006693.050a0220.e3d95.348c@mx.google.com>
Date: Fri, 04 Oct 2024 15:05:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.12-rc1-3-gedd435390c554
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 6 builds: 2 failed, 4 passed,
 1 warning (v6.12-rc1-3-gedd435390c554)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 6 builds: 2 failed, 4 passed, 1 warning (v6.12-rc1-3-=
gedd435390c554)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.12-rc1-3-gedd435390c554/

Tree: kselftest
Branch: next
Git Describe: v6.12-rc1-3-gedd435390c554
Git Commit: edd435390c5542af4634a8ed8f3b0bdb34ea4987
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

