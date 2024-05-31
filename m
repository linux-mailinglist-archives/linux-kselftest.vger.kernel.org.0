Return-Path: <linux-kselftest+bounces-11030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F078D67FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 19:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84E31C25DB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A525B176AA4;
	Fri, 31 May 2024 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="3eY9F1Li"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3F156242
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175796; cv=none; b=LqXVChSGs0UWb7H7zrUdj/XfXms8hrr3sy8KLuVFtyN5mBxmrTeBJ7yECsK6KEaE60HeoC3CJN3fh/i9ZLzA8ds+S3avZf5vG5MabLgRlnDvtj8oLPzTvXM2QkaG7eHFyWADwVIAOFtdeJwtsmZavkqHgB8r6Nyk9t6BH/ZKFnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175796; c=relaxed/simple;
	bh=7yW3olQCIN+nHXN9a97vOJq0fHbhENXz471EHbIjWt0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=lLLJYE0ejgygDdwGzWQaOHno9rMCx6tEspsHkRBvdjf3b1zursmMGJ5vK2z7wmsKw2IshrN3cFfYgaYmXBt2DGPq9z/zQjb9UqhzlP9OJpjCI1UAOSDuhEA+4TL2FCvxREyKyRVT7NdZewfneyooT46qNmpP0a4mcMjpyiKKgk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=3eY9F1Li; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f480624d10so18901305ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717175794; x=1717780594; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9MrwJ5x8spmkzVrVZr0BNH6mTCrPOBGo8xNMOf+MH38=;
        b=3eY9F1LiZzrXzgHzMMU+IzUUlh3JNpDTfd/EHfcKBNTx2QCbaxV3r5MReBWYB8+uol
         90g3AgTySr4P1r75PqqmWKv5uAXUDH3Uv8/16wPO7IhzOH3srjIw+0ifMBjPeshvQqM/
         EW/x+N/mm/Ln8jG7PlaBp1Y9Yx2AhDj5phS3EaZdXMZBofLbcU31lIveELBZyvS5hoT1
         2puVH5d4rdE94vs0jy2cJb49i5mGbSdU4Eij7kDSbuaR9/+/Spylo4Fox0QiVF7b/NMF
         s2bt/JHibzgu0aHnoDlXyfKJkg30dQ+U3Buj5lfE2zjrX4onPPJzhnEzmcoZGNeHia+X
         EIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717175794; x=1717780594;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MrwJ5x8spmkzVrVZr0BNH6mTCrPOBGo8xNMOf+MH38=;
        b=pRpoQUOC3MDogp3Xvq4adtHSFVWbgmTL0lao3djMQgI6zkMD/12uZsaLhRFfw5XAVd
         UA9GCFJAZf1GV8+6sTS2m1jS5I9UaKw+9AUtYGXJB80XJuyNAL5a1rtGdY1pOWH+GfQk
         mJW8iDLnPQAl2KNE2Kw4hzfQPmM2dDg+XKYU/D8v4QSAW9SYim/4k21Se7Me9loODndI
         +XBBEIklbFwSETyutygGBFPhyCNG/HsJMwpvy/YbkLSXHo3vAKJZmEa/lIogmcFyXhHd
         MH1/47YU2aLWtREbJZAJnUPrzDtDYxH3CadbubUqLbxgWtUCHFK8prV7FXkeHL0d61ZG
         6zlA==
X-Forwarded-Encrypted: i=1; AJvYcCXCot7W2MKg1nuLBNyicE3iyLNw209uqgcsYfQFi85KJpmaLhp+4qTLUkKckG+J//2vPy6g7wX1MRqvQ5iEYQQk7+O8hVG76Ra84H9ZKrcm
X-Gm-Message-State: AOJu0YyRLF71K6JzwHoFuJ6RFu740v5+r7L8w+bAv96JlTIKXenwL1VB
	NUqN9yjuWNGMKFzav0lXwVDbU308vx6WAPXn97xFrJou4JZvDFcCd3zHevMT3zQ=
X-Google-Smtp-Source: AGHT+IHasi0W5Xnym4Io1+IZNU3hcK5/Bb0w01iPNeLhEueaE7HtWo0MfcUDnGydKnwxh2H046GhQA==
X-Received: by 2002:a17:902:ea02:b0:1f4:75bf:5b83 with SMTP id d9443c01a7336-1f6370ceadcmr32403585ad.45.1717175794335;
        Fri, 31 May 2024 10:16:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232dd4fsm18792715ad.45.2024.05.31.10.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 10:16:34 -0700 (PDT)
Message-ID: <665a05f2.170a0220.136cfb.5179@mx.google.com>
Date: Fri, 31 May 2024 10:16:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-9-g0f42bdf59b4e4
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-livepatch: 2 runs,
 1 regressions (v6.10-rc1-9-g0f42bdf59b4e4)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-livepatch: 2 runs, 1 regressions (v6.10-rc1-9-g0f=
42bdf59b4e4)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
10-rc1-9-g0f42bdf59b4e4/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.10-rc1-9-g0f42bdf59b4e4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      0f42bdf59b4e428485aa922bef871bfa6cc505e0 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6659f48a0dab1a7ca37e7076

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-9-g0=
f42bdf59b4e4/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftes=
t-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-9-g0=
f42bdf59b4e4/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftes=
t-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/6659f48a0dab1a7ca37e7078
        failing since 58 days (last pass: v6.8-rc1-4-gb54761f6e9773, first =
fail: linux_kselftest-fixes-6.9-rc2)

    2024-05-31T16:11:40.647832  / # =


    2024-05-31T16:11:40.657216  =


    2024-05-31T16:11:45.800624  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/14111144/extract-nfsrootfs-yli_sz22'

    2024-05-31T16:11:45.816678  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/14111144/extract-nfsrootfs-yli_sz22'

    2024-05-31T16:11:48.041221  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-31T16:11:48.052379  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-31T16:11:48.171766  / # #

    2024-05-31T16:11:48.180312  #

    2024-05-31T16:11:48.297878  / # export SHELL=3D/bin/bash

    2024-05-31T16:11:48.308150  export SHELL=3D/bin/bash
 =

    ... (76 line(s) more)  =

 =20

