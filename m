Return-Path: <linux-kselftest+bounces-18699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110C998B0AB
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 01:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E571F226F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 23:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252AC188A05;
	Mon, 30 Sep 2024 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="2Py27gwO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9792018754F
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738092; cv=none; b=aaUJH3J+TykgS+qO3R4CjW8m0mJGqpfFQSutU3xOYLTFK1xT3viNwHDJZ7apWAFmUzOTK6deqka3QyBVWf0H3mlUA58zbAa2WwHlBPHKe+SY33JYS6RUo956jBkFto/ujND5Y3saXKrLL64gKO1xja/KuD3m3AgYxBhfyUdOPuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738092; c=relaxed/simple;
	bh=cgmhei0EndJHoAgyCM2GuT5zhNGJ/6wrhyXutQZ1dwE=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=UAWb8o5yKiaz9c0WPGbDn0uJMzPpQT3pnzEi9wGrfhqM3ycRSdThROqeRplyRFQ50BkAWqBZpdGUL7UaT6AfFVC3MITqB5WP302/aOp2hOu3ygB+GGRa3J+tkTO/AJvsJk1WNuPw37ogrLhH6iT31FLdVN5rW9BOK6+3Di2wQHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=2Py27gwO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b8bdea19aso13068805ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 16:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1727738090; x=1728342890; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ghPTXCuc0WXBQNZaczTPEIYjaZamix1aO/ZeuXEBkiY=;
        b=2Py27gwOZWAsKqDkjNtQDEmJnma0ASHMWv7VMLeeHVsTncp/8ZV1KVpnvk3JFWJmdz
         AMmcR+nQWCPPDLmmfTwwR5i6qoQckZEig86eQVrH/xSarKZoRjbEKgb4KPwb/dY90/PB
         kqRVXoAjLUAhG7Z/99a5pmnWMGowuha9Yd+rChWSwJi7+tc3N+eHnEevHdcTDQ8SOcdJ
         OAD0sdbj0UXarF0z1IEESXPKfDrIC5zN9a6xxZhAZ/rRE0n212qelvFRpFPVLqcVcko2
         0KbcIkt2DhDzD/G2E0qnHmMtEX3/xGByr37iWz0V3Z9psZTDhe1FIhUSQBIIfirdA1UC
         mZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727738090; x=1728342890;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghPTXCuc0WXBQNZaczTPEIYjaZamix1aO/ZeuXEBkiY=;
        b=RXmj/oTwTVZyru8De/v4wc5dfC1MaCNeGNr/N/YVVcfRAbmOkO76GFO86PCgSwsC0W
         R4QStDcyJsPwJr+ipv1xkN8cyVuMPRH713ppB3f9lCag0kXXMLDrVNqrtlFI3dHfbtmh
         CsXtlZE8D+w2ShnAiK9cMA5j3poVmrSq+lI0c/j6nQt9yKPjCH6+jpuAUReTywKAeQbi
         2OkfdCp9xIU7q7rmubauw0ELJs0CT5aNPUlHRvmlpZEhWiwyb4cFtkPs5OEZQKuZMgpj
         iO9k6L/vm7kj3fOA4IAV83B9SpwmdWJyMqpYlh0MobM4YlH5+AVL8yXF/CDSuFZ5FzcR
         LQcA==
X-Forwarded-Encrypted: i=1; AJvYcCX46UHBmt1eiNO95VNoZuKCis1RVX2yzsDojt8+KpqaAJFx/S3pHDGA5LJOMp/Nina0QQVm3vsV1qiEr939D+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkxy3ET9HGUXRNULj8sWC5kZ1cRNV1O01WW7cIxjHPUmncslpC
	dCiXIiZr6nBrdjVuvsQMpDuHMVHo5z0CJMkHfOV04s+iJOjNswgseukf1glEo2c=
X-Google-Smtp-Source: AGHT+IF/+oEqlIU5IvfZzNDfYFWDYPUtP9wGM/85sZpITZNU60LnkmL9zBGD1/OmdohxqSddMZO/mQ==
X-Received: by 2002:a17:903:2445:b0:20b:6624:70a7 with SMTP id d9443c01a7336-20b66247298mr118782125ad.21.1727738089851;
        Mon, 30 Sep 2024 16:14:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e6c997sm59260055ad.307.2024.09.30.16.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:14:49 -0700 (PDT)
Message-ID: <66fb30e9.170a0220.2c247f.7ff9@mx.google.com>
Date: Mon, 30 Sep 2024 16:14:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.12-rc1-2-g010b07d11e25
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 1 runs,
 1 regressions (v6.12-rc1-2-g010b07d11e25)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 1 runs, 1 regressions (v6.12-rc1-2-g010b07d=
11e25)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
2-rc1-2-g010b07d11e25/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.12-rc1-2-g010b07d11e25
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      010b07d11e259e37d2cd5579b8f2b189342ececb =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66fb2f959f6a8fd4ccc86866

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.12-rc1-2-g01=
0b07d11e25/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-lk=
dtm-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.12-rc1-2-g01=
0b07d11e25/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-lk=
dtm-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/66fb2f959f6a8f=
d4ccc86867
        failing since 62 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

