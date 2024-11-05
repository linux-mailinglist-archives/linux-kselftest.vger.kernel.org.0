Return-Path: <linux-kselftest+bounces-21428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BCB9BC266
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 02:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D5C1C21924
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 01:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0A72905;
	Tue,  5 Nov 2024 01:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Ogj4yu7O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C19168BD
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 01:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730769508; cv=none; b=Ku1LSIwr4NB9RAPl1qnUu4vUNeBFBUM3ndyrEybvjuBTPaHfRl9tg2ToWE+gtKprzDcu4lui/E7mx4SEh5kx0JPeAAXZMKPaErW1CHgKyU76yYV71+Xm5Cpvm0V4GZUyhCd67XkF69wMh3x24MyOYHzUwa70OZW1mPjGSZI2rjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730769508; c=relaxed/simple;
	bh=vFCWdyE4vGnR69NnwRg9t0gVXcQKjs8Id9ayJxxh8lU=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=HbWPftsDUVKjlNs6iEC4R6wdbNDV3vAstmc/6Ya1/kbuLpmnRyk3jc0bwRuT+RYTPsFkuuaEjPocivMmC4eZBRm0qjDkkYMGhLb0coRk3ru46tNfDy7Nb3U3+kbCGYgWus+VJc5Mds75RnWgUyktv6ehxCf5kdDuZSKP7qEbA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Ogj4yu7O; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3180127a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 17:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1730769506; x=1731374306; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fTPrQ0ErOynKDudKZbBY5ojl2qNQhBcyTYNqR9rqHlY=;
        b=Ogj4yu7OuJrufrxYXMVaZ7cTbWhZE4x9kVwTKL9ya6/m9y3HnW8q5Yk+JknYUrVhk8
         bgR8qjsnX6mNEvYwkglZzammwrC4c9LlAGXyl77gau1TvK/EpBGUpfy0KFNrB+NH5su+
         IkGteTnaHZYa7PYTNu4fCXCeKmAHMrHXsYwlokClyeaJ+wjJ5Ph5C9KohMkrp3lyofxI
         cG1Eje101hyODvc+qVh+NjIUuOLjL9NTfAfBoF5uqgzTD24sOcvHbgaK78idMj7ZpdTV
         DVd+ix0/YQIgBz5MYMpHqhs2qhQlmC7gerVGM1RJacIdQ0jLKNQntI/OMQCoSMLODp8p
         ALLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730769506; x=1731374306;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTPrQ0ErOynKDudKZbBY5ojl2qNQhBcyTYNqR9rqHlY=;
        b=gCzR2Pwi9xRAjHN3s32yZxLlbYYo+dZAGcWMizhouRiig9mHV2COBXHw318ODT52HQ
         qaPQriHubg79uI8q5qhtJxWMiXrB0nY21zcvOmc5zdgLVLHgYELqpCDk0Ee2KHYV6tBU
         niMIYV3DvJAxjlOLzbPZW6mircTwXWQ4Tich1uIQ/V4KUnAf9VwR8PvMDkhNT43fhyYy
         z1oouqe3xVVeZSFYT7GxYZcgm5rcQxW9KjxMAMh3u9n38sDZX0mz0iYtrBWS4G5JFkTw
         VCMvOZw7ttALMk0u1sAYyU5NxloSHuQ1wCG8BiqeIDbubeGojQVHNe2DAsliM3yUCmur
         N2gg==
X-Forwarded-Encrypted: i=1; AJvYcCVIWSsVssDeykHXzlADHsY5PnDA6r7JGbYR9CBGQYKT6jdy1s53lWIJcvfpGbpv1Xk8Lzp5lZzd4no3/w/eoFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7oAfjPrKW/0SIGSxD7HRiXCYeCecYqw8oAcUqlAT1br1ykGHY
	PnMIMWp9fuQSrEjWBfRzIJgYkY4MP/h0qgeIVRt3BfDOlyeT3LVtVBwUHYh4ZxWyLaezez5W635
	H
X-Google-Smtp-Source: AGHT+IEFXTkobD9nOWkmtR+lIGtT0c1kn1QFpgZ2Kh68X9CgzEJfi6kHDyAbIQEL5YanqZJfwYLQkA==
X-Received: by 2002:a05:6a20:12ce:b0:1db:e3c7:9975 with SMTP id adf61e73a8af0-1dbe3c79a8amr5499825637.15.1730769506376;
        Mon, 04 Nov 2024 17:18:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc313e0csm8317620b3a.189.2024.11.04.17.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 17:18:26 -0800 (PST)
Message-ID: <67297262.050a0220.1de185.4ec4@mx.google.com>
Date: Mon, 04 Nov 2024 17:18:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.12-rc3-23-ga44c26d7fa74
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 6 builds: 2 failed, 4 passed,
 1 warning (v6.12-rc3-23-ga44c26d7fa74)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 6 builds: 2 failed, 4 passed, 1 warning (v6.12-rc3-23=
-ga44c26d7fa74)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.12-rc3-23-ga44c26d7fa74/

Tree: kselftest
Branch: next
Git Describe: v6.12-rc3-23-ga44c26d7fa74
Git Commit: a44c26d7fa74a5f4d2795a5c55a2d6ec1ebf1e38
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

