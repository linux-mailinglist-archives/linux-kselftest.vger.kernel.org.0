Return-Path: <linux-kselftest+bounces-3290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3C883594B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 03:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01892280F50
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 02:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60C2A34;
	Mon, 22 Jan 2024 02:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="DoUTx36J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C62A2A
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705889796; cv=none; b=H+2LS4qbT1Nrf9UNFSPWy84GUgbanfdynUBGB8isGTdW7vv9pbihl+LyeuPsp9RPkShk27S329i44LgaWYA7YTSWf2+FQRrmZ3igoJnF6ysGxgA/vr/Zw8jiDNvOCZnKWH05hp7bPMs2T9jd/WggZU3LA9j9/n0xdUo/HnHBDpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705889796; c=relaxed/simple;
	bh=pIR//a0LJ4LXvW8IzIEwLQynqjurqr3ETVilWspUCj0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=hKjPNOWTQzr6Z3yEXFcSVWF/hSMizPJL89gGZ/WSOMWuJT2o8ONh4EHsROMeQwz9yw0P2C+bvrrttDVgdwkmjE4NLKB9BU6AwEuyfr8dZ9W5314BhqWByXnitUXSJn8KVnYrUz0XnvJK8HX0iJEjM2ntboeGwqD1gdbHV5uDK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=DoUTx36J; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d7354ba334so8629875ad.1
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Jan 2024 18:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705889795; x=1706494595; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YipvRTvgDvXfXFtHpkYOe6mymufdyaMkA2yQ/98WInw=;
        b=DoUTx36Jxid1luonQHY+qOYsDZ5JCJ/x/mx7sZhbdUmXULLKw7rqh7DIR/9+6tq1WW
         bnWlYXs087FjlFSnUC7yUhPk5TF3LuRg/5qVDixcer88Vf2UKKICBXY5lfiQqZRb5JqS
         5JmdP3bqrVpp0cHOThxZ4Vxmgmi/eXvE1VuXFz82L69dd2MEw5E1CEv10PZYUACNtElS
         +2bzx6OO4zFi8zqGSC4X7+nKVdfqAf0qpI+zTdp4/dAtwVlnv5xte+tW4y/z2tIcqcfA
         TnP+8fat+WPx+CjjBaF19hVbZ2c5ROxAvUkdJmVOJnTRYJT//JnRDwSdEFNgrB+hVoTr
         MmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705889795; x=1706494595;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YipvRTvgDvXfXFtHpkYOe6mymufdyaMkA2yQ/98WInw=;
        b=iLa3Yg3xh43XGy4eCZ3fEJMJeUMfpTB4+Mds3Lsiyu4qdKamJjQyC+JstPbw91wUMw
         kVubPR6i1tD1u6ekUz/FqsB4WNItll0+TYqv7SuhrK65aeTS7Wl1l2Gqjpse0RWoNG7j
         a8HkM58lg0ag7wJzcIHTS2u+DXjegoOtYs/v/ouE8ZxeDN+s6G3tA81lNVKUVayriKg2
         KYRixJR7ks0NCEaNAcJ5UcuiOvHWTOAXWM1oqTcSWpt6Vlici6HkHo5j18EXlfSXvNrs
         7ttTa619ijZhEnoGZOdxEVxXVAlyjo1qZ+wtN9cB2ZWfc+tFPdhFEwfpskHrb3jB+RqH
         s3Pw==
X-Gm-Message-State: AOJu0YwEVQhZBo5zu3dFjajo5vV8u/NMw2DoTNFECeZAz6oPB8dc+Rl4
	h+S1UJhpoxYnZDf2ckYQi7PmwxJt6zYWh40A2sWml9cs78rstiL431Cjp0+DT/s=
X-Google-Smtp-Source: AGHT+IF4SJW8qXU537uah5ouUYMRMcaD4Lg0dLa+17nXDgH/AMIxZa/O4gqYgpvSAKItgjw/J+eQ9g==
X-Received: by 2002:a17:902:e88e:b0:1d4:4768:5f with SMTP id w14-20020a170902e88e00b001d44768005fmr4644443plg.37.1705889794844;
        Sun, 21 Jan 2024 18:16:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w15-20020a170902e88f00b001d73f035eb3sm1870449plg.181.2024.01.21.18.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 18:16:34 -0800 (PST)
Message-ID: <65add002.170a0220.d6e44.4085@mx.google.com>
Date: Sun, 21 Jan 2024 18:16:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.8-rc1
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lkdtm: 4 runs, 3 regressions (v6.8-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lkdtm: 4 runs, 3 regressions (v6.8-rc1)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
8-rc1/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.8-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6613476e225e090cc9aad49be7fa504e290dd33d =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65adc2f20c23120a6952a3f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm/m=
ulti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sabr=
elite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm/m=
ulti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-imx6q-sabr=
elite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65adc2f20c2312=
0a6952a3f4
        failing since 461 days (last pass: v6.0-rc1, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65adc33b20698fa69d52a3f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-=
mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-=
mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65adc33b20698f=
a69d52a3f8
        failing since 459 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65adc3370fad8dd25952a3fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-=
mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lkdtm-=
mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65adc3370fad8d=
d25952a3fe
        failing since 459 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20

