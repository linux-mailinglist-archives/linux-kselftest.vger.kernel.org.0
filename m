Return-Path: <linux-kselftest+bounces-7527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62F89EAA8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 08:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9211C211A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 06:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1463410A13;
	Wed, 10 Apr 2024 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="EIpp3TTJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FDC22085
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729953; cv=none; b=ZeKdYGCSQBjgtSFWEM5nib1IAcFFRHcXHLMk0dfCE14BBdCkCeaXJPK0DOoiuY9eMI/Od05VuIwRoMczKlbhgKF1s7PC97kGuZtlGcjK3a7ddVeLgOuFE+aDncuVcSsSDKOnvislnniMKR6ElkE2ORWBOWgsSF47l+FToNwKkzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729953; c=relaxed/simple;
	bh=IX1i7YL978VSoJ5g9nOxQUZSrdUU//3QrTuc1Dobka8=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Fm/MjTk/EWxpcfyREAI08KbSNGl8dXkZtHJ6hg5WhNUC3DRaTg75qj2ndI3eN0S3DGMCXcwlnOGcfogzGlLB2sWVEktoqtKG5uX9pfL8OeL2nK61O6dw7ypoPLgbL/hy5xWQFZmCfL9l5yj/CqQvdHuSv1Z82bt9P7Lu7njI2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=EIpp3TTJ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa3af24775so1870097eaf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Apr 2024 23:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712729950; x=1713334750; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WRNqiuWRyGZ24rzpaastBzidptsPCQ1/kIiiKkSDAYo=;
        b=EIpp3TTJ3BaEWosHco4USXyoGKSwBK8gQYAfcNGfE2NI0ICgXChtYEiilU54H5t1wU
         q/b3KvTYNZhnu3ZQytppgBa71Jwbh3ijtaWzPP2txOMvh37DyGyF9leo5dum/CgaMg3U
         V8Pr8ePsqQzemUWtgjxdB1/q5KUXvG1G7TlnUnzzyNMm2Q4x++xclkqvEYCJE10lPwLf
         lVIecUpOE+VtYXZPLEvR4h8igUi+sXg34wzaZfrcb4sNqKSMY8C3nB4sYfWHdmVHtCo7
         ku/UnApCckRwsdbqwaiH4RgAIerCP7qs9fcY8hZdD/zQ5Isqk24FppMs+4gISx8drBXm
         4SYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712729950; x=1713334750;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRNqiuWRyGZ24rzpaastBzidptsPCQ1/kIiiKkSDAYo=;
        b=mcL+cIX0TJB777HI9oCLWhH7sKgb/Cj8llBPQfzAdDa/FENt3yvZJNcTW1SDr4Y+il
         f0jE8bh1KMiSLiLl+pJ6hY5488KPalTSJqe2SOuaTzZ3df/5npPg0Szu7VNy35SJeSTU
         chYDxn35ohlhYM8dj6ky+4gf0qFz27qjF60xGHmWpA2m5P5SqKEhCIi/tzSlfvevnsvm
         1ra5a7xVfLiKvBdE8iiR0zMydp7PGyIM6fOsA7ikmkUT3OkkgV095QKL7RU17duefkrT
         CQ6D+92Kgvz3D7uP2XJW9RZoZk+V1PjNKZG7hwDiLI+zCT1OB2JRkHDZ0+pFBgoH1qm7
         rboA==
X-Forwarded-Encrypted: i=1; AJvYcCUojoRQzfLY/RXyh3K5UBuiqhuhrJcT6yiSNQpBz6fom1KFfOeMuJnlawrLV6zcmY85KycVpUTX4g95J47JNghjHWKs6WCxwx6VplvOXZe7
X-Gm-Message-State: AOJu0YywKf+0lIygyrJ/P/3+zeWttswdganx5EhqTLfN+ELcUSgpZzWs
	vffAzLbGBq+N4+Mw48RmPwUFMx0ic/g1Wr+iplFYQCS4HDndW+a9vBcBScstQxL8ZaGJckif6Tn
	jdTo=
X-Google-Smtp-Source: AGHT+IF6y6354v6B/S6hjoHmE4kNnm6Tn/kt4V+ONAzz5mfLFTGdN0l3uFZEUnrCtdx2d4r87i+rKA==
X-Received: by 2002:a05:6870:b61e:b0:22e:1f18:6e96 with SMTP id cm30-20020a056870b61e00b0022e1f186e96mr1935119oab.14.1712729950436;
        Tue, 09 Apr 2024 23:19:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n7-20020a056a000d4700b006ed4aa9d5c0sm4237134pfv.188.2024.04.09.23.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 23:19:09 -0700 (PDT)
Message-ID: <66162f5d.050a0220.e8676.d40f@mx.google.com>
Date: Tue, 09 Apr 2024 23:19:09 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc2-16-gf8a3e7c8a5aa2
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.9-rc2-16-gf8a3e7c8a5aa2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.9-rc2-16-gf8a=
3e7c8a5aa2)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc2-16-gf8a3e7c8a5aa2/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc2-16-gf8a3e7c8a5aa2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      f8a3e7c8a5aa2c6ba90a014edbaf827c12da80c9 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/66162103f432b107544c42da

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc2-16-gf8=
a3e7c8a5aa2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc2-16-gf8=
a3e7c8a5aa2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/66162103f432b107544c42dc
        failing since 55 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32=
-g345e8abe4c355)

    2024-04-10T05:25:23.733705  / # =


    2024-04-10T05:25:23.743418  =


    2024-04-10T05:25:28.884756  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/13322914/extract-nfsrootfs-cijwayce'

    2024-04-10T05:25:28.895715  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/13322914/extract-nfsrootfs-cijwayce'

    2024-04-10T05:25:31.130036  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-10T05:25:31.140938  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-10T05:25:31.259935  / # #

    2024-04-10T05:25:31.268885  #

    2024-04-10T05:25:31.385922  / # export SHELL=3D/bin/bash

    2024-04-10T05:25:31.396168  export SHELL=3D/bin/bash
 =

    ... (128 line(s) more)  =

 =20

