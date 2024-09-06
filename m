Return-Path: <linux-kselftest+bounces-17430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C0596FE40
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 00:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A531F23E70
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 22:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AFC15B0F2;
	Fri,  6 Sep 2024 22:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gAMo1y9Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5F156C5F
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725663576; cv=none; b=c2P0LoGKgz5SJjp+yAv4ojeoPMAafZu0JJX/t0smz5QQ1O7Lxi8tYjx02G87uZRBKFdORvDh+GEBd8yyNK0df7qGyXvKKFgQF1N06lKRvntyuGawOC9Kz9Ip+5W0u4MsxuHrkjw0Zdudy3dYCXxFEXyFWMa5VJBtO9cZvTHc0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725663576; c=relaxed/simple;
	bh=WAJLz7DMSmUe3Xq3OwDgjpUoPD8TONO00AL+wKk75Pw=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Immzb+lkf99tMymio3RyoE9RaTtiC2owzYHkj/cDZtY4Y3nzw37LsjfABMdg3wNI64GoqB3Pm27zz911QjH1CLwqY4cetpxCQMD3CerOHQAucsXBPkmqKfGqS+d4kzkljwaNHMxMQDTKZIDEl39NkGfaDaYr9n8eiGf8qygy1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=gAMo1y9Y; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-717934728adso1884352b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 15:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1725663574; x=1726268374; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ac9OtQS+dLxVop86c5U7oNidxqtGffbLwNKUhppB/PY=;
        b=gAMo1y9YHnBg9HpAcaYiUthwQ+5VbQEOC8Z5Af3WWYRWqL2W2HU4xwRIZmlS2Linmh
         /eZlzx0U6Yq+v1UnzhpTASEQok1aGIwaRhXyh3kkQt59Ti8DYTynzi1R8R9EG+weJVYm
         ijdBAYb8x7g344TGcCW0gbP9INw0GUD9o84fIpaEhcCQHIuEOLkjNZb90dfUksNB7Jws
         HcVz+2/oRKINBd2CQhTQiGb0o66FHRVbVB0S4/IyiTDsThAVku6Wgoncd9D+MDMRi25f
         xRyB4StZMByx3A8CnhbxP8heuTij63SjzmOI+L2QqgFaDLBuMhVQl78egPtnNHlc6Voy
         T6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725663574; x=1726268374;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ac9OtQS+dLxVop86c5U7oNidxqtGffbLwNKUhppB/PY=;
        b=jgg2JzzxIhZRq0AAcEpaKdHRSTxOKJZfOkvTAJwq9P1aRdGZty/iyJRsKV7IlT1G8K
         W1lUVlQRUSpGueBqkUiErdSY7uJMz+0m61894whqcnwEuRyg7HyV6jCJhOoU2ZCsDkt/
         v4tCFboOpxZxpzeLHDd+bBj9FI/fAoYcalWeUWpoddE22h+pw9+DhpynTWsThDoN9Zki
         MLC5relRXivK0lYaHs+y/P3bL/VwKEepl/fL5W8on+XWly15vBpZF25nAfkfDhyM9vkC
         IZ+gO4MPyDXiFPAGpiCLq8TwixuDrGhqMe1snfwqhEgLmLhxZkygm3+VPK7pm4RNUMQw
         FBNg==
X-Forwarded-Encrypted: i=1; AJvYcCWICWPsEmamg8gtGlfNkT+weSqqCPXW06i6UuzHk5yLNPT6QmAd8GyFb69ISEkRG0urb6pjctA2J/w9Zbl8mtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh2jl4fKfq95GhabPnNeu6QrQVYE8zo2NGUTItv8BbAlEVfZWy
	CsgM1qb/3k6+7wWaoF6O0KAaefNGCxOvVdBVltQzdfsIlSsQIy4lkRN1J5sju9I=
X-Google-Smtp-Source: AGHT+IGDC3dlXZt3mvK9Tj0lVouZqW1y8uba9cTgbL3FuJknxoh3aLWHbF6kUfLjPENuGqUNuLGnxg==
X-Received: by 2002:a05:6a20:87a9:b0:1cf:2438:c9e3 with SMTP id adf61e73a8af0-1cf2ac89179mr621559637.16.1725663574031;
        Fri, 06 Sep 2024 15:59:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8c1d2sm5574307a12.21.2024.09.06.15.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 15:59:33 -0700 (PDT)
Message-ID: <66db8955.630a0220.992cb.9125@mx.google.com>
Date: Fri, 06 Sep 2024 15:59:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.11-rc1-20-gaf1ec38c6ccc3
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lib: 2 runs,
 1 regressions (v6.11-rc1-20-gaf1ec38c6ccc3)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lib: 2 runs, 1 regressions (v6.11-rc1-20-gaf1ec38c=
6ccc3)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-20-gaf1ec38c6ccc3/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     kselftest
  Branch:   next
  Describe: v6.11-rc1-20-gaf1ec38c6ccc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      af1ec38c6ccc31ec963ac4bcf8f6a7d8f44d210a =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66db7fc38d2f0d735dc86865

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-20-ga=
f1ec38c6ccc3/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lib-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-20-ga=
f1ec38c6ccc3/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lib-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/66db7fc38d2f0d73=
5dc86866
        failing since 38 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

