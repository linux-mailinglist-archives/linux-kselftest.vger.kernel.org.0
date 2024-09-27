Return-Path: <linux-kselftest+bounces-18518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D56988BF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 23:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCFC1F221CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 21:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FFD18A92D;
	Fri, 27 Sep 2024 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="K2UkHR3p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54C171E5F
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 21:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727473559; cv=none; b=j7tdITOIAM6RCXq2in4GCnL5mAbZ3jUPyuEVzGTEvXs8uCKU9BSHMCxs8qxt+MMpX3rhtMEM14d+EX2ykY8SCoTDjRiyZp9idvvYByVSF2S6HT5k1+Z0A1vzsnw0gonz164sqLwPermXYdqU7gsMYjFvRojzypkDratg/rbH4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727473559; c=relaxed/simple;
	bh=Dn+5co4Ik7qXfVp+tmlGU94lXVpEMC43+qqGeuUfbnw=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=PJSoOQrvVrT1P205jCzbql57uOkvGEPXecnf1hGjAORcdSGungkWwpmIkQlcn2ybDmx/FkydrbdEwprDkrl3Goymws4JNiwRzRzgqL6uJKsXTJTXK4wrEMIuVgdz0Kns2q7tpJFRy2xFuocBWgA2/Yf7HkUDJAJDkm2x505HjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=K2UkHR3p; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718816be6cbso2304298b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 14:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1727473557; x=1728078357; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7DLirDrMuCTEsjziZAZCEw2KDnGuxQtgMwz+CHkSY3w=;
        b=K2UkHR3piG1PXJKHOkCepHk/vBr/M7imOcWBlUJoEIVawbbqdKr0QGmgd4vHVwuqW+
         dhLmJ5zGF0LrDetrKgAxvkk0A42F6OuLQ8uPQQ1zbnUAwgeAUBe2jHY1hioBZYLxAbrk
         Erc57ofLe6lHS3IXyTQmk5qaoiRz6k4Pyf21JkDmDwZ5D6hQVadB++kXZnt7gB/xvDDu
         WFI+7pWqpJDk3qXDhQfBr18tc1m60mO+XJibvL5mvh16bz6YGbmBb6ytANhIjHp3zq+m
         mu6JR3bVXC9vmWrysL1x3/1xcRIavmDnKMHgXFZQw/FEYDP6noa+dOFffLulXln3qQW9
         LFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727473558; x=1728078358;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DLirDrMuCTEsjziZAZCEw2KDnGuxQtgMwz+CHkSY3w=;
        b=VpvR5jzr0GFZzgQlCRzWo439K/qB8mP2IVb/OrQ+vAsiK7vblv1LChfxxP7kt9+pz3
         smrMO8JBACwTS7ggv0AKRWuUaxl0VKamuEw81oscunmE4E5U5jaaMIZqa+rmq6Tt9bKA
         +wrwWb+rSB1AQbRm+Nxl7VIDbHpXlorWzL9I1CU1DX8qYgqNSJiIbdyPG4u44xl+Y86v
         CrZHZ+Jvj9ATOcazYamlPrzx/abOQBeqnmQt8MIqtiN6LuT7iEmbdDH1plL6t3Z7/sBM
         pVVTTJJ0U8eEIupErDH20eUt/kqfL9VjO3ujtaIwlKGvoTlrJ2uxxwQNKstTEFsIvTnY
         d5ag==
X-Forwarded-Encrypted: i=1; AJvYcCU5mtxpojh/uIggcCf5Sevl6NfMknskRWtEYoIgwRYC04JZ35CP7HEbrZIT277vTOIQpC+1AVflY8YAtHk0+mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDQO9r31muYqR6IbQSE+eS/9+hqkj3ltC/aGMsq8Rw4RCxTtV
	mZv8Sadj9ZkB+zCyjAVvsd7vGGXHZW0robacZfhNu572SHxCZMjRf183KXFJSm0=
X-Google-Smtp-Source: AGHT+IFPAlV7ujsLCTXlyy+snKCV9vUx19ALqlRQkAiu9hVMAu+S+qiEaulBwl/crX8aoGOObsRgrw==
X-Received: by 2002:a05:6a21:1690:b0:1ce:d1b0:bc65 with SMTP id adf61e73a8af0-1d4fa7c7282mr6068409637.43.1727473557625;
        Fri, 27 Sep 2024 14:45:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264d73f3sm2120108b3a.90.2024.09.27.14.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 14:45:56 -0700 (PDT)
Message-ID: <66f72794.050a0220.191cb6.cec7@mx.google.com>
Date: Fri, 27 Sep 2024 14:45:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux_kselftest-next-6.12-rc1-1-g4b721fcc094e
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 2 runs,
 1 regressions (linux_kselftest-next-6.12-rc1-1-g4b721fcc094e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 2 runs, 1 regressions (linux_kselftest-ne=
xt-6.12-rc1-1-g4b721fcc094e)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/linu=
x_kselftest-next-6.12-rc1-1-g4b721fcc094e/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: linux_kselftest-next-6.12-rc1-1-g4b721fcc094e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4b721fcc094e9eb6dd4702df8d79ab11e120833d =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66f71c2a254fc0e2a4c8685e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/linux_kselftest=
-next-6.12-rc1-1-g4b721fcc094e/arm/multi_v7_defconfig+kselftest/gcc-12/lab-=
broonie/kselftest-seccomp-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/linux_kselftest=
-next-6.12-rc1-1-g4b721fcc094e/arm/multi_v7_defconfig+kselftest/gcc-12/lab-=
broonie/kselftest-seccomp-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/66f71c2a254f=
c0e2a4c8685f
        failing since 59 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

