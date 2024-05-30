Return-Path: <linux-kselftest+bounces-10885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE648D428F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 02:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386221F2114B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 00:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE2E5C83;
	Thu, 30 May 2024 00:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="PidbfVad"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686EFBE8
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030409; cv=none; b=IJ1EiqUwHQa2Zqe5+yDJMIR46GQjyoxPryAOvU/iALUffp14LPhRKO2Zsoxxncmvc2MgrXILCMDW8tF3EmT+bwYmzvEjDu82XczkrYy+zDDxB4h7tXTFFPGSczWWP2bDfeU+tfy+MD0JOxyzK0tl3fBppBdGumKy0h8dfVXxQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030409; c=relaxed/simple;
	bh=pMNPvOjU+ZjmQpLnX2znNwhfk5/AWq/mNgDDVpXqEkE=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=tgN0AoCQ2aveXmVevGNz1OqEtCi3yJC+spig2cUW5EcLdwNHLf6keGjUfrehTzZy5Jhp1EAAAQxVxHTVufwy++USIFk8nsfDybnxfZfhe76GOiDwxcqNPqju1ktqNCVRGG7lPUp5p5ZKQb8ekdWxjdAVGmpaAxPw5djhY+uVqq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=PidbfVad; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70109d34a16so332995b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 17:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717030408; x=1717635208; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZG50ZgQ2tpWX6G53vlP9wkA7WEQsEvmbo7jWAGflAIQ=;
        b=PidbfVadT4ETNDAxDeDi3+W4vDs9LGexas1ghdG3mrI7DDUb3bIfkqxnBGC0BLcCbc
         6Y+B+xHIfYvM2p0LHg9LEACkQFv0QM+yXg+geOyBsRYM/T/UGIorkv3A6Q/kOSaDwZUc
         TwtXPCib3Tm0fkJiBpBStQRgH1hqesJBkWfWIt70IcYXdIPHmwksaOnhgGvFKmcR74x2
         wiMfc8Ce3ZbUOWdyHhs+XTZH0l02DWIasALIm6fRGJwOELPMZyPyoq8kJnCmxornpVP5
         OfOxSexMutcHTyVwDVxjm1DnjDHL8ndVPsHv0vwyDLlHfzKT5ie9psLqcnsPcf1N5Y0+
         pJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717030408; x=1717635208;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZG50ZgQ2tpWX6G53vlP9wkA7WEQsEvmbo7jWAGflAIQ=;
        b=jiXq/QdiMBxwfy333Qe8FOXn7+1j8Nlkbr6zbtAzFvjBmy4JbU8v5mnfIGPTjyotzC
         lQjO72VuZPKvy2/oKS/i/NGiIyBfWL1UXNTBEVZTdF0fjNZkfaw6ZJ9inLvxsNQghSzi
         n7HlBbzkRB7tcQeu6fKUHucW57X7hsT42luXuFFyUoAXlsX+MJ/cPLyG84yqD9Cas33V
         dd3z9PADdYGJMz3AhEFstxyX+3p8FWVtOEhPIOk0eLof6ni1C4Pg2jevRGSUdEQd4Lmb
         xFLul6MXMFBx3UfC+lmxSNT2lA+A6g99UcI37XE+3pjyBCNBHGJADvoxmGFwc9TA7jYM
         NLJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT//sLUs21rlG1iiJQYKgwplvLvgC/j6qW74vieQqG3waQ5VRBOOp4apDj98s4m209JrhX+9OBu+evYzgKGIybxuBwIVzDUVUZBp+7DYtq
X-Gm-Message-State: AOJu0YwNvLE80MriosMIvxMr79Mq24yJB2Hm4nondlm9u5nF08wu1W1s
	lg1WTMTC/aNSvCqGG/o9bHp+bQPwCVC53tuSoa0MVlgWvuch1+5P7flryCWtE6OJmvqiZo+GlUw
	d
X-Google-Smtp-Source: AGHT+IEhZUuvxgjx6tZEIh0/hx+LLngli5UD1IK3ncXk7gavSZKpHx5AHBWxa94XUA3+P1lW3NkqpQ==
X-Received: by 2002:a05:6a00:28c5:b0:702:2f19:65a5 with SMTP id d2e1a72fcca58-702311b7fcamr768803b3a.25.1717030407619;
        Wed, 29 May 2024 17:53:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc053bd6sm8596402b3a.45.2024.05.29.17.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 17:53:27 -0700 (PDT)
Message-ID: <6657ce07.a70a0220.fe65e.8805@mx.google.com>
Date: Wed, 29 May 2024 17:53:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-7-ge8b8c5264d4e
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-livepatch: 2 runs,
 1 regressions (v6.10-rc1-7-ge8b8c5264d4e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-livepatch: 2 runs, 1 regressions (v6.10-rc1-7-ge8=
b8c5264d4e)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
10-rc1-7-ge8b8c5264d4e/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.10-rc1-7-ge8b8c5264d4e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      e8b8c5264d4ebd248f60a5cef077fe615806e7a0 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6657bca01b5d42cc547e7088

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-7-ge=
8b8c5264d4e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-7-ge=
8b8c5264d4e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/6657bca01b5d42cc547e708a
        failing since 56 days (last pass: v6.8-rc1-4-gb54761f6e9773, first =
fail: linux_kselftest-fixes-6.9-rc2)

    2024-05-29T23:48:17.420011  / # =


    2024-05-29T23:48:17.432852  =


    2024-05-29T23:48:22.575203  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/14084256/extract-nfsrootfs-w_d4mft6'

    2024-05-29T23:48:22.592522  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/14084256/extract-nfsrootfs-w_d4mft6'

    2024-05-29T23:48:24.818518  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-29T23:48:24.829483  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-29T23:48:24.948066  / # #

    2024-05-29T23:48:24.956044  #

    2024-05-29T23:48:25.073749  / # export SHELL=3D/bin/bash

    2024-05-29T23:48:25.083931  export SHELL=3D/bin/bash
 =

    ... (92 line(s) more)  =

 =20

