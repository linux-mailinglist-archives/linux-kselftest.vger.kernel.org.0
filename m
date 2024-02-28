Return-Path: <linux-kselftest+bounces-5512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F9D86A84F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 07:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6DA287EAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 06:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685CF21A19;
	Wed, 28 Feb 2024 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="TubTD9SR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E29220DC8
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 06:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709101419; cv=none; b=jtslwjy4XwZqw8Inb6yrvu5FVK8LvbSDuI6k0DE5AsZ4P8599HA+JJxCfEUMdVA4G1qJujX8gz+QYJ7c0wW9qnDswEdD0nSLA3Eo0OftlJhy2HtSRjEyRWTIkhmY3WLg2ao71b4RcmzBAGCLH5YOSo81lbQSEOihhnCV7ZS+1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709101419; c=relaxed/simple;
	bh=S3gaZPPj4C5uWQzfSJqeiLPmJbuUDvQNLFX/3CZCfd8=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Eia6D3A5Caf39MXJ1eyvXs/xm7H0J3XJe6Xv3vfMMXI2NGCgtxjr0YcNLfH499+wri/5suX1YLUq7E+rYUWDuWeOTeuSrKaqbI8tE9NP6DXW73eA+o24tTXu8s+W492UQp4Wx+cUoZG5IqyrerHu/35SspdBd6B2pNEfZZniy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=TubTD9SR; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e478057f1aso2432706a34.3
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 22:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709101416; x=1709706216; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4tLla2QFOYK/qLFd89KdOyblPxy0l+y7tpb74w6E2us=;
        b=TubTD9SRB4FjXXFYNMWTlqsFYW8n3bd3j4KkZW63dY3jIgk5382ETGBXANOx4pzQgB
         Ieepb2Aw79wVFmXoXyiAporKW1WA3BUkuFAlYdIk9Z7boVZF22cNGncG1j6U1uP40mF8
         CPEjTv1ZPcEc5hfsBdeNbVxBjuftEk/w3a3d21grgr0ARsbYxlDCjjBKSqBVgR9tewIq
         hWgyv16lMHuVFD0kzYQ48kiJJlORrznqBmaW455/TAYHRvkQNA5ySPlehYBhrCabik9f
         NT5B7Z5NRmOu7Sp1PTOIk1rFZQCjU9FG8QDUTVoTZqzoeV8tn9DtbhLmsg3qWCg9D8do
         vsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709101416; x=1709706216;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4tLla2QFOYK/qLFd89KdOyblPxy0l+y7tpb74w6E2us=;
        b=cfmsgDusxh49oj9pcWIwRn52mCLmWsRndQ48eb/nYLqYhKwv0QIvE5b2e7gb2bray/
         xCaz/pvbnDM0LS9jlJ6wAiKr1tk0akz0sSZrGTT5O5oMi9xdweVFCNyEJtQymYlV74sf
         dDuo3pUt54SGs9diCSqBItUfSLgSgnhc6Q/5FiP1vvomvFgHeZHa9TBuxFhO/3mMk/+s
         fSbmqSMxjXCl7vFICMieKP+JyYiXwNLD0+jnkZwtKLU0z068NVrLFLv0BJN/GaMYJ5Zu
         VbnKl+r0+/rS19lxVoHfjVGIuwpu5f76sXoqCQtqtAr1Q6kX2j8oz5lxH9TFIjDpCF6x
         KfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH+msRF5jfn40coRg+0Xe7/+MmetQ7n7nHWLR64SAbVD1QXnx5271cae1CfQsJXvhpu4UaFBa7o/4hKoQeRKQW+gF0oJftvmIE+r+x2rO2
X-Gm-Message-State: AOJu0YzdORtgaoPaUTHEDW7Z2G578C33v8CRRzvkjBQkjCVyGHP2BtOo
	NecZeK53TQAnptgeVPxjnPwlHPNO1W+F3Bql6KvgCr2ziym9Taae/HwYBknn+c4=
X-Google-Smtp-Source: AGHT+IHyKSzRCSxaAoQw1sTrY5RUikXa5pPC5cee9uYii6BrKFIPdEmNXSlkW0HB900CrlWFpiDqCw==
X-Received: by 2002:a05:6870:1489:b0:21f:9ce8:462e with SMTP id k9-20020a056870148900b0021f9ce8462emr12352247oab.55.1709101416622;
        Tue, 27 Feb 2024 22:23:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o7-20020a63f147000000b005dc9439c56bsm6865123pgk.13.2024.02.27.22.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 22:23:36 -0800 (PST)
Message-ID: <65ded168.630a0220.7f688.a038@mx.google.com>
Date: Tue, 27 Feb 2024 22:23:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.8-rc1-56-g539cd3f4da3f
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 5 builds: 2 failed, 3 passed, 2 errors,
 5 warnings (v6.8-rc1-56-g539cd3f4da3f)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 5 builds: 2 failed, 3 passed, 2 errors, 5 warnings (v=
6.8-rc1-56-g539cd3f4da3f)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.8-rc1-56-g539cd3f4da3f/

Tree: kselftest
Branch: next
Git Describe: v6.8-rc1-56-g539cd3f4da3f
Git Commit: 539cd3f4da3fdbe7dc353634e004e4b0e725c35a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Build Failures Detected:

i386:
    i386_defconfig+kselftest: (gcc-10) FAIL

x86_64:
    x86_64_defconfig+kselftest: (gcc-10) FAIL

Errors and Warnings Detected:

arm64:
    defconfig+kselftest (gcc-10): 1 warning

arm:
    multi_v7_defconfig+kselftest (gcc-10): 1 warning

i386:
    i386_defconfig+kselftest (gcc-10): 1 error, 1 warning

x86_64:
    x86_64_defconfig+kselftest (gcc-10): 1 error, 1 warning
    x86_64_defconfig+kselftest (clang-16): 1 warning

Errors summary:

    2    include/linux/fortify-string.h:57:29: error: =E2=80=98__builtin_me=
mcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings summary:

    2    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_=
memcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]
    2    cc1: all warnings being treated as errors
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x14cfd6

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 =
section mismatches

Warnings:
    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_memcp=
y=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning,=
 0 section mismatches

Errors:
    include/linux/fortify-string.h:57:29: error: =E2=80=98__builtin_memcpy=
=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings:
    cc1: all warnings being treated as errors

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warn=
ing, 0 section mismatches

Warnings:
    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_memcp=
y=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 1 warn=
ing, 0 section mismatches

Errors:
    include/linux/fortify-string.h:57:29: error: =E2=80=98__builtin_memcpy=
=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings:
    cc1: all warnings being treated as errors

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14cfd6

---
For more info write to <info@kernelci.org>

