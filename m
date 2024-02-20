Return-Path: <linux-kselftest+bounces-5045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D035485C1FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 18:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84589B225FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 17:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC259762EF;
	Tue, 20 Feb 2024 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="3cauF/ap"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D91C2E
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448758; cv=none; b=lvAND6VE6RIbAoZkAZK932oMCnVwUBAd+B2IRA+NAJ0SYdiJV1ssgWGuGWY47ltdfkML5zgmm8ITZD0UgbMWiABg71mvV1F76HrW5dcHhq4lhUkvIyqX8nBKaPXH9p7icp79wB3yi3pf07+t1KtsF4aeg7NrrI1SAE/UUpPBJMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448758; c=relaxed/simple;
	bh=IEevpCTRyr6Yrk83FEtRQRLmg8WxSefSxCtZseJG5zk=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=dKxLiTL5TDxSeYVrF0EOHOMwTMsxpW0bo0n7pVZGSTIq8wmjRGYk/KUnO4N4DK8jUN9if7XZt3rAJaOU1+31irvwzVO2IvaQu0gShWDPCZwvOeNoBFq/R8joJsyfEBNmBqqWBGUZeSqvL5y6lYawG1rfLS4BgZwnheCuN1pWBE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=3cauF/ap; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc09556599so14223195ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 09:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708448756; x=1709053556; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mHsO/b1g6OunzqG9dXwoedaKziPjW4pTQ3nMjpgFTg4=;
        b=3cauF/apO/mpbtvKK16QGrbeWsjhkB7GrTuJzDWDFbZyhl5ZeMdvHD5dwFh0c6Qflf
         HbTmH0h3n8fTe8cGGHSxymCNmf93dGRZMZMPbNZZuGY5IDKpTD240v/PcKLnNH+bVF4B
         bbiyGl4Qvl/REx/diTZ+S34FCWZeRJcP3RaaI7YKeHRi/sGfI7z6FhLoja0B5Qt/s0/M
         8mya3gd4pVpVyvHag/tqd1dxPblIk2ogmEIWLnQgmM+2eUa+5uu8FzFIRw3tKZHDdnQW
         dzoJBcsP9Hn8Iy6e4PLPA7x+uftytzqjUsUzdyBFfW9qfV2CitQei3Re3J1ZtTUFVFZg
         Bv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708448756; x=1709053556;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHsO/b1g6OunzqG9dXwoedaKziPjW4pTQ3nMjpgFTg4=;
        b=BR1w7fKQ3ceTyfjHaUwHe/db/BeqgzPgx394hpPOW8pj2RDtKcitRQiehf4VpgYlSa
         6zFHfB0BBRM8J2rdEjkNjrx0YkT8bjIuAcejbvZqSOQp8M8nbnuU8CKGVbfAnur5qsY5
         XTBuO0bxGDpmEJUuBCvub0wT67BaFnVVDXvZpBbOUrbkMAoO5D0ilbSqe09rsaFuR1f6
         bClQDjhZGwObWqaBLSMRJ8+JS7SjKZr1uSKrqApxsMv8LEF9M0lnuvjVAn/KSOm9z6t2
         +YKbycn0M9hK+my1GdmbY2ixPMCSNJg4d6vscUKC/pNzC0C6v5RMVOtkdNjKrZlo6ioc
         vi4w==
X-Forwarded-Encrypted: i=1; AJvYcCU9xzdnt3Wbgrhz9YqDgOtv2rsTvuiMS2YSCADDzP4B785+LlCC+pXxnM1r26PZpvsFK8uqXihZoldssJxvJBzdTaZ3ZaFraYX3pPvW++Cn
X-Gm-Message-State: AOJu0YyKRoB1jz/zCcrRBVpuBPNUcmXa/VbYH60mif7rjzuuFJhaMhKB
	u8iBq4vc1DEdr1736W+9oGeVY9US4muxIefNRTkTrFmS5ENrxhfTQsxqNT1TH2xEf+hUx8RrNzX
	Uadg=
X-Google-Smtp-Source: AGHT+IFJAyuIgEJhl6Eou2q6gr4KvaHcFJ7pVm19vz+CSggg6dFwW0nZZT5Urc4yAI3AX2PLTDofIg==
X-Received: by 2002:a17:902:ecc7:b0:1dc:15db:bcca with SMTP id a7-20020a170902ecc700b001dc15dbbccamr2819697plh.55.1708448756473;
        Tue, 20 Feb 2024 09:05:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090323d000b001d9edac54b1sm6551366plh.171.2024.02.20.09.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:05:56 -0800 (PST)
Message-ID: <65d4dbf4.170a0220.6f23b.3f69@mx.google.com>
Date: Tue, 20 Feb 2024 09:05:56 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-33-gf17d8a87ecb55
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 3 builds: 2 failed, 1 passed, 2 errors,
 3 warnings (v6.8-rc1-33-gf17d8a87ecb55)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 3 builds: 2 failed, 1 passed, 2 errors, 3 warnings (v=
6.8-rc1-33-gf17d8a87ecb55)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.8-rc1-33-gf17d8a87ecb55/

Tree: kselftest
Branch: next
Git Describe: v6.8-rc1-33-gf17d8a87ecb55
Git Commit: f17d8a87ecb557bc6c9770751c3f0aaf10edbb98
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

Build Failures Detected:

i386:
    i386_defconfig+kselftest: (gcc-10) FAIL

x86_64:
    x86_64_defconfig+kselftest: (gcc-10) FAIL

Errors and Warnings Detected:

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

    2    cc1: all warnings being treated as errors
    1    include/linux/fortify-string.h:57:29: warning: =E2=80=98__builtin_=
memcpy=E2=80=99 offset 32 is out of the bounds [0, 0] [-Warray-bounds]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

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

