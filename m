Return-Path: <linux-kselftest+bounces-7235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B2D89928B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 02:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BD41C21582
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 00:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47236393;
	Fri,  5 Apr 2024 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="b220KqW2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92423160
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 00:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712276353; cv=none; b=ScU6SfUw3PSF1yyMgeTKOXb80b33re12Ukv6ZJ7WGmEdMP14ndXVEvphkLTf5sOOnOh93XTImiP+ZfBEmHdIKskA7mpZOO27AaWDdXc8P9HgvShAp3XmKYgi+aCT7UJwtMHCW7meRSN8E5thJAoMPQ6ZDszEfYsgpKgY2xTkoZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712276353; c=relaxed/simple;
	bh=JrRWuZwuXzAxc47vjMNZOB5u0vuPt42JnaeFouZqnN0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=MXml/alszYaeJWGX2XKiqdMECCHC/lSWtJpg9rDvvQR6wMTTzqsuqBJ275axuh7wVyLLxPSY6WAoCVIRzl4X5evU5S5JV/naEEbXjN09VmFtPxQm/FAk9xUSYrIYLJP3asMC2JmDNBiCI/jizgtK25k1ilFDDQAdjxOeQuuHBtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=b220KqW2; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-222c0572eedso875917fac.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 17:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712276350; x=1712881150; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sA88ETRYilkEachwGcLU4lWGVKtzut8HrKVxn0W9Isc=;
        b=b220KqW2Rld+kWh23DdZoJlejcKKsqt4SEeOWu12CC9CsdbXviyZagPvj8rV7hijzj
         k2eK003DQVMNx9jINfF5aWVYnDV47+NtOPyv8qwz1xcuqTnqP72sYjqLPwjw3rvKxyc+
         QmF+hNlRc/89+LkpRtNOm94i6bjdvsKbt3bS8iRPygEENSLchEC/CMrtTTESAE5War1C
         VW9j5dfkjEOHRtEBiGnDKgwPUfwgLN8VSkJKjw+X1zYtxplB0z/2QbYhX/u1+uffaHBe
         XQ9bovLC+77ePvTxMoTOJ8uTilIqXWhlzAiY47Przc/2wYJpkeWuP6h5IKka9SGPFV+G
         I8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712276350; x=1712881150;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sA88ETRYilkEachwGcLU4lWGVKtzut8HrKVxn0W9Isc=;
        b=jHLr2Th3sRCxdpPZHWk9/QKua6hjKRgYUzEYnoSjUmhMmpU/zXCgagBJLwxNpBE6P9
         6Ayc2DB/cfWRTeADBhl8KivatK0NgDE7WJ/dgp586CgauK7PfJX75qf+0bcyNEPL6XwJ
         kFfBPAV//dUoSWfBbrwaJv0ZrNi7l8vt4kyAJ7Y24GRjNfdNpSVI07glcFCYmZk5wIqR
         s5UGhFqhM89+nLox7UPuyS8ek98OaosQgzGcip9tOvu4iDyZhiPVkmwQLRuMBb3rRqsS
         iWFN4X6J+3rU/DVFX5F9nG2rdZKlvnzIgjWgPC+aSAaiStegcALCgSyL1stkcc35qSmX
         szPg==
X-Forwarded-Encrypted: i=1; AJvYcCXd8LblmzIN6f4K5gbzIbWMNm0FAl9Se6VbuEylaYpnA68U3jaCNso9VvzQgP+UA/Hy94sG4hGn9ZMPvMJq0EQ0VSTd2vHdPH38FrocD5Cj
X-Gm-Message-State: AOJu0Yw/PmwZd4iViG6DoWeq6TLXo02tqgpu2UFaWbj/Q2mcPvKmVddy
	petOtM6+lUhPOI1aLCTnjvL5gBW7Q16l0hLqeprxVoUwX1H7r8WrlV4U6ABgf6nNdG/57WaOu44
	k3BM=
X-Google-Smtp-Source: AGHT+IF5uXvCqnZHlijGDXdZJjOIRr3ETcK5qNARi1pDR7uGC6f1AmEPYn24VF1WQogN67bXC5HLMg==
X-Received: by 2002:a05:6870:238e:b0:22e:c787:5fa2 with SMTP id e14-20020a056870238e00b0022ec7875fa2mr2685oap.58.1712276350578;
        Thu, 04 Apr 2024 17:19:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d6-20020a63fd06000000b005dc4806ad7dsm260832pgh.40.2024.04.04.17.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 17:19:10 -0700 (PDT)
Message-ID: <660f437e.630a0220.334c7.15c5@mx.google.com>
Date: Thu, 04 Apr 2024 17:19:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.9-rc2-14-g4389636db356
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 5 builds: 0 failed, 5 passed,
 1 warning (v6.9-rc2-14-g4389636db356)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 5 builds: 0 failed, 5 passed, 1 warning (v6.9-rc2-14-=
g4389636db356)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.9-rc2-14-g4389636db356/

Tree: kselftest
Branch: next
Git Describe: v6.9-rc2-14-g4389636db356
Git Commit: 4389636db35667bb5d59422bfdfb3c876c3654c8
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x149ce9

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
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x149ce9

---
For more info write to <info@kernelci.org>

