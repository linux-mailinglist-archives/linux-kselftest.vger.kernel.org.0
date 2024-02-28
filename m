Return-Path: <linux-kselftest+bounces-5514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D624F86A8D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 08:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6734CB25F3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 07:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83315241E6;
	Wed, 28 Feb 2024 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="OLhluWdd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA0924A05
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709104918; cv=none; b=kSisfJXnFtDOUm8f4QzItnI5BKYD8wG72f2pjjoDVUW9AuRycibvg71F4q9RQH0RvmH2ynTWs26j2QEmOcNCL/8mI7blxX329CQX6yr3zLlf70ebS+2mrTvGwtJ42Lldu6rmnrEwuDn74AhOblgvX1Dyrf97cs2d2BcqZkgY20s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709104918; c=relaxed/simple;
	bh=ejOEZk3S+P0/ZzlYty7wrO/3BJYOENlmyVQWSyjH2NA=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=oUL6wjaurtoE+C9PL2kngekElNsqhAlpVqcNnk7P7ftzUKqJzMmAoEtTLqknBKwQ2aI/8bq2YCLRuMB4UZ6HTmQVp1uGNDbNsPFCGPyFNxdc1apka4H1TFNkTDVx1amQbMXNnRqgoaq23uDALQl4k8YvyhNmPVCxR97i7nHRu+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=OLhluWdd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc1e7c0e29so27580865ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 23:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709104916; x=1709709716; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y9qJw5NTpa+Z4+lsr7PCvzogE9du/IsgMZqlqqS9i7Q=;
        b=OLhluWddKkWPRczF4K4W/vH3Lx2j7xbZoD+oME6lEUBe+3Llhc7IdkqHATTAoUyExa
         H8rhcelHOFPHaRoJqxdehNPw7G28wu+fic790DU7ljok1f6Kv2U+n7IaCJ7fYzRoEPdH
         n4L6EmlIwSUhvy10e1YHRp9kbengKH+kRZXY+ixt+pxc8M2ssz4JjEPVdTN73C963VYZ
         DOcLSjNDpiGqwtRnvVweNABjqeZcQn5dbq3f6ca69FNs065G2Ld5tR45Gvpqzy36PhS4
         nEp4h4+G+R7kU1zgPNXL2vn78N8yWgtDIrs7Mmoe/YkxDDuYGb5OuW7Isk4TZIgNH8O/
         8h8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709104916; x=1709709716;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9qJw5NTpa+Z4+lsr7PCvzogE9du/IsgMZqlqqS9i7Q=;
        b=X68v1y7NMIGhK60Q6DOvMaG1mpKnCpkwQcAMlq0Is3SgSX+TRE9jEnyy5s/4LJWnf/
         mEB8z3cIs15xckIKzGjfmPSXN+CSVXGOB2Qqn3sm8hq0HLl6JlZfvEw64MV5DqnEGg04
         WowGyE3gX32w88PGXDGPJSvKNGExSQtJazf+iuUP7YBtXPKRVslLiXCQ4NDw+YnKbjca
         +RohJiAKfyo3xLUIFDnADph9owaGC7KADdN7Ddsl7MpT+SG65YfutrlHKhIp3qXmOXx0
         hVNYcbJTJU/1DHaqomTpbCtjIeSTdC5TYx+p30BDBFNcWQBa29TExkSpVS9YCxemYbUE
         HZDw==
X-Forwarded-Encrypted: i=1; AJvYcCV5d67VkphilgOOyixuCPqC7yJXIVrZVcp497BacLuK+jl3LENflLAZCIahBC5XVPaXuR8poWOegAa3EgPjx/JN1nbb+KHxTez0r4yvYRct
X-Gm-Message-State: AOJu0YxhE8K3LIBySM3dm729DZHSb9iZa98lUEp9tYuV2yAjbc9xxJUC
	/tEDP6VBMgqBK8mADvLQM6aRl60qKDTw9fn8QlCVT8s8cK6khvn6O7a8WGFKAfk=
X-Google-Smtp-Source: AGHT+IEcdFPtYtcSwsY0mKG+X7T2Fe43y+6GdsjtqY5O/HRXTvZXPwL5vDxRAXljNld5+rEBfdX+dQ==
X-Received: by 2002:a17:902:e552:b0:1dc:ce55:e6fd with SMTP id n18-20020a170902e55200b001dcce55e6fdmr108728plf.69.1709104916373;
        Tue, 27 Feb 2024 23:21:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902e19100b001dcb4ae9563sm2636408pla.33.2024.02.27.23.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:21:55 -0800 (PST)
Message-ID: <65dedf13.170a0220.3a789.b5ad@mx.google.com>
Date: Tue, 27 Feb 2024 23:21:55 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-56-g539cd3f4da3f
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 2 runs,
 1 regressions (v6.8-rc1-56-g539cd3f4da3f)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 2 runs, 1 regressions (v6.8-rc1-56-g539cd3f=
4da3f)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-56-g539cd3f4da3f/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-56-g539cd3f4da3f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      539cd3f4da3fdbe7dc353634e004e4b0e725c35a =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65ded31017d8855223637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-56-g53=
9cd3f4da3f/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-56-g53=
9cd3f4da3f/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65ded31017d885=
5223637013
        failing since 454 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =20

