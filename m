Return-Path: <linux-kselftest+bounces-5398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEC68622D2
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 06:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF576B20DB3
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 05:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCC617543;
	Sat, 24 Feb 2024 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Vc3ML1F9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE84168BA
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708754388; cv=none; b=Ga5RLABaQGyiHgB+D5sOBtcIUO4JU3os198qOx+IxDn+zqU7fbooToV5V60ls+OnU+mi90b6tnO583/hiNu1Aay3hwViQhOUPQmnmMN+6Dc2Ngqj5S0RweA1zkuu68ZNbALWaTRShJbhWp2SWQHnmuYsDq60L+Cad/DTfRDqVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708754388; c=relaxed/simple;
	bh=bZUjn52ukRSkhOIQSC+WlXcIxwiu52Q5DJkxp5pV3lw=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=B8KjILK8W24iH+s+79t4IVUHz7BVP23mlGyEV2CuK07lcbhNHc4FVwOQFKMVIDbJM+bHVJ0ZK+0zApHt8peqMkMxbq9lNto+O1EHh+Pcj2OJ2UlRdU2+C0febkmDsAUATNVTTF515/kP6WR2wRORSGOTteJze9/qt01rUJZuces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Vc3ML1F9; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce2aada130so1346433a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 21:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708754386; x=1709359186; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gt5/IcQAFo+LweZcM/SZ8OghYpW1D1Ak1wwbfqJRlOQ=;
        b=Vc3ML1F9IDrMq2ljGhxkYjTJKoUr34GdZBpHnBkw/StBPyjiNJug+1NPNUMeAPtAMQ
         Lv6p/bXciTMiY1lXqLcI82HJWcrtWXn+H4qsdX7pJvigjW6iz4/0FYS4p4USBAJgbtMr
         B3OTl0Hn+BQZXa75hkCdN2466iDDYz7L4tqv+LRhFqYJgAzquuNaMuMWREUfwkZ9d+UD
         JWpCX9pEJjs/4e/RE4okbiSm0JXbLwTbOT/mPxD9afXnXM1jpimlY+uVpXkoalqvv+Jy
         JY0nzb6yRgdJmappEYuijuonek4KMYxDmksYmL/+mchR+NjcAwuDd6cITpjUqWfGKf75
         YRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708754386; x=1709359186;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gt5/IcQAFo+LweZcM/SZ8OghYpW1D1Ak1wwbfqJRlOQ=;
        b=hPXiJfyV6urEDIHE7oWRuOkTn1zgDgcPecjGuwMDskBT9Jq9V1AlsVJ6pg6Fwse3uO
         cpgvfNLB9jk6LxRQ8hql8LbVDumcyiYbbA3vgf51DRKQDcDXYE0HTyf7ZJ2mIHpLdm8K
         Hm2U1dg04uFGdEAPST3zQSLVDVpNIdJxG6T9J3AbgnBRMQsIW6LHR+/7Nnb3Sb5Fb7OW
         SGOsTxrkv+9f9k78V9WQA+9uw4x971Xh9eexk+JAnxm5IC34Rh1LVfBDArgyhy/LVxom
         OC7nFIiz7//3lKzJb5zPpbiSe8nq7bjHJI8WzpAYzmWv9kasCoFhq06urkAH6ePxtKF9
         4+dg==
X-Forwarded-Encrypted: i=1; AJvYcCWPBFFBn4mLshwjnuo7qXfAkXRxcZtMS0HD3t3FJscmT8E5iCbj11rieLubwQg9zXBEldVP1tocdImtWH+0J3D6kGIYldBJ3k99V4xnUhNU
X-Gm-Message-State: AOJu0Yy6OoHt/GKab4E6xTD3Fg9GPISjD+wadOUFRsQP6yS7ZT3ubcf3
	RFdDseV6p3f98MzREX2rkW0AP1uGnrikntvJMP54rVsixtXJOz5tqXiF9c1O82M=
X-Google-Smtp-Source: AGHT+IHUW9buXtCYuKZTjxrykbAi6i5Cq4LYHRK4hJkAqxLhJA9p8otmBprZSsNhoHiWGw2zC0DRDQ==
X-Received: by 2002:a05:6a00:198b:b0:6e4:835d:c9ed with SMTP id d11-20020a056a00198b00b006e4835dc9edmr2465880pfl.4.1708754386174;
        Fri, 23 Feb 2024 21:59:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v13-20020a62a50d000000b006e0d44e1bd0sm409316pfm.55.2024.02.23.21.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 21:59:44 -0800 (PST)
Message-ID: <65d985d0.620a0220.8fee9.11e4@mx.google.com>
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
Subject: kselftest/next kselftest-lkdtm: 3 runs,
 1 regressions (v6.8-rc1-53-gae638551ab64a)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 3 runs, 1 regressions (v6.8-rc1-53-gae63855=
1ab64a)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-53-gae638551ab64a/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-53-gae638551ab64a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      ae638551ab64a216364a63c4ee5061f82702fde2 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d97ce67d03b68867637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65d97ce67d03b6=
8867637013
        failing since 450 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =20

