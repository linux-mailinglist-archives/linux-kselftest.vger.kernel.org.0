Return-Path: <linux-kselftest+bounces-18805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E75D98C500
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 20:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5065B24A46
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AE91CC157;
	Tue,  1 Oct 2024 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="bEhsBaKX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF00321D
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805747; cv=none; b=IUHz7O0Xd+mpohMRGqEl3+3nyZrb70XckGgaeinbYtTCoFeMzykKcdD0jk8Xbg8FIQ2kUSc4o1FK+z09CAdDTNMbiWFZ/B4bLAWmKMLOiikiCup6iiSO8qWuueo/zUonix10k6mz+xdbGq9BEMJYo6C7wkll9+xxrvtraMnyu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805747; c=relaxed/simple;
	bh=9toUEv/zx/lZnA0kSvke/yBL0oDmYq8aYhEMoPO6O0U=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=X/3u0sGT5aU9xcvHXVbNNRq2r2bJOaXyNeoNA8Ke9QMq7jJ76odKqp8j71RTir9zzV6YPRa4Jg/PAmKbLgKvPK30fgEBukG1Bk6i2ScRoD+XssSG21vOCaAvWAd+dWhyzdCRuk0JmBVwtF3ZYPW6K8n+bfVWJyc9fcfO4xIQ+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=bEhsBaKX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20bb92346caso573475ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1727805744; x=1728410544; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UC9MUT/zdk+L6t4HyUuwp/eXUdEd256oOuJKYjtURbA=;
        b=bEhsBaKX14ytLE2womAq8gMBompOo0v760ypgyMqTtEA522J8Hd57H8aVL7Chj8Isx
         1wB2V+8gN5RB9UU+WgWjv0ZdKqQGsHQpHCN05f8ZxjW3e+MFzDxg5vALmLAY0eiPTfCo
         X9pw4JrqFGgv8pG5ah5y1UOKRdixDRmNbvCX+Y8pDwnDFaEPVcob4a/NlvBlJqDe4n5u
         87z02tZ8wL8pUlpikKDyXFz3I7WtCXyUUQM3kCalxEP0ZXbEu0XwCalD1ngVGxmBY03h
         nZY82xIkRKmB1gId6VWA8uP2pBd7wt70MCTQenVjcSClwOYT1xXpTr49u2d9y0mLHtSg
         m7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727805744; x=1728410544;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UC9MUT/zdk+L6t4HyUuwp/eXUdEd256oOuJKYjtURbA=;
        b=S75f6NuaGWFyKc6sbn6mBA6pTQD4gdNWiQEyGBReq8a0iIV+IcCKzQ6y3fDls3iAhg
         8aaEP7pJWJWyxF7hGGTK6cyh3tEJJiyvShFFhOiANaYQ3lkVBPVn3Yf3yTH/8+jF9weP
         wUqjmOCtD15UcnGnNKH3d3MPf9spxYEPBXMcIatlF0gU0Hk9MVmck7SHqjOi0D08zTk9
         7lMYk0oWgg2Y7x26scWu5PZXoFGO7UDx52M3wILvth6VqeuXq3QMv1bVYjTaJH4hgaq7
         Oz31lIAEkQ6XHuaJ6T/w7yDl+C5QotMPNnFYtv+/SImIAu+2h1Scaep8+24M4uMc8ocs
         tYtA==
X-Forwarded-Encrypted: i=1; AJvYcCVPBxPsmzjsFx9H6HP40QgmXzk4PVw3QcPyHG9XzkW4BtiglEnbDMHovaROrQ/ScD57gqWJg/AcZ0u3wCCZyDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCXcgMmNuIBnhA5xrAkwqpsFvSbltLlWeb4IM71/j6b/MYuMtx
	KFYTrgc4QS/WTWU7VaFG0fN7lnZe6gwe+yOCW7MGPAZgSK3KV6IP1I7HIX0RCDc=
X-Google-Smtp-Source: AGHT+IEdFQIZSReIaYOCFgagGShMaQDY1fIhc6j2XKFDh3odKXlaLugCcSDqEZi0G1wbqAf9yYGymw==
X-Received: by 2002:a17:903:22d2:b0:20b:a9b2:b558 with SMTP id d9443c01a7336-20ba9f39ca4mr70384735ad.28.1727805744362;
        Tue, 01 Oct 2024 11:02:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e5a371sm72177955ad.262.2024.10.01.11.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:02:24 -0700 (PDT)
Message-ID: <66fc3930.170a0220.117f66.e192@mx.google.com>
Date: Tue, 01 Oct 2024 11:02:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.12-rc1-7-g160c826b4dd0d
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 6 builds: 2 failed, 4 passed,
 1 warning (v6.12-rc1-7-g160c826b4dd0d)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 6 builds: 2 failed, 4 passed, 1 warning (v6.12-rc1-7=
-g160c826b4dd0d)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.12-rc1-7-g160c826b4dd0d/

Tree: kselftest
Branch: fixes
Git Describe: v6.12-rc1-7-g160c826b4dd0d
Git Commit: 160c826b4dd0d570f0f51cf002cb49bda807e9f5
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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x14fd19

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-12) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

