Return-Path: <linux-kselftest+bounces-11076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077E28D6D4F
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 03:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390471C21579
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 01:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADEABE78;
	Sat,  1 Jun 2024 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="g6nrqmvP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E232A946
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Jun 2024 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206169; cv=none; b=NzM+JAmedeB6lkKofa0xLkgSgL8EWtbkSs5xJl21YPKxL+/m/0HbY61HCidjHyaR3Q0ZWpO/gVKy3nL3L/hbgRphu8pBDmEgh0rkz8+PMG8cjb162tKbOCtAsZWRLX+EZdz2iJSn3Tj3HQ/0/9MEzM64S2rd8Vk3Vu8ueorwOb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206169; c=relaxed/simple;
	bh=om5Kpa07rJLDmiBQNVD6/1LUGheY7AXQ4H9ruJirgIk=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=KyzMH95z5Al6Il9RTL+9VN+CfLA3tP5Wu9MCFfClyEjJyaHBMalUJlvHTCZqI2SNOxpxt8BhJLORkygThJ4EYilWemcCbQKdIuRn7dMkG6Xm/9u3jUVpdkmM7h5g1cvBUPH4ku2C5bzSwpmmBTc9HwnIS3MVfX+ndo2sRgKSOVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=g6nrqmvP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7024003a515so1568740b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 18:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717206167; x=1717810967; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1pErB/W78OZgNqEGsC4uGesPC7nb3YAuQLdMaDQ93Ro=;
        b=g6nrqmvPAH207gbEy1JxFUlESzU4M3Xf/1XxHsV5/3JwyJTmokww3QEKMJgd1ONqiK
         X5GZVM0qTkM+UjMDrSnIFoNPZjDDWKUyhfhxjKHnClgLWcHYahG7hQUz3sQCKtnS/Wb7
         YnYn1dwRdLUxRCSCrG6yfoSgybC5Uawd8CDixLsjmYltw1xBe5kFDgd2aooZegeN5wDW
         JkXFTvuoMbLk9//0O5Z5TCcDSZU4oFupxTo83gax+Hi3KXI67WHu5qP3cZsoy2QQDbEu
         aMmh/MbcIPKBxsclBHkmyJohjQqOMfZWOYz3A1IUbRGI+5SqM1hXlSSSEiIhlsdwww8S
         +15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206167; x=1717810967;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pErB/W78OZgNqEGsC4uGesPC7nb3YAuQLdMaDQ93Ro=;
        b=pHRvJ0lEhXxOa2UjYjrZ84a9IBrhZgRZ+bBHIbQqOhJq47miZWOrJRZckHK2pIgmAO
         dJLWVm1SpZC/aYQNR7mJF/8qaoojA8wje5SS0pyXCvd7VoQNyHArH+VUEwDdIayUS6Aw
         n7rpl1exc8mt4R2DqG4aUIx7I/albdfIWhGDqpXWemBcNjPqXih4GfM3h9dyIHSGZNwt
         XEbfTz20RNhNrrlMzCeCn2q8V1zsWxrt39TRgXW1+GgMIVliWIo8kqpCDeYJU/av3m4q
         mPToIv7GNtY3nBh5J02ZszEZZRHeQxgD1z1U0Vb4Jz7FafNnI9rx0KBuLPUEugOhIY0E
         ZE3w==
X-Forwarded-Encrypted: i=1; AJvYcCW7nGvol8lgomKB6rwyDz0TsupwDqFSQuexfm5GLy3Sr5VDRgmEHLqm9ksBe4FBMIjGB1mh6SDYjj4aunPRIDR1fU0cqH2QTEZxO07+aEpd
X-Gm-Message-State: AOJu0YxV+sjAGzZXJrBno9EohA7g0G/kvOPzHbwm9E94u6mIFU69mwOp
	lfNO0GTJD4E2OkjYmiERm0GCnd6tjzkuUAjTPRVK95QyCh5aupnDdW678Hik4GzT/GAQIsi4GVx
	A
X-Google-Smtp-Source: AGHT+IGL81KnupWwUmWHj1b90h2elmura9/GeS6+IAC1TYlGnFRb55WfpPzpAuuZ9k6xt/g7/B3cwQ==
X-Received: by 2002:a05:6a21:3383:b0:1ad:8755:976 with SMTP id adf61e73a8af0-1b26f17ca47mr4031720637.13.1717206167459;
        Fri, 31 May 2024 18:42:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323e9027sm22805245ad.183.2024.05.31.18.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:42:47 -0700 (PDT)
Message-ID: <665a7c97.170a0220.e7ef2.6fef@mx.google.com>
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
Subject: kselftest/fixes kselftest-lib: 4 runs,
 1 regressions (v6.10-rc1-11-g4bf15b1c657d2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lib: 4 runs, 1 regressions (v6.10-rc1-11-g4bf15b1=
c657d2)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
10-rc1-11-g4bf15b1c657d2/plan/kselftest-lib/

  Test:     kselftest-lib
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


  Details:     https://kernelci.org/test/plan/id/665a769156859895ef7e7080

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-11-g=
4bf15b1c657d2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-me=
son-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-11-g=
4bf15b1c657d2/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-me=
son-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/665a769156859895=
ef7e7081
        new failure (last pass: v6.10-rc1-9-g0f42bdf59b4e4) =

 =20

