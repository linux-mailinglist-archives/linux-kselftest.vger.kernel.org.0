Return-Path: <linux-kselftest+bounces-10804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0B78D27B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 00:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548F11F21B74
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 22:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A955B13DBBB;
	Tue, 28 May 2024 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ZYtmuXOf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D313DB8C
	for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933877; cv=none; b=dRUOlHC2NtaomR9vNWoh5CB17MNBlBQLzaYX9bNGLZlf2SGfYJFdVfdvsla/eITAo2xAELXcKWXuwehSTSOvkED80QeycoZUip/wSSc5OGnLcb+VkRJkHR9/HO9jbOOrZnvfOcATH2JBvlH7msrCqDQ5xeqACci1jo/bNV+c3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933877; c=relaxed/simple;
	bh=LsrMTUzwMLDRYrCJ6WaWbQmnFgt8OqqQXPprkshhmlw=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Tqh3jswJ7qa3ZyW0cWbCiJIG0BrmeVG+nXHxuoMLxg+3Y2DA5l+hCfcyyZJGKhuFNvm53p/o01ZOhR9yZr6Kx7Uc9W1nj79wLDyOfoyj5t46xiBxARtyQt6j/ec8HShTpcQ8H1/m7ZJ7MM5wj3uMny1paAvpQQOXExYrQ3DeV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ZYtmuXOf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f8edff35a0so1166018b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 15:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1716933875; x=1717538675; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PSul4v4An1bQjSQTRn3STUO91sqc031haLgFIsd/7gg=;
        b=ZYtmuXOfijRNRB25j/iKH3neM9Nj3tR0hRvA3AvJXo8oXKTfJpXuUBdCeEFJiO92B7
         mUzQ9KhFNFJWWj5o531vw+2ypwcklg+cjbS4Fvzzbyri+l2ZX8b3JHK2erwVTKlTqVX8
         AHEuMlfT6+Nb8EeaXF8eodkhLGxcTL+qwerhXOc6RY81m2AIlIoZ8i3IBGCuy94vx51q
         c4Uj+l9iN2weKncyiGWMvGVv/gCuTOKO5lwS4sZqu8W5CqH47AjRxYY8s18uZdl9aEJr
         XudILwYE/4UU0eSV7QfXvdOy/VPTladAEj6hogAhrkKtmrHcj8SXaHWFm8U5puvYuqnv
         75CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716933875; x=1717538675;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSul4v4An1bQjSQTRn3STUO91sqc031haLgFIsd/7gg=;
        b=BqjnVPYPMWuPmgOsBI4IinwRrxdDB9usdJOn9tn4owZJio8vtHur4qxGxKR+nd4Xu7
         iKpHrombiiOPS27r9iGf5EqOcZvlH3A5h+mx6W3jDq+U5vcSZbg0Rsy89s+WeQlSPQOR
         Z96ltWy4NeYr32tarKbt6cXNbL61COA6hwUIkDdC7eOirjR9hoBO5k154gCK99jawRjx
         UNG1wYVhQScUvAn9KlOXzaEoMDIZGfj7VoMszwUP7c6di8EEWnBd+gx2lTHH9b8953Gg
         1tarONTKebwR2LlZDAApFlgsbSWn5mjrz0WzIeiV0Cgx7tbnHOZkNmJFS4bxJgbnMw30
         do9w==
X-Forwarded-Encrypted: i=1; AJvYcCXFtXZquH1fR8dnjLOQzCF4P5oEKJ+LEFXsQw5S7uVbpu/tq4Ni97eUa+NYvlAvFItNlbQ999WKTM5dE3ELRz74ExEYjsY48wUlf38EL9Sk
X-Gm-Message-State: AOJu0YwUQiO29PGP7V68mBo+mFQEArnZoVkRyvDK4JcAgRwKfr9Kqek4
	hLNSBi7Hcw/uYZB1IFN79+WolX1K3DOP6WYwqgENcHvyxyFpdNjjSO3OQkPYQYw=
X-Google-Smtp-Source: AGHT+IHydcozXej8bLItENwsinyqqH8WqDXoXRR3BQnQPsm1CiC/7+eBqHf/gQIYYemuqK8DNPn6/Q==
X-Received: by 2002:a05:6a00:2917:b0:6f8:c1b6:d06a with SMTP id d2e1a72fcca58-6f8f3d84ba1mr13983691b3a.29.1716933875439;
        Tue, 28 May 2024 15:04:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbea8bfsm6893092b3a.124.2024.05.28.15.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 15:04:35 -0700 (PDT)
Message-ID: <665654f3.050a0220.c197a.20b6@mx.google.com>
Date: Tue, 28 May 2024 15:04:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.10-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.10-rc1)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc1/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/665643441b3e2e138c7e706d

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1/arm/m=
ulti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-=
sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1/arm/m=
ulti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-=
sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/665643441b3e2e138c7e706f
        failing since 104 days (last pass: v6.8-rc1, first fail: v6.8-rc1-3=
2-g345e8abe4c355)

    2024-05-28T20:48:35.986884  / # =


    2024-05-28T20:48:35.995337  =


    2024-05-28T20:48:41.139322  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/14069597/extract-nfsrootfs-9ufbc7md'

    2024-05-28T20:48:41.150423  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/14069597/extract-nfsrootfs-9ufbc7md'

    2024-05-28T20:48:43.390330  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-28T20:48:43.401366  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-28T20:48:43.519056  / # #

    2024-05-28T20:48:43.526489  #

    2024-05-28T20:48:43.644547  / # export SHELL=3D/bin/bash

    2024-05-28T20:48:43.654894  export SHELL=3D/bin/bash
 =

    ... (46 line(s) more)  =

 =20

