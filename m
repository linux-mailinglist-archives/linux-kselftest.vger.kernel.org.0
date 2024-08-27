Return-Path: <linux-kselftest+bounces-16396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A304E960AC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 14:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F586283522
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 12:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2D51A08B1;
	Tue, 27 Aug 2024 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="bsUrzyGR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9267B19885D
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762756; cv=none; b=ndh4a6iBf8kQicMJJKRTmybcuCbsRWA3BaefqlQ62VxfntwYyEHF+RlwUuxwNMVFcbOJ9f6EX/bDTNNjy0Bk3wiy/zACItbR4dT/dpO8FwE08UwB/UG2PxOFuEBSCn66JgU39+lFpDYOHqC8sTOdh0QvsennsxndXaG2xSkzgrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762756; c=relaxed/simple;
	bh=gHJy8niD+15uydrEsW++9QTEb54teXzWogocZXQziDA=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Y2J57vnbmtWt4h17BCtgGdFKWXZp7FQcoymS0Lxr/W9yQcQxiLZoa2cxHlEcCsDj6Z1/quyN1vW7fonRPwTazWTGmn3jVub82ruRXw91g7O4efkH0sGhmdQP68JAEmRZfDjZl18QFfrzOG4j4ExtyjFZuKW96xm8Be9lBHUNLwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=bsUrzyGR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-714226888dfso4893088b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1724762754; x=1725367554; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4420WHiXmQMDBNmaQKHT6PHntNCuBNR8NnFUwTlTthA=;
        b=bsUrzyGRjwhpV9SlIwmUXe2DbCH0kmxSEqB2tzNZ6aMtBxwkTFmuRVd2sbZirSEp7U
         CaZhAQcW9QVsxERjjdG/70caMVMGOCt0Co31ObBxRP8Ao4GOwyh1ygy3X2kpq1vgkgXZ
         gCT9bacuui2YkhmkbGOYvP9cd6dtdJMcQTJKF81OPi2YYaHtExszEBYAk4cKnKTl8AbL
         vSpMsc2qrm0EmZnDcXqsR1Rg+ldFCSWuL41Yfyyp90wCHxnQNjp/HlvJEoBXLeS9UYyM
         R6VoWnnzcKKvdtzupftXMvJ+1KudmjmsO5GHweUMDlnYACtiR75dV8k0pkWEVNToCttn
         eMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724762754; x=1725367554;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4420WHiXmQMDBNmaQKHT6PHntNCuBNR8NnFUwTlTthA=;
        b=i2W9kNhBjmMkXuRl2eH6h+9QB3XtoBwzP/Bt/zs/YNuIw9YvEGp4nChQuDKhtH2+JP
         e26pTYBZNr19u5YZNoxMDejm9oqeTqz7DrRe78L/5ZxzgQ+20K7pP7LnRuRM2wJ2GflD
         pxR0XvXHLGm/PeJvUO/rjcviCFsDzyRk90S84iA66/5RrcT/90t66TnPGh6I2RGw/L5/
         UD+TMVVEF4ifSmaMt5rL+aVSWs6KHt2n202znAJNeI/tQbQXrH5tyH4cjGp0GexUubd5
         acHR5MUdXuxIC8zyTwwhLIEVbDpbHk5QYPKjAv2akIs0ho5JFmwxH/n7/e+BHMvIe21G
         Vp2g==
X-Forwarded-Encrypted: i=1; AJvYcCX20O8AuOqe/lXCU6G5rTUYJWMmGFIi4hXH4KxwIyPx/FYHQLH9Zk8Jbd8ax5gm/57SZzLL4rLfbevOfVP2yjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0eaH6L8P9DW+e9wsy6mrJi4KWv7qThpqlUAtkxK8qbBbVNuQ+
	SR3w0uVfM7F483R1MpmaQFsfJNMUZJqbKFn/PVUkHYwzGeVg6KbBEr2GsSXVdew2pw1V2iIYjoe
	qFBE=
X-Google-Smtp-Source: AGHT+IFXAXzFazNUplQg7rrDNZbtxOcjfWqT951aaqbmfYjfs1JDGyspdpDHgIN8j/XDiImJprqDXg==
X-Received: by 2002:a05:6a20:d526:b0:1c4:9166:ae3c with SMTP id adf61e73a8af0-1cc89d6ba69mr14200390637.14.1724762753472;
        Tue, 27 Aug 2024 05:45:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434230696sm8812037b3a.10.2024.08.27.05.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:45:52 -0700 (PDT)
Message-ID: <66cdca80.050a0220.2968ec.1455@mx.google.com>
Date: Tue, 27 Aug 2024 05:45:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.11-rc1-16-g611fbeb44a777
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 7 builds: 2 failed, 5 passed,
 1 warning (v6.11-rc1-16-g611fbeb44a777)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 7 builds: 2 failed, 5 passed, 1 warning (v6.11-rc1-16=
-g611fbeb44a777)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.11-rc1-16-g611fbeb44a777/

Tree: kselftest
Branch: next
Git Describe: v6.11-rc1-16-g611fbeb44a777
Git Commit: 611fbeb44a777e5ab54ab3127ec85f72147911d8
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

