Return-Path: <linux-kselftest+bounces-5397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8F38622CF
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 06:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4EE284E53
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 05:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF6C171CD;
	Sat, 24 Feb 2024 05:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="lQXmU4a/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736A14A87
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708754387; cv=none; b=armpinGpKBf4TsGJwdNZfSqgvTreB9ahL5Uj0yi468tuvOoP/zg43BfFnnYMPE2iPJDPqeXTI9b4+DUniDJZcaiNWyh/IU0j2M6UInG7phxJC1E285anup92Egjnlpir1j8bEjpjvP8DSV1PVVl9zQHD0AvbBShKZ6Hzs2Fh1ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708754387; c=relaxed/simple;
	bh=ZOZVeWlxqV60HC8p41vfLdAr0a9N42RUmtD0ZglPKwI=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=OLa787Anjqb76cEmPWxdXvlsb42SEG7GzwVZ/MWsKMVZqvp0OCpbjBcgRiTARykIb3f80iEGH2HCB7lgSGh/jsxN3Z3s4FFYVukqZQAE7Me/qkgIMnkPsrVmi8KEUN4KbQiltRYn3eZ6k2YIwMEVXoJ3Cw/Wm1TYEZ72GyqlUYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=lQXmU4a/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d934c8f8f7so13864745ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 21:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708754385; x=1709359185; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gg93pcD502e19mYr2kmGZCHWu/oAc3GAtvAbRKVyy7g=;
        b=lQXmU4a/JpX9i6qspq2VPZcHsbDMq6YmDldY8+o6S2gWQScBNx0Lz5Bh+GaBFYrtOF
         AT0lvuvWX6AbXZbygD0MsXYVBjdngTsLyVDZ/2as9CFUFWgO6VSRY1NEarbd1HNQSdA0
         CRJOVdUnc1nXouRFpv+L7jhn7qdyOzA+wzJJRQ/FYteqdF48x+HNQ8AxbjocCYxD+F6x
         zApkx5klvFqcx3WCoD1wUHgyuTsLKDewoz5IOUPNAl3c2qW4UCQa1XDJZWrXjEGa2erN
         L1fkpi1yRmSGfFM2gPuo7rhrGQVO7UfJF0MY+cyCyRsDVg/TNdON326ECNnfpBgwXZ4K
         qllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708754385; x=1709359185;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gg93pcD502e19mYr2kmGZCHWu/oAc3GAtvAbRKVyy7g=;
        b=XHC3nFwaFeMkesjQD/z4cawOyjF/NRiVxnBPTYpkmAwtl3idUS5gFa6i6SpIPLaU9b
         exVmiLHrrf2UQZslNa5B4X1sr55V0Df3jBI4+MhUbjvVOEdn9/mRcErpIAKisMpIDmdU
         sUlp9nVQ/BQqsID8WJAoGCxFvDpXBud3+DzsRIwc0YTdAgBHbUlwM3B4dvSVwnyKc8Jk
         DMtRtXajs5MpSBGMgb7wqqlVnkBYRGNbq5b+/yfaVIKQdCsrliiheQGltUxitCG+xZCE
         a52ELmJnqPGk978v0eBOip8ATG8n9LWRYcFivHLAE/sxKfXLfNfsHyAZ2sIHP1bv1TbJ
         Mkzg==
X-Forwarded-Encrypted: i=1; AJvYcCUszGLMN2kzELXXajQIaps1G1r9hzNLZZujrOhjvKfG/KEzqSsPHil+PiDbHCORbYqSDs73u6Xm9ofwMsuirqhp1erZifonuAk+KvbKhn7p
X-Gm-Message-State: AOJu0YwTA/rlhrGvELRx2mmt5HXopyHXQ69X4yGg//qgV95oZX2/LRWC
	y7OaPWQ5pK5/1oqPX5H7PaxsqaxaTWw3CmHYqd2rNgeyzqcz/JG+XzYwD/qTtUQ=
X-Google-Smtp-Source: AGHT+IEa7HZDlmnC9vl8h29E6Etj/PiI80GJnp5WZS/5//MmvboZQgThtkLQzKY566GR2iAxIywh3A==
X-Received: by 2002:a17:902:ce91:b0:1db:f910:98a9 with SMTP id f17-20020a170902ce9100b001dbf91098a9mr2280512plg.56.1708754384907;
        Fri, 23 Feb 2024 21:59:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902d20300b001db834a8dafsm345645ply.60.2024.02.23.21.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 21:59:44 -0800 (PST)
Message-ID: <65d985d0.170a0220.73c23.0f16@mx.google.com>
Date: Fri, 23 Feb 2024 21:59:44 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-53-gae638551ab64a
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-seccomp: 3 runs,
 1 regressions (v6.8-rc1-53-gae638551ab64a)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 3 runs, 1 regressions (v6.8-rc1-53-gae638=
551ab64a)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-53-gae638551ab64a/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-53-gae638551ab64a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ae638551ab64a216364a63c4ee5061f82702fde2 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d976fb14070ee888637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65d976fb1407=
0ee888637013
        failing since 491 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =20

