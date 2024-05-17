Return-Path: <linux-kselftest+bounces-10329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652488C80D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 08:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3581F223D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 06:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1891170D;
	Fri, 17 May 2024 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="EAM69rKg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74111CB4
	for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2024 06:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715926540; cv=none; b=baoUJoRU48L5bt2QOMAIxVkNaQOZnIQPfuHml1lI1kU7XKjgH7MK7TQCEJjDpAQtGONYRhqe/0kt7nHVt0Gd9KfGi6z9tEfaj/NmBIxrQOrCF0G+0BpKUeMXUCSW+ZEAN3WR2EFX6geOKilbqFGWzql3P9zOmhsX4XfEZRYffj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715926540; c=relaxed/simple;
	bh=2fwH6PoioSb5zW6/VQFDwzxM33R/xQsdnki2G7rtwww=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=mExJpAFF/oIAUmvVmeOizTRFMPkdpSxsXKV+T1kLQ83Dpo8NBGY1fw9mcyF4RQ28dHSwgeDfnLpSL9rzhxGO7yKaqrC0XnUnqhFHsMRb+gzMNCLyuecEwpW8d1gE0FRrFl//+ixs5vvQVaM5ggRZ8sN2PuXNq+RI05d14QsfBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=EAM69rKg; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f0fd87da53so688120a34.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 23:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1715926538; x=1716531338; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1QYmHac5iBzcwyApK8JMUbOTAInxD3yuRHXaiC1gjz8=;
        b=EAM69rKg9pqaRfk3KSQX7H00HGRxHBlHC8y6+URHVP/TtCVTMPovL7IStZc0whRNLN
         m9VJXJvXwJR2WCZXVTPcMaaO89PCDPMlGbTRcfvCBu9PpQUtqpC1iurTdK0INzJiQbC5
         +2ledmXeuDVHNkt5wU1myfPYmslYitdrq6wBj/7gszyT6Msx/xlj+iA5U46uw9fxBJo8
         wjtwUpotU830I7NCmdzLtkeqn+SXmB4f2Ivrmio8riDtTwpqFPXvg905jLMCaAG5qUnv
         Ox2KFaCPsFJAqi72+H3Zo8T2MfMXq+9h0nIHtjii5krslU/R4Slm/0J/WA9/MSmP08/w
         w1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715926538; x=1716531338;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1QYmHac5iBzcwyApK8JMUbOTAInxD3yuRHXaiC1gjz8=;
        b=lru9BRdOllKxvLFGBp117ZGHMlJb0VVOyJ6C/ZahbYokx8/rl6m2Jtfv/z9csn0C0x
         4/veRcqFPAX3Ss5McuUsYXjNT2FkZaRFYP0VdY/4E8OzJoyzXz6wZyUrvFia/NyF+ZRx
         efnH8QLJoi7pn8BIZ94z+BsykcFQRJh1qqaXMVUwMWivXMZeN2sDeZItC0fUGD3oavdM
         Bu+P0PzahIIgH3wEL9ZOMIF4O5wabqPGWIkCv438cJ8wsMtiaS2FM9maRTnvwq6qxMFA
         7cu4EnNW5tXsjxIAunhQqVk0N4qYCSp1OuKOiA0q6oBlf0QqXB0c49/ikRDouIpFg51k
         bKtA==
X-Forwarded-Encrypted: i=1; AJvYcCVSZaFUIVnDblN4xFAVC41cnHGDYGa8QO8LK9E+iJ12g66EwdRFmK9A4udvd75/fP7YyHD6d1KTDDSlsvch/RwaSC2Yk6VLcptditbPzIQm
X-Gm-Message-State: AOJu0YwN02RFOlysgwUBt4toy85dzqwDspsllrBQN8v112HlcuGqV6VL
	Xhd/UGGaAjdYuGct39Y3Q2G+nozplIXz2yTxx8hx8EJ5kQa9Qmnhd3dMbGURljM=
X-Google-Smtp-Source: AGHT+IH+WG0v6KpnBwCOPGlpkfO9+botTSIru/IwipCDJmJpT5XtMz/3RzJ01Beug6U0Ql68tE06kA==
X-Received: by 2002:a05:6870:d6a5:b0:233:1901:7523 with SMTP id 586e51a60fabf-24172fb5eadmr25234998fac.55.1715926537865;
        Thu, 16 May 2024 23:15:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2462sm14556522b3a.141.2024.05.16.23.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 23:15:37 -0700 (PDT)
Message-ID: <6646f609.050a0220.89e60.6269@mx.google.com>
Date: Thu, 16 May 2024 23:15:37 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-8287-g31a59b76b978
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 2 runs,
 1 regressions (v6.9-8287-g31a59b76b978)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 2 runs, 1 regressions (v6.9-8287-g31a59=
b76b978)

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


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-8287-g31a59b76b978/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-8287-g31a59b76b978
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      31a59b76b9780a9b2d385024e2d6d0d051bb06a5 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6646e7728813c2beb54c4309

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-8287-g31a5=
9b76b978/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-li=
vepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-8287-g31a5=
9b76b978/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-li=
vepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/6646e7728813c2beb54c430b
        failing since 92 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32=
-g345e8abe4c355)

    2024-05-17T05:22:14.386921  / # =


    2024-05-17T05:22:14.396909  =


    2024-05-17T05:22:19.540722  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/13854313/extract-nfsrootfs-h8_h7jqp'

    2024-05-17T05:22:19.557695  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/13854313/extract-nfsrootfs-h8_h7jqp'

    2024-05-17T05:22:21.784837  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-17T05:22:21.795705  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-05-17T05:22:21.913710  / # #

    2024-05-17T05:22:21.923089  #

    2024-05-17T05:22:22.040178  / # export SHELL=3D/bin/bash

    2024-05-17T05:22:22.051641  export SHELL=3D/bin/bash
 =

    ... (83 line(s) more)  =

 =20

