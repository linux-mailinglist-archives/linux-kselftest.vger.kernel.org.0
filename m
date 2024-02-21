Return-Path: <linux-kselftest+bounces-5150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB28585D3D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 10:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE02C1C2134A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 09:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB06F3D3A7;
	Wed, 21 Feb 2024 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="eS52OM6o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398263D0B9
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508421; cv=none; b=Dsew0yAgz/ZTL/CFtXROHajXwSIW/dInPPiXvrnETzTDS21u6JfS/vN4irdYstgRFjhMgp03vcCXOOdrXXghCEn70G3XEztNlC6LRoZ85K6gS3+cR98eZdVtFqM1YWDwi87ik8X5wiu1IV7uaUxk04yxa+2zXakhkLtOqOSDr+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508421; c=relaxed/simple;
	bh=4tBdjaqVHlOJtK4rLYTUaACWjBhsusTGGV+egjrVDaE=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=jIqc/lDrA7EDODRNEk1uMr81Ah3LWYyV5YM3DINQ+l38FN/gbQEgL9+FRN0Jj5y9GiMr72b7HKXN3aG0kvFKso4Bsu3b1WcJ8xwU+vN1WUgDTNNYIYbxV+qV9OkUxRUV/1O+yqHIFbTDVEQz/ZYKp4eEic1FmllfY4uHDF/uXp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=eS52OM6o; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c15b7b367aso49791b6e.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 01:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708508419; x=1709113219; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dS5frKrU0LBhFT99f3WNfR88VVqbVKxEwIqU6sae9xA=;
        b=eS52OM6oUSqJxPQWKGzSp8iQ2i4tBUXsuD/GtHkcbnbq/KoX1fK12iKd7g89A6bZG2
         FQ/onFLr4kzS9SqHHBtd+3SJtHUJL3wVOOIhZZt5IOCoYllu4nvu8X82a7hYcZQtimcU
         qg6uAjDWGkmiQ7tLK8RCTexT0e+v5UjZ+FlnADseNCEO6GdXly/ZaZTpzCB2se4XEzOM
         66YDWDTSzd4bv8smN873dPkarLNaYYWMse/XjGGxYCSXgkndmUmc9jNdfAOo1PPdpJak
         zaPkOPJQjnpUEURXrAU19QaFxdhn/MMeBzyKKdLZ9c/K0wqolgNtOXVdCU2H49SPuYnN
         pUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508419; x=1709113219;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dS5frKrU0LBhFT99f3WNfR88VVqbVKxEwIqU6sae9xA=;
        b=GKst+5CyFFOaJgMMWxulK6qJWbyBfV4Hz153Rfg0kaRENASspKQPj6y1pYyTxicdh0
         hkDCmBw2aBIY62JJYZIJ9w9QboV+aSxQR6V0oHonQManvW80EeRkGzsMuskSXxsd+YVA
         stsatie6hCIkpDf9duqXZDIH2RvimJOPzpSq/NcTRqNiylUMRSysOscnk5J51oWMvR1Z
         mSLJdMlFRlem8+pi1cakvEFm6IKzOEtDP1Hmk1Cy6zF4qKPtqPNpM1/WvJbjviP7EIuz
         +HaqAn6C3lcpVELosu8pn3vmird76OOYuQ1rU+hwKTVZqgs9nXudiyTP3ccKRJ+2DNjy
         KRWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMFbkidfda9wRBymGA9s+aWwHdpL7/0Z6s2QZWnUQ/wkxCg076+KC5mIgmT7IWm7ug4+2IDrx64Nw6HxUI1dEKgT0K3wwYOqsMDUmp1LzR
X-Gm-Message-State: AOJu0YzNX2hvbuBbRuAhl6jbTBmEoImqwUiEZFk05BaOTTZrUd2Qx27Y
	4rDnnqyGHRdDb6z3EBOb7m9F1cEsqCtKmefAZaO0+Zrz9XGpZPoB1kT7IeCZs+c=
X-Google-Smtp-Source: AGHT+IHLpWvCUi8mfbYjKwPpMv7+Lvo4sicmmi7X4MPXYDB5y/famIb5BcAZsffsGhTB0NQt1a1Jjg==
X-Received: by 2002:a05:6808:1146:b0:3c1:377a:48f8 with SMTP id u6-20020a056808114600b003c1377a48f8mr19526954oiu.2.1708508418653;
        Wed, 21 Feb 2024 01:40:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 8-20020a630c48000000b005dc36761ad1sm8120009pgm.33.2024.02.21.01.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:40:18 -0800 (PST)
Message-ID: <65d5c502.630a0220.4e520.8b03@mx.google.com>
Date: Wed, 21 Feb 2024 01:40:18 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-48-g6f1a214d446b2
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 5 runs,
 3 regressions (v6.8-rc1-48-g6f1a214d446b2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-cpufreq: 5 runs, 3 regressions (v6.8-rc1-48-g6f1a2=
14d446b2)

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
-rc1-48-g6f1a214d446b2/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-48-g6f1a214d446b2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6f1a214d446b2f2f9c8c4b96755a8f0316ba4436 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d5b99b494bf67f81637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/65d5b99b494b=
f67f81637013
        failing since 488 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d5bd7484e582dd51637038

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/65d5bd7484e5=
82dd51637039
        failing since 480 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-8-g94fea664ae4ee) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d5bdb0450a5e8aca63702c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-=
sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/65d5bdb0450a=
5e8aca63702d
        failing since 475 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-13-g67c0b2b52916) =

 =20

