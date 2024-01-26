Return-Path: <linux-kselftest+bounces-3616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE57F83D23D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 02:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E100E1C22008
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 01:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C254EC3;
	Fri, 26 Jan 2024 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="feSmtFP6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE37465
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jan 2024 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233676; cv=none; b=d42RJBhUMocxwZTx8y+OYYMC3f43DU6ECCiK3yJVMAUX4smMgoTnCahXq8IYwX/rvu+F3oDHbGYtfu1u7yNeSdqu6m/B6Rk+kzszVmeApaB3IMBP7UCIdNeyJGqUFI8kABNM0yzvu5Ie5CMVs69Bh+RhWZ8dzRvJ388IayvQBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233676; c=relaxed/simple;
	bh=TWThmf6bwRA6+TDfUD1gxd+CjURemQJwYjqO/gfHVdQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=kGwJPDaNNgwKdBEhD+UAT8atbxhrb2Z4k07QfK6SZlXsYITv8ZDVWD8VkROGpypKUIbaxMi5nS+VvodCNIg6wbCeMfFo3ZT/YxUm7XVA254nb/IrJ1E9a8RZ1TP6LlIxOBPbcihyJq4bktM3tKMHVsv8BKZ8UAKr2Co4JdSK240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=feSmtFP6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d89518d3b1so6050015ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 17:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706233674; x=1706838474; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vi2ALMmlfa+medR8Sw4z+rpZDHzuIi9Zoe+TvnUrI/I=;
        b=feSmtFP6piBJga97osqft0/r4hOLWP+60PDmflfoe3RJ5bNqBtR5ErLHAaDKCxuYnq
         luydFUMpebd7uH6Asu5WsVfg8zlEYn2d6LPrG2U+Nu1bmaYoazQKaMmUJbNTtbr24aL2
         vX7H7Jke+TYThgZ99rnN0w5YaiZYOOLw3QZ/F9r79bOBj1EBhp/PEWxjhy4krFYBe4M1
         SJlR2vPsqBBmfpGTca2PuYZTYZmbb4bLFyxFwpA/UAvl6S2NGbM78MZCkwwl6noEGvSA
         Prhl6AR+pjohMe8SW4dDFFc6nwRkIFEy36Qrzncfz4bGlDfD+wGngtigzV4iqopmsOkU
         siJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706233674; x=1706838474;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vi2ALMmlfa+medR8Sw4z+rpZDHzuIi9Zoe+TvnUrI/I=;
        b=rPMW9A/PxEpGuiWnm94UQ2QhIygB/RYmMuvz4Cnv0AtMkWbl0btaXEfrzln87PGvxS
         cvpHMGnZtWtoqeOX4RxtDtZiEpA+N4FTaDmJfKb5ElDIvXmdL8JwcYOGy+vb89oOtFxf
         qMZD/JOgfHOBw4xb2VYMG/WzJZAk0OuZwv5dUMP6lz1hItEYlgE78QXO+/xFrbShygkt
         h7f4qjR8CGQSGobl9gGEskLjndFf8ScWqHZHqg45QWcpW6itL3J6YALatF/y1DGkk8D8
         SNZmQeUUenIJOzEzGE15s99nxjhaIXBn6ec3nxDYQpQT3ARJqJA3qPlc3WcEvs1yFQOa
         VZsg==
X-Gm-Message-State: AOJu0YzjZUtoiOO4yaNO0sMv70Jz1NE2vIll0B/ZKAALqfBKs5DPNIkk
	r5CRMquyu2EklAUXASQVQ7EW9g2k+rlmRADdxlILl3Vs7ofEQsPyAsqmO61FwKFRBewF2G9A8gc
	nqkY=
X-Google-Smtp-Source: AGHT+IGjJsSIa7bBTjllNLCWXC2LvNLk4WkBA415fF4tGTSza0sWz1t+1ftzFe4Tf1XBZWgZEzYcJw==
X-Received: by 2002:a17:903:22d1:b0:1d0:af63:2403 with SMTP id y17-20020a17090322d100b001d0af632403mr279447plg.50.1706233673839;
        Thu, 25 Jan 2024 17:47:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ka14-20020a170903334e00b001d740d195e0sm139648plb.93.2024.01.25.17.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 17:47:53 -0800 (PST)
Message-ID: <65b30f49.170a0220.db1d8.0729@mx.google.com>
Date: Thu, 25 Jan 2024 17:47:53 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-5-g93ffe3f1e97da
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lkdtm: 1 runs,
 1 regressions (v6.8-rc1-5-g93ffe3f1e97da)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lkdtm: 1 runs, 1 regressions (v6.8-rc1-5-g93ffe3f=
1e97da)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
8-rc1-5-g93ffe3f1e97da/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.8-rc1-5-g93ffe3f1e97da
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      93ffe3f1e97da3657451004145e767f88ca218c6 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65b301baa1d84d934952a3f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-5-g93=
ffe3f1e97da/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-5-g93=
ffe3f1e97da/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65b301baa1d84d=
934952a3fa
        failing since 465 days (last pass: v6.0-rc1, first fail: v6.1-rc1) =

 =20

