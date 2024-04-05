Return-Path: <linux-kselftest+bounces-7320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A4389A62D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 23:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5E428369F
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 21:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA57175566;
	Fri,  5 Apr 2024 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="b6OOXa+0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4B175558
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353281; cv=none; b=ZIZxfWSE4XxAEsqGGd5AhRlI0TUl7KkECeMAZTyrLWexM9P33cSn9NO3wwpoZvCADu7y+cJV4A3ebqkqF/tjm7YJmEACEL/6yV8Gf81hm3gQe53A3x9r5I1TPA1VWsC54jPnZWgijpoT/mpp2WLDvTGZZlRvPCpRRIhFbrkhDk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353281; c=relaxed/simple;
	bh=rl5xnOys83rr+ei0o3jHxEZmS0eaUloIFd4x4DOtJRQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=uC507xrVd4+d1n4pleVWkoBfH4JtNTtg0sdpoucDGhP23Ns0Ou5qDfk1LFw7HjGYAawtRFLUae7jTyGKi3v2PlxYiY5Usis9OYRPo4j/9uJSCp2swVTkLSUaunS5n3bFquUOuUu5L86IthzNX6yI2tpV0AeVEQREN9dTNsZTd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=b6OOXa+0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6b22af648so2754344b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 14:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712353279; x=1712958079; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aatm/NugAKtwnB7hu4NggdU/PQGJujX2QzuS4+yZrEg=;
        b=b6OOXa+0X3SIqrWq88BFu7vy6fglQgJDOwLfNe9ManuxPygWfDtyD9hka4fDQF00P/
         eSXAWFX8tCwFfJy9XZ5VeGxTzj/SJ+qypA1IJWuu3qX6KwmhwjRlnEOumD1bJVPAubCg
         HMgJb6bPlIILFT6Y8NkRgIB9yRDSKuDGjtQdpeAhFophLi+i4LxH9sWhcoHpW3oqzq01
         JrLSijV6AO8OkxXml/FK6u0hKI0G3o5yry1pYNrgFsIl2WXxCXxoBU7dUKwh23volGzT
         ed5minFzVY6lUA3GeY5/57amO4cycbLGur26waqjK4p535tkCv117zd8WucrRJ0Z/z6m
         WQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353279; x=1712958079;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aatm/NugAKtwnB7hu4NggdU/PQGJujX2QzuS4+yZrEg=;
        b=BOPNCxbwi6kYlxZjA86dmv1ISfV8Fng+MeMgXNzUHgyMs6hnbML8F8RiP+mLO3pT/z
         0hmeSX8+YsvN6/wNcKwgj3B4nBKB0SH61jJ7LETQ1epDcqFP8gtGlTTK50oITLtM8paV
         IrXoVWLwtrmZq2/Gl266/PPSw63lYjDcCPDyAMXgnB12q2Aejv4GsEgjiy3J8tOq6T+v
         c7mhEvwFW2ul72rXVBIVh42PkfBF7UmG0IUyAAiePZQSQWeCZGI/xGBwh9UqOhNfKHEn
         yRFDuLzbG10eqPTVpqImGjcxa4HDCRtwFuPjHt6I22JxHDACsrFOQ06a+jrZ6KBbSTXg
         C4wA==
X-Forwarded-Encrypted: i=1; AJvYcCWXSgWLOaqwEhiYC+d8RegooVA+xD88z+MKVxzh5BoUZmL3Glrj0XKJQ0hosoh+GqYszQOa3dHgtK/VrIN+EHG7Pgl1SjhMMp+t6ZxzDs9L
X-Gm-Message-State: AOJu0YxGrk2gR4VgDzfGUNjUE62ycwVJP795zl+7yovc0QVnNaj4L9p6
	+0miu/x44ga0MIX7MQTzdkRNktwyLIdlh1sRufq/fJjSnYfSim9MCBLvtvibgyM=
X-Google-Smtp-Source: AGHT+IGNHcRl7Ny0kL74eoOI5fiHtqHRczaBaVLNj/CHmmALhmvWQvwv4H+zEK/i6p00zxctUK/2gg==
X-Received: by 2002:a05:6a21:7888:b0:1a3:a821:f297 with SMTP id bf8-20020a056a21788800b001a3a821f297mr3647397pzc.2.1712353279048;
        Fri, 05 Apr 2024 14:41:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m18-20020a62f212000000b006ed01ccc2c4sm1645162pfh.90.2024.04.05.14.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:41:18 -0700 (PDT)
Message-ID: <66106ffe.620a0220.be037.51b9@mx.google.com>
Date: Fri, 05 Apr 2024 14:41:18 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc2-16-g3f4d0fa96430
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.9-rc2-16-g3f4d0fa96430)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.9-rc2-16-g3f4=
d0fa96430)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc2-16-g3f4d0fa96430/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc2-16-g3f4d0fa96430
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      3f4d0fa96430b23553fc9c8c36c2ff9cdb8e9667 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/661061264ac6a50eda4c42db

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc2-16-g3f=
4d0fa96430/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc2-16-g3f=
4d0fa96430/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/661061264ac6a50eda4c42dd
        failing since 51 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32=
-g345e8abe4c355)

    2024-04-05T20:37:24.326440  / # =


    2024-04-05T20:37:24.334348  =


    2024-04-05T20:37:29.472774  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/13272493/extract-nfsrootfs-u7p7h549'

    2024-04-05T20:37:29.483723  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/13272493/extract-nfsrootfs-u7p7h549'

    2024-04-05T20:37:31.721722  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-05T20:37:31.736181  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-05T20:37:31.840467  / # #

    2024-04-05T20:37:31.847605  #

    2024-04-05T20:37:31.965298  / # export SHELL=3D/bin/bash

    2024-04-05T20:37:31.975400  export SHELL=3D/bin/bash
 =

    ... (47 line(s) more)  =

 =20

