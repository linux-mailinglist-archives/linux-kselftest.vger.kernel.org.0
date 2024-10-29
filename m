Return-Path: <linux-kselftest+bounces-20895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4BD9B41DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 06:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E39B21B7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 05:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B63F18B48C;
	Tue, 29 Oct 2024 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="wUsNe3WZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DE78821
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 05:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730180735; cv=none; b=mOSDGPYGzhPK096J6K6xf0wetWlCks92Q5hbPnG3xpB4lfs8UvcjNE4u/f4Y48X95p+S63pnL3Jtgeaq1cncgLo4CLWfTJwjYuGMkmLw48ELZ3Bg03vePcUDjSj6TECu9MRmxqulYQNBgUU4xDDJeGm/d4NTDikNxMG6arxrnZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730180735; c=relaxed/simple;
	bh=aKtWVdM+srap9Y5H4ip0sIsOhzCo/m9Q/jB8dDn9Xlc=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=LIDFTgAwcdJWKZsT6jos76YgR2SRb3iA4j2aIRVf4xBpwNTV1ody8v+/b8vx+M8Ti1ul22bw3Qy4BNzi53G1OtlHVmmtFlu1IGGQI5FSPPTfGx3TgQGoiB7KagtPFk83wNORyLSaD1Q+tnSUliWCF0EoTu3oqstGPaj1TCYSNRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=wUsNe3WZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20ce65c8e13so44447615ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 22:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1730180733; x=1730785533; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=imfNpfIF1WMNRMgM/oZTBLcOsLnoNOPlalG47AMsok0=;
        b=wUsNe3WZQEhdPejjRQe42GWQlskAYdPiu//IG7BEhBDTCupvFS933Wvf00JgpLshNZ
         rVZIumLWJe91niZPYsU5QndXtTtzll04fcxLtVB7amO3kSk/AiVxuICgpYa3dn0uvAYL
         UbgzPlHRIlKcfCHMOK8lD0NKNacqqFqEJ98JFaep/+dfk4Vwp1LBfFpLIJbfLKBqX5W0
         R7DxnE6xZj69UlAqBlI6+GEsDr2HvX+sE8irAtoVMg+m9oXykNcPol+Sg2y/f/CpjfKX
         8bPxWzN/O3Ue4Nx73Oeb8qLILw/9XFEkGvXLEqCuqTB5v4yH1j1xEfa6cFbHkBQdzsKG
         qHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730180733; x=1730785533;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imfNpfIF1WMNRMgM/oZTBLcOsLnoNOPlalG47AMsok0=;
        b=oHcibIKY+zzPIxulGJ1Ss4VVmdDq8hzMe7nYKs2jBOlA9s81EJ4AOBm6g7Tz3BsQcX
         s02y19wejtz7D2nLt/iT+kHu/WyPGJDKGM+ZT242UMqauKCBaZGfTkSzG8j/Ujzc5QYq
         P4W+spCtML3yqTupTc9LqrVbf7OTHgkK1eufIsCtXlNsDCjFc1Ljfd1w4SU8zKaJe9ra
         i6agpMTiDswzJEOzEWiKthWibH45LdNQfIOcgu0r2mrV1QSrPr7TPZ0RKKkJaa4Jai18
         mUe2uNXtJmr8vdEPN4DlgW+/X0U/AzmfDGIZB6HikceGUzEL9Jjw6l7Zif9mlN4QHzDD
         Rv3w==
X-Forwarded-Encrypted: i=1; AJvYcCUWSLYDOUyaBEXEscoeFAZ+YfTIPMQwve0Ot5z/EtBuWoYZ1u95zcly2Y5GiCgI8adISafiNqb34kMFU5YM40U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWz+fg7x1Q7RtnZF6HTg1pKIoUe/Ec09b37Bmz69VZ6uzW7ZJa
	xWDHZ9/lpJUodWPtZW1/ZewqXdQv2zeaDrmoeyRy6dUc5qqdrgwv/OpxyDsDL5wnYRJn3ccSEIi
	C
X-Google-Smtp-Source: AGHT+IFUqkgFE5qQRC+Ej5YYtKCEDRNVEe6Jw0je06F2KqMSFTpcHW6xxKUq7mc4moHhbJyI+TecFw==
X-Received: by 2002:a17:903:41c2:b0:20b:54cc:b34e with SMTP id d9443c01a7336-210c6cff16bmr162019525ad.51.1730180733268;
        Mon, 28 Oct 2024 22:45:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc0178a1sm59303755ad.143.2024.10.28.22.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 22:45:32 -0700 (PDT)
Message-ID: <6720767c.170a0220.83460.5552@mx.google.com>
Date: Mon, 28 Oct 2024 22:45:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux_kselftest-fixes-6.12-rc4-4-gdc1308bee1ed
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 6 builds: 2 failed, 4 passed,
 1 warning (linux_kselftest-fixes-6.12-rc4-4-gdc1308bee1ed)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 6 builds: 2 failed, 4 passed, 1 warning (linux_kself=
test-fixes-6.12-rc4-4-gdc1308bee1ed)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux_kselftest-fixes-6.12-rc4-4-gdc1308bee1ed/

Tree: kselftest
Branch: fixes
Git Describe: linux_kselftest-fixes-6.12-rc4-4-gdc1308bee1ed
Git Commit: dc1308bee1ed03b4d698d77c8bd670d399dcd04d
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

