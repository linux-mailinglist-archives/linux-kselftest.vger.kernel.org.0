Return-Path: <linux-kselftest+bounces-10802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ABB8D26EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 23:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0F01C25F0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC1117B413;
	Tue, 28 May 2024 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gWaHTzno"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B651804F
	for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930847; cv=none; b=vDSQoIDv6ohhGtmhr2n5YomR/nrXrWn0wGnoyGiENiy1+Z+0il9WaaucFgn937dhMQ/4g/bGNNw2JJvnNt1RRDsvwhtF+McUHKxiOD2sYX/0aTniOpt9GeN3JIwiReNfPBGUnqvopDFabBPhJDqGdzHQhrCJGmXUv0mlpuqh3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930847; c=relaxed/simple;
	bh=PMyFKUPDZgr8phBuIdg46O+zw4ZTmqxMb29+0TiT0Ms=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=SBKtI8OJR9l2xxxJmsmX6hC4rrH+mb3oPqZeGg4ft5x4M5/N1f4ObXLTMv8Ouv0DTGRpokuttLci3oNao4FdB+y9o4jX8Ck7o1Ox5sbIcVE4exjiKggidxeSjmZNjCNyWgardaJTY/2vpRCYnb9IZCtWv7Lm7UShgw7sQdbF3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=gWaHTzno; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f48e9414e9so2377335ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1716930845; x=1717535645; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RO5GVTb/9M7Oyen0iW5rECqdae9NqdpuHUQgov9dVCA=;
        b=gWaHTzno+ybnBSsPQRXxcpu6QGWxGvQvlzJiVRQ4+jyZr0x/pGpxMeCyqdRkwhM8Ft
         PWzuS5FwwdFnq6g+EK2MptmJBht/tuAl0i/kX3zIze5Jwi2GumRnziL+SoefdQtyVwTN
         X9+BkRV6+fKtrLwPmSHXhEwypo1oNFJMbvi622hM0TRSiNDjVTmpMDVUhV/qRnXiHInH
         czmptpc832wht5ltRLtoIvXi932JX28wIzRwNzHVTOG8Cdj4wlNwZtmvMMZ+DTXoVNLg
         Alt4qw/JxEPLLYxLp8BKuxZbaHUAG3vpuqWhJxdSQYqkkO4BdN8nttlkSM3IZenh7wJv
         rCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716930845; x=1717535645;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RO5GVTb/9M7Oyen0iW5rECqdae9NqdpuHUQgov9dVCA=;
        b=kTD9g2nGj2xT7c22T9GzjCCxNh45ZwsEoX3PwCyDA2RUB5V+bDNdjiR62A0OFyXdfM
         SloEOR0/eFf/9GbslR7/4hVCk1x3yQ507an1FvT0E7H2hixZbIdlY2OSrt+COQQHDPi7
         MVMkuuhQAu5wgPWv3dfCO/cYHDypdmi9XWu8lZEB+nySrZpaYLBO+Zi0AIvWe879WwIB
         KBdunCVmVU9Qr6C/CHjQ0uJjpxxYxkSRBC4GK//IOazcDw5HepQME1KJMHgEpnynxSLL
         1m+GQvcTCd/Y8VWqwX7BdcfRnVIT3g4DAEJLGGqhhzy1NwmAWxVBF9xY8tuqIZ7Kceq4
         Ymeg==
X-Forwarded-Encrypted: i=1; AJvYcCVAR926Iki+HpVPW1+/DY6jKr9vXxL1+vcrbtD2rYVKoa58swPTBEYHeQBXm4cMC0PanfHDEOcTfIlfkljG8LZzTtTZrmTvdhxaJlvJyo7k
X-Gm-Message-State: AOJu0Yzttx86KTFb70lfaH0hsITQnGGE7GbkgAnhW2XW61x8Sxohd9TE
	fcck62udL6cGvYBLspoim4vRlnnpy2WNE70/zEffBFP7kv70DhjQeTAPEVFYxNL2MVXWYYHE+A8
	j
X-Google-Smtp-Source: AGHT+IEIXcXalOAfRiwV6TtUKvM4MkxrJyb6LSa5QqDmtBFjMPYZK0pmzfq9kJivh13LLC4uqxecIg==
X-Received: by 2002:a17:903:41c4:b0:1f2:fcc0:66f with SMTP id d9443c01a7336-1f4eab33b64mr3715715ad.31.1716930844611;
        Tue, 28 May 2024 14:14:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f48a2a7641sm50985185ad.227.2024.05.28.14.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 14:14:04 -0700 (PDT)
Message-ID: <6656491c.170a0220.bf6ad.cddc@mx.google.com>
Date: Tue, 28 May 2024 14:14:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-livepatch: 2 runs, 1 regressions (v6.10-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-livepatch: 2 runs, 1 regressions (v6.10-rc1)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
10-rc1/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.10-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6656373c0e8b802e4c7e7156

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.10-rc1/arm/=
multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q=
-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.10-rc1/arm/=
multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q=
-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/6656373c0e8b802e4c7e7158
        failing since 55 days (last pass: v6.8-rc1-4-gb54761f6e9773, first =
fail: linux_kselftest-fixes-6.9-rc2)

    2024-05-28T19:57:17.966963  / # =


    2024-05-28T19:57:17.977278  =


    2024-05-28T19:57:23.148172  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/14069508/extract-nfsrootfs-5hb0cuex'

    2024-05-28T19:57:23.158759  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/14069508/extract-nfsrootfs-5hb0cuex'

    2024-05-28T19:57:25.390882  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-28T19:57:25.403449  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-28T19:57:25.507163  / # #

    2024-05-28T19:57:25.515287  #

    2024-05-28T19:57:25.632578  / # export SHELL=3D/bin/bash

    2024-05-28T19:57:25.643013  export SHELL=3D/bin/bash
 =

    ... (83 line(s) more)  =

 =20

