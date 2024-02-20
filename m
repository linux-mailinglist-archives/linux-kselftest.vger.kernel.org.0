Return-Path: <linux-kselftest+bounces-5052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB7185C34B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 19:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D02288B28
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 18:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BA377652;
	Tue, 20 Feb 2024 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="iOuwZnAS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530678693
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452243; cv=none; b=Jf9TV8u5d0PZZoOyy7L5a8c4MaXsG2a6YLTZNQvSg+PgbGJpK08WgAT6prhJlUHrKc9LSS/19WPgsoB2sI0bmzPLDIL81y9wLLxNZ77XgBnHzPS+yYZvSJY9m5ABqLQzHn+uQrvlxV26d/DG+28M4AipQ5V48CqUvbxPpE9OWdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452243; c=relaxed/simple;
	bh=PX9sdLVf1rXPBzISoCdjtNQ4khXj7aBsRRAyc8FkIIQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=Wu77LKWGrassQGfuU3PCTPLJAUwiBX2ELQOuHJ2fWR36+XUaMLzeKvYEhMch+Ptt0MNKN4Am6FEFWhMNegTnSneun+MI36oJtyektmWZQFCM6BZg5pctJlwC9fRi9rHTERSsK3XEKl/T6crqXv4yhih9e3EZOLJdUIWYlc/dkt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=iOuwZnAS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc13fb0133so10133285ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 10:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708452241; x=1709057041; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w90P/QZLbiCy/jsC52hGRsfMg2uWyfTwVkXaUF96An8=;
        b=iOuwZnAS2UhZEpIwJT+WF0A1ZCs5YBRO+eIpAg3+gjl5NaionWfIG/9e4jmFR/3rLu
         PbfwAi9t1mu6ZX+jBGEO0M9SXWOztpwDLdESdZzN0By6VxlNmBJkx/7il8lbywQl0hOA
         ZH6fvCVz4ekQ8ULEMhmmCbHQl9NpX+2VBctd1jHPeKk+JtaPpavNbjXdPCVeK1mcixNB
         BUg1KvZRW4XdT21dz0MHehGjGGuHm3hTc+QB4DFt5yRPunxF95AeLcRZbtf8e3Tvm6o6
         MeCW1AWxhLUnwMT445EuI8i9EYE6vzHfJGOrHgZXDH36F00RsqHsOYHn9oGCXWst7clj
         Xjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708452241; x=1709057041;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w90P/QZLbiCy/jsC52hGRsfMg2uWyfTwVkXaUF96An8=;
        b=tPZOYoCE20WmeOR6EpfwIIkPUYk+NGRk1M+KvigSrvGR9cZB5Ub0Ve9rAyj50lCdCW
         GcO4M4IZPqkfif3HUPjBkvwM5HauvNmNgeEsGeIJ8JYZf/VC2fJu77mzijeuaoLvP4ZJ
         4OZs86e5HXMtqYWTPtslPangrD2lrRLIJlyhWHoVrH0Jv1TfC2cIj/YlA+8SwOcmhvC9
         Fg+vzGS+uAkDvi0GObN/CZEDku5Bq0T7I4iCguoSI/nBCLayCeW4nS46F90lFmgP+mdJ
         79G2pMDXWiALpFe00CTz+zyvhgi2+7yh97wupLOQSor6M4LF6OJtPBi7icN6cZ53XXTL
         knMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVYwHZlloelPh+dRl7r7ZSWUtcBPzcvdUR6bEPXWE7eLlzjfs4PLeehZOnooOSPJJT9xekvIjuT1hKtC1A4Gc4sVc/MA7lL7bgJI+c22g7
X-Gm-Message-State: AOJu0YwvbMLdPf3asAIcASfPc4Z7iIp9SR8+XDxaDaze9PN96YfyG1Mq
	4ZU1kU1/8bzJYlwMVjajp2wcZB7NKnz3pRMSWXq+DyOvMjGlTh2nPs28acegKbebmi+j869N3/p
	LX4U=
X-Google-Smtp-Source: AGHT+IFnQZBGzZn08PSEg/i/J6i4A8+yCVxKD4OkPzyuG2vnXpjWzF0mCHIT86njNJlDJxBrPW6GKA==
X-Received: by 2002:a17:903:98d:b0:1db:faa6:d4a9 with SMTP id mb13-20020a170903098d00b001dbfaa6d4a9mr7197752plb.69.1708452240489;
        Tue, 20 Feb 2024 10:04:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h22-20020a170902ac9600b001db5eb52911sm6547174plr.89.2024.02.20.10.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:04:00 -0800 (PST)
Message-ID: <65d4e990.170a0220.5aee2.3fc2@mx.google.com>
Date: Tue, 20 Feb 2024 10:04:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: kselftest
X-Kernelci-Branch: next
X-Kernelci-Kernel: v6.8-rc1-33-gf17d8a87ecb55
X-Kernelci-Report-Type: test
Subject: kselftest/next kselftest-lkdtm: 2 runs,
 1 regressions (v6.8-rc1-33-gf17d8a87ecb55)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/next kselftest-lkdtm: 2 runs, 1 regressions (v6.8-rc1-33-gf17d8a8=
7ecb55)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.8=
-rc1-33-gf17d8a87ecb55/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     kselftest
  Branch:   next
  Describe: v6.8-rc1-33-gf17d8a87ecb55
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      f17d8a87ecb557bc6c9770751c3f0aaf10edbb98 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig              =
      | regressions
----------------+------+---------------+----------+------------------------=
------+------------
imx6q-sabrelite | arm  | lab-collabora | gcc-10   | multi_v7_defconfig+ksel=
ftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d4e2122470917dbb637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//kselftest/next/v6.8-rc1-33-gf1=
7d8a87ecb55/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//kselftest/next/v6.8-rc1-33-gf1=
7d8a87ecb55/arm/multi_v7_defconfig+kselftest/gcc-10/lab-collabora/kselftest=
-lkdtm-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/armhf/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65d4e212247091=
7dbb637013
        failing since 447 days (last pass: v6.1-rc1-23-g00dd59519141, first=
 fail: v6.1-rc1-23-g8008d88e6d16) =

 =20

