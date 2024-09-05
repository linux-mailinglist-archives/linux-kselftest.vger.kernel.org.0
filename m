Return-Path: <linux-kselftest+bounces-17199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F8F96CD21
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 05:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604D71C21448
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 03:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957FA14373F;
	Thu,  5 Sep 2024 03:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="i4uwVgMg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8023EADA
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Sep 2024 03:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506356; cv=none; b=BlqrbxLrEFq1NTIJvMz4Lmt6URmuWNghDNxeAtDcK8dwgMkQ8GYB8Slxa3KiwJjzCrPLEf6RGJS6kB8m0l9hwEmv19+wZ42HboCeKUTEMlVXHBG2pug5N5uTs2l+RFSoKXb2NUM4fuOIejZuBPkJiA7uolbzzVuBusCDx3V/gfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506356; c=relaxed/simple;
	bh=JnPNB9Lse0DK4J+7HM1wENKVA3EzIYW/Dx/py4ooFew=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Xcp6vxXUD/SKwZLLijN9Q92aScFSMKicbKHfjKxbklGbPC3Hhi079vkrZucPsR4IhmmrVUJYgVDuPzoTU2/zbvVgck5We4ve0c7WqpYaoXUSvUBIFchN3r1eOba7n+V8yIt1EBSIA7mKO9bM/g54I6y7mkCdBdLCusJ76bVsVTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=i4uwVgMg; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2daaa9706a9so223216a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2024 20:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1725506353; x=1726111153; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UztQHhQp0ZOIpNmXTeNlf4JFmtlXnZbocU21B1BkXlo=;
        b=i4uwVgMgc4SL5Tfqz7G6eQ7qm+n2nun7FLRolsYy1xtZN3WhkRBlOw8jlbvykW4+2F
         Dk8nifvKlVp4iNicGCIwnWt4SpTZKsJqjKR9sCS3IFq/4Dh5JpXjVQuQZ6KKlgRGhNpQ
         PEArgukP2VVE6R2qt0vwf+L/A3Yl4ghw6BmtWUYA0P8/CBg0WSa28hr9QELANgVIikXx
         NYL9dDj7TpnDpnv0N7TTsdzjCWk+rBt6VKToWgKq3sgfRgH/xzFMNS3E9rQ1g6GgmoKf
         89ua+f5EL6x341L7U0madGJaAOb60c+yLHW/MCeyXm1zM6vJk8eh0CIJQtAzbaDhQLEj
         BcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725506353; x=1726111153;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UztQHhQp0ZOIpNmXTeNlf4JFmtlXnZbocU21B1BkXlo=;
        b=f8h17TYMfArBvCrdu7Et5kKunmQGUOd1rwuGmyFPvEKPPy0azDlyE6VPcX6MApQFQ/
         5Fg5eR+kJzBtcKfWMqz26d4DgFoB4cOtYZF+Z69dpHUBct47zE7Z0GKagehzDQhIxwzS
         rUdUEnyI6idRFSAbxh17BJXL9GllNTn38Z6CtV4+EnG0VZKdpgQ34LuVQdhEyilLrQKF
         bji0dI9zb7wrQ1GhnViltlKC98FyJayPSEyqKF5+RvzftZfMdyTSoZkStyqC4ZmyzTxd
         /4mF38avonyvaVAaxHOdnHwy/EfumP+P3e68q5/A4XbzybV2ZInLLu6VvEmka2X1vjLA
         /L+w==
X-Forwarded-Encrypted: i=1; AJvYcCVZQfApT0qVyA9y+sB8HrnP3r/Z6fwEDET8DK/3JROBPi+cN3ZAGpauQm7OHBkn521Q/2kjKfSCHOe1ZsQqWLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YydD2fuNROubkbAtAkRHw51AQKt91o+kDp93rE7AIRTzPKY826d
	w52M15X0pJ6Mik+YIx6NM3ZXmvLHl/PEc8qMsIVsMXLRvFLQYWcSt1+lvCbbyc/YCFNryb8xY8x
	R
X-Google-Smtp-Source: AGHT+IGeVrZUqtOhTxqTTCPXUXeJToq/b+q5FZBjcz81yzf9/opdReSQhG7swIDaZcGXg7VMnqyh3g==
X-Received: by 2002:a17:90b:4a89:b0:2d3:cd22:e66f with SMTP id 98e67ed59e1d1-2da62ccd6ddmr8697535a91.9.1725506353009;
        Wed, 04 Sep 2024 20:19:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8f0cfb388sm6567503a91.45.2024.09.04.20.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:19:12 -0700 (PDT)
Message-ID: <66d92330.170a0220.213b5e.773c@mx.google.com>
Date: Wed, 04 Sep 2024 20:19:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-18-gf0a6ecebd8586
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 2 runs,
 1 regressions (v6.11-rc1-18-gf0a6ecebd8586)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 2 runs, 1 regressions (v6.11-rc1-18-gf0a6ec=
ebd8586)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-18-gf0a6ecebd8586/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-18-gf0a6ecebd8586
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      f0a6ecebd858658df213d114b0530f8f0b96e396 =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66d91e42bac78b47bec86860

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-18-gf=
0a6ecebd8586/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lkdtm-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-18-gf=
0a6ecebd8586/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lkdtm-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/66d91e42bac78b=
47bec86861
        failing since 36 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

