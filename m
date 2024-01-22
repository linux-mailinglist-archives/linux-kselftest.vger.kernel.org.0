Return-Path: <linux-kselftest+bounces-3289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9539A83594A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 03:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458DB280DB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 02:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7AA81D;
	Mon, 22 Jan 2024 02:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="wZWxhW4p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7CA34
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705889796; cv=none; b=P9bJQAIVu/R1lG7L/zcaYTX4lKEgiZ0OwQb6pY/kQGXXnqp/e5dGqPEEZC9rSo54z0kA4BVv1QRVB8qv881OBPm0oby9NHM0IzSEOypP7AO1fsarNgSn9gQPFd2JkVlsqR0+dwYPWn0ivnGUBgfzdMt6c4Ys4Q57XZI3TQTLi+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705889796; c=relaxed/simple;
	bh=/AWHqMmlHAonWnjQYsgeOlU6zqKIF+pZoJ1cU1gUEjU=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=g/PGuyUG6Tb16sY5acZzCUmQPgCf5yMP0UCxsVFPRsMTx6WhLciqMnsnOF/B1hpfZMe5caA1wDdt9hpK7G8yqDoAfeO/yX/Px1T7nQqAmDKg6ggSq488b1zLNIWYytjMy3xJl9QnqtKPaNIWYmgfdAGhE/ne+KOuMZ6eRSKtBvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=wZWxhW4p; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dbb003be79so2420305b3a.0
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Jan 2024 18:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705889794; x=1706494594; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jYJsN95wVMvmQmKRYroCuEVqPvNcWjnjqZOLRx4WYxc=;
        b=wZWxhW4pFV55icukAEHW9MIJIcXvf2KAwZnNXIn8CqnRHoGF54Ol11oxgTN/5RSAI2
         rzW1ceYUX/JhVMxQc37S1xgJygl/AV3oAE/0P0FN2chqGxNXIz2W8FKOmxH1YrfUwfvO
         r/pu8H8wgZHMUZNQ2AIUTYGZut4bdEuudH8zo6JcYUl4PVkoUgnHvIDPLsr9nkRrPXpq
         eex17zE8oNzxNqCFh98GizwsyJI+BMa0Fu412azALFrLfPvjOVGZVw64p0FxR5re+pA9
         r23bhilWDsRnDhxL+tnmbgIJvMIMMCt/x8D+MY7YJA+PjgCJjGVcLXcjJFy3/zS2lp9E
         D7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705889794; x=1706494594;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYJsN95wVMvmQmKRYroCuEVqPvNcWjnjqZOLRx4WYxc=;
        b=K8hGamHFkG0vHgibmDbQSyHfOMwv16iLf8O95DdysR1i/iHVbF38MTT6huJE5bawGR
         eCx88BJX6p6Q/wD96/e51/p5UpUv5C0aHu0g4u1KnpmwBKhdAIA1YAKBbaq3rBk+ORH0
         UM/TAcOPBT2XEJJ+w5OTH6gxV94hP5JdrMla0LtBMeE1t3Y4t0PwkJiPxuzkIbhQtEvy
         RFPr9/pAxCeLu7eDnqTjp7vTuSaJ++jwlWmEe7TbkKii538h0Yz1RA+mfGWapn3AVN66
         FqNbIbOdLffVx0p2ykYWnSOtKRsHnDpuEvr+9wLmEbMYP1CGAGT/Wg4zM2E6k50/wLCi
         yyuA==
X-Gm-Message-State: AOJu0Yw8bndstwpvmoiVOhiONw4jE9zMn7fFyvv1pPV0yTQw0GXTfbY9
	jy1U4XOiQKfBm1uiaZy8N10e70NpJ98NO9gGI8vd4L7gzRUt1NMb/jCpgPfG9j0an4GsFNGRyEN
	fv0U=
X-Google-Smtp-Source: AGHT+IFhP8eEvMbIn+cSBk7+7iS3B/310kbnwGPZgmL9KamC6Ql8PIgk/DPJZCsibl38cHMIVKfurg==
X-Received: by 2002:a05:6a20:6a2b:b0:19a:fbfa:b16a with SMTP id p43-20020a056a206a2b00b0019afbfab16amr3982303pzk.30.1705889794427;
        Sun, 21 Jan 2024 18:16:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kq17-20020a056a004b1100b006d9330a934dsm8591674pfb.64.2024.01.21.18.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 18:16:33 -0800 (PST)
Message-ID: <65add001.050a0220.274bb.f480@mx.google.com>
Date: Sun, 21 Jan 2024 18:16:33 -0800 (PST)
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
Subject: kselftest/fixes kselftest-lib: 3 runs, 2 regressions (v6.8-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lib: 3 runs, 2 regressions (v6.8-rc1)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
8-rc1/plan/kselftest-lib/

  Test:     kselftest-lib
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
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65adc3e5ea9e3e489952a47f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meson-g12b-a311d-kh=
adas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-meson-g12b-a311d-kh=
adas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65adc3e5ea9e3e48=
9952a480
        failing since 461 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65adc3434058ab4b2552a3fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lib-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-lib-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65adc3434058ab4b=
2552a3fe
        failing since 459 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20

