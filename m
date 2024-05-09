Return-Path: <linux-kselftest+bounces-9756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D538C8C09D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 04:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C52B21DAC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 02:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967ED82871;
	Thu,  9 May 2024 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="2Yc9uVjc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDFC45018
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 02:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221867; cv=none; b=CKL3LqrzkobQQuFw6uuzpCTE+P/tLILHfhSFcw5gF+c3TFz+4kxcKzPNjiS6DHjxlLbBac4u4io7MGtCZ78RF86t7O7JrSuDVoWKZpohBm9QHdZQ0eWrPydjVSu7nCbfqodq/HPucWOkAKVPXkq/jVwnW5P2N86zhKdV3wWQJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221867; c=relaxed/simple;
	bh=PpYBSDxy8ck4N8j/Jjqj8J9pK61Lr1unxyM/xteYw94=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=fRBSCleo+YBI6mYO5oNbBBqqN2ncqF/LrAAAHCAB3/6fU6Q6q34YuCy3XZlKKEaboYuWhLbggoYoSPBVdXMKqH336nXwnJI4Xhvs/lqGHsxT06dQtPOUVbBoKaxrzsciILTPxWT2ZsmHj140BC9UcchVu3pcOH/LU+2NkF1LTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=2Yc9uVjc; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso283369a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 08 May 2024 19:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1715221863; x=1715826663; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bDFKkBUSBEevLzSZP1rXvc/18wmJEmOLtfFltMyI+IQ=;
        b=2Yc9uVjcYG+UPHqzPif0RL/g8kZ6IlxEGbYNyP1Pw2AxcLY0yvNv8TfG4MZR4UJOGS
         Ruvds7NBcCumdpHiD8ppUHUJolSu3DV3SUJOaDvhzO1m6QtAgN+m3HFlqEy6Ajmsxb3F
         74z24Gu2YN704jkx7rLZih/Xseiq4rTbt4ihMbBp+FE6agmu/mB48KKWTg59K1OMM3Hj
         maiknp5Yxx5ffRhickoIlOXQHj90y9abEqLzJfIkQ//03Z6+O87ZErX50z/3btlcCO1s
         2gKHkx93h+EtC3Soo1c77dgSv1TGEhysdcPPjzMv7hFqcbekOL9UGNJIT/eEQTVQ6Fio
         Gj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715221863; x=1715826663;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDFKkBUSBEevLzSZP1rXvc/18wmJEmOLtfFltMyI+IQ=;
        b=Ovc9VrWctDNcfoMWKomCfZ49JdvVwgt0UbwuiAoUq6oew7+AUTTEI02nO1wZF+LhtO
         /BpazAOvpsA+VjUbYo4vunk9wB5DJRsyBC5ncz/rJo9xVT0DgPLi9J1myiruu2LduOYl
         H0UqDlkke6bGbDOR8Kn3RIFvYTNilyXpKxs6gL1GkpeToFn/9VpqqEciqUzkmXG0VWY/
         dQ4LCyG1xjdPCuVKSs/F4tKBYGycJtrIWBH6gl0Yp0X7O60Txv+L3OdVbzu5EmAACSdZ
         Vrt7/YbhLX+yany31WCYuUAflufTzzso/2+0E/jh/VndB69H7YcLnUFTue8SKsxochBW
         O2EA==
X-Forwarded-Encrypted: i=1; AJvYcCWucxe59KB4TRPP2VPVdX2OMBBavfdVTRm2EEFx7tSQvGIYG+OLlIttwtVFy8UT6d6+A+jRgcNM5iFFeNNJviu6G+/3LQAEV2DP6GypxMzX
X-Gm-Message-State: AOJu0YzvFBQNIxjCCtgxrMI1VFRycy6UoRD7rkBESWUdpSmV5AernBYr
	Eewn7y/ZzscGh6qDRGjDc0F1Lmvhbjysgaki4aDE4fsWssQUlvFFezQuw9slxmg=
X-Google-Smtp-Source: AGHT+IHpEDiUYcACi2/GpiCO2fDAq03qYVPWW+hKwaH5UJXcBtSDkvoeW/bwsaHV/HQi4T++acVJnQ==
X-Received: by 2002:a05:6a20:e68f:b0:1af:cbd3:ab4d with SMTP id adf61e73a8af0-1afcbd3ad3amr3284664637.33.1715221863380;
        Wed, 08 May 2024 19:31:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca5117sm2140499a91.40.2024.05.08.19.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 19:31:03 -0700 (PDT)
Message-ID: <663c3567.170a0220.70d16.6c96@mx.google.com>
Date: Wed, 08 May 2024 19:31:03 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc7-44-g2c3b8f8f37c6
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.9-rc7-44-g2c3b8f8f37c6)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.9-rc7-44-g2c3=
b8f8f37c6)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc7-44-g2c3b8f8f37c6/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc7-44-g2c3b8f8f37c6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      2c3b8f8f37c6c0c926d584cf4158db95e62b960c =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/663c261a3dce3597d84c42da

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc7-44-g2c=
3b8f8f37c6/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc7-44-g2c=
3b8f8f37c6/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/663c261a3dce3597d84c42dc
        failing since 84 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32=
-g345e8abe4c355)

    2024-05-09T01:25:12.718367  / # =


    2024-05-09T01:25:12.730671  =


    2024-05-09T01:25:17.858909  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/13700273/extract-nfsrootfs-9f0zxrtr'

    2024-05-09T01:25:17.869886  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/13700273/extract-nfsrootfs-9f0zxrtr'

    2024-05-09T01:25:20.106488  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-09T01:25:20.118164  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-09T01:25:20.234727  / # #

    2024-05-09T01:25:20.246659  #

    2024-05-09T01:25:20.391582  / # export SHELL=3D/bin/bash

    2024-05-09T01:25:20.405961  export SHELL=3D/bin/bash
 =

    ... (46 line(s) more)  =

 =20

