Return-Path: <linux-kselftest+bounces-7237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FB88992C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 03:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D159028621A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 01:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D779963D0;
	Fri,  5 Apr 2024 01:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UIMbdwlJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF59B64B
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712279858; cv=none; b=Mikb2IEtMiqviTJRoMlPIWeG3852MXQ5tb7EU9kP15h23MLvs0xeBWR6zMxS74dqxrLEthfQE/xZlyEMqPbVWAQ0HJagVGes1tnypePnC34Wwf/S3GgUtKopttuTHUBVnz35UEcahCtFcWQhFfuesjf59qTNcKtlieis1jHLUTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712279858; c=relaxed/simple;
	bh=glviQpa2ZOvtYhD3NEoNE+8SClvf88c93UW+15iB2pA=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Mos4U14R0UzrtlyhUzaidx8dT0eQSUQKTYIzTLh2T0IQhFWOU1ORA43u1V0XOlqdlvz6UtUPvnnbIsuE42txY80oAoPVbLQfp8WdfNtaejDqAdoJW+6AmzlMOpWbrLN4ZF3O/rvCvDONSV+zunJNCbKJpzMDKpUGtCho1VXHq30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=UIMbdwlJ; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3688ff3ca52so6446645ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 18:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1712279856; x=1712884656; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BBLg1O4+nMGqk3dAYNko7pXxp9J9yjiwqvK4uqy7I60=;
        b=UIMbdwlJoylGRQlCnP/Uo8p7Xd1njkwroZl6HIZ5AWikubEY5WGCbOp+KiyYbLg4KR
         Unhfrlg7621so92d/0ZwAHGDluiS4JfYxs6TJChJu/zW84kvsJbE1rklMcn2FV6EmFvL
         MZr71xcstzrTO9e6KhxG/VcbMxfvO/6C9wrj9NamJNH6IWN3myfhB6R492yDYrR58D4B
         nEUf38EqlK8rBfSIynfkelL3TE5PJwcmLldXHQ3lsAMfnwns1j1E/cmiyu2aOoN+MEkC
         tSVq4nI2Ha6o5Kxut8uQATuUzp+g7Crq7tUZBzU+Fpyr8G/XNxKB+Znj8dEcrU+q+A3f
         EVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712279856; x=1712884656;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBLg1O4+nMGqk3dAYNko7pXxp9J9yjiwqvK4uqy7I60=;
        b=TjroMB9UxDT9qifl82Ir2l93yLKBqZwLWlMr2cnD4b4Ji2F1YR08z82zl7uk9gprYf
         y0w6D1d/isl+Dj6xuUIPojJs9h5azvPZdjsjrMlbktGJJEgH1cZC/rKDvBr6ssfbUVVQ
         mfCHJpHlnLfU8MqSjTXdgNYxcRGunyWsIcXIMuknv0uEand4jhj3rH3jYC1hqCwL2X9S
         gjteHcDToUaE5n9fkKoLXPfQTkXdNvD+GHBGvcjNsMqQmyPSVrcHBwEhTAz1kp/WjK/r
         8FE4lBXHNpnyEeq83epvKaiLdfYsE4P3TdskxQ9o92HKjnkbIeD/j+WkL04q+Fj5C1LC
         LRrg==
X-Forwarded-Encrypted: i=1; AJvYcCWQZoW7V5odRWaM22dsd6QyDIEkTZZijlEqCg6Narsue8UvetppY7ToCfJUUcXZBv6hvzegCh0lEdHsaa0YR4uIlrH2xLjcicaHSulPQeYw
X-Gm-Message-State: AOJu0YyqxqlT6EktBsPOiveg8RDyknls9PJ7xIweteC+IjCnTLGE51Sc
	KF1y8No52BXW/ghs0mXcNmuoufYLTPEAybTrq+/sf4hkdKz1V/Rveg10owHSq+AlBHARmxZJfD1
	JDHs=
X-Google-Smtp-Source: AGHT+IEZqmis8GpgBrPBagYlqz3KzYaAly7f+z3WuIXh+5vZgSeGmH3Q68pGRAdkXSBI+GK62PWC3w==
X-Received: by 2002:a05:6e02:20e9:b0:369:f611:5efe with SMTP id q9-20020a056e0220e900b00369f6115efemr22677ilv.18.1712279856328;
        Thu, 04 Apr 2024 18:17:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j19-20020a63fc13000000b005e49bf50ff9sm314162pgi.0.2024.04.04.18.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 18:17:35 -0700 (PDT)
Message-ID: <660f512f.630a0220.c80c7.1838@mx.google.com>
Date: Thu, 04 Apr 2024 18:17:35 -0700 (PDT)
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
X-Kernelci-Kernel: v6.9-rc2-14-g4389636db356
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-livepatch: 1 runs,
 1 regressions (v6.9-rc2-14-g4389636db356)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-livepatch: 1 runs, 1 regressions (v6.9-rc2-14-g438=
9636db356)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.9=
-rc2-14-g4389636db356/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   next
  Describe: v6.9-rc2-14-g4389636db356
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      4389636db35667bb5d59422bfdfb3c876c3654c8 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/660f434734c73d34ab4c42f5

  Results:     1 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.9-rc2-14-g43=
89636db356/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.9-rc2-14-g43=
89636db356/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest-=
livepatch-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/armhf/initrd.cpio.gz =



  * kselftest-livepatch.shardfile-livepatch: https://kernelci.org/test/case=
/id/660f434734c73d34ab4c42f7
        failing since 50 days (last pass: v6.8-rc1, first fail: v6.8-rc1-32=
-g345e8abe4c355)

    2024-04-05T00:19:19.759836  / # =


    2024-04-05T00:19:19.770049  =


    2024-04-05T00:19:24.913020  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/13260754/extract-nfsrootfs-nupgh_u9'

    2024-04-05T00:19:24.927987  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/13260754/extract-nfsrootfs-nupgh_u9'

    2024-04-05T00:19:27.154877  / # export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-05T00:19:27.165763  export NFS_SERVER_IP=3D'192.168.201.1'

    2024-04-05T00:19:27.282570  / # #

    2024-04-05T00:19:27.291322  #

    2024-04-05T00:19:27.408815  / # export SHELL=3D/bin/bash

    2024-04-05T00:19:27.419090  export SHELL=3D/bin/bash
 =

    ... (115 line(s) more)  =

 =20

