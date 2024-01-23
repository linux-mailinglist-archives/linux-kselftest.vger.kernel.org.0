Return-Path: <linux-kselftest+bounces-3413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0310A83916A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 15:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69A428A4C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A7012E5F;
	Tue, 23 Jan 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ssibCi1U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2AA8F5A
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020363; cv=none; b=QAcD80w7Wf9NxXaIg6ciW7iP/MNrxdgYPMo6Amu0sy36EVuxHqJ5mF0ptxoU4ZHr9Q4NOsRB4/aLOBXHGuVj4XYMCa7qhzs+rLrcwRuEp/qFUVv5lrD1Ggyw1EHqC2NErXLz2DJCoh0koYDgVuqa0Wbl7kPiXw3pBjCDzd3R99o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020363; c=relaxed/simple;
	bh=AjgXcvez9GKY5gO+AycNRmGDNuU2rW64K0IRW64kMug=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=kuxUHHicFA3xO4l15BVYDEkKRbyrMx8q0ud6yGH8flszGSqnTgq7D5/+qCuzgRdm3TG/0FWmEEHp6+TPOvs4LHQJtuCCqujV6v66MY9CslEzzIUpTwtUPEJ5i6Aw+Pqmistasucm8kHGSPY6yR0fXCFbAU7B7nF7apmXPSTH0sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ssibCi1U; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d7431e702dso15355385ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 06:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706020361; x=1706625161; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iBxKhOeF+1cl5Huu1gXbg1ZBJFSpvdL07w/8nQRe2mg=;
        b=ssibCi1UYF1rfZ/xBa1DfZp5780hkyV5sRv3CB02L1y+Ntjsa4rroeiU22LUPyAcnA
         WcDn6DrRhzFdmNWUt+rvg7pdwF1mxRly8tWIm+fpOGzY3ll7GN+keXAzEMZ0wvnljTii
         ewPmvGjiwXEslAfaCDwaGNxD91t45mf9FanHFw0rq9vsEkL6+z/DopwMNMQb4OYGM3IN
         9ECH02QyfuAkwRxTmjkxSCZFurFLUhh+ldfSiWZBu6wmQuWxamb4N/8WgIUzVLyqg4kJ
         NEwii8dm0mTghUAAhrCvFdBtS5aYcipHyiAMIQeTHgmTIda+z9HktN9Ctj3X/S99vKWD
         NCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706020361; x=1706625161;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBxKhOeF+1cl5Huu1gXbg1ZBJFSpvdL07w/8nQRe2mg=;
        b=AFeWXGUfSx2X/gX6VYLtp1/nIQ+zCAEDe0aNShVtyFNJb0Ce4/E6tmgUsseq6P7I02
         Y/L3pd4CT2h7t5Mm/41AWvgTVDIPQoclyxt4yCFGttLP+KH9R4FGt9F+DCffzj16yTTp
         uz2IYBtB8GH0kDWkXrx7ql9Q/Dvq3t0IpLFO/Jlffz2TwteYLXBypxowU10w5r070vWm
         HkVrHqg2WaxFBmLU4qw3VftLF/TKKpQR4Z2En3zeLUtnl6hVNipSagytasxHQYJE/hmq
         dPpYYxiGCteUPFe1NfCqjDF9Wgo/+YcohAP65DBXLLDGOCPx1rCShViPfWui5ci2mJ59
         /IEg==
X-Gm-Message-State: AOJu0YxATdvIi/FFFsHH6+n2rjskG7anvbCUO4nEUX66+xfaJCn7RUmq
	OQ+o3Ze5y2rw6IA6/QJOpjv3ZRAiW9fEVGYVVtW1Dp5+fR1KlWtk0MjNk9743cY=
X-Google-Smtp-Source: AGHT+IHSA5Tk9NnUIDPd7ks7MY7vcDEg/wE3ANE+L5XR5VgCUc8cgM2SgCXQw7RjD9C29QNcBx/6ew==
X-Received: by 2002:a17:902:d546:b0:1d7:450c:be65 with SMTP id z6-20020a170902d54600b001d7450cbe65mr3542080plf.91.1706020361402;
        Tue, 23 Jan 2024 06:32:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902c65100b001d7724c24besm979564pls.9.2024.01.23.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:32:40 -0800 (PST)
Message-ID: <65afce08.170a0220.6bb98.29e8@mx.google.com>
Date: Tue, 23 Jan 2024 06:32:40 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-3-g6c8c9d6e1bce2
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lib: 3 runs,
 2 regressions (v6.8-rc1-3-g6c8c9d6e1bce2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lib: 3 runs, 2 regressions (v6.8-rc1-3-g6c8c9d6e1=
bce2)

Regressions Summary
-------------------

platform                    | arch  | lab           | compiler | defconfig =
                   | regressions
----------------------------+-------+---------------+----------+-----------=
-------------------+------------
mt8173-elm-hana             | arm64 | lab-collabora | gcc-10   | defconfig+=
kse...4-chromebook | 1          =

stm32mp157a-dhcor-avenger96 | arm   | lab-broonie   | gcc-10   | multi_v7_d=
efconfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
8-rc1-3-g6c8c9d6e1bce2/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.8-rc1-3-g6c8c9d6e1bce2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6c8c9d6e1bce2871df58a85d2c0c545007c34f5f =



Test Regressions
---------------- =



platform                    | arch  | lab           | compiler | defconfig =
                   | regressions
----------------------------+-------+---------------+----------+-----------=
-------------------+------------
mt8173-elm-hana             | arm64 | lab-collabora | gcc-10   | defconfig+=
kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65afbefcdc25cadafe52a409

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lib-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lib-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65afbefcdc25cada=
fe52a40a
        failing since 461 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                    | arch  | lab           | compiler | defconfig =
                   | regressions
----------------------------+-------+---------------+----------+-----------=
-------------------+------------
stm32mp157a-dhcor-avenger96 | arm   | lab-broonie   | gcc-10   | multi_v7_d=
efconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65afc85f993fc4360852a3fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/kselftest-l=
ib-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/kselftest-l=
ib-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65afc85f993fc436=
0852a3fe
        new failure (last pass: v6.8-rc1) =

 =20

