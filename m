Return-Path: <linux-kselftest+bounces-7236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5048992BF
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 03:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E121C222AE
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 01:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F262256A;
	Fri,  5 Apr 2024 01:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="KjuvqYvh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE822AD23
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712279858; cv=none; b=JkZRLiPRBYW5EwzfQJxyPJXYonzrFTqbedHmxwAglhVy2JF/rIidQV2yvKieDMXdzosPn1+sbEKP9BwTH9hy9ffnFfUclalXZqV4x+DegK89O+uxyeMqUhg3fu0aXSqVIvP96zI/kJ/H1X2C+d+A9Xp5jwWKPcebGVUZBGWTvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712279858; c=relaxed/simple;
	bh=+g7L3scXyIwgceQbsdUcaMyWeC5qVSJ6514AMwxlRts=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=tHZElrXW32Q0qkAP5Zg4K4cgdSjgdTCc3j4gEuYnPAADc52YdN6aIETE1gYLRO9bVtjcaoTbaqPDRdiyz+SVM9h8GV2e9rEHNkJTc06vhzdkjhjj8sJ0Z/ztyielKKVBW1vxeU3oKjYqZuJ1ZI+ANxr9G/r7Zc62XKOgW1sv3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=KjuvqYvh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ecec796323so1254605b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 18:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712279856; x=1712884656; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=33zd2GNtNRTWN3d/GSXCcs16pHgm6apuyfsBkEe3sXA=;
        b=KjuvqYvhDtpos5lih0FWQF2Edy/NX1rrBiOp9bmdarjhdD5Zy4XvlJVplw+nu560z7
         rESRwqqxmj+KO+/EtQWqSwHuovxQ1JouQQAvZIu7cHpGTRFM+yTcfmifYlN6Yvc9/gts
         Zwo4ZztNvLH64LPwK0N4IQ0ZzwFiGSh8TcFfEwfzKcRI4E7yW2mnV70W/XeZmRoVmucN
         U9YeFzuO/Ibpx8J2HAOkA/SeVOduS9aipvBLJRbd7Cs2X6IP8ejWn3Kfp4qw86cjFAR0
         lbVYuaUcUCkHOo1TzjEKPdtMnK+ZswqZZ1oRDtqO+hYbf36LBPjWfrf+VsYjDfRZ+9Mf
         A9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712279856; x=1712884656;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33zd2GNtNRTWN3d/GSXCcs16pHgm6apuyfsBkEe3sXA=;
        b=qQhOlkIa2E/z6MYw3DYsYD1XvoIqE1boMB41zf7uXWvVlah2YzsvZtXF+/y3jdvYuP
         0Ch73R4cQnp2yo8sEo5C/sq33dDmjP+wAxoVCLwJQLTNBzAOiuMZ/VHrT8rk5fHSmGMU
         vtxBte/X4LKEB5qLPnkYKbYExMFP4FJv0lE67OzVmTULqPL1atPuLEfC45AUuUVXSqZk
         iIDvI/vz5FHsM5BytSUkizb+KUAyNdfqrqIFkOVZpsFE23eZ8sP7y9prwXq6jsgCu810
         Qf6xR5kgU1quPTAfduYRJ+0tshGvpuVl0RhTC9ni0S+xo3/xtgzV9o90gXdJv240dsib
         a4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVibtNFVCAKgu7HUMyilF9hAOKv9NMYK1e7dXWQF2xc4AfgGPDyi5cA1OOIFnNPcMLlOxbmXc9Bves50iRMOe+NIZlGXK4lOV+hsfrWzzud
X-Gm-Message-State: AOJu0YxFnSrMbKIhxkRKap/8Dms7ZWf67BKmT529VvVgQfQZbgD6KNy2
	O6fPA18PsFs51Q16PvhrXDrY4zLQUujpAzjiSgR6ocCdvlmSFyt1gByMtlvh/XI=
X-Google-Smtp-Source: AGHT+IFPDMJjj2WvaOoYEQWHCANiU7SwvG7sdGBSJ973EetvG9rqvkhMm2wuN5cCgO+J2KslUuAPdw==
X-Received: by 2002:a05:6a00:98d:b0:6ea:d114:5ea1 with SMTP id u13-20020a056a00098d00b006ead1145ea1mr165116pfg.17.1712279855834;
        Thu, 04 Apr 2024 18:17:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z4-20020a631904000000b005f0a5118863sm296447pgl.12.2024.04.04.18.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 18:17:35 -0700 (PDT)
Message-ID: <660f512f.630a0220.7ce3a.1aa3@mx.google.com>
Date: Thu, 04 Apr 2024 18:17:35 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc2-14-g4389636db356
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 3 runs,
 2 regressions (v6.9-rc2-14-g4389636db356)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lib: 3 runs, 2 regressions (v6.9-rc2-14-g4389636db=
356)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc2-14-g4389636db356/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc2-14-g4389636db356
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4389636db35667bb5d59422bfdfb3c876c3654c8 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/660f4486286d25ee324c42e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc2-14-g43=
89636db356/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc2-14-g43=
89636db356/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/660f4486286d25ee=
324c42ea
        failing since 535 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/660f460bfe18d4f7524c42fb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc2-14-g43=
89636db356/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson=
-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc2-14-g43=
89636db356/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meson=
-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/660f460bfe18d4f7=
524c42fc
        failing since 532 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =20

