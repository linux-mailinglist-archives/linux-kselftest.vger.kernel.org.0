Return-Path: <linux-kselftest+bounces-3414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D0183916D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 15:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91E3FB25DE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F407B21104;
	Tue, 23 Jan 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="iGZMwUO9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B542EEC2
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020363; cv=none; b=aT4lMpnu8y5AWNHgrmeR7c1DHmCVpD8UX6fZTV1ZBp9Yf8orHNFgaJZ0xzUz4dW0KSZDsIUD/fMdADZdcV08fkpZE2tIJavDTFo8wCxGzR6Mfv3Qng+DkysLCElYuDNh9Qrjbyf0H4DknqU55iocuk6gic28v9NWo+nWpoG9NZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020363; c=relaxed/simple;
	bh=f9qPmn9FTGGMGPRUvq7tlIu7N3x7FmXvzUCNEwOCdZw=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=QHrFJo3eP9XpcBSjNaQNHUCONCBSY53NuhIM3HpOurk1+J8dyZ7tJJSXCprlMwA8+jPc8KRW0fRWf17HjMe2AJG3OV9Q1aEZp2N+EbhOrBmdlSHVzYdbSedILbbGI4/8QtGdc8SXHgdcWnOD1uOXutOch2Q4/lu+h2yPKPYWn4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=iGZMwUO9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d70b0e521eso31608885ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 06:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706020362; x=1706625162; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gw/UngyNtq2hM9mp6hqYO8q85L9T2dZ9qdc2NjhCYqs=;
        b=iGZMwUO9LPNqctuSMUfgrOhj/bUm7Xmd9IlTT/3uKZc6MxGHwrsuiz+YS9K/qfIoPw
         DD/urLkW7AooI5eyvsIcaQB4K4dJtFTJbrevW+6a85xzddWerdHTkmAbgHOIiuLXjA9B
         KClFv3q1y5+umjwcVZ4RnW5b7rCd/FKmei8bN9uxqHj99zA3KLo6m1BRioBOCm/OTr+N
         PINxWwOnSDUuTRPTkzqjOgs6BW7y/oM6W4Cc2CMqYXR4x8FUZ0nvPK+kpjs618snNarI
         ycK/s90JDF1bdz55p5sf17Rgw5KbpT4vAa/QGeyTEyTkt0UupqJXpRPDWi2X/1AlmLwd
         ynzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706020362; x=1706625162;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gw/UngyNtq2hM9mp6hqYO8q85L9T2dZ9qdc2NjhCYqs=;
        b=goKIv2Z9G1+O+kKERTlQ5frMZg147Kf8a10BNRADC4Yz9gV4J1KebDiSRu5aNvH2CZ
         tSpwHXMVADwwnrnr6NKudqVXMTh8WBuzkkSfcT48D1RngLpIBJUXNXyorsxdfpVhGaQl
         /acKYKq8WWl5vhG2c45eo+CriA8A2nNF5JTQGGxw6nVWPB+d+eGpcwA6s3nc8qHYUfLR
         WZMVfjG/HBzLwkZgymflX2Lr8DD2w2YNGB7yDdkgNYhRq8MWy4Uz4eCCsOA0i015mz66
         r+Mpn+GedeH7f9bTCVnBPI1+SdthQv7euHnM1kYcLwVo9dYmhJo3Jf6WcZoNer6XjTsI
         ypoQ==
X-Gm-Message-State: AOJu0Yza8/lhyv+0RRlkqZP37NbgH/3K/DqaofM/WZsiuoQIhLO4YZrc
	n5u0KHz6iocvgonlzii+AkNn50U3gqg+/e6JjbW0DkDWiwjYHpFccMy2dxatZ4o=
X-Google-Smtp-Source: AGHT+IHY+jRg/0hXipAQaAVSHN2p1rSItvWXRIZWATHnOKjwDXn/IXavqa2MUJ0rdMQ2t5H2woLYAQ==
X-Received: by 2002:a17:902:db0c:b0:1d7:4377:e5ff with SMTP id m12-20020a170902db0c00b001d74377e5ffmr4798782plx.122.1706020361869;
        Tue, 23 Jan 2024 06:32:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902d64300b001d74031b250sm4448097plh.266.2024.01.23.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:32:40 -0800 (PST)
Message-ID: <65afce08.170a0220.a1756.d098@mx.google.com>
Date: Tue, 23 Jan 2024 06:32:40 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-3-g6c8c9d6e1bce2
X-Kernelci-Report-Type: test
Subject: kselftest/fixes kselftest-cpufreq: 4 runs,
 1 regressions (v6.8-rc1-3-g6c8c9d6e1bce2)
To: kernelci-results@groups.io, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
From: "kernelci.org bot" <bot@kernelci.org>

kselftest/fixes kselftest-cpufreq: 4 runs, 1 regressions (v6.8-rc1-3-g6c8c9=
d6e1bce2)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/kselftest/branch/fixes/kernel/v6.=
8-rc1-3-g6c8c9d6e1bce2/plan/kselftest-cpufreq/

  Test:     kselftest-cpufreq
  Tree:     kselftest
  Branch:   fixes
  Describe: v6.8-rc1-3-g6c8c9d6e1bce2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git
  SHA:      6c8c9d6e1bce2871df58a85d2c0c545007c34f5f =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
       | regressions
----------------+-------+---------------+----------+-----------------------=
-------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+kse...4-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65afbf206be134c24c52a3f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-cpufreq-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//kselftest/fixes/v6.8-rc1-3-g6c=
8c9d6e1bce2/arm64/defconfig+kselftest+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-cpufreq-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-cpufreq.login: https://kernelci.org/test/case/id/65afbf206be1=
34c24c52a3f4
        failing since 461 days (last pass: linux-kselftest-fixes-6.0-rc3, f=
irst fail: v6.1-rc1-5-gcb05c81ada76) =

 =20

