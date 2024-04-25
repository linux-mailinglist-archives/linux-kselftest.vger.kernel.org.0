Return-Path: <linux-kselftest+bounces-8873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0A68B2771
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 19:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE4A1C242DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 17:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E770014D718;
	Thu, 25 Apr 2024 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="MtpXPf7/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8314EC48
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065341; cv=none; b=kpS6eU6kTdZtI/kTBCbx9DcfeD5BJqbCLv2qvoselkCaLO74w5Qsk9SwyJNC0nr22Psr01rFTqot/1dJuNhA3T45aNN1/2ytVg3Ir4Dppuwx8dzyfFiR6SzgnF7d2qGrMsFv7j9/ve3C5JHomZ6K/C5lTJfMCZ1CpcWeKDwPC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065341; c=relaxed/simple;
	bh=t8CLnJ0UD9OpmrKIrtFy9pzJOBflNafNYPvsGeaLZ+c=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Ac5RZCFtah54zs/LyeH4OzFf8yYfbdZXOPmWYPBuV0lzbzKF8IBr1eNUELLPYQG1iA6zMfIfWzmPuqcyGLoOON8ogzYfItFS6tHEYSJWxJZKZJ3LavbUcMN8BGFq91FprU3JarEcaBCaV9WsgUp90fgTsHrRiG4g/kSXm3m8nSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=MtpXPf7/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so9662125ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1714065340; x=1714670140; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w2w9FVpPy2jaQUN6cEa6I6jc0/RGuE+Ae455tAPdXxw=;
        b=MtpXPf7/n8//vLx3QBhbnccvgLOvBvVgJY0vU5a6/D6XXdVCWTcbEU72y4szNuQik7
         KCs81v/WWn8a3z3ky+4cJBDO8EN5btjGYdh/28uL16nARqx7vRkKF2pyzP6gGSMmDRyf
         YxGiSvwzEcggNEnlEEb7dN6OxzIMAmo4/N3le5cnXFroNQGjRud3c0qTLakCylxMPYT0
         l5Q+zKiJpTcR2xq3jAEUdgXfu3YPYI8pSiv4xXXBqsut7rblo7P2aZmcAgvxBencfsYZ
         JlDsYsrnXJ4awyy9FZBVLd+8NxDCuV3yJd9lugU4dRPLJAXoXjInRVY1upYjon1qgAQk
         wmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714065340; x=1714670140;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2w9FVpPy2jaQUN6cEa6I6jc0/RGuE+Ae455tAPdXxw=;
        b=NV7SxknPtwXZNO2VGB8bWcdq+q1i9iUhPV2+7Ryg29e9r1lmVSMgudctyiXuKZuyo3
         2K2H4YO23glzd0kRKoqyHOwKI/N6eaEm0fiwXPV/VKAlHY/ljPK7nVtP64+fJ7jsCsLi
         l3BLVs47BgKyaXg7PbkII6zgw+qTXG9Ih8y557bT4ouza6SWcZXywOsBHCJhrHE2Rqgu
         OQ/Wrw9G5SXB4NFs6MKxBIW7LPuY1ZSa3HiNxIJdKKq6mfKukWPcyE98YCGs0PlNvMDn
         7ULw1mG1j+IfPhgA3GWJwZbuux9PKDPV4egaK0NnSXZPMBsQLWzozu0QDeoo14KSlXbA
         mIyg==
X-Forwarded-Encrypted: i=1; AJvYcCUDf1vnps6C7PuuRCj8FX25cEcLYjfH5aQJpMrF/kcCp8Vh9ak9m9Uw78JiW1duKbIBUBzRxVkf3Rql1fSGkb41wJYwysp8gYHBtZjxuzfG
X-Gm-Message-State: AOJu0YwC4kEWJBijkHfcRoQnjeMlEuAeBxQ2hKB4hz2K7O7pCVGq6rWK
	Jt0BXbGsrEZ6z4Lz1ZTaEqmbJsMVelXUYasivYU0AEuTUQx5WX0woAYC0b8Zg/k=
X-Google-Smtp-Source: AGHT+IE58cro3ncwvxio4atBD8vZSnhKWTZ3dLhQ1aQQUly5+n7v68j2BEar68Gu0hMUAkj1XI1L3A==
X-Received: by 2002:a17:903:228a:b0:1e0:b60f:5de3 with SMTP id b10-20020a170903228a00b001e0b60f5de3mr624198plh.7.1714065339589;
        Thu, 25 Apr 2024 10:15:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902b94600b001e426094bbasm13949509pls.289.2024.04.25.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 10:15:39 -0700 (PDT)
Message-ID: <662a8fbb.170a0220.7cd67.223e@mx.google.com>
Date: Thu, 25 Apr 2024 10:15:39 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc4-32-g693fe2f6a9ea
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 5 runs,
 2 regressions (v6.9-rc4-32-g693fe2f6a9ea)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 5 runs, 2 regressions (v6.9-rc4-32-g693fe2f=
6a9ea)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc4-32-g693fe2f6a9ea/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc4-32-g693fe2f6a9ea
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      693fe2f6a9ea17e4241e5114f54c6ae7bc2512d3 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
imx6q-sabrelite | arm   | lab-collabora | gcc-10   | multi_v7_defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/662a803a6a5532d9344c42ee

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc4-32-g69=
3fe2f6a9ea/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc4-32-g69=
3fe2f6a9ea/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/662a803a6a5532=
d9344c42ef
        new failure (last pass: v6.9-rc4-19-g00ab560eb0e3) =

 =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/662a8272e22aaab90f4c42da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc4-32-g69=
3fe2f6a9ea/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc4-32-g69=
3fe2f6a9ea/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/662a8272e22aaa=
b90f4c42db
        failing since 555 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =20

