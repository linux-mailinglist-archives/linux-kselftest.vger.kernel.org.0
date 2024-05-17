Return-Path: <linux-kselftest+bounces-10328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF598C80D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 08:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F5A7B215F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 06:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1611119F;
	Fri, 17 May 2024 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ONByzwf9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B0A125AE
	for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2024 06:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715926540; cv=none; b=M8h6zUhisqwfzYiQD+eLb/e+LlX0A//ZBsAEyReYX/s2COM9Q2ZXZVrzPq+Z7x07xPJ3V/aT8oxoTsub5s5nWHo5KjXs76Ch3xSVt2WosvHnGGDq3bVRpkEEGZxOJy9P9c1Pfr/SHQz7ksictPBMv/EUQ5whcEgjltUZfb7hwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715926540; c=relaxed/simple;
	bh=D9hP8ufUvdc6ZFJPKe1v0+5HHLwfEEOv+y31vZgwkXI=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=fPkHBjiWDjLeFxoJ5IrveJaVPmSjXtEnagDYbkG+Hp8z2/RjG91S3rXnR3xKFjV6djCe3m3jbFFhsT3JKEdP3jtuWWFLiKZoYBstu6JR67dkh3RGOg9pCJXQnhyHqohECwa9M5tdU62ogIwBSHZLN7tzQ2jOdqMvgylHRyf9FrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ONByzwf9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f44390e328so950379b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 23:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1715926538; x=1716531338; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mTqXp1HvtNDP22k2G7R4lwA9uAd7WUesHuUlesvK+XA=;
        b=ONByzwf9Co3rNlSssMa8oI5ZDUUUBL9tIPk7oMUtx4Bc+7ZC79WYm2dGt7QF+2HzdJ
         IJqTf2sYNvz2nRCxzu2iswH/0xxvQgtggyR/WOrgeF0mjKfksxSBAxqYD6d4AFCDp0FC
         iXAMPoGYWgXzFF5yamg6XqDJBGkQPtUZWnPpNLARCSfet96bkYncIv9M/wxGTRxZiS0f
         up1tWzRNjSwVSah0LPUm6/OXzFQf801XMEloecwzBYx6PBqH8Yap2FSlddfp3EmH8YPl
         wUsYFr9YgTVmRs87EBTcBFM0tLCf2cJWMqAHqvEwWDIiJYRf7h7mlRb/qQbhotPhyPeh
         TRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715926538; x=1716531338;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTqXp1HvtNDP22k2G7R4lwA9uAd7WUesHuUlesvK+XA=;
        b=hYt0dlmko47DLbf1A7NTPHWvlJTFTIYLAU98byPdQTv6tTJzF15r2tfX4HZ41rjKHe
         ABdGjPbIVEtYT8lNFxqcK9BboB04MIitGcPFT/Yqo1sP2o/zAnYrbpHdNUE2z39Yw727
         JvGlZ07Fq28c/GnkfEFX87S23v/M3MisBWjIrjTJfl2JGHEKwMXHgRpuMzgWlo/KgIJf
         5Gba9+SkSJR2kS8WDi7Qe3lQLdUdlK1YYLpDBDgbrP2IF8SFuLkkECv6jeatFY3rYwMA
         BoOR0ZRyzZVuND3TSKMS9nWjiCifGm1ZhvKQcRfenO0xji8jh7dmQdtXK1EaQB0SPbEP
         mSGw==
X-Forwarded-Encrypted: i=1; AJvYcCUdluwFo3jl6U3T+zkaFGnnsoa6eoJ4jGuHm1pTu1LKtusV5iQL/S+qWaj8GGd/4mEfu7uEU1jWt/VF44WgFjB8n4XxcsMvqfvNn2oZORQK
X-Gm-Message-State: AOJu0YyZrGhXf6ztuezXXnTfxfe4euFlDTFh94/qcUpKlJVT2OYf0P7e
	hf7gFDBsOTVkQI1bR0Iri9GSS9o3PvLN+DkoYgQDR77Cgz8Wep3Q6l2yp71T/SQ=
X-Google-Smtp-Source: AGHT+IGT2U+3oVWrFseWtDZdk4tFaCXSm7qe2t98690r4lxqUFLcVO5I3SyQ3jxFlyaWq2FVARfdcQ==
X-Received: by 2002:a05:6a00:1990:b0:6ed:de86:be57 with SMTP id d2e1a72fcca58-6f4e034850dmr32840142b3a.25.1715926538090;
        Thu, 16 May 2024 23:15:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ade27fsm14044440b3a.108.2024.05.16.23.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 23:15:37 -0700 (PDT)
Message-ID: <6646f609.a70a0220.28934.4bc8@mx.google.com>
Date: Thu, 16 May 2024 23:15:37 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-8287-g31a59b76b978
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 5 runs,
 1 regressions (v6.9-8287-g31a59b76b978)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 5 runs, 1 regressions (v6.9-8287-g31a59b76b=
978)

This legacy KernelCI providing this report will shutdown sometime
soon in favor of our new KernelCI infra. Not all tests are being
migrated.
If you are still using this report and want us to prioritize your
usecase in the new system, please let us know at
kernelci@lists.linux.dev

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-8287-g31a59b76b978/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-8287-g31a59b76b978
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      31a59b76b9780a9b2d385024e2d6d0d051bb06a5 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6646e8cef167b1cf9e4c446b

  Results:     62 PASS, 4 FAIL, 21 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-8287-g31a5=
9b76b978/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lk=
dtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-8287-g31a5=
9b76b978/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-lk=
dtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_FORTIFY_MEM_MEMBER_sh: https://kernelci.org/test/=
case/id/6646e8cef167b1cf9e4c446f
        new failure (last pass: v6.9-rc7-44-g2c3b8f8f37c6) =

 =20

