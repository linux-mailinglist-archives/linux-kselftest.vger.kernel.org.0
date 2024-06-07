Return-Path: <linux-kselftest+bounces-11436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E92F900CC3
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 22:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E181F22387
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 20:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784EE6E61B;
	Fri,  7 Jun 2024 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="O/qzI8x4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D3419D89B
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Jun 2024 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791324; cv=none; b=anzjXyikYp4xU7sDyJ/Sj5KDIc2bBBaIugZgVqwsGUWPV9+jwJzklyaYNtUWj/2lJywztBK/FZI5uEx+Eg2g20aFF50ihIQogxCIYW5LEAWeXWouSGUpbjGKqA4hnHtf3dxocmLagfhGeVCMcI2v0ro91hJTZ/lw2K/sMOwgjO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791324; c=relaxed/simple;
	bh=p+tPt6dAArzFe9j90I0I8XCTI1/mvsk6LNwgggNU4IE=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=hF0g7uJhlqkXGxiEWBHBKfdeiUXTsu/4sCFTrT1HNqWOSAmWeFAzerXM0R4nq7MC51SJ3zs0ah4kGHbcR58MQOaB86R2JH5Y4LEQcnUz/n8ko6zjM1XGwvRaij1icHA42oVcspC1+cw3qfuwfy6/JhYOnBNB8LYsG5NXU05bIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=O/qzI8x4; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6e41550ae5bso605026a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2024 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717791322; x=1718396122; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UK3XRa0aAhjtgA+4Ay+fgMemqvk5vcbw+5ZtMZdJwwc=;
        b=O/qzI8x4wIfBA1YAsU2BBhVNVeKhJS0yHbvQb/Rvji30Kkcg9svJh0zTIBqa9kIp3v
         ECRpR1GwE3Ku6OGLUiYFD8y7iE1tL2c3IodWLVEKXRqovs4lcj/JXduNNEuJgCOj+tOR
         oW8HyFFdM0MjwXoxg5G4UmMkeWFP149gUSTqSkse84jWN1w73qzDS3vC1kWZ2Ry1DwPc
         d/PBpOwaXWjunJgt5y+WU8pBwAPiML+Q2Cgv2/CEvB/PWoV9v9Ml84YhydfjQcxi7S5i
         DyYkB9TR6n/jPDjFmd8cp15XloOtdo0I+40Rxf0mL9adBYQFsi5uG8SYZrkgIDavZu+a
         P9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717791322; x=1718396122;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UK3XRa0aAhjtgA+4Ay+fgMemqvk5vcbw+5ZtMZdJwwc=;
        b=YiVMfNJiquwVJ8JjMmeYp9fWJXma/+5ZAz7a2x7jAhUOWuJWykx8exfE0ZFREFfTIw
         OxipgNANfqbd07qaYWNQhWhnfFG2F742RyX5cOYOcAzZl1PwgcXOKbQCn0wFVZhIGPjP
         hvOuai17VbA9YwVULnwTFnOGzg5ZCCU/igyXnAbJnVzCbDeCf23Sfb6QbauQRO9rYXrS
         VUy7gu1LizPiFbfDnQAISeFq1WTw48vKb/tnlOE1ZWFkOw6c/WOoWgRVr1mKkr7fNJkx
         FcVwy6QqJkwgj+g9iyi2nuM0CDS7d5eOoCS4qYURjfRAOxNmOSS8WaBp1ZlA0WseBtoL
         ROLA==
X-Forwarded-Encrypted: i=1; AJvYcCVXDYbxkRFmqEttOc5+X+xZ+5bO2mAU5o9kJauk8WsEKZ3aj3XRs7n7Om44VgtzdgbjNTJk0/VzwKUOQO8F+xVfXM6tkDGF/lC8AQUOMEJE
X-Gm-Message-State: AOJu0YzBXVOJ8MR1lHCGneFT/LumJ6yAkaAF1kH3tLKLqYqCkSBQY/gE
	qhuxSVF9eXnBClr2yJVQ/WUxwt69Po3yCwSQ3bijHSWDwKahknZj0jbFiWWg5EBIR5xCtswUMGP
	K
X-Google-Smtp-Source: AGHT+IFcikD/S7fUELVAgsFuLkQ2gi2BPBFsw/dtfuyye9i69WQ6J5FdUd/rez0kyZWwtGU0QM1aMw==
X-Received: by 2002:a17:902:a38d:b0:1f4:71ef:98f8 with SMTP id d9443c01a7336-1f6dfc42669mr16507275ad.16.1717791322088;
        Fri, 07 Jun 2024 13:15:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd80f6b4sm38308665ad.279.2024.06.07.13.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 13:15:21 -0700 (PDT)
Message-ID: <66636a59.170a0220.236846.b127@mx.google.com>
Date: Fri, 07 Jun 2024 13:15:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-1-ga567885b1ecc9
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.10-rc1-1-ga567885b1ecc9)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.10-rc1-1-ga56=
7885b1ecc9)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc1-1-ga567885b1ecc9/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc1-1-ga567885b1ecc9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      a567885b1ecc9ce739d128c9f2e5ef6369dfa59f =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6663593081d789a9147e706d

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc1-1-ga5=
67885b1ecc9/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc1-1-ga5=
67885b1ecc9/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/6663593081d789a9147e706f
        failing since 114 days (last pass: v6.8-rc1, first fail: v6.8-rc1-3=
2-g345e8abe4c355)

    2024-06-07T19:01:34.236592  / # =


    2024-06-07T19:01:34.246478  =


    2024-06-07T19:01:39.388006  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/14231762/extract-nfsrootfs-l_zdvy_4'

    2024-06-07T19:01:39.403610  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/14231762/extract-nfsrootfs-l_zdvy_4'

    2024-06-07T19:01:41.629437  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-06-07T19:01:41.640271  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-06-07T19:01:41.758009  / # #

    2024-06-07T19:01:41.766397  #

    2024-06-07T19:01:41.883893  / # export SHELL=3D/bin/bash

    2024-06-07T19:01:41.894084  export SHELL=3D/bin/bash
 =

    ... (87 line(s) more)  =

 =20

