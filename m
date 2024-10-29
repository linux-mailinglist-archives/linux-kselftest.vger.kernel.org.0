Return-Path: <linux-kselftest+bounces-20900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9209B4401
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 081AEB21874
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 08:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4473C1E049E;
	Tue, 29 Oct 2024 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Ii79eSRU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E58318A95A
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189955; cv=none; b=FvPMwWKshaW7eRIhbtbGOv1TnevQVoHwW5aCFF/MQUKRHGrGuTYIzMFHrKcdEcF8LZOqeNpQ6o+ObW69juuKWYbG2GcTgyo54lSrm233JI+msmR4o+DDz9koKU3mDAAFR/4c+X9rdofXU1namN3sCSiE/dsZh5lSQ0MZy/B5mTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189955; c=relaxed/simple;
	bh=lNMeMXIAc1Psms2CgMltMK3KdPyLzyWC0MQ9k6U9h7A=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=jT/iLFJWYVMOtmNDXJEg6gEwborhhiNQCy9X35Jyp3IOCcRN6ZJD2eT1cMfNijPhr2J9nCVLWNzomJybkuobvouAfkuGWB68S7PaAU8k7s8YckrtajX7NXKOCrVAUgh15HrEjcjNCqIhmx08B8LeZ05qtHWXGEoujD0a12V48o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Ii79eSRU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2e88cb0bbso3934652a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 01:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1730189952; x=1730794752; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sHm33D3V6lEYupRZbzGheD5WM7UWUa6CO6WIPQOz9rg=;
        b=Ii79eSRUNuwHYcRDgfTXnBKVDedgu78/He3em/VC5FhVqqxJ0/UPrm2XmRNHs7fO2e
         zREgekwZ0d9EB+pokNRSlpnljyfi/qTZTciiDOZpkZniNHp77cG4QGnMrTqaOppUyoIZ
         fTEVFn3DhBfKfvGE33I+S9l2DuUExHYye9Fag+rZ0Yaou9jdT4y+HCKaioKFbkLi9tyi
         /o02HWCMTfXY2UZKKFRHW+JPPdSrVVG9lMljiJnHa3NzbuOgvy8WslyaSgur1tQm4Kqk
         tkmQF/IJNLkVt2sYo1oYEOH4QaztkeFX+fhcoHmnLORZa+Jg+8n0E5t6nNogeSsDNvYV
         P6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189952; x=1730794752;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHm33D3V6lEYupRZbzGheD5WM7UWUa6CO6WIPQOz9rg=;
        b=qlVPO7P22E0pvLbMKHzkYjzkhiOlPfOpV6iCIqKIg1IaTZK4GDkVsHVvPEG+akG3ee
         SOsYNW/LhtfZ+5Wtm6Y8Ki5YsXlyXJTZKpvvB86dNQlFNGtlNcoN6Ol92JT2kKZurZhS
         uEF2gPcO0tdHv5ONhr+D/uw/kpW/qSuuCcYQJchR4L++/23Mm5zwWYIKb1Yf4swJMlqk
         iNBRoe7TJeI1UeKM6aW+FRWEFKjtUbzjkzk3iHvGGGyGPFMo5c6eGABj88ql+A5HhvdT
         eGkmD1Bx7dMroL7EUIldq/NRiawhx1Y7xOG2mIl5X2SmuScUpkJpzMYkmlLVKp4bT94B
         qf/w==
X-Forwarded-Encrypted: i=1; AJvYcCW6In9jeOzflzc0VMM2aV+m+2aXYhU/nrT0l57VBjWJC3tzXMxjK337Y+mSIbzhNDlY78aXJMAiJmHXtKxej+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqUFLP9yP7+orxf3dJKd8dGDCFelFln7/pruRxfi8s+LBJAhQh
	7ONKGN3KYQIflC5queI4wvzQ1Z3aBEiJHNzmsnddkq1HnHL5o2AYGPFVLQqLwn3kL++q5j1Bk6f
	r
X-Google-Smtp-Source: AGHT+IHU/nz53Mki47SvszfuY9QwvtiDwvxg5tkiw7+6bn4Zeps7OxH9qov2hSyQfYw2vqK4qqI5SQ==
X-Received: by 2002:a17:90a:f185:b0:2e1:682b:361a with SMTP id 98e67ed59e1d1-2e8f11bad82mr12476291a91.28.1730189952331;
        Tue, 29 Oct 2024 01:19:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3555c33sm8825153a91.3.2024.10.29.01.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:19:12 -0700 (PDT)
Message-ID: <67209a80.170a0220.3bd00c.f7e1@mx.google.com>
Date: Tue, 29 Oct 2024 01:19:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.12-rc3-8-gcecc795329fc
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 6 builds: 2 failed, 4 passed,
 1 warning (v6.12-rc3-8-gcecc795329fc)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 6 builds: 2 failed, 4 passed, 1 warning (v6.12-rc3-8-=
gcecc795329fc)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.12-rc3-8-gcecc795329fc/

Tree: kselftest
Branch: next
Git Describe: v6.12-rc3-8-gcecc795329fc
Git Commit: cecc795329fc3e0ea2e84567ee57570cc050cf6b
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

