Return-Path: <linux-kselftest+bounces-11077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4CF8D6D50
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 03:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10C11F22FBA
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 01:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAE06FC7;
	Sat,  1 Jun 2024 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="nwOImv+y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDEDA94C
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Jun 2024 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206169; cv=none; b=j9LVJTEv4gp0V2Ht3V7ycSYaR1Vmr+1uFQVv62jTApSMO2ZI672PJYEymji/pdoXm9hyDi9ldtwijuBpsZXs7VNIkEZuvBZOCQnStfJgFDSZAUgm53mUNzVD6QAgEat8nNh85LekgxjUcGNai/L3nzNgf2daM/BJg76CbPkxlW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206169; c=relaxed/simple;
	bh=KUHgtvkasxa79ix5Rr5ornWqaqOXzVB/ID9rflmlDUo=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Fic40l2rREWUnwQPops48ojkC3BaEnOFutBrieZl6mCfQSDwTyG8wkmTU2OVi9I0HyU3uivldlDx4Yr3xxpb+6ZEJ+M+ZciXpWt0tklJqZUC7H9Z/rc6oO/yPVnAm8e3o0OgIVPVJvYkpQTbal647WTLsM70u+PIuVvWrVJi360=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=nwOImv+y; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f480624d04so22752775ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 18:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1717206168; x=1717810968; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HbItqM13nhoN1Zj5q3CUqiYnnCV/Vm3D4c+KfUVSjO0=;
        b=nwOImv+yBRMuD6a53rS3PMUsNZxsYcr0LtlLfpDoeHQ4LhlvWShpb/PnNrrkEOYsLg
         rPgyfByLiJuGEZTSMaroILMPKb7I/xVJE9SLdWKj/X/hIe0eYkg05g6qz7i1h+QarEfD
         DiGSvwZc7orOOy5NoM9La8bgeEUHGaMoneHxJAWHJAYxiHiYlUqwnGSH0eRIEsOGJYmL
         9jxOaD6kDx7EPBTFTBcP2HkWDRhNKdfVdNy7KfZuPAuTz2BcB4vjGT44jkyRFDAE8wYY
         0YjaA0kULwk/RhqwFRDgonXI74TbygLFijKNpS4E3yPJIex3loNM30ANJxJ3HMlb+bVV
         LBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206168; x=1717810968;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbItqM13nhoN1Zj5q3CUqiYnnCV/Vm3D4c+KfUVSjO0=;
        b=WK2izm+qaXKBtRxTjK/o2qYTXtgxbC74XUqOrqNe9JpVeJ5qP2n8b9r1T+Akb0UQxD
         UCglfWOjU0M2m2IBnlYLN7d74A+qQOgU4+bvvy81CT+a/QvHlezetE30sIWJhtTDfbXY
         90YEUE9Zqnw2YOlRcQZuVF7wKOvzC6pnNJQS0yNyWbrqLDm3++nBPe/ikSJMhdKWxjFm
         A0TTSd4vwnJ7q1ST46lGXb9OTUnxpoLng/piutmZnZKWhcoU829Fwttn55h2oEH7y/p+
         OD9a3lTNDVR6dZYRe1awfX3GTT0cAC1YE/9EM1ZQLZWbVrJisRNO5clmeheopU551lmy
         rDpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1vnNs5GSXuBcelaxK57IbJZlDTb0HOXVXkMFT8rykrWiKnv50p7hA+f7XfFvY5OlWqDqD0m7NEeC99nMm/ETn2qwyy72iVP7KY0j0rIUe
X-Gm-Message-State: AOJu0YwAvWYUFMxjW1VA08281LqDVFUjtQsDq6XhRIs3YgJ/DKs3boNg
	oVixATJPGhiDZd2n65QbIDbmp3zHEZn7za2Xcc0UxUvJ87kh32kakgZJ/PNhbOs=
X-Google-Smtp-Source: AGHT+IENpMATzBOUnbTPbNIy7++0XU9twLl35jXFiPMwTWxDpGgBovpJ46yyF+fCQvwvkJJtJLqqnw==
X-Received: by 2002:a17:902:ec87:b0:1f6:33db:2cc1 with SMTP id d9443c01a7336-1f63700df39mr40510105ad.23.1717206167600;
        Fri, 31 May 2024 18:42:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63241f76fsm22750085ad.307.2024.05.31.18.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:42:47 -0700 (PDT)
Message-ID: <665a7c97.170a0220.31ec9c.6dc1@mx.google.com>
Date: Fri, 31 May 2024 18:42:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc1-11-g4bf15b1c657d2
X-Kernelci-Report-Type: test
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
Subject: kselftest/fixes kselftest-livepatch: 2 runs,
 1 regressions (v6.10-rc1-11-g4bf15b1c657d2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-livepatch: 2 runs, 1 regressions (v6.10-rc1-11-g4=
bf15b1c657d2)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
10-rc1-11-g4bf15b1c657d2/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.10-rc1-11-g4bf15b1c657d2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4bf15b1c657d22d1d70173e43264e4606dfe75ff =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/665a6b892d801e28807e706d

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-11-g=
4bf15b1c657d2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselfte=
st-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.10-rc1-11-g=
4bf15b1c657d2/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselfte=
st-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/665a6b892d801e28807e706f
        failing since 59 days (last pass: v6.8-rc1-4-gb54761f6e9773, first =
fail: linux_kselftest-fixes-6.9-rc2)

    2024-06-01T00:39:18.168845  / # =


    2024-06-01T00:39:18.178718  =


    2024-06-01T00:39:23.322490  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/14114904/extract-nfsrootfs-x238udv9'

    2024-06-01T00:39:23.338757  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/14114904/extract-nfsrootfs-x238udv9'

    2024-06-01T00:39:25.565503  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-06-01T00:39:25.576358  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-06-01T00:39:25.695059  / # #

    2024-06-01T00:39:25.703518  #

    2024-06-01T00:39:25.821124  / # export SHELL=3D/bin/bash

    2024-06-01T00:39:25.831491  export SHELL=3D/bin/bash
 =

    ... (86 line(s) more)  =

 =20

