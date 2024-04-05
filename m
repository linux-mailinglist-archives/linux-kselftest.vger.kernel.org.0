Return-Path: <linux-kselftest+bounces-7238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 132368992C2
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 03:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C94F1F261F0
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 01:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21967484;
	Fri,  5 Apr 2024 01:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="wgQzha7+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2F2B656
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 01:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712279859; cv=none; b=JHXbkrAl/xa0wjVYgGhRqgioI2ngbh+On4uI9wmUkZSMKNIK6ycJ0aVq1X+8LM3s4+ZccFi/w78qgimHjANvDeDofZPdzC+A7BzFqKOZ6F2cyhg/wNNe6Ydj7uEGekRPIe+zlXltKVq7gIqh9tkAyouLU7N+EJM2y5lE6ekK9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712279859; c=relaxed/simple;
	bh=BeKYb1S/l0TCg7S1UUgvvk2+p4rAMm7nJ2gi4BIWK2o=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=mZ9mnHYzFoMO0M31HLchXKwYzMVId/nAZwtwSvMhZcprs8iCk6dL+Yp7EYPic0dS85WSbxKQZ3UWFGmuBnOdH+sIyFRSVrX7H9k4L1DTpjf8g7aPCsWwd1xU8DB/DIC++E/kbjf9Ka2oCNRkkSgR9/Q+OHRtcEDxIh+GrPGIkpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=wgQzha7+; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so1408202a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 18:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712279857; x=1712884657; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ySLu3+VCgSa4y1+6JNWG5F6rDa9KmS87zhhWEFxbViw=;
        b=wgQzha7++IdGVAVTEQoxmh54NN/ix+k5a2LgPcYTk1crujgGIaQ+7mUT+oGrjklyTQ
         PFSN+qbq4Bh7ei+dK6CS3YFSGhZaoUFdErjYIDifnDwwUX4zRyE00HCbTzBsYLH0U6sp
         1DZoKerYnuHHaZDfzak8P7JtqcPVurEstoF2kBcMhrps3V7w5cV7VyyMxw9gcQH/aTvL
         RriyX3FNzDAwaNKVjafKChQcqcrkwmKW8W4IRpqg4//+pqoGZelC6CNlir8U4MlEYrd/
         kWePjO7zKK5D7luDVOb+oB3y6TN7r9XfT5nD38N6byFuIiIyEovMjiQSUjaVOrRHeyGH
         TXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712279857; x=1712884657;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySLu3+VCgSa4y1+6JNWG5F6rDa9KmS87zhhWEFxbViw=;
        b=V7a4UxH7zaSFsX1n3yBt/p99TKy498zLavx5s7HXOx0+DkukQWU2Am3RorkN9RLZc7
         JCUIL6VuZWo/hxvWXV50CGnbp0L36ZMlLip+iZ2Cm9vtEb34sVMtxeWrMMyC/BHsvVxb
         Aar+/W7NodW5ud4swjfcQsqi1wmsWnu99gVYeS7xm9CVlLGlSh6p66iGa3urx4D3Yq9f
         i46kq/EmPX4Jbhq2GicYliX3Wy6CtAshOuyACCLrlEx7qAgMurcXE1eFWoJRQvKp5AL8
         oeLC+O6LDomrcHjXWe4O4aOWa+CqqbDbUuB2xElb4nLG/iR0/WwzrrOcjCnuSS++s1cS
         wp6A==
X-Forwarded-Encrypted: i=1; AJvYcCVQTCbeQRX30UZW4W7yZjXV35adx7+muxKlqteYLlhelVJ+Cu3kdZarF7aNV6GEWPlBG8m4rmsBr5aQjAvi+MDoi9WPJ29A386qi89vpp0X
X-Gm-Message-State: AOJu0Yy/OUKHsf7RYO3+nFIQ8kdpzfg1HK3h2NYiejXWrqayC1Qobcpx
	jq1ASCmlnMxJ2ULJHmdd83okQk84LfIAKZViRWiquJggG5yVKecW5QLHF6GsW3abobr3wf8esFT
	Shfs=
X-Google-Smtp-Source: AGHT+IEXWFg6Ikle70HSisdzP0VTRFiWB6XRBrNySso3HfA30Z41ytQ8Gj2FzzOgj7pq+GIMVkmUMw==
X-Received: by 2002:a17:903:124c:b0:1e2:a467:1b6b with SMTP id u12-20020a170903124c00b001e2a4671b6bmr97688plh.16.1712279857524;
        Thu, 04 Apr 2024 18:17:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902e30c00b001e290812d49sm279275plc.226.2024.04.04.18.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 18:17:35 -0700 (PDT)
Message-ID: <660f512f.170a0220.3dde8.1825@mx.google.com>
Date: Thu, 04 Apr 2024 18:17:35 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc2-14-g4389636db356
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 5 runs,
 3 regressions (v6.9-rc2-14-g4389636db356)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-cpufreq: 5 runs, 3 regressions (v6.9-rc2-14-g43896=
36db356)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc2-14-g4389636db356/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc2-14-g4389636db356
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4389636db35667bb5d59422bfdfb3c876c3654c8 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/660f44bc14e1b49c674c42e0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc2-14-g43=
89636db356/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc2-14-g43=
89636db356/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/660f44bd14e1=
b49c674c42e1
        failing since 532 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/660f4826ed64defab04c42f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc2-14-g43=
89636db356/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-s=
un50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc2-14-g43=
89636db356/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-s=
un50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/660f4826ed64=
defab04c42f2
        failing since 523 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-8-g94fea664ae4ee) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/660f4d4e9095137a934c42e0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc2-14-g43=
89636db356/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-s=
un50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc2-14-g43=
89636db356/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-s=
un50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/660f4d4e9095=
137a934c42e1
        failing since 519 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-13-g67c0b2b52916) =

 =20

