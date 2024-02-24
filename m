Return-Path: <linux-kselftest+bounces-5399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDFC8622D0
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 06:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20DA284FE1
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 05:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390BB1755E;
	Sat, 24 Feb 2024 05:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="uIofp+T4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BA0171D4
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 05:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708754389; cv=none; b=TRw2P9f9okuyAkVsPlVwAWlrXM4WT91tv/sg2ckHyV2PhH2tND4rEPmQ7HnkmyQXKUK6sL1yOPqzPvZg0hn4xfU7L8hfQWrIb0Xn0LoI/s6/J/Y0xfyUAJXbFyHj1eAC7HimSzsu+R3qJmMuIYdVwSkUgP4DdCm+JIeKScWDsV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708754389; c=relaxed/simple;
	bh=ALjHCiIfQO7Gp+WoS1O1TrDhjew54k5REEPodqmfEog=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=BRdEDaSicuYHuB2klyT6Ll0zLRZQ0eavEX8ToMA39z7Tze4vpcIqNtLgIX6PJIkCQMuaK6riw2cX6UE4DBYfU40eTQhOZULZcB1IFoWlB/fIQYDFZx4LWprIziNdV4S2ED3akTqNdRe6s8ShJ3dit6Yfaa8StN7vRXrvcs+QqLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=uIofp+T4; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-21fa872dce3so641590fac.2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 21:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708754386; x=1709359186; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jPxCbdStOR8qv6mHdhdvXt77spki8NKYjMTSGBfDcr0=;
        b=uIofp+T4QxKh5WBdrlapR1lBXRY3j9kLca6uo5mT7mZ0fmfPSFuLxyOLUn2h0VD36C
         XAk6X5i30hCK+97uk8chwNkFXyFNy+MBh5ziU6RpNrKYCO+vJzpwE8a9A8Xa0/RpJ2A5
         jKhrpKJ27tqdW1wVJ96Nz4LQPSycbE0ebf/Zx4b0YgXPNQO3wQc24/TaVFiykBLIP1mm
         G4j/zFc4+H74npEcuM1zy0IPHW1NBVsyhdejlF6zITQ7Db7XdDsPr9vEDw6lC3ob5qlR
         2Law09mhKLHgbWqb4X5hz/54CLPUgeCOwKc2IwL2UdVzYn1G84mMhV+d6xjJRsKLfQ0V
         4lCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708754386; x=1709359186;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPxCbdStOR8qv6mHdhdvXt77spki8NKYjMTSGBfDcr0=;
        b=iR543qfszIM1wdXRsAKY1XUgYwORt6rfXWkn3TsOzixNrhCFIkD98j4jL4lOTe6UsQ
         rFZZfX1j+TfNFNTRq6abkZIyaiSAmvOr9wwIm4XgO/+uoG6+l7Ni4nuVMEHdSB/5X9dD
         AWB41V+sOBywmmMorzdGwZ57QpbPK8ecMmDhUH+jWP8aaKxktBcTPuNmC3h6pgU9wpwV
         sNuGTOapPUPwRyz2ZBzmIGIJv+aCQ4nT4xbAneE8tz/dcYenOS1iTFYqbso75nAwBIQK
         HPg4bwrLO7ESxqQMF1EBFMhvCK9xew5jlXTyCyNxOoya9SGINBgn+m6gq6SDnEeBthSb
         9+2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHasYyifI5u7SeWzcaEbex/7IMe6Z8c/xo5Pt5hnfBTAEUf2MVhFYRvOr+c1vNQ+GDEGjqeApRY4NXJNq0nSwFykcdOpU9Bp7GUzL09StA
X-Gm-Message-State: AOJu0Yybh7y+L1EclHpmkwlDgC4jXRUFLBZCUxxvHiLdwiMItXo7U7Iw
	xuPEoCKa5PasjBJOypWUh4b2tcGyaK+4S23xt0lRXuAOmqlOkCMc2G2Vv678gHo=
X-Google-Smtp-Source: AGHT+IE79BrQlVv7JTAI2g8pYY28qZgBoMP0b7t5nLIzdjWHNpp2hH9lQyguRZS/2wcKf0DtE4U27g==
X-Received: by 2002:a05:6358:7e54:b0:17b:6171:ada8 with SMTP id p20-20020a0563587e5400b0017b6171ada8mr1692873rwm.15.1708754386562;
        Fri, 23 Feb 2024 21:59:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q21-20020a635055000000b005cfc1015befsm344917pgl.89.2024.02.23.21.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 21:59:44 -0800 (PST)
Message-ID: <65d985d0.630a0220.b72a.0e47@mx.google.com>
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
Subject: kselftest/next kselftest-cpufreq: 5 runs,
 3 regressions (v6.8-rc1-53-gae638551ab64a)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-cpufreq: 5 runs, 3 regressions (v6.8-rc1-53-gae638=
551ab64a)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-53-gae638551ab64a/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
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


  Details:     https://kernelci.org/test/plan/id/65d97834d30971079363702a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/65d97834d309=
71079363702b
        failing since 491 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d979a0055546e10f637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/65d979a00555=
46e10f637013
        failing since 482 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-8-g94fea664ae4ee) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d976dac8b1d2c64b637023

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/65d976dac8b1=
d2c64b637024
        failing since 478 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-13-g67c0b2b52916) =

 =20

