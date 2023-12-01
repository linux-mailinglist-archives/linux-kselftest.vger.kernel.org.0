Return-Path: <linux-kselftest+bounces-956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF60800A88
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 13:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0BC281AE3
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 12:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E3D24B2A;
	Fri,  1 Dec 2023 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="zQhOkJc3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016D11728
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Dec 2023 04:11:27 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfb4d28c43so3699315ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Dec 2023 04:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701432687; x=1702037487; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YXIIB6GZBDaQqyMalStTGqWNXD3u6mAF/+oWGtD3hFc=;
        b=zQhOkJc3y3CgEO39FNdctkGKSbrfPm7801pHNJMuTKZ6uQxdb+Q4ugxoz0Mrq5jVCr
         xaUopTjWC6zHlW8Sq9dKYxJ+o0KgXBPILK4lugubKAUf5QZs3TF9dxDyGbxbir2JmH4J
         GZOxE43Pqc9mLP3VAZxK6sKlyvgbu4BhJKhxaNhtfZyTX2JmlFCoFLV4VnVPBqygHkj6
         oIH0r5wqLEfQ1mTfZqa9aVUOAzPy88c0rzsHui6mZk7KEt7AzsRf1Pfu2HqZZbcVEhGm
         b4FvzNgPpMYJj733r/NG4yUva0Kur1a4CZj0MIsmjltO32MP5gkjgr1mgX6W21zdwBta
         mGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701432687; x=1702037487;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXIIB6GZBDaQqyMalStTGqWNXD3u6mAF/+oWGtD3hFc=;
        b=K8+UkQvf8y+bC0It9ircwEjs+z+wn2XH69WHHAmCMFyLLBVyk9mCah8DmNpxq/D6jQ
         7h2m+9bTE88sW13k0YaKJB0z+0z22mQle3kJniZBKyksW9HHPc+qmdm9ubIH26eo2rM8
         fFQ/O0tEPBAG/eBWFHEHG3v0Td66HhwLid3OhWuW9Edyr/NqPCJrwS5Rur0KDNHjlcRn
         tyFWgiksJmcv/C0TR3nvjYug7JaXvuqkKyAcHj5n4SQMyNPGhkwXiYaXnXmetv1NxxX/
         Xs7qv8G+ZIb2D8m1XGVtRxMcQ7e9g43D6VfdEWqt+Fc53ISVz/dJHf2J/AaB9FGLpD2t
         GDQg==
X-Gm-Message-State: AOJu0YwCyqcPhNu5JwfRp3V2opSZEV1gjL7CE7FRgyz7yjy5MpNzs7hy
	QxmcLuZuJ1zMgs7ENTeIWlCbS8ZBDiFhxbHRwngFOg==
X-Google-Smtp-Source: AGHT+IFu30OkBQmS/b7Fd+dlprnfAmMVptotN1reeazy0YnkoC98zMdBRYJHEdd/oHCSUEKbga9gYw==
X-Received: by 2002:a17:902:ecc5:b0:1cf:c2c8:7f96 with SMTP id a5-20020a170902ecc500b001cfc2c87f96mr20788366plh.48.1701432687326;
        Fri, 01 Dec 2023 04:11:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u6-20020a170903124600b001cfd66f31b1sm3182534plh.167.2023.12.01.04.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:11:26 -0800 (PST)
Message-ID: <6569cd6e.170a0220.1917d.9fe2@mx.google.com>
Date: Fri, 01 Dec 2023 04:11:26 -0800 (PST)
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
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.7-rc1-9-g130a83879954a
Subject: kselftest/next kselftest-lkdtm: 4 runs,
 3 regressions (v6.7-rc1-9-g130a83879954a)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 4 runs, 3 regressions (v6.7-rc1-9-g130a8387=
9954a)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.7=
-rc1-9-g130a83879954a/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.7-rc1-9-g130a83879954a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      130a83879954a9fed35cf4474d223b4fcfd479fa =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/656970aa17eccaff267e4a79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/656970aa17ecca=
ff267e4a7a
        failing since 365 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/656971603522bc7b467e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/656971603522bc=
7b467e4a6e
        failing since 409 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6569713b192e7ddd9c7e4a93

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.7-rc1-9-g130=
a83879954a/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6569713b192e7d=
dd9c7e4a94
        failing since 409 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20

