Return-Path: <linux-kselftest+bounces-3286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E0C83591B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 02:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C99DFB22024
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 01:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067BF36F;
	Mon, 22 Jan 2024 01:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="MKdt/npr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB6236C
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 01:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705886286; cv=none; b=SEhCNdmY4B18b9KCDILqzg+1lX8NcDuGrh6NUbdQ4V8TOTo4gT5EBt+V5rXK2AqNyET7Y0HoT2Ph/Jzq+tyMTepAb55ohApEwk/t2uCNQAvzuqqGz8+cgJ5Odyk+uxLX7oz20Lgfujj2aCgqI0hWSpbQeM5dYs6taxM/tCuH5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705886286; c=relaxed/simple;
	bh=q0FOWmoA1w2554nTBj2ZhBc3OM1gOoibzeFqBQDE/VY=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=tL16aa+pL78CgzyA+PnT1cJgmJwA9ZqEE/11kWbTe/fWIiyxQsEOoD2t+6/0iBA+15Z30uqqL4s8qK4kXZ0mlAXZwXCpFbhWVBrPPcPwY9z9tI3Wepih20qQBBzpv1gbKP1BHR3Upu/llVfxl7lQZn4HaKGo2LLe/W5V/Q+2vTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=MKdt/npr; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ce0efd60ddso1228129a12.0
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Jan 2024 17:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705886285; x=1706491085; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JnDbuPvIAbzlqsqTcfJxI37MPB9jKUm4YJvaLINPhUY=;
        b=MKdt/npr8CMSfU/hgU9BDCQiMkwrL1E0JeCiuI5M9I1e3x1CyPptY+u1eBup3nIapX
         Dp7Q634HA0zcVBKUakLuAMPuu3xDOLWVlMIb6YW4WJT/Xxk7Fkcvj9KJL8aa8afvo5I1
         I/CZDiMQ95YV37ysUos1PXHjRWqEdHF8jx1KxvQOp8HRC0YFll91jGVDyDYAmge/rnNV
         87P95F1HORGc/lWJEX0LjfWAS7sqNKPEbfpfhAWfuor6oBY4R6z7CHMjWBXV1NRFLtaU
         5c+tayRQA/St6tCL5u9tVWpyZtrSlSBSJxKDlKiRNd6uSaXhVx2AIudyplQewycIvLoO
         t+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705886285; x=1706491085;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnDbuPvIAbzlqsqTcfJxI37MPB9jKUm4YJvaLINPhUY=;
        b=lbyoNzCPnLHZm9HmFbWu8yFfOB1p9CR7G8Vh0B3MTs8jz+BycM5jz30U6HIt9afr+R
         i+sOF6T24XyMiZHNUk9e2eu0Dz/aqbezfqHNUbXsKgYUU1fBj6oKn5U7VJX7Xh/sllzQ
         hMb5Vl6lmPQuVShrz/EgMKsExee4As9yCpxK+Fi1W0H83MpRGCx+lH5ghc/sZklZadXp
         TTSY8EZcklKk9FrJKLGBN7i1qOLbZsIkTwZj1Q3BA1LptwKXrDLDhIzs6NaqarQ8tbzP
         ptMHENhanHJrVlGXTAJh/FGtMHPbe/jGJXhpCIo/nlrvjE1GT4GwOH8SrqJY+JvgNosK
         GCig==
X-Gm-Message-State: AOJu0YzNxkNVO9VeklpYChFO/SQUUgINDrtCXrIHGOtW2WuoL5stQTEW
	EkuKyKmFSpIc9KLFjd1iLZKNbAPaw/9xADh9vYg5kAVp7lqm+lZKI56spUXDPWP9kAMAY6+qzcd
	bFTQ=
X-Google-Smtp-Source: AGHT+IHd8XEIFiq/X1mjNShi42MIURHc0O5vrTKIj0k9QW89KUmHofv9gtp+rqicPaj/7I2wIdsJbQ==
X-Received: by 2002:a05:6a20:a12a:b0:19a:7512:6f6 with SMTP id q42-20020a056a20a12a00b0019a751206f6mr1086850pzk.91.1705886284810;
        Sun, 21 Jan 2024 17:18:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jy13-20020a17090342cd00b001d720fa139fsm4356209plb.70.2024.01.21.17.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 17:18:04 -0800 (PST)
Message-ID: <65adc24c.170a0220.42e97.be41@mx.google.com>
Date: Sun, 21 Jan 2024 17:18:04 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 5 builds: 2 failed, 3 passed, 2 errors,
 5 warnings (v6.8-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 5 builds: 2 failed, 3 passed, 2 errors, 5 warnings (=
v6.8-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.8-rc1/

Tree: kselftest
Branch: fixes
Git Describe: v6.8-rc1
Git Commit: 6613476e225e090cc9aad49be7fa504e290dd33d
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

Errors summary:

    2    include/linux/fortify-string.h:57:29: error: =E2=80=98__builtin_me=
mcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings summary:

    3    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_=
memcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]
    2    cc1: all warnings being treated as errors

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

---
For more info write to <info@kernelci.org>

