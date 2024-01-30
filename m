Return-Path: <linux-kselftest+bounces-3766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B0842D6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 20:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536401C21DD4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D1671B24;
	Tue, 30 Jan 2024 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="TlQCDl6s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D9769E0B
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644719; cv=none; b=vCWvf6m9E1ZNBnitjp9NuV5KJNY5irYHx7cY/OHE3DFswC+oWHTfHtj/ok2JkitMAHflMIT1lkWdvijzvhFjp3DK82wF0n35Q1EnNEl1INozSj/+LdE136zDk5k1ZfS4UQkKbI6CbJtYVEuwOaJolsNrH3rwZiATGKDz67YKdv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644719; c=relaxed/simple;
	bh=Q6VnTgOLAfkePSNMn9pcpjATMVxFATPTsNtnTv6GaCI=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=QmBIewcbmOnGic+nz3VztXcP0vWmIA/G6p9KpMnbOFt8MHiRmfgyGfK2jXNLHqy2e2Z9FEGNR20AFDDySFEh905S+z3QhMaDuAcIVq0YtdwLrg2JBERvn3X5ZpzN92K9+0FRL3qyPraa90dMZPF32vxdLnUjW7Ise0acH2YrwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=TlQCDl6s; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d7858a469aso24739585ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 11:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706644717; x=1707249517; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kbjb0gQwrDsDux8nUa7kmG+hywW+PedyL/oO/udhL6k=;
        b=TlQCDl6sOymATVA08hAdyenZBIh9iH70EVfT3Pd8dGQYAf1OaGoXI4PFSY85p+4Llb
         KqhuX3UVs+tVIhZ/LffdIZkSDcsa+ywXz9Eho/39+6mUxvvOW7EBW4syEeq7132ujaxp
         RRLQD4DXnCqU9V+fe8k2+n1K0aLZKX8IQAB5DxPIndXXUcgF1ZRHzOrsIYHpo/vbr7KC
         E7ZobI98YrOhJ+kcOMVSWnks1II238YtWWpoNJVSrVdyeQ24x2FoF6bIQO7bQSkCEfZG
         Q4h/5E7VclNj3Q96eFCLmpwZrNT5nkLbF6r7nM8a2uzqWAH9tUvwPqEFEXYUkHYsLYq5
         YF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706644717; x=1707249517;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbjb0gQwrDsDux8nUa7kmG+hywW+PedyL/oO/udhL6k=;
        b=LFC0vqBsA027GzADUVb/LXI3IPVRLJDuzjOX10bhTrJFl8IdHoBJcDcJr9JDH0EFUh
         S8gFZWU9r1d81bVS2jvV8oJmEoqeNZdt5X47Ego6B3DQAeRWrP5fi4cIbVBv8HqXe7n2
         3U+F+grskDoABtqYhZslkev2uj8XyewmPrwal9vkLLttpnird4mYlbdPqoIsFdu3ocS0
         ICYJidYR5dZgYgTiOr5xGeevJVZQu8yQ71P8FrSq7s6c6YqkEd1tXmwofuduKXnZF02S
         YCl9TnmEoqQ9N+aMb899ttkc6ocY4OXZgC1WOoDP3ZqQlDA68d+6t6XZ1Fag5qyhTajc
         kXTA==
X-Gm-Message-State: AOJu0YxYi/QaTj0XBSYfsXlyAfnOHcHb0pNiQM/8sDj2d0E93aOqNZH9
	dD74uUIDTNrfz80ziXWvuDka1sjcaCUJbzLYQN2s9MMdbXt2KWHGLWQnm0/zB4/lT9lRGfPqr10
	T
X-Google-Smtp-Source: AGHT+IGXTX4pPwJIMxCG3lxunlML6mHvc0/hWc5yH79PZqj+MJutMxXcV1aJAdqTCKNqu6w47Vl1uA==
X-Received: by 2002:a17:90a:94ca:b0:28e:78f0:d8e6 with SMTP id j10-20020a17090a94ca00b0028e78f0d8e6mr5120190pjw.30.1706644717543;
        Tue, 30 Jan 2024 11:58:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id sx8-20020a17090b2cc800b0028df5c748e4sm8920049pjb.44.2024.01.30.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:58:36 -0800 (PST)
Message-ID: <65b954ec.170a0220.baf03.b741@mx.google.com>
Date: Tue, 30 Jan 2024 11:58:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: fixes
X-Kernelci-Kernel: v6.8-rc1-4-gb54761f6e9773
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-lib: 4 runs,
 2 regressions (v6.8-rc1-4-gb54761f6e9773)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-lib: 4 runs, 2 regressions (v6.8-rc1-4-gb54761f6e=
9773)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
8-rc1-4-gb54761f6e9773/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.8-rc1-4-gb54761f6e9773
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      b54761f6e9773350c0d1fb8e1e5aacaba7769d0f =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65b9467125e321600300a05c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-4-gb5=
4761f6e9773/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-4-gb5=
4761f6e9773/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65b9467125e32160=
0300a05d
        failing since 469 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65b94a0e937c2d11a400a046

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-4-gb5=
4761f6e9773/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meso=
n-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-4-gb5=
4761f6e9773/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meso=
n-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65b94a0e937c2d11=
a400a047
        failing since 457 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: linux-kselftest-fixes-6.1-rc3-2-g3d982441308e) =

 =20

