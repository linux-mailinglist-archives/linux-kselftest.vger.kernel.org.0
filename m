Return-Path: <linux-kselftest+bounces-8246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363918A7CCE
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 09:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360851C20D20
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 07:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CE36A32F;
	Wed, 17 Apr 2024 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="YHFHI+1a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AF152F7C
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Apr 2024 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337626; cv=none; b=hYvMTDnQqSha1fj6uYBqvzF9SLx+u0LqATxLdtXU1OyjeUolHDOxDTl4Wa1knFW/c7nfWjbFahmqMsfADUVxAaLHSIs/kuOUQH81cJMeVWocSrlNioMalzPEylLCkPJQBPxKOBMXrfjLnzZYZd6jKdpZw9TYZfRqRmQqxu+b1Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337626; c=relaxed/simple;
	bh=bYVDF4bBJmm8D7n1NPvkKzoJWSus/hGXm6Q7EvI/20c=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=RfU5FaDvN/ZMynHRmFucNEO6JS0shrl1hnDA2RS0vP6QlVBEQfdRUQbHGTcb6iHVSR+FqNqqWzR5lk3ZZD44vcNCJPckfDeLFK2rwmztm2tFbhGBqHXm5tfrn4onV7h7HO8Yrb3M4BEfJAgxmnKAHhHLHj1LHcJijk7GmJCmqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=YHFHI+1a; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36b38a2288aso486855ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Apr 2024 00:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1713337624; x=1713942424; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GiRg4XJDqbS8aqbI3jSd++1sAW9dYdNkzG8qMIGL8uI=;
        b=YHFHI+1aw/DejPhIFBVYA7Y2d/7XtsdYlOupyAh7optHAn2yFPkLAanTgmG2ej+JGZ
         XqSSoPhqhc3OUtiZeqaytqA659BLo+6AxT5BWLRk47LvOHN1iax5NW7hwBMLRTxRhlET
         WOckKhEtfQWm20nBsSbqZaVeyUSSRF6tGMqGdfBhyJJ2Qc/bo8lY5G7x30yNRjipbf7b
         Bnzedgt/Fpb2C3beRCDuulgs94Gr1ndmtZOJjZcmCkguFRt48sSvz61AmmVO8gFxsju1
         Inh8pOHOdlhDJXM+bfZsm7VFkI6poOBiUom9qLj02OfLBSmX+mgRh6PFQfKM1I5cdCXm
         JtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713337624; x=1713942424;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiRg4XJDqbS8aqbI3jSd++1sAW9dYdNkzG8qMIGL8uI=;
        b=BICgKOnlNctJz65zr9/D8ZTymtN0YN/ZfKvd8arm3YDMKlTLr8ArnVRYRxuabOTslf
         3UrG7zpzKIOse1POf/4cQ1cDor7YoDwrwnMnxPJd7GrMYRQFlz9dabshq2MxN9CyyNfq
         wYTaEhPZQf057XpyrEfMFpxllzU6JKeZjecki7v3q6VPclOJfJJRDkC+oN/hh8J3/uxU
         EgCWE69qCj4oeUPDEjtXiz8jB8h/WIhuRMR+c6iT+pCCCefmSLxvEGOx4ttUsnQB4xY/
         sxnL4gsrdzTDn01wJw8AcNjXUu3o/A5h7nTj2fFHMl/VW0iZeG9PgriRU18WXE0Uus2Z
         +s3A==
X-Forwarded-Encrypted: i=1; AJvYcCVHthFW29u75wCldvETq0lJJyRf3yQaJ3th4Ko0xrtDEu9Vjn5pfMiB3Oxj8V/mGnUYvZqH93xUyLgJFxBIkQJNnc3gAVmvRDDu3Ma5XQLR
X-Gm-Message-State: AOJu0Yw2hlst/NYYXS5VrelyFPWlP/imo2Hy7vh55ncAwExTNuZi+tPM
	bCrEO035ERzA1M+k92v+rGSXsAyZCzlbbVNf5wVX9YCVxIqyRTjHXuzCR07KSwQ=
X-Google-Smtp-Source: AGHT+IGEHT7jzBYZCed22OS9ErNqnKjkFkd4Tf6D1UVNcZzVdv6YTCeoLWGfLrtsPq2c9oZ8kAAF+w==
X-Received: by 2002:a05:6e02:b29:b0:36a:36d9:36eb with SMTP id e9-20020a056e020b2900b0036a36d936ebmr18069597ilu.27.1713337623873;
        Wed, 17 Apr 2024 00:07:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m5-20020a632605000000b005f751c18d0esm6654930pgm.86.2024.04.17.00.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 00:07:03 -0700 (PDT)
Message-ID: <661f7517.630a0220.4cc37.495a@mx.google.com>
Date: Wed, 17 Apr 2024 00:07:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.9-rc4-19-g00ab560eb0e3
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 2 runs,
 2 regressions (v6.9-rc4-19-g00ab560eb0e3)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 2 runs, 2 regressions (v6.9-rc4-19-g00ab560=
eb0e3)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 2          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc4-19-g00ab560eb0e3/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc4-19-g00ab560eb0e3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      00ab560eb0e3f9725521c9fec2e8992e9e7e6c29 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 2          =


  Details:     https://kernelci.org/test/plan/id/661f683339d66133414c42e1

  Results:     61 PASS, 5 FAIL, 21 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc4-19-g00=
ab560eb0e3/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc4-19-g00=
ab560eb0e3/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_FORTIFY_MEM_OBJECT_sh: https://kernelci.org/test/=
case/id/661f683339d66133414c42e6
        new failure (last pass: v6.9-rc2-16-gf8a3e7c8a5aa2) =


  * kselftest-lkdtm.lkdtm_FORTIFY_STR_OBJECT_sh: https://kernelci.org/test/=
case/id/661f683339d66133414c42e8
        new failure (last pass: v6.9-rc2-16-gf8a3e7c8a5aa2) =

 =20

