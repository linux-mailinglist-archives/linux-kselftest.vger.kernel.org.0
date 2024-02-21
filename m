Return-Path: <linux-kselftest+bounces-5137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE52A85D2BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 09:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA361C20A9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 08:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28F3C684;
	Wed, 21 Feb 2024 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Yog/LM3E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D73A1D3
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504924; cv=none; b=bVNlX9z611mpZ52ahlBGDxdWrF2my8BWLr1FygHeH7GduYo2MXRGFjwjxZ7yND7N/Jsr+IuPvSMxyurtgia7eMSKhgpSVGsYhtfGeoRgfimYkOMNoQa2FQk3GoerHzfGQQF6xr7Z0HpEogDer0GS3X8LYHrZDKajlM++XZ/gbCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504924; c=relaxed/simple;
	bh=B1K+wriIHRfG3eDdHn4JY0YiUTs6fF2I3O+MThKdG9w=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=QsjxLZJW5wFVe+x8n2cX9SthxbdKe4pZMXIXK4fqSUWi7O00TbYXIlqdxu6Z3PHWgZNL4wjWJzg9BALOLme0OdKoPrZfW6Nkk0FhcDh6A/vPa20HvNZjP/rZFsg1j4NM7AFBFZWZSHNCkyn1fxfP4W1XeTvSFc+MR8SuLERym3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Yog/LM3E; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7431e702dso62833095ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 00:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708504922; x=1709109722; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4TR10DafM+cPft4WF3B/NR5gagPkR+3hWG35Kjlwt08=;
        b=Yog/LM3E8N9CxRRQajjuW+gCcFfJg4f/GnqmeikbPdWoA5+JUweT5iMRUPKCl5a3b6
         9ZkbH4ruSgXpcO4KWlLyM0wdvNPMIMbtUfrQFFDxSuvvjgutkkg4lB/yB3C7jb0NZZPc
         liiqT/HwHN1LyNT1tNvrcDBOTC7Zw7OlM1D1zJsI7jeBoPfCh8IucksVr+z2li7nP/fh
         zYtuFZsG38f39IIgOFsZcb2r/Im1esjSEa0kunx8rdJTS4f5Prvd5V6eYKC5Y1buKoOn
         4pUBJHeoC6H4hfRkR0Ea38NjqwrViMbl9r3VdBJj5WDfNBq6Dvuk3n1anENykpGlVeeu
         HlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708504922; x=1709109722;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TR10DafM+cPft4WF3B/NR5gagPkR+3hWG35Kjlwt08=;
        b=mKhSCrxjIXVOjISGdtNPwcPzFuWzhO3dTaatlmHyQEy0yPUtUgizS3WWxqhcTiY+oG
         Lp/J8zlorW0axJdjnbU2wCNd86ZHQ56QYh9SDc3Ao0FRfZau3jdfgNnGpx3gcbN65e6K
         is53c1hh0xPvpBCWZxZBxYHIsJF1PK8nkFPd9TpfOrhh725PTDLK0yeK2jonTKYH4Esg
         V8zTJJe+w7vKBss8g/fWhESdYEK90mn1bE6WGfmbhfijjddqpaN+ZyEr5Vu1k2Pw800s
         MwqOuRNuJL4mvkAZK+y7A9FwF6fxMcVT9p4KiSupJiw2a6I/5YKkE8bvLHAc6RI1d9JU
         MHRA==
X-Forwarded-Encrypted: i=1; AJvYcCVcNqgKFx6lFKuTi+psWuCJs4bZq+0y9AEospTkaL+ejDLTEk0vvVA2f4KBowhYVXe2jPeeGcxS2+E/KjnmezVnZUom57UplGpk1lNTG+V8
X-Gm-Message-State: AOJu0YyoJe5lmsWo1wBblSPE1gz0nrqeHZvS5Etx+jAjEfsxSOACeOC8
	5cQdPHYY1367FRoVaNw7VKLgRHhODzlgLYNGtITmh44FrTLMtyaf3Y4nev4oMfwfcp7XCcH5Zgb
	gVmQ=
X-Google-Smtp-Source: AGHT+IEdIJxD5E8/wEkNrh2oNNcQ/0++yMVwPDp1J1GPtxlNtwd/7U1ijAmtTe7ZfxdZ1jawLejeuA==
X-Received: by 2002:a17:903:452:b0:1d0:b1f0:1005 with SMTP id iw18-20020a170903045200b001d0b1f01005mr14603544plb.63.1708504922127;
        Wed, 21 Feb 2024 00:42:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id mi11-20020a170902fccb00b001db608107ecsm7556052plb.167.2024.02.21.00.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 00:42:01 -0800 (PST)
Message-ID: <65d5b759.170a0220.66083.6758@mx.google.com>
Date: Wed, 21 Feb 2024 00:42:01 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-48-g6f1a214d446b2
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 5 builds: 1 failed, 4 passed, 1 error,
 5 warnings (v6.8-rc1-48-g6f1a214d446b2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 5 builds: 1 failed, 4 passed, 1 error, 5 warnings (v6=
.8-rc1-48-g6f1a214d446b2)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.8-rc1-48-g6f1a214d446b2/

Tree: kselftest
Branch: next
Git Describe: v6.8-rc1-48-g6f1a214d446b2
Git Commit: 6f1a214d446b2f2f9c8c4b96755a8f0316ba4436
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

Build Failure Detected:

x86_64:
    x86_64_defconfig+kselftest: (gcc-10) FAIL

Errors and Warnings Detected:

arm64:
    defconfig+kselftest (gcc-10): 1 warning
    defconfig+kselftest+arm64-chromebook (gcc-10): 1 warning

arm:
    multi_v7_defconfig+kselftest (gcc-10): 1 warning

x86_64:
    x86_64_defconfig+kselftest (gcc-10): 1 error, 1 warning
    x86_64_defconfig+kselftest (clang-16): 1 warning

Errors summary:

    1    include/linux/fortify-string.h:57:29: error: =E2=80=98__builtin_me=
mcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings summary:

    3    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_=
memcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x14cfd6
    1    cc1: all warnings being treated as errors

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

