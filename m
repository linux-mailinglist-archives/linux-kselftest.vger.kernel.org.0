Return-Path: <linux-kselftest+bounces-3755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF14842C3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 20:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3081C238F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 19:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4506E7993E;
	Tue, 30 Jan 2024 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="3LamsTUm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2076279948
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641230; cv=none; b=fSI1TFsr/f13txNFcnlujlNp+oOwo5coidrls1CMb/Oj41m+jNDI69zwp8RLd1mp9q4HR0q9HPQXxGqVm1rvUU6VXey1MY6QDtQqdyxyfG+/0Y2ZAJMZN9fxatazhtMxfC5JjNGrZd9yPeqv2pCZ8W8Sq/2rdBhfmyTYCZBp4+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641230; c=relaxed/simple;
	bh=56elv0L8fFS5lUO6ko+c/MQ6HC+QzOu0kNPycO7ZrGk=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=oWacQZ+vja27dZknuGtlYWDvaiRWw7lH+PpWbFzEWXyxy2a+XiOOmGdSywPKJeYlpVH7hkRgW9Gi5SLP0Qt0s3nXKBhFKnJQ0slu2MWjaLXisGRN+iqVCrFao/eFVvcQnVNsrzIucIElkdNNe29UaQ8c0o36F4j/e5A/QL78sIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=3LamsTUm; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2796193a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 11:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706641219; x=1707246019; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9itGHOsjJfhryTIbRBa5covhNN1I2zvlWIf6/+YWowU=;
        b=3LamsTUmh0MJdjXUSSZpkVoKGTnHromHsFu3tEwE5tgKZmet75aZN/XJPBSJ+zySoL
         GA0hrQX7oUUC/Ic7pVb3Jmuq7Np5jSDi2hYpuKJ8djbWW5/UlvqC+GrFG/ao1g1z+ESn
         rapsgiMtiEFkbjjdSUZr1+QYa01wYT9oGS1zGLILJTNZCviXOVZt4KxA5pKatq9OnJjU
         /HLbwUwY5F/3+TMlXzLtRNGbwrLu8isA6P7VNToKB7HEiRMmMZN8RHaBVH4do55AObg1
         XLFC3HgO/d8pi6BmUjN2Y+bhkCt/Nr1P/61LnNPrqpj79IU0PD3bWR6Qv5bldC9ty0LD
         fFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641219; x=1707246019;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9itGHOsjJfhryTIbRBa5covhNN1I2zvlWIf6/+YWowU=;
        b=fzDxbzBsjwwJruUl+nqWwxMLNsSqyfyrr8Zw1zxsLYgLC8d6UKxoGpDGM5eGBnf97d
         KiWuCWMA6tI1dgaDoxRMTnidX95ZXcIFAiPDpE5TuyTT7dxoRssj4AI3cSnHeGTkYcXb
         BtwhTyh81Pv/Riy9kNQ7n0TnGYvf6b9fPA/YdKEyoWQPMxDRmzr3Q0pD9Kdce7eZmKsR
         bKUJUYpr+6lI2JBzBKjulxVxuYrVUm42zNvz5ooDKk4q4V0aJSWccD3LisqlU20qjCoT
         nxHPTjzYVDaJEJxmWZvDRvE6FY5qwApZ0EMguq6RggawKXRqx02SdbVISIkz2bNaS80H
         1cFg==
X-Gm-Message-State: AOJu0YxkB0ZhLAL5A70uChuPAYG2A9AzK6AszUHKFpSrrAylZpC9ZHak
	0/FNnPUBKYhS30zkYWYsGDdVZWcE33ea4JMAAPp67449yo7Ik7tOwqctOrruMKt7F8k5jC4stnJ
	e
X-Google-Smtp-Source: AGHT+IEabslO3IWw5s9vQ1QAxLIlUncCO/9l57azPN3DrXffwH26NTnK2M+Cv2ZbMNtpeXRVK70kUQ==
X-Received: by 2002:a17:902:6e02:b0:1d7:91:4f9e with SMTP id u2-20020a1709026e0200b001d700914f9emr5939186plk.96.1706641219407;
        Tue, 30 Jan 2024 11:00:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090311c200b001d919be90fdsm855665plh.42.2024.01.30.11.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:00:18 -0800 (PST)
Message-ID: <65b94742.170a0220.6f2a6.3ee3@mx.google.com>
Date: Tue, 30 Jan 2024 11:00:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: v6.8-rc1-4-gb54761f6e9773
X-Kernelci-Report-Type: build
Subject: kselftest/fixes build: 5 builds: 2 failed, 3 passed, 2 errors,
 5 warnings (v6.8-rc1-4-gb54761f6e9773)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 5 builds: 2 failed, 3 passed, 2 errors, 5 warnings (=
v6.8-rc1-4-gb54761f6e9773)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.8-rc1-4-gb54761f6e9773/

Tree: kselftest
Branch: fixes
Git Describe: v6.8-rc1-4-gb54761f6e9773
Git Commit: b54761f6e9773350c0d1fb8e1e5aacaba7769d0f
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

