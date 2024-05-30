Return-Path: <linux-kselftest+bounces-10887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5033F8D4291
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 02:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DDC1F213A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 00:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50950C14F;
	Thu, 30 May 2024 00:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="k9RQ3NQh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184FFC01
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030410; cv=none; b=FBjaCwaDUzTD/8IRlzaQza9N8QKGjz0uqYafJuzQKVfZUiIBnzWVoY/9BmwrzZ7ikfdJCs6rt7MfyxnwighGrza5Mm+asnQjx/ChOsKzjE4L5l32fXQ2oiCYnefK0GKpduNX6YGECFs42BGfWHOiCR1vqcmZM9BcQSRYnsPoBEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030410; c=relaxed/simple;
	bh=LTIDGMxgdzUFS01lDnzGmZbOoWjMmjR3a/SOSoub8Pk=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=J8XkN3+qXJxwHf8cmS+AEa+yWO6aJTHVaOetUVKyUASz5la05A+vhC8w2sJfqBUpSsXswTVqQiGoZD6yCsy8Q0IAWwNm0pJacxKLKIlFvSApssqvlrlUeTdVprWh7c+KosqShGObKxbqVSyV+4lO/Hs1phmuQ7B73RwGOuzrLRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=k9RQ3NQh; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2bde0e3cd6aso260782a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 17:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717030408; x=1717635208; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gt5+W1XxErFXYWQNmkY2dOGx9Lo11Trv/tzxOvAOUqY=;
        b=k9RQ3NQhEcY9TVOqaUCP2SM9US9TsiuPF0q1EmwUVs0CBHLhmNobvQirQQyPYKNMTT
         DDrZT3YPwEiT9Og9/3ftygecH2pZPO5vZylWHBPTjkG3nqXyVd1whlWy/cH94b0STpnl
         JrUJBQMCxXosrzoXAAPC1IHPYAnMG60s6sYrk4SeEFt6dYu4AXNkPb4M+CTGSL5yLEwq
         Po1/2yQpkGZ4F8wHAc7Uz1/T3ZgzU4mlVDvwcXJb3QKEJ48wJuC+1E7l3pWEKppmjQKr
         1Qv+HygrocFADpEmjgLaoXiXCRJ/ggMgjpsUDd0R6y3PIniMS7oWV076n+MOwxTXY1rZ
         y2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717030408; x=1717635208;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gt5+W1XxErFXYWQNmkY2dOGx9Lo11Trv/tzxOvAOUqY=;
        b=MRau/nCgPF+VzgYiA09wZcELDh5iQUGJHBJ495jWB95X7QrBwKIbjiZa+P68n25H6P
         P4G3fFRCNJzEx1TkyEuAgYxtiowHd+ugpFsU9gYwgh2jT1GXmwWLg0x8ayid77jri0m4
         TReo3/gzOLldn1UPvcfhUKQS/KTMTisxigEgmiYLp57WjdmqcE1zcv80gC8jzrduamm6
         EYohrxwRDSsKYA0JcaLQJN5euNQPOr9V24c/vmLDbJuljs7vwhBXFuBFPvY8IIpvCWFH
         Xng1QHWqfVN5iQKggoBuYeXi/tVIRnyUHKPvpwVbJtIiC0PEvUjJlN/f4xcXlMFpyMHS
         Kc/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOrJ0xAvMAyChK1qy02NrANn9Hq1uFxDTMPTXCsa6oRWkXw94wtM+fyop596/8KuafwMJZuu9HgQcCqEvviVarkCIck9ZTlM/EcJb5A+br
X-Gm-Message-State: AOJu0Yz/yESRPe+MX0AQAps1c45LjU8lkav0+9m+zBkUqJdnco5GGJ+E
	EzAIGXNAf9AbwYVPI1BAl8hBBg9QJvuRgFJD8L3W07sxlHd+iwerohKWA24Rmff2572yi+uokag
	b
X-Google-Smtp-Source: AGHT+IFRA5RbZOCcgnj/wTqdJP1pbtggRDS4dt2eTjhP5DQ2x3tXKNCp0hH4Ywb8IdP71RY6iDAjjQ==
X-Received: by 2002:a17:90a:db44:b0:2bd:faef:e85f with SMTP id 98e67ed59e1d1-2c1abc3c4damr687789a91.24.1717030408032;
        Wed, 29 May 2024 17:53:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a7778068sm463058a91.19.2024.05.29.17.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 17:53:27 -0700 (PDT)
Message-ID: <6657ce07.170a0220.174a5.2fb3@mx.google.com>
Date: Wed, 29 May 2024 17:53:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-7-ge8b8c5264d4e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-seccomp: 6 runs,
 2 regressions (v6.10-rc1-7-ge8b8c5264d4e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-seccomp: 6 runs, 2 regressions (v6.10-rc1-7-ge8b8=
c5264d4e)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
10-rc1-7-ge8b8c5264d4e/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.10-rc1-7-ge8b8c5264d4e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      e8b8c5264d4ebd248f60a5cef077fe615806e7a0 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6657c34ffb75bd8ad57e7077

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-7-ge=
8b8c5264d4e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-7-ge=
8b8c5264d4e/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-=
meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6657c34ffb75=
bd8ad57e7078
        new failure (last pass: v6.10-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6657bf5f9059fe370d7e70b3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-7-ge=
8b8c5264d4e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-7-ge=
8b8c5264d4e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6657bf5f9059=
fe370d7e70b4
        failing since 588 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20

