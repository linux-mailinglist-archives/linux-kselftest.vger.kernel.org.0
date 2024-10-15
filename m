Return-Path: <linux-kselftest+bounces-19785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F7899FB6C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 00:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699532865FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 22:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B86A1B0F3C;
	Tue, 15 Oct 2024 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="nX8lpuhx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967821E3DB
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 22:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729031155; cv=none; b=KTYYLX1IuYXtf7gUUtZUXemSZF5L3xW/R8yzf3uv5QihZEuezzcKdER81jd2O1U15GxZuFcRyuih7FKFuVVmYhVjWUQmYGvoOazbdmcX0M0NG3/jLZPa+GJ0Nx4YVNBqh45lxDv3N7mIshV57Z1/gQ7U3BBuhC1xBDMQl28pcG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729031155; c=relaxed/simple;
	bh=9w357J9OU4zS0/KyPEJrk48swvRl/f/CoCHuGFUgcaw=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=uDU4V9h6m2IwrICiVi6TQIV47+QvG9XNDxm4eDztJkAIyUm0JvcES7XwMSkcGSAMoVpLiisTKeyMLfNUDbGCjIqwXs68cLzNy6rA0Dj2hz31oIqzc4SqXumfRLbu7IoTCEdF6wPqvpuxmiGtLoMNOXVoINlUlf5AM0jvR8QazLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=nX8lpuhx; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso4325584a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1729031153; x=1729635953; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gf/G/5WibC1gKvtkb+uQwxvLojBulp8394cZhm1MxEo=;
        b=nX8lpuhxR69zA5qjvJ+9WttO9or9Pq/qnuLxDyXNSgE1AVCSahwNAKWgwDlKlksK4A
         ryMJCCoK/x9U3R4Dc0HEg6Vou9BTk2uCApv4duvHVrOI3PpsXIph4z2sxiVw1Lf9zYaO
         YUeEd8MepVf6GYi8IxtErE1bKAuaCPdnws6aK1z1kSJFSnJMoib08Bvo54GMPlsm/juo
         hkZB0/4D55APt1C1Wp4J6QMKtMV4Nb/+O8uNFFiEEyKG/UGIZGwu4xfDYX91SKzaM9HY
         llt1zrxVirySdSHJjDyXXVWI0PZ93w7uzLH70MAmZCRoeDzENnOyiiM/sgCZtb4oC6m4
         WZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729031153; x=1729635953;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gf/G/5WibC1gKvtkb+uQwxvLojBulp8394cZhm1MxEo=;
        b=LGY9aDvJm0fSfAOIZ1kF60gmxRpnqOgrvCSrO2C7uQw6fuGtFVy0OA3Ap9495Z6BYQ
         4n0Q7CnWG3UX4vksgbTPRfPJBUGiIRfEhN73dbIdpwmULFkYxq1ObDav9EA1GZU/xIYs
         ax5z6SF3HkrP4mq8nceAeFqHGJdRkkV9rwZ8LZ+cx4xLEp2MjnZCPaMUQs0lgwQwnDMe
         2wn+KQ5eZSL7Am+jaHpcONh3PaHytLETh2x5nyUVePR0OrsY10o60lKTb8YplF9yoOud
         gu2SNISH6aw6rWAki28I+TDJjILFWcIdvESqSEbCDTYn4+4CNThIUBFGKWxZoB2mKZSs
         zVxw==
X-Forwarded-Encrypted: i=1; AJvYcCUM4LmMHMxsmPvrhN8Z38MeVJmROgUkPxcAMlwO0BPghbN5NIp+LLBqVTg6TKYKzL9/5dlVBRqXEh3EzV0z4nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX84oXrkbsBWQUCB5jYqf8OX+WfCTrjyqKGPIxk4PNjXMTJnmW
	ipLXwUkpD+dIKhCDFymLVLQTQt39tXpa7yfZniWfZzUipZwN1ksgxGazGVIuz2w=
X-Google-Smtp-Source: AGHT+IECZ6NQ9N9wrnLDAdYFDwD1uc/OgwRhwCop3DJmcyp4c3mtw2BxUVyRZSgxg0ZjxGX5WMslbw==
X-Received: by 2002:a05:6a20:9d8f:b0:1d2:e8d8:dd46 with SMTP id adf61e73a8af0-1d905ec45f9mr1818951637.15.1729031152666;
        Tue, 15 Oct 2024 15:25:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e82a19a8esm14995b3a.211.2024.10.15.15.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 15:25:52 -0700 (PDT)
Message-ID: <670eebf0.050a0220.2103d2.0071@mx.google.com>
Date: Tue, 15 Oct 2024 15:25:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.12-rc3-5-gecfe6870abac
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 7 builds: 2 failed, 5 passed,
 1 warning (v6.12-rc3-5-gecfe6870abac)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 7 builds: 2 failed, 5 passed, 1 warning (v6.12-rc3-5-=
gecfe6870abac)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.12-rc3-5-gecfe6870abac/

Tree: kselftest
Branch: next
Git Describe: v6.12-rc3-5-gecfe6870abac
Git Commit: ecfe6870abac400036d802e28dde4822ec153ffd
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

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x14fd19

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
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x14fd19

---
For more info write to <info@kernelci.org>

