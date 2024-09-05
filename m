Return-Path: <linux-kselftest+bounces-17198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401F96CD20
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 05:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B773B1F24D94
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 03:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DEA13D291;
	Thu,  5 Sep 2024 03:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="w9JhMRCx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2CB42AA2
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Sep 2024 03:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506355; cv=none; b=SFEOW5+wjQ6avCJj7+kUmDh0ca7WYbx/YV60nkc6TjqNBsExddgRD/oBYhMc2qWue2lbZoP3iPor0MnQiLvQRHA9RPYdkI9u0Q8xLznrO62THscmv3jEFFg9jXArdyHG7mPTgyVfbtpuyYB0+/oS90sGX9HhVy//Q6GlUCu86pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506355; c=relaxed/simple;
	bh=2g6s6z0QwWgU1iUPHP7AJpLzoWqGcviHuEgeL824H/U=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=LKS2mRWfhEfj2xZZvfYo0MLLA3zgfqOc0wRZj0sRtMPTSMXor5JECq4WXaGSCzvzBTtvpzS8M71/Cpm3y5biqpV92ah3aI+hc8ywzk68Gxv4pYNC+By85qjWewEO5uqT327jI6ou0wtRePB0CrxTUZP/5c9/gFWyp/7SUmP64Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=w9JhMRCx; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so201267a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2024 20:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1725506353; x=1726111153; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t1rcv++48bhT1jN2uh7JY+ktBCRKaRyRJ9NK5e00XSQ=;
        b=w9JhMRCxaqvKHUwfY6z0CZKrwqwMQKScwIzxmFLj7ErW7DNuw6/7x5n5UMyc8VRSI1
         L3Fw74f0UEkCQnEXFhdZ3nT09h2oHsYgo7pgc+IlDjtBtPN6MRcwX0IOwYk+iojAxxJa
         m1xmZIEJqCtMhnRnghyg8N2yG0VdgTZbj59bb3FwB9rPQnJsORag6RoGq+YHrpfF3aa+
         fX2Ib6D306VsyDmTOCdnBaY5wcPicfoFalSEy+ekxL32mkBbhdQGE+n9N0383H/Rh36o
         xBVDzf6BaX1kU7Xja+sWg38deCsL6sSQVodjWIQDfA/Elyz5hn37umxt7tgWF3aNI4J0
         hhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725506353; x=1726111153;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1rcv++48bhT1jN2uh7JY+ktBCRKaRyRJ9NK5e00XSQ=;
        b=VYKBbakD+4v5HDvGZdqw1BZlVPlDLvtNr8cjc58SdiybZSughJFs4hSN3qT6nJ1I+o
         3fh0Rvo+qemKlb46wnG38EC5E8+YvXsPNLI+/yGCU1CIN15oAw5eOCGrLWdiuorkYZIk
         IVxtq3WkVnFzk2Ywvx/quU1qt5VntxQhlY7bQ9nbIpVdxxVz1c/6hQLZYFJJoTozNK0T
         RgoJHeyBSsyoJWu96zXhDfR1X4/xx3y4sfZeKaxN0VHR+YeZ8ucLLhnXZNto6964Nbtc
         m3mIm33ge6n50qwduCImwRZMVu67id0wA8tUlrOCEb7FV1m7cKXzqnSbrsojRT/5PnfC
         P1AQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/eKVl3crfi7OAZd2sqBlzmuS+R/DPTm0qW0eboPSckbzCvTsygP0CASyLtE6uGFAn0fPfMAKBR+pA6IDY7iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdoniMDuVKJGF8V4O3FVNTV+3HtYUGyMKcb23oWePwpiC48MCI
	v9UGZHmsRlXAmfjf7EZSOxTUPBdBznn47XlFaTw4T/lW2J7WVWEIpUpW3yf3uiM=
X-Google-Smtp-Source: AGHT+IEAnpsP88h26UzKCyi8Hk4blSD+bhWOd8PSMcIWjyqIDguE60HHVLho60bdqqaZiPD8HtUoNg==
X-Received: by 2002:a17:903:230a:b0:206:9818:5431 with SMTP id d9443c01a7336-206b836c01bmr71985135ad.20.1725506353328;
        Wed, 04 Sep 2024 20:19:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea69770sm19656845ad.277.2024.09.04.20.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:19:12 -0700 (PDT)
Message-ID: <66d92330.170a0220.516bf.7cfa@mx.google.com>
Date: Wed, 04 Sep 2024 20:19:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-18-gf0a6ecebd8586
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 2 runs,
 3 regressions (v6.11-rc1-18-gf0a6ecebd8586)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 2 runs, 3 regressions (v6.11-rc1-18-gf0a6=
ecebd8586)

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
1-rc1-18-gf0a6ecebd8586/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-18-gf0a6ecebd8586
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      f0a6ecebd858658df213d114b0530f8f0b96e396 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-12   | defconfig+k=
selftest          | 2          =


  Details:     https://kernelci.org/test/plan/id/66d916d62986e258aec8686f

  Results:     107 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-18-gf=
0a6ecebd8586/arm64/defconfig+kselftest/gcc-12/lab-broonie/kselftest-seccomp=
-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-18-gf=
0a6ecebd8586/arm64/defconfig+kselftest/gcc-12/lab-broonie/kselftest-seccomp=
-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/66d916d62986e258aec86871
        new failure (last pass: v6.11-rc1-17-gb4bcdff7e839) =


  * kselftest-seccomp.seccomp_seccomp_benchmark_per-filter_last_2_diff_per-=
filter_filters_4: https://kernelci.org/test/case/id/66d916d62986e258aec86876
        new failure (last pass: v6.11-rc1-17-gb4bcdff7e839) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
stm32mp157a-dhcor-avenger96  | arm   | lab-broonie | gcc-12   | multi_v7_de=
fconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66d9183da9ac6df563c86874

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-18-gf=
0a6ecebd8586/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
seccomp-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-18-gf=
0a6ecebd8586/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
seccomp-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/66d9183da9ac=
6df563c86875
        failing since 36 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

