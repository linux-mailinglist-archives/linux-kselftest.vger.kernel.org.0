Return-Path: <linux-kselftest+bounces-19409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265409978B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 00:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F1C1F21862
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 22:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71204188587;
	Wed,  9 Oct 2024 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="g40yPUF0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6C738DD6
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Oct 2024 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728514274; cv=none; b=a7ouvxLSt5TlidJXdljioTVC78L3RKN5eLvTGYrNJkqTZAVYRnQd7sWZOZ7fK6GqVu3usPAOkIA2qUdSWUqF33UxYgPiOAVoE4WGhZy4huD2ojwCpdzlY82Gs/R1yUYsHdcHkAw5ZgwY/kbtWW/5rubPB5sb8ofLndeTG67jWjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728514274; c=relaxed/simple;
	bh=5OzzCsqeGJY8HGaT9XWNNPXhiSKTiec/IBeoY5zeyOc=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=L1StPjYA0lQUj+lGjS2TrFtOdPFr3yUiLaVvQN4mHx7Lvp+1boYi0qpq/y2nVvPminV+XuFMmASqw3X5UCbFCj4xuiRy+pnZp+p0vOzGYp00eH5xRecAI6rZN3o4mkJW4PqwBXxiIlleIJ2LzaxzBgGU+smJJQfIHa6UyOJK8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=g40yPUF0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71de9e1f374so228075b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Oct 2024 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728514272; x=1729119072; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NFJvlQwrSSopdzCzZ0CspmqiGNbR/aW2giNxMT+p06M=;
        b=g40yPUF04s3Zmc4IuAdKdh6UsPPhwKl0LuWfB5+syQM9+YdYA0vYRdHDCmz6FTPecW
         mIhdMi1ixRl1pG77J6896l5u/h2sm926claQBOVAIFoLO+87cGVvsV17gVt8+XromM9U
         j4cLu3AdcwZtMVeAki+2wAqPmmiVqlDelONXb6rwvfLzKQrJ7IQm7CCs/WD6QV3VQVPL
         Q6OkzfHaLkbu5/v8PkeiZI1EBgAG1YQSjJjH9l98bLNxHsXIvpHgGKHH97R3yeQO8Gkg
         +lOrnvNXyyYSlw7QGtItdSfBztUtJDrmUwZvcjhwqAghjqtnyoCqfLFdsLaLuVQRkZAJ
         GA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728514272; x=1729119072;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFJvlQwrSSopdzCzZ0CspmqiGNbR/aW2giNxMT+p06M=;
        b=v4GuOR27CJreUTnYQ+Zd4Hdw+qT/5P5ayA8YVRhoYKGdcyizQbDRxXpJULRyYUbzwy
         62dbhofUo2HADq2IQblCVXqwL3KhOd5IYkyAquwxYxyV0vpDEepiGJd2uNcBSSFzfTl6
         GNPVvFwlfRfj5nZZ/zNbuBsZwFCcPLA0E+ZRFXFfs0Tvy1DZGgW787bEroP66QZyo83v
         5kptO8SCLwKCAcrR+BAzbuhPp4tomUEpEaf/u9luvvznutr0N8Gi8Homh+ZZR5xPlRlE
         GHWWG2hxXyknaZqFryPvmn5hren3GI+TdxuaC97M1E46PisFVxeOLISG0TDGdwZ+pCUF
         gdIg==
X-Forwarded-Encrypted: i=1; AJvYcCVsSAj7lRTFI5mkrX8b5Kqn/G8WPRoMAfBbd6BVhLayUYQHeMC009PHRDhC8ba6q3skhEsDBPbv4zoWM8THVGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ4MSPsX+NuGmTPGjiw1PqFFzsPkcm2UbQaqMSoCHytA7+WVwu
	nL+b+Ljo+4AIZqAHMiWD8UfX9xFzYyVpjVYWHRvK+ViSKxR3mTv7jNq0hu7mXa0=
X-Google-Smtp-Source: AGHT+IE5VI2SWsHXBOQEmkyPjwDbYIT/yt4KELnWaaNuyq35meS24rk8c7VJWFNh2u1XVSF8NJEe8Q==
X-Received: by 2002:a05:6a20:9e4c:b0:1d2:e8d8:dd46 with SMTP id adf61e73a8af0-1d8a3c005a2mr6006169637.15.1728514271962;
        Wed, 09 Oct 2024 15:51:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd0610sm8310831b3a.69.2024.10.09.15.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 15:51:11 -0700 (PDT)
Message-ID: <670708df.a70a0220.53045.f807@mx.google.com>
Date: Wed, 09 Oct 2024 15:51:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: linux_kselftest-fixes-6.12-rc2-5-gdc7da277516a0
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 7 builds: 2 failed, 5 passed,
 1 warning (linux_kselftest-fixes-6.12-rc2-5-gdc7da277516a0)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 7 builds: 2 failed, 5 passed, 1 warning (linux_kself=
test-fixes-6.12-rc2-5-gdc7da277516a0)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/linux_kselftest-fixes-6.12-rc2-5-gdc7da277516a0/

Tree: kselftest
Branch: fixes
Git Describe: linux_kselftest-fixes-6.12-rc2-5-gdc7da277516a0
Git Commit: dc7da277516a0f22fcb4ae904c4ce0083ae0b9ff
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

