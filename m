Return-Path: <linux-kselftest+bounces-11999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE24790961B
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 07:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFA81F21E31
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 05:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB90FC0B;
	Sat, 15 Jun 2024 05:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="J9oKWSnY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50868EAFA
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Jun 2024 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718429028; cv=none; b=TjBWcsCAqB8gQmND5Roc1kP4JslWhkj9VYGhWRUpY6VZ/o5G0VMhNeEoU1AdaBFFzI+aYY/iazW0NFgELY4YaLaPVNazXyMIkhiWcziLFNAFGJbVu+vUNGEoQBEqU+a8jp+mPb8IuE9EDfa9H0G9q2AgnAWfewA1DBQL65DhEIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718429028; c=relaxed/simple;
	bh=KAPrTbVqdmc4dv58eLR10r1s4dz78sAUW6RY6h8oTY0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=dY+3vcQHCOPzQ7tmWO6VYOSYb9KbXmVXvnRmKsH5aT5gwtMlimBIU6seVIwOKpMBzNsaXlHsGTQUvjlz8a2oRJhLllpNPcAAl849RvRhtfusfa5iCyF7p/9W9yCPF5xzQOsIbP5S67+zcOmjaf/ZBXz0bd5ikZfNvgcnsXyZpXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=J9oKWSnY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7042882e741so2389854b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 22:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718429026; x=1719033826; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3kgu+I2nlog+2NVaMVnlmq41sgt2v5bPeKoxLkzrIyA=;
        b=J9oKWSnY+63w9UAy7MpjGxn6VFmfw0T0zlTC9Im8NPnA2hbj+czCs7/U+VViKKcwIp
         u2zgO9D63rq9oqkPuGarJWYBezcKc8HoCFDUYVk/zENOJpA4qjBwon10/dZCLfDsH46D
         t/ULF8TwuiK6hzVl935Ps7MEiXVLHQnxSd/Y6ItBY0oekykldKVbXdJXVPMVovzLvFk9
         jmHpkBBgKMmLoldPrC7Tth2acw+D31YKQBbXcdBroHLwy+ns7BzAelCaxzk9NnB4RPdu
         AYqlSloVY1+GL7PNeM5fFmA12jPujpCvElByzjm4FRe+nU2dYftCOQFA+kI3WqWeEPvP
         2pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718429026; x=1719033826;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kgu+I2nlog+2NVaMVnlmq41sgt2v5bPeKoxLkzrIyA=;
        b=LDMmejjn865KBd35MOnZP+FsitE87FDPREJWC7iXtsHTh5t+y66iByf7ejtBXxT7F2
         zMJyBSHdPTQqW9GO9+Q11QIF4HrOdHDrb0K6kWP8kOY2jXJ0XPHO1LPEGfLSgUIg99lR
         dtvd8hfp6EM6hARKVKILYMlAAJjL8lNU5nVAlOH9KE8PTIzuEfeA33w1foFLyuzBZLro
         z6YoLC/lgJtf4z1DD5y0IMoUbWyqVWN90agC2VA61KqooVbK9IO2Xti5ZOXvVJPCDqfj
         PSgkId9wHTay19Y5SNBpA+mrxglIw6kqN9c2LDWoMS/NtoQ8kmjmr25+goHqWL0FvJLQ
         2a8A==
X-Forwarded-Encrypted: i=1; AJvYcCXskUGlplVeD/D6RpXoWOB0VbwHwKi9NYkuCNDkfOz9vT+GbYp3PPP8uhGl88RcmsdOekEnCj5dmOIp/XD8wwFbBv5Q3YhK0d9f+UJmIA/J
X-Gm-Message-State: AOJu0YyRUvC6sRKwx06fztCkIcRyhucaPEA41TQmCZRTonw150TAYLVw
	H+V7OENa+hca1iz6dHAqaIFqJIWIJv3d1NPyAvAhxJWqWNy5wcDzDoBlH6oFmE8=
X-Google-Smtp-Source: AGHT+IFhNiAalEr23rf0M3+jairuQg4MBncs4hIiOyBTh9vm5j8ErbTfJsvohxmw+Yvj7FM5XWcr2w==
X-Received: by 2002:a05:6a20:2d29:b0:1b8:5e44:ea3c with SMTP id adf61e73a8af0-1bae82422c5mr5109357637.48.1718429026342;
        Fri, 14 Jun 2024 22:23:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4ca4997b3sm4697687a91.54.2024.06.14.22.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 22:23:45 -0700 (PDT)
Message-ID: <666d2561.170a0220.e51c2.ecee@mx.google.com>
Date: Fri, 14 Jun 2024 22:23:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-2-g64f5bc57b24e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 2 runs,
 1 regressions (v6.10-rc1-2-g64f5bc57b24e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 2 runs, 1 regressions (v6.10-rc1-2-g64f=
5bc57b24e)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc1-2-g64f5bc57b24e/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc1-2-g64f5bc57b24e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      64f5bc57b24e8c7935d51732571d405acfcf4b99 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6669009c63cd4b2b267e7091

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/6669009c63cd4b2b267e7093
        failing since 118 days (last pass: v6.8-rc1, first fail: v6.8-rc1-3=
2-g345e8abe4c355)

    2024-06-15T04:32:42.846561  / # =


    2024-06-15T04:32:42.856646  =


    2024-06-15T04:32:48.021798  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/14354047/extract-nfsrootfs-1xc_88sr'

    2024-06-15T04:32:48.032644  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/14354047/extract-nfsrootfs-1xc_88sr'

    2024-06-15T04:32:50.274485  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-06-15T04:32:50.285380  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-06-15T04:32:50.404446  / # #

    2024-06-15T04:32:50.412986  #

    2024-06-15T04:32:50.530057  / # export SHELL=3D/bin/bash

    2024-06-15T04:32:50.540701  export SHELL=3D/bin/bash
 =

    ... (70 line(s) more)  =

 =20

