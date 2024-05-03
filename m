Return-Path: <linux-kselftest+bounces-9443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672378BB874
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 01:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9EC1C21216
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 23:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9CF85623;
	Fri,  3 May 2024 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="EP5VbvSo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8056D84DE8
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779967; cv=none; b=aONIU18CqtrJJjLJmrCWDT9jSKpigtI4b0/vyEIxUCZspzIyg4fpLtjbOQ7EEUThO1KswA16kW4apxV5DW5D2gL5jJDHAjxFZ1Omjc3iQ9EdOxX7qWqGqUouuGy4Qg9HSlh67SgWV0EF6tCVJ09H68mb6iFzCDN3zi3w4UMT65Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779967; c=relaxed/simple;
	bh=PcpsIpKn4BO6y1md4bWDwP88xbRD1kCD9yAXUVJ/ymY=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=b0idyri6MFEwfF9Vyo2T0Amc1Gkb67GU2gprHu8ot0puObVKtTCjRwNudNte0QKescVATVVsgiUDdKtexgJXBg0Cn9/60+eZJqk7ovaQ1G8rKxrsCtIHbpckzQtGHoQuLMh/GDIkNEjx1jvE1POiA7bVg5NKpF8/DVcxiWFa6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=EP5VbvSo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ec69e3dbe5so1928335ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 16:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1714779965; x=1715384765; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xFjrd0k70+YxPAGozwqHE5Lb+8lILxzoTzHJxqeIZAg=;
        b=EP5VbvSo7ATcSV5ggBmFvSqYnXSddgLgWJPNcyg/aFH40iJBHglPt3BSqmxyKdoBs1
         lCLcUiBw8JuV/4F4nFVY/aDezjCg+NF90aPwvHnWz+OmlpeqfKC3+7RNu1sBqcAYzXJ4
         PNB2037IlZ0Lp8BxzbChMrFO4vE5nhkM/51l2bSTtGLuKcC5ziFxCCe0jA5knteC/8wI
         qqzdOb1aSxvbwYybFI9OUcR0UGjnGT7129L0AfON9NDt864c6wp9GUAzfd2yT51AbSTr
         naMNw0SiDTCbFRQLv7epql1qgEbeVQIGyD+SDL1N0u61iED5HtOijpSh3ika9CjSXNhI
         jZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714779965; x=1715384765;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFjrd0k70+YxPAGozwqHE5Lb+8lILxzoTzHJxqeIZAg=;
        b=U6nhYY1SUueDJGzsN5l9au/nw3tvi9+Pnyyh6yRv9FTOgp6/GRkJP4ZD79T5MdUMpX
         XCy/QhU66tV8ixgHScGNQHvDZ7pfYVxY9hjqeBnI1Sv/gXMyg15/EVeqWjXkMaG90MgA
         swecz0p8DzohcDGX1f154lsFpePV0W8qom4vTGLhek5QHGn7pu7REL8Viqd3e4VHP/Km
         6XwU0Dy+4nTXCZDqDf1n9EYXE1fIji48XWW0KeTXZYVJFhq9fExqZBRU1xNa+lBb61eO
         VPz8K9ndiSTTPbsXgFyRw5wA9DPQ/jQ8FMqPbBIkjmksB0vC6L0L8R+KMANYomKwG28G
         T6xA==
X-Forwarded-Encrypted: i=1; AJvYcCVTQbZ/7SXj76l37JZ7YHM6au3T6WJQMX8uUtOxA6Eg3t09WG+qxkmbR7ZKY4DVcRMlPoCYdIYuRc/eQhgYupHrJWxif5C3B2L6TeY2unhC
X-Gm-Message-State: AOJu0YzyDa4cZPV+gRJqMO2RRQzCXlH6kYH/Zaq6zfucjeIk0x5k8HYH
	l9mnuka7YrYJSYXeqZOuxqq4HMvb8pfS4rNGZL3aOIXwBZM/+AquXXKlHWqb1f8=
X-Google-Smtp-Source: AGHT+IEJUL3886oG8j25sv5s4Ogf71eOJho8vnD/YLDsof2jpMmCvOrChladNFyy29Pc6esczVibuw==
X-Received: by 2002:a17:902:8f97:b0:1e2:718c:61e with SMTP id z23-20020a1709028f9700b001e2718c061emr3478822plo.27.1714779964645;
        Fri, 03 May 2024 16:46:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090341c300b001e245c5afbfsm3822434ple.155.2024.05.03.16.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 16:46:04 -0700 (PDT)
Message-ID: <6635773c.170a0220.10f67.fca4@mx.google.com>
Date: Fri, 03 May 2024 16:46:04 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc4-36-g70bfefe4252d7
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.9-rc4-36-g70bfefe4252d7)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.9-rc4-36-g70b=
fefe4252d7)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc4-36-g70bfefe4252d7/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc4-36-g70bfefe4252d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      70bfefe4252d7ab57fb49348ca5b66ad9298e46e =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6635687051b08916c84c42da

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc4-36-g70=
bfefe4252d7/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc4-36-g70=
bfefe4252d7/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/6635687051b08916c84c42dc
        failing since 79 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32=
-g345e8abe4c355)

    2024-05-03T22:43:22.173115  / # =


    2024-05-03T22:43:22.183109  =


    2024-05-03T22:43:27.326213  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/13633047/extract-nfsrootfs-c03ooedj'

    2024-05-03T22:43:27.342473  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/13633047/extract-nfsrootfs-c03ooedj'

    2024-05-03T22:43:29.569322  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-03T22:43:29.580248  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-03T22:43:29.697807  / # #

    2024-05-03T22:43:29.705994  #

    2024-05-03T22:43:29.823718  / # export SHELL=3D/bin/bash

    2024-05-03T22:43:29.834056  export SHELL=3D/bin/bash
 =

    ... (94 line(s) more)  =

 =20

