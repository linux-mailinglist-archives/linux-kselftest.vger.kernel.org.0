Return-Path: <linux-kselftest+bounces-5400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681C48622D1
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 06:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0631C21F16
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 05:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DA717575;
	Sat, 24 Feb 2024 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="3Ic0WssL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066A168BA
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708754390; cv=none; b=k3npGIQlW9gVnT+UiNCOM7FTDh/JJgDSVvSx/JnI1FJaal/IMpi6KNc43g11ZIb3aB0Jdl03Dt19E1T70ezvF5lwp/ngw03gp3QPfwpu6mMdn/5OROSk1IE/UoaUjQIBPvsC5K9ue1HkZnJxeLZA2VwP544H/ONy2I+ZSIoMxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708754390; c=relaxed/simple;
	bh=ACIcBESlZJta1faa8/1EEHP769teX8WjnGd0fO+pZi0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=MX8nTE1NuXLUyZWg1MbGELAQazKDOK9Eq5+ibKO4/T6+/m49PLMJXlF8Dvb/1Rj8e7O/NesxnUZdkCiXx6S+Mf94U0oIKB2n7EMftLxcgPwam0+fBW9qm/r4PsrErwafZpRNnMG4ag+NuznldI5PMPro5m5H1DPzgz/1Y/7DulU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=3Ic0WssL; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a0521b1b89so593602eaf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 21:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708754388; x=1709359188; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FDdzk7jRAlO7EUORZcY1eXMpVquICcYS2UvVVzbb7lI=;
        b=3Ic0WssLM2YvCxkrkq/ZL9OlPggpGJoTvOYZJykApN0TpmDeUH4osLapUwwby2cBdI
         5xbkzeFbeQM3ITlSujykMRySF3leLx7pV6niIQsK1yWDviF1OjW5C7PHPXN8ahZzZjQp
         69Ar8voKgG2jJadUmD42c+RwtNMn9vdELtNuR7erFi1YYOBrWiqaovvDEzFOOKOXAYjy
         XydFZt7WBQ0jcsMffWk5oy1onCciVumJRSgVQw9VLMNqhc4jK1nDbfoNoqkKuwYCQ3+W
         1EWkF8mRypW6VL60LzldtJggek2Vf5/HauQ2YbR0CrZaUCFX2suqO+Dx/N0S1faQAP3o
         Z1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708754388; x=1709359188;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDdzk7jRAlO7EUORZcY1eXMpVquICcYS2UvVVzbb7lI=;
        b=to8kqSUAQAeu6E/YZ+v/7d7BMzydJtqcPlJzCoLfboAkplOaLMtOUPfEclrASYzSxh
         KxCgK/maeut1W+62saWftg6LnzlIeRY1cWevpIk8O/hBR1X8Vt3KU8dtX7siMoGmImrE
         GSkVTOZVlIrLlvcXfMXG0jpnU6HVQnw+IkGuKG7rcf9GkZ6opPbCfgFXQbnkEDjHBY/M
         Gls/snPpgRKVKckfXV09rI7h4Thw1BjJXaPlya7LaZD6DJ0JMeNvkJEAYMxAsVVQNBh7
         Zke/55y6UPC+LMdp1NC+DzHrAq2+hkn6p40luFbBrznsQvphUR1ORb9mOLH8QXyedRRL
         gcgw==
X-Forwarded-Encrypted: i=1; AJvYcCUqdyUqnfk27yyWuemUsVvVKyxXruadxIir5LKJqBb0rXXg/5hNkki1mZV4WgWweD5qZtWJ7ReFkZM50+40lFXNZ+835SFuJXpzsVVbk3cY
X-Gm-Message-State: AOJu0YzmJg1IdKCqnWahTZoJZbdfIciZZ4GPP34Ym8ROy9i28aQTp2uW
	9wHOtq+YS7ujOv3kx+XIfICRWBL8/QC+W0l0kOwI3MveonPkvif3224LCzpEs5M=
X-Google-Smtp-Source: AGHT+IFn6GaW1xXI1dXOiewiF2y2NY5yPmQw/uy9/BLQnukLrW4sHfWxYEIMBmVFFMR8e1c6Fj5pgA==
X-Received: by 2002:a05:6358:6210:b0:17b:5662:f3dc with SMTP id a16-20020a056358621000b0017b5662f3dcmr2351939rwh.7.1708754387899;
        Fri, 23 Feb 2024 21:59:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e17-20020a635451000000b005dc8c301b9dsm435311pgm.2.2024.02.23.21.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 21:59:44 -0800 (PST)
Message-ID: <65d985d0.630a0220.5f483.15a6@mx.google.com>
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
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.8-rc1-53-gae638551ab64a)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.8-rc1-53-gae6=
38551ab64a)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-53-gae638551ab64a/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
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


  Details:     https://kernelci.org/test/plan/id/65d97ac95e7438716b637012

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-53-gae=
638551ab64a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/65d97ac95e7438716b637014
        failing since 9 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32-=
g345e8abe4c355)

    2024-02-24T05:18:03.496498  / # =


    2024-02-24T05:18:03.506371  =


    2024-02-24T05:18:08.651646  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/12846770/extract-nfsrootfs-_kckc7kq'

    2024-02-24T05:18:08.665764  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/12846770/extract-nfsrootfs-_kckc7kq'

    2024-02-24T05:18:10.892206  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-02-24T05:18:10.903149  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-02-24T05:18:11.021855  / # #

    2024-02-24T05:18:11.030274  #

    2024-02-24T05:18:11.147792  / # export SHELL=3D/bin/bash

    2024-02-24T05:18:11.158106  export SHELL=3D/bin/bash
 =

    ... (121 line(s) more)  =

 =20

