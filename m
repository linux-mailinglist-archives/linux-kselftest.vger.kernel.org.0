Return-Path: <linux-kselftest+bounces-14584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B369438BA
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 00:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C400D283D68
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 22:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6416C87F;
	Wed, 31 Jul 2024 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="sr+3NhVE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE48433B1
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464474; cv=none; b=OqRgQW9qhRLuFl6peKbATMkqTg5eVOwo1OaXOwE7lKFARWSh/fUdmSyt1L3DpOw5ts568skaNWaElZEca6QSpVSKdDF1AWIKExI6expdEmh21JEE4BgWvZimL0VWMji8iNCzol0UL6BQTpFd4QfME1VHBIbZwvFTlrigkWbyFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464474; c=relaxed/simple;
	bh=F+rHyKreamsHUJ972rDfI19JuwoVotjDGSDK7Rebe8c=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=VkC749YfBdiBF5KmtQ/rxHs1tQS4jxSVlu+cZy7HuBhTf5E9LAB2g1dw40RuQO9wMZAX+hyofmTdCx71GDihQ8ReKh02bVF8ucbiTPeCSqoPboiLVldvJ/97xc3LlJdcendtprI8saonRTPsY457Nmluv7B0SZbormFg00YdAb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=sr+3NhVE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc491f9b55so49802695ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 15:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1722464472; x=1723069272; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rWo80y6VAsTy9zx9I+LQb9A3sfxtx/QxXYV3Zb4ciSw=;
        b=sr+3NhVEdNxPLpX6hdgCQUiNR8z0n4Ju47T6TZ+z8z205gHtOY4QJ79V5twYrbMX6z
         SXBJewuw50f3pWe7+UpwCFYkGPU9iKgVKaYkV1fitc86p8wFD1mkV7Cu29H5gvJWPIVi
         c/Cj4cRau6zmsiEQhq46n/BnDmYW3VWB+c3lLMCaXUUyhv1USgE7zATQXIMYqj1Im9pF
         40TjrmBMajXAlYHhBd/C+ZQvS/x2NvQRDbv+7GRwnNL7eNxF0fCwAhk8/vIPDPNfI2SK
         l1b2/WlDBYaiM3q3eEgj6QiplUeRsm9MaiWE5sGUIZ5NUXFFcT7RGMTszYfF8AKe6ifb
         O5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464472; x=1723069272;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWo80y6VAsTy9zx9I+LQb9A3sfxtx/QxXYV3Zb4ciSw=;
        b=G9xy6gDKBdFD8TS2IPBoiLs2ANpl4wb7iDjT2z/DC/1qsAYKJ6AZLsSfKelcQWtQhU
         zFhPPbBdWj84BCZfTtxsfY/d3aCczmvytWyGziEk7d/rZWH40TiPsa09LJ/meK8Gffi3
         AtJxcEYXqGP/d9zduM8wSErk0vMN79iGYPDdhOIv++UT7ZMdKWX6qSCWAJDFntTLY09P
         uqrhsjvi89gyP4lT5L2HPPnsp9PKDsnqYulQY4FLSBSd86/4u9rjexNfmBXnvrMj3vNe
         IgD/+I0F8JWgZuCRYshP+vWtYFtqlrIVtUVJfU67fprk9ESZ5ROJoJQ+ns12bbCBVqIF
         M0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCV9II1SBER4ocFUzT793zlZlY1M884/iRE/75g7Cf3RysAXWFK7nRhMIxon46JW3DpBoEe2g+zUj69pHmrdBT2QvnCiwenvujt6IwPenc9A
X-Gm-Message-State: AOJu0Yxaq9n1Zqa6jN0KqMmg9N+jFIIE21sV3/45aTSTz7/P8xOurFLZ
	BvHZVDwzf/6KtSJsEXc6kv570g+W5ZbV7KuIhJfOTPMFL0piPYnVNLRhWUKpIfE=
X-Google-Smtp-Source: AGHT+IGQ2e3TbpBtIWY4N3OuTeLMpka6NvjToRqVN12b729TfBluAcVZjrU6Q7829pdmSrvjYNtgxg==
X-Received: by 2002:a17:902:d2d0:b0:1fb:d335:b0bf with SMTP id d9443c01a7336-1ff4ce87365mr7997315ad.25.1722464472288;
        Wed, 31 Jul 2024 15:21:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fb04sm125520505ad.43.2024.07.31.15.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:21:11 -0700 (PDT)
Message-ID: <66aab8d7.170a0220.10a972.0f21@mx.google.com>
Date: Wed, 31 Jul 2024 15:21:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.11-rc1-6-g38cde27f74d8
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-seccomp: 1 runs,
 1 regressions (v6.11-rc1-6-g38cde27f74d8)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-seccomp: 1 runs, 1 regressions (v6.11-rc1-6-g38cde=
27f74d8)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-6-g38cde27f74d8/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-6-g38cde27f74d8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      38cde27f74d8bbe2f705fb1f80384acab9762e9e =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66aaaf4931f4ea31e87e7074

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-6-g38=
cde27f74d8/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-se=
ccomp-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-6-g38=
cde27f74d8/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-se=
ccomp-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/66aaaf4931f4=
ea31e87e7075
        failing since 1 day (last pass: v6.10-rc7-29-gdf09b0bb09ea, first f=
ail: v6.11-rc1) =

 =20

