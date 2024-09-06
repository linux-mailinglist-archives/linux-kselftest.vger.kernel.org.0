Return-Path: <linux-kselftest+bounces-17428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A55196FDC1
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 00:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E37D1F21C80
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 22:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4909158A00;
	Fri,  6 Sep 2024 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="tMpc9qY4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E904F14C5B3
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725660089; cv=none; b=OIR+cSJdLGrASbG4kdrMS8AVNpyO+OLnBam8rHDTVdSraghvOsbTib2pLLFUwCxht6qNjiHehYzKTPQv4DYOEGNOSw3WfIyW4XiBSg5JIBaT4TpSyrlqw2Gv/3B4PgTooWBcaItzGq+WoJKkvZ70mDN8uNRtgI3FwgQl3ef6iRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725660089; c=relaxed/simple;
	bh=8P4MN5n6VIBR3ieG3HYR4aH1WGlHkSX+/iWDR4rkt4E=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=dH9pd9BL/9AI90fhUWDYv5bRNldFIm8ZZnf1G5SEqPTqVc6L2sAH6VZ2uCt8VxpYMV65a+QZ+66AZyrJN+B1EAEAOC3V1RuewfMgCvCPw4J9R6fCXSCELgV/sj/HuwTBIRKf/Pgt3pSD3+kPaBMfA9Dz7W+E5+3EB4ylgYHHr6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=tMpc9qY4; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so1807989b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 15:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1725660087; x=1726264887; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3OHWmCJWbvQmW0fDPN4U9BiUAayDHbDFXMi6ItY/DYQ=;
        b=tMpc9qY4MbIvvh7JlRqab9kUzQq2tYO4Plf+MwUtAQmbSaI6FmT0ecJIFa0/x3EB6m
         Pd7gL9LajwNlcoqogGqqydIdLT3NQxRZtGSTIxaVrvDkGOlTXjfSnKQzRml7y8JvlQ50
         YuC1yfQ9PqYu99WeRldEUSrZAg4W+KT4m/VYbCU4MexVsVppZeALciMGqF1V4c5iAUKY
         foCVadzyqqgqDrjG353PEmjnaoxzP+BWx0Hn03IixC3rZz0hX3ebPaohQalNzB5QoQXF
         v7v53vlIrPzVDeyL1cF7QUAdW3nGJouyilXKAkRsF0EWzX5a4eXoRU4c4LnOG4EknnFv
         V5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725660087; x=1726264887;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OHWmCJWbvQmW0fDPN4U9BiUAayDHbDFXMi6ItY/DYQ=;
        b=GPzKDqPLunTBvPMNQtpoO1f6tcz5uamOQ2hy81JCwTeUBHSS3nfJvXNJ2ZpF1XW6FF
         PEm7/CjNukU8WLTtMaOx/A0GE/s3gTU9YvEpAACEjpwZEAs2PXL4K/iK7akBnT/msPft
         GStuSaLJtKB2WxBehs1E5PfEg6eXDUVPqYhg/90Qnr0lpVMyz/HQIpfwdZQe+R+BnWVS
         c81fuAD3u1XIToezVOxIAUyeu5ZqWMHq1wWEMsePH4TBSvnemG+PG8x6RksQ7+CanbNk
         EFdCuVzOp7B550IsWj4tCnOn3qk165qfZbc7AASkIKTMNHvucDfqGoyZKr8x2SpovucO
         2Bqg==
X-Forwarded-Encrypted: i=1; AJvYcCUJFEkiotcx5bmgIjOSq++qV0RcJHyRYt5PBg+m2etk8qT4VC6SdZZlGC4Wn9lVb31kz/BHlzoMSBOPiGmlpyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/TUS1JSm6MMdZ1EUj9rk52wmcQl+UWa3RLIipuI39SWvWwxi
	D7IX12xKD2Dq9T+AjC85ke6gL/zg7JAYeBJsUJRDqF4r272VJ8Lhu7CYUZN7lBg=
X-Google-Smtp-Source: AGHT+IEK9NZbB7PSouK6SQX0M4Ep0Bh+SF3nA04lu/rupJF/MUNC1v1w3wBXkTl0+9gKlGFlayjoRg==
X-Received: by 2002:a05:6a21:6802:b0:1c4:23f0:9665 with SMTP id adf61e73a8af0-1cf2a0b7dbfmr780306637.29.1725660086840;
        Fri, 06 Sep 2024 15:01:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d5a53d959bsm1878708a12.87.2024.09.06.15.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 15:01:26 -0700 (PDT)
Message-ID: <66db7bb6.050a0220.2880c8.ac91@mx.google.com>
Date: Fri, 06 Sep 2024 15:01:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.11-rc1-20-gaf1ec38c6ccc3
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 7 builds: 2 failed, 5 passed,
 1 warning (v6.11-rc1-20-gaf1ec38c6ccc3)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 7 builds: 2 failed, 5 passed, 1 warning (v6.11-rc1-20=
-gaf1ec38c6ccc3)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.11-rc1-20-gaf1ec38c6ccc3/

Tree: kselftest
Branch: next
Git Describe: v6.11-rc1-20-gaf1ec38c6ccc3
Git Commit: af1ec38c6ccc31ec963ac4bcf8f6a7d8f44d210a
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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14ef94

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-12) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

