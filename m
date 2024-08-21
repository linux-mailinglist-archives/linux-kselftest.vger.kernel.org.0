Return-Path: <linux-kselftest+bounces-15845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 370039599C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 13:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B7D1F2402B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 11:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7811C192D89;
	Wed, 21 Aug 2024 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="HgIcbsg8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B644436E
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724235766; cv=none; b=O3yJyokig1Gs2xepsH9IRwRNkLP7pl2nhiacTbFD4wNo2oLzATqFZx9qXL2FG+nfXAYFr1F9wMVG2DUcjR/RuX/oLbLugtCnjVTj3sePojC0BQrbbZwJoXsT+Fpx6BNrMBDW3gldJyPkgYsxEmLMPL5gHq/y8Gysr2CHw/Elv/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724235766; c=relaxed/simple;
	bh=leQryR9DVLQz19iBvuwjMzT15oXyE2vwtvt/S3r0of4=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=H+dUysUu/UaXrij/EeVnqTYgfg/BlMyeZ8iTP6+MMoZQhEyg9mmIl9TH1bOzSzltMpqeCNy5EvA6WEPMQLh9RnrEJD/4hUUH/ltwTowklzzaqR0lIV3bWrIbxdcodJuaJ9JzCtxnvJiD3ENGmYWr2+Boqjk8Yh0iBlfJsUc+eaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=HgIcbsg8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-714262f1bb4so360526b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 03:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1724235764; x=1724840564; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=svxc4/WdJyAWI0HJevx5XtzygRqowJlH675kDCaCv3k=;
        b=HgIcbsg8/Z18o0jA1bWsFQknO5Nh3dprMqeSgjm4iY15ZLgOFZDpmvDYLl4NcPYCen
         cDcevUhuKy7NvUW4gjSol2MrL6MNy5Atu/78ngZkG336z75bnHjw7stP9vcHyCVybhZU
         pZ8CGeodFEqt5PXMe7V71A1zAn8CHKcqAyQObYD5tReFbkpyKsaPQBapllC27b6lvxDY
         SUz3WKpZbbSQJYeYRBR4RGcf8rx+5BAao/6QLXidh+7rJSuOQbwuDzOO3KdA1nfHFEaY
         cAmLO4vIEiWx/E9QW1gWyurp09JJgsBb5fZa2klPP8+oAuWaeAZB1aIeYEA2B3q7NsYE
         9rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724235764; x=1724840564;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svxc4/WdJyAWI0HJevx5XtzygRqowJlH675kDCaCv3k=;
        b=JknILbsXR+iYT3ZrPcb+FoT5HbbeW6GAYoLQ2ja54rVwQxpbmG0zLAZmP6+jzDWYyx
         5I6wbPCk8gSw3vDxEMPE92z5UFIR9zIfJJ62mRcKQRDHkgyHaJ9LLG6sCFlR60yiwDNZ
         OMNX8TPKBtFM5twpU31+kqAXYW9XhkoqCVyqmHtqo8LRr++int6o2gcKyf+d1wNfVOCA
         Jzol+WXPcBlpAVgicWV1C8TmwQZNNvZPoTbhwWa0oVP5zvOUt++3ssN10zVBM2CLu9P3
         MMaP0tvnHNV5BM/YknTtohbv1qiXWYeTpbrJUq99gb0cmyNrL+9L5QJBPWwSR2SeycQf
         ydGg==
X-Forwarded-Encrypted: i=1; AJvYcCUBtVR0q2DLLTHWQ+mDBaC+aE9aCjod5eq75NwMkncaUJKvZdyQm9QWQvCsZfmXdUyx8X0KpMaMw6YRC+aTSRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYHGGOZZ4hQLdAyMBeQ8FyCoEvNeCzFtLKApnZmdT+n1yFktAz
	X0o9XmfXGrV3iES5x8CvZD9OIhIsvys/tauLORec2zccXBNVHaNWMG/1Lv+opT8=
X-Google-Smtp-Source: AGHT+IH2NkjSHzlMe+zrwUwfUKwZORbXsQxnnRp1Fvd3pQ+ZlW7ypnLQ6NAAXqdsP0qArhdvaH9Ynw==
X-Received: by 2002:a05:6a21:1304:b0:1c0:f33e:aaec with SMTP id adf61e73a8af0-1cad83a21a1mr2073003637.49.1724235763866;
        Wed, 21 Aug 2024 03:22:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eba2e44bsm1393685a91.13.2024.08.21.03.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 03:22:43 -0700 (PDT)
Message-ID: <66c5bff3.170a0220.13831.3376@mx.google.com>
Date: Wed, 21 Aug 2024 03:22:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.11-rc1-15-gc049acee3c71c
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 7 builds: 2 failed, 5 passed,
 1 warning (v6.11-rc1-15-gc049acee3c71c)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 7 builds: 2 failed, 5 passed, 1 warning (v6.11-rc1-15=
-gc049acee3c71c)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.11-rc1-15-gc049acee3c71c/

Tree: kselftest
Branch: next
Git Describe: v6.11-rc1-15-gc049acee3c71c
Git Commit: c049acee3c71cfc26c739f82617a84e13e471a45
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

