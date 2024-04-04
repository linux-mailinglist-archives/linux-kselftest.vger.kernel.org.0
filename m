Return-Path: <linux-kselftest+bounces-7232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EDE89924C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 01:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B5B1F2344A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 23:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5322713C691;
	Thu,  4 Apr 2024 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Dadby8cG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF22130E57
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 23:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712274649; cv=none; b=Q0qjpsUuSvNrLJjsYDq8oTIWoLsMUgU/3iMHm9bF9VS+1gazSBpf4tRqPsZZv0scCu/6rAoZ9E+hwOaxh31Ps0GtQOM/8GhAMS9fyUWV5rAmvy85JduMilmxTScnBl6HRWjpk73waHsjR/WDHwBhtBpGzonfltOCqbGA8yeJ8ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712274649; c=relaxed/simple;
	bh=TKdsVr6V0n+NCg3F/1963auDZx1r4oj9k7VUzO63EDs=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=EA8gTPUkaPwLFXiV5KBUJ1bi/80HuqFqsJIA8tA8RFvDBSPOivzWM+T4QXhMYlzWw1M6E3jVcxxeMKI+aCudtG7D7MZW3lD69B3I5zKqrOlhuuzCsthODgTNrBJ1znGf6C5chPbdLBddUafAznEZlMsSyeUVyF+f6kswJy6SdK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Dadby8cG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e29328289eso12433065ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 16:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712274647; x=1712879447; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LOtZIB6ErhgXlqLBKt80MhABUjCjHy4XFR26uMhY54c=;
        b=Dadby8cGSnnnKTY9f4SyoxbHCqdje2VaGhcpFGKES+PeZ6BRZ0jPRP3eDZsfkrt57n
         wxD8kfJM4cWcmWCGF/k7B8DTf9KMjRRnAaND5IRpEh7KrEs6TbovlfA5U5/LZwtds4OZ
         /Jd5tC6YSyEbXvnKPduNDO3uJ1Hew5cVHgSL28aecj+kI3bCf8Sw8CDhK/BBD9Lng3jE
         NAZjPFq1m3HqlDntSi7hWvMmPqdnraOb12yTjzcXKfn6Q/O/lgECVWCObMsTfdE/qBqc
         VdnmdKZqKVfHLK5Y82/iS/sPzI6M1GUaSFHGvT9xrN5D+JA2AmicQC9xT4hyMIFX/VAu
         3mBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712274647; x=1712879447;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOtZIB6ErhgXlqLBKt80MhABUjCjHy4XFR26uMhY54c=;
        b=Kfrum4JOZYjyMVpS6KxK8kSsgHiMRCmsoSXhMl6szZkDpaMtD6ROMlu7C/N39S5GWj
         0aCCZuot+ATIIRIFGZNoTi52KyY5ND2oymn9F/JmmXUt8+6pdLLGllgfcE8VulnFpXmR
         mnNgTVopLe+vatLX88BqOHT8llYgcrDvRLTpjLnfR0ModuOdG4dG5+dmbsDj3YP2Cxmi
         w9fz0uRZEbe7lidk55DJqMXdRj4J2ZQiOBI/f3GcFT/EAin40Cqfnk176jTlJ5X2pDAL
         r4vYME5CZxtYDJXvaQsagqbx9ZU2HFWWYicaZJySpr0WAPnxGMkMj2UlRM8Fbmy+tlun
         vUJw==
X-Forwarded-Encrypted: i=1; AJvYcCUHVASLkRPHH1pvuY271XMyaOTdtLIqqEp71krXSg0gug6MzFkmTD/2v+2KkJnGDHS2LkIK3/Zz6AtECMfAjxo7HYrM5xFhCqq+tC/pIFj2
X-Gm-Message-State: AOJu0YyD/z8GF/+MpfiAINcS4ZxGreDCadUZTuH2nCjgGDkyr7RtMwU+
	ykpGZ5EAQUVTd8u58FWMl13bzHV6i7z+mS/MWQMW07Z2uQdc0B2uDdiAoLyWtF8k+mmBVpThgSZ
	eNLc=
X-Google-Smtp-Source: AGHT+IERlM+9Hdpk9G3nif7a10UDqMMEpNdp6ORkamd2Ld43bOvJjZeWW9bfUeAKcpxnzbGFUPe+eg==
X-Received: by 2002:a17:902:e849:b0:1e2:952b:81fc with SMTP id t9-20020a170902e84900b001e2952b81fcmr4649603plg.29.1712274647006;
        Thu, 04 Apr 2024 16:50:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b001defd404efdsm213072plf.13.2024.04.04.16.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 16:50:46 -0700 (PDT)
Message-ID: <660f3cd6.170a0220.32bdd.14a7@mx.google.com>
Date: Thu, 04 Apr 2024 16:50:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: linux_kselftest-fixes-6.9-rc2-2-g72d7cb5c190b
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-livepatch: 1 runs,
 1 regressions (linux_kselftest-fixes-6.9-rc2-2-g72d7cb5c190b)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-livepatch: 1 runs, 1 regressions (linux_kselftest=
-fixes-6.9-rc2-2-g72d7cb5c190b)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.9-rc2-2-g72d7cb5c190b/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: linux_kselftest-fixes-6.9-rc2-2-g72d7cb5c190b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      72d7cb5c190befbb095bae7737e71560ec0fcaa6 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/660f2e7dc29487bce04c42fb

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.9-rc2-2-g72d7cb5c190b/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.9-rc2-2-g72d7cb5c190b/arm/multi_v7_defconfig+kselftest/gcc-10/lab=
-collabora/kselftest-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/660f2e7dc29487bce04c42fd
        failing since 1 day (last pass: v6.8-rc1-4-gb54761f6e9773, first fa=
il: linux_kselftest-fixes-6.9-rc2)

    2024-04-04T22:55:54.609660  / # =


    2024-04-04T22:55:54.619242  =


    2024-04-04T22:55:59.763559  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/13259881/extract-nfsrootfs-p3qzmbom'

    2024-04-04T22:55:59.778371  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/13259881/extract-nfsrootfs-p3qzmbom'

    2024-04-04T22:56:02.006017  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-04T22:56:02.016977  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-04T22:56:02.133853  / # #

    2024-04-04T22:56:02.142265  #

    2024-04-04T22:56:02.259929  / # export SHELL=3D/bin/bash

    2024-04-04T22:56:02.270150  export SHELL=3D/bin/bash
 =

    ... (118 line(s) more)  =

 =20

