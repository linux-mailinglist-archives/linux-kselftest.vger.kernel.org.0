Return-Path: <linux-kselftest+bounces-3411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFC8839048
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 14:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5219B28241
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 13:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523FC5F555;
	Tue, 23 Jan 2024 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="P5W2uy7t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664B15EE7A
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016865; cv=none; b=BScf/2qOJhmXdiA8sXgzT4e5JifcAB2DclERjcCYQg7WPXSqy0upduU3NadB1mtBjmQfEN4CRa/fTNmD6/Jq4zUbMTD0pqR02lBV0HjX5KvYj6nw4w0+pviVaRn5Is3KcOSijV14EiI2g2bo/w2zPmUztFoWQspeVaEJ3nFs1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016865; c=relaxed/simple;
	bh=PKJyniCrYvxTDYJ+wP0zJifH7fLmX25pRae6tJ6+avE=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=mbwfK+d/xVyO+qS70ddp0mFCSrVzOfJ/lpme8USxadBYdr3mUM2P1nlWAXbC8etY3uU6OlzcAu31N0lyT2lXYzMe36wUHBj7Be3xduLdVrOpQlkUqDjKN0eG9SeaUFXrjuPUxNoQKAeL/BC8saCuLdI7CMwksXp+NmPru9TBqUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=P5W2uy7t; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6da202aa138so3311188b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 05:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706016862; x=1706621662; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pS7pvOquY6DbNLzoDnvEiN1OeUucFCfxAuRs8+bkAHM=;
        b=P5W2uy7t8DHx4MplkUDvruAC3UBuiVsW5PojKQdq/NY4YIloOYi/z/zPokW/dx+08Q
         VBTdpfT6ah4FOxCU4FGzHgqn1l/ob/iXYZ7yDi25uhhptMA3F9g6nsRAWReNEkqGr52O
         DevfVhV+jJfBK+/Vcma1enL2t9TcqTzTE9bDPD7eqLEmmSUqGTyYij9TRPcATjCGuA97
         WRwdTd790L8DCf6STqxPY5R3yZJvrn0Z43YObLRoU+LrCm05jfq4RJVnr4CK8eZM5gGT
         XnnhB/w4sWghfduZjckL0kSKW2GUTvW8V20xk66GPCJw2FOZJXxtSG/5QwrQc/Kr0oK9
         QLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706016862; x=1706621662;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pS7pvOquY6DbNLzoDnvEiN1OeUucFCfxAuRs8+bkAHM=;
        b=NTCEpfBAOeUCncsh+fboApjGY/3F8l20rqk3Dcn1fBdbPu+0K4MbjQVIO904DRn8A2
         +gGxNa07Ueki0b3LruzpFSCcOa9eD1HWC0Fbdba8h8saIH2XAhfpqEXn9snvggj+YcMq
         TGTq1RLkd/w0M/GvnYkYsdjpm7TTovNc/NfNFzAAV798xn9EI/NwNWdhhPUIU2Xy/ZhB
         hvdw4mnodSWwzK1s9D508gerlRwWgkpInZ34TTqqtbBQR90lBDkjiIXUv6Dr/QAxTBcW
         jvVsjThzbpACHPiqeB6fUP55WsDy8KQLX5X2Pb82jIXfAx3xlo9KWMaEAyS6QGQV+t/M
         VvPA==
X-Gm-Message-State: AOJu0Yxl4rVu0TPT7MbrpmebWMurFgGsMCleeR2CZuWf9qdBA6Ilt7bw
	359aA93whoRPvQiwSpAIbvnRyA2BUpiM9SfPzZT2V0/SneIchiEtF1WM3GGDw/j0ulXRiVzlqaE
	m1fY=
X-Google-Smtp-Source: AGHT+IGqt46eA13n5pNfiH0XmE2BPXXwvj+RYvplZCN6wyd5wQkfs7ToIIyBkvF5G0RwzNg8hSPs9g==
X-Received: by 2002:a05:6a20:da82:b0:19c:4fb0:98ac with SMTP id iy2-20020a056a20da8200b0019c4fb098acmr2604793pzb.63.1706016862652;
        Tue, 23 Jan 2024 05:34:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l18-20020a62be12000000b006db3149eacasm11530778pff.104.2024.01.23.05.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 05:34:22 -0800 (PST)
Message-ID: <65afc05e.620a0220.bf0a9.8231@mx.google.com>
Date: Tue, 23 Jan 2024 05:34:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.8-rc1-3-g6c8c9d6e1bce2
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 6 builds: 2 failed, 4 passed, 2 errors,
 6 warnings (v6.8-rc1-3-g6c8c9d6e1bce2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 6 builds: 2 failed, 4 passed, 2 errors, 6 warnings (=
v6.8-rc1-3-g6c8c9d6e1bce2)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.8-rc1-3-g6c8c9d6e1bce2/

Tree: kselftest
Branch: fixes
Git Describe: v6.8-rc1-3-g6c8c9d6e1bce2
Git Commit: 6c8c9d6e1bce2871df58a85d2c0c545007c34f5f
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
    defconfig+kselftest+arm64-chromebook (gcc-10): 1 warning

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

    3    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_=
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
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 1 warning, 0 section mismatches

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

