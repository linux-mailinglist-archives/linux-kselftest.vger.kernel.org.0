Return-Path: <linux-kselftest+bounces-5894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135EA87177D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 08:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF958288D61
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 07:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB1B8004A;
	Tue,  5 Mar 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="xmtcpIFs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CE8003D
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Mar 2024 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625375; cv=none; b=uvamBHl0jnNX5wc9UDNROOUV9yqua9ihlO2CWTzVXmIusZkzsaa0JEgHSN9RZGJjDlwxqMHAHaosgYEFJLx73CfAW+4zgr3snYGipe+ZttpQb3K6/SWsVVJI2K9mskpUk4OgX6mLpXHLLZjQnqFj8+DxNGLgR8TvcrTLitJgJsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625375; c=relaxed/simple;
	bh=K2QCWyUQxBFX7A0zA6MGt7OC3IU3AXsAqJ5joNtLh3o=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Z6qDNswJA+KP1nSWBhgg5A5a3d28NHncGsKrag/Ka1TQrq2m7biDatwr53RY/asMaHwGZm67FPGC6/cnmdZlUhO7m1L7jZ3bk5oXJUV4SYVi+m+TfD9kMyJyXzQGL3mwkTvnL4DxYEjn0NJdyqPjGsBhzbMrZVLnhUNSF4AxSyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=xmtcpIFs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dd178fc492so13023585ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Mar 2024 23:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709625373; x=1710230173; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pVhC87EyIfPQJT+p6yqEKO+JNKdUvqx62BOmE/7djg4=;
        b=xmtcpIFsRUc6zHrLjPcNi705Yq+03kBX5ZWMKj/J2cJDp4rScHJbuO6HKqyMyY1svD
         IQyCuKRYEzDqh5uhRO/rJsGWlaowxRBsbAbCy1W6/243VyqqNNasloMS6+iIhnhKxHU6
         4CfEuxAX4DiLXcch05Oikn9q9Ctcu9dSUxFpYM9SqAvFSQ84xcwscKtTlr8p+mfzhDfU
         mJVIhlzlCEUqp1gjsnsoikAFYJohBsFK2zRM7lo564I422PszWoHrpJlpwJqnXwmLQyL
         lmVEa+QZYVFOsL9vKoTbJfcuiWO9yElVA2y7cQzZzi+u3Pe5Woywr7ihnAw+W+zV2DcN
         rS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709625373; x=1710230173;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVhC87EyIfPQJT+p6yqEKO+JNKdUvqx62BOmE/7djg4=;
        b=eRWFVVo457rQin82LXydH0SBO+UnaSlk22aGT/emeaATPllZPylWpiFXL0csDS52i6
         K2nifap08MhXG9GifgFcPOoSmo7iisekm/nNIPqDwgvY75PmzByWy2r8Fxtyg2KbYkXv
         j51ltjCF77ex80fMQJREJmrRx5KFW5qrlRk1Oif+FRlZm8C8PHnNGiwNurgIE+59+vas
         Wu12cuHP4n4Uq6B4hgwhx/jEu+pI67f6rMk13nCyyGkfZs7qVv0g8vCKxYZfPq1l9P9C
         /jbka67pDe40j09T5fft62lAdlVjNvxihFf9T8gICU6cf6i0CCo977WkjfPOzhANiN0l
         Y+kA==
X-Forwarded-Encrypted: i=1; AJvYcCWdKz3THSR3UihJuplzP2xstps+QzGB1pnXkf/fYu1kPjn2/jbKEGhddTVZcC7TiaVa4hGTo1HHoBFRdZzU7mJNB3/6eQOYcwMDhxZ0NO6J
X-Gm-Message-State: AOJu0Yxr/DE2H2EOT+Mplxmiz21CIJADbnDOkHmY5D9roQYh8rr2Gc4e
	MCJb6TSsDtVvXjnG3xGGS4EQA6jPxamUnPERT6Q+/K1DBXG58pwCSb5e8qTeJsU=
X-Google-Smtp-Source: AGHT+IEYBWqtJ6xz7BwRmnIXG+li8CT6RMYf1r214fyfXQ1bP54EQ1zafHnTXQUzbkH8SvjPp1J5XA==
X-Received: by 2002:a17:902:ce8c:b0:1dc:fc5c:9e22 with SMTP id f12-20020a170902ce8c00b001dcfc5c9e22mr1216665plg.33.1709625372901;
        Mon, 04 Mar 2024 23:56:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d48500b001db9cb62f7bsm9881429plg.153.2024.03.04.23.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 23:56:12 -0800 (PST)
Message-ID: <65e6d01c.170a0220.37829.69d3@mx.google.com>
Date: Mon, 04 Mar 2024 23:56:12 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-57-g5d94da7ff00e
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 4 builds: 2 failed, 2 passed, 2 errors,
 4 warnings (v6.8-rc1-57-g5d94da7ff00e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 4 builds: 2 failed, 2 passed, 2 errors, 4 warnings (v=
6.8-rc1-57-g5d94da7ff00e)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.8-rc1-57-g5d94da7ff00e/

Tree: kselftest
Branch: next
Git Describe: v6.8-rc1-57-g5d94da7ff00e
Git Commit: 5d94da7ff00ef45737a64d947e7ff45aca972782
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

Errors summary:

    2    include/linux/fortify-string.h:57:29: error: =E2=80=98__builtin_me=
mcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings summary:

    2    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_=
memcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]
    2    cc1: all warnings being treated as errors

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

---
For more info write to <info@kernelci.org>

