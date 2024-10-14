Return-Path: <linux-kselftest+bounces-19649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3097399CAB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 14:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5421C21514
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 12:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72241A7275;
	Mon, 14 Oct 2024 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="qJwJ3ERg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043E15C15F
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910329; cv=none; b=V7TJEJAtAgcIYsZYXUsrHHXuPQyg5WX39lFpPHQhlBAhiewvLNNqCl8Phcz6HRumcpsqhRuqIAD1DTDda9dUTs4F/jwg/Ekl5K7BfGMxLBs7hzAvSEjEA/+s6Evxsxypzqt12EzTyaJIGhqRS86kVCiH/P4D4UpHKbuFGAvAYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910329; c=relaxed/simple;
	bh=DPXN5RlwwjIo31nobjOvavVgLjbNsv6ENCkH4O9rjG4=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=pDMpBYCM/dKeA8TF1GIKYvcblKqq/T1ob8+N12KTsNI5Sct6kemRPN2D2nRqmV732w2BIz3dl6tW7M1nUEITrIvYjd9rZE7zWsmsNtpy9BINwOKtckuHYtIF/Al/vbycBaTLj4mlumXH8W4+kBixy7OroYUpEfLzhTuNmPsA1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=qJwJ3ERg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-207115e3056so34333785ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728910327; x=1729515127; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W0fr1CSrUmn0aM0JhnwUVlx0yfmfb5vyD+ICrGEnOdM=;
        b=qJwJ3ERgQz7LzJYFiUhP/7fMBB8gGYCRkuKXVlMxxH47o43wJbC4zpW7haYoFMcXZY
         JVOFsCYdmVVqIF5qxiyd8voOHvj+KwNi0BhC6SKJUzyIi2Cjz+WSzJRs8m7Oh1A7JmO0
         jpQKt4PcBfZ+YyeDHHkYpHwNA8ykgIhX3QREloQ/ewP6aGghPg8QFycz419Kp+6Bywp6
         m7eN3t0HVc+b+I6ZvKpZa5xszGigRE17djMbJehz4qpbkLLruG8Z9qXtKKRLSGtodqOa
         /uac3iLEHaS9Tnst/goLn6gHzjiUH0BzUbdlduFYb/LfJiXmctAIpB+BPgus9YcZJyA3
         M9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910327; x=1729515127;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0fr1CSrUmn0aM0JhnwUVlx0yfmfb5vyD+ICrGEnOdM=;
        b=sgN4rFvszDQW5Q2ozO7XGtBe7OQ2Qp/zsiinyCZgEzno4gqI+h6Yo1GDOmvsr5n122
         hmrnCA7Ckll+LwsUY11B/UxnRRmfMEGmXy3TfbWxOntffS8p3WFtc6v1SpVw4PL1+ycr
         6b0emw849qHKfBc1CC+dNfO3BOAKNZx21xkgn4Ct/lSvuunsoy0rgZOfSFWIKJMpHgfr
         dwpEQSCufQtQFvCeZ0wj+kEKlnj7PvWuqhND4MTpMhJD5b7+7x6PurP7ZtHXC0ZpTCDd
         4bobY/RBOfcdY6nPWI81jFGykLlkCa3LSE5hhJW1QajeIF9My5GgOBTAI8AQ91zGCqic
         402w==
X-Forwarded-Encrypted: i=1; AJvYcCW6AiFCdpWxtSn3bD7+9MGljqE7IHcm9cL43un1bZ6wBef6lgWvRzew+F7aD2f+BbENVzoS+tG6yenFc28z32o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+mZKW+Ch5iT2bb5xNKpBg6TDiNjrOwoLpC0NdPJbClhGIXcRI
	6H4YNVh/h0L7PowC+GCn+IgH51RzfVu4wlvo2GduvFLRkaIDnNV6K7GezB8d7GILaGSLojU6hPf
	r
X-Google-Smtp-Source: AGHT+IGw7QSxFahJTtSWi2o1bGRF8rkMYLWtvDqq6pbSdpgx0L4CxVmDDFzNEKx70vc5zzrfjFO+FQ==
X-Received: by 2002:a17:90b:3b8c:b0:2e2:ac13:6f7 with SMTP id 98e67ed59e1d1-2e2f0a4d6b8mr15066803a91.4.1728910327439;
        Mon, 14 Oct 2024 05:52:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5df1eebsm8918375a91.17.2024.10.14.05.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 05:52:07 -0700 (PDT)
Message-ID: <670d13f7.170a0220.2f4c71.8868@mx.google.com>
Date: Mon, 14 Oct 2024 05:52:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux_kselftest-fixes-6.12-rc3
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-cpufreq: 3 runs,
 3 regressions (linux_kselftest-fixes-6.12-rc3)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-cpufreq: 3 runs, 3 regressions (linux_kselftest-f=
ixes-6.12-rc3)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.12-rc3/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: linux_kselftest-fixes-6.12-rc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4ee5ca9a29384fcf3f18232fdf8474166dea8dca =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/670d07df5ce1577dbec86858

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc3/arm64/defconfig+kselftest/gcc-12/lab-broonie/kselftest-cpu=
freq-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc3/arm64/defconfig+kselftest/gcc-12/lab-broonie/kselftest-cpu=
freq-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/670d07df5ce1=
577dbec86859
        failing since 5 days (last pass: v6.12-rc1-5-g45a8897db67d4, first =
fail: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/670d09462706bb6cd8c8685d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc3/arm64/defconfig+kselftest/gcc-12/lab-broonie/kselftest-cpu=
freq-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc3/arm64/defconfig+kselftest/gcc-12/lab-broonie/kselftest-cpu=
freq-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/670d09472706=
bb6cd8c8685e
        failing since 5 days (last pass: v6.12-rc1-5-g45a8897db67d4, first =
fail: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/670d068aaf8e516253c8685f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc3/arm64/defconfig+kselftest/gcc-12/lab-broonie/kselftest-cpu=
freq-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.12-rc3/arm64/defconfig+kselftest/gcc-12/lab-broonie/kselftest-cpu=
freq-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/670d068aaf8e=
516253c86860
        failing since 5 days (last pass: v6.12-rc1-5-g45a8897db67d4, first =
fail: linux_kselftest-fixes-6.12-rc2-4-g34d5b600172b) =

 =20

