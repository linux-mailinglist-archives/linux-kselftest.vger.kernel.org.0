Return-Path: <linux-kselftest+bounces-10446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1B48CA222
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 20:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6703282466
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109191386DA;
	Mon, 20 May 2024 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="tkl7o3MC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750AF1386CC
	for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2024 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716230595; cv=none; b=Vj102wC6BmzplgfaB90sBa+tBN3ew2cypxZQ4J1IrhapynOfIj6MHTwTNG79ULuMuTME8rM28XA3tAP2PuzdulQ90NL5psxFsiQ/xkPoCXu0r6TUPL+JM7sgNIaS0mBkkknFi+r5yPNriAndyLGCg7hyMywuXivOZDgEbFjEP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716230595; c=relaxed/simple;
	bh=qu35jXgrloC2HfZ33850jfCB/qIzHkQ39tSRy7Ap9Ng=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=ZVDlmH+/3a5O/DgDqwcvVkQNb7g6k2HsV+k5gcdToefzMrCxvp3O7VZEZ9T6SDihsKikqdbFJ8s/Z77wo0kLYzPe6AJr92lte98cku8o6fpn/sC43dddJ0Ip3uQfov5qjFB7KQRA5vR1vNXQhPhhduZjyGFGmcus15YmiCO+bMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=tkl7o3MC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ed012c1afbso24475825ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2024 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1716230593; x=1716835393; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jnnk2UuZi4E63haeWoiQVkLdG0WBqSyE/dF9D2tShHw=;
        b=tkl7o3MCO92aVF3HqZPkvuV+uPiKpGnKAdmh+Mcx5vCot0TqRJZzqJwtgYx+nFzNdv
         PLPVRecWh6W+Bq7D3CWUhCneiNG37sTKKK3qUaKqdqbGfh28sGdHo0r1UCPwED6+Yx4m
         24bWNBTAd8Y3vpMS7p2Bz2/xLacuItM2IbAWgUsJxuz5BUfP7NziUfMfrr8X2V9zzDkJ
         rjVujhp4VaygyrJ16qWEcpYU59YXhqa+ivfYkSZLNdM/FX6xU8pRfSJN+Y8eLenyiz/k
         T9OzdemVhTLMoAzJQS6Yo1futMqd6iWWrHZyCbtaHGD+K2KV6K3J9lOO9o0sYkk9smOf
         IT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716230593; x=1716835393;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jnnk2UuZi4E63haeWoiQVkLdG0WBqSyE/dF9D2tShHw=;
        b=cwvI2EAMNVYmZd8iwyrAd8LJlOKfVFZy6D2ocWdDsA46cboYHPmsyr68LPOHO07NXY
         g3KssUManZtP70fBz26+tAj/X2XRDXPE9x7mrbojKX1WIWI3XfZyfE3FOTp8FeZv4+cg
         MulgqIL+iOPwcuW3jBhFM6YtoVojjnDZt5I6AvKe4/FqBR62UG1GYqDzmfwgvl3vtbGF
         1UVyVPnQEG/oTtJI+3rhlzXPxLkGZNZCmUq0CPzGzt9dQUoL1O/G1xPVSi0hEhZnsCrV
         GL5VydRIctaBlfWsGTypfFp1tcGUS5C9AWw9cX7fGXjvsMw28hLQ7qrrVctBCoE1JOcZ
         SiRw==
X-Forwarded-Encrypted: i=1; AJvYcCX/idORwVIYUkZVE1JdSHLLtDE7NFJBTGmCNK2yAlaRanR1LJrtgLK9L+tcq9V5CG1iD6E76Dt1LrJWpcRuuWLu+Qf2iKfdy8Kv+qZGJH6a
X-Gm-Message-State: AOJu0YyyjzlqPIEiEML/nxgSp8xajqE4/TtZuUURVTxWNlvcMUKOhhNX
	+5QdWKTMFviqWFLQ1CaMM4vHmcl4IxYbw/S+TLHSuAyEsZN4xp8zbHOeuTKltPP8dm1JY3X1pQA
	x9yGd2Q==
X-Google-Smtp-Source: AGHT+IGIkuVwECDCM6TyN9L64tpP1/FLOoYSxdsHWJz9beqRX2uUpE9YviN2lCuPay74iFyzCRnrtg==
X-Received: by 2002:a17:902:bb97:b0:1eb:e40:3f74 with SMTP id d9443c01a7336-1f2ed3c31a4mr71559435ad.32.1716230592575;
        Mon, 20 May 2024 11:43:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f3046e1b3dsm18195825ad.173.2024.05.20.11.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 11:43:12 -0700 (PDT)
Message-ID: <664b99c0.170a0220.5b7d4.4ec1@mx.google.com>
Date: Mon, 20 May 2024 11:43:12 -0700 (PDT)
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
X-Kernelci-Kernel: linux_kselftest-next-6.10-rc1-fixes
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (linux_kselftest-next-6.10-rc1-fixes)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (linux_kselftest-=
next-6.10-rc1-fixes)

This legacy KernelCI providing this report will shutdown sometime
soon in favor of our new KernelCI infra. Not all tests are being
migrated.
If you are still using this report and want us to prioritize your
usecase in the new system, please let us know at
kernelci@lists.linux.dev

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/linu=
x_kselftest-next-6.10-rc1-fixes/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: linux_kselftest-next-6.10-rc1-fixes
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a97853f25b06f71c23b2d7a59fbd40f3f42d55ac =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/664b8b97ed9b56ded04c42da

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/linux_kselftest=
-next-6.10-rc1-fixes/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/=
kselftest-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/linux_kselftest=
-next-6.10-rc1-fixes/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/=
kselftest-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/664b8b97ed9b56ded04c42dc
        failing since 96 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32=
-g345e8abe4c355)

    2024-05-20T17:42:00.684206  / # =


    2024-05-20T17:42:00.692575  =


    2024-05-20T17:42:05.829340  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/13915161/extract-nfsrootfs-jkxfusmf'

    2024-05-20T17:42:05.840469  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/13915161/extract-nfsrootfs-jkxfusmf'

    2024-05-20T17:42:08.073511  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-20T17:42:08.090583  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-20T17:42:08.195259  / # #

    2024-05-20T17:42:08.202370  #

    2024-05-20T17:42:08.319474  / # export SHELL=3D/bin/bash

    2024-05-20T17:42:08.330051  export SHELL=3D/bin/bash
 =

    ... (48 line(s) more)  =

 =20

