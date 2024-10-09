Return-Path: <linux-kselftest+bounces-19308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85845995C15
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 02:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D560FB239CC
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 00:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648FD36D;
	Wed,  9 Oct 2024 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="kAk9mBqK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC15ECC
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Oct 2024 00:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728432495; cv=none; b=dM3mz9sWuPlTJe9164uqBS6OdHEOimR9OR61uWnI/DQ3Ro9qVe0sNPSmMkPy7i8NfFvfs3f/zDxcKNMI7DTAJuoGFoerysxpenHd8NiRR/AdEYEZJ/JYBwnxBE4mv/PZ5bTnVf4u86TOAJWeb8aiHmVZUieSfWrTIe6egnVoysI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728432495; c=relaxed/simple;
	bh=4gMa4YdTQ2GZEqzNfUumKazSTrUcGzr98BlvPsqR2ZY=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=YnAS0x/3nwHHKkuuoZObzMBM9sF2PjAo5yQ7nTHatTApSoJlpSEr8j9EVF4jzZuge+Rb6UKVok3phWqiWTMRDQgDYPc4tfAP9/6MnzSE0sHYW+WyaztqRe13HweWtT3rYAWPnxOAhLbZABzWWULoEWdHM92Xkle41rNEFqYOzu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=kAk9mBqK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71df8585a42so2748124b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 17:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728432492; x=1729037292; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRkKHYg1w8dRcz1bpoeTtBpsIkj1UB56wx4Gw7KbGM8=;
        b=kAk9mBqKm7wPq/khV4gx/CObXNZW2LSl8UKxLtkfZnJcP4EkgoIy4u141OhCo29mGu
         Ac3SWn1fz+8k157Jf6S+YJel7RhQiv7EulhPZghR8rIrZ+slt2YCQLk+MQr5ErBTb+js
         huE5PRX3W/CNpjLKKU3amRjfM9p3QEQ3Cam5JMGuN/C/8OnPsKnlpqwSTRdRIFSOpr4Z
         DCmGg3SOuUdUUp/rbdIbmRk0KQHDgS93Xpbh5+qfcBMTtN9KvuCe3stnbrLmcI1B4jeI
         9g2PQoOxJdCrs7RKNqBn+wRsYTnN1hZv15Cen7RyNWtSZo2OHTE/4Humq6osLktBfjSf
         fDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728432492; x=1729037292;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRkKHYg1w8dRcz1bpoeTtBpsIkj1UB56wx4Gw7KbGM8=;
        b=j+LnY1JU5CwqymWDrt6jz+vVHIolb+KZc7FD8/RSh+gbF0k23C095RTcSKg8zXu0CE
         I8RSJP8ZHuwoldDkdHD8AgqAaTCPsob0BtCPp8qb0HtBNPttmDIP5+sOYGrpxE2NMpu0
         OnMupSLPjzYHyj1RNn2u9VumfPkICmZQipZ+y1gWAQ9ataKKTZsUOk/hpUHCaRJzPgrx
         CvJjmde+eEwYik7H1jL/Sr4FfLXJSJwggpYhOZhSV0JG7WY011dIQ9hc1B4kM69MbaEt
         8xY19eKoy3XJoAkOIaywaXdn3nv6T/5bMMZDORnhuQzdBJOrPwgub/NqcAjINE7Kt0D/
         CxZA==
X-Forwarded-Encrypted: i=1; AJvYcCWFbG2bSzm92l1D7UF7gQmGjWtOAuMzvp14DzpSmBYXh9ad8K2T/WIq5chghvVqzywcqYGQ4s9ivi/H+EQ0Ms0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE44tQVzS8LqgHPFHhvpL+n6xiuSBw5i9Yp4rB3Nbu7MYsO0gr
	MzQ32qpIM/mQFwADoFu4KbkZZEhB82FPqbmvDCDIs3zN60rC3AA4q68e9fUwKZaGLAyyGRl3cN6
	c
X-Google-Smtp-Source: AGHT+IFZHLicWOFnK1HNLxZz1cc0IeZfdMXOUYrhxbYU7ciDdAIZS8vjUo9beFPCHN1uZGwAEjwOsg==
X-Received: by 2002:a05:6a21:9101:b0:1cf:499c:f918 with SMTP id adf61e73a8af0-1d8a3c0dbc7mr972561637.18.1728432492666;
        Tue, 08 Oct 2024 17:08:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7ce21sm6673920b3a.186.2024.10.08.17.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:08:12 -0700 (PDT)
Message-ID: <6705c96c.620a0220.2b564e.8b5a@mx.google.com>
Date: Tue, 08 Oct 2024 17:08:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 7 builds: 2 failed, 5 passed,
 1 warning (linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 7 builds: 2 failed, 5 passed, 1 warning (linux_kself=
test-fixes-6.12-rc2-4-g34d5b600172b)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b/

Tree: kselftest
Branch: fixes
Git Describe: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b
Git Commit: 34d5b600172b846161e507bdce132c98d9cc9701
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

