Return-Path: <linux-kselftest+bounces-18517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F42988BF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 23:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7BEB21902
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 21:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42A818A6C8;
	Fri, 27 Sep 2024 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="AEExtNH1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEF515B118
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727473559; cv=none; b=YtJ2RAFSiAmBr5IvYshahuFVYgPy0L/rjhorD8jb8K/paZe1Kq4rZtKXLvJWtAs0UcMc0eyksMNVDXE3nOimRm/IXQhvGxw1u0Y/m1909Bti3EPfYgQpn17b8rk4nIn7d4h01j4Z44KX6ZZjQy/NXfuRGTkmVheB7FKSKiCxZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727473559; c=relaxed/simple;
	bh=UIfvAql8zDAv6kpKKpxf6MFAATNGumaO5pwGhsuA/yY=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=npN6Wu5GTVIHwn3QRrOLyqaYVUTezoB4dSuj7whct9cr/wF8CwhM6WLy7TsmJXCwzDNkrhK+96fCRDMLyEtR/vtP1+8W1mjiJgfGJRRks7m9eUOnZlpzpqqKxHG7G9XHmc+tDTMW+ioVWQR4HGt5BHQ9Pf8ksx/fTDtPekIaNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=AEExtNH1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7db54269325so1976846a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1727473557; x=1728078357; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jnRNVLuLMBA85Q2PSshUkRROU7AylxnW/yOtj3p6Qgg=;
        b=AEExtNH1aaUYs6FIzu4UrLGcAaiY+Jidcpi/IDL25UJpxu4+jdlI+q8MzXOdKMoPT0
         CfI//DRbZI/FkldoNCTBcirIXF0HX/ucmELfBlmumxnU/WGO0iXRszTzznv+WrScUUTb
         1RIh3tugvfrr2XKPGIF2YMUhjmD8eYaGC7TjBJ1C1wzdDG1Mgjm72qKTBd6ng8S/N5Nq
         2WM4pGQxasGWvrKc5CxZomyvo3vM4Z3r681dFv84mVy921W1336MVt1jUrRGoc4Xyi81
         neXdhYqFCDwfjacFbjgZ63zF7Xcq06Ws2qqEFTRTmbCoPnf4yJ2SSZPF6986UEBGNM+g
         IFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727473557; x=1728078357;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnRNVLuLMBA85Q2PSshUkRROU7AylxnW/yOtj3p6Qgg=;
        b=NkWkIghtTqhc6drqCrjajbw3VVcmxxCKrBomlsPhawblydu5XIpCnESOsNjLMmq1ir
         QpkMsBhqs2fX/YunYYfTO+3dVlEr8qKq3dwUm08aXlJv1dpJCga/BjfkZOCdngtT625C
         CPvNrFOSUaR9gd5cKfpIJs6bXbDM+R6lgmImErGCrrKbiP3mmGH3yOJ+8lj0H9EUTtp6
         TwYg3P1pYUdGmGxCjJknVZJxO5O77w8dCZKPd91MsI9B3SAotEjroqiCETI3avblMMyS
         xA7tGTLHVI/saaj1qGrgo9DKllbB9dxXl7tRrj/c/WXz6/ysqn6s4/dKSgIUpdLokgB0
         SRdA==
X-Forwarded-Encrypted: i=1; AJvYcCWwPW1XNS3FiZAm/WTC/O1f5Xo4Zgu/VkGcpCCmwcwrgMY8ovn4KHGf9/fItGAGVnHxPXTQ6NiQr5q9rkaOxV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQ2CosgIoIIT5GRh0wlam2x4D/9Bde/Y6VFKaqteSX9WYemaQ
	S4BSCDsTEu1HrTSitnu36tB8/C9DK5DGeMcOId53OdVer0GFnCrZ1zVSGz+aLeU=
X-Google-Smtp-Source: AGHT+IHRtgYE0Lh+VkVuejQ1YRPcVE6IsaLC5cAawBkIeQ7JSX1f3nwus3qNp70MdBzexBOXiCcfdg==
X-Received: by 2002:a05:6a21:2d8f:b0:1cf:4679:9b97 with SMTP id adf61e73a8af0-1d4fa77a2edmr6380223637.37.1727473557449;
        Fri, 27 Sep 2024 14:45:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26498b26sm2057939b3a.9.2024.09.27.14.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 14:45:56 -0700 (PDT)
Message-ID: <66f72794.050a0220.52fa2.c875@mx.google.com>
Date: Fri, 27 Sep 2024 14:45:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: linux_kselftest-next-6.12-rc1-1-g4b721fcc094e
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 2 runs,
 1 regressions (linux_kselftest-next-6.12-rc1-1-g4b721fcc094e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lib: 2 runs, 1 regressions (linux_kselftest-next-6=
.12-rc1-1-g4b721fcc094e)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/linu=
x_kselftest-next-6.12-rc1-1-g4b721fcc094e/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: linux_kselftest-next-6.12-rc1-1-g4b721fcc094e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4b721fcc094e9eb6dd4702df8d79ab11e120833d =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66f71aaef3b0ef5235c8685f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/linux_kselftest=
-next-6.12-rc1-1-g4b721fcc094e/arm/multi_v7_defconfig+kselftest/gcc-12/lab-=
broonie/kselftest-lib-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/linux_kselftest=
-next-6.12-rc1-1-g4b721fcc094e/arm/multi_v7_defconfig+kselftest/gcc-12/lab-=
broonie/kselftest-lib-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/66f71aaef3b0ef52=
35c86860
        failing since 59 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

