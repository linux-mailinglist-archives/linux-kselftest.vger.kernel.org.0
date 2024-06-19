Return-Path: <linux-kselftest+bounces-12196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A1490E18E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 04:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F0D284547
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CDD26AC6;
	Wed, 19 Jun 2024 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="mylyToDS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1057D17C66
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718763334; cv=none; b=GBSe/S6HOs9eCgiD3iK82bNm/pMkQQDHHF9q6FwhTy664qK6jNT1puqz1FJs1MRAsEfkeo6ys/5Wbrs1D9eqTZC/S1T5aF3PSdKpoqiw/YRpUZOpKS6H25YHNapsVkHBtecv0wIjpB9EpvrVHDVej2evTU2026wKMgqJgJShun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718763334; c=relaxed/simple;
	bh=HM6OC5/JHvIGZCfs4qnXLc7/RZeGXTNT9uDA84KgWgI=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=kihlEGaj8YxxWUWxvjV4lcDOsSE5VAgRiB1pwSNLYn/viYq9e0Ol4Djm3D6T5Mkjj8E8ADNl/VJUkVcxzexXmxQkPn4CuPjxXFHaJ8e4WPfRmmNkUVClrTf4GIhq7TVfqgBHNxeKQ6nPaR4kGRnogIPgqgGkhVqd82UURlA1f/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=mylyToDS; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7041ed475acso4847667b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 19:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718763332; x=1719368132; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ6Hfrk0oj7P+DAm1Mhg3tlwK2pyIIgSoodG2N872lA=;
        b=mylyToDS+lmRCzJG4Yr7pBrI0PNXunL0equKCNA72OqMBMTrPefwzdaJQo3p+6fx/V
         rEEGrC0eI0shKsbjPm6XsNqmozJdlwuirZ2g7OmLBbFpK7cKkE5dkEjkiM+6EzcIRmt4
         T1nr5ssqIZLZ4hwtxBQy54zJVfrpMDJxyLD3joCrdP+ZhIJh36yibyGR7QHIDxFer1t+
         Du7oQtL/ga4T7lMy82PYej06LWxEcs2w4F2AM+YJBH4lbJm3B1d/FKFM7jAEXbfM2JDh
         /Gmj21rl4ki3cmM/bBQA6EBQFZqoPl9kqEuQoSMJa/xWQI8NwdbImfzZmzQ0KPDLYJIp
         sy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718763332; x=1719368132;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQ6Hfrk0oj7P+DAm1Mhg3tlwK2pyIIgSoodG2N872lA=;
        b=SjVaUH0SUj8Lg0JYzm73nJkSU273zj3uuk1k6M98am6yVPKLZCnnbvINThztcfRb+e
         LaRgHEuqqLYVBUqnirEFNYrlSg6MOsnfx8FM1gjhMfimu/yykoJ/OFweiLdJuCuuwqmS
         I743ljuhgLxJA7OoBU5w2hVrSIKgEaLid03Gaj18rV0u5lSNVJv+wrPtoUzJYGI2Gfg3
         yoIsT+N/7PpgMoMtTXLyKmMd5TWu7bZlOH2dwSkdcXpBZs5KvvdKRJ35g6BpNxA2YVHk
         frTgll9N6W95e3DKRWgz6R3oYPcuyf+mcdtCqoFADUwwc46Mm/O3wuD1FrMvyXr0ZM9y
         C9wA==
X-Forwarded-Encrypted: i=1; AJvYcCXEHboX5TFlW8sYFlT3SWA0Ua/bQwKNapfGgI+HUt+iLuxlW5/5i3XLt/FWcCYEAALlobjazC1Dvpxr/Ocw/ezJ7N7jzAYdFqeA6j9Ey5oi
X-Gm-Message-State: AOJu0Yyw0FhnH1Qknrr0dVUGldijJf9aMMMONGdBzSKRxbPg3ISW61MT
	YHQm12pHdMWM2R1vlvNrdpASrrjWh2kBT5UGa29zM0ta3pFMX9SkAXff5ryrnN3T8vV6CLxQ+tA
	7AyvkJCxp
X-Google-Smtp-Source: AGHT+IHnxNge83Ir15UShLfBZcpkYur2Ot0AfdI0gtQ/of83w/5a+cbGx4xfHs6WSm17M/THqYhZaw==
X-Received: by 2002:aa7:8a57:0:b0:705:a7a7:b31f with SMTP id d2e1a72fcca58-70629c41564mr1157367b3a.10.1718763332166;
        Tue, 18 Jun 2024 19:15:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7063413b5fcsm150872b3a.55.2024.06.18.19.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 19:15:31 -0700 (PDT)
Message-ID: <66723f43.050a0220.9c372.081f@mx.google.com>
Date: Tue, 18 Jun 2024 19:15:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-19-g15a783a493b02
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 2 runs,
 1 regressions (v6.10-rc1-19-g15a783a493b02)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 2 runs, 1 regressions (v6.10-rc1-19-g15=
a783a493b02)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc1-19-g15a783a493b02/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc1-19-g15a783a493b02
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      15a783a493b021975f3dd12bdd95a7080df0e8cf =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66722da361f38993257e70ca

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1-19-g1=
5a783a493b02/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftes=
t-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1-19-g1=
5a783a493b02/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftes=
t-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/66722da361f38993257e70cc
        failing since 125 days (last pass: v6.8-rc1, first fail: v6.8-rc1-3=
2-g345e8abe4c355)

    2024-06-19T00:59:46.886727  / # =


    2024-06-19T00:59:46.896727  =


    2024-06-19T00:59:52.029861  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/14425648/extract-nfsrootfs-jut9pq97'

    2024-06-19T00:59:52.040563  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/14425648/extract-nfsrootfs-jut9pq97'

    2024-06-19T00:59:54.273533  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-06-19T00:59:54.284403  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-06-19T00:59:54.396745  / # #

    2024-06-19T00:59:54.405502  #

    2024-06-19T00:59:54.522821  / # export SHELL=3D/bin/bash

    2024-06-19T00:59:54.533284  export SHELL=3D/bin/bash
 =

    ... (74 line(s) more)  =

 =20

