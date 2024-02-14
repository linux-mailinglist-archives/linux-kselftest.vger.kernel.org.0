Return-Path: <linux-kselftest+bounces-4612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5D2854315
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 07:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B71B23835
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 06:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F330510A2C;
	Wed, 14 Feb 2024 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Yq2udMmy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445AD11193
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707893492; cv=none; b=JEtEHtnTa4x2kd6xrEFTk7A3LQSpuGmIpWT6jfM7uTvTU/gfoY+ASKUDVgpYhZKYt2UyLxA8JZ9HZtEYcTCRm3qyS1OKjOgn8qRswwI/3q1TbN3blBZDxkb6NGBgVFFg0YXV+mjjOJGVPAh2FeazuFNw5OLIfz4vsIaCYq2zCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707893492; c=relaxed/simple;
	bh=1Ed3UkMxuQ6PS7K/cpwFUKPEiLiwR+dmu8mW6YEFDGk=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=OeATyv2KpfRO94yUv8cpv7VvaEJXVPeXp1MTfJFHbAHfuu8brw9cCMOGrzadeUQVuvfW6M3nAqbehPekB6t42zM+fgj48FcxdIL7AALj8cuDplKKCyjJpg3hrUOtRyIaIQUUoYKSkEFdRwPn17Ulpg7r7xDvnZAw/QoYYWVLHbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Yq2udMmy; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e09493eb8eso395742b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 22:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707893490; x=1708498290; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8InoOXw2RVRoAVG7xZzVi+ZHM+br6uu/SBm3lUZ7Ibc=;
        b=Yq2udMmy6Yhay2McX4wZfBJesjbAM486zDGiuvzmWBKvREgjZ4ZLOJlUggZrl4fpnQ
         7Ml6DmXMhCjNAjWiR2Ba9KclRhaoJmtyuYZHpPujDycqswBuYkFNLWLEg3jZQyaYrboJ
         CpvF6s9gyTVQzEanHyBbqRnrhbJugmTiof5cC3jL47UrFtZBdKuD7YNy2BMCylDkA6Yu
         Oo6ZuozQRso+pVjOg1I8bhgVqtOH9ButxSGu5DlJtWWQ/ijSZvYr4SUAtSPFN1U3uZNl
         8jOdzr6eIMwQR+EggIi7HhycssUl+lBKvWmi/IaSrCkrcICU7h7dd+mlKgwHWCln37DX
         Z+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707893490; x=1708498290;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8InoOXw2RVRoAVG7xZzVi+ZHM+br6uu/SBm3lUZ7Ibc=;
        b=ZpJKRyQsEbU5HUTc8Cvz06wONX6G6JjUtu4PTp59eXsqAOaepM4jjUtV8b8IV/zcdq
         cSECbYsAqXuVFESk6vLFIWGfVZnNEeECeOr9xlK0vDVTqrSi8G6xSnT7PyUc0CaQ8Isg
         Xuxdc59l6xjMvSOOYTyQdsCFWtRrcMIMvSqD1str00wd7Mz0GFTbbd+qziE3lXTlR6Tk
         hteMufoJtFGrypRjX20OYlkyEUCcCZqk3h6g46A0cfNv2WYiIiE2CqpWluXLPTMFw3IZ
         Bzh1vx+f8Uj0W49JZRF58boJxwQ2jp/y0b6tJ8xWDbkacKHuxZNpVQZWntd2Dzmf5vql
         y/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFLkhIA+tLF1eXkuF6zfDj/B96gTgesHr7gPoLAYsMvMP9y01/mKpFp2vgCDt994joXSvzkWaasHTP3B812s8ofDy6b1VKCLYlMdtWq6Fy
X-Gm-Message-State: AOJu0Yw7BDn8BJAGP3aYck5b2LBBB+DI7uYU0Y1HQjVHRHToc9lb2Ll5
	djA1/8DqYEeCUOUooMgtBZdx0tXbQ+2ZA/idWot6mRz2gGe4a15T52XxvATXY8Y=
X-Google-Smtp-Source: AGHT+IHMgu1JOKpZ0kOU0I+eqIveQ9LVycQT87TX5Jr5WCjJa1PvY/htRSw5wDQvyh4bF66FoZkY5A==
X-Received: by 2002:a05:6a20:43a2:b0:19e:4ab2:c362 with SMTP id i34-20020a056a2043a200b0019e4ab2c362mr1689119pzl.14.1707893490504;
        Tue, 13 Feb 2024 22:51:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHEXgKdouy9/GFiSOqC6YysfsOvQsTzKqrTaUGIbjYzvEnvSC3FFOaGNI3Z/wBep96UVwXU2kcg3h0GFCx6w0e3DguhGuYEotiO5SdSWpGzKBMyjTkYf7XUBB44Fh9vHZf
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id lm17-20020a056a003c9100b006e080d792acsm8357334pfb.184.2024.02.13.22.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 22:51:29 -0800 (PST)
Message-ID: <65cc62f1.050a0220.74c67.7ec0@mx.google.com>
Date: Tue, 13 Feb 2024 22:51:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.8-rc1-32-g345e8abe4c355
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 5 builds: 2 failed, 3 passed, 2 errors,
 5 warnings (v6.8-rc1-32-g345e8abe4c355)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 5 builds: 2 failed, 3 passed, 2 errors, 5 warnings (v=
6.8-rc1-32-g345e8abe4c355)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.8-rc1-32-g345e8abe4c355/

Tree: kselftest
Branch: next
Git Describe: v6.8-rc1-32-g345e8abe4c355
Git Commit: 345e8abe4c355bc24bab3f4a5634122e55be8665
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

