Return-Path: <linux-kselftest+bounces-19647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD5B99C977
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 13:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F715281DA3
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 11:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7618519E980;
	Mon, 14 Oct 2024 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Fb1JcytM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0319E971
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906838; cv=none; b=UA5Z18cEN/uo5YIp1pXKQ5VL8l31eAaCrjaeUG8KZufSh/fKdBCmhG6gnCugS3lpQQpG40ALmPq39XinEyvqfrPjD64Et+ST+gEAlsj7TdcgjBu7zkMh38mLTlhfofcSzaR1EhKxvFNwZfOBp3VUBUezj3Kr0FMVduD7VG/T4SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906838; c=relaxed/simple;
	bh=I7MV2OnT7yor9qlxyhVOBqFFqoSCkTkuBGNxJAIMrdY=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Hm6xw3DmVoZiazVU7i+PZZd2UrBrh3Ncl9pji0s92iosPqKZN+VWxk/ucgfDSWFoYJRJRp+5RQG2QXYqNOa/+8dHXHVutpBp3bH+Vd618Hh+7R1mgbgv2WviD+SCA6XyJKRPo98fvxOG+gFDlMmzaohRkwbrUY0Dn5ydMPCFZ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Fb1JcytM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso926135b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 04:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728906836; x=1729511636; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OZ+SmXgrj6w/kSUfdlGfSaJGjuo6fUkdOR2jsgZxxGI=;
        b=Fb1JcytMrvdcI86v0lEy06Iura1Z57QkAoN+q35kBJ0HukhDACOLKXJNsaGnOaU+t5
         LtJaQZnk1M+VV1T6Nmrh8O4V0ToDnoaWBYmj12+cDMYn1wcrYpFqbWd2BUrMjHXDU16g
         DhswqM8GJ4honjq1aL/aLo/o4iMT9GWfiZTIZWKV2uQKzfieO308WgIxXPqQCHr4hRN3
         avaeb+ZrM2FdpmiWtRRZXESNJPeHsrXQRPKHOUHQQ+YeEi68zKr+derj0bsK2TkLBkTm
         mYAWRtsI+aq1OEBOw0S8z7e1yDNY5QIuyu4gdrBpmvzznhtcvQaWUeDeAcLGLs+MuUy9
         gWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728906836; x=1729511636;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZ+SmXgrj6w/kSUfdlGfSaJGjuo6fUkdOR2jsgZxxGI=;
        b=wU6snfbMgnj+ch7dvMM+mlMG8VGAzzhy+oMdm5oa9BZOM/rOI1CShOjBWnhFshk8Yv
         k868Y5RIlX4ECvClU8NyqBddPEFhy15d9zRNMFLWWYXdTQcJpzBLGJ8tuEbhr+4NoK6n
         /lZTkpUb41AJVg6KD1ZRzlQb+TxWeMzrmqtl01xO8mSOTEgp5XcG754m+C6yw4wz7GkI
         nKRwg5U4b8q+jAERbRzw8MeoK+RtTw+idnzg8tphP9mOQW88oAiVSbv+bz40JqOMMehS
         APKAF+tzjzO92VbZn5FRWEmc9xRczYcXLlYAIgBp4ZnqjnOVlb1/HXpYL0wjW08p3k50
         W/bg==
X-Forwarded-Encrypted: i=1; AJvYcCXwR3VU36bXUzwa8S/IZuPJ/W5/Ii/2gWlIZgu6UUYvZdW63ohDenhMe0BIq3sFFGIHYrMOrjfbLBKdrCHzZCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDH00ZflJZ459fDcPqEzXTtEJ7xDT6euwELjvxbYQUOcliCDby
	gw6+qorvSJPQat0Nmdz/j6LprzI1/8VAsJb9l+VEd2sik4RhhIuPP5gvuL7vM+9LcQ9LeC2lX5M
	y
X-Google-Smtp-Source: AGHT+IGoXSgjKi54rVBnEHhykmPiISIY0ifgy87fpMx8LWsL4fmjtICDV+2lb4EQ2Jk702pfYmr+vQ==
X-Received: by 2002:a05:6a00:3d08:b0:714:2069:d90e with SMTP id d2e1a72fcca58-71e38083eacmr16953039b3a.26.1728906835971;
        Mon, 14 Oct 2024 04:53:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e493db367sm5135603b3a.92.2024.10.14.04.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:53:55 -0700 (PDT)
Message-ID: <670d0653.050a0220.10ad4a.c55a@mx.google.com>
Date: Mon, 14 Oct 2024 04:53:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux_kselftest-fixes-6.12-rc3
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 7 builds: 2 failed, 5 passed,
 1 warning (linux_kselftest-fixes-6.12-rc3)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 7 builds: 2 failed, 5 passed, 1 warning (linux_kself=
test-fixes-6.12-rc3)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux_kselftest-fixes-6.12-rc3/

Tree: kselftest
Branch: fixes
Git Describe: linux_kselftest-fixes-6.12-rc3
Git Commit: 4ee5ca9a29384fcf3f18232fdf8474166dea8dca
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

