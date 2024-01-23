Return-Path: <linux-kselftest+bounces-3416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1A583916C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 15:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCFD1F25ECE
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 14:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0B841236;
	Tue, 23 Jan 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="HmUt8cOQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE068F5A
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020365; cv=none; b=HDA06dRGUhu+hsEu17gljrcxg0IexP8VtE2Z93AKnH93yEMA/2CnPTgLA3/lWRZXWffqcBD/3S4dGddosR1h3qkIhkXlQLYThmbWiZfp5N6iVFCmOVf3EyaCUWrWdG79Z1rowkru/21zOXUdgGqafpbKu99QH138cKNfRuh1LZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020365; c=relaxed/simple;
	bh=kRVDpAxIcl1Atw4vspN60woaUNtqok3Cs2NPblxrbdc=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=mPbWcLaenD1BIC+Fh/tYkBExqngx4Ji3t0BzUzY93J7lCFNn1i6gxDCetSgIENYvsH1ndAhw4lo9O+aTGGI1hCnADLXJ+MY71UgTLSI4XGo+qXLCijGWdWtm8cwComTmgKXqrlqUBEDG2hCU9lAEx889UHJ6M5ITIfATJo2ztkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=HmUt8cOQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so4306642b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 06:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706020363; x=1706625163; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jWqa1eXDK5rBcQL1FvD+rUalH3/g8SEky9cyLH4NfNY=;
        b=HmUt8cOQw6JR/DvLIElNLB69Uw4h+zajngM/tFpMXgsOPyVm2bgAJ62IvvYv1H5l15
         dCa/eJWJOFxfEz9PttJWARfIu6fikerE3bxFoGw+cCxLR+9xxfvt7AextnKJrnVpNRrj
         g6VgyBZwYdrX7ACebxHSyDxBJn1tRr6EeipSVOl6NqSxfSyJ3ofOUPi6ORtHCdOTQVi4
         /gXg+3eGqZFOnGo/Efcc2gHMQU/MAgRs0/b43bhGSww0dwwo8j7GhD9opklLnA9tmgPc
         HaxS6Nt717rw59U7Yn8ixUacjwmf6FQyowS/KKEhbghcK0kj12gzHjbMUa1I6rwaQRvu
         QylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706020363; x=1706625163;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWqa1eXDK5rBcQL1FvD+rUalH3/g8SEky9cyLH4NfNY=;
        b=qaYNBJ/Lz2m2PkWgHJzN/6lV03O9uYMEi+iSXKMSkWf/8Y/4dXC5pm2b0i/4blhiAP
         GBWwYlv63fWEZ47/IN9u6eId/rAn9LnDiKpMnn2zN2DCWDIbYHl7pKx4RKtruL+yTH97
         z5lmn7v77GcRxQmymNMmRMOsMUlf+Q4zhj6ymbXBJSiSqGDXGcWINb/OcSXv0UCtICB+
         R7YyGZ8K9GgCbZGbYfrLmC5hsdayssDcpwxf13uXtqNMtkAFbDWtsAIQ57vkVnwfufBc
         JHwaQX2SfVwd137WCmcGTEcLEYexuTP1ldaxWiaMlVDOhLRdxGSpeOcxN8BC2lKP8FkW
         Pcsw==
X-Gm-Message-State: AOJu0Yy5lpcAdcRcki+cIaHhkhMdQ+KhVsNd2Mo/Mgd5Sm8oARW466d4
	p14Zlggc1q+USXGQUk5ypn9JN7HdrkVk2E7jG0MNxSPiL3VvNL0nHhKu3ThIQ7g=
X-Google-Smtp-Source: AGHT+IFKpIGsCIILx87EX8j0VT0cX2mvWSYgzGZw412GXI6eQKvNTSSVkDqK5uSDU3TXqNHs2hOL6A==
X-Received: by 2002:a05:6a00:3d4d:b0:6db:d5ba:ff41 with SMTP id lp13-20020a056a003d4d00b006dbd5baff41mr6396100pfb.51.1706020363061;
        Tue, 23 Jan 2024 06:32:43 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fk17-20020a056a003a9100b006d97f80c4absm11589629pfb.41.2024.01.23.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:32:40 -0800 (PST)
Message-ID: <65afce08.050a0220.3b433.92c2@mx.google.com>
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
Subject: kselftest/fixes kselftest-lkdtm: 4 runs,
 3 regressions (v6.8-rc1-3-g6c8c9d6e1bce2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lkdtm: 4 runs, 3 regressions (v6.8-rc1-3-g6c8c9d6=
e1bce2)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =

mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
8-rc1-3-g6c8c9d6e1bce2/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
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
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65afc10f5d8ea2707752a4fe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65afc10f5d8ea2=
707752a4ff
        failing since 462 days (last pass: v6.0-rc1, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8173-elm-hana              | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65afbeb9312d7adb6752a3f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65afbeb9312d7a=
db6752a3f2
        failing since 461 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+kse...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65afbeae98df3435d752a41f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-lkdtm-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65afbeae98df34=
35d752a420
        failing since 461 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20

