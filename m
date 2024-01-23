Return-Path: <linux-kselftest+bounces-3417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4FB83916E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 15:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C97B25E04
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 14:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B869EEC2;
	Tue, 23 Jan 2024 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="mHk4+LqJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F432E3E3
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020366; cv=none; b=OQ/0akQb9NwqPEtxMWzZ+8Busbbmx6lZaetipaoLCqHF0j3a33r+eg0KLoNuDZkDys8siyAnqYbNqdlo/V55WYpug+21AVBSAjiDQ9sgh+xxi7sqmuYQWY9cKZ/uplPM/nPXrii6skODCAaLP+aH25ktIknLMvq8BeZZLwCS5tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020366; c=relaxed/simple;
	bh=kHt9lT0lnj9p9TwTP7A3g9MCBoF52e1rVoPASZtkqqI=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=u9/pLbRJAjnNLg3yba+Hd230UkJiHWJ0Y2NTc4J5m1jicVaoIPpcPWZkOlIUd7XcWUz1CAUvY6HgURDtPV4BNs4p9FjymCjEqr05iSZSfUHdYFr7g5dyvJVMwEDl6CW8gsER5xaEzPghbBHPsJylvaG37x6qJ9WHOigXntAsmkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=mHk4+LqJ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-290a55f3feaso1523852a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 06:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706020364; x=1706625164; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Co7iJekz2i431vl4/lQ8YhRl41qR0yl18yiHd5wEzwM=;
        b=mHk4+LqJZ9THZE7SIFIsL+XQlMwujZ3he5LlMRdmYjnCDB2Cbyni/nOFCzuMxyn8DL
         +nOOYA5zghXB/aeW/l9T8Nwq0saMZUJnytsQfyl6MpahEw43eQpv12QwLL1+gqwAB38j
         4p5CDHuw5OwabSOSyoJAVzTnXDNu73kJeJ94jDJWV2g8ttNpDP1/FOZ/BQTCgiSOg5XP
         LradB+KmKExL5YzhxOe5p2wVghROaGxjokCVVT6CW4dt7V2jtxDC4eT7XnG2wa4wFor3
         7ZupuAr2hahC42EusM6OjqtQZOkJFEfM6eJNTqHs/79uKQKh/yX7h9VebQuz+a4CAuIy
         dkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706020364; x=1706625164;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Co7iJekz2i431vl4/lQ8YhRl41qR0yl18yiHd5wEzwM=;
        b=s4Cut9MRXp70goYRNso772NSSQ0JbHSzV9lUNkAPdDlvD+NXjcYk65kw/PMSgG8tdH
         9N205QhOvQ4r4l1mi5B/47UnzAiNnRBgXBlSW69/2eVbJG+NWPxrkcNeaP4yOVwaf7bU
         NutudYPCBpWP2FsgRix5IwOhhiU6gg5Z4p0jfrxjdK5LwOjzWiFuWuhgdndRal50D1Yh
         d3viOxe2WRL19rNefthqG0Os80HUD1aIiUeB7AywnjT2xsylYbIDi6/FKn9WMOt/DdQG
         swzyb0b4vfKGgKE3XwmmA63BiLf/JuP0YE0jEaaqzvyQm/rVh8+YhBu5rghigsjNPxlM
         BZRw==
X-Gm-Message-State: AOJu0YzCpzFQI0IhUchVxNZeVGiNwtXol//m7xSOeD8VHcmTtJq0QmBq
	8QNuDz5zyMw3X2En2qznoa1c2GswLOPbWtXTJB1hLRaMDfboHLfdW4SZMgOzIZg=
X-Google-Smtp-Source: AGHT+IFWOtMBGzzjtjnIdAPAIfPsvD2/uOMhOXozCM9sCm/m8zaMAvgfsWIWe14GD0IPFnMxf3uW8A==
X-Received: by 2002:a17:90b:890:b0:28d:f5db:70b8 with SMTP id bj16-20020a17090b089000b0028df5db70b8mr3277296pjb.37.1706020363993;
        Tue, 23 Jan 2024 06:32:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pd14-20020a17090b1dce00b00290e148dbe1sm547347pjb.30.2024.01.23.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:32:43 -0800 (PST)
Message-ID: <65afce0b.170a0220.33c32.21d9@mx.google.com>
Date: Tue, 23 Jan 2024 06:32:43 -0800 (PST)
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
Subject: kselftest/fixes kselftest-seccomp: 5 runs,
 3 regressions (v6.8-rc1-3-g6c8c9d6e1bce2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-seccomp: 5 runs, 3 regressions (v6.8-rc1-3-g6c8c9=
d6e1bce2)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

stm32mp157a-dhcor-avenger96  | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
8-rc1-3-g6c8c9d6e1bce2/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.8-rc1-3-g6c8c9d6e1bce2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6c8c9d6e1bce2871df58a85d2c0c545007c34f5f =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65afbf00bf72bf376d52a402

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65afbf00bf72=
bf376d52a403
        failing since 461 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65afbefebf72bf376d52a3f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-seccomp-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65afbefebf72=
bf376d52a3fa
        failing since 461 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
stm32mp157a-dhcor-avenger96  | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65afcbf0ad4d9bff1852a4e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/kselftest-s=
eccomp-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/kselftest-s=
eccomp-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65afcbf0ad4d=
9bff1852a4e9
        new failure (last pass: v6.8-rc1) =

 =20

