Return-Path: <linux-kselftest+bounces-3285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F377783591A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 02:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0DA1C21509
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 01:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C3336B;
	Mon, 22 Jan 2024 01:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="BAN+QFEs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDAA23A8
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705886273; cv=none; b=CwSRDAGEfLJLap/QiFNcOcyJri0TGIAP5XSjJMx2/lBRUOZPZ4QH9XJYk7JtIfE2cxna2HBdnEPFv/LGC2oWMgyy/E7vXIdQorN4zNlh4L/XHHAA/qh5SrePxvhfaH6RHsLgY/utX4CO5srrE28VQzFBHz8Wqr3cXpk9z89iClo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705886273; c=relaxed/simple;
	bh=Mdz9cGjuQADsFkKetLpmpRQJEwXMLCfgsspTt6cG24Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Mu/bt6GR6/DGunsqB38ylqkVpjOaiFgAmn8oerUDw3/iWZmRecamfigSIysUCSS98QglubUF2mIajj/1sA9F0uK+K9jFJVrROU21CVZxEkWZjjm15N4WuatMBt7+n8XIWxmS21YZil38D3ufaflVNQ7bOfn1e5bng6GORu4FloQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=BAN+QFEs; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so2483969a12.1
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Jan 2024 17:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705886271; x=1706491071; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PEo2UE2fjP7Z+z+KBxfIIxdS981aTOhfcVHCSrHjQKc=;
        b=BAN+QFEsfHTHMbuEMhbmEGfc+qn8jWLKDPNp9o3pqjCLEoXWVWLAOYva5qmI2ir+Tz
         PGJDlrl7rLjqqz25hLrSTiegK+3oCBc34aOZfv0/5UF29ViC5RyMMjWrPs5+/AjZ63TC
         bZDrSaW8HPMyN8CVQNBoiDMcCN4AljR19zN5Qls8BoL90cNOkKle2AsqGw5boaVF1HMA
         zNoX17vFvSijroSxyKoTlX10oO8fudwBACEbRKUvAZFzk0jjp14rSQvFKn75K1NMRAkO
         P3lTWwX15iQMyqVJymAngbHrw92RllZvPmC+dmUoiKhg31hNODpqmfJP5/HPNOC7MB4E
         uh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705886271; x=1706491071;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEo2UE2fjP7Z+z+KBxfIIxdS981aTOhfcVHCSrHjQKc=;
        b=crdxomNkUD1Km9/Hjh/qV++yYN8zfgzkWvJ89P2TebYj3amrMM/+H1pPGmO6ZcBHFf
         ef34XWglVUxY5ncgDJhVvRs8zi77ToLc4uTJKNY+ho2pNH1sJ+hpu5lFAHck6zhkR5sl
         7nJ52duWnSApX+Yy9mnBPr3DwJwolxPaKHbjDbhGQgFh7GhqF5OCpVPqd1Nwa/SHTif/
         YJ7I/GH/a9DX72wGD+cq6ovQYQrDiNDPlfGxIgtwl7hcje6yQP1xqGW/7uOHYb/d35Ab
         gP3TsWod4HQ3lnIBkKSmhJjVPgtLb8+ObuNNpczOVLj72VuY3WVDkKS6wU134YiFso+a
         yHig==
X-Gm-Message-State: AOJu0Yw/Zz+ntS7+VYdhaMSgc7xj7z3IQT03AQl8E6NxpyPu1IzgxQlb
	vnZ0SrazIZiP6VIccC3WIXiGdWqPvxwn79iM8NpcttiKaVl/TDse2EzManYKLPw=
X-Google-Smtp-Source: AGHT+IGtVxTbkptDzZqm6CvEUjljevaIalWoKmwAVRCBs/cnNGFjjESrQS2tsacHcRncPtKFwLC0hg==
X-Received: by 2002:a17:90a:6f27:b0:28f:f249:3c4a with SMTP id d36-20020a17090a6f2700b0028ff2493c4amr5340207pjk.19.1705886271316;
        Sun, 21 Jan 2024 17:17:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id sj15-20020a17090b2d8f00b0029082ec3619sm2285069pjb.30.2024.01.21.17.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 17:17:50 -0800 (PST)
Message-ID: <65adc23e.170a0220.6753f.4b6f@mx.google.com>
Date: Sun, 21 Jan 2024 17:17:50 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 5 builds: 2 failed, 3 passed, 2 errors,
 5 warnings (v6.8-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 5 builds: 2 failed, 3 passed, 2 errors, 5 warnings (v=
6.8-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.8-rc1/

Tree: kselftest
Branch: next
Git Describe: v6.8-rc1
Git Commit: 6613476e225e090cc9aad49be7fa504e290dd33d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 4 unique architectures

Build Failures Detected:

i386:
    i386_defconfig+kselftest: (gcc-10) FAIL

x86_64:
    x86_64_defconfig+kselftest: (gcc-10) FAIL

Errors and Warnings Detected:

arm64:
    defconfig+kselftest (gcc-10): 1 warning

arm:
    multi_v7_defconfig+kselftest (gcc-10): 1 warning

i386:
    i386_defconfig+kselftest (gcc-10): 1 error, 1 warning

x86_64:
    x86_64_defconfig+kselftest (gcc-10): 1 error, 1 warning
    x86_64_defconfig+kselftest (clang-16): 1 warning

Errors summary:

    2    include/linux/fortify-string.h:57:29: error: =E2=80=98__builtin_me=
mcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings summary:

    2    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_=
memcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]
    2    cc1: all warnings being treated as errors
    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x14cfd6

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
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning,=
 0 section mismatches

Errors:
    include/linux/fortify-string.h:57:29: error: =E2=80=98__builtin_memcpy=
=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings:
    cc1: all warnings being treated as errors

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

