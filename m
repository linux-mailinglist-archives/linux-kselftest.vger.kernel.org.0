Return-Path: <linux-kselftest+bounces-7033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B808961C0
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 03:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4A2286DE7
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 01:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD62DDC9;
	Wed,  3 Apr 2024 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="RP2VELNW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D0134B2
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712106442; cv=none; b=A/tTmZGZ/MO4n2/Uv4DeMR5q+de1mPLMHxBa8SBvxUfYTia2wmMeNkGouNCnQ2roZ3fvJg2l55FBd0eBz2lQlNhdLzLIJ5ELszIZKpqLxzxnCN8EGUlWpZRlwLDosbWGrW2C3GQYtA3DH1JGmfXlz2/ExWg7zHS3j+XmS5wRVL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712106442; c=relaxed/simple;
	bh=zODTvQdaF6tU5CpSDasbsIIWNLg9RI5yW/ya7DNzewE=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=XIX0zqz9Rp3FJAlw7HVjo9/vbsOrbrryRZjEDXW/3bubvWyGpLu9zqf7vCkwpnERSIWV1jNyEhyQqQlJHkldljiiF/tPYuYtesYET2SaotL2qv1FnLpv4h45akDiUOdnhIRdyngFr+ngLuzAlb/kL9MHGZgiAq/BkaOExjGLSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=RP2VELNW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29e0a1fd9a7so3747688a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Apr 2024 18:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712106440; x=1712711240; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4EvXcar2GbZqj+rBOfAcZLPenYPgCCAfKHMwVPuMQlM=;
        b=RP2VELNWy6gHfkvQimg+bq79LfWUMbkvRLEFLshbgQDg8RWf2uYeT/ZmVdq1M+aFv4
         PRNuL4nFnV5cpVeAwCfm+d6uWgq4MsBKNT96VPSDARPXfusBawP6w4Cn15bHzkHiPUXL
         mW2fR3RIXk1dT9MTKiRoib580B3nz23Dclc2lwOn57lC4/ua8OeVUah+S8DeV8RZQ0pP
         SuiR2PIc+9QR7/Ys3/HSato3bYtAcsc3n3UeW+6M9WfwfwsUTgwBV36tndwC6IbbA0be
         ieqlKXjaOMfh7gZs1yQwjsp9PxBxDASk4Meo1i3T6+b+mWtupFqlbnfq9MdNZ1F04066
         73LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712106440; x=1712711240;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EvXcar2GbZqj+rBOfAcZLPenYPgCCAfKHMwVPuMQlM=;
        b=Afl+TXhfJ+9viPnRvwCKdWuod3ZUG5E7AH09r9S0iaZMmFPb0fyPOWOFS5nJtvNtMZ
         S4kdsf2rSoAHC/xU2mgRerxT3b44CFSYj6O3NSyFCllneefagPLZxYrcVBRmcGQ0lVHA
         HA3tg44Wr9PYFSYMYBHH1tVrzPl5YlN5f8iuMhUAzYovVT8U85sE1AiBqh8eU2hfwxIU
         vKPzau8W9zV8m0bt3QunkKWqo/K5Z3LTuytL/i5zcoUt00RKG6tnKXYGFCqKOkJM2mqx
         3mRUN9aqJGBvy5PS/3JW/to2ASJasA2x+URkekcf9cq+iNA+RPj+73QbEdkPo2hsZmYj
         sq0g==
X-Forwarded-Encrypted: i=1; AJvYcCUUeAHGFgE/JPsgF5SIL73eP2DYiXDvrtssv0iN/EEP+4Q+5/ybCJma8BiCoDFwMHqZ5ZeM5PtO0CZQ1EbO/0c5hcqQXLLC9dtUIPiP23iX
X-Gm-Message-State: AOJu0YzThbJuh5uv6KKnCWtobdPont8JkRuz/FJaIAnSw14MtrUUllfc
	U6GI3y5xcODFbfD6d6fAmqVfD+3VL0zQtqMQKmUHLczF47IitbSznz9bOrNOzsQwgszfGOPmPVs
	S
X-Google-Smtp-Source: AGHT+IFvtcHAwSwSwBVz291qHG5gXOUSERwkSfC9m9tjXgpR1cYmvy30lyhH/Dcb+u7e3EqrAJJpJg==
X-Received: by 2002:a17:90b:3e83:b0:2a0:765d:183d with SMTP id rj3-20020a17090b3e8300b002a0765d183dmr1382889pjb.18.1712106440424;
        Tue, 02 Apr 2024 18:07:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f32-20020a635120000000b005dc4fc80b21sm10433978pgb.70.2024.04.02.18.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 18:07:19 -0700 (PDT)
Message-ID: <660cabc7.630a0220.e9fbd.cf89@mx.google.com>
Date: Tue, 02 Apr 2024 18:07:19 -0700 (PDT)
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
X-Kernelci-Kernel: linux_kselftest-fixes-6.9-rc2
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-livepatch: 1 runs,
 1 regressions (linux_kselftest-fixes-6.9-rc2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-livepatch: 1 runs, 1 regressions (linux_kselftest=
-fixes-6.9-rc2)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/lin=
ux_kselftest-fixes-6.9-rc2/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: linux_kselftest-fixes-6.9-rc2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      224fe424c356cb5c8f451eca4127f32099a6f764 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/660c9d6bcd8b3644e54c42e3

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.9-rc2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kself=
test-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/linux_kselftes=
t-fixes-6.9-rc2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kself=
test-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/660c9d6bcd8b3644e54c42e5
        new failure (last pass: v6.8-rc1-4-gb54761f6e9773)

    2024-04-03T00:12:20.432938  / # =


    2024-04-03T00:12:20.442618  =


    2024-04-03T00:12:25.587416  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/13232321/extract-nfsrootfs-wi2n58cp'

    2024-04-03T00:12:25.602875  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/13232321/extract-nfsrootfs-wi2n58cp'

    2024-04-03T00:12:27.830234  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-03T00:12:27.841188  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-03T00:12:27.959289  / # #

    2024-04-03T00:12:27.967780  #

    2024-04-03T00:12:28.085294  / # export SHELL=3D/bin/bash

    2024-04-03T00:12:28.095623  export SHELL=3D/bin/bash
 =

    ... (108 line(s) more)  =

 =20

