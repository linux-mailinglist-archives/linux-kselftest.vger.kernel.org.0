Return-Path: <linux-kselftest+bounces-18052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677DC97A839
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 22:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D051C221D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 20:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122D715DBC1;
	Mon, 16 Sep 2024 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ryYU0sdR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7992B3B295
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517996; cv=none; b=b3AW83/U/oaoJGACADOD2r3xOrBAY4XzxhncDVkpgRX9abtQGe5mBC7i7mg9/JpAf3rscqPrv0Sm8JTJApMQxDExcrrCStgvPy4sTQn+3dqxM+0EeLsY0h1j0ao02vAdRpTxUKLt2+EB91t0prrhqpVFoeQJsQ3yB7ZNjzCu1WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517996; c=relaxed/simple;
	bh=LRT4u03g+XG8BkC0es5AkaJKqrMTHFUgEXxLnbQerHo=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=E3jq2ELieL3MShSDHA4hqxfRPWAKyhxaK72Ab/PfovrDD34hHBg5ymmE0J+WI6FT6w/ff0suPdsb/Sk2SJCpUP1oV3+K0Nehm7mhm946NlpZ7f15usVoT5MxWqe+ZeirIuU9yx33nRUuwhDMuRq7y1CEwLtpy4fW50sXlmP/l2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ryYU0sdR; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7c3e1081804so2239804a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 13:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1726517994; x=1727122794; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ydTjLfAfzC9L63sbJN1HDRGnejCbl0eYXNbUbMiUsKI=;
        b=ryYU0sdR/m+tF7gscH9neMYW2JllvB06qfSrbZmJzBEO9P0nnHOmumHud6lIZ444FP
         NZT/DmxKYLBqmHxY/TXZDuEhkAABKytNldCYeK2hsgSmJIIBs2A+yRXpKnZdHfdVzKfW
         DTT6PPCFMYOdtsVbtbTB+GXbZ+FYRcvxuf4JI2tsqsDo4WCfWHdqW04vh0saxHsHE9i6
         mwXdhp4TjR7Zualbz6kCRjG+skG9+i9r4dQ3lQNmYF1Wwqyi+WegSeDaD9EQfIRzA8Vr
         YZp9rturnUwo8rnRN0nFHwN5JyyabMatfcbyEfDE2+hVWOZnleZpvQGzCLxgOOSL+fGf
         F7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726517994; x=1727122794;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydTjLfAfzC9L63sbJN1HDRGnejCbl0eYXNbUbMiUsKI=;
        b=sfy9g4zVYKcsJzf5nrxHBaF4Kwdj5tdjY4rYNGKO6dvRLxyOf/p3E8Aba/mnpmzM38
         r+QZfz5qRJL8GTW4OCuCqC/43VHa3AWIsBOAWDVZ304KEvJ1l5iGaaA5F4ocIxEm6xzb
         FwYbtmttLf+fJNwwKRYroQ25R6amabxomievMp4NGC9ujhpVcrwBTYimAVOflkGVmMXn
         chhEKTmwPQMh5z1tcP86JdL/RSNB1hO6px/cRgW3AqcrMWJQbv/j7hJ0aQztDdvhvPQO
         FNEB/e/+oyTXqJ1RHIlurvnKZuAK0ZX4seo7LBxVqwfMZxMUTh0Ae48nEDaxZC388jAQ
         bH9w==
X-Forwarded-Encrypted: i=1; AJvYcCVh4pWqKSEt4pMh0U1Pph8wLRQPORrMd3sOcd2we33kzKBv7tVfueAF5131zh+baQV5jDWZkVeFZ0dwiOinhAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNJYh4G5MAM4sb1Ya2q/yUfk1//tqW7HaiHmrnXYoxM8yCJb1A
	rdqDJd6RcvyF/4rg8SvJn3H8KA0Dcl1BdZc+P9LnuCOjyz1C9i3eVBbHUJqvidwW33aFPctm1IY
	n
X-Google-Smtp-Source: AGHT+IE8dcCN+7qlqY0+YRQ/6FazQDhK9FezDTPbkwzYqf2m8TfVjucIvFb7KDv4NhQAA/Zty8BZgg==
X-Received: by 2002:a05:6a21:3a81:b0:1cc:e5eb:e91f with SMTP id adf61e73a8af0-1cf75ea273bmr26546321637.1.1726517993663;
        Mon, 16 Sep 2024 13:19:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a980b4sm4127560b3a.34.2024.09.16.13.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 13:19:53 -0700 (PDT)
Message-ID: <66e892e9.a70a0220.258aee.de25@mx.google.com>
Date: Mon, 16 Sep 2024 13:19:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-21-ga0474b8d5974e
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 2 runs,
 3 regressions (v6.11-rc1-21-ga0474b8d5974e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 2 runs, 3 regressions (v6.11-rc1-21-ga047=
4b8d5974e)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest          | 2          =

stm32mp157a-dhcor-avenger96  | arm   | lab-broonie | gcc-12   | multi_v7_de=
fconfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-21-ga0474b8d5974e/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-21-ga0474b8d5974e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a0474b8d5974e142461ac7584c996feea167bcc1 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest          | 2          =


  Details:     https://kernelci.org/test/plan/id/66e88768d950f5c504c86855

  Results:     107 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-21-ga=
0474b8d5974e/arm64/defconfig+kselftest/gcc-12/lab-broonie/kselftest-seccomp=
-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-21-ga=
0474b8d5974e/arm64/defconfig+kselftest/gcc-12/lab-broonie/kselftest-seccomp=
-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/66e88768d950f5c504c86857
        new failure (last pass: v6.11-rc1-20-gaf1ec38c6ccc3) =


  * kselftest-seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-=
filter_filters_4: https://kernelci.org/test/case/id/66e88768d950f5c504c8685c
        new failure (last pass: v6.11-rc1-20-gaf1ec38c6ccc3) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
stm32mp157a-dhcor-avenger96  | arm   | lab-broonie | gcc-12   | multi_v7_de=
fconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66e88e6d0e37a1fe30c869cd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-21-ga=
0474b8d5974e/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
seccomp-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-21-ga=
0474b8d5974e/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
seccomp-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/66e88e6d0e37=
a1fe30c869ce
        failing since 48 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

