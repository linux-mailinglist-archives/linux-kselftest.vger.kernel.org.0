Return-Path: <linux-kselftest+bounces-17082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB9B96AD51
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 02:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3149B238EF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 00:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FA7391;
	Wed,  4 Sep 2024 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="wSyi7lB5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD665C
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Sep 2024 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725409751; cv=none; b=qOBGyUo+IUi83/yIRRnehCj8MXnDnWL/RmT/4zjMbh+aRVHjLI1uEs55zSYhTsmt2shRMAHhjuoGIiWmQtuOESPbeL2onQqBB9aI8LK+PIondkM3xly0DE7RXV9VCySR5N4I1VFQcznLpsFs/2DH4Fo6fl6KNT1dzwfPr79Nyc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725409751; c=relaxed/simple;
	bh=Kh/rmEP2mSV09S2PqTxJDvyol6wbIV5OHKNGmXH6zZw=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=lLO61L2Ym53HrhKoEynv2T3PY9/N7bjuMkhm3YY+G5kE/YpwfDw2SzhNgb/rPY2+z/p9ci2K871qqVK3rb9F1iGi36BzUWDDaUjxIKAnXInVMULLjYrtvghJb7rXDbdGZSo6WBXzQbpw2SPiyclAKzaID9ubFchld3h+H+g7x8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=wSyi7lB5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d88c5d76eeso2545688a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Sep 2024 17:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1725409749; x=1726014549; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cNtpzS7zrc7sh2PiWdFN57BVHUpGWUdjbzVVI2KZ87g=;
        b=wSyi7lB5+brlExgBbY2Irze0q0NA8iZ4j54gKYNhZ3HPIBiMnvIeIOz+DAzGVxJ4Vs
         vdU/9cdfzDZP79wQ2xd0TG5XHm0afnahhX6BPQ+om683Up5RTL/nbFvkYyEusPpX7Z7U
         msC/HwSjegopDL2w2OEwjbxGPXxOcB/hvcPUM1GSbVeX2M83DlyqwWEWw4NaJAmjPFyq
         L9ji4prPQKtl48+Wc0gNvCragDaK21Z+02wNJu64qNHSUkCc9kpGiEy29a3JumE8w1kA
         aC39U2zwsPzTYLUSSHGTDKH1X4tMxZBZtjjWd95a4tzAyf2OX5xpvMVmdHCFx9PuxT38
         u0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725409749; x=1726014549;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNtpzS7zrc7sh2PiWdFN57BVHUpGWUdjbzVVI2KZ87g=;
        b=EkaSX82Ef8FlgC9R84aSav3Z8vx8eQEB0wuTqmgs+/85VlUTx5AniZFWG1g+Az+x4Y
         5lDLYt3yQhPnsPmJr4r9jCi8Ae6DvU5wzefCQAdLFFv8S8Qz3FpRLpI9hJWeFJ/M64Z0
         vo96UX2BF/6l0HmWcMAmXWxKnXN7GsuNooxLX+zPhYv8hccU2tFbku/MfIbXuJau392b
         5adjLWnWd0GjbRBNJXSRU1ZzOex9tDfBcCojAXm1OwyxRWxIAL1BbjmOk9tErdkbyRC3
         bDgYG2nczt+5CFXhB2B0jl7yzUKYIwmS41fOBDgI3BMLr08eSr6YA97hCBfW2TC4U1x1
         7b/A==
X-Forwarded-Encrypted: i=1; AJvYcCUzeYbqw/AIcGg2QZQiZRm9HtAO4b/943mPZ9gX0QQTZyf1hVtIae6NQhaiEyjq4X1urdcJtbt3IQ4bfBpcYuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsrWc0uoWIg5BfdmMuVZCwmPHn7k5FVRQwlHkA+KwIz2JtSKDN
	y61tXdL3uV54nHt4h7qV3qyZQA76JSFEU2BYjW6cBentnFQKT9pvvYJSDz/LF9pG6qFYcYJqpXi
	M
X-Google-Smtp-Source: AGHT+IHZZUFrtmKvaApSfa8scD/aTS59hWFe9PGkgDS7QDs9WrR1/5OInHrK3oXQk+odD1w8efBRdQ==
X-Received: by 2002:a17:90a:6fa5:b0:2d3:d7b9:2c7e with SMTP id 98e67ed59e1d1-2da559a2cf2mr5424619a91.24.1725409748887;
        Tue, 03 Sep 2024 17:29:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da901926cdsm73139a91.24.2024.09.03.17.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 17:29:08 -0700 (PDT)
Message-ID: <66d7a9d4.170a0220.2b97fc.03e5@mx.google.com>
Date: Tue, 03 Sep 2024 17:29:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.11-rc1-17-gb4bcdff7e839
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 7 builds: 2 failed, 5 passed,
 1 warning (v6.11-rc1-17-gb4bcdff7e839)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 7 builds: 2 failed, 5 passed, 1 warning (v6.11-rc1-17=
-gb4bcdff7e839)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.11-rc1-17-gb4bcdff7e839/

Tree: kselftest
Branch: next
Git Describe: v6.11-rc1-17-gb4bcdff7e839
Git Commit: b4bcdff7e839237d89a2aa15b6042b96b0240ac4
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

