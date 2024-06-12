Return-Path: <linux-kselftest+bounces-11733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE78904962
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 05:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901D31C211C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 03:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0056111AD;
	Wed, 12 Jun 2024 03:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="CuYuPMtQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41480BA31
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 03:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161792; cv=none; b=DcnhQMA51/4bufMq4l9OFx+5IGADDb4d74IA47P6BtxyD4STqfO4jgK7bumQrnEOn18j/ZGxo+jP0MiJ++VFnc2hRuE4Iyqz36xt8fgqALqqKySPW2bCo3TlaAO0CqbiKF+Qo70BlBChWcFz8czOsWIzYq3je+rn3oYmbGVGCD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161792; c=relaxed/simple;
	bh=fcWkxLhgab2O4D88CZOsJRETCvjk/J/JbDCqASMGJEk=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=LsDpselbL3ako1SGmMxh5GR2YTYE2l+b8iqKizlkAnoycR67pXvLpNYv6CkJU4a2aMo23PmouP14JqCjmCcrdb5RJC4qYKbJb7Xm9sHMKAzY+Tiyv/cfe1tPaMxjV2s8k+rRVMsJoPIO2QBcV5rMluG6eZPPNMPnjCmsn8roLvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=CuYuPMtQ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c2dee9d9a1so2901494a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 20:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718161790; x=1718766590; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TqH86VXnD4+OKsCQukXD83IXGNQyRZRJ6kW7U3DWywE=;
        b=CuYuPMtQLP2JRbzaHig/rArC0xnPCyo0LBQg1k05QC1/4uuONQdvWHE6mA7Zm4jYEv
         5WVAI6RNH9EMfIhN5p9jIeYmPKLWfpu+F20aBRYyDT/u/n227AQ02s4cYTWpzMjB6PAR
         6yEpGuJSWiToyG+eWgk6AswXU6qGghcGI0L0RlZakz+QL+hmXQSw+QElfNCj0D+QwgmO
         zggADujiJ+0T3Z4Tc/u5O111Ru6PjNv4svTzB0tvCkX0c8wAHBZ17flMcxtvezA3aMOT
         CFOEzVhVTwXt0L6gT2164YSrGhBoR+XwOBO+3ctAOoyuYSAfNyXaKdqSvU5hV/NX1Hu5
         34gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718161790; x=1718766590;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqH86VXnD4+OKsCQukXD83IXGNQyRZRJ6kW7U3DWywE=;
        b=mMb5aNruCjbajJpcsR/JKo9AkSfl5jplskkERoVmq6t/llLOVk1fk7wMN8iduyaYlj
         2XEG5JqoKyhMhDW5y9ftDnRkT1A+ht+ouaEQhI6/T0F7Nu48U6dzXUqzqYa+egERf/99
         y+I5mq3rioBPrwP2PDThNdmX6pO3YYsMKDzBMDwrjC6gr+FKrz3rIcMwTsWXHoDPwV3I
         0Lv0dMaynznviQBHlTz26oPPNnQ3i48zT/FKIcwtkWuoKsxexcyOWym116GN3seTEOCh
         Fl1RvyCFs715X3osJtxhjdxRL1PZvF0YzgVHR+nH5z3GBn+7AWqvFT438Xr9VTxAj5Jj
         KBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcOH/jospryvh3h2yjG4u0ozAs/tJKvq/ZO9oKS+xDnptV2MyRMEbpo20IEw9QtGLP197yIzyvTGjYzZz5c6Hzwh8+WbQgBLdqSpi3jfiC
X-Gm-Message-State: AOJu0YwNM4Kg1ahztPVvHhtOnSOyNmWkZ93nRAOEvkQqG6YjHMz7vaWe
	QOA5Fc8OuDBJpdtAZ8s5ZpfMpBI9SSqWP7LUJbkN5w+xRrX/PNQDwIp9OFpEnxE=
X-Google-Smtp-Source: AGHT+IHi9rm+Wo51nNwS1Ss4usKu0j5uKbfPzwsMjBrMoj8T+Y5TPv8jFhL8c29iKgrb5CxG5axmBA==
X-Received: by 2002:a17:90a:a58a:b0:2c3:7d8f:5eb1 with SMTP id 98e67ed59e1d1-2c4a7624b86mr646381a91.19.1718161790406;
        Tue, 11 Jun 2024 20:09:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6eb420e918esm4639275a12.2.2024.06.11.20.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:09:50 -0700 (PDT)
Message-ID: <6669117e.630a0220.1cce0.ed1d@mx.google.com>
Date: Tue, 11 Jun 2024 20:09:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-2-g64f5bc57b24e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-cpufreq: 4 runs,
 1 regressions (v6.10-rc1-2-g64f5bc57b24e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-cpufreq: 4 runs, 1 regressions (v6.10-rc1-2-g64f5b=
c57b24e)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+k=
se...4-chromebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc1-2-g64f5bc57b24e/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc1-2-g64f5bc57b24e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      64f5bc57b24e8c7935d51732571d405acfcf4b99 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                  | regressions
---------------------------+-------+---------------+----------+------------=
------------------+------------
mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+k=
se...4-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/66690987f94e1c493c7e707e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8192-asurada-spherion-r0.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/=
kselftest-cpufreq-mt8192-asurada-spherion-r0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/66690987f94e=
1c493c7e707f
        failing since 14 days (last pass: v6.9-8287-g31a59b76b978, first fa=
il: v6.10-rc1) =

 =20

