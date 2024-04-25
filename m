Return-Path: <linux-kselftest+bounces-8872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8388B2770
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 19:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E3728651E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 17:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4B514EC49;
	Thu, 25 Apr 2024 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="KkHbbz3k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5114D6EF
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065341; cv=none; b=KUpHxPZlvu8Ycov/tCqhVgja3yzaDDc/NXFYS1rvhF+8hlS667fSLLQ4DT/H4eDzmkgDM9DfQqKa1kRnvr9B+m1DjGhY0/2f1O4YhZDq69Y0b5RKtULGxYZMlwh19dtxYJDiQl4SNiEKVLYa8SUOjRxQC7CudMopOFX1VfLOMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065341; c=relaxed/simple;
	bh=RFTbYVaKwHFrqHcB757XtGS5lcE1vBPAGSyb1Rj3KHM=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=cVmLrLGKu4acCASsVlwowojWSUX+xg/8xPxBvR16gDJTQfqbSwBE4aIW7+LkDhh7+3qn2TwfQBd9O5SS5QmGZPLPW94/xF8dyCCCSTIQJs2/de41JHnu++Cnzvpic9SOriy/mldbk0Rby0XUNSfct7vR+NjEVBS42nYBhm3jnSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=KkHbbz3k; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a4df5d83c7so935808a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 10:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1714065339; x=1714670139; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hsKbaMDtfsFKrWZ01yVFuSNkhDSHnyyNuWpbWRUyUxk=;
        b=KkHbbz3kaQaTozIpUdHzmIU50m09tDPOBdkX0Q8cCZ3CWFy6NQ9I8MGTMIM6FIYxRd
         lsU+EiZQcwnJDCEnKSq9tZyjfb5JQ5WJPWRxkBzMTE8btfTbYBskwG3pfPlIbD1c3Ia5
         eajJRwu1ghTT8CG4BxVouwV4rldVHnREagoMnWbEoeh626QMABRjlA4FUvqjtWQQWr2Y
         67iehrmg+8zJituCSD/zAcD3PneSfam/scnsA9INoRJyQzi92XBmRYg9EgK+MKyLFYkl
         7kwbPjOQp8gi2iwxvJ+28Yek7UOLIViu6RCcWxGrHbYjw8sI1IIzRXC41Z/4KXLGoobL
         ACuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714065339; x=1714670139;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsKbaMDtfsFKrWZ01yVFuSNkhDSHnyyNuWpbWRUyUxk=;
        b=FoFyn6156COarDbmlwWVsGgBBMKGktdlOJF7iTrUHy4xO1/ajcZka7uLQcboBzJH1V
         ZtHJcpGqhiYuCZPhFu0zuvv/lcjJX68JhSQ04jE9C/yJ669NlJuxu+ZQJwYQpLUlH3jL
         Ow4EEXzKcHGRnsNEDe1KJ5qT57HNlSA3LeE0nemWReKqAdjP/9WDw9U+PqL/SNEsDjVu
         ThhysyEOWvB3ftLL9SsvvNItQL6QAEDhhExoNPasE+Vx8S6YvdFNMAaZRVY6H5TSTJM3
         p7CDKZKh6eJDeJBZ8OlqspIpV4y+VK6SA+CetllMzgG3XIvtAyVPKa5DHCQTudOZJuvm
         IOEg==
X-Forwarded-Encrypted: i=1; AJvYcCVOka7+LFo6X9K0zAzTSQeRpnoWZ77n1lRNwLbn4P4O25l9gpQkiD2dC2CHrgYkSVqQ2xjXmNvZ5h/8SlPp+WztfKi8YutPMe+I69jhWALL
X-Gm-Message-State: AOJu0Yymb9/9pQK1l9F5c0JSF4HHx9gD3qXuc3BW9lwLj8gAH+9KJOFX
	y+NWIXnC+q+UK4zTG0wNRVFTwWbB4E37/gRdFQbs4cv1Jl03ti1JU7EXVeKo/Ow7ZF20EayjCCF
	odbM=
X-Google-Smtp-Source: AGHT+IF2Ge/nThnm4EU9YoGDgbeb0n+Nxu+9SYXo8ONwsYUg/V5xV6ZTA2RxtA77iYGn+LIzjXn1hg==
X-Received: by 2002:a17:90a:fe8e:b0:2ab:e09e:fdf6 with SMTP id co14-20020a17090afe8e00b002abe09efdf6mr177150pjb.47.1714065339091;
        Thu, 25 Apr 2024 10:15:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090ac00400b002a3a154b974sm13213740pjt.55.2024.04.25.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 10:15:38 -0700 (PDT)
Message-ID: <662a8fba.170a0220.70eb0.f7db@mx.google.com>
Date: Thu, 25 Apr 2024 10:15:38 -0700 (PDT)
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
Subject: kselftest/next kselftest-livepatch: 2 runs,
 1 regressions (v6.9-rc4-32-g693fe2f6a9ea)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 2 runs, 1 regressions (v6.9-rc4-32-g693=
fe2f6a9ea)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc4-32-g693fe2f6a9ea/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc4-32-g693fe2f6a9ea
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      693fe2f6a9ea17e4241e5114f54c6ae7bc2512d3 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/662a7e871dc4e5b1fe4c42f3

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc4-32-g69=
3fe2f6a9ea/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc4-32-g69=
3fe2f6a9ea/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/662a7e871dc4e5b1fe4c42f5
        failing since 71 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32=
-g345e8abe4c355)

    2024-04-25T16:02:14.082199  / # =


    2024-04-25T16:02:14.092194  =


    2024-04-25T16:02:19.219929  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/13520225/extract-nfsrootfs-37ys35mb'

    2024-04-25T16:02:19.236049  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/13520225/extract-nfsrootfs-37ys35mb'

    2024-04-25T16:02:21.459762  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-25T16:02:21.472128  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-25T16:02:21.575440  / # #

    2024-04-25T16:02:21.583708  #

    2024-04-25T16:02:21.700517  / # export SHELL=3D/bin/bash

    2024-04-25T16:02:21.711640  export SHELL=3D/bin/bash
 =

    ... (149 line(s) more)  =

 =20

