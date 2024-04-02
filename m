Return-Path: <linux-kselftest+bounces-7006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD25895E8A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 23:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB961F27527
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 21:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B6215E5C3;
	Tue,  2 Apr 2024 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="lWjg5NMp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B966415E5C4
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Apr 2024 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092637; cv=none; b=p3ec0d4kdkuFutd/H+gu61ijwo6Lr5tDktxuVdTMesV/CGIgl5NEsNNctiPnnLs8nFLzkVKVbQGPKdDOOe8jooK/oR+HEnrwOILtHwP0aNO7T8KPNnMVVhmALU0auh7BlkKJknDT22lYPlCMM4B8RmXtLPplb/DvwpznRlrOLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092637; c=relaxed/simple;
	bh=EuC3dE64aqGiTj5+Qt8ts2cfmZkXI7waHw0OEnGFpho=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=YxnbLwqwcpJLGHVwPNVuPzcIk/tXShn/X39znZOsbLNYbk4PkZ4laeeSybEaAxUDum7KaikyYKwsiyDu8l6OMGqHhlW4zUlCQoDMkUUGuh3RyvqRJe4nQ8AQcw39ivnEiN7UEJ+NbDFyyQFgpTR72K+Bk8ZrlBMa6/FWZhsDt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=lWjg5NMp; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso3056824a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Apr 2024 14:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712092635; x=1712697435; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pzCANURn04nu5Dksr2CkKzWEAQ4eKn0BQRYNWWOxWEU=;
        b=lWjg5NMpwFNqNkozsR4U7byZ0nZhorivNTjEvKuUM2B9ItVsWWrkBnrWOr0Hwq9Fn7
         Q08MWF+49GIEVt9LXaj0Hu4Rw8uHkFD2QBq4lLQNxYm1QJw0+kFRjW6nxmBiGFSLHCXK
         jvMvSCwB2xWw8KG0+JOJgOYLtuWqV1599bXFL2hSsyac7y6Kpt7qQrjPJjbIPOHJAAYD
         D6vpA0yEChYR6Bdack977kRUxRfRUuhQiTQoOaqLdQCW5jKa3YZ4DuqzJypiuO6CVIu8
         ncZ/8QNN3jy/9BpH+p0LXqVv4MQXi6chOay9vci0OHj2H5REL5NkkTDTx5CkB8o412RU
         PZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712092635; x=1712697435;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzCANURn04nu5Dksr2CkKzWEAQ4eKn0BQRYNWWOxWEU=;
        b=FxwAFNG6h+Yi8iFa/r98pvmJssL4zMnXJEQAjyBGEqfGYFygjZe+mDoqK46Ijc4DcU
         gAi/hrJtL+AyUHGTtHjB8VMZfW5xdrWDMCGGwq6g/zS6KGWG4cGu3V/71vWSppmeeZ09
         l8uQ7tdtYuxkbzO/JEuS7DkohXLE4i0AS9sNEcp766nzoqKfZbRgZy4RL/+G1FYV3JKI
         7uK9ngGR6nB++VITYkzHCCASCLd9vyaG9yRBBAWDpjAtRYGUqK/Nyb8MqbFthVmsm9e0
         2lcGO3TGPnX/D5YWHi8jMY8T1idUBMCGOORwMEl3PfDl5jBGL004dNzfgb1HH3c80xZ1
         RVvw==
X-Forwarded-Encrypted: i=1; AJvYcCW+EgmL8Xou2mYe4Cq5/wm2YkoiEAyWGHpD5CVXwcvXjxmMQUd1BetfQiD9rzdaVKk77M5KD6djFTtmJoyd8iVZOwCNm4DpEga5XDRSKeFw
X-Gm-Message-State: AOJu0YyjMnpbg6PPrFqhppATvfs1S+QSE7ITF+CcwT+Ba6Ucg0AvfLYL
	/E3io8zUVpO38ySmbkSzGx2npD0m7Z9kpONXA46UYQIGUXqy1JESLPrz2Fz5xjw=
X-Google-Smtp-Source: AGHT+IFZ6thh/cbUltGMfZvrNLIzu87cERwFqDIlsw4lVMDKCqSHgq4pTlLFZiqHe4RN325UULLkkw==
X-Received: by 2002:a17:90b:1e07:b0:2a2:4f92:b1e7 with SMTP id pg7-20020a17090b1e0700b002a24f92b1e7mr3837827pjb.1.1712092634957;
        Tue, 02 Apr 2024 14:17:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c21-20020a17090aa61500b002a076b6cc69sm10144263pjq.23.2024.04.02.14.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:17:14 -0700 (PDT)
Message-ID: <660c75da.170a0220.f9f2d.aee6@mx.google.com>
Date: Tue, 02 Apr 2024 14:17:14 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc1-11-ge1e4db64728f8
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 4 builds: 0 failed, 4 passed,
 1 warning (v6.9-rc1-11-ge1e4db64728f8)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 4 builds: 0 failed, 4 passed, 1 warning (v6.9-rc1-11-=
ge1e4db64728f8)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.9-rc1-11-ge1e4db64728f8/

Tree: kselftest
Branch: next
Git Describe: v6.9-rc1-11-ge1e4db64728f8
Git Commit: e1e4db64728f8f43c610ca723e443f6caebf19b4
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

Warnings Detected:

arm64:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x149bf9

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
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, clang-16) =E2=80=94 PASS, 0 errors, 1 w=
arning, 0 section mismatches

Warnings:
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x149bf9

---
For more info write to <info@kernelci.org>

