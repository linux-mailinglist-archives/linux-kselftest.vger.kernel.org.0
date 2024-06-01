Return-Path: <linux-kselftest+bounces-11075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A97F8D6D4E
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 03:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8390D1F2330E
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 01:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A684BB67F;
	Sat,  1 Jun 2024 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gY6r8H4m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8936FC7
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Jun 2024 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206169; cv=none; b=GsDjA4XR18zdXRF+6Dxd270PH1wEjcQmQEFs5RutrxSsLEciimeKy5m9xn1Nm5d0khUo2nGNRS1qs0y5+y7JH7A/AkL97m90Ft4OM5CBOCyXzmP/rcK2nw6QmuaKAPaSaGQa+g8wBTW7sCK0HIiOX4eaJLeueyqUIUHPzwdMsXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206169; c=relaxed/simple;
	bh=hnpxE59GadseB3nBEjBA8paeuUbnmtRKhDD7Spexg7g=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=IzCbTg5it5B7MS+IyG1ngc2tYNmSey7ZWiN0z7EwM+m0OezzKT2sYtSW7gLTlMcv4uIWNZ8fvZEN1vInEwav4E+/GlANHkc6v07PrVWXGvkNZnnetSLm50qSZsNN4oPL1UhpNdMaQ/ThQ5WMYXVG8T/PnZoYqsn0jswXnNkRIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=gY6r8H4m; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f48bd643a0so19648395ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 18:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717206167; x=1717810967; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cdErN/+P2r4sZTmDw85t1bE58FtS1MTnNdLORb0wHpU=;
        b=gY6r8H4mkuy0y+xlcgKTTxeRvIXwlMs1i7gH46Cj/JH6DzJp/RPl4V4XhxIAAyVuiU
         DEhosyd0/EN0ih5zK8s+2pLahaFrlLsNVN3hRtR2A6uHiozbkS4qsJJaIXi1xM/9RtLC
         aH7cSy70f+iS9Zz99d2U7ukjK1yBY6TpBvCiDuokr6gnBb5neF0twdtlknsRberdzKCU
         ttF63NFCYdpNztHs8QIyqxBfKRZJZw1VPVyepqokIy/6hETwu//IHHxMFiXYDBPwCyMj
         UaR7y87QqNC/r9YKqvVyRl0Rj266/QL/zm2OZyL9nrg6QI4I0BrVg+2nzhIXf36s01El
         /5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206167; x=1717810967;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdErN/+P2r4sZTmDw85t1bE58FtS1MTnNdLORb0wHpU=;
        b=UDNuEphg9fw4lNIVt8r+rx3JDiecWtqCd1e1gNDPHE4GQ85ym6s4PFOr/338RjKwsJ
         NtnIXysVeCPh3Dsa1RjhlkgPRE7UFpbY5QG6zGDJ/EpKqfGO29UVBmgrMahyRn98vst2
         tBxWvdUrc/N5Ek65x/XdUdMiJWE/f6EC92iZZReuBvwoX+cQn6oBwZ7EFYzGS9344/Jl
         qR/kbFWYAzhtOfRp5ygE/JvLYfLvLQLdXZFiotMVXLW/AqwBxeB6HE26aguQXySNJ+wX
         NJudJ/wNAfrMt2+Jq80WT/e6lzUFGnV88dQoJ+BB8RaTJtlH6/9MvjZO89MqXm8jJJcp
         MwOg==
X-Forwarded-Encrypted: i=1; AJvYcCXOmPNDSJosvfAAsA4jS0F8td/kqhCIgCklUVqQo+0scguyxqQm+xSp2BXtH+ei0iX+Hde2VortzThvniM0I4oNOoYQJONTw86q59CsycoM
X-Gm-Message-State: AOJu0YyzjZr1Iu1nesmgGe/pBEm8149k7STo+3QghCj5I373n0WbkNiU
	jGovFC/eXQdVWptAEXUbKOFibrUtnEpUMHKip7pLoFnNinMguYT0yq0TBroZ3/LhJWLNYoesCqb
	/
X-Google-Smtp-Source: AGHT+IEV18k2W8aNx3KUJ+lHjOlpHQoUXb9K0532hsbi8zoP0SIj/m9UL4rsrWTnCruObOGax/r3tg==
X-Received: by 2002:a17:902:6547:b0:1f3:35ff:ad25 with SMTP id d9443c01a7336-1f6370baef9mr37755045ad.63.1717206167259;
        Fri, 31 May 2024 18:42:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm22727955ad.147.2024.05.31.18.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:42:47 -0700 (PDT)
Message-ID: <665a7c97.170a0220.1004df.6ec4@mx.google.com>
Date: Fri, 31 May 2024 18:42:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-11-g4bf15b1c657d2
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-cpufreq: 9 runs,
 1 regressions (v6.10-rc1-11-g4bf15b1c657d2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-cpufreq: 9 runs, 1 regressions (v6.10-rc1-11-g4bf=
15b1c657d2)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
10-rc1-11-g4bf15b1c657d2/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.10-rc1-11-g4bf15b1c657d2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4bf15b1c657d22d1d70173e43264e4606dfe75ff =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/665a7911e0ab3de6777e7073

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-11-g=
4bf15b1c657d2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufre=
q-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-11-g=
4bf15b1c657d2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-cpufre=
q-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/665a7911e0ab=
3de6777e7074
        failing since 0 day (last pass: v6.10-rc1, first fail: v6.10-rc1-9-=
g0f42bdf59b4e4) =

 =20

