Return-Path: <linux-kselftest+bounces-10884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692AA8D4223
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 01:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8041C210CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 23:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4A41C2339;
	Wed, 29 May 2024 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="M+zyPTZs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403CB28E8
	for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717026915; cv=none; b=OjHuXqpfi41/+2dB7hbP+7ntKgnF22LWzM6rddJGZKty0/i4J10u9ckFejJS7KdGDk7u5W3FDBZRrRIFySQQGcaortyN+uXo8qd4Ikz/ePRK2GojL/MpMBXJzFogUKeM2Q25YwxbR+shGTf1cuT+HP1X2dcLet032sy2ArYPgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717026915; c=relaxed/simple;
	bh=dOFyuloBj/zwklIg4VsJpHFqiln6SGPlXNj+VnyzAyI=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=dwYZKkF3/sExcdevS0jC68yOCpbvLdZOvq2Kp+0EgGjVx9jIA5FSo2ypL9+abAsYcXI6ZSMqLUGXHwX2tG+LP1ZZKBHfAemo1BcAUPTYHdqxcEYvkAgnLHaMCCT5RXQTvcx/bl9z68GPesj5TMF9gFhkA3QKzyFVCIkxtYuehiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=M+zyPTZs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-701d854b8dfso306371b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 16:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717026913; x=1717631713; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KQ1O+JmdlJtcXskvcw3euq9830gu5JIlq0yafs8CgDU=;
        b=M+zyPTZsaycbBJY9SBEXreV3KEBqRQv8/cFfJI04lPsRDbtHsUsf6/hGrG6BQKTsaR
         Au1nWtuOnQLSzwhMGwbBEiNScLSyzXcbJ+kWcaACzv2EsrDmM+UHRigffWsut/PXcmhU
         vHc5BeA6g9+ZGzqRV+z4SPZR8HF3B9bhBfrFaWlsbGkoCQzUKDFLx2r6Mh966nqRsFKN
         sbhJomd+0qjhKOFy+E7eWir+sAoXgQTo3vEQt3vundWIuKC6LXvBM2hYceM8UyEgochb
         IS2uePJHZbKdqCmOP5uVl5Tl04rMX+2Qqcy8H7iydScEm5E33kjoX7MYmcUj4nyEZDGl
         oZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717026913; x=1717631713;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQ1O+JmdlJtcXskvcw3euq9830gu5JIlq0yafs8CgDU=;
        b=quTb/oKVsqK+RXY45uq2C4dk3MrtD/9CV5E9xs+m5o+Fs+CaOmPprs9+2LU4EuIDrP
         L/sdDO3WwKV6BVikkjN5+8Z56rSEcGNE/th0RE+ZUC4ngu+BIK6GIL5iSf3GjVc3dsoX
         Fn2Jmj5JR44GOtzE85WOWqDv5M/7LEC8X1e0jRFm7eD4TK3t6iZlI/g878N/miXtA0EH
         d0Jl53a1w5PbcPjPYzri308eG56bnW5ZDxrc/j/RbiKGTT/cXWCV/tWNQ6Swjs8UIQK1
         rtpWnVgHVYhUoU+riOuudRQ1e6kfS8mT/y81G9mJa+umluvrPexOhbH7EBOhm0YuJ/tA
         KZ3g==
X-Forwarded-Encrypted: i=1; AJvYcCUpzai4p0ekvI18CfJoLA3WZCgAiBBLq+aZBIqNoMV/BucnknbLFdJk6iwlGI0ln5pTcU6EhVqgm4P3R9FtF9OZqLKZMKp0L624JTiSxnzh
X-Gm-Message-State: AOJu0YzVLXxMNM2Oy3vIXAI1hz8808U5MUrfn1vTeF8U1D5dH1grMHCf
	noJsnDHytqYGGcrODycLGFe4b61zLwjyXb+ZVsiboTogydw7iSMQelC/YmMp7vs=
X-Google-Smtp-Source: AGHT+IGl1itDWAIl3eAcYfQzJCuVt1hLz9kOxqdbVPyjA9SC6sFfGA8xcHn6f8aBxIzSbUc0LZdaRg==
X-Received: by 2002:a05:6a00:3311:b0:702:2f19:658f with SMTP id d2e1a72fcca58-702313de331mr525510b3a.30.1717026913426;
        Wed, 29 May 2024 16:55:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3dea2sm8523232b3a.24.2024.05.29.16.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 16:55:13 -0700 (PDT)
Message-ID: <6657c061.050a0220.abc12.7e83@mx.google.com>
Date: Wed, 29 May 2024 16:55:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-7-ge8b8c5264d4e
X-Kernelci-Report-Type: build
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.10-rc1-7-ge8b8c5264d4e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 6 builds: 0 failed, 6 passed, 1 warning (v6.10-rc1-7=
-ge8b8c5264d4e)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.10-rc1-7-ge8b8c5264d4e/

Tree: kselftest
Branch: fixes
Git Describe: v6.10-rc1-7-ge8b8c5264d4e
Git Commit: e8b8c5264d4ebd248f60a5cef077fe615806e7a0
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

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to=
 !ENDBR: .text+0x14cf94

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
defconfig+kselftest+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

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
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14cf94

---
For more info write to <info@kernelci.org>

