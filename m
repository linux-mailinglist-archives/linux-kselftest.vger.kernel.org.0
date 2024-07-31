Return-Path: <linux-kselftest+bounces-14585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE319438BC
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 00:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5107B22B94
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 22:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DA516CD1E;
	Wed, 31 Jul 2024 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="WBaWBTG3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872616C86B
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464474; cv=none; b=B+LwgHxtbtEqB/Iu7CACPS7XjpAiPablSsfDwZsSBnf9JxcgYjG0vpDLHwrRn/jmDvM937y6vSx4n7F1h/syoGa/715isLtQvsecEnt0zacTNfWLIDxi6tDGaY0BjPlyK0bS+bkY2W8e+vEPN+Ru1Tlk5WiXGeLwjuF+Hx06Q+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464474; c=relaxed/simple;
	bh=8mz3d+Bl5KLgqmY95BX5kki6MJ0jwTugUTa+vNnIocc=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=ZnEDst1Uqu8I+/S29EhL+uBGqkNBlIREDF9QSzrnPaycSGtjSh3f5xzbggjddeQwwZKrLbwxWbWoJV/JiJ0OMWejN5lhLoZ77PhG4QnCJepDJV2zz16HWuFTEkZ6Fza1alFnn40UbyBIqlmIRiC82D4cvq8gBLU/fO07t4BOjBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=WBaWBTG3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso4057074a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 15:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1722464473; x=1723069273; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wRmH4t0u8i/UnwhOxs7UmlAL/JEufHRGoySvycnSDX0=;
        b=WBaWBTG3fOZ9hGGLHcKurJzeohx9Gi1wPwkQ1bXI1023XpSBTT0WSD5hzcWQRiviYq
         Qp978GZ39NAv+Ul6Xe+wXM2volm3ryvS55+C09PKngG8YC+VNp/exJjabX4ZCfnqyt+5
         fQujc+fgPpIZhaLGRjI5cniJGI8+ovanPjyPmavm9ogHVuqex/BuCQWMLeydXCsA2FVH
         RvY2FyO1Y8Bx8xxbcpunegswonJDN5M5rykBFSiRAcwjrgCTjxFedGDfd91PXXnqHfxY
         i5sXtMDmeRpPsRumlwhaslAYXSezyzhrp/foQh0GjLTlNCjuhfmYlNTNH7hA+ms0Qmc8
         v91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464473; x=1723069273;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRmH4t0u8i/UnwhOxs7UmlAL/JEufHRGoySvycnSDX0=;
        b=B2nr9fLnYWapIRyg31IWsnQ3gKyhzhNhpSzufN98fDqWfUXuasWUdmtSa8QUmBxr0J
         WtDn/iy+GnKO3EFtQf7euID6K5WA95lKgoTO+OhNLUqM1w738+/N3OKu48LUTvC7O1g7
         4fR1bYtMQB/v1PViIaaxVl2y3avm9znb9ZRuqTmMdxtXxWO8H+vb6ZdsKENz7yvE6iGR
         2uO9u22FXgDycNv1nSBuOoEEi0L+QUImWezXXDwFGrLkytO2wGly6LXEW3a0fdnWCJOm
         ql8rKBM7A3UdtyAPTxKYKO6Lkjbqo27hGy9evVoHBfP65OsDEIf69lo3vR9YJiVwjP/n
         Yj4w==
X-Forwarded-Encrypted: i=1; AJvYcCXHH0OiEJ/uOdy7PefL0nhZjnj5b4zScWRldQilqOSonGC86lO7xwOZvEh0A/gzSdOK81rX3mTUw5cryVy3sHfRFpB63LyxOLAXUKaqoP5r
X-Gm-Message-State: AOJu0Yxx8wO8fgyMRB6tLG7mxmeIc1TC1YySkCohE+mt2TMwCDDBvnK/
	w1mFcJbaz+f09ikujeg4bFQjr2j9Fd5D0Lhph+q/tnLvzkaoyF+iodvmtVRw0zheKl9VVcul3+s
	A
X-Google-Smtp-Source: AGHT+IFmwygc3UL2Z5CGveznEA9ZbknOkn/4nG49auFhQUul8/Xir4yYdR5uC6VhzOCCmGEcQLbjsQ==
X-Received: by 2002:a17:90b:17d1:b0:2c2:c149:ca4 with SMTP id 98e67ed59e1d1-2cfe7b4c8b9mr759922a91.43.1722464472644;
        Wed, 31 Jul 2024 15:21:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf16bsm1856044a91.44.2024.07.31.15.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:21:11 -0700 (PDT)
Message-ID: <66aab8d7.170a0220.2917b6.5909@mx.google.com>
Date: Wed, 31 Jul 2024 15:21:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.11-rc1-6-g38cde27f74d8
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 1 runs,
 1 regressions (v6.11-rc1-6-g38cde27f74d8)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 1 runs, 1 regressions (v6.11-rc1-6-g38cde27=
f74d8)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-6-g38cde27f74d8/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-6-g38cde27f74d8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      38cde27f74d8bbe2f705fb1f80384acab9762e9e =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66aaadcdf1c97474547e707d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-6-g38=
cde27f74d8/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-lk=
dtm-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-6-g38=
cde27f74d8/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-lk=
dtm-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/66aaadcdf1c974=
74547e707e
        failing since 1 day (last pass: v6.10-rc7-29-gdf09b0bb09ea, first f=
ail: v6.11-rc1) =

 =20

