Return-Path: <linux-kselftest+bounces-5396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AAE8622CE
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 06:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B031F2321A
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 05:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB0D171BC;
	Sat, 24 Feb 2024 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="lOc1ZDK1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A614019
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708754386; cv=none; b=k+yZiHC0JAFgn8PmDfNmEz7cNvuHSBJNSsn+HCTFi60cLbwNyFKhyOY0AHrbMmMjYHVKJ1kKoeDRn3jcSexNVIoF09EcjcmM6lbTlluRQRLSzwUrSYogoYaJTQmlaIX1vWShqeBx4fbmvAOKjNKCRmyWlGuSQHwNFJ8XRpToNpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708754386; c=relaxed/simple;
	bh=XvKYSzmsel4C3osML2bBzhU0Web90eAwuKybSdTEFuA=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=KJubr3N8WDnJqmhrVqBlRrEc4sLX+ld67s/jb463ZCZstUZpYWiGafmmJFFB8HwFajc9Vb5I9EDme/hKQFmIqfk61f1Lwg1QL5eyDZHxILBM7Ym7XkZZ6j4u2wHSf1DQ0ySmiTdlSQnDrGvLdJFST0Ker5F/fx6QjdoKzASyFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=lOc1ZDK1; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d3907ff128so1003231a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 21:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708754384; x=1709359184; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+qzwYrf+Z/dwMQmx6PwVKA8tEe0OI36u/LT7N+6QYHM=;
        b=lOc1ZDK11mhmlf/gzNns+2oeN49OTMOvFEQj21G+Y/HyyeZvpo0kU8WkH6oRx1xsbK
         Fj19QRUPUYk8WIEQT2F3GwnxlksfmKxwlPlddwSUwm47dg0ufVNw72pdQ9OK3CJEalmH
         LjD5tv+XpBHqmxXsD4D+3xMwhaSd2jdD/jGncCaatu7xbBjrVPpIXLEqP+MeUuSzOQzz
         FHbUW0JP0+qBHMa3WvwQWBJOJhe+yP1xopbpRsad5YK359WWamf/JR2b7IBUoquXYyIM
         Gfy7OI3VjfRbhoogC1x34yio+PJKWz1pfPQjImbTpVfJYbPURWDIeVGTzp9DRKaiu9ro
         kJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708754384; x=1709359184;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qzwYrf+Z/dwMQmx6PwVKA8tEe0OI36u/LT7N+6QYHM=;
        b=FW1PvBzYZJTtFhe4n+fOx6cInVw9Nua7dNmgdweZ54iVjmE58HHHw/b5JJP2DkwuKQ
         hh9LcdZd4AErq1wVBWQ8wnfqv+ZcrIWbLlXaRJsdhgngS6FbSaaPO2bm84dKg7VZI9Y4
         F0rbFCE3FXg7Y3phRfvnnzfy6SqiClYGZO7DC4kVkMIEJN9leAkS+LtQFnP8P/mGQ7+E
         jKc5HRv6Amxg4o0lTpJeUcfHb5dvuUL/YNlD+mO9THb2vL2vU9d4cPlfEJRSH2cnWNeU
         HZuJFpjgOLLRr32Q+x6rn/fm5spQaCGDdgAYq+J6G5Ge8l9HMpQO/gFleZJ38UX71aJk
         1aQg==
X-Forwarded-Encrypted: i=1; AJvYcCXZZBdX3H4hVjp0zvbffKO3zvQlH3u1sYsf19yrIRMu+JUgqhfjiKKNY4qDR8+SGheVMxndxkhgnHShrPmQmoo6tDxkb7oK93zkozTbfam1
X-Gm-Message-State: AOJu0Ywf60MtwkqBPs4KK29Zt86DTJlzaFY7HjS0Kg6/P0qYf9Mh9nhS
	dgoYMGg4F1nZ6uPdDcIG0i2Lyo8wQgcACO94LneNZMU3IUk6Mtg1yD3q74bnUFw=
X-Google-Smtp-Source: AGHT+IGSHgwTXkxXsileE9MlDPFsCOjIbv7XmPVP5q1Jax1K8v9WaEQYli+LtPG6px0BwDHZ6XsZsg==
X-Received: by 2002:a17:902:cf0b:b0:1dc:854f:9a7e with SMTP id i11-20020a170902cf0b00b001dc854f9a7emr600157plg.60.1708754384516;
        Fri, 23 Feb 2024 21:59:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w23-20020a170902a71700b001da0a698095sm339579plq.282.2024.02.23.21.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 21:59:44 -0800 (PST)
Message-ID: <65d985d0.170a0220.11801.0d2b@mx.google.com>
Date: Fri, 23 Feb 2024 21:59:44 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-53-gae638551ab64a
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lib: 4 runs,
 2 regressions (v6.8-rc1-53-gae638551ab64a)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lib: 4 runs, 2 regressions (v6.8-rc1-53-gae638551a=
b64a)

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
-rc1-53-gae638551ab64a/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-53-gae638551ab64a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ae638551ab64a216364a63c4ee5061f82702fde2 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d976adcdec23094263703f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm64/defconfig+kselftest/gcc-10/lab-collabora/kselftest-lib-me=
son-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65d976adcdec2309=
42637040
        failing since 494 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1) =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d97813d30971079363701d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meso=
n-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-lib-meso=
n-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65d97813d3097107=
9363701e
        failing since 491 days (last pass: linux-kselftest-next-6.0-rc2-11-=
g144eeb2fc761, first fail: v6.1-rc1-1-gde3ee3f63400a) =

 =20

