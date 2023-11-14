Return-Path: <linux-kselftest+bounces-63-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5930A7EA8C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 03:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087A4280FB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 02:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82505196;
	Tue, 14 Nov 2023 02:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="GZCQZlPf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96ECBA33
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Nov 2023 02:32:18 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A41198
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Nov 2023 18:32:17 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc3388621cso46059055ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Nov 2023 18:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699929137; x=1700533937; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tz+uyefSogSVpvkXHLofOhjYjW2Hvy29o0CUAz3RKiI=;
        b=GZCQZlPfypnTPONeKDMP0W1QSOYJilz2sLX9M8GK3eR+MtXrDbNLt1COLpcW+3FZ1h
         gq/l17ra0lk+fct9JUbJfyaC3NADp/oJfvqA3yj/VA460fCggZ+YHaI6tZgI+PkSfVWM
         A0cs1jxJ8WrN4rjfsYl6FTIulm+gir30yWsXV4A41SuogLd/wADw+DWSX5oo9EehYuWf
         oQgJU4AYg9mijzKb7w83t1BVKKtO/LxplIbeM1DKvj101QEAxOGd1GNSme2H72KDj7+A
         FrxK2LBNcOR7Ii5aoF4Z+yuPG75U/w/2oP0JCttBDQlpcAZsOh03DlthrttB6+PRxXnz
         GYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699929137; x=1700533937;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tz+uyefSogSVpvkXHLofOhjYjW2Hvy29o0CUAz3RKiI=;
        b=R+/br0Ms85cCXFRBGtxvqCZcwGKwvsrapDeVwvW0P3ICqqL0TVxcgr0TcI+47SzkYU
         C3G6vr63efb5RfzDImd97xhV6ecE6fcWWJu4xrIM3H/KtNDmmUvPFPux2ImZB84bhDZJ
         580W+Pu5MGFKTeu/GjE/0OIwUent0sH9wXnnhdsmStABf5OdbTHwoGuP9bOA7cY+B32x
         42DOWpzm3teFVkP44WQKUXO1/Cum+BYYhp+bHwuh8EDiyNlO+uDd7seBlYX4pxDyIYMD
         6sYAxPIxqrz4zuUDfWw0XxBqCvRCrDWg4unY0Whe92+8xbjSMa0SvCG/dhETai6vFbkq
         UPAw==
X-Gm-Message-State: AOJu0YzonnfPB2C06qUWqQHR300cktfU9nFBuV+fDwRCdzqrj+xgJ8eH
	DbPa5jEpxihqNIcprNtJBFQDn6hL19MmSdIVEHg/BQ==
X-Google-Smtp-Source: AGHT+IGnIFZAuB4l3InZMRMkC0Twr6yjK2GQNUgRhPu1w09jZmqg98NIrp2Wg/G1cSOpAEX+UPy3+Q==
X-Received: by 2002:a17:902:ce8f:b0:1cc:32df:427a with SMTP id f15-20020a170902ce8f00b001cc32df427amr1261391plg.27.1699929137346;
        Mon, 13 Nov 2023 18:32:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902e88500b001c3a8b135ebsm4664505plg.282.2023.11.13.18.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 18:32:16 -0800 (PST)
Message-ID: <6552dc30.170a0220.5ace8.ae21@mx.google.com>
Date: Mon, 13 Nov 2023 18:32:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.7-rc1
Subject: kselftest/fixes kselftest-lkdtm: 1 runs, 1 regressions (v6.7-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lkdtm: 1 runs, 1 regressions (v6.7-rc1)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
7-rc1/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.7-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b85ea95d086471afb4ad062012a4d73cd328fa86 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6552cfd1a643143fb07e4a6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.7-rc1/arm/m=
ulti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sabr=
elite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.7-rc1/arm/m=
ulti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sabr=
elite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6552cfd1a64314=
3fb07e4a6f
        failing since 392 days (last pass: v6.0-rc1, first fail: v6.1-rc1) =

 =20

