Return-Path: <linux-kselftest+bounces-10444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F468CA184
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 19:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F3F2812E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 17:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBC6D53E;
	Mon, 20 May 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Mxi1aJTW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B7E13791E
	for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716227106; cv=none; b=gysiS+0fk6QjsDMwWXfAJemmdutAuTm3T2iTA2uIhyK4OOJZXkeV7YBm/zDiCkR1hvfLqV+yWLggL6AamDNiMcFyPwUgNkNpewxE9gqsvoXeaNv0Y7MSZum3wit+Aj9VrMxXxt+dUHtofnpx7Bq/0OvSLhJe3w0nA2xFA+Nf030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716227106; c=relaxed/simple;
	bh=NoF8Epxk+kPwoFDdVNCmSSKs5A0z9ukazRXDjetP+iQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=VXTEeUlc5iXvFjstDRyx0WrDEg+alv4pH7Br3Yum55/1UzSPLh5hv4/ccf4QjphRjRFs0BzvhZhFAIya2U/o8LltxgkQKtwkxAbFWJXLaDS2YVWHEfmBc7N0I8nlI673A3aWPprVG1he7uHjZIxb5Gx6beCc0iLW2YtqeOz5Y40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Mxi1aJTW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1edf506b216so79013955ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2024 10:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1716227104; x=1716831904; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WYOAib0im5YAIvaoLC4Jwr+EZhyCaxWhipiU5T6Uw8w=;
        b=Mxi1aJTWHuxctKS6HMqgvuK4a2A6PFTfwT5xQdjEpJ/bIEFd0FyazEpTUnKSYaDjgG
         B3W28FvkGGbNBWfi2qchfglF5lCiEz0Z2YPOTDu92NGT4mdE/9gn3iugFF1U8BJOMOWT
         pS2eI9Gj3fynmBQWvF+VnNt+ep2XkP9veIUKuzPwRH8lU7x3otLtNebJjU65wvNGCgxh
         k6oW1gMlkl1Xummo9iNFT970et91jcrKf4S597cbatMKF5Yd9d6G6j/UxYBkE6IyHxBj
         PDDDJk9r3C8nr3XPiDXv4ZgECe5A6zxUZsac2Ew0a6w2CfXmLE8ikrPRFDj/yoFUn7Ib
         xNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716227104; x=1716831904;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYOAib0im5YAIvaoLC4Jwr+EZhyCaxWhipiU5T6Uw8w=;
        b=KmxJyNOu1xojwAaF0Dv2WZvONIc7qqeiFVcyl8YxZGtvLwJCfHpyOBxPd2g0Uo4dto
         APs8V/1K5iyNLnVbwR0nZY0k4AKUr4eN51yHSjAWFN5UKZCihkEevMaMGwcVn+1wPzg8
         EHw1yXeBDMNhsYTglUDCUy1R4Ws8axU2lWbKuKUHNhF/p9i6u8cTYOeiYaiw/dZ5FQp+
         TkbL2Lij24Ik2DHHHy3Q4vzVByjUrkDZu/qE0iKSzZkuIyZBFx3a7U5mra0jqZ3UYv9K
         rKu8YtatKFkzFRFwopFRVYOo39Pax45WQ1o3cH62+2MrL8pLDv/+WQWTA72IgMeppbzf
         fi3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIpaaR1fEajOCWefy8Fy+SQJMX0O6a2R8+Ju+yEjUCGdAoPJA5jP1xEzDYNJWY/RQia3twUVLZkVOzLSzoLRXbXvVllIHrDRhRrOdTqI9l
X-Gm-Message-State: AOJu0Ywq3g4DRZAxzjsXSj10VFhlngBYt/b+WqCRwPpGoR/b55TbFnGY
	2L3gvNSL89tYO8ABPqwo6aca4NXZlTB2+NYNOvb43764Yvv5GUEq/JmfFgPUBR4=
X-Google-Smtp-Source: AGHT+IGSP83LK59lDrAUC06K8wYy4cJVLkLalIosHKTaUDb8DXNLIvnlR9bUemvrM7Ajwt7gOq2SbA==
X-Received: by 2002:a17:902:7d95:b0:1ee:b2ff:c93a with SMTP id d9443c01a7336-1ef43f3e4admr280919625ad.40.1716227104077;
        Mon, 20 May 2024 10:45:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d164dsm204987635ad.52.2024.05.20.10.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 10:45:03 -0700 (PDT)
Message-ID: <664b8c1f.170a0220.5691e.4a83@mx.google.com>
Date: Mon, 20 May 2024 10:45:03 -0700 (PDT)
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
X-Kernelci-Kernel: linux_kselftest-next-6.10-rc1-fixes
X-Kernelci-Report-Type: build
Subject: kselftest/next build: 4 builds: 0 failed, 4 passed,
 1 warning (linux_kselftest-next-6.10-rc1-fixes)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 4 builds: 0 failed, 4 passed, 1 warning (linux_kselft=
est-next-6.10-rc1-fixes)

This legacy KernelCI providing this report will shutdown sometime
soon in favor of our new KernelCI infra. Not all tests are being
migrated.
If you are still using this report and want us to prioritize your
usecase in the new system, please let us know at
kernelci@lists.linux.dev

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/linux_kselftest-next-6.10-rc1-fixes/

Tree: kselftest
Branch: next
Git Describe: linux_kselftest-next-6.10-rc1-fixes
Git Commit: a97853f25b06f71c23b2d7a59fbd40f3f42d55ac
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselft=
est.git
Built: 3 unique architectures

Warnings Detected:

arm:

i386:

x86_64:
    x86_64_defconfig+kselftest (clang-16): 1 warning


Warnings summary:

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x14dd29

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

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
    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to !END=
BR: .text+0x14dd29

---------------------------------------------------------------------------=
-----
x86_64_defconfig+kselftest (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 war=
nings, 0 section mismatches

---
For more info write to <info@kernelci.org>

