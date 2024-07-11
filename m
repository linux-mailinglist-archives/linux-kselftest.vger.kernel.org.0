Return-Path: <linux-kselftest+bounces-13616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 523C592EF7D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 21:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDBF286F57
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 19:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F821662E2;
	Thu, 11 Jul 2024 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="MItTxizc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0301EA85
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725450; cv=none; b=gJePNIQE2tja66oC370A2q7q4nNCxGtJsU66cjHwzndguWf9FPqIbtntfRajdwtUbv+I1SgNrZaEvC7CmkZYUEJMkk4w4QJA0jFIYrwRzGvl0uemOm6GZ3yx+WdUSR9k/Vuhrtip2RK3M9EWgdTcEY57XIYdvIueBwzu742M+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725450; c=relaxed/simple;
	bh=hl0QyxJsBENw3ikw7NxW0N1Ferw/xs9FGPVXQ5veJjk=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=awbJcPzijKjVtN51tkoJzc4+OFGs5JC0HsNgg8k08KDRM3yxYd/IYHbuvx1G0k623j0Nn7Miz/tJKLnPNe3enhF0YdA0S2tqrlfOw69BR5fKOczTC0kRzq4+LAnjlHyGjmiikee0KRG0aRUnwL5ws6RJdXZnVL0woJeOUOy8nMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=MItTxizc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f4c7b022f8so9919405ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1720725448; x=1721330248; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L5x0r7uN3IppBKjeyG8cP7ObGUaLR4UntuONea6uQQE=;
        b=MItTxizcch+qJkH9sm0sq9pZoSrWtWY9Qdakz7djZLJAUy+hz03rVVAff3X0zV5Dg3
         97DgUzdTKYFIl2hDD1dcB2hYRUbeH/2k/zpv4FTUKeWnK2SefKaaRaBxQ8jULk+35l7b
         JOuq5p2ybrtJlpjMBAHIYzGKQVPKSk7YOupJvrcRcVLNKPchUxzPs8jlVPSikpI95Ubg
         UMC4YZepL71cp2POMJLo4ZV2Y/WgyD8o8/TiB2ut1uic/U5yXYH1LsnyTybfyIDejW1U
         1gsBkNyVT1ZOKrO3KuFXs6si/p6WAf+WHc9Ts44kq/lSdMdjpdso1cHDbO8jxllyH2Nh
         D2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720725448; x=1721330248;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5x0r7uN3IppBKjeyG8cP7ObGUaLR4UntuONea6uQQE=;
        b=bG4eVj9t6mr68lpK0ZSUewtbOj+SAzxPwiV9/Qj8Mms8GGoydDU8/SqPwW25iVvHgT
         8n3MZbaM2kZCaVIz6joEuln1E0RV9oo70Hdbwl2cZEbKclXN9WQLbmxih7BuyK2zPLsB
         SCYLz3UFFhskeKS7EVCAnCtea+QoNxR5Kyf7cCdBlnHMgyCMzS88oPaMUWd/f0XOck4k
         gm4sDSDRbbPQ16S6EuVdwk5Q5E0eNM3C1Q/jr+yUZuQMa5gYlM45+FH95USAqq4vnZNe
         PA53prpqjD684JdjuqfyR9HOUK6mjaDiXaVM955VdPRNmDvyeuhvcNcctnpW4tisYMTn
         EwJw==
X-Forwarded-Encrypted: i=1; AJvYcCWuOKznOCH/EvCZESW99AipLTHEcTcdV1vHv0XfcRyQTNifh69b9B7tWJTpynm2EQbIi+PxEopiGxvSOc/7G/osQ0aBKXW8+8gUkgP/knjL
X-Gm-Message-State: AOJu0YwfVjxdMeCIzoROYC/jBcsY828RAELxR6M/5tEN7WIIT2ii826h
	MkGcYLf6udnp5hixYE8p96yhBf/M5r2JzQpX1p4F1mOtNBxLGFy5Cpt7ca2qdtM=
X-Google-Smtp-Source: AGHT+IGNPU0M6va0K9w73xQ0A8JpXUaCJ07zYafkCfogJ68HmJGGrJGsfY05UTo0XH2iui5MKGkccg==
X-Received: by 2002:a17:903:32c5:b0:1fa:1739:89aa with SMTP id d9443c01a7336-1fbb6e95e6dmr81157355ad.67.1720725448106;
        Thu, 11 Jul 2024 12:17:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab761bsm54172255ad.176.2024.07.11.12.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 12:17:27 -0700 (PDT)
Message-ID: <66902fc7.170a0220.8cf39.9297@mx.google.com>
Date: Thu, 11 Jul 2024 12:17:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc7-29-gdf09b0bb09ea
X-Kernelci-Report-Type: build
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next build: 6 builds: 0 failed, 6 passed,
 1 warning (v6.10-rc7-29-gdf09b0bb09ea)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next build: 6 builds: 0 failed, 6 passed, 1 warning (v6.10-rc7-29=
-gdf09b0bb09ea)

Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel=
/v6.10-rc7-29-gdf09b0bb09ea/

Tree: kselftest
Branch: next
Git Describe: v6.10-rc7-29-gdf09b0bb09ea
Git Commit: df09b0bb09ea9775b66a5d24dc0fe0f86855efb5
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

    1    vmlinux.o: warning: objtool: set_ftrace_ops_ro+0x23: relocation to=
 !ENDBR: .text+0x14d3e9

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
defconfig+kselftest+arm64-chromebook (arm64, gcc-12) =E2=80=94 PASS, 0 erro=
rs, 0 warnings, 0 section mismatches

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
BR: .text+0x14d3e9

---
For more info write to <info@kernelci.org>

