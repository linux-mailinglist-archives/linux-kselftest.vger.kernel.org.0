Return-Path: <linux-kselftest+bounces-10794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0890C8D2597
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 22:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A20A1C21903
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 20:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B29876050;
	Tue, 28 May 2024 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="X5GFW+Oj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A54436E
	for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927355; cv=none; b=JBI1kdVHuTSsSoHkqmA9E/eIif7ca8s/x8/8+Uvx5w7XrltI3hOi8ggwIFdPUsoO2r1ssn7JJAb9y3ipwklqlDqfV8apWYOTyeLLFDaMUtFVlVWvNxKX3+n/0zGwjEuFe9fKVT0c5Z3OQ0yYfmhTNnw9PRFEHzFENl82wJSCrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927355; c=relaxed/simple;
	bh=LOvqo+aV+B1mOBU3H+RRFFDe5Cq38Xtx0O5Q3+LYB+A=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=HHjuC206AM+4xjbEx9t/AFphLYu6yy8I1n3h0TYMh0IA0BYSga7PRNQilPvchn2IgSy3BAH8NP/bsg7Xa+FqWc4rHg9uP9KXseE9nAVgVMKh1oOf9X8RqHJL0e/F7a/K8vRcnOa1G2ISKpKbiQkiUZkswrqOMdtszgpaDVzzNWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=X5GFW+Oj; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f8e819cf60so1065031b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1716927353; x=1717532153; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jcEC98X5Tk9pufqIfKmfwp4sjab37I3AMWo+deVLHIA=;
        b=X5GFW+OjJ7wkeW9DPGExW7KOkRfRmfAg0rCWSJmxUhn+cCFKdXpLs5PqmSVtmb2cZa
         BJ4lVmuLoGPMZ9VaKGm7Iov138I+/8TmPMw7qVWb498CrcA5Zsk7sZDP0AMxfDKtkqH4
         bS6Ye9toPGe0CExBrnrP4EXHf+ILJMaru+ZCXqNoS3w5juvAlo2OfTWwBBSAagY31+zB
         bOyuPir76CuNzsvcc59jRzmcET7YU4kIbWCv6Qv4bXve87btK7p0HvJNYKSf/IUxRPOC
         NtV4tVKT0kxmUYZJo7O16pzGGhDpzoAM/6klRYNuEuuV1prtexDvL+TMzjT15q75buNf
         cy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716927353; x=1717532153;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcEC98X5Tk9pufqIfKmfwp4sjab37I3AMWo+deVLHIA=;
        b=cWFvvHhsBXMYWCpmXFhQ8CJSlg9/9qMyhNHCW/jR+QjnHqvPzQuyGqMbaZTe4iXCyS
         h4I/0fzM1h84MvZe03IQV7mtXkR97x3tc4iLoynCQf2X8jXGNHTvbPUkpMZV6cJ3XkNq
         OXuJrdUn6FHKD0pIfRAYocfyXESsBcooP8DQFuz9F6ehXXQ6hgHdLbnnxYxwMHXpmSvI
         O2UpvPd9hBRJ6oQxsreymCnySzJqdFVNIWyHwqnCQehEs+Xd4Q+3DKalhUUHLE0X5PIT
         pGcQAigWokLi1UnMn5keC5ajIZGW4DxW6J7CFmzVn23h4xkt78jdOidJlbFy6sWkV15r
         vuvA==
X-Forwarded-Encrypted: i=1; AJvYcCUnnASyUvVAkCsJmQQzmdDJ5d0foY7v/Gy6i9uLp0Wg8xKUiZsZOJK0v815rW2ptqSSQBmG3MMtui9c9ltIB0MQgdQI47TbWqUUjMSOJvzy
X-Gm-Message-State: AOJu0Yx6EggUZ+eG/poWukYLowuImhY236ygjA4R/ZYC35F79xMnIH7G
	aBjsdgm7tSV/tqnLFksmJ+pLaQOE4LJ285HFg3zFFYxbptlhp0wCQ73h76LAW/Y=
X-Google-Smtp-Source: AGHT+IHYb7qIRYV/asWrKHIV/ya61hCaowBFPEvmv9j+QZakLOHdAIqnDpzGM7KC/Z0vDr+vQLtTrw==
X-Received: by 2002:a05:6a00:808c:b0:6f3:e6d6:7fde with SMTP id d2e1a72fcca58-6f8f3b3f89bmr18671384b3a.26.1716927352944;
        Tue, 28 May 2024 13:15:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd2d909asm7022593b3a.178.2024.05.28.13.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:15:52 -0700 (PDT)
Message-ID: <66563b78.050a0220.3d199.1e21@mx.google.com>
Date: Tue, 28 May 2024 13:15:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1
X-Kernelci-Report-Type: build
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.10-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes build: 6 builds: 0 failed, 6 passed, 1 warning (v6.10-rc1)

Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kerne=
l/v6.10-rc1/

Tree: kselftest
Branch: fixes
Git Describe: v6.10-rc1
Git Commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
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

