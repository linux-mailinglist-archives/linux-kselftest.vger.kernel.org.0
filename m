Return-Path: <linux-kselftest+bounces-3291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE23683594C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 03:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639F7280FE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 02:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065EC63C;
	Mon, 22 Jan 2024 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="jVeM8Lor"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEBBA48
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 02:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705889798; cv=none; b=BR2v7ihvdrDWXNS192BdB/wv0SqU3zid63yJ5meO2xaPNUhFrozj9FlqNE8FCT9NCIntq+ERAL9jvDa4W0/F1lIfcx/bXgbdY24yZb4Wf6NGlzFojixZv9BQEnPzQ+ktGADgDu410dJBCie2OOb8baYVv8Ni2B8DeaOdJqdr6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705889798; c=relaxed/simple;
	bh=FKpyvggEu2kJm4AzQdS+q5a8GzLKMi33RPGJQPKdGGc=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=FHQqOXRuKQqi82RQetJEVrR/lReCzWawoLB8VkwY/OWTZHlj1mR8Gfj38lKcmCcTsd9tyHACU1trUmE/Pj8ZT0bgp9ztuZMsFvBP/hzI+dVrQmpRx4q83jGy+gUwxk4tcrVfenK3CdkeDMbBXX+uPQr0kXL7+y6PpUHUR5oNO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=jVeM8Lor; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-598699c0f1eso1496146eaf.2
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Jan 2024 18:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705889796; x=1706494596; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CfEJPMpZrsj3R0edKEnmnHJqUjS5DN9YyXvIFJdQO5Y=;
        b=jVeM8LorUl2DLnocFEvzq9taPn7RbXg4QV+VkaDnU3WTz8/Rmo9UD4inLDK9dIMmze
         8L1B7AjM+7oLBUP5ehJTq1uNkxwCFbhzEEIs4HYgzHgRlhGaeu4MNCpEescezqXePKVD
         ANZ2fvcv+9jZnZgHRxr9MqweLycLWLzoqwxbCd359H5NK/kftSG+stW+fdZjV4ZAxFM0
         xypvabf5Ox8vz+tBPhoG+NuDgvJdBsbDgRxnOu+XIog+06GYWSk0XXdw2fIX9ce4Igbl
         h/BvIt0iWFyCFnWx3+r9gcLb3aEpmk0k8Q74BfsoEIy6DfSun/Kt8VifnGb3DLh9lnci
         st+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705889796; x=1706494596;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfEJPMpZrsj3R0edKEnmnHJqUjS5DN9YyXvIFJdQO5Y=;
        b=hCZLyrw2RwMR3m0ZTIUur+ktiUG079pMhCcJWaiBPIrwaE4YFM4pFTpBgFyTV9JZTd
         hfJl8+6QywvUcPqSeKfQukTUo55NnkAINA9bDG6oCk0iDJc23po8y50Rv+JzkmY2+q8q
         EWtPCaWizM8lWpipIOISFXB++Tfq18n3N02gBLuHgrFHmTUegh1LvZqTwJ1TitbISeI8
         jBS1QDZ68npzAzqjFfyAcTinnrYBr9mh8wBWWTXpgm3Z9W/MjiaN77ZxUvhfmuNrXDqp
         62ghrugHJB46YHqjPle7g/5F1RSjhR3zCDH2Qg6P3uDqG6IFAy2zxmyGxH3Ewrrkm4Id
         /lMg==
X-Gm-Message-State: AOJu0YyEJELLl8ME4o+9nFauprY8rO6vucuSQV69dFdQnpyOHocfWnPE
	6yinc2dMwZT3Tp1kFBSAhBhXBVx/3Hx2YpZ/UkO06OIVP7foy+aIlNUorgCKB+Q=
X-Google-Smtp-Source: AGHT+IF9fNbHbz+E6YCanUUdK77aD3ln9O0xgPxtzDuRew6swsAxINGsfwaEpNpLlGSKimLv922bxg==
X-Received: by 2002:a05:6358:60cb:b0:176:2f2:1c5a with SMTP id i11-20020a05635860cb00b0017602f21c5amr2758313rwi.30.1705889796583;
        Sun, 21 Jan 2024 18:16:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c15-20020a63724f000000b005ac384b71cbsm6959752pgn.60.2024.01.21.18.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 18:16:34 -0800 (PST)
Message-ID: <65add002.630a0220.30b25.77d5@mx.google.com>
Date: Sun, 21 Jan 2024 18:16:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: fixes
X-Kernelci-Tree: kselftest
X-Kernelci-Kernel: v6.8-rc1
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-livepatch: 2 runs, 1 regressions (v6.8-rc1)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-livepatch: 2 runs, 1 regressions (v6.8-rc1)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
8-rc1/plan/kselftest-livepatch/

  Test:     kselftest-livepatch
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.8-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6613476e225e090cc9aad49be7fa504e290dd33d =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65adc3530fad8dd25952a40c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-livepa=
tch-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1/arm64=
/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora/kselftest-livepa=
tch-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-livepatch.login: https://kernelci.org/test/case/id/65adc3530f=
ad8dd25952a40d
        failing since 459 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20

