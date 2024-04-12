Return-Path: <linux-kselftest+bounces-7739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3884A8A2315
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 03:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5431B21E9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 01:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF12211C;
	Fri, 12 Apr 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="PnnX3tkr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C6A1FA4
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712883629; cv=none; b=cd+FLFXZyKNb318wvA6dH9e9C1UmxK4TWXDwGAOG9jzJAHy2y73GqEoqFvPheQeDhyd8ZxP1cPqGzcCSb+2Z5O3g6s14p1kLg4sZIHXxWYPyMB7wjVxnAKq2rlkvsrTOm1A/qTsDOf7ZKip5MKu628F3XQelC43slESEUNMXrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712883629; c=relaxed/simple;
	bh=Oo4Ka/bHfLIziW8hG23X6A3tC0x60QcKROCUgmP0PwQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=YYZITtI3spqylcC9kIjNgoYDBop+H3UwQDGgzWxr8OvnY/660AVTKXS9uvIjkiECG59II7YjBvLFJ7P8ANJA+LBvKVJOCPw4+vQKtQcs8KF1JjsayLG0X6R4/wrZXHfTz3k9K/xsk0+Sh3bwGm3ZEmtcxyXB4JwzECCZNsbtnC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=PnnX3tkr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso931617b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712883627; x=1713488427; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/22r7ki74D6edTfdtWYA8L8yLGW0u2JN9XU8b+vUbOI=;
        b=PnnX3tkrAdZiECTsNKes7QtYLsZ0ftRqbCeOVd4Y0DwDSisZn20sbAbDOKy+jpTy0l
         JOD/59qELOuz6lJbDWUBWKKdoxZZE4SnVC4yzccqe8IxkNYHRUTpQ0aJAbC9D6+S6J0n
         BYH3CXBe6J2Ajd4GXNxZDDhwgPOZQEPWIj1tF00WuFblRI3l7RF/6p9RTZbDbrX3vik4
         7Ij8cfZuIaSG9yWK8l1X/C5SZmgYegb0qfBxzPCI2TlXQfQTPtJ6qi8G0NWrwOo6riCX
         P03tsWCb3kvRbx7Uqa0pU1UW+LQmDgdbCzRwAicRpDO3dGoHKKt3d0deZ3+4WG89B2BG
         hd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712883627; x=1713488427;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/22r7ki74D6edTfdtWYA8L8yLGW0u2JN9XU8b+vUbOI=;
        b=QZxEGLMbKNuHbgl2vzePqxKBZZABLhdrKpXB+BVcr7xVPxiKQVFJEvokvSH0QpRIKQ
         7uihJ4zhpQSqvAtku/DC5syNlI3C3sixrydJs9yJirPU598dYxT80vHDJDqaGv7joiUl
         uHkWwWcAsOaEqMKmpa7qy3Vb7Q0f8JrYj/3RU68e3mlAb5oVUeajYmjx4O1zYHql82ID
         5KyE+6wPn/DderNPO4gIiTJrZtO9dZNr0P5tr52Xg4yvVj+uAE6jxnnnzzv8r4fJpGsN
         pzjIq3Ccypt9K90quul7SAweyuhEgPsKhb1coYgXpboGF71syBQx614Rs+tQF5r1WP6f
         b5rA==
X-Forwarded-Encrypted: i=1; AJvYcCUSmT8xzFGuUKQcZkONlWhfnANTMBD/HCCBv520TpIZcc2no5oN1GY/owbmHcoZ7wj/X2E1ZKlX9ETz70Q1gu6xOU8K/I5ELXEO+YEIKmgl
X-Gm-Message-State: AOJu0YzU+lx1sFPZsVaoauZl1zBwOQFRg6K8zzBAv9jqnGRhsZRfNAbl
	y3NS1HxnmDQBXUBmLu3o8Kcju1to3hOOo2R9Kek6pm6tWpEsUsEN2UJSVOBiY2c=
X-Google-Smtp-Source: AGHT+IG5Ix6rpgOqJSg4p8R9rNo/Ms7IipQi4dZ64RT6z/rmRwyRzKyh4DdV1lz5aTSW1MGGgdCXaw==
X-Received: by 2002:a05:6a20:e605:b0:1a7:52db:6711 with SMTP id my5-20020a056a20e60500b001a752db6711mr5047845pzb.2.1712883626787;
        Thu, 11 Apr 2024 18:00:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j7-20020a632307000000b005f0a5118863sm1662346pgj.12.2024.04.11.18.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 18:00:26 -0700 (PDT)
Message-ID: <661887aa.630a0220.c9d7c.547a@mx.google.com>
Date: Thu, 11 Apr 2024 18:00:26 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc2-20-g4f4ade6863ce
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 2 builds: 0 failed, 2 passed,
 1 warning (v6.9-rc2-20-g4f4ade6863ce)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 2 builds: 0 failed, 2 passed, 1 warning (v6.9-rc2-20-=
g4f4ade6863ce)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.9-rc2-20-g4f4ade6863ce/

Tree: kselftest
Branch: next
Git Describe: v6.9-rc2-20-g4f4ade6863ce
Git Commit: 4f4ade6863ced470fd33152dcf8ba8ae2534d8e2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 2 unique architectures

Warnings Detected:

arm64:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x149ce9

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
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x149ce9

---
For more info write to <info@kernelci.org>

