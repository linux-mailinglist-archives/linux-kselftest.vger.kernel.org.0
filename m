Return-Path: <linux-kselftest+bounces-5898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1208718B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 09:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEBDB23043
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 08:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763D04F1F5;
	Tue,  5 Mar 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="xuSOct8o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC254EB22
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Mar 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628871; cv=none; b=dRKquL5/wxm6f7TUmhaH4ujzhlpLBq4LUuTo05uLR4Hbu2Xmo4Barc3HoH0Qds2M8kI9sy42ZQovFFXQpp32Pp0m/gnDMLNO7mrAewDRGcaVzdvCJVUZWoKIWKd8/8BiJIqgGYC8VuszxusD128R074dEdEsUvZwcBefPRETXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628871; c=relaxed/simple;
	bh=EzC1Wa+cW3Y1R2bv64xqWV86DccbFc9zG+LQmHgCUJQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=qHwitbaoAgW/Guz+OJfrkgYgXvENnT87zHiDf5YN6dh53CtjbF7aqT7VpZP+WLUc0YOacb6J6pt71Nd1+WcT4TnR2cVVorCWlQFO/MkYF4eEl34b8NtxcqaabcSpXX+dEMBkdVAET8YZgQEh+gJLbslkCghccLzN5D8AcZHMTyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=xuSOct8o; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dccb2edc6dso44964485ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Mar 2024 00:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709628869; x=1710233669; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T66tkwWFGBRhSsMB7k4PgGRHuPuItvaN9jhUmQzHeL4=;
        b=xuSOct8oWlPvO8X5oPKEXY0joBXYfjvNsLKkjXcEymgeZ8Dbr8NofoQiY1LOF3ie7w
         G01d149jGNesyvev1MpN5NXfPN7GmXaZsURW55SsL5/0lMLN3aJqVYwKn2OLM3snOi1m
         EkrKBqvbQS5tdh9LbIrsY5OnYS7u740foF6oJg0u5nqTIc4eb3h+wiyxJDs9596iAbpD
         +yi+6vsQmaouzDZdhgaoCaC3vXyX6bG37DxH8ET4dlL4FE0Po+t4Xum7wB/DNjIFsLDX
         gNGQESApJ0OWq7byW9DkMMewFLW5jl2cnkOXl1YXNvT2tAUTF8JMOEQYaniZFRlq+iUn
         vRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628869; x=1710233669;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T66tkwWFGBRhSsMB7k4PgGRHuPuItvaN9jhUmQzHeL4=;
        b=wgoYrSyvqpniWg+gO1mZAstNb8qlTE/vWq36EL7YmEWdsRUW71Q6pi/zwd61tKYAKx
         rU+9LO/3fby+AuL/Af+6KgpG8mZZJ7oG8mdtkQyC+Mxp/CflwoHGnJNjL6itv9gG+Z9V
         e118/FkfgrpltIaXUqg3ulHradBJ95ETKJdn95NtZXQM+2W5z81Lgr6hDVIASD/SbpGQ
         /V5WU5lYFYnE7tNA+t/DmDx6gRuA+KRSnQPwWucziYGoDkbcTiOSXypDlchU9TBqnMxG
         X8qgQePeaLDd+jb01i2lLRL5YWondn4okLXTve7GaTp4dkf0xaLTXVOb6a75zS8K165q
         J1fw==
X-Forwarded-Encrypted: i=1; AJvYcCVW6xdgsPrSr8b8Y0DSwsQVhjByGy4vAIkqIJReua4VdA4UAEBYpELjauwX2Bmj6IQsYf2K2Lo2nogKCt+no2hewZ3r9Hu4jphaJh+ydRxd
X-Gm-Message-State: AOJu0Yz8PFniBsNGrYc/1OcQAORjDH10VNb5GRX8vYwz85hVcmQw7Ajf
	7MaTVoXSaw9G2w/1dZk3PdTjvSUu718aPzeUvV9LMT/PMssiTab3gPnSTe1aCgg=
X-Google-Smtp-Source: AGHT+IGT+nJSV31uXyGB/AAI3OJpXMzj0NRO5bjVSf6SLKzlBLyKqbdKS73gdt6PdXIEPChbEZ7sug==
X-Received: by 2002:a17:903:22c2:b0:1dc:b1b1:2176 with SMTP id y2-20020a17090322c200b001dcb1b12176mr1400856plg.11.1709628868994;
        Tue, 05 Mar 2024 00:54:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b001dd2b9ed407sm960024pll.213.2024.03.05.00.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:54:28 -0800 (PST)
Message-ID: <65e6ddc4.170a0220.296e2.26a4@mx.google.com>
Date: Tue, 05 Mar 2024 00:54:28 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-57-g5d94da7ff00e
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-cpufreq: 4 runs,
 3 regressions (v6.8-rc1-57-g5d94da7ff00e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-cpufreq: 4 runs, 3 regressions (v6.8-rc1-57-g5d94d=
a7ff00e)

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
-rc1-57-g5d94da7ff00e/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-57-g5d94da7ff00e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      5d94da7ff00ef45737a64d947e7ff45aca972782 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e6d2da785c3883f74c4388

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-m=
eson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-m=
eson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/65e6d2da785c=
3883f74c4389
        failing since 501 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e6d32a193b1e394d4c42fb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-s=
un50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-s=
un50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/65e6d32a193b=
1e394d4c42fc
        failing since 493 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-8-g94fea664ae4ee) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e6d5ad2738123dcf4c46c7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-s=
un50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufreq-s=
un50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/65e6d5ad2738=
123dcf4c46c8
        failing since 488 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-13-g67c0b2b52916) =

 =20

