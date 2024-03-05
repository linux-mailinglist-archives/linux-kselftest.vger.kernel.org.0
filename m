Return-Path: <linux-kselftest+bounces-5897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFA88718AC
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 09:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A57281EFF
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 08:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ACB4EB2E;
	Tue,  5 Mar 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="qXq70kdv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09F14EB31
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Mar 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628871; cv=none; b=XhHA+30rFhdXf98n++INeUG4kfVUHOhFDDIiA+FzuTXp4xIEvdPnqTEC+n22CF2BWpTp7OqapCrLHjNryX5I5fRooO2HA+ulIpshPoeNtArhbI3qG+E7QX/UuDEtwqlF9fuYOTqboiFCFfRn94DpoLrI8gfQomcsIvjSAIJgGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628871; c=relaxed/simple;
	bh=CyfboY5SvYIhCJu+rIdtEN/Er9X5FnUfODDWn8XEfWA=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=mf5hTVcWmnyTQ70HaKxzXBNuiEs4g702cXpDfdd+IaPjW2rJ7HfI4WT2mYgh1nkAO/kDV7UmyiKXln7L9tZSZQS+G3v1w5ph/tA1LhMt8ogaNOCNccliMnIWXN7hK6i0PCFd6HqC3dvMVqSKbE1+vaJkRm04QFyf6PUeFqpBQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=qXq70kdv; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso4647550a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Mar 2024 00:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709628869; x=1710233669; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hBocK4Ahd53+VtFH4R3AXm3RVkDUThoISySqORpXXjI=;
        b=qXq70kdv4y5CaYyp0MSJqFLPOvowJIz06GYNpIFOJPFZVpb7ikTeFIL+FozhOWa7kK
         +amn05jak2FGc0MZRlwgsPMoe9I2t4/jC053b5//sKAlxkDwSrivb5e+mep3hqaiwr/j
         jrB3xGIzvZDhi6/sM+1YLMNsc9QSKJXh+a5n0Z7dZ5I8FFBZcXQjx1ub7GrU2bDq6uge
         Hd8SO9Lgj1MZgKEnwXrnFcQ4lyRjrt72n/+mbqLwNj6BegnOkPyqzaKsNBKHeHSurUAh
         zsFWB1QhU3veWHgfmDlBUB2CSX2FZ7Mc0i7SznokwR5Ht12Sqj3ZG5hvOzp5JYfcHrvs
         /6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628869; x=1710233669;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBocK4Ahd53+VtFH4R3AXm3RVkDUThoISySqORpXXjI=;
        b=Q+DkMxcRSvxfmEpYmdP63URp6/0jVRP2YgwHXVWRQjOBAIRTEgAPz2PtcVgm5OYPqo
         sfresGv1GHvfDAUtzL1jc+6X30gctBgK4B6wFOGcCF8t8s/Y7P0D4NlHa68nitvev5Ne
         XDBbihHzHOzof+FAO3h3DSdHJ9P+Vgw2oO4JpJfAYa5jlVETn6Dw4PzZfsRD/3U8cIVz
         ejh3GRVEnNCxUQf4VSKahmDbOZ/pEzNOQtfdact9+poo++iIZRg/x8tBE3smVBDL8Adc
         y8cDvqrBTIz5zcz42HNCEQe9soe/at58DdhyAszVO5WqQqa5A+VY0gFEMlPNQFE13Wm+
         vpLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpyZl3cA9mTWavVELM9TjL80wrlbkovKsykIS/TVt8aYlvGw5SYUCiApLYy4LX3i1lXMGb6mh60aaszCr1te0LmwWqlZxOipqOreKG6Sp4
X-Gm-Message-State: AOJu0YzioZqro1A8/OaQ9lqc413mc3mCYi7dKA22bDR1WnC1odqX707k
	5sYs/f/O4sIkL/GD+T2xpkKx6oSl+GWZv2hrlVykwU2vKR1YQZsu36QfezJ4g5w=
X-Google-Smtp-Source: AGHT+IHUQ/i4uaqKWMU+j5jlObVifXz5tctSHEJEnSDlqZh1zZUowzufjSrum73WDR/Kn0Teb7KxIg==
X-Received: by 2002:a05:6a20:54a3:b0:1a1:4848:981e with SMTP id i35-20020a056a2054a300b001a14848981emr1433909pzk.14.1709628869342;
        Tue, 05 Mar 2024 00:54:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r5-20020aa79885000000b006e530aca55asm8488376pfl.123.2024.03.05.00.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:54:28 -0800 (PST)
Message-ID: <65e6ddc4.a70a0220.b73e0.215e@mx.google.com>
Date: Tue, 05 Mar 2024 00:54:28 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-57-g5d94da7ff00e
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.8-rc1-57-g5d94da7ff00e)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.8-rc1-57-g5d9=
4da7ff00e)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-57-g5d94da7ff00e/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-57-g5d94da7ff00e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      5d94da7ff00ef45737a64d947e7ff45aca972782 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65e6cdcbc6d2c9f73b4c42e9

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-57-g5d=
94da7ff00e/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/65e6cdcbc6d2c9f73b4c42eb
        failing since 20 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32=
-g345e8abe4c355)

    2024-03-05T07:45:44.826582  / # =


    2024-03-05T07:45:44.834815  =


    2024-03-05T07:45:49.986367  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/12943976/extract-nfsrootfs-9i1x1ntv'

    2024-03-05T07:45:49.997706  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/12943976/extract-nfsrootfs-9i1x1ntv'

    2024-03-05T07:45:52.243187  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-03-05T07:45:52.254179  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-03-05T07:45:52.369458  / # #

    2024-03-05T07:45:52.379584  #

    2024-03-05T07:45:52.529346  / # export SHELL=3D/bin/bash

    2024-03-05T07:45:52.539274  export SHELL=3D/bin/bash
 =

    ... (47 line(s) more)  =

 =20

