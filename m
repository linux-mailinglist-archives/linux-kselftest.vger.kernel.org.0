Return-Path: <linux-kselftest+bounces-5151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5599385D3D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 10:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FE51C21C22
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1DD3D3A8;
	Wed, 21 Feb 2024 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="IGSIBFhO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE373D0DB
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508422; cv=none; b=mMkHJolOvdhPlSazHNWBhTjz+/j406HPuQY3M3ZtqM5/yFPGceMMXezeD2K62G/G4UNqYO6OoEPY7xjFZPJavm1XMwp37NqcYzmXy/vtYBgMkvGqULgJetZQhaDoBwltp3pXx3UCaA2ZjyBQMH5fhpacTOw92eVfi/1nN2T0QTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508422; c=relaxed/simple;
	bh=Q2k3gb9CxNPMrWmOl9LcswaxvbL6d+LT+uIvF8bXGKM=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=BrIK7MlmP+fLIC+AvcVbrSdC9rLx3ZYGsdI8UsMEuck84JTudhNrOS4eNL1golHLuzBKlZHOisJ+tSFOwtp2uNeACg3HQMVxdbWwd5wEUwrGFMJlaqKQB9u+6T5I3Jcv+t41rHoVFBADbJI/z+X3mDY/QOOHSXpNgJ5t5QedviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=IGSIBFhO; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-21e6be74db4so2936276fac.2
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 01:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708508419; x=1709113219; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yuUsHCHwqkkxZylzpOL/MqugzJL8+Op71yFxxesPyPY=;
        b=IGSIBFhOQbZDMOfdJZ16/uTn1U6asstaDPbVxKatSQFNnKkh7Uh2IJrkdFdV9p1BxC
         OWtQjsMbPBCmqjwSHy8vMu3sqRAlUwhfSMvBU+dATyYFAQhbdYZgrvAEuuNL2M7KgW7B
         OG1tCicvQcdhYO5tTiZpDJPOKxFAnv9P/Aw1vMPqOPc111dao9WBWPvLoz8j08nWe0l7
         aCTbLcoZHTc2aMG2vxQRJboOxcrbRsAooC0rT3yEMXtl15bZJbnmb0ywbn1RF6Rbl2S/
         oxCX1wjCeDigAwKpdxilSmU6xtr2+931qyg56V4A+lT4BcstqH5w6VvjYw5kFHxFF3tc
         FXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508419; x=1709113219;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuUsHCHwqkkxZylzpOL/MqugzJL8+Op71yFxxesPyPY=;
        b=AC1fbgIOsT9jDppPbQwFFrZqHMFx/AA/AmAg4cDEEckrrs6fOs/ca8f56Kbi/C0C43
         mD7Pt01ZoNM7Ijs+SjpvUK17ZhT4oqqSxqxez/qEmRAnz0lnLb+DEocQJVIheNdbOMDZ
         358DOzCywV/z0k+Kh7MQIxnyHR4QB+WKcx0xpN0fh7BTnqOPPn6CLQOw1TWLdI8wOtqn
         kL4EkM2FNg+DS7+Ct7+AadwAIZlKaHdrVCkNhdN9/11XSYVXCm8cMR2qzzHzxIeg4U6t
         qQ2Cg6Z2uekRK8FXrEbGO+UIZSkINEq4XCRO19VnTLKvwQFmvYpT9+cOpuPqAlpkJK5d
         oOGw==
X-Forwarded-Encrypted: i=1; AJvYcCWi1KLQOd34KRqdtxXV2yBDYNuLC/vdTgHlEbHnXsdd1I6YakSh6HY1yoUlVngUMWvGxk3f99aM1feWou30+vbkhFmELv/FGbkOHrI9RUwg
X-Gm-Message-State: AOJu0YxB4WPW0xJi62ZvUQsaM6i5mJPacfQQw/0HymFfYtOOAQ/qNY6p
	D47wfVeCHpT9o7TF/Gmtmgx2f5QVCRnB2nEGalkSACGfbH1XpG3zM+wLrAkXDiO8Gx5CFcm2rJn
	u65A=
X-Google-Smtp-Source: AGHT+IE1OT2QdYazaso+sga+mEvlJXspQwheCqcHJFpWHP5LUCW0P5zzTuFP7kf8a4K8TAA5obJWNA==
X-Received: by 2002:a05:6870:2197:b0:21e:6d9f:136 with SMTP id l23-20020a056870219700b0021e6d9f0136mr11830282oae.27.1708508419054;
        Wed, 21 Feb 2024 01:40:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s2-20020a632c02000000b005dc98d9114bsm8075211pgs.43.2024.02.21.01.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:40:18 -0800 (PST)
Message-ID: <65d5c502.630a0220.2f888.8d6d@mx.google.com>
Date: Wed, 21 Feb 2024 01:40:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.8-rc1-48-g6f1a214d446b2
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 3 runs,
 2 regressions (v6.8-rc1-48-g6f1a214d446b2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lib: 3 runs, 2 regressions (v6.8-rc1-48-g6f1a214d4=
46b2)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-48-g6f1a214d446b2/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-48-g6f1a214d446b2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6f1a214d446b2f2f9c8c4b96755a8f0316ba4436 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d5b7faa65aa84260637018

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65d5b7faa65aa842=
60637019
        failing since 491 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d5b979181fe9cfff637040

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meso=
n-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-48-g6f=
1a214d446b2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meso=
n-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65d5b979181fe9cf=
ff637041
        failing since 488 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =20

