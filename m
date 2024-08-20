Return-Path: <linux-kselftest+bounces-15793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D8958FD4
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 23:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA231C21107
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 21:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D041C579C;
	Tue, 20 Aug 2024 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="c8rc+nd/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE51645008
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 21:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190137; cv=none; b=CiwUajll9jrWgtPjvayNTYID2AE4WPikagm6kHSMpiatHrKo+AWgrAxcVSETeEkxLG7DFKrKK3Y6N2TEmqU6OmiC/G5j0As1GwuNC1YgJCCRfRSTYkle/T4o5iFRzy/IW8lV39Xwomweo5tPI66qckmwkdWRAhBVyQhlYH3KnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190137; c=relaxed/simple;
	bh=ZLCzDf0eRPkFAYMiz5x+rDCokoV6AxQU6DYD35R9bdg=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=EKHGj1sif2w77YvuFgDJtWhVoHUMvYP0D8OkfKGG5dkKrazvA3VBdp7O4NZZqLdv9o8lLU1Cz1rv7UEX3ElPImn8bc99qsPVJ2yS7/tAgbiPAT/qnQUVS5ncnp+2loijHcwGQblK6y1IKF0W4wkAmvs6BTbI0229Cx9k5dPJXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=c8rc+nd/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-713eeb4e4a9so2067593b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1724190135; x=1724794935; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vTkPGtd+DiinFMab+CyqohzMBNEuQMAf4Uf9XUhpPeU=;
        b=c8rc+nd/qdvJAlF4mzzofdo7vEx4MlHCBJbeu4U6BQPXp1+P8+oti8jJKuqQ+F2cdm
         3A5acXQ1u+kp0iuMEr9G11zaLiOroc/vF+1yUN+GiMMrXndieuvjA5UeKlZ1eY7GovZL
         Yg3VROCWtcNQnhqfSL7EOhbmb9HziruCCehTO71Zn5DLJubZWBp2K4Mp4mbmeH1zJV5l
         PxamfznfUyZDV9uhRBtKUng7DLkwtEyxzNzR6oK1Y0Q01TT7whptXn5UKZNixxUdYfw/
         +J75x5r8gHq5LjdKJ16/rZzjSLNNxdGBzkwwVglbTwUJufxU46ipNTtyRB3seTmfdIKq
         6GrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724190135; x=1724794935;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTkPGtd+DiinFMab+CyqohzMBNEuQMAf4Uf9XUhpPeU=;
        b=raRi03YP+F3xhsEb5ixz7o3TOOFBZIgsNWzCFTvM01lAmd227b3XpubNo6Cj5iy7T0
         ksaGL9EU2rizgd861c7rrFPe1f59wlBez7WDdDS66Ls2ACBWlD7gwfjpvOYBNZ7SzQtC
         tHBUdUGa/CcdqaKIxkQzlsUZczagL9n34HibWh5wDjZUMrcoI2GpecRpuTjjiGcla9eU
         PlxTmErwSmauynAHhUrD1KZnHF+Z2n03r+uoK03quB6d7JiTRh7Q6iRGh3psefFFunJC
         b74FelSAXLJPAAc7k87A5/M6qVJtKgXIhsx1yJLOf8qhRMLbSAS11j/jIf6+ZrpLlKlC
         dS7w==
X-Forwarded-Encrypted: i=1; AJvYcCXlVLtf0GHlkqq2csp35ptAQhDK4hrUy4CsSMMGLYaGuuxBrT1843VWZSpiGgGUqtK8d521iOa14aa1dpMloqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqjC69Dp0Kn9pU/zf+mMlMYQ5n9OzPxkKex1eUrGhlb0qtCrDX
	YpUJjt7LcvS1MIz5VgEV1po1pgQrfFmnO5iNk8SwQh2SkrlsVMbmh+yww7JI2nVV1Xz4y4v/Hqf
	Q
X-Google-Smtp-Source: AGHT+IEqcJfLG1yk+sfTMCVLO/Oi565iZ/THorWpiF/M6ChvP6uuQenJRBLjh5FHU/bYEqCn/0nqRA==
X-Received: by 2002:aa7:8892:0:b0:70e:98e3:1aef with SMTP id d2e1a72fcca58-714235b336dmr419348b3a.29.1724190134772;
        Tue, 20 Aug 2024 14:42:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0cb5asm8701841b3a.69.2024.08.20.14.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 14:42:14 -0700 (PDT)
Message-ID: <66c50db6.a70a0220.3ad085.ed61@mx.google.com>
Date: Tue, 20 Aug 2024 14:42:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.11-rc1-13-g41f37c852ac3f
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 7 builds: 2 failed, 5 passed,
 1 warning (v6.11-rc1-13-g41f37c852ac3f)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 7 builds: 2 failed, 5 passed, 1 warning (v6.11-rc1-13=
-g41f37c852ac3f)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.11-rc1-13-g41f37c852ac3f/

Tree: kselftest
Branch: next
Git Describe: v6.11-rc1-13-g41f37c852ac3f
Git Commit: 41f37c852ac3fbfd072a00281b60dc7ba056be8c
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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14ef94

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-12) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

