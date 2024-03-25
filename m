Return-Path: <linux-kselftest+bounces-6595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142388B61F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 01:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 575D6BA4B21
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 22:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ABD71732;
	Mon, 25 Mar 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="06tOrFV+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA86FE2D
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404445; cv=none; b=eFHGX3/wskRylAZocK4RBQwcZtPqKE/8S7lxcMxAgTGTxnj2uLHvWbZ2ALbTQ6hlpk7XfPkSGie+HHU6R903JdQxXFQiWP3C/5sW8Uzu25sEDm4PuuXgx0BRf1I06envYZuGldpwFO6cZ4g85Mr4x0lNIqo9dkxgomZRG9zn5ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404445; c=relaxed/simple;
	bh=yhBpHgBKZTV69igZfIDF76Nbgw2JK6v2liB0rplu1NY=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=jwnwUn/3ASUHfLwIbggz5PXFPNWPg8h4Lue95KQlHNtl99LipB3cKlu3yZXvC1qX8pQzd5DOE2SIG1I9hlsx0BjlUzsn9138M07aVCulVI+JZqQYrtk4/qiKoUi921r4acfI7bRhdnduJ7O5wrmNqTlfsgXjJCaOtORX6up4xVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=06tOrFV+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1deffa23bb9so36255085ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1711404443; x=1712009243; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ipVR1KRiWBFmDUhw/XD/1y6AYs+sAaJOhL1auCqhXOQ=;
        b=06tOrFV+a7CvK6RLmvenD+IOrELQqcdrpTenWvztMHTdkctJEuZDrGBXPKVmfzB0hK
         RJ91np1logx+ZJB0cely4JHwYRXdxD+9JUBplXh9ychppeqkjzklurpgJhMW9+tM6wNi
         Qhu9hpunDqzPf6mDWEBEQBBtI4V6TEHfkyV3tiiI27zKiVOQKIvEolBNNxdVmatgt87X
         Mk6MZyB8v0XhLihbpJTcHd6cZcarectG+HS9fy6hVsCD+5YrFbmbEbfLYkgdYPTla/YX
         hR2aw1qqFUZqvDp5ESnKe/2I82zp1U6Nhvw9zEk/HFBS3YIBwRFsjrweqaSeJncC1h7E
         MuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711404443; x=1712009243;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipVR1KRiWBFmDUhw/XD/1y6AYs+sAaJOhL1auCqhXOQ=;
        b=wqDu2ABzohnJEzCuERgUqevy4lwb91ZotMAyFvdLpBSYJMhZzL4o7cxbQCJsU8iiOX
         o8n92M7G13M+nweJSJ3wC0NHScXFhK817Z4VNYXnyO+HLl/kEiA9+yRQ/llrL81+REhu
         /eAFvLMuoh5xctuVJUc0/c1KdXpA+8bPXSfUEiVJQ5TJNIo1tWkqGAE1jwcDfCOcbNL7
         JT4p6wJYJsoO4c1DXr1dxdAT1J1OlFD42XG/vw9Da0jOLmjFPyq5j7Zj0Qp+DjslsxO0
         YKAqhrl7PLUIakfVBIEgeT1WOuicw4iiEm/sTydVs+ckVlyHwAbdtfYwTEElb6zvtfdd
         igcw==
X-Forwarded-Encrypted: i=1; AJvYcCUedb6OSXiLpcFMhkjnVRvg8gPBhbfCycW/5TDWGT96W6D0J4sGw55Rp/is8pJMU0GJkDRuFIaTJlULSJK1+BNpJLBLdpBBr+DOAt80qjoK
X-Gm-Message-State: AOJu0YzILM086eDKosV5moyfhaxyD/uxvGzqypcEb4ZMOIzedQFHqBkf
	WNX1POcVNRf+qEsrapmX8t33nbvHaqSFx/7xNRxKtOcqWgwwSOsJa3FsdE8k0ys=
X-Google-Smtp-Source: AGHT+IE7L7hZl61g+HC7ZMaZvPvjCoZdFQnwqxeA5Z9SCClxRvkoABtoBM5qvZsmlCb3uzpPMG0DEQ==
X-Received: by 2002:a17:902:ced1:b0:1e0:ccfd:5a19 with SMTP id d17-20020a170902ced100b001e0ccfd5a19mr2583824plg.65.1711404442705;
        Mon, 25 Mar 2024 15:07:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001e0b60e26f5sm713053ple.62.2024.03.25.15.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:07:22 -0700 (PDT)
Message-ID: <6601f59a.170a0220.b697d.3536@mx.google.com>
Date: Mon, 25 Mar 2024 15:07:22 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc1
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.9-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.9-rc1)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc1/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4cece764965020c22cff7665b18a012006359095 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6601e848a8019ca84c4c42f3

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc1/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-s=
abrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc1/arm/mu=
lti_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-livepatch-imx6q-s=
abrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/6601e848a8019ca84c4c42f5
        failing since 40 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32=
-g345e8abe4c355)

    2024-03-25T21:09:47.461187  / # =


    2024-03-25T21:09:47.468676  =


    2024-03-25T21:09:52.618374  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/13155765/extract-nfsrootfs-pb3wx4b6'

    2024-03-25T21:09:52.629686  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/13155765/extract-nfsrootfs-pb3wx4b6'

    2024-03-25T21:09:54.875019  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-03-25T21:09:54.886126  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-03-25T21:09:55.002910  / # #

    2024-03-25T21:09:55.010388  #

    2024-03-25T21:09:55.128275  / # export SHELL=3D/bin/bash

    2024-03-25T21:09:55.137967  export SHELL=3D/bin/bash
 =

    ... (48 line(s) more)  =

 =20

