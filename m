Return-Path: <linux-kselftest+bounces-21431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08E39BC30B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 03:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CCC6B20E4C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 02:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA49422098;
	Tue,  5 Nov 2024 02:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="BCJx3FMN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657FEAD2
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 02:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773003; cv=none; b=Ksm5/K3biuk6FXy8M13slkvIFIPR7A7foIXCgNHMSBfWiZW6hzvbbKGelmvohTW0dYxVAAQy+3453ElM4PjS0/fZ7yFE5xN8lYNv4xofQgchYz8Zn6G2IfhwF6UIr7z739zeTkqWsBE7gfMoFt5GsArhkk2Ke8qP2ejUK1CLLag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773003; c=relaxed/simple;
	bh=UnUmmL3R24BvZFiECpxgbCG2c2mBoMufGGxGw1oYT/c=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=XMBHgK891PMlvksjwCOq2BOYHtZlecgVeKjzcQUmTZAJ9LeHijsuwIspp4W8tEArhT6I3nyZwaijWw8F5qjjDn0hVVXwOYaru08NRH8lgEE56N8ar4J3xoYpHcRdFWrQyvTRqEz+PY0b+JbPmNGlnkX16KuQaudzYtdqFsigwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=BCJx3FMN; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso2467646a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 18:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1730773001; x=1731377801; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vCuCsNdw5hsCNYAVuGzrYwXlXi7Bc5Ib+QqCdpsh9j8=;
        b=BCJx3FMNBXR4kj+nhrAOW+WShrgwVLKxRGz3SGj0a4s2FpO2exT3ydEbyEThvcFIH+
         UZs/2tm8V3gyUCg983wXmOwVvVhEWraI5Cica8zaUNuPTPmzNsVRYERKK1bnSd7jx4Jx
         BdYTkKNqMjUWUK81wYkA5rDY/H/8ktwVmT6z6Kg1YbvrbCOWmP2zEBtjEQU28Y4hWXCg
         FunxLodYqOvLTwvUhyROM11FZiTVmTeir/TDadtStnJ5fz7jgZUzXypdwE0eo61CJT+x
         hrzNKwsi2VE97rk4cFE4cCB1zp08B1t0WZVM2XdAIEInAfvHa4gwGvaHSKzjRAiRXe+R
         W6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730773001; x=1731377801;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCuCsNdw5hsCNYAVuGzrYwXlXi7Bc5Ib+QqCdpsh9j8=;
        b=gwSXuXf918kJ6BjVOuNDb7FWtntZvkAaCqwfwUvf44Nl2ogvKCQqDjrDWtEJU7fNgf
         mvEn5oAgrbVBdXzQU3pKjRDw8IHNZIrRcQV/FgArUzP25QfgTDrUGgmf3NUno7HC1ZCD
         tsA2Cn7CADmcVsi4gXi1g3+zvWIZu17RjFCtELGU5uPAW+szjRMC09Mc1s2ZR9VszdZj
         D2jSok64C3EB7fgUHnGBTvC5El/4ROGach5I1okvekcnL473+2ADm3Mi+xvojW9WZD6/
         PZDzGaLKMS7OMKQGZ5I9reLUKonOYdz7YyetF+0Ms8hPpOfsA7d/xBAzWivlcxll6Az1
         sTGg==
X-Forwarded-Encrypted: i=1; AJvYcCWW5A9CHIjg/lFhhT8Snm0qEO39xV+P1dUtY3c1lOIUByAmRZ0Qf9GTOkuMvnGKeFnkz8z/bpn7bmjPhVzwSNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW5tPu92UfIYchzdiHtIkKLadYRdVslnqZjcRAKv9YSOa3E+9U
	N9bMOOoWPpFzhfQHasYZFrXAiex+zQS0CjWelPvJPn3KgUdKlcnt9BoimR4It/ujpbH2nx31xNa
	k
X-Google-Smtp-Source: AGHT+IEofUmd4MRos6YV7zjLGdiynAgKQoK0QGhyAuiicNU3geHXszVKo/AKsSm2OeciSyD7+Qd0Qg==
X-Received: by 2002:a17:90b:5283:b0:2d3:c638:ec67 with SMTP id 98e67ed59e1d1-2e93bee6aa3mr24068118a91.0.1730773001183;
        Mon, 04 Nov 2024 18:16:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93daac455sm9526224a91.19.2024.11.04.18.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 18:16:40 -0800 (PST)
Message-ID: <67298008.170a0220.3db46d.b3d1@mx.google.com>
Date: Mon, 04 Nov 2024 18:16:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.12-rc3-23-ga44c26d7fa74
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 1 runs,
 1 regressions (v6.12-rc3-23-ga44c26d7fa74)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 1 runs, 1 regressions (v6.12-rc3-23-ga44c=
26d7fa74)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
2-rc3-23-ga44c26d7fa74/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.12-rc3-23-ga44c26d7fa74
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a44c26d7fa74a5f4d2795a5c55a2d6ec1ebf1e38 =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/67297bfb8d4223d56ec86863

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.12-rc3-23-ga=
44c26d7fa74/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-s=
eccomp-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.12-rc3-23-ga=
44c26d7fa74/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-s=
eccomp-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/67297bfb8d42=
23d56ec86864
        failing since 97 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

