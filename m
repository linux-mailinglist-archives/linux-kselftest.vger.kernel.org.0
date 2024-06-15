Return-Path: <linux-kselftest+bounces-11996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3D89095FE
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 06:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98325B22A5B
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 04:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154AFDF59;
	Sat, 15 Jun 2024 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="xVCtHieF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E05F8BE8
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Jun 2024 04:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718426162; cv=none; b=hDZZ3PrjoLLbGc4EJ/yBOlGxVNHn6dx8wN8Bovcvy9oE5KzKt+KssPjzc/1CfnL4jjCR6AczSbX8Jf+e5r/dnjHO2ZgFQYRLN/KJnL770kTOn6RTb/0AvVBuVdrbab3M36pxt+FqJt5cJbp6c4aZ76pqqj+grLKbEeCspqVT7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718426162; c=relaxed/simple;
	bh=8lQNSxvGlPilJhFtaBWF5rMpIKuYAR/vsA+kgioPoi4=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=GdKHdrq9TFhaPhkTRYR5Xv+qmii5TcnApZH/ewJ6adR1tgiWoUXXIHrV6mUxCbpQoodffSQMZ++p0/1tHoucafmORBtD8G4rUwr+7zoGbAAuMJKkBjlboD/TWjbWjxuXYyq/nfSmTB7Dc7Wfj/1tDkOiSQA/e7O9yYslDKYVDBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=xVCtHieF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7041053c0fdso2118160b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 21:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718426160; x=1719030960; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8xtypIJaAbs+UCHmPiYz8/am0W0Tsj5NwjZO5l99o7g=;
        b=xVCtHieFWULbKZ1Bka52Gv/oWyi8+R+jZM51U6ShwQVTirk2kyQ09fH8XeJprZztyO
         NsQc2a0KzEAfDJwAJPqaj42XNyxxuea1hgHP2g85I4igEA08lB5aQ6wVrbq5jo7YpKGk
         i8CHChynUZVsv5oaF1ZH0XaQN9+E09CcnXCCtfy16ZBDWmxUQe7vai5Y32qkcVfYuibU
         3AkLMnNCamS166iyPG9aT4q6++twdpnJMNTcJl78hrka3eqcPz2O9XqrJsoNLcXUX3Oo
         B2SSWS7LiO/X071oil5H1YSJvxCXNgsG2kzVIq+UFu8M+5wTGIwIW3RtX2m2YnNyXQ3C
         cQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718426160; x=1719030960;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xtypIJaAbs+UCHmPiYz8/am0W0Tsj5NwjZO5l99o7g=;
        b=ig11lyyDlmkPmXDEfoolD0Gi6RAVzQZjCQRqY3hNF9+4/yDKn+X1JPhwjQRBpHz/N7
         jiMjQC7uH8HwfDd+Id5tcs/2NbTNZnAsifgnVIKjeUdvockBfJnzvLCDNIG8YaDc8CH/
         5DbamR6CaiWtCwsJhsg+krqGsDwIuUqTvdNAdK5ztvnrIfCR/fGDvF9q6atMIqLE4YWW
         wSLjzqzqciMGPmfpvJIXZ9to0pwOo3v4o1L5waWVfTctA86pWqNSiUHoEyal2Z4STHM+
         NqF+CFVif2OiinZHli9zPeDYiwJRGJFdbaHUd6Ggx6YDQS28UhXEAt7FGsqopeNZn4xo
         A/GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEqul9I8jdmkwFYtxjz+XRAogDy7Cv5hqiTG8vxU/ZlJrH+NAqZSfMZCe9AgJlYDz0VLFLzj0mP3NnPnlyAb7ODs6kwt8NACDEw5Xev6DY
X-Gm-Message-State: AOJu0YxFKWuLDtqibSqrbwmJLcCzZTvY57AJ/rBWnEEXFql/Jtp9zRBu
	2t4tpN4VWcLbjbpSn2YmAkLSOf3jlmVQ5Ln4hQVMb5qrCz+qd+k/8452c72O4RulKYOiNYQ8Fmn
	4
X-Google-Smtp-Source: AGHT+IGURQoOZmT0VADwApzGELlzINFo38YXfByrGWg2Ni1y1nx+tqmA8GUagFKnKRP6LUAH52Mcmg==
X-Received: by 2002:a05:6a20:244f:b0:1b8:4dd1:e3ca with SMTP id adf61e73a8af0-1bae7e878cdmr5442901637.25.1718426159738;
        Fri, 14 Jun 2024 21:35:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4ac192848sm6823953a91.56.2024.06.14.21.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 21:35:59 -0700 (PDT)
Message-ID: <666d1a2f.170a0220.bf5c8.5c4a@mx.google.com>
Date: Fri, 14 Jun 2024 21:35:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: linux_kselftest-fixes-6.10-rc3-4-ged3994ac847e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-livepatch: 2 runs,
 1 regressions (linux_kselftest-fixes-6.10-rc3-4-ged3994ac847e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-livepatch: 2 runs, 1 regressions (linux_kselftest=
-fixes-6.10-rc3-4-ged3994ac847e)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.10-rc3-4-ged3994ac847e/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: linux_kselftest-fixes-6.10-rc3-4-ged3994ac847e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ed3994ac847e0d6605f248e7f6776b1d4f445f4b =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/666d1939a6986b69557e706d

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.10-rc3-4-ged3994ac847e/arm/multi_v7_defconfig+kselftest/gcc-10/la=
b-collabora/kselftest-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.10-rc3-4-ged3994ac847e/arm/multi_v7_defconfig+kselftest/gcc-10/la=
b-collabora/kselftest-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/666d1939a6986b69557e706f
        failing since 73 days (last pass: v6.8-rc1-4-gb54761f6e9773, first =
fail: linux_kselftest-fixes-6.9-rc2)

    2024-06-15T04:31:15.426622  / # =


    2024-06-15T04:31:15.439125  =


    2024-06-15T04:31:20.561504  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/14353478/extract-nfsrootfs-j9d2t6e1'

    2024-06-15T04:31:20.572408  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/14353478/extract-nfsrootfs-j9d2t6e1'

    2024-06-15T04:31:22.814737  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-06-15T04:31:22.826327  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-06-15T04:31:22.946570  / # #

    2024-06-15T04:31:22.954315  #

    2024-06-15T04:31:23.071625  / # export SHELL=3D/bin/bash

    2024-06-15T04:31:23.082099  export SHELL=3D/bin/bash
 =

    ... (46 line(s) more)  =

 =20

