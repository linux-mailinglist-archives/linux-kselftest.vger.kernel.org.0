Return-Path: <linux-kselftest+bounces-5053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA80885C34C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 19:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F408B1C20D69
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 18:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647F577648;
	Tue, 20 Feb 2024 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="mNmPUlla"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32D66D1A8
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452264; cv=none; b=Lq5tUhSMsGiT1dX7nd2feehq730fCSAwGdVOoiuUvNWB0SDLSnHK9nlojsJ1zAxHocNLWbO1uTk3ty2+e30MfRFRU3V5Vh8eP0SxQCcXUk+I0qrWqNDloLrHN43bgSDJU51/DznRm8x5Ge2ylvSD/zH939k73fC04eXlgS+9Jt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452264; c=relaxed/simple;
	bh=y53yG31hNxWkTMDR7J1nYlcnQ8E6gNldCLY4uZbWfeU=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=FTkVHgmVH0Fo7Fb4NAzc7tL4W8o/CPJui3PuuDCziZpDyGE4NcUnhuf7AmFOTJh2kwluTR1kUskdAoWBrFgtqB1bC/3Whb3nOO1G6JcSfBXxV3d13zqhDXEQG9Zdjv8mfVBKT/cbErmPtoKxsTi8377dGKhEKdaKre/fTPb/bPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=mNmPUlla; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso4707656276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 10:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708452261; x=1709057061; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zuiMw9iFTyuQA+HEWDB+yJP2Le6jdjXtdI5FpHB8Pl8=;
        b=mNmPUllaYE9r41W6LdmA1o0JwIrjZ/7L7zXE7gaf+S94e4HTKSuMMcQDkcozCgAFAA
         zRffd4XDOLzZbmkW+dYO5cHDK2N3BD9HhoFgHKgMEG9EVhE2xUFb5sF1HXlxfaPSjIBE
         dCEH4HyNyxTiIRdO4+LTcDgKdT83+qh0tLih818M80sPtr1T3J+Va38vAd4kql0a+/sw
         wIeP1ljZYlxalDt9+VLgM5gIY7I2lloSnEEowK83KrH4S6HJH7P2+YKSWcse1RYYx48t
         2NKG3FooMD4PQrKPROl1xXpHxaQzW+vdVv6oIWl5iM0i08QmJHRzuVhIpoxu5WriIpvt
         Z1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708452261; x=1709057061;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuiMw9iFTyuQA+HEWDB+yJP2Le6jdjXtdI5FpHB8Pl8=;
        b=NqfZJiLJypjxLh4Da5LEuZU824vpUcRfePK/6Ep6PRkLNOch1fU+GTfRIZUhkCJ+Vt
         Y4NAqUCtAvFE1HUFgaxUzm/QhyDtVDSxE3INR9ffQPBrEkob0XhDJacY7yrWtbV4ImG1
         WccwaCmLZTw8YcCtZWbYJI4xRrcfpYLXyFzyM6JwT8RHbqDQaYKpCNrJs2VtWk+2Z4x5
         Rbtm0vf/hqnvHWUi6VhleWE1xBFoqMOpx2zbDOnNFMBaukINwFHWY0WhHe4Q3kjyNzzC
         j+U/n0MF7jZPz90vyLUGTbQcr1r9lWi4xDFIel9W0uSSj5VzmL6bxw66FSwobiYCbWQN
         p3bg==
X-Forwarded-Encrypted: i=1; AJvYcCVcJwZd94lwNhTQ8zh6DWCF18V5UDoSJxhsNBx0wz5Kb/e2FmwlosMKkfr/qJV3GHc4Z1n+bWNOD3E8NpSIY5+oMRhxxurJXZ9/L1AVv5/B
X-Gm-Message-State: AOJu0YxC6U3dVDl6sSB1PU1FQgU/ghP9uehIPdJ6AoGvPKBBuq7rFPTh
	PP29AFYyV4RHoCz2DWvP/Qd+tlg/FFWUk+3T32XSSiAJxWLSQzykkYOHpB9loEr97xGVXfDn6m/
	LVN8=
X-Google-Smtp-Source: AGHT+IHs8rGn4oJBVj4sVGdjahUYiDWA2eyJa8Wgm+s7Ut174p2zUan8XKiV02EHLYLUAX5rtZbE/A==
X-Received: by 2002:a17:903:41c5:b0:1db:e514:1cfd with SMTP id u5-20020a17090341c500b001dbe5141cfdmr12236327ple.21.1708452240821;
        Tue, 20 Feb 2024 10:04:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ja12-20020a170902efcc00b001d9d4375149sm6599982plb.215.2024.02.20.10.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:04:00 -0800 (PST)
Message-ID: <65d4e990.170a0220.ec84b.4a15@mx.google.com>
Date: Tue, 20 Feb 2024 10:04:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.8-rc1-33-gf17d8a87ecb55
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.8-rc1-33-gf17d8a87ecb55)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.8-rc1-33-gf17=
d8a87ecb55)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-33-gf17d8a87ecb55/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-33-gf17d8a87ecb55
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      f17d8a87ecb557bc6c9770751c3f0aaf10edbb98 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d4dff6b0f1b2f071637022

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-33-gf1=
7d8a87ecb55/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-33-gf1=
7d8a87ecb55/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/65d4dff6b0f1b2f071637024
        failing since 6 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32-=
g345e8abe4c355)

    2024-02-20T17:22:37.077734  / # =


    2024-02-20T17:22:37.085329  =


    2024-02-20T17:22:42.234932  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/12810344/extract-nfsrootfs-f36p3g8m'

    2024-02-20T17:22:42.246551  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/12810344/extract-nfsrootfs-f36p3g8m'

    2024-02-20T17:22:44.489988  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-02-20T17:22:44.501111  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-02-20T17:22:44.619769  / # #

    2024-02-20T17:22:44.627247  #

    2024-02-20T17:22:44.745233  / # export SHELL=3D/bin/bash

    2024-02-20T17:22:44.755218  export SHELL=3D/bin/bash
 =

    ... (47 line(s) more)  =

 =20

