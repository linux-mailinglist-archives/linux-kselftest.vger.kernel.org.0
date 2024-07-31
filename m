Return-Path: <linux-kselftest+bounces-14586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E5E9438BB
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 00:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED716283E2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 22:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C51416C86B;
	Wed, 31 Jul 2024 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="sdfFMp+M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF616C86D
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464475; cv=none; b=h4Z90GzcQnLOz9EvdL+7ijHC9vCz00R0ipCwrxKFPn8mqeZHqmzpAy5F86Sa0bD7iEluT2RNUXnrSJq3IxWSH6M5gh6VUt7jFuUJM134lhDBjO/AQVHXo0wRZKYE8CAi3j10UCW4pzfIPbImkQzQ2eFYY27g0mTSuAQ3tyCbGc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464475; c=relaxed/simple;
	bh=FGroTnom6XFlBRA8uC3b+MjPArrVPHE2ZYc+zVzhBpU=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=J5QP2xGvMc2/ioe2eeH6ibnRubWOO4Ayyi3+briicI173Ptig7Lqkkyonko9GvUpeHTU0zC3GyFsBYmZqddWDExHwMeFgQXIlVVasGOB+pOyb5Ci+fQgFKXSOppEwzjfady9I4v1K6knXjo95JGOsWN1KlPrtEcTiEX7mHb6PE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=sdfFMp+M; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso4118056a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 15:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1722464473; x=1723069273; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1LqJtUGzkJo5msz+4eOBt7LeaSI/5iH10L92Jt+7dAk=;
        b=sdfFMp+MvA+fs0gOWMQZM/I1ny8K97lpQk4EAtqu3Wfv8Nul3yex4S0RnT7rCWfQCL
         CYRvh5Q7Tly1kqLhiuhnBxdx4X6MFcVBz8qM6LnvcGQVqUrzZba6Bb3hceIiQiaoE2kW
         8EVOQNLaNywuZDtghQs9azzkFy/MjVpSJVZEL7TBF2fe24KiLCpzsS7HK9xRb+WC/KMa
         rENEpUVSKOLSx7RXfuulBlC9SupkrEmW0xSB5TS0834ZGKAOFRrzAFMrkn9hPm+Xn8Mh
         xpBf//IyyapAJOs5XJ2c/TnOXtuJCNOkno9Dh0K7Y+Ty1Tp19m8CXAlnSo7HtqzDnjip
         /n7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464473; x=1723069273;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LqJtUGzkJo5msz+4eOBt7LeaSI/5iH10L92Jt+7dAk=;
        b=GGuyoqt5p1ieiGuQM0s8VIomH3ka/K6G/fai/zWghLUUwie/Zfd8TUCc6ilGn1hzoE
         RPukrC1sne5r77U7rHDO6j2mrcs5zMnhdJTJ6osEgj8fS3UQduC/WAnrmPe9QV2TaK6I
         CkLH5JIfrqXjbL9z3uRqW4BL3U83bokkPl0lMv1TRYXILo2eEBrTRJ1C27j/OaCsWwd2
         SnHMMUqhw5Y6h3uz3xJ6Zc4corBl5nGcGmwK6SwbdrnnousWBVSJ7CKO7o/yP9I8Jty7
         tVZX1WoDB0NBFziHvOcKkLA9KCcj7Nczesh/FwQxVEEBDj6tvVIuGKIRBjYn19lCoDgN
         zwpg==
X-Forwarded-Encrypted: i=1; AJvYcCVtuc99C2HlQ58UdngSrUp7aH1Dzg6PH7XCQQ5JSuJBGi7RONKfxuknWR9hgaE0mbHrcdF1/JPmJfcykzIAjXutPsupSl0O19Y9vaHxrqRx
X-Gm-Message-State: AOJu0YybFfOFsAZjX2eJ2tJ+wRWqzOMQxi/x2g/eqTm0018GHqjPZH98
	u8qIhBzvBR+l+XYYj/QVGwFym1/QbA7jJiTPx0jlNMJts1vznYnP74cC8g4Zwow=
X-Google-Smtp-Source: AGHT+IEuAEmKthulgoBG73jP3UL5bdZ0OxdepyzHDSqNMAShP+y6JGJWjTTXLijakpjgvO5XgFztnQ==
X-Received: by 2002:a17:90b:1114:b0:2ca:7e87:15e6 with SMTP id 98e67ed59e1d1-2cfe7b70c1emr792497a91.38.1722464472938;
        Wed, 31 Jul 2024 15:21:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4aa0c2sm1856274a91.46.2024.07.31.15.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:21:11 -0700 (PDT)
Message-ID: <66aab8d7.170a0220.188ef7.5d6f@mx.google.com>
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
Subject: kselftest/next kselftest-lib: 1 runs,
 1 regressions (v6.11-rc1-6-g38cde27f74d8)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lib: 1 runs, 1 regressions (v6.11-rc1-6-g38cde27f7=
4d8)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-6-g38cde27f74d8/plan/kselftest-lib/

  Test:     kselftest-lib
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


  Details:     https://kernelci.org/test/plan/id/66aab22e093b574a087e706f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-6-g38=
cde27f74d8/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-li=
b-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-6-g38=
cde27f74d8/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-li=
b-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/66aab22e093b574a=
087e7070
        failing since 1 day (last pass: v6.10-rc7-29-gdf09b0bb09ea, first f=
ail: v6.11-rc1) =

 =20

