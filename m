Return-Path: <linux-kselftest+bounces-18512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13BD988B7A
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 22:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA3FB20A1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 20:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52C81C1ADA;
	Fri, 27 Sep 2024 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="RZ4ZEfpi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D725715B57C
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727470065; cv=none; b=cz0piPUFKJLLwCDV4yg2qwzo6qg0ZGWPvq4iBEi9iHjfAuI/jXhRpDtr+zQ28EjlDuK1rn5eCi5oUVTQ/Nffad3XSS3Me9cpg490YldRNTjj4XVF5BKlSbu86lZFWJGju942umktIvxbHwdX4rT3PSsJspTbIhRSNoXs4yvYUoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727470065; c=relaxed/simple;
	bh=dGURXykTGIk90HcSxOJEvHk22obsiMfG4dDOvewwOPE=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=iK4YX8t1TuMcPXLBJTdnvv0lpNtUcaueAmI0WNdN/iLWOp0W4Jl88vlh95qcMXK3sWWPLG2rnby1oY5uM7t4bIuBwpbX9UBooWZR0NdtOyWW1inw9+rP8X/yDf+C396SVYv2SlUUdsyJgiiYgIT7mKf8phHgQJ7mNWZheKdj3pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=RZ4ZEfpi; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e075ceebdaso1961502a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1727470063; x=1728074863; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cYrK5CWQlhtP0ChyNTRiZB1yZuIY1xzdLogsRzYS9bY=;
        b=RZ4ZEfpiakK0b6heFvQs7AoxOEUrMiodJE0YQ87k0XqpghQvJ7yn0LJ9xgbBQOoq7i
         FTvu6CgvePPH/V0iHLWXVpin9cqSNZZSa82LdVYmafhIRnIJVNDy832C+YsPeqxsxfD3
         8NlyZLdQql5jhVZKHe8+FUckFP+ZuE0VuAZRzlNCLz9qKDZKS1/KDvXRBZWjoXoA4Qln
         0p8dOrZjW/WPcXcflutnkLjkN6v8IUWyBqR3rv4hTV5qsyDbnIZZ/oncrPjYb+ZeO4mH
         cDG3Jpoeo0WqqqolgNNMqd29IZDn067+5QZGZbsBJSiu+fuMIGI6FDl21oZt0S9LpDzt
         DNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727470063; x=1728074863;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYrK5CWQlhtP0ChyNTRiZB1yZuIY1xzdLogsRzYS9bY=;
        b=F1Tf5v3xIhtXmztJvTU/GGAC/GcnL1bmglRSVdafJfDrAV8POUJzJuUyyN9fBa76Ze
         eZ2TkOBXbra1fV3JmekEDY6JxxDdjN/24M78yBFe8MLEPsym+PCV+AhVHITBUxvX43p/
         uP2VEXUkW1oFlyYe7VpM9RefGVvLQHHJ0thba3l67ALbQc7EDHXB8gAk8s0NVY4n7ARD
         5qgRK6wv3uOEV4txdvggwKkszEAC65uxHEYk5ksFLa6SVeaBQnbgrbduaG9p8aZMxIX7
         cSL2B3szY1uoa06LODjjvURRpR7k7nqtKvYNEHy6N99zmlhpuaBGhkL9kW7O9z9YzPiD
         lAYw==
X-Forwarded-Encrypted: i=1; AJvYcCXoDtb+/VsAb67K7FK0DU4sCUO6+FKvgkSLGUjUUP9rT7yJbTE8Z7Zc73pkmeZcvLWE8d9tedvphyLj9sOvukI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPiB+vuQ4N/8l5N2+gFXowh+DOcaSG45G1Z9Cz8QvWd1VAFQ1+
	zuZuRa0Y3EG4RFtNamNJbX5ILf5oEfc5m1jpStSPq4wcdxFdxxWw+GwxuUlr5fW5lBmnoMKxFO6
	C
X-Google-Smtp-Source: AGHT+IEMv0VvasaVylFz/kyvR8T3inbjFjH7/XnH2t9kzaMDbsc1bAV+9qZ00G30KqxfmEsPr8Jiig==
X-Received: by 2002:a17:90b:4388:b0:2e0:970d:e386 with SMTP id 98e67ed59e1d1-2e0b8c5f4bfmr4813863a91.24.1727470063127;
        Fri, 27 Sep 2024 13:47:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d7e6asm6096651a91.29.2024.09.27.13.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:47:42 -0700 (PDT)
Message-ID: <66f719ee.170a0220.38b457.c3fe@mx.google.com>
Date: Fri, 27 Sep 2024 13:47:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux_kselftest-next-6.12-rc1-1-g4b721fcc094e
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 7 builds: 2 failed, 5 passed,
 1 warning (linux_kselftest-next-6.12-rc1-1-g4b721fcc094e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 7 builds: 2 failed, 5 passed, 1 warning (linux_kselft=
est-next-6.12-rc1-1-g4b721fcc094e)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/linux_kselftest-next-6.12-rc1-1-g4b721fcc094e/

Tree: kselftest
Branch: next
Git Describe: linux_kselftest-next-6.12-rc1-1-g4b721fcc094e
Git Commit: 4b721fcc094e9eb6dd4702df8d79ab11e120833d
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

