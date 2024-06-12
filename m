Return-Path: <linux-kselftest+bounces-11734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691D0904963
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 05:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821501C20DD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 03:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624B11799B;
	Wed, 12 Jun 2024 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ddioz2Ra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF3911182
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 03:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161794; cv=none; b=TKgYuf2FXQJLrLPm09+E7cZF/0fpXBS/q94VrKmc4EOvp6492nSx8kegMdG4LuwJGoj+BqcUDUAEDFrssZLDPfoPbm5jVFLpGGD+V0GL7iUB65hB0sn4KoU2dEvuJFOhRgk0wLMbcjvSoHRftwM27nBKDBtgTOJII2U5D092wzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161794; c=relaxed/simple;
	bh=CnRM+Mh8PYR/TOSZpPle3kdXlFSJ4miGuDNJyQth6gM=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=p75i1k1DYQyXjQ2zGrWk6g2+De0y6M9nlG2jO6xWtPkAKKMFxJ2tfST8vGTmzKpRVonIQjosDRlLjyacWEmxjaDD1C6BoH4UpIjJ0dIe72AOoyF8TBUzCDPJ2f4V4MDCUiQazC9c1sOV/BRjF3LN20Vg/PBDB+vVq4Lp7JHJQSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ddioz2Ra; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f47f07aceaso55139195ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 20:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1718161792; x=1718766592; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=21Z3XvFX395cCuF8jQ0UVuleH8Ogb/n0z0kSzer8iIc=;
        b=ddioz2Rap4OhnH9msi0M1SRIhQ4wWGAKNP05N5Sf5Eeg59UW+LG3uu5XAT5oDQ1Ftr
         mMrwU+y/lHYFP3pSdnCVD8upmLLBHf8lwxhusgFaOOTzoy2QL8bFqCshSVS/OW9UGoI4
         iGFp9MNMNY/vdfNLvKS5T+IK+c84M4jASXOEKFeOJroZEEnf4LkL9RqmuAArPBoFDWKX
         tQEd/bgTG6WJMuRAWWKaXPNNd3gh36yhlhfgClJusXTn5268WIxr1YrHTfpM3jKYaGyA
         QoXoZiVf6lQoylhuMoJ+R9XIDWYxjO95HRfcUJ2XEpJqiJhqkYKrNe1Wh5sPtcJNtw+z
         xdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718161792; x=1718766592;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21Z3XvFX395cCuF8jQ0UVuleH8Ogb/n0z0kSzer8iIc=;
        b=X5h1WIMg41zZEETq5ZyeeljAskoxsKGuLliHuIdsF1CjYk7ZFyqcurWHynoZDjbO4j
         gRp2H1aXM4la5rsMMJkW6kEqvVvEe/cZbZeFzyZKksmJu6+HY0FjTUsUk5q0qsLMOfBO
         CZNGbj4ahWd/gwItRntzbkasurslMy+ffbpPOrORxnr096rtHYeDxJntkrlO2wNVN06n
         Kk9Rv3NOH8F1ab4GDzxrz3lBRj6zb3S+sMFiBi2DMQjnBNxnmcUeJ3Zm4IO1HRFz/Uj8
         f1On+ccW+PJ9pD6RTtxAzZ4tTqbiSFT9OlXkyb6GDfaV7g2pw/LpOHy9y7fiTPFUFhTd
         nQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbi+GbT43HsKmYbX1XQzTfkmTgIJZyhowuijie0+wnxkoHXsBegGWRbkwfl1/snnsda0F+WZYE+V6/HQUCtaVKMzcJ8tp9uBk+fa2HXL+g
X-Gm-Message-State: AOJu0YxzI4mQDZoVlIb3AanIp9Z8bhorzn+4bCnc12A7lznyKhnK1Xua
	T8Ib2ge/vHoL9W2CvCgcOKLSQ3s2oHX5gOZS9Hjqn3KJXNj/h61vT6jJRLckiC/NkN8QxvHw0p+
	rh5Y=
X-Google-Smtp-Source: AGHT+IGGzOeYwKh0sLIwqyUWRUn9IdOfDGuYXBcvOpf4vCQHTvyRJMHiWA7KxbXuPVJBhbQ8EhMh+g==
X-Received: by 2002:a17:902:db07:b0:1f6:62cb:7c22 with SMTP id d9443c01a7336-1f83b6ed458mr7012945ad.46.1718161791921;
        Tue, 11 Jun 2024 20:09:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f7029c5d63sm58617395ad.299.2024.06.11.20.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:09:51 -0700 (PDT)
Message-ID: <6669117f.170a0220.67476.237f@mx.google.com>
Date: Tue, 11 Jun 2024 20:09:51 -0700 (PDT)
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
Subject: kselftest/next kselftest-livepatch: 2 runs,
 1 regressions (v6.10-rc1-2-g64f5bc57b24e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 2 runs, 1 regressions (v6.10-rc1-2-g64f=
5bc57b24e)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc1-2-g64f5bc57b24e/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc1-2-g64f5bc57b24e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      64f5bc57b24e8c7935d51732571d405acfcf4b99 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6669009c63cd4b2b267e7091

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1-2-g64=
f5bc57b24e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/6669009c63cd4b2b267e7093
        failing since 118 days (last pass: v6.8-rc1, first fail: v6.8-rc1-3=
2-g345e8abe4c355)

    2024-06-12T01:57:13.452100  / # =


    2024-06-12T01:57:13.462271  =


    2024-06-12T01:57:18.601719  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/14295387/extract-nfsrootfs-ngjfxq8b'

    2024-06-12T01:57:18.612548  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/14295387/extract-nfsrootfs-ngjfxq8b'

    2024-06-12T01:57:20.846234  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-06-12T01:57:20.857036  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-06-12T01:57:20.975780  / # #

    2024-06-12T01:57:20.984683  #

    2024-06-12T01:57:21.102030  / # export SHELL=3D/bin/bash

    2024-06-12T01:57:21.112406  export SHELL=3D/bin/bash
 =

    ... (85 line(s) more)  =

 =20

