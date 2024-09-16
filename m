Return-Path: <linux-kselftest+bounces-18047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C00F97A7C2
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 21:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42374280C77
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 19:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97390136664;
	Mon, 16 Sep 2024 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Qp/8BprM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC42BD08
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726514500; cv=none; b=TOlRkTJHhX/rYZa8HT8DiUBOPrM+V0T3gpFFLKebLp2JicbnrrF6WrzOkDrHdm/ujG5tJIin4aB8XVnwrwZnQYmq1A3Bq1ZqLZbIMLqmKxjSOlftQdhKoz2jpJcGddQsCwMFPnLqcf70JtdJ3RR8mE9fzR0A+UmxkQCtScS46e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726514500; c=relaxed/simple;
	bh=dxlyuWb21RhBWBsGkovDC8xCd6fZLGR8ciLS2b/SHR0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=klbjgwYPAb1/CrfATZV+xqRTRv82UdGn06zdbcOJW9Mkm7GXytWoX0vnN95IpU65DI11Az7joIdYq6cOT/hvBq+Wv+XQqHdAP1YwhVCtuxGFNiYrekEA3UlXsb2o0f1Vi43aEBIw78Kw/nSb9+XJCpykPT9Q5hTvBO5l59e0SY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Qp/8BprM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d82b0ebd51so1209261a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1726514498; x=1727119298; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hPRHcTflp2G9qK5HRxPVDR5TeX6mwgYMCW0e4Dm8PCI=;
        b=Qp/8BprMALfJBoDvjJ6uqh/k7BSjL6MtzkQbFDQs9t+gIN626jDnP33AxBaishWKee
         I23hRSiKClR9aOnZ9L9a/RqzgNqApgu0m0nd4fXPuwWIZ0TY3URJE6XfEdWNvkkoLelC
         DJ9YB+5yDevT8OPaX1DzNJXshMh7IcKO3XgEjphM1s7TPo611O+HZx7jNZCVQ9q306Zu
         Reo2IZugtWM8WOiDaCvN4rwr09Az1cvcacVSrUM2fTUxat5/auaTsn7Vo2Ipp2Zmubjr
         ex95HgjS6rQNk/aMZG7N4iN5NsBu13SMMUOhtP6XRing5A1tBQSlmWUltcAtBq44Iy2d
         J6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726514498; x=1727119298;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPRHcTflp2G9qK5HRxPVDR5TeX6mwgYMCW0e4Dm8PCI=;
        b=Dhi6PGZhCAaPA52Ib3qPJDe5dTHNAvZj/PO6P5JG2r4EEuSy3EuwEGuXpkxHHOVYBz
         Te74SMteRCmfL3YIONZW3fq9akgv1sFUsuKk5pMqR6jSDUUUS2a742bOVhZ43yNccqQP
         TlGAnXRM3a3TLxNI67uUCPYXZvzeWNpsSzDdPatQsduRfE3pMiYfhMr9sCX4QfHwl2AV
         /fwNs+Olrx5g2Tg/GyYX02tj9eiz04VNY0Hou7dkE9quD8f/t0roaO2YfPc5udvI46eX
         KB/mtZFt1sqwHLTXVSUlIFdS8m9XUPTvkzT7LUaqMokaxcABQ2oDabf1eC24UEUSq/uQ
         B/mA==
X-Forwarded-Encrypted: i=1; AJvYcCVbmY8jBmKZFhTid0qLi7j8dqIRgnV2mg4NrJ2a+z/KnER7I3P7hYOeIXPLHPgYfkkcgiqmgd1fZesSyvMdKsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv1k6GFG3sD/yWqHym+gnnOO2//JezcHbEFMy0PQ0xmn1z5PpU
	1gilgFDQ6kY34pCmQodr7M3+qmow+o7upCBtL0EwLbfDBeGi4MInfTHEPk6XqEg=
X-Google-Smtp-Source: AGHT+IHfH0G3lZD3OkseqhYqzkvX9VjthIY9I+34L3b7E7vItz/eKb9f4njyh5Q7dsTTxc3EoashoQ==
X-Received: by 2002:a05:6a20:d80f:b0:1cf:3677:1c63 with SMTP id adf61e73a8af0-1d112cbc340mr20226119637.25.1726514497775;
        Mon, 16 Sep 2024 12:21:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b110sm4074355b3a.134.2024.09.16.12.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 12:21:37 -0700 (PDT)
Message-ID: <66e88541.050a0220.2a85a3.d326@mx.google.com>
Date: Mon, 16 Sep 2024 12:21:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.11-rc1-21-ga0474b8d5974e
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 7 builds: 2 failed, 5 passed,
 1 warning (v6.11-rc1-21-ga0474b8d5974e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 7 builds: 2 failed, 5 passed, 1 warning (v6.11-rc1-21=
-ga0474b8d5974e)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.11-rc1-21-ga0474b8d5974e/

Tree: kselftest
Branch: next
Git Describe: v6.11-rc1-21-ga0474b8d5974e
Git Commit: a0474b8d5974e142461ac7584c996feea167bcc1
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

