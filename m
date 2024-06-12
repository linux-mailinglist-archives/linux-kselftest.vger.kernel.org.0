Return-Path: <linux-kselftest+bounces-11732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E137F904947
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 05:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405B2B2101E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 03:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB27F107A8;
	Wed, 12 Jun 2024 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="N9sIDDca"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA65FBF0
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161253; cv=none; b=c3cl2BjD2Bwcgu+mXHGnM+Z7ns16bFHMbs/JZ89mnXQo8UyjZtsQQfrZzuYb8PxjVJ0mJ+v1FHp03EpYXRHSEAKyuF8nT8GpHeJ7le3qkOR4vIYvhH0jKLcEku2mt9CKpPqJLw3t96Y8yDaJZ+vD1Avo/+mb3fQvKuhxi3Yukyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161253; c=relaxed/simple;
	bh=oNHldiwsmOHDuahmzVyovYxrATJ3O3hyhMoZCy2oHfE=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=iz0TWYfdQLSwdHQS4qE+DjBm2RhEScyBvmfySJRiaHusmZVaH2vFawjFIiCZ7OozRJIv3AgV5XXq7ax6b5X4p7wzqWn8/ZcR+/APxnRLrFclWWRXIji6l15IHswvzpQnxxLJgjr0GRekvQIYFkc7v0/ozyj1Wzo1pxFmLcIUDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=N9sIDDca; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f717b3f2d8so3421105ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 20:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718161251; x=1718766051; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OSbfPVQqiJpXAuHmUbX0ck1vQg5CFEr5Na4Ko70OtrA=;
        b=N9sIDDcaOevPAaTRwbOaSw854gLUktj+dczi9pY8ImSKNTtzSncOVLBCS2legzuM2v
         4JmWLuKIxuKXEUHm5NJnlirnh9mPqONb+0ho/X3/5dxKyeNWIZcMR4/JHUxBfQHBChpL
         Nklj2wcsuTB6Vkq0w4/wr5o4/H70CZskGcG2gXpwfUsV/e5CgzVmD/qP2cXnFXZHhcdQ
         DKH6oWrt+CfC0VfM75qdRr7e9OY4V18PNHgkDwYuGQhsDe6m9XjfZk9jo8j6aBmIOxXF
         ZFvjb56GG03pjR3fmKZ85Lm8btVnC6Zn+MwirvtHr+YuNyFtA4fzwtgeGxIlmKuH5vsF
         h2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718161251; x=1718766051;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSbfPVQqiJpXAuHmUbX0ck1vQg5CFEr5Na4Ko70OtrA=;
        b=Kw6f8xrcwxHkKs53fhg7Y43COfsAtVc4FxTiT7s7ffoL25ujFHeStkyPMR5QxXI1DS
         VQeZuXZ4YOnSq8QLV7bfDlvmbGSvO0LQ6igpbmSCXygFsX+lUAyj8D2VsQvb5H0CSQ6I
         txmvdCouZEyODe1ljH7znaFEwbDNR6AFpCAvsgbOjfh45SP1C69UChd2MS8hAbVgACvs
         LMKKZOQQLPUIwF7JHjvU+0Ae2F9czewFBqv8Vg/zzPKq42staHpATVfltzqGNuhZENXs
         IfMlhTLQzkk6VTihURr4BP1IrUryexYlMZ/sfGVsBxPMdeQlXl/yuhY3Pyac9CZpj7vG
         FMGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbrpvKaAgWZWjIHGHDp5rktHnzkLdqg8vei5EJRWBEkpQzZVuLqVisIW0ynDADLDzxte81rHC+KygQ6+DbdMZmPFrNkszI3ULTS1S5TbvM
X-Gm-Message-State: AOJu0Yw76z+TTHhjoZGE7KgaHrOi4UnElJxwY9RUtUAOImMjk3PyYjsI
	xU51VqUHfmYOEuUhkyKeVyNoaHp2CeaIbi76B6Ws3Ep3rKKqJdHleLMYhA58u+m40/SS00KuyH9
	FmV0=
X-Google-Smtp-Source: AGHT+IEXZas24NHmDoXPjjpqHIDM05fOlZDeTR3jr0QE6DCe9tvGJZbYRgk2ZIWrSwUqEN+V1xTseQ==
X-Received: by 2002:a17:902:cf0e:b0:1f4:adcb:37c9 with SMTP id d9443c01a7336-1f72892f9d3mr67402835ad.25.1718161250787;
        Tue, 11 Jun 2024 20:00:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f70acdf14dsm54182575ad.113.2024.06.11.20.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:00:50 -0700 (PDT)
Message-ID: <66690f62.170a0220.fc1f8.0de8@mx.google.com>
Date: Tue, 11 Jun 2024 20:00:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: linux_kselftest-fixes-6.10-rc3-4-ged3994ac847e
X-Kernelci-Report-Type: build
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 5 builds: 0 failed, 5 passed,
 1 warning (linux_kselftest-fixes-6.10-rc3-4-ged3994ac847e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 5 builds: 0 failed, 5 passed, 1 warning (linux_kself=
test-fixes-6.10-rc3-4-ged3994ac847e)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux_kselftest-fixes-6.10-rc3-4-ged3994ac847e/

Tree: kselftest
Branch: fixes
Git Describe: linux_kselftest-fixes-6.10-rc3-4-ged3994ac847e
Git Commit: ed3994ac847e0d6605f248e7f6776b1d4f445f4b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

Warnings Detected:

arm64:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x14cf94

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig+kselftest (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14cf94

---
For more info write to <info@kernelci.org>

