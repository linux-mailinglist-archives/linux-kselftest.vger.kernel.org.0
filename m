Return-Path: <linux-kselftest+bounces-17197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F6096CD1F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 05:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33601F24395
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 03:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6374413C9A9;
	Thu,  5 Sep 2024 03:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="sPhap/aG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC690374C3
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Sep 2024 03:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506355; cv=none; b=U8a//7SWjC6LCk/YU4HeWXENl/KCrgR0qp7p8I2aaoFgJbxYv4Gp+SWv1Figd2dOi9QXPW7Svf+wccy80SpAgWGy6xHUrdQbl8a9JXRBvMybJLMphIZb+vMhwVmIgHUhyDBOPX/X9iQP+gMXP8X/b4hRJ4MWF0nx/ccwEIBFiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506355; c=relaxed/simple;
	bh=S5EDDbkXPByOHfcFzZ7/3tg24mX7ftBF7kzgAa5v4sM=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=ISXn7B2FCXNjOs+6JKagopWBA71pZobgp+JY8wClYfISl1M2VnBnP6lkGPDjLbFx8kGzMuhuSs+npurflgSXXrh6ixh+2fxPVf5AK90xahy1dZ7OCAFSgep9RK6VhHPbvignV8lgl8r71s3EVbnMzMwGBIZi/r190nei7k7cipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=sPhap/aG; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so256909a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2024 20:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1725506353; x=1726111153; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x1sZyIgH4xuS/G591eBsibMvM6A/+Ox9Zoh+j6wfwzc=;
        b=sPhap/aG4q7iRAT2slnhJ0BiYF9fs/G+CdQ/51xT73RmWjFRtgoJeTECi++eMuYWDu
         xOkiskHeH0Nq5V+y2fwUMYoer23rWW58BNr5vj4Lpd50wZXfIF3Ep/BMgG+/1dW0YIG+
         eKrH/EXeaLYQo9ORekmU5o3waSGMM3KdfjT3PSU3ZXlG+VbzuH31U2pPApXVQPEWvQDv
         Jsqpy4UVkfGxLYtbVfJV+AbYDKb6ceHzZQR0CgQljhXxR98k6fX7EOkBmU+R2E36W9u5
         8l0pjmHmn5xAqvQZbzsAJnWiGt2M4SeDzmSQF60gctRNOeaf9N1lLGKDwiiFmkOng+Lz
         T4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725506353; x=1726111153;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1sZyIgH4xuS/G591eBsibMvM6A/+Ox9Zoh+j6wfwzc=;
        b=Ona2VMpq5eQ5snx7MvWZ4CmHLqpIxmC+ML8iJHIYdiputDoZdgLXa46ptSS8n+qADd
         nc2fLsnOdouLy9EiKVCLXRDyi/KXIGqMNyrVhSlDNOL1/rAuAU7Jyl0IYESxXER9d6ks
         nxdrkHhfhH4tMGtRf98jUFuMWTW3WVD0W9yP17w57OlI4pkrq0s68mt4WR4cWoIXAkTV
         aimmk0fX3mIcjoflC0pTjJlxXOf/d3zvCPXOM+iUsArcND0qkkOvoN636sbReaekzUrk
         KA1fje7HZiYBcJDyX2vC+IqY+CWzADJBHZh1omlY0xisfaMoevw3nGnzA/9eAWYP0ekg
         ptkw==
X-Forwarded-Encrypted: i=1; AJvYcCXHPiW9iSlififZ4w+s9mRq94QnTa33HcocJd/wguR1c79WSH+7YhD8rsAIJKd3qYxYol1ebJaWkn98N5HmhJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzB6h4M6AIYdpWRdCbyMHanokJuRWSTGOfJHlGLtLpfiEd96jF
	6XKRgDAjLnqjkmfbI2kAsgLvPpnNNEi6n5xBxkUrvWe6BaYNpXzh3xz2Aqxo73c=
X-Google-Smtp-Source: AGHT+IH/UAjMex1zeA2X+2/Q/FrfdUPlqcMHLFj9ejgz26F+IohazXLNZRvDZF71eKhmhqouhfZ/Fg==
X-Received: by 2002:a05:6a20:e196:b0:1c8:92ed:7c5e with SMTP id adf61e73a8af0-1cce101d1e3mr26388966637.23.1725506353150;
        Wed, 04 Sep 2024 20:19:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae90f4d3sm19958955ad.59.2024.09.04.20.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:19:12 -0700 (PDT)
Message-ID: <66d92330.170a0220.344800.8872@mx.google.com>
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
Subject: kselftest/next kselftest-lib: 2 runs,
 1 regressions (v6.11-rc1-18-gf0a6ecebd8586)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lib: 2 runs, 1 regressions (v6.11-rc1-18-gf0a6eceb=
d8586)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
                | regressions
----------------------------+------+-------------+----------+--------------=
----------------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
1-rc1-18-gf0a6ecebd8586/plan/kselftest-lib/

  Test:     kselftest-lib
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


  Details:     https://kernelci.org/test/plan/id/66d91328c30f229e10c86856

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-18-gf=
0a6ecebd8586/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lib-stm32mp157a-dhcor-avenger96.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-18-gf=
0a6ecebd8586/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-=
lib-stm32mp157a-dhcor-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/66d91328c30f229e=
10c86857
        failing since 36 days (last pass: v6.10-rc7-29-gdf09b0bb09ea, first=
 fail: v6.11-rc1) =

 =20

