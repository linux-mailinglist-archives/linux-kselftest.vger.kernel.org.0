Return-Path: <linux-kselftest+bounces-13625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4DC92F02E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 22:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810AD1F226B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 20:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550644CB23;
	Thu, 11 Jul 2024 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="1lC6g5rG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC42F3E
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720728942; cv=none; b=UOJU7wVMwAYQFZYuils7RI6VWE2gMwCAbdxQcHHeqhln9rSB8S/wJzlEZzeCTdHI5CFPw6XyZK4LOljx8XNfgu7RUMpyGUzu00TDTM7oXjjRpSmZZwGyXSynV75Qksq/s0/P29fFvT1ZIfWztfxpiFLimYt9LIb4l0fuBkpj0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720728942; c=relaxed/simple;
	bh=k6g9U8xPg6HqEUUjcY287ty5cgRB2mZT56j5TMUCPBE=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=RR3W5+geQ3A3djccvN7YxInmJdKqSJHtx4KnGZaOOKPOLBx/YsiDE6CIsPVCqF6Fdny+sorrNRecReo3N09TAS1lNNVp69MupPVxsMquYiG9Wwcoz/iSSFEHrz9+MYilB+A23kD/t4epZ6mGXneXYzeAfKQ3+bzIAZVZfa0Nifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=1lC6g5rG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70af3d9169bso1248642b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1720728940; x=1721333740; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5obdc0UWCx4w54bgbhwu6ZpiWRQLfmZtiJLsr/Ar/io=;
        b=1lC6g5rGJl2e/YGiBW7eobLtgKlJOaFTt6MSD6Ta5U69tveVfNV/T0SlXu5Skjl6ah
         sMloHTxSYUqnQmDVMdEn8G2QPC3qc9QCtbSj616o2c6ybjKfE5nvUxGuCSOYLbDUvuB8
         d2sJBGgt4qsOEIfnVWdbf9kxSgxBY+D9XGZ5LFNLkcScPP1IFzsuruavc8/cYKyhL72o
         BEbn8q1wgPE8mBpa/zQKF2ePkft3fx6CmDZzgvsTm1epzp4BhKmmzsjJKzrbcBB8QkuC
         sUXA2mVtSIi4gyuqJiGk5vojbg/avmPVWF+N+Jw4f4wulGRwIRPQqHwgrp3R2+Oc+B7p
         EjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720728940; x=1721333740;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5obdc0UWCx4w54bgbhwu6ZpiWRQLfmZtiJLsr/Ar/io=;
        b=cA4VZOaOiyN0H2pCi8Ldqbe+/CklsLJBWA45mQKIEoMpS0PGzspEgy9mmH2i0a63+S
         g5bbbxTvZT02NXzIRP0z6jh0y59kOXoZ+hfZsdIBQ0+3ec75NGd1Rle9ccMlnYLolh6h
         AQrOfQultzadAPWLUIQTbnJwiNG5jcqoZ9D4C5EuqnSoC4wJg1SwkbXE24TlN3qj44dV
         A1w/Up1aJEZ7hgdj1pMMmQv4UhWV8NvMw39p7+nkiOqMbVxUsFa/oNpuQ6dQPNglaikP
         urb8garAzCd0/Ishxl8XmSYsPrHrdfnkZ4nwsLe5oOv/AyDyigCtt8y1aq5/gjJH35rV
         7bjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV37erMHyRrxiYp6eOI/rvZ4S8Q0YnT1GO5h1+2yh3x+wAjcUE/SImy31mnsPEpBCJtLo5XY2cRle5swoLd8K8TPzr4k7pjIjNS3/fStlIw
X-Gm-Message-State: AOJu0Yy1k9/tboEZaXD/t32cApQsoQwWvov0Tvb954iwqf0mLYFShYxz
	CQ9lY/0CFFKrY7brGmSSAF/cccKQ7CJigtV5zxR8CeGf3Fg+XtUEYAYWtf45rOo=
X-Google-Smtp-Source: AGHT+IEcgToAIqd1NsXSDN/nx1zEZKVU/oHB9xgt1QHMFOIA6A0uXLWEqYVQ07xFULDSsC1I0URa0Q==
X-Received: by 2002:aa7:8896:0:b0:706:5bf1:586f with SMTP id d2e1a72fcca58-70b4335a002mr10709734b3a.0.1720728940000;
        Thu, 11 Jul 2024 13:15:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b1789sm6293407b3a.175.2024.07.11.13.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 13:15:39 -0700 (PDT)
Message-ID: <66903d6b.050a0220.76239.d858@mx.google.com>
Date: Thu, 11 Jul 2024 13:15:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc7-29-gdf09b0bb09ea
X-Kernelci-Report-Type: test
X-Kernelci-Branch: next
X-Kernelci-Tree: kselftest
Subject: kselftest/next kselftest-lkdtm: 5 runs,
 1 regressions (v6.10-rc7-29-gdf09b0bb09ea)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 5 runs, 1 regressions (v6.10-rc7-29-gdf09b0=
bb09ea)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-12   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.1=
0-rc7-29-gdf09b0bb09ea/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.10-rc7-29-gdf09b0bb09ea
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      df09b0bb09ea9775b66a5d24dc0fe0f86855efb5 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-12   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6690313f5c9846670b7e706f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-12 (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.10-rc7-29-gd=
f09b0bb09ea/arm64/defconfig+kselftest+arm64-chromebook/gcc-12/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.10-rc7-29-gd=
f09b0bb09ea/arm64/defconfig+kselftest+arm64-chromebook/gcc-12/lab-collabora=
/kselftest-lkdtm-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-ks=
elftest/20240313.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/6690313f5c9846=
670b7e7070
        new failure (last pass: v6.10-rc1-29-g2b2ea9f19da1) =

 =20

