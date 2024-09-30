Return-Path: <linux-kselftest+bounces-18680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3909198AC0B
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 20:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5A1283285
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 18:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2FF19308C;
	Mon, 30 Sep 2024 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="pBxPDX5B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFE2B9A5
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720729; cv=none; b=FijY5xYNFQvdbvS99Ei0Sl7sFEhSqfJ3LiFpjh4pLtfFi8GemuL9GhhquHb9X93pPUhJ800Qu6tA34vv2SVxo40xcw+YmYOn1KYnm/JPFdJarmg6onSZDyODBzNfW12W6FHITBGUebB7gtG6JKMqTRcV/d0lKJXdSOXkJDsrbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720729; c=relaxed/simple;
	bh=lAPYo4phA8n78e5EYRHFp/PhJ6PyBrnB1w7qXwJXapw=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=U2nCgHwD0QZRk7+J3+SgID6ja3nLwiToQN9GuWlYXnibfNawNIZIAM6WFwdxHAYS/WMKKW52zEMefx6MqWhFBYzSwSxipVDLgI3HGlws0B0QT3UOxMc/hWDbOZx+mJhWxT4L7XS101ZiR5tx6RQh3iZ9ZDVHhjorO4+3PGHt53k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=pBxPDX5B; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a0cdd77dbeso16447405ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1727720727; x=1728325527; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x8MU0D47RTUGAw7/c2lj9vd5eyt0Ge45pDa1v1gKz5o=;
        b=pBxPDX5BTQleNOMlbNna90Mc/YzFVykOoBGO2KDyi7n1C0Pw6bIgfX0Huyw383BlBB
         3Ja5FZr1gp4fs5op2jDHrxxXfcxJlZGuCaPloQLI5acgI8X8eCSv8CeQo6Te1PFTt819
         pxynFtw7Gc2DNjWYSHihEf/7E1uFfDq/xC89y5NoO6edooLi5iYvVrZI0xY7wrXDgMhz
         66UksxrQWEq92ohJl0UicpE7IsPQUYKoncHv/RRYU+NsTor89g3vcL5/hWpIYh32mvQU
         p3dBOHqpopE0hUSAH7tkELjsn/iEboWiy9xDbeF4sClc5bZMMECPcElHZI3IbBOfIU8S
         8mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720727; x=1728325527;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8MU0D47RTUGAw7/c2lj9vd5eyt0Ge45pDa1v1gKz5o=;
        b=jDFJm5mHp3dj50wK2AvaVxd8AWZoG9XDZQkDpd+LSoxniadkQhKbS4RSuNRw1T1Jl0
         NodBp97U4ihbG0OQMlgOGpIaKnxnilmGgjvXnS8UvYs5LoUNvUX8FZXpbWapMUyqTvWb
         Tf9bBA9gCzqcJ7GdyGNac/pbLKYnHyLWs+y+4FBNsk8vfcLBTb05ecmlq7ao7LPUlgFA
         si5SJRPpvo7E8ceNYHsAjRQ7q13DzOStcx5mAqVdGlQ8xWOeIFvNbxDU4oTbU8M6+Oh6
         F1FRs29tbXu/sbQURTXqDvMHfwOuTXAn241HT9ml28Tv+8QGy/xqejJPOIxL4AkIZ8If
         Avaw==
X-Forwarded-Encrypted: i=1; AJvYcCUIiB4jOgd2MaAY2Op8pgronF2d6qOH+g4H2jDs8dmkXMl7UeepbJ7Wk+PWaLgNmR4dVPGAFEbLKTKDC4IkkYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJAL2pOKhiENyH3q4mmxQmzvkLyVglZUvz2DcrhOGc5hcNVGp
	2I5NP3sIYU0nkP0CwaHfgvXEeSid4PdACvORYLAbIwf/tFK9Zr8ZTEwPl1q4v3k=
X-Google-Smtp-Source: AGHT+IEtKnVIiiVu0H/JkosOHBbveOanEpKPzpstVpRePpUJVU8l7CSxCtLLbnwCzsXgSyQ7vOrM3w==
X-Received: by 2002:a05:6e02:190a:b0:3a0:9829:100b with SMTP id e9e14a558f8ab-3a3451be445mr100415195ab.21.1727720726822;
        Mon, 30 Sep 2024 11:25:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db5ed118sm6944451a12.71.2024.09.30.11.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:25:26 -0700 (PDT)
Message-ID: <66faed16.630a0220.2d0b7e.b1f3@mx.google.com>
Date: Mon, 30 Sep 2024 11:25:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.12-rc1
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 7 builds: 2 failed, 5 passed,
 1 warning (v6.12-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 7 builds: 2 failed, 5 passed, 1 warning (v6.12-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.12-rc1/

Tree: kselftest
Branch: fixes
Git Describe: v6.12-rc1
Git Commit: 9852d85ec9d492ebef56dc5f229416c925758edc
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

