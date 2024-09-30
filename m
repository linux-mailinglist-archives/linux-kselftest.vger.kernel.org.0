Return-Path: <linux-kselftest+bounces-18686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3B898AD68
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 21:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDEA1C20B8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 19:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6F019DF60;
	Mon, 30 Sep 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="rWvsMHcT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CB619DF41
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726021; cv=none; b=UXlhehpHR6bzUOtIsT2CV8K3nL3TBmN8oQk/U2w66R43R+X/vQyrSqYG8ZwJmcNgCw7VvGnj0Cv7g0/6TT7TqOu37tTC9OLnLyYnZrE7gOk2dLKi/mey2+n28PNt6bPhBKmYssKVl4queu63W7yBkhMp8UHV38KQKHPC1vuxR6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726021; c=relaxed/simple;
	bh=TqgHfC/2SgXdtRi1A8h+nWDi7hno7OhXeVVViX0gNMI=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=AJfXuEDALzCtsoJqOhG/OP/ZXcgI/UtS1T0cWfi8Tzkkby0FgUyTAZ90AzKra73xVfVPIfjJtEUFJKpIgkGA9koPvJ4giBB5uboudZvMSTpUOqCQACytNxZWeppt/NWY72BOMBrU4VD5ywgCktnrKLPoXfPTW/VozruojGuoNJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=rWvsMHcT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e137183587so949408a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 12:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1727726018; x=1728330818; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn+fGH0jfc7Ll0A7J4V6yp1BhUe6mO4u8moiy4+pbDg=;
        b=rWvsMHcTlIIT9hnlr25RhLXLMzi7x36KXDy2Anjs3QBHAxoIr716iKI9lUJj1E5BDr
         SINZFikfbQXgd/fmvQnRkzEuMMQ1r3KhwjDoqUUHCFrfEK2MR2MyrgchPkEC/8/8Xk7D
         tVf48jaJuf4H3HJnrhHEvxuriKphpcvhcddHeUhx4Uk6rza+Cm8x6+JSZaQpKBbo6ZLc
         NZemdYhOcplfhhOprNX+rxGFlPMcvq6zHPwv8nCVeMbp87n3wWUa8a6VJ2Wl2F6e+NF3
         FpiduNckKiSD8jrC5bSgR4tx7MgX40vr0Gp4+1jq8CsuRimp9ushZa3hgxOW2K+kg7mb
         W1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727726018; x=1728330818;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fn+fGH0jfc7Ll0A7J4V6yp1BhUe6mO4u8moiy4+pbDg=;
        b=Ph8RBV5HkxeK2KmGlfvrtCOQ21to/UVxgKkREs0HBDVB9RIeMYWVkvdMpWmutkHqdA
         jFmubn18qSvkyzP4+7FrpUze4ecf3rzKpTKWW3zryvbjg4r0l1XmO/XrJpVLX9BD+B5C
         xxB5kkowgWtcMKdG47uv2gOyBzZgnROxRwb2PpRE5WkCqMZHn8On3fPOqUyPcUCcW7Ue
         mezKeBEH+FYLw8kQihm4qlVBAHL3V30NA6JIvvFk9jWQbAPgL39RLqWIOyB1uZ3B1HHk
         th3U0BAfvV3Snd/K3P/bq5g1B1N8vnncsC+tZ1gh3D5uGDqDMMUKaRbA+O5XV2bNJT2z
         jv3A==
X-Forwarded-Encrypted: i=1; AJvYcCV/kpJhWkjPrpQ3s6Mn+IElqhcDdIW8m18hYMpFTJJuo/x3y4s0uFOw5mdOirznDQyDrelDtDB7uiTVb42SkhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3b+pERQuUylAlocAjiweZ6dN2zAUPpe8pf/800sy2HCe+ertA
	oXXiJOhRfmscNdPw4vMDKqhbfhzgQ7iwChfw7EGxPgKzlUwAxT2R+ThBI1C7+qDFmTB9X7K15a9
	N
X-Google-Smtp-Source: AGHT+IHjhFArpDOzET3pJgk3IaYZ7L+a6z7Oll8jUco32Us2qAIlsxG6iO/a4yIOs5PUQAPAZ3eoxw==
X-Received: by 2002:a17:90a:a797:b0:2c9:7611:e15d with SMTP id 98e67ed59e1d1-2e0b8b19b6bmr15473931a91.20.1727726018342;
        Mon, 30 Sep 2024 12:53:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4c1e3sm8408292a91.10.2024.09.30.12.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:53:37 -0700 (PDT)
Message-ID: <66fb01c1.170a0220.23346f.1d6b@mx.google.com>
Date: Mon, 30 Sep 2024 12:53:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.12-rc1-5-g45a8897db67d4
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 7 builds: 2 failed, 5 passed,
 1 warning (v6.12-rc1-5-g45a8897db67d4)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 7 builds: 2 failed, 5 passed, 1 warning (v6.12-rc1-5=
-g45a8897db67d4)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.12-rc1-5-g45a8897db67d4/

Tree: kselftest
Branch: fixes
Git Describe: v6.12-rc1-5-g45a8897db67d4
Git Commit: 45a8897db67d43aad3a17a792fe06a6306f483d6
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

