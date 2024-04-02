Return-Path: <linux-kselftest+bounces-7008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC21D895F88
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 00:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6181A2827F6
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 22:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84CE15E80B;
	Tue,  2 Apr 2024 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="krdVDKVQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF215E7F9
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Apr 2024 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712096129; cv=none; b=WaRgaCF+3lMQ95EuCvr5iazTVIraCjVG2cWUfINFz5b2eHBJY/ZJOgKQDHBzoLovBK1umy/PNCmI7Jojfi++fBqcEZ2DZxpHIpvr0QiqcxjT08HwweCXQhkmDHoFfoLkpZhMxBbBEnTFp+cbcOFgp7kCnrUUXiMSD3fvEqVqLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712096129; c=relaxed/simple;
	bh=1J4EuNcO/swNXB8cRuA42Uam7QPQ1stdbiUKk/oDTnk=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=LjCVkQm+3wYijPaIJoBYeG2POlFM7UGrxtc0sSk+lVThQVVuUkmFvywgwBkIruc6v0BlPjep0NyYykPBsPAnKQcdXW/+Pr3M1/g4w7fkxJlMt8wGmHd7lM88IMdYFFoqHwcO6nOEP8kvF1FaKlErmacfsVhA6BV3vTwL4ISz57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=krdVDKVQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ead4093f85so5395153b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Apr 2024 15:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712096127; x=1712700927; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NmGJE5yni5aedzu78VrXe4FTebdM8Bb+r1t8IcP3yg0=;
        b=krdVDKVQGzZ8NkX9Mxvz47x2zViLuMIAft1ZXlzixPk/Js4Rmngkf/W8tg9txKbFRe
         VZTXnHiYPHOZf+9sWVyO6qWPQfU50z6kuZ2I5CVO+E1XkFHPvxr4Exm8fIzOrzcDwWby
         9fXowasDl1asG0tzH+XrGHR1Wc2b5eRguqom5OsAvOvEFs5YbzJtWhQh3NOWbWQ2gMex
         tfW0G8dbHElAmpn6UxnDyAftCymxSwf3XKx4KD3DnMWMzxTHF/GVa/nmnhbhxmyio7kQ
         BS1DqNaQajyjLN0AWgw+HmfedgUI7rTZRaubLD7AKNGDLYQAjJI9d+hoTXqX4HwGGy/N
         laog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712096127; x=1712700927;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmGJE5yni5aedzu78VrXe4FTebdM8Bb+r1t8IcP3yg0=;
        b=RzHkvNqbYL7xLcXaGQmY1BIva0nwaR2MA3Mhkg3wLys6Jjb9B9KUfOBDeUhi1KCAob
         TaVT5U/nYsM0b+VqA3QpVDXuGn28635lihKZpn6aoGHXDvN1z/KNwivB8dq8Vvv53mnm
         5p6F4gjjXGxq/w/iibNwghJv8rN52aM574AJp7zBgyX0QHN/aefZf0WFx74NghG2Jmk0
         RHpc5HWMhTRD1BjabBhnGXIXucS0Fd0sa/85TeatmkiHSGr2LcYrw6W9BKt3xxklexqy
         68QU8wApof1U6RA0/w0p81Bavn4Ixa+nKbKd2mOtm38lGxklhBYE19RZrVSSMUfXWbK1
         8Fsg==
X-Forwarded-Encrypted: i=1; AJvYcCWb1FGHRo1ZTkagcyVlcEjbVaOdhV30Q8c0dMOWw8qbCJ0qxc3hBSiSafNEQb2z8UfbzLq7T3SEK0+FG0W6ieh70PDnDHC+wyCZyfQWiqzR
X-Gm-Message-State: AOJu0YyF/4Fv4oXid1qz73Ef4O0x+Tbg2maVSX7h9IfwB79VW5vWGcQZ
	9SaJcBjjzXxdC30TybCx7K1st1VdXNc4PT1N/mDxlPyrL63PakPblrI4gD5CYzK/wmxEeJeGVHz
	a
X-Google-Smtp-Source: AGHT+IH6oEzjtw5mSm0h1HmKYf22zlMGeVERBvpKcYsEjUwyxTFtRjJqRcTXiU7SafBWN4uWU0nb4A==
X-Received: by 2002:a05:6a00:1403:b0:6e7:3223:4556 with SMTP id l3-20020a056a00140300b006e732234556mr12903453pfu.32.1712096126767;
        Tue, 02 Apr 2024 15:15:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00084a00b006ea9108ec12sm10290659pfk.115.2024.04.02.15.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 15:15:26 -0700 (PDT)
Message-ID: <660c837e.050a0220.8ba58.c801@mx.google.com>
Date: Tue, 02 Apr 2024 15:15:26 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc1-11-ge1e4db64728f8
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.9-rc1-11-ge1e4db64728f8)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.9-rc1-11-ge1e=
4db64728f8)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc1-11-ge1e4db64728f8/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc1-11-ge1e4db64728f8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      e1e4db64728f8f43c610ca723e443f6caebf19b4 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/660c750c088794ab4c4c42e1

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc1-11-ge1=
e4db64728f8/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc1-11-ge1=
e4db64728f8/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/660c750c088794ab4c4c42e3
        failing since 48 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32=
-g345e8abe4c355)

    2024-04-02T21:14:33.350409  / # =


    2024-04-02T21:14:33.359779  =


    2024-04-02T21:14:38.504480  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/13230997/extract-nfsrootfs-ap2ts0b8'

    2024-04-02T21:14:38.518602  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/13230997/extract-nfsrootfs-ap2ts0b8'

    2024-04-02T21:14:40.745765  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-02T21:14:40.756705  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-02T21:14:40.873847  / # #

    2024-04-02T21:14:40.882366  #

    2024-04-02T21:14:40.999740  / # export SHELL=3D/bin/bash

    2024-04-02T21:14:41.010110  export SHELL=3D/bin/bash
 =

    ... (147 line(s) more)  =

 =20

