Return-Path: <linux-kselftest+bounces-5513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E6C86A8D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 08:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9970928552E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 07:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7A02374C;
	Wed, 28 Feb 2024 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="g7kCOp63"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB64F249F7
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709104918; cv=none; b=TUVSnjfj+PRrMvL83OeaMBNCqqQwc8y7W0CYoj0S+TMQsqIiz5xudqq+zryLW7L6CPuEuDNrvZHet/ZbcQ/4Fmn45W5HGABzTKvR5kaPS51k1He6wuUAFIWO0kteuqOuSCjG0oyfrC0U6DwuNShc1baOlRAuiAInwbA9NNIeFVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709104918; c=relaxed/simple;
	bh=zc8nCmbBhrWNKyDeDoGi4K6vPN2u/WLTZUhwigZvONE=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=mFu5+Yhjt5b8cCyWQ2BWNOpWNyy5c8xeYRGQARarYYMOTKL/lV4LihK5V/lLBZXxDzWj0aqKxqFheAFL4Nxe6FyM+nfK28rqsKOQAsBRs6qf53ZWMr5LrB8rzmEAogXPmWzslusTrOfIrW+TT+nL1RkY57oH261AxYp5aV9TvQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=g7kCOp63; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e55b33ad14so439276b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 23:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709104916; x=1709709716; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wVhy7POBXH4o1zWf8wJL0tethHZLIOzgut+mSiPSi+4=;
        b=g7kCOp63L/oIWwDeZt9txV4TiVFofscP/DZJ9m48QXrItgTl/0+dzJonS2aTfrA2g8
         8hhsjhemZxyPCxTmrhFuM1p5XvCJTdWXymadThNKp72RUYUuqAys+BqN2vOHmtyavGq0
         4ZNx7zNV+WnSZNcRf4FMCSMO5tgGutKd3WDVD1KbUjNcPSs5VmtxFULE2yj0nFdbhIKa
         RiQDwY8NMJU+dTG0WbJ5T4ug0L2dT/cs/xfYb288l8j5S0hW1lrWjaY59+GQLiuVgTNC
         CGWRUQDm6xYIJIa+/fpQDXRXUTQZSip4VLhu24WjPpSPUd4FDbOMwsu1lawY0E/eZMFO
         1POA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709104916; x=1709709716;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVhy7POBXH4o1zWf8wJL0tethHZLIOzgut+mSiPSi+4=;
        b=UnGVV+8GLjUq/ck+6c8sLtnQZehUpAsu3DbJfoRGq8OdaKtCRN6jMxfZuewOUttgIi
         rMUWPgTElW+6Shv/ol70KwRUm2ujefT9BZByoRFuxEeoEILRbfUAyNuYyTIH9XBSf/9E
         0YOmlJBV1jATDq3nuJ7t4/dSw827FHW+b3mggzdAzapi0JtKD2qEjF3aOThG9R1RK2MK
         bpS6MEoqChKgTgF+T16oshzVuY2U5yKR4t2OhkiGzdh6GQdLGOJECINs0+FeIE1Zk0jr
         DCNmOGWcGAIly628nD98TnRPbjvG5Y5eXEd5J8nOlZF9qXALnR3MHonJdCLgqpQuIq3J
         wnuA==
X-Forwarded-Encrypted: i=1; AJvYcCUVA1Tzi08/lE+B0VUJ82YiZktjb+KZpxl7hw/5l/dUSRiMGiQ/+INrx6M+MWCstegTjvycxxoMBYXtdUU3F2XNGO6W9DTCDacQnPlXj580
X-Gm-Message-State: AOJu0YzLDP781lddicBGht68cjmvBRIbgVnyMk7+b8+KNf2lpQKWYyJN
	lgDf7E1CLF/sAZYFbpeHyhNosQ4L328xsjBH/4Vt+PEkyIviCvlqYZAy0r7+ihTB1eF5dNzlSi/
	VNj0=
X-Google-Smtp-Source: AGHT+IG5FiVty+e2tZTd5L5Y43CcjAc2tkPZYhloZKQL8Css3T/p6yFrlR8E3chS5zPoKEkZUBm6pw==
X-Received: by 2002:aa7:9d9a:0:b0:6e4:68fa:7e10 with SMTP id f26-20020aa79d9a000000b006e468fa7e10mr10715036pfq.9.1709104915990;
        Tue, 27 Feb 2024 23:21:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r25-20020a63fc59000000b005d6a0b2efb3sm6944799pgk.21.2024.02.27.23.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:21:55 -0800 (PST)
Message-ID: <65dedf13.630a0220.f8b2d.9280@mx.google.com>
Date: Tue, 27 Feb 2024 23:21:55 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-56-g539cd3f4da3f
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.8-rc1-56-g539cd3f4da3f)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.8-rc1-56-g539=
cd3f4da3f)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-56-g539cd3f4da3f/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-56-g539cd3f4da3f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      539cd3f4da3fdbe7dc353634e004e4b0e725c35a =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65ded1d5c2aa34249963703c

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-56-g53=
9cd3f4da3f/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-56-g53=
9cd3f4da3f/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/65ded1d5c2aa34249963703e
        failing since 13 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32=
-g345e8abe4c355)

    2024-02-28T06:26:05.757140  / # =


    2024-02-28T06:26:05.767314  =


    2024-02-28T06:26:10.908349  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/12885469/extract-nfsrootfs-c33w8jjk'

    2024-02-28T06:26:10.925782  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/12885469/extract-nfsrootfs-c33w8jjk'

    2024-02-28T06:26:13.149970  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-02-28T06:26:13.161626  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-02-28T06:26:13.280972  / # #

    2024-02-28T06:26:13.289584  #

    2024-02-28T06:26:13.405920  / # export SHELL=3D/bin/bash

    2024-02-28T06:26:13.417269  export SHELL=3D/bin/bash
 =

    ... (112 line(s) more)  =

 =20

