Return-Path: <linux-kselftest+bounces-11433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10760900C5B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 21:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F6F2830A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 19:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F1C19BA6;
	Fri,  7 Jun 2024 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="hchqnPml"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCEDD2EE
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Jun 2024 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787833; cv=none; b=RkD5SJpr3vjPppH9WI3TrdF6rK3s4WcYSJmvu4DaL1ZK4300ofIB/gAMMJa50nLIeUT8JG+t+8M+gJvuUpWv2qdvErpb0mzh9mNuVEKCSTzf16kkHcGWOBmAHjWeXYvuOMzqx7P4XYfJXXO0lO56mFE8Pm49p0/8GdMA1Zf5zD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787833; c=relaxed/simple;
	bh=YhVqXjhuxNu4SLjSdrgBiWw8ZIiSEzALUZspDWhoz8o=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=D94io5IygPnzM1g5L+8KkspZDe2X9wLfdJ+CXpBN2/upx0oB5y/mw99gl7KqfiSGgiBsEHYkkhLQx9GuwGL3H48hYGWNTZJBUi7tG0nXqsbJo0vfp7Aiuj5BesCjRbVb3dg36Pyjwm2sPbKA5Bu3C/1UWWKraOsjV6kp/Bko964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=hchqnPml; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6c3b5c5e32cso1821849a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2024 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717787831; x=1718392631; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dgxf1vQpwMY5Zqc5uix5eZDLGfSAviGI84SCnlkBAK0=;
        b=hchqnPmlTOX8EZTCc5CvjARaIIhtR3cgZ5Bx1F0LNCiBiaboWSev7E7tjVeFyUnTHZ
         KwRKK//IY2q6LeZF7lCLxs0lv5u2V6GuQ7l3v84TM7xiToGtF/Go/ykY2PTR84r1409t
         60+4r9nF74blhHPzbVhTcHmrMr5os1A0wqiKAOUKi7Bbsjo86rnSn+GKKah346eZFm86
         +L2j82Rnog/dNrUBao7mfMv9D0tRqciQU00epS1olESaDLbGfEiXy5SfHwibOVyRtKaC
         i6Jh9nimvvRf+Eq7yRO4XOb1BZLivxq9uJM5KNag49xR3q8NTj+HrgudvGXm6qn/Immz
         sMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717787831; x=1718392631;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dgxf1vQpwMY5Zqc5uix5eZDLGfSAviGI84SCnlkBAK0=;
        b=Pf82c5KIoCuPK1HNizTzf3uEjwee+xkQFqOJ4bWBlY7TeiOW4s2vRtV3gfmT6bgn9H
         fq6srZF8LsyBF+kfJut9dDEmhVxIQRFaVzcnjxqxOKEk96zV7SElkWF7FOjUs6dwxLDx
         AoPnVVbDjUvjttJYukO3s3GQVvA0VVZLLvx6vVy5H3NAtALfbaGyopHWz4t8eimyDNTG
         ntNon4XjuktazTV++auikkDt23vJHS5mp0ZHH4OZyjHd+iUGouO10tqH4b2LpXl1XWmV
         qlhbK0t863dmrISwUDodVKAmw1HmsOy0KoyUQtse8R5ZfS3tm2Le3/L3r719WCHHai8X
         cLDg==
X-Forwarded-Encrypted: i=1; AJvYcCX5dvD9/oAv04EF7qz6GUs8GiSmrTJWmmB2gXouv+fz6kI7TQXVyF+QQLJHafGewKzW/Twc0L0YucH1v3U7kQ4qBlsmoHsuL9KqG7NxrVG5
X-Gm-Message-State: AOJu0YxIb/JXFebzgMNGO6pkSsKyvJLYp2d7slT4a7axClFa/b/PMtcc
	+bN8yG+8C6kuiq5GiSRwN8/RrkjR+eqp8lOBt05TesMSj5zSInZwx46qtFFX0tutmhpld525dja
	y
X-Google-Smtp-Source: AGHT+IF1mZvZ2Iq/ptRjjQdmHWQN6OW4c1ZhM3Z8B37/JTG8x5fp96vCMapsW2jJjK6TphCrGb64hQ==
X-Received: by 2002:a17:90a:ae12:b0:2c2:c995:f348 with SMTP id 98e67ed59e1d1-2c2c995f554mr1836831a91.25.1717787831148;
        Fri, 07 Jun 2024 12:17:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c28067b192sm6062129a91.30.2024.06.07.12.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 12:17:10 -0700 (PDT)
Message-ID: <66635cb6.170a0220.da701.18fa@mx.google.com>
Date: Fri, 07 Jun 2024 12:17:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-1-ga567885b1ecc9
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 5 builds: 0 failed, 5 passed,
 1 warning (v6.10-rc1-1-ga567885b1ecc9)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 5 builds: 0 failed, 5 passed, 1 warning (v6.10-rc1-1-=
ga567885b1ecc9)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.10-rc1-1-ga567885b1ecc9/

Tree: kselftest
Branch: next
Git Describe: v6.10-rc1-1-ga567885b1ecc9
Git Commit: a567885b1ecc9ce739d128c9f2e5ef6369dfa59f
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
i386_defconfig+kselftest (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig+kselftest (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warn=
ings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x39: relocation to !END=
BR: .text+0x14cf94

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

