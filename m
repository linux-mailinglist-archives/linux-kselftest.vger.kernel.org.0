Return-Path: <linux-kselftest+bounces-17087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B13496ADDF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 03:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17A31F25F8A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 01:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543148C11;
	Wed,  4 Sep 2024 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="m79/X/+V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250C33E1
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Sep 2024 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413244; cv=none; b=vGm8iP678FPX5u8BC77JloqbR2B8TYQKCY6GGOfwx+6Pxq+CqAyWjkIRtl6IG9aChKeZMAtIDr/dubdOfn/flwcgBxiWapKjlsJPlwjytZFSLFefcKGdOJINT3WkNksIJVdwG+4/G26s3yCR/f1bjEZlmqj+7iMHlVMqKHPgwlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413244; c=relaxed/simple;
	bh=bWj2zKGtnVL5bgfN+5PtmLeh4dqxbPVHqPY5xgDn/nk=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=tHoobEeMPRDZIzZ9ra1NP9uItYtSKifS359r+sGZRyWVcks0GA9k0yEl9Ixkx0z9P9vSa/CNw5uykC+wWwYczxbagB0/AFBy7HtZrZTzRiSyk25QW5obVgiqN7J1+unvQEBsl+OcT64+Orn4fJnOHUGfSHwV9LpryhCixuAIRGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=m79/X/+V; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so4315704b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Sep 2024 18:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1725413242; x=1726018042; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eatfEWeChd1D9Vw0ZVq62O7TT8fLD/DrTQXQ7kQkabs=;
        b=m79/X/+VjGk1JnUukmwQVSvzFRr1/1PZp+1nnOoIEzXYuw9o/nV7Fo4Xbs55YPiZjN
         tf12VHq7NAwvEUOBpAtg5Cs/pSEuWypFJn7aL2XswWoN5Et8OxP1QruVPZDcYRFWwMs4
         eHDrviL7rOls89UPZS7ZT8noNN1nSdvGQhwsFFBe2ktNrvNmax9PO4e1wM1lxrJoSF6T
         U/oHqYtsEEnmtRyTjrSjAVuxMkL0+R6fBEhHJaUzhE1h5o/JBxR6e1kBIUMcZXCcFoce
         ynJdUi0ynbT9Js+aq+cQqWG3kxsB+hfryZpjQnPWpz2OfD7Dby1IqceRMaqaKeEchtQ5
         +Ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725413242; x=1726018042;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eatfEWeChd1D9Vw0ZVq62O7TT8fLD/DrTQXQ7kQkabs=;
        b=vLNLFFxLgwyBKo/8ajfTwAZX0m93LmuaEctzVHsmS5inmuVurT89JV+cvhj8Cu2VS+
         m8kmIrOjvLspO3oC+4QPm53nbwAlY72W4Zv/WmmhF8vfKME06uOSMiLu4LZmIJHoSyNB
         vzOSUR76XEUrryvuOOgbkOQiCZSZ9upc4F7h8Ri7me/s3SExX4HU35QKhotVN5XXz6IU
         0gYIt5Hsdqx1QfvbezsjyAZSe6T+pPy8WGtWY1ULUtZQUO5FJqVusy+kO8kJbg2QTd6R
         +y5BVCmbloNw4q5Q++7fLWHL+5UAhRrjoX3+A3I2J+TvXEcTxk/LDsfmoylC0F+nGDMf
         mUEw==
X-Forwarded-Encrypted: i=1; AJvYcCU+1jmXYT8pVcIOCcbLG1EX/wBROKF9v7PhXqhzWTDBT+ThDu7PQa+bXoLMB2zaEsB2oyyrqShOvfJaTndH3jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcp3xHOQFih2hSMI5qyhetV55JsUn/KwiBsB8F1kqksBAq/dV
	jsHioPYQRKp4itGZQ6z5aCPNBAbu2IrKQ1VDE6lebQCqYqgvNn73KgKj/50wklI=
X-Google-Smtp-Source: AGHT+IHFn/If6RQoeSTWgRSMrlo1+JAarcJ+EHjApHgEqN+OGaSKnKR+gzPy0XjqrZ00CAwcVnnVRA==
X-Received: by 2002:a05:6a00:10d5:b0:710:bd4b:8b96 with SMTP id d2e1a72fcca58-715dfcf24dcmr22831719b3a.28.1725413241907;
        Tue, 03 Sep 2024 18:27:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785309e3sm492747b3a.51.2024.09.03.18.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 18:27:21 -0700 (PDT)
Message-ID: <66d7b779.050a0220.28d767.2d41@mx.google.com>
Date: Tue, 03 Sep 2024 18:27:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-17-gb4bcdff7e839
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 2 runs,
 1 regressions (v6.11-rc1-17-gb4bcdff7e839)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 2 runs, 1 regressions (v6.11-rc1-17-gb4bc=
dff7e839)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-17-gb4bcdff7e839/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-17-gb4bcdff7e839
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b4bcdff7e839237d89a2aa15b6042b96b0240ac4 =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66d7b13e6922285319c8685f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-17-gb=
4bcdff7e839/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-s=
eccomp-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-17-gb=
4bcdff7e839/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-s=
eccomp-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/66d7b13e6922=
285319c86860
        failing since 35 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

